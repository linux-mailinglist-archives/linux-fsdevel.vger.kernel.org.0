Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D440EBC2CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 09:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440590AbfIXHjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 03:39:51 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41414 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438384AbfIXHjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:39:51 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A37D343D63A;
        Tue, 24 Sep 2019 17:39:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iCfQC-0000C1-Fo; Tue, 24 Sep 2019 17:39:40 +1000
Date:   Tue, 24 Sep 2019 17:39:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
Message-ID: <20190924073940.GM6636@dread.disaster.area>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
 <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=wSS0DcxVZBN270Py4OYA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:06:46PM +0300, Konstantin Khlebnikov wrote:
> On 23/09/2019 17.52, Tejun Heo wrote:
> > Hello, Konstantin.
> > 
> > On Fri, Sep 20, 2019 at 10:39:33AM +0300, Konstantin Khlebnikov wrote:
> > > With vm.dirty_write_behind 1 or 2 files are written even faster and
> > 
> > Is the faster speed reproducible?  I don't quite understand why this
> > would be.
> 
> Writing to disk simply starts earlier.

Stupid question: how is this any different to simply winding down
our dirty writeback and throttling thresholds like so:

# echo $((100 * 1000 * 1000)) > /proc/sys/vm/dirty_background_bytes

to start background writeback when there's 100MB of dirty pages in
memory, and then:

# echo $((200 * 1000 * 1000)) > /proc/sys/vm/dirty_bytes

So that writers are directly throttled at 200MB of dirty pages in
memory?

This effectively gives us global writebehind behaviour with a
100-200MB cache write burst for initial writes.

ANd, really such strict writebehind behaviour is going to cause all
sorts of unintended problesm with filesystems because there will be
adverse interactions with delayed allocation. We need a substantial
amount of dirty data to be cached for writeback for fragmentation
minimisation algorithms to be able to do their job....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
