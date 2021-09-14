Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55ED40A266
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 03:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhINBVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 21:21:54 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:49441 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhINBVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:21:53 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 3CFD9ECB25A;
        Tue, 14 Sep 2021 11:20:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mPx7d-00CCJV-0Z; Tue, 14 Sep 2021 11:20:29 +1000
Date:   Tue, 14 Sep 2021 11:20:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <20210914012029.GF2361455@dread.disaster.area>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-14-hch@lst.de>
 <YT7vZthsMCM1uKxm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT7vZthsMCM1uKxm@kroah.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=hM_N2pAvqWJ6tqKoahEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:27:50AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 13, 2021 at 07:41:21AM +0200, Christoph Hellwig wrote:
> > Trivial conversion to the seq_file based sysfs attributes.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/xfs/xfs_stats.c | 24 +++++-------
> >  fs/xfs/xfs_stats.h |  2 +-
> >  fs/xfs/xfs_sysfs.c | 96 +++++++++++++++++++++++-----------------------
> >  3 files changed, 58 insertions(+), 64 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
> > index 20e0534a772c9..71e7a84ba0403 100644
> > --- a/fs/xfs/xfs_stats.c
> > +++ b/fs/xfs/xfs_stats.c
> > @@ -16,10 +16,9 @@ static int counter_val(struct xfsstats __percpu *stats, int idx)
> >  	return val;
> >  }
> >  
> > -int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
> > +void xfs_stats_format(struct xfsstats __percpu *stats, struct seq_file *sf)
> >  {
> >  	int		i, j;
> > -	int		len = 0;
> >  	uint64_t	xs_xstrat_bytes = 0;
> >  	uint64_t	xs_write_bytes = 0;
> >  	uint64_t	xs_read_bytes = 0;
> > @@ -58,13 +57,12 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
> >  	/* Loop over all stats groups */
> >  
> >  	for (i = j = 0; i < ARRAY_SIZE(xstats); i++) {
> > -		len += scnprintf(buf + len, PATH_MAX - len, "%s",
> > -				xstats[i].desc);
> > +		seq_printf(sf, "%s", xstats[i].desc);
> > +
> >  		/* inner loop does each group */
> >  		for (; j < xstats[i].endpoint; j++)
> > -			len += scnprintf(buf + len, PATH_MAX - len, " %u",
> > -					counter_val(stats, j));
> > -		len += scnprintf(buf + len, PATH_MAX - len, "\n");
> > +			seq_printf(sf, " %u", counter_val(stats, j));
> > +		seq_printf(sf, "\n");
> >  	}
> >  	/* extra precision counters */
> >  	for_each_possible_cpu(i) {
> > @@ -74,18 +72,14 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
> >  		defer_relog += per_cpu_ptr(stats, i)->s.defer_relog;
> >  	}
> >  
> > -	len += scnprintf(buf + len, PATH_MAX-len, "xpc %Lu %Lu %Lu\n",
> > +	seq_printf(sf, "xpc %Lu %Lu %Lu\n",
> >  			xs_xstrat_bytes, xs_write_bytes, xs_read_bytes);
> > -	len += scnprintf(buf + len, PATH_MAX-len, "defer_relog %llu\n",
> > -			defer_relog);
> > -	len += scnprintf(buf + len, PATH_MAX-len, "debug %u\n",
> > +	seq_printf(sf, "defer_relog %llu\n", defer_relog);
> >  #if defined(DEBUG)
> > -		1);
> > +	seq_printf(sf, "debug 1\n");
> >  #else
> > -		0);
> > +	seq_printf(sf, "debug 0\n");
> >  #endif
> > -
> > -	return len;
> >  }
> 
> That is a sysfs file?  What happened to the "one value per file" rule
> here?


There is no "rule" that says syfs files must contain one value per
file; the documentation says that one value per file is the
"preferred" format.  Documentation/filesystems/sysfs.rst:

[...]
Attributes
...
Attributes should be ASCII text files, preferably with only one value
per file. It is noted that it may not be efficient to contain only one
value per file, so it is socially acceptable to express an array of
values of the same type.
[...]

We are exposing a large array of integer values here, so multiple
values per file are explicitly considered an acceptible format.
Further, as there are roughly 200 individual stats in this file and
calculating each stat requires per-cpu aggregation, the the cost of
calculating and reading each stat individually is prohibitive, not
just inefficient.

So, yes, we might have multiple lines in the file that you can frown
about, but OTOH the file format has been exposed as a kernel ABI for
a couple of decades via /proc/fs/xfs/stat. Hence exposing it in
sysfs to provide a more fine-grained breakdown of the stats (per
mount instead of global) is a no-brainer. We don't have to rewrite
the parsing engines in multiple userspace monitoring programs to
extract this information from the kernel - they just create a new
instance and read a different file and it all just works.

Indeed, there's precedence for such /proc file formats in more
fine-grained sysfs files. e.g.  /sys/bus/node/devices/node<n>/vmstat
and /sys/bus/node/devices/node<n>/meminfo retain the same format
(and hence userspace parsers) for the per-node stats as /proc/vmstat
and /proc/meminfo use for the global stats...

tl;dr: the file contains arrays of values, it's inefficient to read
values one at a time, it's a pre-existing ABI-constrainted file
format, there's precedence in core kernel statistics
implementations and the documented guidelines allow this sort of
usage in these cases.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
