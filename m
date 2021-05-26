Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B385390E36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEZCOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 22:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhEZCOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 22:14:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75611C061574;
        Tue, 25 May 2021 19:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EuhM5+Qw4IXz+4jLPxbbQLmy1P0ODhuR5UwjyZZ2oXs=; b=AaXFkj2BY4gELqVTNm75b/lg9J
        xEW7R7UssY+rt7pybv/I+9QWAhK99HwNiCk0NJ5NcqEuRgR5igB4rQ8GJRJMmTvtv7hdiZy5qAFb6
        ZOdLMVrWGIpvOKMfguCQ81nYad4zGOZwUWhms9IF9PP9RN7sYnQiNCi4FkcBXx99tHqVhHWRj2kNR
        ahMGmBmyxKS6PZyXP5s1cuRZb8fvExR7KxkFK4pxDUI9YHkzpnIOG0QySHz83kYW6pakPBXUsTrEx
        9K/1E/Q8ATJNiVWabJZhmxRMlcp+zVk4eKvgJqok9OH8enMqts8xNsMvZlRpFxPNFrC++6feOTVrp
        riFc4Vkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llj2Q-0045qA-2H; Wed, 26 May 2021 02:12:52 +0000
Date:   Wed, 26 May 2021 03:12:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Brian Foster <bfoster@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Message-ID: <YK2uorrbm0L76p68@casper.infradead.org>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-4-bfoster@redhat.com>
 <20210520232737.GA9675@magnolia>
 <YKuVymtSYhrDCytP@bfoster>
 <20210525042035.GE202121@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525042035.GE202121@locust>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 09:20:35PM -0700, Darrick J. Wong wrote:
> > > This patch establishes a maximum ioend size of 4096 pages so that we
> > > don't trip the lockup watchdog while clearing pagewriteback and also so
> > > that we don't pin a large number of pages while constructing a big chain
> > > of bios.  On gfs2 and zonefs, each ioend completion will now have to
> > > clear up to 4096 pages from whatever context bio_endio is called.
> > > 
> > > For XFS it's a more complicated -- XFS already overrode the bio handler
> > > for ioends that required further metadata updates (e.g. unwritten
> > > conversion, eof extension, or cow) so that it could combine ioends when
> > > possible.  XFS wants to combine ioends to amortize the cost of getting
> > > the ILOCK and running transactions over a larger number of pages.
> > > 
> > > So I guess I see how the two changes dovetail nicely for XFS -- iomap
> > > issues smaller write bios, and the xfs ioend worker can recombine
> > > however many bios complete before the worker runs.  As a bonus, we don't
> > > have to worry about situations like the device driver completing so many
> > > bios from a single invocation of a bottom half handler that we run afoul
> > > of the soft lockup timer.
> > > 
> > > Is that a correct understanding of how the two changes intersect with
> > > each other?  TBH I was expecting the two thresholds to be closer in
> > > value.
> > > 
> > 
> > I think so. That's interesting because my inclination was to make them
> > farther apart (or more specifically, increase the threshold in this
> > patch and leave the previous). The primary goal of this series was to
> > address the soft lockup warning problem, hence the thresholds on earlier
> > versions started at rather conservative values. I think both values have
> > been reasonably justified in being reduced, though this patch has a more
> > broad impact than the previous in that it changes behavior for all iomap
> > based fs'. Of course that's something that could also be addressed with
> > a more dynamic tunable..
> 
> <shrug> I think I'm comfortable starting with 256 for xfs to bump an
> ioend to a workqueue, and 4096 pages as the limit for an iomap ioend.
> If people demonstrate a need to smart-tune or manual-tune we can always
> add one later.
> 
> Though I guess I did kind of wonder if maybe a better limit for iomap
> would be max_hw_sectors?  Since that's the maximum size of an IO that
> the kernel will for that device?

I think you're looking at this wrong.  The question is whether the
system can tolerate the additional latency of bumping to a workqueue vs
servicing directly.

If the I/O is large, then clearly it can.  It already waited for all
those DMAs to happen which took a certain amount of time on the I/O bus.
If the I/O is small, then maybe it can and maybe it can't.  So we should
be conservative and complete it in interrupt context.

This is why I think "number of pages" is really a red herring.  Sure,
that's the amount of work to be done, but really the question is "can
this I/O tolerate the extra delay".  Short of passing that information
in from the caller, number of bytes really is our best way of knowing.
And that doesn't scale with anything to do with the device or the
system bus.  
