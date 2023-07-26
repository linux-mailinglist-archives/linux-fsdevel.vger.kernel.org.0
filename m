Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B2763623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjGZMU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjGZMUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:20:25 -0400
X-Greylist: delayed 959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 05:20:23 PDT
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DCEDD;
        Wed, 26 Jul 2023 05:20:23 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qOcvJ-0008TQ-56; Wed, 26 Jul 2023 13:43:21 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qOcvI-0007BY-KW; Wed, 26 Jul 2023 13:43:20 +0200
Message-ID: <ae356339-6fb1-d098-21c9-ca88e7a3bf4f@uls.co.za>
Date:   Wed, 26 Jul 2023 13:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
Content-Language: en-GB
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <20230726105953.843-1-jaco@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Just to give some context, we've got maildir folders running on top of 
glusterfs.  Without this a "medium" sized folder can take several 
minutes to go through readdir (getdents64) and each system call will 
return 14-18 entries at a time.  These calls (as measures using strace 
-T -p) takes anywhere from around 150 micro-seconds to several 
milli-seconds.  Inter-server round-trip time (as measured with ping) is 
generally 100-120 micro-seconds so 150 µs is probably a good lower limit.

I've tested the below patch from a more remote location (7-8ms ping 
round-trip) and in spite of this massively increased latency a readdir 
iteration over a small folder (a few hundred entries) was still on par 
with the local case, usually even marginally better (10%), where on 
larger folders the difference became much more pronounced, with 
performance for the remote location at times being drastically better 
than for the "close" location.

This has a few benefits overall that I see:

1.  This enables glusterfs to internally read and process larger 
chunks.  Whether this is happening I don't know (I have a separate 
ongoing discussion with the developers on that side to see what can be 
done inside of glusterfs itself to improve the mechanisms on the other 
side of fuse).

2.  Fewer overall system calls (by an order of up to 32 fewer 
getdents64()) calls for userspace to get a full directory listing, in 
cases where there's 100k+ files in a folder this makes a HUGE difference 
(14-18 entries vs ~500 entries per call, so >5000 calls vs 200).

3.  Fewer fuse messages being passed over the fuse link.

One concerns I have is that I don't understand all of the caching and 
stuff going on, and I'm typically as per strace seeing less than 64KB of 
data being returned to userspace, so I'm not sure there is a direct 
correlation between the FUSE readdir size and that from glibc to kernel, 
and I'm slightly worried that the caching may now be broken due to 
smaller than READDIR_PAGES_SIZE records being cached, with that said, 
successive readdir() iterations from userspace provided identical 
results so I *think* this should be OK.  Someone with a better 
understanding should please confirm.

I made the option configurable (but max it out by default) in case 
memory constrained systems may need to drop the 128KiB value.

I suspect the discrepancy may also relate to the way in which glusterfs 
merges directory listings from the underlying bricks where data is 
actually stored.

Without this patch the remote system is orders of magnitude slower that 
the close together systems.

Kind regards,
Jaco


