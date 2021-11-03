Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B568D444500
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhKCP5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 11:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhKCP5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:57:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6702C061714;
        Wed,  3 Nov 2021 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OrHZfcODQam8SYKtC3Lj9MXWr83XzejExt/jJ8/GaiA=; b=kIf1jB08vxK2+2uoEHR3BYtha+
        2o8bvNTvMsNJM16+W18FdOTHBPzWFBQL7XA9Fq9Kq7zQPai8jwq1oEIXPTDP4Akf+zpRKCJ4/2SrF
        C3bOlxB27VecrXKlkZk8Yt53OtwohVG+PNM8znTpcwwRG+NR8rmjPUUy9jpE/GBusVUZSsz1sT6py
        7n0bpx4CPLuvcsTr9r8/nNA47g6Ufniwbgt52lgdGr+Lv0JMiYGlJxRDFQ/C01VrkOOHcM0obKMgW
        iF3fCoqq8pTju8mm3WHLy64p3YzZ4JLfBpvRUmHTwQ1m2PxKSjogq2aMRqBxgKiclM95b9y1sDorC
        zYLHPfAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miIbC-005c6F-1n; Wed, 03 Nov 2021 15:54:50 +0000
Date:   Wed, 3 Nov 2021 08:54:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Message-ID: <YYKwyudsHOmPthUP@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-19-willy@infradead.org>
 <YYDoMltwjNKtJaWR@infradead.org>
 <YYGfUuItAyTNax5V@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYGfUuItAyTNax5V@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 08:28:02PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 02, 2021 at 12:26:42AM -0700, Christoph Hellwig wrote:
> > Looking at the code not part of the context this looks fine.  But I
> > really wonder if this (and also the blocks change above) would be
> > better off being split into separate, clearly documented patches.
> 
> How do these three patches look?  I retained your R-b on all three since
> I figured the one you offered below was good for all of them.

Sounds good, and the patches looks good. Minor nitpicks below:

> Rename end_offset to end_pos and file_offset to pos to match the
> rest of the file.  Simplify the loop by calculating nblocks
> up front instead of each time around the loop.

Might be worth mentioning why it changes the types from u64 to loff_t.

>  	/*
> -	 * Walk through the page to find areas to write back. If we run off the
> -	 * end of the current map or find the current map invalid, grab a new
> -	 * one.
> +	 * Walk through the folio to find areas to write back. If we
> +	 * run off the end of the current map or find the current map
> +	 * invalid, grab a new one.

No real need for reflowing the comment, it still fits just fine even
with the folio change.

> Rename end_offset to end_pos and offset_into_page to poff to match the
> rest of the file.  Simplify the handling of the last page straddling
> i_size.

... by doing the EOF check purely based on the byte granularity i_size
instead of converting to a pgoff prematurely.

> +	isize = i_size_read(inode);
> +	end_pos = page_offset(page) + PAGE_SIZE;
> +	if (end_pos - 1 >= isize) {

Wouldn't this check be more obvious as:

	if (end_pos > i_size) {

