Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED34114E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhITMw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 08:52:29 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:35813 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234203AbhITMw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:52:28 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 99603FAB81
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 13:51:00 +0100 (IST)
Received: (qmail 24957 invoked from network); 20 Sep 2021 12:51:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Sep 2021 12:51:00 -0000
Date:   Mon, 20 Sep 2021 13:50:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Message-ID: <20210920125058.GI3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <YUhztA8TmplTluyQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YUhztA8TmplTluyQ@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 12:42:44PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 20, 2021 at 09:54:31AM +0100, Mel Gorman wrote:
> > This has been lightly tested only and the testing was useless as the
> > relevant code was not executed. The workload configurations I had that
> > used to trigger these corner cases no longer work (yey?) and I'll need
> > to implement a new synthetic workload. If someone is aware of a realistic
> > workload that forces reclaim activity to the point where reclaim stalls
> > then kindly share the details.
> 
> The stereeotypical "stalling on I/O" problem is to plug in one of the
> crap USB drives you were given at a trade show and simply
> 	dd if=/dev/zero of=/dev/sdb
> 	sync
> 

The test machines are 1500KM away so plugging in a USB stick but worst
comes to the worst, I could test it on a laptop. I considered using the
IO controller but I'm not sure that would throttle background writeback.
I dismissed doing this for a few reasons though -- the dirtying should
be rate limited based on the speed of the BDI so it will not necessarily
trigger the condition. It also misses the other interesting cases --
throttling due to excessive isolation and throttling due to failing to
make progress.

I've prototyped a synthetic case that uses 4..(NR_CPUS*4) workers. 1
worker measures mmap/munmap latency. 1 worker under fio is randomly reading
files. The remaining workers are split between fio doing random write IO
on separate files and anonymous memory hogs reading large mappings every
5 seconds. The aggregate WSS is approximately totalmem*2 split between 60%
anon and 40% file-backed (40% to be 2xdirty_ratio). After a warmup period
based on the writeback speed, it runs for 5 minutes per number of workers.

The primary metric of "goodness" will be the mmap latency because it's
the smallest worker that should be able to make quick progress and I
want to see how much it is interfered with during reclaim. I'll be
graphing the throttling times to see what processes get throttled and
for how long.

I was hoping though that there was a canonical realistic case that the
FS people use to stress the paths where the allocator fails to return
memory.  While my synthetic workload *might* work to trigger the cases,
I would prefer to have something that can compare this basic approach
with anything that is more clever.

Similarly, it would be nice to have a reasonable test case that phase
changes what memory is hot while there is heavy IO in the background to
detect whether the hot WSS is being properly protected. I used to use
memcached and a heavy writer to simulate this but it's weak because there
is no phase change so it's poor at evaluating vmscan.

> You can also set up qemu to have extremely slow I/O performance:
> https://serverfault.com/questions/675704/extremely-slow-qemu-storage-performance-with-qcow2-images
> 

Similar problem to the slow USB case, it's only catching one part of the
picture except now I have to worry about differences that are related
to the VM configuration (e.g. pinning virtual CPUs to physical CPUs
and replicating topology). Fine for a functional test, not so fine for
measuring if the patch is any good performance-wise.

-- 
Mel Gorman
SUSE Labs
