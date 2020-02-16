Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6D1606C3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 22:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgBPVlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 16:41:35 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45822 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbgBPVlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 16:41:35 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6280B43FFD9;
        Mon, 17 Feb 2020 08:41:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3RfM-00037v-3o; Mon, 17 Feb 2020 08:41:28 +1100
Date:   Mon, 17 Feb 2020 08:41:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Allison Collins <allison.henderson@oracle.com>,
        lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Atomic Writes
Message-ID: <20200216214128.GY10776@dread.disaster.area>
References: <e88c2f96-fdbb-efb5-d7e2-94bfefbe8bfa@oracle.com>
 <20200214044242.GI6870@magnolia>
 <20200215195307.GI7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215195307.GI7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=uq5sveacr8KZjx1GERMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 15, 2020 at 11:53:07AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 13, 2020 at 08:42:42PM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2020 at 03:33:08PM -0700, Allison Collins wrote:
> > > I also understand there are multiple ways to solve this problem that people
> > > may have opinions on.  I've noticed some older patch sets trying to use a
> > > flag to control when dirty pages are flushed, though I think our customer
> > > would like to see a hardware solution via NVMe devices.  So I would like to
> > > see if others have similar interests as well and what their thoughts may be.
> > > Thanks everyone!
> > 
> > Hmmm well there are a number of different ways one could do this--
> 
> Interesting.  Your answer implies a question of "How do we expose
> a filesystem's ability to do atomic writes to userspace", whereas I
> thought Allison's question was "What spec do we write to give to the
> NVMe vendors so that filesystems can optimise their atomic writes".

Well, hardware offload from a filesysetm perspective already has one
easy userspace API: RWF_ATOMIC using direct IO. We already do
"hardware offload" of persistence for pure overwrites (RWF_DSYNC ->
REQ_FUA write) so we can avoid a device cache flush in this case.

I suspect that we could do a similar thing at the filesystem level -
pure atomic overwrites only require that no metadata is being
modified for the write, similar to the REQ_FUA optimisation. The
difference being that REQ_ATOMIC would currently fail if it can't be
offloaded (hence the need for a software atomic overwrite), and we'd
need REQ_ATOMIC plumbed through the block layer and drivers...

> I am very interested in the question of atomic writes, but I don't
> know that we're going to have the right people in the room to design
> a userspace API.  Maybe this is more of a Plumbers topic?  I think
> the two main users of a userspace API would be databases (sqlite,
> mysql, postgres, others) and package managers (dpkg, rpm, others?).
> Then there would be the miscellaneous users who just want things to work
> and don't really care about performance (writing a game's high score file,
> updating /etc/sudoers).

I'm not sure we need a new userspace API: RWF_ATOMIC gives userspace
exactly what is needed to define exact atomic writes boundaries...

However, the difficulty with atomic writes is buffered IO, and I'm
still not sure that makes any sense. This requires the page cache to
track atomic write boundaries and the order in which the pages were
dirtied. It also requires writeback to flush pages in that order and
as single atomic IOs.

There's an open question as to whether we can report the results of
the atomic write to userspace (i.e. the cached data) before it has
been written back successfully - is it a successful atomic write if
the write has only reached the page cache and if so can userspace do
anything useful with that information? i.e. you can't use buffered
atomic writes for integrity purposes because you can't control the
order they go to disk in from userspace. Unless, of course, the page
cache is tracking *global* atomic write ordering across all files
and filesystems and fsync() "syncs the world"...

> That might argue in favour of having two independent APIs, one that's
> simple, probably quite slow, but safe, and one that's complex, fast
> and safe.  There's also an option for simple, fast and unsafe, but,
> y'know, we already have that ...
> 
> Your response also implies that atomic writes are only done to a single
> file at a time, which isn't true for either databases or for package
> managers.  I wonder if the snapshot/reflink paradigm is the right one
> for multi-file atomic updates, or if we can use the same underlying
> mechanism to implement an API which better fits how userspace actually
> wants to do atomic updates.

A reflink mechanism would allow concurrent independent atomic writes
to independent files (because reflink is per-file). If implemented
correctly, a reflink mechanism would also allow multiple concurrent
ordered atomic writes to a single file. But to do globally ordered
atomic writes in the kernel? Far simpler just to let userspace use
direct IO, RWF_ATOMIC and do cross-file ordering based on IO
completion notifications....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
