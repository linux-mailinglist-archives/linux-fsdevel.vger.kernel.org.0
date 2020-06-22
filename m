Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40F2042A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgFVV0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 17:26:14 -0400
Received: from fieldses.org ([173.255.197.46]:51546 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbgFVV0N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:26:13 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 82FC93EB; Mon, 22 Jun 2020 17:26:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 82FC93EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592861172;
        bh=Czca7QW8KGtHkb/Q7ULTwRFUj30LwsBIzvGyIo0BmgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLXq9kejL/ER77z3lLgkzPPp/WwWi+6NqDkn9ImUU5/OqyWFmTWtfNdkqk1gH56Zv
         KdyHbIr6Kswhs7USTEwF0BuVujcoGqpsDOOCsW0xiW5Mg1BCVPEbwAGRkHcxyJCDwn
         0sXccFgWAgm/hmkZ6ezAvgqlE8TtggUtGQwA3h1c=
Date:   Mon, 22 Jun 2020 17:26:12 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20200622212612.GA11051@fieldses.org>
References: <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
 <20200619024455.GN2005@dread.disaster.area>
 <20200619204033.GB1564@fieldses.org>
 <20200619221044.GO2005@dread.disaster.area>
 <20200619222843.GB2650@fieldses.org>
 <20200620014957.GQ2005@dread.disaster.area>
 <20200620015633.GA1516@fieldses.org>
 <20200620235408.GS2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620235408.GS2005@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 21, 2020 at 09:54:08AM +1000, Dave Chinner wrote:
> On Fri, Jun 19, 2020 at 09:56:33PM -0400, J. Bruce Fields wrote:
> > On Sat, Jun 20, 2020 at 11:49:57AM +1000, Dave Chinner wrote:
> > > However, other people have different opinions on this matter (and we
> > > know that from the people who considered XFS v4 -> v5 going slower
> > > because iversion a major regression), and so we must acknowledge
> > > those opinions even if we don't agree with them.
> > 
> > Do you have any of those reports handy?  Were there numbers?
> 
> e.g.  RH BZ #1355813 when v5 format was enabled by default in RHEL7.
> Numbers were 40-47% performance degradation for in-cache writes
> caused by the original IVERSION implementation using iozone.  There
> were others I recall, all realted to similar high-IOP small random
> writes workloads typical of databases....

Thanks, that's an interesting bug!  Though a bit tangled.  This is where
you identified the change attribute as the main culprit:

	https://bugzilla.redhat.com/show_bug.cgi?id=1355813#c42

	The test was running at 70,000 writes/s (2.2GB/s), so it was one
	transaction per write() syscall: timestamp updates. On CRC
	enabled filesystems, we have a change counter for NFSv4 - it
	gets incremented on every write() syscall, even when the
	timestamp doesn't change. That's the difference in behaviour and
	hence performance in this test.

In RHEL8, or anything post-v4.16, the frequency of change attribute
updates should be back down to that of timestamp updates on this
workload.  So it'd be interesting to repeat that experiment now.

The bug was reporting in-house testing, and doesn't show any evidence
that particular regression was encountered by users; Eric said:

	https://bugzilla.redhat.com/show_bug.cgi?id=1355813#c52

	Root cause of this minor in-memory regression was inode
	versioning behavior; as it's unlikely to have real-world effects
	(and has been open for years with no customer complaints) I'm
	closing this WONTFIX to get it off the radar.

The typical user may just skip an upgrade or otherwise work around the
problem rather than root-causing it like this, so absence of reports
isn't conclusive.  I understand wanting to err on the side of caution.

But if that regression's mostly addressed now, then I'm still inclined
to think it's time to just leave this on everywhere.

--b.
