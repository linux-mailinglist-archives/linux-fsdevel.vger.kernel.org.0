Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2E6F6E89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjEDPDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjEDPDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 11:03:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD05267;
        Thu,  4 May 2023 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=91KnE58Tck/Xqc36ceWN6e5o7xjkJJLlWUw/hf+QxdY=; b=iq6m1hhu5C9ycS/k/RQar9a0eu
        EPbfpqE3UN1EKqziSxGmPhgDPlZj8H9BF2+jfE3OST7z9f0somGZ7WXLvixWTq2fRj2SOUjhT6Nzm
        wvCcxEjhzqB7N+hQqff3qthq7QuG54mz7Px7vPvsRr0y7Bndf+PR7AInerAuys8OkC9UVAbJfZhuU
        4XwU1ATc9BB0FM3bPy5VQPxxWw+RSfVEuPPLjfZFdVd3yV8KYGsymdoW1fqr7625GYXU4ippHumPz
        lDVK756Z9jPfivBSk2gVTwDLZ52CpQiZSBDFCFrB4q8JWBta19QGlnQ+J6iE+RektEq/X1GZXeKun
        tuSgVShA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puaTo-00AhPL-1O; Thu, 04 May 2023 15:02:48 +0000
Date:   Thu, 4 May 2023 16:02:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv4 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <ZFPJGDqfcUtI4ptO@casper.infradead.org>
References: <cover.1683208091.git.ritesh.list@gmail.com>
 <377c30e7b5f2783dd5be12c59ea703d7c72ba004.1683208091.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377c30e7b5f2783dd5be12c59ea703d7c72ba004.1683208091.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 08:21:09PM +0530, Ritesh Harjani (IBM) wrote:
> @@ -90,12 +116,21 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
> 
> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> +	/*
> +	 * iop->state tracks two sets of state flags when the
> +	 * filesystem block size is smaller than the folio size.
> +	 * The first state tracks per-filesystem block uptodate
> +	 * and the second tracks per-filesystem block dirty
> +	 * state.
> +	 */

"per-filesystem"?  I think you mean "per-block (uptodate|block) state".
Using "per-block" naming throughout this patchset might help readability.
It's currently an awkward mix of "subpage", "sub-page" and "sub-folio".
It also feels like you're adding a comment to every non-mechanical change
you make, which isn't necessarily helpful.  Changelog, sure, but
sometimes your comments simply re-state what your change is doing.

> -static void iomap_iop_set_range_uptodate(struct folio *folio,
> -		struct iomap_page *iop, size_t off, size_t len)
> +static void iomap_iop_set_range(struct folio *folio, struct iomap_page *iop,
> +		size_t off, size_t len, enum iop_state state)
>  {
>  	struct inode *inode = folio->mapping->host;
> -	unsigned first = off >> inode->i_blkbits;
> -	unsigned last = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = (off >> inode->i_blkbits);
> +	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
> +	unsigned int nr_blks = last_blk - first_blk + 1;
>  	unsigned long flags;
> -	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> 
> -	spin_lock_irqsave(&iop->state_lock, flags);
> -	iop_set_range_uptodate(iop, first, last - first + 1, nr_blocks);
> -	if (iop_uptodate_full(iop, nr_blocks))
> -		folio_mark_uptodate(folio);
> -	spin_unlock_irqrestore(&iop->state_lock, flags);
> +	switch (state) {
> +	case IOP_STATE_UPDATE:
> +		if (!iop) {
> +			folio_mark_uptodate(folio);
> +			return;
> +		}
> +		spin_lock_irqsave(&iop->state_lock, flags);
> +		iop_set_range_uptodate(iop, first_blk, nr_blks, blks_per_folio);
> +		if (iop_uptodate_full(iop, blks_per_folio))
> +			folio_mark_uptodate(folio);
> +		spin_unlock_irqrestore(&iop->state_lock, flags);
> +		break;
> +	case IOP_STATE_DIRTY:
> +		if (!iop)
> +			return;
> +		spin_lock_irqsave(&iop->state_lock, flags);
> +		iop_set_range_dirty(iop, first_blk, nr_blks, blks_per_folio);
> +		spin_unlock_irqrestore(&iop->state_lock, flags);
> +		break;
> +	}
>  }

I can't believe this is what Dave wanted you to do.  iomap_iop_set_range()
should be the low-level helper called by iop_set_range_uptodate() and
iop_set_range_dirty(), not the other way around.

