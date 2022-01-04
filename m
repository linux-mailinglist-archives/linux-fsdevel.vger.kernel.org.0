Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1148477C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 19:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiADSIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiADSIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:08:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13F8C061761;
        Tue,  4 Jan 2022 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QuiQtYWCOIprm8FAAD7U5pdcjxOOYewWBK2lmqcEfX0=; b=TTIrUqmUVqa5+k9EQA/jSeWigF
        LCPjCN841vZufWrpxL1fQAOJ/ifGDVqYA6XhIqnJnxw39jaACYzfpFm32ZYzMSd5mJ9aGTJmXvcOd
        v5XeUzV12BaODeOndPU9ejTjQeoBOv244LHG/+FEHjieM/k1At/fl+U+/vhvRhVnSigdvK7yfW+82
        1uljqrg4ah1M41Cjd/eeMEMROFX8t3OxzGEx/n0oib0D6UugVu4XTuweXGNvKYne9AJ0bp0EsUTWb
        ugm4LEr82EzRrZZkL5pr2pkEIwsWShvtlXrLgZQBujQjdWyKQh6+oU/gQpN61XhiCgVSCQhBS3W95
        e5sbtGgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4oES-00DsoE-CA; Tue, 04 Jan 2022 18:08:24 +0000
Date:   Tue, 4 Jan 2022 18:08:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdSNGAupnxF/ouis@casper.infradead.org>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdPyhpdxykDscMtJ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 03, 2022 at 11:08:54PM -0800, hch@infradead.org wrote:
> > +	/*
> > +	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> > +	 * also prevents long tight loops ending page writeback on all the pages
> > +	 * in the ioend.
> > +	 */
> > +	if (wpc->ioend->io_size >= 4096 * PAGE_SIZE)
> > +		return false;
> 
> And this stops making sense with the impending additions of large folio
> support.  I think we need to count the pages/folios instead as the
> operations are once per page/folio.

I think it's fine to put in a fix like this now that's readily
backportable.  For folios, I can't help but think we want a
restructuring to iterate per-extent first, then per-folio and finally
per-sector instead of the current model where we iterate per folio,
looking up the extent for each sector.

Particularly for the kind of case Trond is talking about here; when we
want to fsync(), as long as the entire folio is Uptodate, we want to
write the entire thing back.  Doing it in portions and merging them back
together seems like a lot of wasted effort.
