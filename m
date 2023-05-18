Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D47082A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjERN1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjERN1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 09:27:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D0136;
        Thu, 18 May 2023 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KcY68U6U4Q3jPvhJOR7+Fz35FiF7RqM7Rv0gOIB3t3U=; b=O5Bfu800HDVOVbBEUzqXb9zeDW
        FlE0f6zZvhznQxzrebeJAj3wChGL/903jN+P2udAyqUXFoAju0nmK1SQZ93mKQYD/vvhYdN7jJveM
        qfT4q8kyd7He9gkWSJpmaSSJUud2lyU4OPG7lsc+njI2Pg3BJcDwqh8b0AR9TJ+++LC/TuNf53g7k
        6rnNeqH9i/Uzd4qt9J3LbaPU0/TEEVzUbpqffdXQQONE/EdF2BBuKYgElSbGFo2oZkvK0zEpiSODj
        iuhwpA50LF3VvMApZMXjrniin+X6wt8TkOQzRIqbjTl17lD8X6rXbkmv4pvqwEYwnfxvPsVJ4noXU
        tm61KLtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzdfR-00D52s-2X;
        Thu, 18 May 2023 13:27:41 +0000
Date:   Thu, 18 May 2023 06:27:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGYnzcoGuzWKa7lh@infradead.org>
References: <cover.1683485700.git.ritesh.list@gmail.com>
 <86987466d8d7863bd0dca81e9d6c3eff7abd4964.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86987466d8d7863bd0dca81e9d6c3eff7abd4964.1683485700.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 12:58:00AM +0530, Ritesh Harjani (IBM) wrote:
> +static inline void iop_clear_range(struct iomap_page *iop,
> +				   unsigned int start_blk, unsigned int nr_blks)
> +{
> +	bitmap_clear(iop->state, start_blk, nr_blks);
> +}

Similar to the other trivial bitmap wrappers added earlier in the
series I don't think this one is very useful.

> +	struct iomap_page *iop = to_iomap_page(folio);
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = (off >> inode->i_blkbits);
> +	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	if (!iop)
> +		return;
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	iop_set_range(iop, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);

All the variable initializations except for ios should really move
into a branch here.  Or we just use separate helpers for the case
where we actually have an iops and isolate all that, which would
be my preference (but goes counter to the direction of changes
earlier in the series to the existing functions).

> +static void iop_clear_range_dirty(struct folio *folio, size_t off, size_t len)
> +{
> +	struct iomap_page *iop = to_iomap_page(folio);
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int first_blk = (off >> inode->i_blkbits);
> +	unsigned int last_blk = ((off + len - 1) >> inode->i_blkbits);
> +	unsigned int nr_blks = last_blk - first_blk + 1;
> +	unsigned long flags;
> +
> +	if (!iop)
> +		return;
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	iop_clear_range(iop, first_blk + blks_per_folio, nr_blks);
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}

Same here.
