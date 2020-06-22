Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1620433A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 00:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgFVWEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 18:04:11 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:33097 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730767AbgFVWEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:04:10 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id C9A76D5A419;
        Tue, 23 Jun 2020 08:04:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jnUXi-0000fd-Ik; Tue, 23 Jun 2020 08:03:54 +1000
Date:   Tue, 23 Jun 2020 08:03:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, jlayton@redhat.com
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200622220354.GU2005@dread.disaster.area>
References: <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
 <20200619024455.GN2005@dread.disaster.area>
 <20200619204033.GB1564@fieldses.org>
 <20200619221044.GO2005@dread.disaster.area>
 <20200619222843.GB2650@fieldses.org>
 <20200620014957.GQ2005@dread.disaster.area>
 <20200620015633.GA1516@fieldses.org>
 <20200620235408.GS2005@dread.disaster.area>
 <20200622212612.GA11051@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622212612.GA11051@fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=HVVqrPaskdhAXJc0OugA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 05:26:12PM -0400, J. Bruce Fields wrote:
> On Sun, Jun 21, 2020 at 09:54:08AM +1000, Dave Chinner wrote:
> > On Fri, Jun 19, 2020 at 09:56:33PM -0400, J. Bruce Fields wrote:
> > > On Sat, Jun 20, 2020 at 11:49:57AM +1000, Dave Chinner wrote:
> > > > However, other people have different opinions on this matter (and we
> > > > know that from the people who considered XFS v4 -> v5 going slower
> > > > because iversion a major regression), and so we must acknowledge
> > > > those opinions even if we don't agree with them.
> > > 
> > > Do you have any of those reports handy?  Were there numbers?
> > 
> > e.g.  RH BZ #1355813 when v5 format was enabled by default in RHEL7.
> > Numbers were 40-47% performance degradation for in-cache writes
> > caused by the original IVERSION implementation using iozone.  There
> > were others I recall, all realted to similar high-IOP small random
> > writes workloads typical of databases....
> 
> Thanks, that's an interesting bug!  Though a bit tangled.  This is where
> you identified the change attribute as the main culprit:
> 
> 	https://bugzilla.redhat.com/show_bug.cgi?id=1355813#c42
> 
> 	The test was running at 70,000 writes/s (2.2GB/s), so it was one
> 	transaction per write() syscall: timestamp updates. On CRC
> 	enabled filesystems, we have a change counter for NFSv4 - it
> 	gets incremented on every write() syscall, even when the
> 	timestamp doesn't change. That's the difference in behaviour and
> 	hence performance in this test.
> 
> In RHEL8, or anything post-v4.16, the frequency of change attribute
> updates should be back down to that of timestamp updates on this
> workload.  So it'd be interesting to repeat that experiment now.

Yup, which in itself has been a problem for similar workloads.
There's a reason we now recommend the use of lazytime for high
performance database workloads that can do hundreds of thousands of
small write IOs a second...

> The bug was reporting in-house testing, and doesn't show any evidence
> that particular regression was encountered by users; Eric said:
> 
> 	https://bugzilla.redhat.com/show_bug.cgi?id=1355813#c52
> 
> 	Root cause of this minor in-memory regression was inode
> 	versioning behavior; as it's unlikely to have real-world effects
> 	(and has been open for years with no customer complaints) I'm
> 	closing this WONTFIX to get it off the radar.

It's just the first I found because bugzilla has a slow, less than
useful search engine. We know that real applications have
hit this, and we know even the overhead of timestamp updates on
writes is way too high for them.

> The typical user may just skip an upgrade or otherwise work around the
> problem rather than root-causing it like this, so absence of reports
> isn't conclusive.  I understand wanting to err on the side of caution.

Yup, it's a generic problem - just because we've worked around or
mitigated the most common situations it impacts performance, that
doesn't mean they work for everyone....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
