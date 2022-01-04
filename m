Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5195648479C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiADSOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 13:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiADSOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:14:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2305C061761;
        Tue,  4 Jan 2022 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eE0ygipHFAAtRi3fgE5+J8uvuMi5iiOoj8ickPpMkfQ=; b=Vo6IiCnE0drvCEE2mUPViphSgM
        yibh5vZfJEDWNnODKDmg35UjY+132YS0eA/4RkVGgF1LKTfAcFmIVk30GvGuHF8eKlqERvFVWXeOg
        3/qHFiTaFoxtUy7l3kiFzRBRXqUnIdbq6IdfWaMgbn2DehdaNZMaPjfFK5mEGgiBHbfyAndvW+Ika
        Em3Sgy7kDaepRVDyyNb5prFrYNQKNUMD1uZe4zRYr8YlqwuFCKp0bKdGiJtqDxop4bk/GDW79sz/d
        cgJDVvHD0Mujw0Pf7fq9P6qg1W5RL11wy3vXMYkuzMvf6fbfYJuyYbtQXt+uxHWnvce73hEzw91jx
        RohOlJ5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4oKJ-00CSRe-OX; Tue, 04 Jan 2022 18:14:27 +0000
Date:   Tue, 4 Jan 2022 10:14:27 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdSOgyvDnZadYpUP@infradead.org>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSNGAupnxF/ouis@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 06:08:24PM +0000, Matthew Wilcox wrote:
> I think it's fine to put in a fix like this now that's readily
> backportable.  For folios, I can't help but think we want a
> restructuring to iterate per-extent first, then per-folio and finally
> per-sector instead of the current model where we iterate per folio,
> looking up the extent for each sector.

We don't look up the extent for each sector.  We look up the extent
once and then add as much of it as we can to the bio until either the
bio is full or the extent ends.  In the first case we then allocate
a new bio and add it to the ioend.

> Particularly for the kind of case Trond is talking about here; when we
> want to fsync(), as long as the entire folio is Uptodate, we want to
> write the entire thing back.  Doing it in portions and merging them back
> together seems like a lot of wasted effort.

Writing everything together should be the common case.
