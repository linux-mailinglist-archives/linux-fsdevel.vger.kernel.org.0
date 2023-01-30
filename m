Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DB5681766
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 18:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbjA3RQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 12:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjA3RQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:16:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B740BDD;
        Mon, 30 Jan 2023 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=udp53f1R9hF7diB8RkdAZFy1S7NqyLDv3T4AeVpfFZU=; b=vD3n0HW7ci8VodIpy5ZqSW57gm
        SD31fx+77pInEqAUorxwQcmeiqRWOeyKbUpnLP3hqsnRV8A1cfs+jYeR7kChbWoR3iw0yY9RwdU3e
        28khJLgl4h/p6YGQ+Kg4Nx0fgK6kqqZ5lECB0U4WFjgZ2a5RLQ2SIhG/BOjI+51SRTB1e/Rzx/svs
        uOJpZ+p6/OQKMUSUefUMkn527gbzJNbKkrUGdRIqh6WmgFyRN58XOTwgFdqLP7sIezA6RjHs9ntXi
        eoOYkureZxc8fd78yi5su1KKqqekLkvXeojpv2OsteaPgFuVJRo9O1/JTuL/eXXWj5LOAQ+o0lE0A
        JOc8jkaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMXlh-004Sjr-Hm; Mon, 30 Jan 2023 17:16:33 +0000
Date:   Mon, 30 Jan 2023 09:16:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <Y9f7cZxnXbL7x0p+@infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:44:13PM +0530, Ritesh Harjani (IBM) wrote:
> +iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags,
> +		  bool from_writeback)
>  {
>  	struct iomap_page *iop = to_iomap_page(folio);
>  	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> @@ -58,12 +59,32 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>  
> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
>  		      gfp);
>  	if (iop) {

Please just return early here for the allocation failure case instead of 
adding a lot of code with extra indentation.

>  		spin_lock_init(&iop->state_lock);
> -		if (folio_test_uptodate(folio))
> -			bitmap_fill(iop->state, nr_blocks);
> +		/*
> +		 * iomap_page_create can get called from writeback after
> +		 * a truncate_inode_partial_folio operation on a large folio.
> +		 * For large folio the iop structure is freed in
> +		 * iomap_invalidate_folio() to ensure we can split the folio.
> +		 * That means we will have to let go of the optimization of
> +		 * tracking dirty bits here and set all bits as dirty if
> +		 * the folio is marked uptodate.
> +		 */
> +		if (from_writeback && folio_test_uptodate(folio))
> +			bitmap_fill(iop->state, 2 * nr_blocks);
> +		else if (folio_test_uptodate(folio)) {

This code is very confusing.  First please only check
folio_test_uptodate one, and then check the from_writeback flag
inside the branch.  And as mentioned last time I think you really
need some symbolic constants for dealing with dirty vs uptodate
state and not just do a single fill for them.

> +			unsigned start = offset_in_folio(folio,
> +					folio_pos(folio)) >> inode->i_blkbits;
> +			bitmap_set(iop->state, start, nr_blocks);

Also this code leaves my head scratching.  Unless I'm missing something
important

	 offset_in_folio(folio, folio_pos(folio))

must always return 0.

Also the from_writeback logic is weird.  I'd rather have a
"bool is_dirty" argument and then pass true for writeback beause
we know the folio is dirty, false where we know it can't be
dirty and do the folio_test_dirty in the caller where we don't
know the state.

> +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
> +{
> +	unsigned int nr_blocks = i_blocks_per_folio(mapping->host, folio);
> +	struct iomap_page *iop = iomap_page_create(mapping->host, folio, 0, false);

Please avoid the overly long line.  In fact with such long function
calls I'd generally prefer if the initialization was moved out of the
declaration.

> +
> +	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, folio_pos(folio)),

Another overly long line here.
