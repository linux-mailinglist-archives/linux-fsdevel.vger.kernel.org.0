Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E865259AAA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 04:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiHTCIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 22:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiHTCI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:08:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193501277D
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 19:08:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tl27so11853182ejc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=S5HX3yQxHZsdBOSDLucjhTh9DK0BKP1yB69LdNKCN/8=;
        b=IOUC4tPa0CY67LIUu8g6TGtR9bQztFvfU4xeiSNigSjCUoNvxd/6dDt2OOgJGxcv2u
         JCQT8Tb8zcwpQBi//KAmiyDw0NaCD84pV+ctbfwnIhq/q02WthnVysWs9elgPBqdQO3Z
         HLu3zlr6yqWxDbCB62BXm7HDtbClrirP3O+K35ItwLSzRRVZHQRikiD6Mfm6IBDhx/Tf
         Ir9hGOLcOf4ss0d7ncuUuDf2HVNjZN3y64s6VM0+HiC6+3YW0J90GpGZ2bkc9sV/sVi2
         p6j7zXVzWDUEUuZ1oJIzzM+L5wC8jE1dOeE8kJA0lWzK2ty2Gb8w5ur4hOVibOnRIxzi
         PkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=S5HX3yQxHZsdBOSDLucjhTh9DK0BKP1yB69LdNKCN/8=;
        b=G+PD7PgssbObfBEVlRrSSDy9jRis5iX9e41S/ODolQGqjoE70YOMjKG2P1kJH1HfBU
         Hbn+5du7sb3AtzHT8FPXFqPtGe2I1EVnnF08JfO+o489kjaiO9YHv26sMDoqjZoiYg83
         /RiuDFubrU8qN/SOEIzbcFOuIg0is9QrqHjZv/6WZRrcLTS30MgAPcVbsY18JXMcD7xQ
         4YpOMvctAlBF9L7OO6crMN2AcdVTkGFTlMHEx9l8AwGWAFLZofNoQdFv5fx/n9DNjcKU
         qOROPgz7eZLwD7U7guvytb2TWlBofx0jIEMjI2Pufg06XyJ2vlec1bc7TXWgnd/RceEp
         hsbw==
X-Gm-Message-State: ACgBeo29P3XY63tlENOscqxJY1h8dgrKLMcbe7dsAlsUlQ0f0OJqiX/N
        LiyB6n8xbjc1t9EvOxmkx5U5+70X2kA=
X-Google-Smtp-Source: AA6agR5d4eTzJdLWWCiu455rus1vo4fBpTkfAGLlz0WFRgspFqMvdB4VlwTZWyV5ZCjlQbQ+Xcyl4A==
X-Received: by 2002:a17:906:9749:b0:730:c005:5d59 with SMTP id o9-20020a170906974900b00730c0055d59mr6459790ejy.419.1660961303489;
        Fri, 19 Aug 2022 19:08:23 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm3011448ejd.101.2022.08.19.19.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 19:08:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] f2fs: use memcpy_{to,from}_page() where possible
Date:   Sat, 20 Aug 2022 04:08:19 +0200
Message-ID: <4750218.GXAFRqVoOG@opensuse>
In-Reply-To: <20220819223300.9128-1-ebiggers@kernel.org>
References: <20220819223300.9128-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On sabato 20 agosto 2022 00:33:00 CEST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This is simpler, and as a side effect it replaces several uses of
> kmap_atomic() with its recommended replacement kmap_local_page().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: remove unneeded calls to flush_dcache_page(),
>     and convert the kmap_atomic() in f2fs_write_inline_data().
> 
>  fs/f2fs/inline.c | 15 ++++-----------
>  fs/f2fs/super.c  | 11 ++---------
>  fs/f2fs/verity.c | 10 ++--------
>  3 files changed, 8 insertions(+), 28 deletions(-)

It looks good to me...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio

> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index bf46a7dfbea2fc..73da9331803696 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -64,7 +64,6 @@ bool f2fs_may_inline_dentry(struct inode *inode)
>  void f2fs_do_read_inline_data(struct page *page, struct page *ipage)
>  {
>  	struct inode *inode = page->mapping->host;
> -	void *src_addr, *dst_addr;
> 
>  	if (PageUptodate(page))
>  		return;
> @@ -74,11 +73,8 @@ void f2fs_do_read_inline_data(struct page *page, struct
> page *ipage) zero_user_segment(page, MAX_INLINE_DATA(inode), PAGE_SIZE);
> 
>  	/* Copy the whole inline data block */
> -	src_addr = inline_data_addr(inode, ipage);
> -	dst_addr = kmap_atomic(page);
> -	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
> -	flush_dcache_page(page);
> -	kunmap_atomic(dst_addr);
> +	memcpy_to_page(page, 0, inline_data_addr(inode, ipage),
> +		       MAX_INLINE_DATA(inode));
>  	if (!PageUptodate(page))
>  		SetPageUptodate(page);
>  }
> @@ -246,7 +242,6 @@ int f2fs_convert_inline_inode(struct inode *inode)
> 
>  int f2fs_write_inline_data(struct inode *inode, struct page *page)
>  {
> -	void *src_addr, *dst_addr;
>  	struct dnode_of_data dn;
>  	int err;
> 
> @@ -263,10 +258,8 @@ int f2fs_write_inline_data(struct inode *inode, struct
> page *page) f2fs_bug_on(F2FS_I_SB(inode), page->index);
> 
>  	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true, true);
> -	src_addr = kmap_atomic(page);
> -	dst_addr = inline_data_addr(inode, dn.inode_page);
> -	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
> -	kunmap_atomic(src_addr);
> +	memcpy_from_page(inline_data_addr(inode, dn.inode_page),
> +			 page, 0, MAX_INLINE_DATA(inode));
>  	set_page_dirty(dn.inode_page);
> 
>  	f2fs_clear_page_cache_dirty_tag(page);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2451623c05a7a8..3e5743b2538240 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2465,7 +2465,6 @@ static ssize_t f2fs_quota_read(struct super_block *sb,
> int type, char *data, size_t toread;
>  	loff_t i_size = i_size_read(inode);
>  	struct page *page;
> -	char *kaddr;
> 
>  	if (off > i_size)
>  		return 0;
> @@ -2498,9 +2497,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb,
> int type, char *data, return -EIO;
>  		}
> 
> -		kaddr = kmap_atomic(page);
> -		memcpy(data, kaddr + offset, tocopy);
> -		kunmap_atomic(kaddr);
> +		memcpy_from_page(data, page, offset, tocopy);
>  		f2fs_put_page(page, 1);
> 
>  		offset = 0;
> @@ -2522,7 +2519,6 @@ static ssize_t f2fs_quota_write(struct super_block 
*sb,
> int type, size_t towrite = len;
>  	struct page *page;
>  	void *fsdata = NULL;
> -	char *kaddr;
>  	int err = 0;
>  	int tocopy;
> 
> @@ -2541,10 +2537,7 @@ static ssize_t f2fs_quota_write(struct super_block 
*sb,
> int type, break;
>  		}
> 
> -		kaddr = kmap_atomic(page);
> -		memcpy(kaddr + offset, data, tocopy);
> -		kunmap_atomic(kaddr);
> -		flush_dcache_page(page);
> +		memcpy_to_page(page, offset, data, tocopy);
> 
>  		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
>  						page, fsdata);
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index 7b8f2b41c29b12..97ec60f39d6960 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -47,16 +47,13 @@ static int pagecache_read(struct inode *inode, void 
*buf,
> size_t count, size_t n = min_t(size_t, count,
>  				 PAGE_SIZE - offset_in_page(pos));
>  		struct page *page;
> -		void *addr;
> 
>  		page = read_mapping_page(inode->i_mapping, pos >> 
PAGE_SHIFT,
>  					 NULL);
>  		if (IS_ERR(page))
>  			return PTR_ERR(page);
> 
> -		addr = kmap_atomic(page);
> -		memcpy(buf, addr + offset_in_page(pos), n);
> -		kunmap_atomic(addr);
> +		memcpy_from_page(buf, page, offset_in_page(pos), n);
> 
>  		put_page(page);
> 
> @@ -85,16 +82,13 @@ static int pagecache_write(struct inode *inode, const 
void
> *buf, size_t count, PAGE_SIZE - offset_in_page(pos));
>  		struct page *page;
>  		void *fsdata;
> -		void *addr;
>  		int res;
> 
>  		res = aops->write_begin(NULL, mapping, pos, n, &page, 
&fsdata);
>  		if (res)
>  			return res;
> 
> -		addr = kmap_atomic(page);
> -		memcpy(addr + offset_in_page(pos), buf, n);
> -		kunmap_atomic(addr);
> +		memcpy_to_page(page, offset_in_page(pos), buf, n);
> 
>  		res = aops->write_end(NULL, mapping, pos, n, n, page, 
fsdata);
>  		if (res < 0)
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> --
> 2.37.1




