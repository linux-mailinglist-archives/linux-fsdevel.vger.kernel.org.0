Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561B1725505
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 09:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbjFGHFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbjFGHEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:04:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCF9124;
        Wed,  7 Jun 2023 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6sLx5GXIQruwuuE83LbdGvHtNL8jzPNpzchN0Pwhp4Y=; b=Dwh+ExT9bsZ7ye0449+Bqd8/Se
        Eg5T7nOYqntSCOaQelqSCyEEtAgzJn2cuQvaWEvsOzi0TqsVC4IcN4Eie6APkwPULsWTSJfLOI0bv
        3I/72kPRFZGidcvqyiKV0QYzpGwy/DDMvWFZ44Fg63rSUzPwN9roorcBdUHOWALLRtRWsSdxeds+N
        7EkRIsXowFAT86RFf4BCNJT8i2T6tF1releglytX2Ez3XMs3SUOZkOE65xS7aNGjBWEZSrKWQKsIH
        lbgBamczSx2jRsBzk2GMO3fQYV6UgssV0hIo/o0nZoKGbBOvql3Ks3QpdKKfiRtBKpl7JtYTTg9RG
        u/3la6Cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6nDu-004euM-0t;
        Wed, 07 Jun 2023 07:04:50 +0000
Date:   Wed, 7 Jun 2023 00:04:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv8 5/5] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <ZIAsEkURZHRAcxtP@infradead.org>
References: <cover.1686050333.git.ritesh.list@gmail.com>
 <0c3108f6ea45e18c7aae87c2fb3d8fa3311c13a4.1686050333.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c3108f6ea45e18c7aae87c2fb3d8fa3311c13a4.1686050333.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline bool iomap_iof_is_block_dirty(struct folio *folio,
> +			struct iomap_folio *iof, int block)

Two tabs indents here please and for various other functions.

> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = off >> inode->i_blkbits;
> +	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> +	unsigned int nr_blks = last_blk - first_blk + 1;

Given how many places we we opencode this logic I wonder if a helper
would be usefuļ, even if the calling conventions are a bit odd.

To make this nicer it would also be good an take a neat trick from
the btrfs subpage support and use an enum for the bits, e.g.:

enum iomap_block_state {
	IOMAP_ST_UPTODATE,
	IOMAP_ST_DIRTY,

	IOMAP_ST_MAX,
};


static void iomap_ibs_calc_range(struct folio *folio, size_t off, size_t len,
		enum iomap_block_state state, unsigned int *first_blk,
		unsigned int *nr_blks)
{
	struct inode *inode = folio->mapping->host;
	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;

	*first_blk = state * blks_per_folio + (off >> inode->i_blkbits);
	*nr_blks = last_blk - first_blk + 1;
}

> +	/*
> +	 * iof->state tracks two sets of state flags when the
> +	 * filesystem block size is smaller than the folio size.
> +	 * The first state tracks per-block uptodate and the
> +	 * second tracks per-block dirty state.
> +	 */
> +	iof = kzalloc(struct_size(iof, state, BITS_TO_LONGS(2 * nr_blocks)),
>  		      gfp);

with the above this can use IOMAP_ST_MAX and make the whole thing a
little more robus.

>
>  	if (iof) {

No that this adds a lot more initialization I'd do a

	if (!iof)
		return NULL;

here and unindent the rest.
