Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD6247E098
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbhLWIrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhLWIrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:47:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFEBC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hr4b/hNqOZgXqkjuRvvg4uXvR6MmXFNQm+5G++mKMcM=; b=0akfVuEXciCD3pI1J6EvL/nHy1
        vgJeb+CGCVmd2KnXqCozWjE3T8aCB7fDfun1q+IbsL8eoKcjvGN7IQf7aMWpo22uKh7GA4r82X7m3
        i8h4Ojbv4N1sgroB6Rb411w4RqDTwvsHP9vADCQsVVMYalGCRM9bO70vCs2cV6cHM2e8g0mdoTJGu
        BNDQrwkxgVhkTgctt09bPqzrh5y8AtGIppeOPFAbdSQmE2hNekq0ZIrtcpyJ1VYL2LTJ5zkC5LDKY
        xnGU+GfEdgvqtHMUBUEH236oQ8elT6uKy6fFln23w55B2loaRHEwOqIvBKm2ID9BVayKgOtdhMQKI
        dlTQMHbw==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Jkl-00CKnV-FR; Thu, 23 Dec 2021 08:47:12 +0000
Date:   Thu, 23 Dec 2021 09:47:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 48/48] mm: Use multi-index entries in the page cache
Message-ID: <YcQ3jf7/ASHSK0bi@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-49-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-49-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:56AM +0000, Matthew Wilcox (Oracle) wrote:
> We currently store large folios as 2^N consecutive entries.  While this
> consumes rather more memory than necessary, it also turns out to be buggy.
> A writeback operation which starts within a tail page of a dirty folio will
> not write back the folio as the xarray's dirty bit is only set on the
> head index.  With multi-index entries, the dirty bit will be found no
> matter where in the folio the operation starts.
> 
> This does end up simplifying the page cache slightly, although not as
> much as I had hoped.

This looks sensible to me, but I'm not xarray expert.

So the only thing I have to offer is a superficial nit:

> +static inline
> +bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)

Weird identation indentation here.
