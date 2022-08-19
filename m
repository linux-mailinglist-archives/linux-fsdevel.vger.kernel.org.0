Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E4A599AA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348687AbiHSLMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348620AbiHSLMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:12:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEF4FF231
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 04:11:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so5245152edd.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 04:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cgcveKfalu9bGwjWhdphSsPeVH0HyR/9XPCDpoeXKuw=;
        b=p6SchWPgQxCXLwQjgG57ICVW6yFu7NROZezkyPjTiirjSBTVDVoYBv+20hH+i2uF8L
         tFVkfOHHdO+Z9Vq2IeDZYPABFyvcaOVMaN3aRDXfhpqkLdR4ljyQkUlXKYQnFX/aWi0Q
         6s/uFmtViCK34glr7OStVo7q3mBZuRYSY0FGcOdLN5LkQoej2oBrK7mF7VXWYLOd42NY
         CanKFXuxo2g/+n7MMKStZ9VytQnbeuBBlo5HQ6aS8qeCnMYtUs6Roq81wyDkrWqN/uko
         dr5F/4kvk5ImzLAvmkVI3t70QOq+eqO29E6DyNga0s1cmVfzfRr8yiGJwdO347XV2Frh
         B7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cgcveKfalu9bGwjWhdphSsPeVH0HyR/9XPCDpoeXKuw=;
        b=b0mNvLORiw596fqYBhVwi8CPoWXNlZWF6XBoxtct1nHQ+wgHQL6/EMhncI0//KsyYN
         QoAmxWTcXwM6X5PAnqOuk9bzZm3Ku4EAZfwACzlON6Zxgydk+fMPjiLzQGCGGg9fivJM
         UareEtpmfz28EXK0tsj29xkc/VWVUrwfoDNstEoM7DYKT6323N4GwUal1Pg53UlUeKtH
         zaMMgtVlnNsS/Ylo/LtvokN6VE6Veo8xkAvlHzxkvFcztmkxHCE/YK4GUfggv15QZum1
         2fEiwxb3tGDCLIGynIOhUtdJNfbXtj+Z0vwibGH7qqAIMlmKPAhhTM5nT2vg1i4fExCF
         XUJw==
X-Gm-Message-State: ACgBeo0H6odszoxk4yQIdtq9irRgdhZ8NRa7fL/3OXXX9bC9j1psYul+
        wAUNh8/YctWHLqCK+OC0nhx6A6nwS04=
X-Google-Smtp-Source: AA6agR6sqNw8K9BDAGKYodlVIVE4ZcURxhL1wDas7RWlI/VD+3/1wZh2ScK1Q0lFI4JUQqOdJThosA==
X-Received: by 2002:aa7:cc97:0:b0:445:afab:2634 with SMTP id p23-20020aa7cc97000000b00445afab2634mr5852947edt.54.1660907505893;
        Fri, 19 Aug 2022 04:11:45 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id r5-20020a056402018500b00445f8e0a86esm2869497edv.75.2022.08.19.04.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:11:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] f2fs: use memcpy_{to,from}_page() where possible
Date:   Fri, 19 Aug 2022 13:11:41 +0200
Message-ID: <4743896.GXAFRqVoOG@localhost.localdomain>
In-Reply-To: <20220818225450.84090-1-ebiggers@kernel.org>
References: <20220818225450.84090-1-ebiggers@kernel.org>
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

On Friday, August 19, 2022 12:54:50 AM CEST Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This is simpler, and as a side effect it replaces several uses of
> kmap_atomic() with its recommended replacement kmap_local_page().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/f2fs/inline.c |  7 ++-----
>  fs/f2fs/super.c  | 10 ++--------
>  fs/f2fs/verity.c | 10 ++--------
>  3 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index bf46a7dfbea2fc..69bfd3b08645af 100644
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
> @@ -74,11 +73,9 @@ void f2fs_do_read_inline_data(struct page *page, struct 
page *ipage)
>  	zero_user_segment(page, MAX_INLINE_DATA(inode), PAGE_SIZE);
>  
>  	/* Copy the whole inline data block */
> -	src_addr = inline_data_addr(inode, ipage);
> -	dst_addr = kmap_atomic(page);
> -	memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
> +	memcpy_to_page(page, 0, inline_data_addr(inode, ipage),
> +		       MAX_INLINE_DATA(inode));
>  	flush_dcache_page(page);

flush_dcache_page() is redundant here. memcpy_to_page() takes care to call it.

> -	kunmap_atomic(dst_addr);
>  	if (!PageUptodate(page))
>  		SetPageUptodate(page);
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2451623c05a7a8..c9f9269a4e88f3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2465,7 +2465,6 @@ static ssize_t f2fs_quota_read(struct super_block *sb, 
int type, char *data,
>  	size_t toread;
>  	loff_t i_size = i_size_read(inode);
>  	struct page *page;
> -	char *kaddr;
>  
>  	if (off > i_size)
>  		return 0;
> @@ -2498,9 +2497,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, 
int type, char *data,
>  			return -EIO;
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
*sb, int type,
>  	size_t towrite = len;
>  	struct page *page;
>  	void *fsdata = NULL;
> -	char *kaddr;
>  	int err = 0;
>  	int tocopy;
>  
> @@ -2541,9 +2537,7 @@ static ssize_t f2fs_quota_write(struct super_block 
*sb, int type,
>  			break;
>  		}
>  
> -		kaddr = kmap_atomic(page);
> -		memcpy(kaddr + offset, data, tocopy);
> -		kunmap_atomic(kaddr);
> +		memcpy_to_page(page, offset, data, tocopy);
>  		flush_dcache_page(page);

Same here.

>  
>  		a_ops->write_end(NULL, mapping, off, tocopy, tocopy,
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index 7b8f2b41c29b12..97ec60f39d6960 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -47,16 +47,13 @@ static int pagecache_read(struct inode *inode, void 
*buf, size_t count,
>  		size_t n = min_t(size_t, count,
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
void *buf, size_t count,
>  				 PAGE_SIZE - offset_in_page(pos));
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
> 
> 

It looks like you forgot a conversion from kmap_atomic() in fs/f2fs/inline.c 
at line 266.

The rest looks good to me.

Thanks,

Fabio


