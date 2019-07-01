Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9185C5DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 01:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGAXKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 19:10:46 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54707 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbfGAXKp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 19:10:45 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 811A01ACDC1;
        Tue,  2 Jul 2019 09:10:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hi5QS-00040R-OE; Tue, 02 Jul 2019 09:09:32 +1000
Date:   Tue, 2 Jul 2019 09:09:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190701230932.GN7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-12-hch@lst.de>
 <20190624234304.GD7777@dread.disaster.area>
 <20190625101020.GI1462@lst.de>
 <20190628004542.GJ7777@dread.disaster.area>
 <20190628053320.GA26902@lst.de>
 <20190701000859.GL7777@dread.disaster.area>
 <20190701064333.GA20778@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701064333.GA20778@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=EmmQ-hcxAAAA:8 a=7-415B0cAAAA:8 a=Qa3Qb0k2LGP6046GbCIA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:43:33AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 01, 2019 at 10:08:59AM +1000, Dave Chinner wrote:
> > > Why do you assume you have to test it?  Back when we shared
> > > generic_file_read with everyone you also didn't test odd change to
> > > it with every possible fs.
> > 
> > I'm not sure what function you are referring to here. Can you
> > clarify?
> 
> Right now it is generic_file_read_iter(), but before iter it was
> generic_file_readv, generic_file_read, etc.

This generic code never came from XFS, so I'm still not sure what
you are refering to here? Some pointers to commits would help me
remember. :/

> > > If you change iomap.c, you'll test it
> > > with XFS, and Cc other maintainers so that they get a chance to
> > > also test it and comment on it, just like we do with other shared
> > > code in the kernel.
> > 
> > Which is why we've had problems with the generic code paths in the
> > past and other filesystems just copy and paste then before making
> > signficant modifications. e.g. both ext4 and btrfs re-implement
> > write_cache_pages() rather than use the generic writeback code
> > because they have slightly different requirements and those
> > developers don't want to have to worry about other filesystems every
> > time there is an internal filesystem change that affects their
> > writeback constraints...
> > 
> > That's kinda what I'm getting at here: writeback isn't being shared
> > by any of the major filesystems for good reasons...
> 
> I very fundamentally disagree.  It is not shared for a bad reasons,
> and that is people not understanding the mess that the buffer head
> based code is, and not wanting to understand it. 

The problem with heavily shared code is that it requires far more
expertise, knowledge, capability and time to modify it. The code
essentially ossifies, because changing something fundamental risks
breaking other stuff that nobody actually understands anymore and is
unwilling to risk changing.

That's not a problem with bufferheads - that's a problem of widely
shared code that has been slowly hacked to pieces to "fix' random
problems that show up from different users of the shared code.

When the shared code ossifies like this, the only way to make
progress is to either copy it and do whatever you need privately,
or re-implement it completely. ext4 and btrfs have taken the route
of "copy and modify privately", whereas XFS has taken the
"re-implement it completely" path.

We're now starting down the "share the XFS re-implementation" and
we're slowly adding more complexity to the iomap code to handle the
different things each filesystem that is converted needs. With each
new fs adding their own little quirks, it gets harder to make
significant modifications without unknowingly breaking something in
some other filesystem.

It takes highly capable developers to make serious modifications
across highly shared code and the reality is that there are very few
of them around. most developers simply aren't capable of taking on
such a task, especially given that they see capable, experienced
developers who won't even try because of past experiences akin to
a game of Running Man(*)....

Shared code is good, up to the point where the sharing gets so
complex that even people with the capability are not willing to
touch/fix the code. That's what happened to bufferheads and it's a
pattern repeated across lots of kernel infrastructure code. Just
because you can handle these modifications doesn't mean everyone
else can or even wants to.

> And I'd much rather fix this than going down the copy an paste and
> slightly tweak it while fucking up something else route.

The copy-n-paste is a result of developers who have little knowledge
of things outside their domain of interest/expertise making the sane
decision to minimise risk of breaking something they know nothing
about. From an individual subsystem perspective, that's a -good
decision- to make, and that's the point I was trying to make.

You see that as a bad decision, because you equating "shared code"
with "high quality" code. The reality is that shared code is often
poor quality because people get too scared to touch it. That's
exactly the situation I don't want us to get stuck with, and why I
want to see how multiple implementations of this abstracted writeback
path change what we have now before we start moving code about...

i.e. I'm not saying "we shouldn't do this", I'm just saying that "we
should do this because shared code is good" fundamentally conflicts
with the fact we've just re-implemented a bunch of stuff because
the *shared code was really bad*. And taking the same path that lead
to really bad shared code (i.e. organic growth without planning or
design) is likely to end up in the same place....

Cheers,

Dave.

(*) https://www.imdb.com/title/tt0093894/

"A wrongly convicted man must try to survive a public execution
gauntlet staged as a game show."

-- 
Dave Chinner
david@fromorbit.com
