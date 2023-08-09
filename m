Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3D775679
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHIJdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIJdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:33:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842E10D4
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 02:33:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 063132185F;
        Wed,  9 Aug 2023 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691573624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mj+K1aNZJ1uaFnsL24bOcXEwStC6A27y5q3AB//p7H8=;
        b=G9BMtRzZ2nbYvJkJii51EcoKrr1yZDN20yh1rOM8f8mJsIsS99Ibx4r4NWgCb/9+i39Q03
        hY8pdeZkbYXkv5vUHEnBgt67/shPbah9ovPykD+qYP+H5DyuefBvFVsaXJkqpSQhikML3w
        /gbJ7zQz9lFm27VwJv6Lu/YKZ1B9fUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691573624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mj+K1aNZJ1uaFnsL24bOcXEwStC6A27y5q3AB//p7H8=;
        b=i8D+rLkmodjqW86R3R0Q405lndRiUvr5KdGS/rc4GDr7Ty0DzhH2CLOX4M0WbxpBXsIQVM
        nYgF/6SEOBClpiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD517133B5;
        Wed,  9 Aug 2023 09:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x+6cNXdd02RqFAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Aug 2023 09:33:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 499A6A0769; Wed,  9 Aug 2023 11:33:43 +0200 (CEST)
Date:   Wed, 9 Aug 2023 11:33:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs 2/5] tmpfs: track free_ispace instead of
 free_inodes
