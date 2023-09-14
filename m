Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4491179FFCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 11:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjINJQc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjINJQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:16:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B00CC7;
        Thu, 14 Sep 2023 02:16:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 672282166E;
        Thu, 14 Sep 2023 09:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694682986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpjtNvUjjQusRNUj0tIKdk02fToavFL2ATfFZFhnb+M=;
        b=rVOldaMrXHOc7XM8bFe5rk3iW42vp+2z0Is/MLLbAkg4J1kcDYZyHmvg8ry5nfDgn/bvGb
        IoLa7K/BaL6lXlsnUNRKAbQHomgA5ouVpRSbOSC8lTZfdO+WFSU5o6ie4vAd79ElrVLUN6
        j2iL0BTrKDN2184h6zysluh02IINwDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694682986;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpjtNvUjjQusRNUj0tIKdk02fToavFL2ATfFZFhnb+M=;
        b=0GQ2LKfxlmSz+OK8/vCmOgz+/Gf1zqRavKNZSEFWDXc5ApZYygqGK42x0e2GSDp2CucA3U
        +UyRwBKVhHUUQ0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5524D139DB;
        Thu, 14 Sep 2023 09:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ddyoFGrPAmVpRgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 14 Sep 2023 09:16:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D5020A07C2; Thu, 14 Sep 2023 11:16:25 +0200 (CEST)
Date:   Thu, 14 Sep 2023 11:16:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, Hui Zhu <teawater@antgroup.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer: Hoist GFP flags from grow_dev_page() to
 __getblk_gfp()
Message-ID: <20230914091625.hjbmlanqc6sxonwi@quack3>
References: <20230811161528.506437-1-willy@infradead.org>
 <20230811161528.506437-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811161528.506437-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-08-23 17:15:27, Matthew Wilcox (Oracle) wrote:
> grow_dev_page() is only called by grow_buffers().  grow_buffers()
> is only called by __getblk_slow() and __getblk_slow() is only called
> from __getblk_gfp(), so it is safe to move the GFP flags setting
> all the way up.  With that done, add a new bdev_getblk() entry point
> that leaves the GFP flags the way the caller specified them.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Can't we just finish this gfp parameter conversion for all the users?
There are five __getblk_gfp() users, three in buffer_head.h directly
generate gfp mask, two (__bread_gfp() and sb_getblk_gfp()) pass it from the
caller. All three __bread_gfp() callers are in buffer_head.h and directly
generate gfp mask. sb_getblk_gfp() has five callers, all in ext4 and easily
convertable as well.

This results not only in cleaner code but also just checking
sb_getblk_gfp() callers shows how confused they currently are about the gfp
argument (passing NOFS, NOFAIL and other pointless flags). Secondly, we can
keep using sb_getblk_gfp() from the filesystems instead of having to decide
between sb_getblk_gfp() and bdev_getblk().

If you don't have time for this, I guess I can find some...

								Honza

> ---
>  fs/buffer.c                 | 60 ++++++++++++++++++++++++-------------
>  include/linux/buffer_head.h |  2 ++
>  2 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 7326acc29541..122b7d16befb 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1048,20 +1048,11 @@ grow_dev_page(struct block_device *bdev, sector_t block,
>  	struct buffer_head *bh;
>  	sector_t end_block;
>  	int ret = 0;
> -	gfp_t gfp_mask;
> -
> -	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
> -
> -	/*
> -	 * XXX: __getblk_slow() can not really deal with failure and
> -	 * will endlessly loop on improvised global reclaim.  Prefer
> -	 * looping in the allocator rather than here, at least that
> -	 * code knows what it's doing.
> -	 */
> -	gfp_mask |= __GFP_NOFAIL;
>  
>  	folio = __filemap_get_folio(inode->i_mapping, index,
> -			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
> +			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
>  
>  	bh = folio_buffers(folio);
>  	if (bh) {
> @@ -1074,7 +1065,9 @@ grow_dev_page(struct block_device *bdev, sector_t block,
>  			goto failed;
>  	}
>  
> -	bh = folio_alloc_buffers(folio, size, gfp_mask);
> +	bh = folio_alloc_buffers(folio, size, gfp);
> +	if (!bh)
> +		goto failed;
>  
>  	/*
>  	 * Link the folio to the buffers and initialise them.  Take the
> @@ -1426,24 +1419,49 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
>  }
>  EXPORT_SYMBOL(__find_get_block);
>  
> +/**
> + * bdev_getblk - Get a buffer_head in a block device's buffer cache.
> + * @bdev: The block device.
> + * @block: The block number.
> + * @size: The size of buffer_heads for this @bdev.
> + * @gfp: The memory allocation flags to use.
> + *
> + * In contrast to __getblk_gfp(), the @gfp flags must be all of the flags;
> + * they are not augmented with the mapping's GFP flags.
> + *
> + * Return: The buffer head, or NULL if memory could not be allocated.
> + */
> +struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
> +		unsigned size, gfp_t gfp)
> +{
> +	struct buffer_head *bh = __find_get_block(bdev, block, size);
> +
> +	might_alloc(gfp);
> +	if (bh)
> +		return bh;
> +
> +	return __getblk_slow(bdev, block, size, gfp);
> +}
> +EXPORT_SYMBOL(bdev_getblk);
> +
>  /*
>   * __getblk_gfp() will locate (and, if necessary, create) the buffer_head
>   * which corresponds to the passed block_device, block and size. The
>   * returned buffer has its reference count incremented.
> - *
> - * __getblk_gfp() will lock up the machine if grow_dev_page's
> - * try_to_free_buffers() attempt is failing.  FIXME, perhaps?
>   */
>  struct buffer_head *
>  __getblk_gfp(struct block_device *bdev, sector_t block,
>  	     unsigned size, gfp_t gfp)
>  {
> -	struct buffer_head *bh = __find_get_block(bdev, block, size);
> +	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
>  
> -	might_sleep();
> -	if (bh == NULL)
> -		bh = __getblk_slow(bdev, block, size, gfp);
> -	return bh;
> +	/*
> +	 * Prefer looping in the allocator rather than here, at least that
> +	 * code knows what it's doing.
> +	 */
> +	gfp |= __GFP_NOFAIL;
> +
> +	return bdev_getblk(bdev, block, size, gfp);
>  }
>  EXPORT_SYMBOL(__getblk_gfp);
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index d17efb8b7976..01110db9213c 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -233,6 +233,8 @@ void __wait_on_buffer(struct buffer_head *);
>  wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
>  struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
>  			unsigned size);
> +struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
> +		unsigned size, gfp_t gfp);
>  struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
>  				  unsigned size, gfp_t gfp);
>  void __brelse(struct buffer_head *);
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
