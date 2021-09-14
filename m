Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7F40AC1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhINK5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 06:57:47 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:37055 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231667AbhINK5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:57:44 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 1E48A106CD1;
        Tue, 14 Sep 2021 20:56:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mQ66x-00CLor-TA; Tue, 14 Sep 2021 20:56:23 +1000
Date:   Tue, 14 Sep 2021 20:56:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <20210914105623.GK2361455@dread.disaster.area>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-14-hch@lst.de>
 <YT7vZthsMCM1uKxm@kroah.com>
 <20210914012029.GF2361455@dread.disaster.area>
 <YUAvSx42abg5S2ym@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUAvSx42abg5S2ym@kroah.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=vTDO8LzAJrJoscva19kA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 07:12:43AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 14, 2021 at 11:20:29AM +1000, Dave Chinner wrote:
> > On Mon, Sep 13, 2021 at 08:27:50AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Sep 13, 2021 at 07:41:21AM +0200, Christoph Hellwig wrote:
> > > That is a sysfs file?  What happened to the "one value per file" rule
> > > here?
> > 
> > 
> > There is no "rule" that says syfs files must contain one value per
> > file; the documentation says that one value per file is the
> > "preferred" format.  Documentation/filesystems/sysfs.rst:
> > 
> > [...]
> > Attributes
> > ...
> > Attributes should be ASCII text files, preferably with only one value
> > per file. It is noted that it may not be efficient to contain only one
> > value per file, so it is socially acceptable to express an array of
> > values of the same type.
> > [...]
> > 
> 
> An array of values is one thing like "what is the power states for this
> device".  A list of different key/value pairs is a totally different
> thing entirely.

Sure, that's your opinion. Nothing more, nothing less. I could
easily argue that "what power states does this thing have" is a
list and not an array, but this would be just another opinion and
completely beside the point of the discussion.

> > We are exposing a large array of integer values here, so multiple
> > values per file are explicitly considered an acceptible format.
> 
> Not really, that was not the goal of sysfs at all.

Sure. We all know this and we follow the guidelines in most cases.
Indeed, every other sysfs file that XFS exposes is a value-per-file
object. This makes sense for most things we expose through sysfs,

Not everything maps to value-per-file cleanly or efficiently and the
documentation acknowledges that there are alternative use cases for
sysfs files like this. Just because you don't like it doesn't mean
there aren't cases where multiple values per file is the best thing
to do.

Blind obedience to rules almost always results in poor outcomes.

> > Further, as there are roughly 200 individual stats in this file and
> > calculating each stat requires per-cpu aggregation, the the cost of
> > calculating and reading each stat individually is prohibitive, not
> > just inefficient.
> 
> Have you measured it?  How often does the file get read and by what
> tools?

Of course I've measured it. I sample and graph hundreds of stats in
realtime at 10-20Hz across multiple machines as part of my daily
development routine with PCP?  I see the overhead of reading stats
out of the kernel in kernel profiles and dropped samples in recorded
archives all the time.

For example, reading the global XFS stats at 20Hz via pmcd/pmdaxfs
during testing on a 32p machine results in xfs_stats_format()
consuming about 1% of a CPU.  From the flat perf top profile:

0.93  [kernel]  [k] xfs_stats_format

That's typical high frequency sampling overhead of a single
filesystem being actively used.

Note that micro-benchmarks give highly unrealistic results. If I pin
a cpu in a tight loop doing like this:

       for (i = 0; i < cnt; i++) {
                fd = open("/sys/fs/xfs/stats/stats", O_RDONLY);
                read(fd, buf, 4096);
                close(fd);
       }

It gives an number of 20,000 reads a second, with 90% of teh CPU
usage being in xfs_stats_format(). This is unrealistic because it is
hitting hot, clean caches and doing absolutely nothing with the data
that is returned.

Userspace needs to do work with the data, and that is as least as
much CPU overhead as formatting the stats to turn them back into
proper integer values and dumping them into a shared memory segment
for another process to collate before it can read more data from the
kernel (the underlying PCP userspace architecture). So,
realistically, sampling from 5,000 XFS stats files per CPU per
second from userspace on a 32p machine is about the max rate we can
reliably sustain on a single CPU.

The biggest cost is the read() cost (open/close is less than 10% of
the cost of the above loop), and the flat profile shows:

	27.47%  [k] xfs_stats_format
	16.11%  [k] _find_next_bit
	11.11%  [k] cpumask_next
	 4.36%  [k] vsnprintf
	 4.07%  [k] format_decode
	 3.99%  [k] number

70% of the "cpu usage" of xfs_stats_format() is the L1 cacheline
miss in the for_each_possible_cpu() loop reading the percpu stats
values.  That's despite the cachelines being clean and likely hot in
other larger local CPU caches.  The percpu loop also accounts for
the cpumask_next() CPU usage, and the _find_next_bit CPU usage comes
from cpumask_next() calling it.

IOWs, about half of the kernel CPU usage reading the XFS stats in a
tight loop on a 32p machine comes from the per-cpu aggregation
overhead. That aggregation overhead will be the overall limiting
factor for XFS stats sampling.