On 2023/07/26 12:59, Jaco Kroon wrote:
> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
> ---
>   fs/fuse/Kconfig   | 16 ++++++++++++++++
>   fs/fuse/readdir.c | 42 ++++++++++++++++++++++++------------------
>   2 files changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 038ed0b9aaa5..0783f9ee5cd3 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -18,6 +18,22 @@ config FUSE_FS
>   	  If you want to develop a userspace FS, or if you want to use
>   	  a filesystem based on FUSE, answer Y or M.
>   
> +config FUSE_READDIR_ORDER
> +	int
> +	range 0 5
> +	default 5
> +	help
> +		readdir performance varies greatly depending on the size of the read.
> +		Larger buffers results in larger reads, thus fewer reads and higher
> +		performance in return.
> +
> +		You may want to reduce this value on seriously constrained memory
> +		systems where 128KiB (assuming 4KiB pages) cache pages is not ideal.
> +
> +		This value reprents the order of the number of pages to allocate (ie,
> +		the shift value).  A value of 0 is thus 1 page (4KiB) where 5 is 32
> +		pages (128KiB).
> +
>   config CUSE
>   	tristate "Character device in Userspace support"
>   	depends on FUSE_FS
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index dc603479b30e..98c62b623240 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -13,6 +13,12 @@
>   #include <linux/pagemap.h>
>   #include <linux/highmem.h>
>   
> +#define READDIR_PAGES_ORDER		CONFIG_FUSE_READDIR_ORDER
> +#define READDIR_PAGES			(1 << READDIR_PAGES_ORDER)
> +#define READDIR_PAGES_SIZE		(PAGE_SIZE << READDIR_PAGES_ORDER)
> +#define READDIR_PAGES_MASK		(READDIR_PAGES_SIZE - 1)
> +#define READDIR_PAGES_SHIFT		(PAGE_SHIFT + READDIR_PAGES_ORDER)
> +
>   static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
>   {
>   	struct fuse_conn *fc = get_fuse_conn(dir);
> @@ -52,10 +58,10 @@ static void fuse_add_dirent_to_cache(struct file *file,
>   	}
>   	version = fi->rdc.version;
>   	size = fi->rdc.size;
> -	offset = size & ~PAGE_MASK;
> -	index = size >> PAGE_SHIFT;
> +	offset = size & ~READDIR_PAGES_MASK;
> +	index = size >> READDIR_PAGES_SHIFT;
>   	/* Dirent doesn't fit in current page?  Jump to next page. */
> -	if (offset + reclen > PAGE_SIZE) {
> +	if (offset + reclen > READDIR_PAGES_SIZE) {
>   		index++;
>   		offset = 0;
>   	}
> @@ -83,7 +89,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
>   	}
>   	memcpy(addr + offset, dirent, reclen);
>   	kunmap_local(addr);
> -	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
> +	fi->rdc.size = (index << READDIR_PAGES_SHIFT) + offset + reclen;
>   	fi->rdc.pos = dirent->off;
>   unlock:
>   	spin_unlock(&fi->rdc.lock);
> @@ -104,7 +110,7 @@ static void fuse_readdir_cache_end(struct file *file, loff_t pos)
>   	}
>   
>   	fi->rdc.cached = true;
> -	end = ALIGN(fi->rdc.size, PAGE_SIZE);
> +	end = ALIGN(fi->rdc.size, READDIR_PAGES_SIZE);
>   	spin_unlock(&fi->rdc.lock);
>   
>   	/* truncate unused tail of cache */
> @@ -328,25 +334,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>   	struct fuse_mount *fm = get_fuse_mount(inode);
>   	struct fuse_io_args ia = {};
>   	struct fuse_args_pages *ap = &ia.ap;
> -	struct fuse_page_desc desc = { .length = PAGE_SIZE };
> +	struct fuse_page_desc desc = { .length = READDIR_PAGES_SIZE };
>   	u64 attr_version = 0;
>   	bool locked;
>   
> -	page = alloc_page(GFP_KERNEL);
> +	page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);
>   	if (!page)
>   		return -ENOMEM;
>   
>   	plus = fuse_use_readdirplus(inode, ctx);
>   	ap->args.out_pages = true;
> -	ap->num_pages = 1;
> +	ap->num_pages = READDIR_PAGES;
>   	ap->pages = &page;
>   	ap->descs = &desc;
>   	if (plus) {
>   		attr_version = fuse_get_attr_version(fm->fc);
> -		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
> +		fuse_read_args_fill(&ia, file, ctx->pos, READDIR_PAGES_SIZE,
>   				    FUSE_READDIRPLUS);
>   	} else {
> -		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
> +		fuse_read_args_fill(&ia, file, ctx->pos, READDIR_PAGES_SIZE,
>   				    FUSE_READDIR);
>   	}
>   	locked = fuse_lock_inode(inode);
> @@ -383,7 +389,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
>   					       void *addr, unsigned int size,
>   					       struct dir_context *ctx)
>   {
> -	unsigned int offset = ff->readdir.cache_off & ~PAGE_MASK;
> +	unsigned int offset = ff->readdir.cache_off & ~READDIR_PAGES_MASK;
>   	enum fuse_parse_result res = FOUND_NONE;
>   
>   	WARN_ON(offset >= size);
> @@ -504,16 +510,16 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
>   
>   	WARN_ON(fi->rdc.size < ff->readdir.cache_off);
>   
> -	index = ff->readdir.cache_off >> PAGE_SHIFT;
> +	index = ff->readdir.cache_off >> READDIR_PAGES_SHIFT;
>   
> -	if (index == (fi->rdc.size >> PAGE_SHIFT))
> -		size = fi->rdc.size & ~PAGE_MASK;
> +	if (index == (fi->rdc.size >> READDIR_PAGES_SHIFT))
> +		size = fi->rdc.size & ~READDIR_PAGES_MASK;
>   	else
> -		size = PAGE_SIZE;
> +		size = READDIR_PAGES_SIZE;
>   	spin_unlock(&fi->rdc.lock);
>   
>   	/* EOF? */
> -	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
> +	if ((ff->readdir.cache_off & ~READDIR_PAGES_MASK) == size)
>   		return 0;
>   
>   	page = find_get_page_flags(file->f_mapping, index,
> @@ -559,9 +565,9 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
>   	if (res == FOUND_ALL)
>   		return 0;
>   
> -	if (size == PAGE_SIZE) {
> +	if (size == READDIR_PAGES_SIZE) {
>   		/* We hit end of page: skip to next page. */
> -		ff->readdir.cache_off = ALIGN(ff->readdir.cache_off, PAGE_SIZE);
> +		ff->readdir.cache_off = ALIGN(ff->readdir.cache_off, READDIR_PAGES_SIZE);
>   		goto retry;
>   	}
>   
