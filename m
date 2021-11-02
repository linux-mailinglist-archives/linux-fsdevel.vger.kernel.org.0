Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4B44284F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhKBH3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBH3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:29:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF3EC061714;
        Tue,  2 Nov 2021 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PVVbJ+L6vQN1A1jcNpOyUiq5xpDOlQSOqXfQWlozuyo=; b=G0cJsbWBva68Jqi2KKs+MyKrgY
        3qn0pmmYTkuj39dlW/O0Ptt86hSqG7bftMNnK1dKVUaKaPMdT9nCCA95myTl82oHWKqfItT0PMg2o
        5YoOWLied2s1pC/u0EEaidX52RVDxWhg3NEctu6oiwKXYEFV64V4P+VXYU3dFuFJqLoqPHdCtmWZ+
        QAtpVHsq7S/Q389i20jbD2Qeq/XCtGiM3iBOSp5Mb6CBZulk4W2BtKBDrDQ3EbdSCQB284SyRemRf
        ijxdP5YvmKzUh62pkdVdj4fQ7IjAxOHsgM+dNQlVCZ7Cnws5APolZpyNWNRFmbZZ/dJKnXozMvCQU
        toxPmcyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhoBu-000mDv-GQ; Tue, 02 Nov 2021 07:26:42 +0000
Date:   Tue, 2 Nov 2021 00:26:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 18/21] iomap: Convert iomap_add_to_ioend to take a folio
Message-ID: <YYDoMltwjNKtJaWR@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-19-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-19-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:26PM +0000, Matthew Wilcox (Oracle) wrote:
> @@ -1431,11 +1428,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  	 * |     desired writeback range    |      see else    |
>  	 * ---------------------------------^------------------|
>  	 */
> -	offset = i_size_read(inode);
> -	end_index = offset >> PAGE_SHIFT;
> -	if (page->index < end_index)
> -		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
> -	else {
> +	isize = i_size_read(inode);
> +	end_pos = folio_pos(folio) + folio_size(folio);
> +	if (end_pos - 1 >= isize) {

Looking at the code not part of the context this looks fine.  But I
really wonder if this (and also the blocks change above) would be
better off being split into separate, clearly documented patches.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
