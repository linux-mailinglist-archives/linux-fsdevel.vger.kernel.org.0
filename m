Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79D29C652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1826076AbgJ0SPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 14:15:55 -0400
Received: from casper.infradead.org ([90.155.50.34]:52134 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900551AbgJ0SPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aJuGrPjUV5B69QAT+XWMNhLwguTttQ9pW4Jb/9sd8aw=; b=WRCPzF2gw/18Twd0RxH2oC7NAg
        8SOZzeso95uQctgaIPQJ31okK/svcLL7s3WlBTsifMP7B1EpA44lORl0lQaN+1r/XRAGFakyPX/do
        Hfn8gO35FggehsRWZbGrjHR/LwAd2EG34tEVvgAZPwgo/qdjgc12Z5PzE39rEeU7taS5/8jMGMBnE
        bNEjcZK3MR/YkKCxW+N9NHh/5GLxHVaEoHRSGxs2uMUjtQ4ncdr21CQ1InGnQAISRC/BXHHOk0XoX
        2/qigVqyvd0tRPvTFccnod80Wn4U/Die9g4EnHabBCbZSCLOFPifOBdWvDBiW6NBnf8FE3HH3XjsG
        CqLigDyw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXTVg-00011u-4G; Tue, 27 Oct 2020 18:15:52 +0000
Date:   Tue, 27 Oct 2020 18:15:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: zero cached pages over unwritten extents on
 zero range
Message-ID: <20201027181552.GB32577@infradead.org>
References: <20201012140350.950064-1-bfoster@redhat.com>
 <20201012140350.950064-3-bfoster@redhat.com>
 <20201015094901.GC21420@infradead.org>
 <20201019165519.GB1232435@bfoster>
 <20201019180144.GC1232435@bfoster>
 <20201020162150.GB1272590@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020162150.GB1272590@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:21:50PM -0400, Brian Foster wrote:
> Ugh, so the above doesn't quite describe historical behavior.
> block_truncate_page() converts an unwritten block if a page exists
> (dirty or not), but bails out if a page doesn't exist. We could still do
> the above, but if we wanted something more intelligent I think we need
> to check for a page before we get the mapping to know whether we can
> safely skip an unwritten block or need to write over it. Otherwise if we
> check for a page within the actor, we have no way of knowing whether
> there was a (possibly dirty) page that had been written back and/or
> reclaimed since ->iomap_begin(). If we check for the page first, I think
> that the iolock/mmaplock in the truncate path ensures that a page can't
> be added before we complete. We might be able to take that further and
> check for a dirty || writeback page, but that might be safer as a
> separate patch. See the (compile tested only) diff below for an idea of
> what I was thinking.

The idea looks reasonable, but a few comment below:

> +struct iomap_trunc_priv {
> +	bool *did_zero;

I don't think there is any point on using a pointer here, when we
can trivially copy out the scalar value.

> +	bool has_page;

The naming of this flag really confuses me.  Maybe has_data or
in_pagecache might be better options?

> +static loff_t
> +iomap_truncate_page_actor(struct inode *inode, loff_t pos, loff_t count,
> +		void *data, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct iomap_trunc_priv	*priv = data;
> +	unsigned offset;
> +	int status;
> +
> +	if (srcmap->type == IOMAP_HOLE)
> +		return count;
> +	if (srcmap->type == IOMAP_UNWRITTEN && !priv->has_page)
> +		return count;

Maybe add a comment here to explain why priv->has_page matters?

> +
> +	offset = offset_in_page(pos);

I'd move this on the initialization line.

> +	ret = iomap_apply(inode, pos, blocksize - off, IOMAP_ZERO, ops, &priv,
> +			  iomap_truncate_page_actor);
> +	if (ret <= 0)
> +		return ret;

The check could just be < 0 and would be a little more obvious.