With 100 filesystems we could, in theory, sample them all at about
50Hz if we're doing nothing else with that CPU.  But the data set
size we are reading has gone up by a factor of 100, and the stats
data is not going to be hot in CPU caches anymore (neither in the
kernel or userspace).  Per-cpu aggregation will also hit dirty
remote cachelines on active systems, so it's *much* slower than the
above loop would indicate. The original profile indicates maybe 20Hz
is acheivable, not 50Hz.

With this in mind, we then have to consider the overhead on machines
with thousands of CPUs rather than a few tens of CPUs. The cost of
per-cpu aggregation on those machines is a couple of magnitudes
higher than these machines (aggregation overhead increases linearly
with CPU count), so if we are burning the same amount of CPU time
doing aggregation, then the number of times we can aggregate the
stats goes down by a couple of orders of magnitude.  That's the
behavioural characteristics that we have to design for, not what my
tiny little 32p system can do.

IOWs, our "all stats in one file" setup on a system with a hundred
filesystems and a thousand CPUs can currently manage (roughly) a 1Hz
sampling rate on all filesystems using a single CPU and the existing
"all stats in one file" setup.

Now, let's put that in a value-per-file setup.

This means we have to read 200 individual files per filesystem to
build the entire sample set. This means we do 200 per-cpu
aggregations instead of 1 for this sample set. Given that the
majority of overhead is the per-cpu aggregation, the filesystem
stats set takes 100-200x longer to sample than a "all in one file"
setup.

IOWs, a sample set for a *single* filesystem on a 1000 CPU machine
now takes 1-2s to complete.  At 100 filesystems, we now take
100-200s of CPU time to sample all the filesystem stats once. That's
a massive amount of extra overhead, and simply not acceptible nor
necessary. 

To compound the regression caused by moving to a value per file, we
then have to spend another whole chunk of engineering work to
mitigate it. We'd have to completely rewrite the stats aggregation
code and we'd probably end up losing high frequency aggregation
capabilities as a result.

This is a lose-lose-lose-lose scenario, and no one in their right
mind would consider a viable way forward. The "efficiency exception"
in the documentation was intended for exactly this sort of
situation. So, really it doesn't make what you like or not, it's the
only viable solution we currently have.

> We have learned from our past mistakes in /proc where we did this in the
> past and required keeping obsolete values and constantly tweaking
> userspace parsers.  That is why we made sysfs one-value-per-file.  If
> the file is not there, the value is not there, much easier to handle
> future changes.

We've had rules for extending the xfs stats file to avoid breaking
the userspace parsers for a couple of decades, too. There are some
advantages to value-per-file when it comes to deprecation, but
really that's not a problem we need to solve for the XFS stats.

> > So, yes, we might have multiple lines in the file that you can frown
> > about, but OTOH the file format has been exposed as a kernel ABI for
> > a couple of decades via /proc/fs/xfs/stat.
> 
> proc had no such rules, but we have learned :)

And so now you know better than everyone else. :/

> > Hence exposing it in
> > sysfs to provide a more fine-grained breakdown of the stats (per
> > mount instead of global) is a no-brainer. We don't have to rewrite
> > the parsing engines in multiple userspace monitoring programs to
> > extract this information from the kernel - they just create a new
> > instance and read a different file and it all just works.
> 
> But then you run into the max size restriction on sysfs files
> (PAGE_SIZE) and things break down.

Yup, but we're nowhere near the max size restriction. Output
currently requires 12 bytes per stat maximum, so we're still
good to add another 100-150 or so stats before we have to worry
about PAGE_SIZE limits...

> Please don't do this.

Please don't take us for idiots - you know full well that the ABI
horse bolted long ago and we don't break userspace like this.

If you've got a more efficient generic way of exporting large
volumes of dynamically instanced stats arrays at high frequency than
what we do right now, then I'm all ears. But if all you are going to
say is "I say you can't do that" then you're not being helpful or
constructive.

> > Indeed, there's precedence for such /proc file formats in more
> > fine-grained sysfs files. e.g.  /sys/bus/node/devices/node<n>/vmstat
> > and /sys/bus/node/devices/node<n>/meminfo retain the same format
> > (and hence userspace parsers) for the per-node stats as /proc/vmstat
> > and /proc/meminfo use for the global stats...
> 
> And I have complained about those files in the past many times.  And
> they are running into problems in places dealing with them too.

So come up with a generic, scalable, low overhead solution to the
stats export problem, convert all the kernel code and userspace
applications to use it, address all the regressions on large CPU
count machines it causes, start a long term deprecation period for
the existing stats files (because it's part of the kernel ABI), and
then maybe in 10 or 15 years time we can get rid of this stuff.

> > tl;dr: the file contains arrays of values, it's inefficient to read
> > values one at a time, it's a pre-existing ABI-constrainted file
> > format, there's precedence in core kernel statistics
> > implementations and the documented guidelines allow this sort of
> > usage in these cases.
> 
> I would prefer not to do this, and I will not take core sysfs changes to
> make this any easier.
> 
> Which is one big reason why I don't like just making sysfs use the seq
> file api, it would allow stuff like this to propagate to other places in
> the kernel.
>
> Maybe I should cut the file size of a sysfs file down to PAGE_SIZE/4 or
> less, that might be better :)

Yeah, good on yah, Greg. That'll show everyone who's boss, won't it?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
