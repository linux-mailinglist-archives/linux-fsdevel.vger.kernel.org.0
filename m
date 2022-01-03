Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDC482EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 08:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiACHxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 02:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiACHxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:53:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB273C061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 23:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=azpgps4BioH/lWW2lGgGYjrtEwL1p0tvtjiWboKkgbw=; b=GmvC+KaS6yu0swv3w53v6NX7Hf
        VIWe9DSwFSOkRgCbq8UNMj1rqmx9aiRPimajP9sW5EfVCGiYa5fkzdRBLThj9Jsyp0xkkt2ztVKpa
        m/yIxfgjDk7LNHOp6prFVTp/WrqB3jYsx/XUXsN0K4IcHAE2VxuJ86dAjpf3STlWPanaIAEFwMDPm
        ipIkeufLNkEs5S1tKbiLrvap6PpooMa53skywvJwXoMjU4ukVwtaR4u7sQxekutGEOsWU5A+GiwFE
        aihH72G8c87SAjNBD21MImuRap/wnDTwXFA6tTbs/JrQSjZRBQCM1elWTFn0xRVW6DvBOtsEVWMrI
        au/KA4vQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4I9P-008XWx-AJ; Mon, 03 Jan 2022 07:53:03 +0000
Date:   Sun, 2 Jan 2022 23:53:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 33/48] mm: Add unmap_mapping_folio()
Message-ID: <YdKrX09t5lwfH1SQ@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-34-willy@infradead.org>
 <YcQnDZ/Yr5L2otnX@infradead.org>
 <YdHOnKIdzKrNAHk0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdHOnKIdzKrNAHk0@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 02, 2022 at 04:11:08PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 23, 2021 at 08:36:45AM +0100, Christoph Hellwig wrote:
> > On Wed, Dec 08, 2021 at 04:22:41AM +0000, Matthew Wilcox (Oracle) wrote:
> > > Convert both callers of unmap_mapping_page() to call unmap_mapping_folio()
> > > instead.  Also move zap_details from linux/mm.h to mm/internal.h
> > 
> > In fact it could even move to mm/memory.c as no one needs it outside of
> > that file. __oom_reap_task_mm always passes a NULL zap_details argument
> > to unmap_page_range.
> 
> Umm ... no?
> 
> static inline bool
> zap_skip_check_mapping(struct zap_details *details, struct page *page)
> {
>         if (!details || !page)
>                 return false;
> 
>         return details->zap_mapping &&
>             (details->zap_mapping != page_rmapping(page));
> }

And now check where zap_skip_check_mapping is actually called..

