Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1448486B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 20:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiADTWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 14:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiADTWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F74EC061761;
        Tue,  4 Jan 2022 11:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FA87B817DF;
        Tue,  4 Jan 2022 19:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045EFC36AE9;
        Tue,  4 Jan 2022 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641324148;
        bh=NMHUJlMAdVjF9ASpH6/8PaDKPbmSvdn6M2/viwvgouk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqQ+RYY7rsDUJf1g0bGZx3ZZ49c8tSHS/uLm/V963t3TWTyFbxgELffFELX+2kzOz
         82N2YNzzXsz3FZDsZEQVIlmhcOa96RTdK2MAr6lWPLKJwOFwyXGZztIHAVGQyS0TsD
         sAGSfbXIlX1IqQXy3OM/IqFGqQ/+Fj9ONMAkYPqxrdfbjfLOsr5akQtn5pXal5x6lE
         JV+AugL8fC27Mg+LweGZAIfnOB6IVy7C6/+8JD1DRnNdNc7Icf16HopOQMXEzmGBvA
         utl1aKiewKc8YcCDZAOlLN4suXA3BdOr6EVsDWiW8OrZw/+q+77GNUDB/X/o+EGk50
         KdIbzx5CL+W2g==
Date:   Tue, 4 Jan 2022 11:22:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <20220104192227.GA398655@magnolia>
References: <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
 <20220103220310.GG945095@dread.disaster.area>
 <9f51fa6169f4c67d54dd8563b52c540c94c7703a.camel@hammerspace.com>
 <20220104012215.GH945095@dread.disaster.area>
 <YdPyhpdxykDscMtJ@infradead.org>
 <YdSNGAupnxF/ouis@casper.infradead.org>
 <YdSOgyvDnZadYpUP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSOgyvDnZadYpUP@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:14:27AM -0800, hch@infradead.org wrote:
> On Tue, Jan 04, 2022 at 06:08:24PM +0000, Matthew Wilcox wrote:
> > I think it's fine to put in a fix like this now that's readily
> > backportable.  For folios, I can't help but think we want a
> > restructuring to iterate per-extent first, then per-folio and finally
> > per-sector instead of the current model where we iterate per folio,
> > looking up the extent for each sector.
> 
> We don't look up the extent for each sector.  We look up the extent
> once and then add as much of it as we can to the bio until either the
> bio is full or the extent ends.  In the first case we then allocate
> a new bio and add it to the ioend.

Can we track the number of folios that have been bio_add_folio'd to the
iomap_ioend, and make iomap_can_add_to_ioend return false when the
number of folios reaches some threshold?  I think that would solve the
problem of overly large ioends while not splitting folios across ioends
unnecessarily.

As for where to put a cond_resched() call, I think we'd need to change
iomap_ioend_can_merge to avoid merging two ioends if their folio count
exceeds the same(?) threshold, and then one could put the cond_resched
after each iomap_finish_ioend call in iomap_finish_ioends, and declare
that iomap_finish_ioends cannot be called from atomic context.

I forget if anyone ever benchmarked the actual overhead of cond_resched,
but if my dim memory serves, it's not cheap but also not expensive.

Limiting each ioend to (say) 16k folios and not letting small ioends
merge into something bigger than that for the completion seems (to me
anyway) a balance between stalling out on marking pages after huge IOs
vs. losing the ability to coalesce xfs_end_ioend calls when a contiguous
range of file range has been written back but the backing isn't.

<shrug> That's just my ENOCOFFEE reaction, hopefully that wasn't total
nonsense.

--D

> > Particularly for the kind of case Trond is talking about here; when we
> > want to fsync(), as long as the entire folio is Uptodate, we want to
> > write the entire thing back.  Doing it in portions and merging them back
> > together seems like a lot of wasted effort.
> 
> Writing everything together should be the common case.
