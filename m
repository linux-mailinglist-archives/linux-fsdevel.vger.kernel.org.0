Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15F661178A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJ1Qbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJ1Qbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8511C810B;
        Fri, 28 Oct 2022 09:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEDF16298D;
        Fri, 28 Oct 2022 16:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0858CC433C1;
        Fri, 28 Oct 2022 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666974689;
        bh=r5jLZiJG+BZh1gQTZs76jR9cqLXlQ/vNf70etHJiS/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAkdmmAPEXdGJLwKu07uII0odmcVzq1deEH+Mo1BA3cpvV1L6DF5p70HKiKrW6Z/X
         8/hZ4ojNEgQ9YuYAfAyfeViKmRoBTPrl28oljCt6lMPoijx88fCLD2TSp64f/XJbZu
         7dYWuE3Zd3rCQKizGX6HGI2m81t9v+vWS3xgc/aptEaK8aHGyukF2vsRBxDlAcbvEJ
         1Xoc0MvCBLTGm96ENG870Wtk91S2RUajnBJ98Sio6wvXSUKhOHb/JX9wSM2RNb2Q+I
         Oib59U/OYE3isuMSlXdML4tIaTRBb9cGYQmg3GS4yFr3CqU0hkBQXYmasfIKBh61uX
         b6/qUBpUv9wkg==
Date:   Fri, 28 Oct 2022 09:31:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 1/2] iomap: Change uptodate variable name to state
Message-ID: <Y1wD4BykwDgJ1mXC@magnolia>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <82faf435c4e5748e8c6554308f13cac5bc4a8546.1666928993.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82faf435c4e5748e8c6554308f13cac5bc4a8546.1666928993.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:00:32AM +0530, Ritesh Harjani (IBM) wrote:
> This patch just changes the struct iomap_page uptodate & uptodate_lock
> member names to state and state_lock to better reflect their purpose for
> the upcoming patch.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ca5c62901541..255f9f92668c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -25,13 +25,13 @@
>  
>  /*
>   * Structure allocated for each folio when block size < folio size
> - * to track sub-folio uptodate status and I/O completions.
> + * to track sub-folio uptodate state and I/O completions.
>   */
>  struct iomap_page {
>  	atomic_t		read_bytes_pending;
>  	atomic_t		write_bytes_pending;
> -	spinlock_t		uptodate_lock;
> -	unsigned long		uptodate[];
> +	spinlock_t		state_lock;
> +	unsigned long		state[];
>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct folio *folio)
> @@ -58,12 +58,12 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>  
> -	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
>  		      gfp);
>  	if (iop) {
> -		spin_lock_init(&iop->uptodate_lock);
> +		spin_lock_init(&iop->state_lock);
>  		if (folio_test_uptodate(folio))
> -			bitmap_fill(iop->uptodate, nr_blocks);
> +			bitmap_fill(iop->state, nr_blocks);
>  		folio_attach_private(folio, iop);
>  	}
>  	return iop;
> @@ -79,7 +79,7 @@ static void iomap_page_release(struct folio *folio)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>  	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> -	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> +	WARN_ON_ONCE(bitmap_full(iop->state, nr_blocks) !=
>  			folio_test_uptodate(folio));
>  	kfree(iop);
>  }
> @@ -110,7 +110,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* move forward for each leading block marked uptodate */
>  		for (i = first; i <= last; i++) {
> -			if (!test_bit(i, iop->uptodate))
> +			if (!test_bit(i, iop->state))

Hmm... time to add a new predicate helper clarifying that this is
uptodate state that we're checking here.

--D

>  				break;
>  			*pos += block_size;
>  			poff += block_size;
> @@ -120,7 +120,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* truncate len if we find any trailing uptodate block(s) */
>  		for ( ; i <= last; i++) {
> -			if (test_bit(i, iop->uptodate)) {
> +			if (test_bit(i, iop->state)) {
>  				plen -= (last - i + 1) * block_size;
>  				last = i - 1;
>  				break;
> @@ -152,11 +152,11 @@ static void iomap_iop_set_range_uptodate(struct folio *folio,
>  	unsigned last = (off + len - 1) >> inode->i_blkbits;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	bitmap_set(iop->uptodate, first, last - first + 1);
> -	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	bitmap_set(iop->state, first, last - first + 1);
> +	if (bitmap_full(iop->state, i_blocks_per_folio(inode, folio)))
>  		folio_mark_uptodate(folio);
> -	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
>  }
>  
>  static void iomap_set_range_uptodate(struct folio *folio,
> @@ -451,7 +451,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  	last = (from + count - 1) >> inode->i_blkbits;
>  
>  	for (i = first; i <= last; i++)
> -		if (!test_bit(i, iop->uptodate))
> +		if (!test_bit(i, iop->state))
>  			return false;
>  	return true;
>  }
> @@ -1354,7 +1354,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iop && !test_bit(i, iop->uptodate))
> +		if (iop && !test_bit(i, iop->state))
>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
> -- 
> 2.37.3
> 
