Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA37924FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjIEQAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354899AbjIEPkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:40:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20517AC;
        Tue,  5 Sep 2023 08:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D5D6CE10AF;
        Tue,  5 Sep 2023 15:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB69C433C8;
        Tue,  5 Sep 2023 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693928394;
        bh=TKFUSkaMVsK+wWUzKmVC+UGxHOnXSE39Y7NxxmSojdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jc55mXPn9HgckuJ8tudeq1vZYUoMoiuI8Gf+nB/EOnU3o4YvCUk0PROHJqrY9uKus
         Pz26WaIyWid+00+fVrtYdWX9EG/zWZZZlPth333Sy8HhRaoc6LO1pd1HE9lur4XnPn
         mz7Y3H+yxPMpRE1OZ1kIw4VG4OJZGeyD5pKJMBSYDJriORjc8nqHoozQ9PactABlMY
         1OnqkxIh3ce6lB5e5eE4cNT+vsQ8wcn86mDgXGS6Q8Qh+0ZCd3rpbFZqV+481+HrM6
         FQmFO7REl3alcKHNXYM6zt7v1GKUWmR+qI9LTSjdtTesjsbP1jRplSR0YDtXPPTfGE
         13WWh8f/wwV6Q==
Date:   Tue, 5 Sep 2023 08:39:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: handle error conditions more gracefully in
 iomap_to_bh
Message-ID: <20230905153953.GG28202@frogsfrogsfrogs>
References: <20230905124120.325518-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905124120.325518-1-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 02:41:20PM +0200, Christoph Hellwig wrote:
> iomap_to_bh currently BUG()s when the passed in block number is not
> in the iomap.  For file systems that have proper synchronization this
> should never happen and so far hasn't in mainline, but for block devices
> size changes aren't fully synchronized against ongoing I/O.  Instead
> of BUG()ing in this case, return -EIO to the caller, which already has
> proper error handling.  While we're at it, also return -EIO for an
> unknown iomap state instead of returning garbage.
> 
> Fixes: 487c607df790 ("block: use iomap for writes to block devices")
> Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks like a good improvement.  Who should this go through, me (iomap)
or viro/brauner (vfs*) ?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

(lol is email down again?)

--D

>  fs/buffer.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 2379564e5aeadf..a6785cd07081cb 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2011,7 +2011,7 @@ void folio_zero_new_buffers(struct folio *folio, size_t from, size_t to)
>  }
>  EXPORT_SYMBOL(folio_zero_new_buffers);
>  
> -static void
> +static int
>  iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  		const struct iomap *iomap)
>  {
> @@ -2025,7 +2025,8 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  	 * current block, then do not map the buffer and let the caller
>  	 * handle it.
>  	 */
> -	BUG_ON(offset >= iomap->offset + iomap->length);
> +	if (offset >= iomap->offset + iomap->length)
> +		return -EIO;
>  
>  	switch (iomap->type) {
>  	case IOMAP_HOLE:
> @@ -2037,7 +2038,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  		if (!buffer_uptodate(bh) ||
>  		    (offset >= i_size_read(inode)))
>  			set_buffer_new(bh);
> -		break;
> +		return 0;
>  	case IOMAP_DELALLOC:
>  		if (!buffer_uptodate(bh) ||
>  		    (offset >= i_size_read(inode)))
> @@ -2045,7 +2046,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  		set_buffer_uptodate(bh);
>  		set_buffer_mapped(bh);
>  		set_buffer_delay(bh);
> -		break;
> +		return 0;
>  	case IOMAP_UNWRITTEN:
>  		/*
>  		 * For unwritten regions, we always need to ensure that regions
> @@ -2062,7 +2063,10 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
>  		bh->b_blocknr = (iomap->addr + offset - iomap->offset) >>
>  				inode->i_blkbits;
>  		set_buffer_mapped(bh);
> -		break;
> +		return 0;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -EIO;
>  	}
>  }
>  
> @@ -2103,13 +2107,12 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>  			clear_buffer_new(bh);
>  		if (!buffer_mapped(bh)) {
>  			WARN_ON(bh->b_size != blocksize);
> -			if (get_block) {
> +			if (get_block)
>  				err = get_block(inode, block, bh, 1);
> -				if (err)
> -					break;
> -			} else {
> -				iomap_to_bh(inode, block, bh, iomap);
> -			}
> +			else
> +				err = iomap_to_bh(inode, block, bh, iomap);
> +			if (err)
> +				break;
>  
>  			if (buffer_new(bh)) {
>  				clean_bdev_bh_alias(bh);
> -- 
> 2.39.2
> 
