Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EED390EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 05:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhEZDdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 23:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhEZDdl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 23:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03E6361417;
        Wed, 26 May 2021 03:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621999931;
        bh=EPD8eWdL3o3BGUuFoBklCzaXdZghvgcsgGeaq/Pagu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReSYn2le/FVvB1mjKEj2QlTS83t0aH3zV3R88CtS4z95l5lbwn+g0rnMGGvQvCYGY
         TdQuEPaSVL9KF+8bfkw4ExGspkvmbVEoqO0Wd2opEJn1Ax3/Hp/+nuLIiAJ1ax9c73
         PyG+BLLsFsk18KUC9bE9mPGeJPzaXyUmQFFB5cQuCG5xxX/BXOvpjpeeOdcbTuAbje
         3zt5g1PE8KO8c0lyU//EAd3r20XVIQ3cb3EGd6wYJTr7L2XHp9NcjITw1hxRAY7Oyk
         kY9bqGj2KcC9q4Rvvf/yyI0woR6h+yYMQFSFKlW4OEXjKl6Sy7GSqoE1ZibkuH+Q1G
         hVU39XXJxTgtw==
Date:   Tue, 25 May 2021 20:32:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Message-ID: <20210526033210.GG202078@locust>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-4-bfoster@redhat.com>
 <20210520232737.GA9675@magnolia>
 <YKuVymtSYhrDCytP@bfoster>
 <20210525042035.GE202121@locust>
 <YK2uorrbm0L76p68@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK2uorrbm0L76p68@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 03:12:50AM +0100, Matthew Wilcox wrote:
> On Mon, May 24, 2021 at 09:20:35PM -0700, Darrick J. Wong wrote:
> > > > This patch establishes a maximum ioend size of 4096 pages so that we
> > > > don't trip the lockup watchdog while clearing pagewriteback and also so
> > > > that we don't pin a large number of pages while constructing a big chain
> > > > of bios.  On gfs2 and zonefs, each ioend completion will now have to
> > > > clear up to 4096 pages from whatever context bio_endio is called.
> > > > 
> > > > For XFS it's a more complicated -- XFS already overrode the bio handler
> > > > for ioends that required further metadata updates (e.g. unwritten
> > > > conversion, eof extension, or cow) so that it could combine ioends when
> > > > possible.  XFS wants to combine ioends to amortize the cost of getting
> > > > the ILOCK and running transactions over a larger number of pages.
> > > > 
> > > > So I guess I see how the two changes dovetail nicely for XFS -- iomap
> > > > issues smaller write bios, and the xfs ioend worker can recombine
> > > > however many bios complete before the worker runs.  As a bonus, we don't
> > > > have to worry about situations like the device driver completing so many
> > > > bios from a single invocation of a bottom half handler that we run afoul
> > > > of the soft lockup timer.
> > > > 
> > > > Is that a correct understanding of how the two changes intersect with
> > > > each other?  TBH I was expecting the two thresholds to be closer in
> > > > value.
> > > > 
> > > 
> > > I think so. That's interesting because my inclination was to make them
> > > farther apart (or more specifically, increase the threshold in this
> > > patch and leave the previous). The primary goal of this series was to
> > > address the soft lockup warning problem, hence the thresholds on earlier
> > > versions started at rather conservative values. I think both values have
> > > been reasonably justified in being reduced, though this patch has a more
> > > broad impact than the previous in that it changes behavior for all iomap
> > > based fs'. Of course that's something that could also be addressed with
> > > a more dynamic tunable..
> > 
> > <shrug> I think I'm comfortable starting with 256 for xfs to bump an
> > ioend to a workqueue, and 4096 pages as the limit for an iomap ioend.
> > If people demonstrate a need to smart-tune or manual-tune we can always
> > add one later.
> > 
> > Though I guess I did kind of wonder if maybe a better limit for iomap
> > would be max_hw_sectors?  Since that's the maximum size of an IO that
> > the kernel will for that device?
> 
> I think you're looking at this wrong.  The question is whether the
> system can tolerate the additional latency of bumping to a workqueue vs
> servicing directly.
> 
> If the I/O is large, then clearly it can.  It already waited for all
> those DMAs to happen which took a certain amount of time on the I/O bus.
> If the I/O is small, then maybe it can and maybe it can't.  So we should
> be conservative and complete it in interrupt context.
> 
> This is why I think "number of pages" is really a red herring.  Sure,
> that's the amount of work to be done, but really the question is "can
> this I/O tolerate the extra delay".  Short of passing that information
> in from the caller, number of bytes really is our best way of knowing.
> And that doesn't scale with anything to do with the device or the
> system bus.  

It doesn't matter whether the process(es) that triggered writeback will
tolerate the extra latency of a workqueue.  The hangcheck timer trips,
which means we've been doing things in softirq context too long.

The next thing that happens is that the kind of people who treat **ANY**
stack trace in dmesg as grounds to file a bug and escalate it will file
a bug and escalate it, and now I'm working 10 hour days trying to stomp
down all 6 escalations, run a QA botnet, review patches, and make any
incremental progress on long term goals when I can squeeze out five
minutes of free time.

Yeah, it'd be nice to rebuild writeback with some sort of QOS system so
that it could pick different strategies based on the amount of work to
do and the impatience levels of the processes waiting for it.  But that
is a project of its own.  This is a starter fix to take the heat off.

The reason I've been running at 110% burnout for the last 9 months is
exactly this -- someone submits a patchset to fix or improve something,
but then the reviewers pile on with "No no no, you should consider
building this far more elaborate solution", withhold review tags, but
then seem to be too busy to participate in building the elaborate thing.

At least in this case I can do something about it.  We're nearly to rc4
so barring anything weird showing up in QA runs overnight I plan to
stuff this in for 5.14.

--D
