Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCD72B826
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFLGiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLGh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:37:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA719B1;
        Sun, 11 Jun 2023 23:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kSFn8sj/lx0kbg+1a8CYLNMW9ZwdAaC8S5IDI6vzm0w=; b=jGtelzEdmx90Kuv80+ed14vdI5
        Ptkguoep13Ev6WbOkOBIvEbe1QnTamC8S4PgFaTJN8u5e5my5cXJ22LVn7mric2dH9AlcKS645nMJ
        q4YugzFUbSNff6Ge+N9N13WuYVnI4XzK7BINlHJfcIO4O+hjvEeuSt+9+8ZEI6SaeZJxwSlZQRCgG
        /RyihsYjqvSHsd9mixqi4Dbktt5o80DwSzLUiXeHxaz3IP4BQpuYSttjzYkRGXaGnmwFRQMRBm7/h
        NvC3LOIa7NJeSHJqC9igeRSnW9Tq3CKvQPFAvt39D0ywAELiC2cWA3C0Fwi2eeUMOnFiD6uOOz7GU
        OUsz5Lng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8b48-002lpk-1z;
        Mon, 12 Jun 2023 06:30:12 +0000
Date:   Sun, 11 Jun 2023 23:30:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv9 6/6] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <ZIa7dFb42FkI5jgp@infradead.org>
References: <cover.1686395560.git.ritesh.list@gmail.com>
 <954d2e61dedbada996653c9d780be70a48dc66ae.1686395560.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954d2e61dedbada996653c9d780be70a48dc66ae.1686395560.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just some nitpicks, this otherwise looks fine.

First during the last patches ifs as a variable name has started
to really annoy me and I'm not sure why.  I'd like to hear from the
others, bu maybe just state might be a better name that flows easier?

> +static void iomap_clear_range_dirty(struct folio *folio, size_t off, size_t len)
> +{
> +	struct iomap_folio_state *ifs = iomap_get_ifs(folio);
> +
> +	if (!ifs)
> +		return;
> +	iomap_ifs_clear_range_dirty(folio, ifs, off, len);

Maybe just do

	if (ifs)
		iomap_ifs_clear_range_dirty(folio, ifs, off, len);

?

But also do we even need the ifs argument to iomap_ifs_clear_range_dirty
after we've removed it everywhere else earlier?

> +	/*
> +	 * When we have per-block dirty tracking, there can be
> +	 * blocks within a folio which are marked uptodate
> +	 * but not dirty. In that case it is necessary to punch
> +	 * out such blocks to avoid leaking any delalloc blocks.
> +	 */
> +	ifs = iomap_get_ifs(folio);
> +	if (!ifs)
> +		goto skip_ifs_punch;
> +
> +	last_byte = min_t(loff_t, end_byte - 1,
> +		(folio_next_index(folio) << PAGE_SHIFT) - 1);
> +	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
> +	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
> +	for (i = first_blk; i <= last_blk; i++) {
> +		if (!iomap_ifs_is_block_dirty(folio, ifs, i)) {
> +			ret = punch(inode, folio_pos(folio) + (i << blkbits),
> +				    1 << blkbits);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
> +skip_ifs_punch:

And happy to hear from the others, but to me having a helper for
all the iomap_folio_state manipulation rather than having it in
the middle of the function and jumped over if not needed would
improve the code structure.