Message-ID: <20230809093343.f72rf5zxwknljkjv@quack3>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <4fe1739-d9e7-8dfd-5bce-12e7339711da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe1739-d9e7-8dfd-5bce-12e7339711da@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-08-23 21:32:21, Hugh Dickins wrote:
> In preparation for assigning some inode space to extended attributes,
> keep track of free_ispace instead of number of free_inodes: as if one
> tmpfs inode (and accompanying dentry) occupies very approximately 1KiB.
> 
> Unsigned long is large enough for free_ispace, on 64-bit and on 32-bit:
> but take care to enforce the maximum.  And fix the nr_blocks maximum on
> 32-bit: S64_MAX would be too big for it there, so say LONG_MAX instead.
> 
> Delete the incorrect limited<->unlimited blocks/inodes comment above
> shmem_reconfigure(): leave it to the error messages below to describe.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/shmem_fs.h |  2 +-
>  mm/shmem.c               | 33 +++++++++++++++++----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 9b2d2faff1d0..6b0c626620f5 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -54,7 +54,7 @@ struct shmem_sb_info {
>  	unsigned long max_blocks;   /* How many blocks are allowed */
>  	struct percpu_counter used_blocks;  /* How many are allocated */
>  	unsigned long max_inodes;   /* How many inodes are allowed */
> -	unsigned long free_inodes;  /* How many are left for allocation */
> +	unsigned long free_ispace;  /* How much ispace left for allocation */
>  	raw_spinlock_t stat_lock;   /* Serialize shmem_sb_info changes */
>  	umode_t mode;		    /* Mount mode for root directory */
>  	unsigned char huge;	    /* Whether to try for hugepages */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index df3cabf54206..c39471384168 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -90,6 +90,9 @@ static struct vfsmount *shm_mnt;
>  /* Pretend that each entry is of this size in directory's i_size */
>  #define BOGO_DIRENT_SIZE 20
>  
> +/* Pretend that one inode + its dentry occupy this much memory */
> +#define BOGO_INODE_SIZE 1024
> +
>  /* Symlink up to this size is kmalloc'ed instead of using a swappable page */
>  #define SHORT_SYMLINK_LEN 128
>  
> @@ -137,7 +140,8 @@ static unsigned long shmem_default_max_inodes(void)
>  {
>  	unsigned long nr_pages = totalram_pages();
>  
> -	return min(nr_pages - totalhigh_pages(), nr_pages / 2);
> +	return min3(nr_pages - totalhigh_pages(), nr_pages / 2,
> +			ULONG_MAX / BOGO_INODE_SIZE);
>  }
>  #endif
>  
> @@ -331,11 +335,11 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
>  	if (!(sb->s_flags & SB_KERNMOUNT)) {
>  		raw_spin_lock(&sbinfo->stat_lock);
>  		if (sbinfo->max_inodes) {
> -			if (!sbinfo->free_inodes) {
> +			if (sbinfo->free_ispace < BOGO_INODE_SIZE) {
>  				raw_spin_unlock(&sbinfo->stat_lock);
>  				return -ENOSPC;
>  			}
> -			sbinfo->free_inodes--;
> +			sbinfo->free_ispace -= BOGO_INODE_SIZE;
>  		}
>  		if (inop) {
>  			ino = sbinfo->next_ino++;
> @@ -394,7 +398,7 @@ static void shmem_free_inode(struct super_block *sb)
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
>  	if (sbinfo->max_inodes) {
>  		raw_spin_lock(&sbinfo->stat_lock);
> -		sbinfo->free_inodes++;
> +		sbinfo->free_ispace += BOGO_INODE_SIZE;
>  		raw_spin_unlock(&sbinfo->stat_lock);
>  	}
>  }
> @@ -3155,7 +3159,7 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	}
>  	if (sbinfo->max_inodes) {
>  		buf->f_files = sbinfo->max_inodes;
> -		buf->f_ffree = sbinfo->free_inodes;
> +		buf->f_ffree = sbinfo->free_ispace / BOGO_INODE_SIZE;
>  	}
>  	/* else leave those fields 0 like simple_statfs */
>  
> @@ -3815,13 +3819,13 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  	case Opt_nr_blocks:
>  		ctx->blocks = memparse(param->string, &rest);
> -		if (*rest || ctx->blocks > S64_MAX)
> +		if (*rest || ctx->blocks > LONG_MAX)
>  			goto bad_value;
>  		ctx->seen |= SHMEM_SEEN_BLOCKS;
>  		break;
>  	case Opt_nr_inodes:
>  		ctx->inodes = memparse(param->string, &rest);
> -		if (*rest)
> +		if (*rest || ctx->inodes > ULONG_MAX / BOGO_INODE_SIZE)
>  			goto bad_value;
>  		ctx->seen |= SHMEM_SEEN_INODES;
>  		break;
> @@ -4002,21 +4006,17 @@ static int shmem_parse_options(struct fs_context *fc, void *data)
>  
>  /*
>   * Reconfigure a shmem filesystem.
> - *
> - * Note that we disallow change from limited->unlimited blocks/inodes while any
> - * are in use; but we must separately disallow unlimited->limited, because in
> - * that case we have no record of how much is already in use.
>   */
>  static int shmem_reconfigure(struct fs_context *fc)
>  {
>  	struct shmem_options *ctx = fc->fs_private;
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(fc->root->d_sb);
> -	unsigned long inodes;
> +	unsigned long used_isp;
>  	struct mempolicy *mpol = NULL;
>  	const char *err;
>  
>  	raw_spin_lock(&sbinfo->stat_lock);
> -	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
> +	used_isp = sbinfo->max_inodes * BOGO_INODE_SIZE - sbinfo->free_ispace;
>  
>  	if ((ctx->seen & SHMEM_SEEN_BLOCKS) && ctx->blocks) {
>  		if (!sbinfo->max_blocks) {
> @@ -4034,7 +4034,7 @@ static int shmem_reconfigure(struct fs_context *fc)
>  			err = "Cannot retroactively limit inodes";
>  			goto out;
>  		}
> -		if (ctx->inodes < inodes) {
> +		if (ctx->inodes * BOGO_INODE_SIZE < used_isp) {
>  			err = "Too few inodes for current use";
>  			goto out;
>  		}
> @@ -4080,7 +4080,7 @@ static int shmem_reconfigure(struct fs_context *fc)
>  		sbinfo->max_blocks  = ctx->blocks;
>  	if (ctx->seen & SHMEM_SEEN_INODES) {
>  		sbinfo->max_inodes  = ctx->inodes;
> -		sbinfo->free_inodes = ctx->inodes - inodes;
> +		sbinfo->free_ispace = ctx->inodes * BOGO_INODE_SIZE - used_isp;
>  	}
>  
>  	/*
> @@ -4211,7 +4211,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_flags |= SB_NOUSER;
>  #endif
>  	sbinfo->max_blocks = ctx->blocks;
> -	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
> +	sbinfo->max_inodes = ctx->inodes;
> +	sbinfo->free_ispace = sbinfo->max_inodes * BOGO_INODE_SIZE;
>  	if (sb->s_flags & SB_KERNMOUNT) {
>  		sbinfo->ino_batch = alloc_percpu(ino_t);
>  		if (!sbinfo->ino_batch)
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
