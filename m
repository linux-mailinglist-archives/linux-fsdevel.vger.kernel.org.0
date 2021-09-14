Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48F740A5CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 07:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhINFOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 01:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239500AbhINFOV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 01:14:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBAB860F21;
        Tue, 14 Sep 2021 05:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631596384;
        bh=AUC88WAiX+VR+fTnlcmenz58rltr9CQ7tv88IFx/wQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtm192x0anPgl38s8NNt3Wc46OwSlcp1LPVgM7PqMhdMDKdSPFD1Q4IclJL6sBYta
         0BHtaIko7qK2PtfubiSe9GirD3MujUh3/nvebHmjtO4OdZDw1NHjwSlQiDXtJh2t9G
         kAq4V7av/nhvVE56YXW3AU6pps/ZzeUu247yxXzM=
Date:   Tue, 14 Sep 2021 07:12:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <YUAvSx42abg5S2ym@kroah.com>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-14-hch@lst.de>
 <YT7vZthsMCM1uKxm@kroah.com>
 <20210914012029.GF2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914012029.GF2361455@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:20:29AM +1000, Dave Chinner wrote:
> On Mon, Sep 13, 2021 at 08:27:50AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 13, 2021 at 07:41:21AM +0200, Christoph Hellwig wrote:
> > > Trivial conversion to the seq_file based sysfs attributes.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/xfs/xfs_stats.c | 24 +++++-------
> > >  fs/xfs/xfs_stats.h |  2 +-
> > >  fs/xfs/xfs_sysfs.c | 96 +++++++++++++++++++++++-----------------------
> > >  3 files changed, 58 insertions(+), 64 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
> > > index 20e0534a772c9..71e7a84ba0403 100644
> > > --- a/fs/xfs/xfs_stats.c
> > > +++ b/fs/xfs/xfs_stats.c
> > > @@ -16,10 +16,9 @@ static int counter_val(struct xfsstats __percpu *stats, int idx)
> > >  	return val;
> > >  }
> > >  
> > > -int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
> > > +void xfs_stats_format(struct xfsstats __percpu *stats, struct seq_file *sf)
> > >  {
> > >  	int		i, j;
> > > -	int		len = 0;
> > >  	uint64_t	xs_xstrat_bytes = 0;
> > >  	uint64_t	xs_write_bytes = 0;
> > >  	uint64_t	xs_read_bytes = 0;
> > > @@ -58,13 +57,12 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
> > >  	/* Loop over all stats groups */
> > >  
> > >  	for (i = j = 0; i < ARRAY_SIZE(xstats); i++) {
> > > -		len += scnprintf(buf + len, PATH_MAX - len, "%s",
> > > -				xstats[i].desc);
> > > +		seq_printf(sf, "%s", xstats[i].desc);
> > > +
> > >  		/* inner loop does each group */
> > >  		for (; j < xstats[i].endpoint; j++)
> > > -			len += scnprintf(buf + len, PATH_MAX - len, " %u",
> > > -					counter_val(stats, j));
> > > -		len += scnprintf(buf + len, PATH_MAX - len, "\n");
> > > +			seq_printf(sf, " %u", counter_val(stats, j));
> > > +		seq_printf(sf, "\n");
> > >  	}
> > >  	/* extra precision counters */
> > >  	for_each_possible_cpu(i) {
> > > @@ -74,18 +72,14 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
> > >  		defer_relog += per_cpu_ptr(stats, i)->s.defer_relog;
> > >  	}
> > >  
> > > -	len += scnprintf(buf + len, PATH_MAX-len, "xpc %Lu %Lu %Lu\n",
> > > +	seq_printf(sf, "xpc %Lu %Lu %Lu\n",
> > >  			xs_xstrat_bytes, xs_write_bytes, xs_read_bytes);
> > > -	len += scnprintf(buf + len, PATH_MAX-len, "defer_relog %llu\n",
> > > -			defer_relog);
> > > -	len += scnprintf(buf + len, PATH_MAX-len, "debug %u\n",
> > > +	seq_printf(sf, "defer_relog %llu\n", defer_relog);
> > >  #if defined(DEBUG)
> > > -		1);
> > > +	seq_printf(sf, "debug 1\n");
> > >  #else
> > > -		0);
> > > +	seq_printf(sf, "debug 0\n");
> > >  #endif
> > > -
> > > -	return len;
> > >  }
> > 
> > That is a sysfs file?  What happened to the "one value per file" rule
> > here?
> 
> 
> There is no "rule" that says syfs files must contain one value per
> file; the documentation says that one value per file is the
> "preferred" format.  Documentation/filesystems/sysfs.rst:
> 
> [...]
> Attributes
> ...
> Attributes should be ASCII text files, preferably with only one value
> per file. It is noted that it may not be efficient to contain only one
> value per file, so it is socially acceptable to express an array of
> values of the same type.
> [...]
> 

An array of values is one thing like "what is the power states for this
device".  A list of different key/value pairs is a totally different
thing entirely.

> We are exposing a large array of integer values here, so multiple
> values per file are explicitly considered an acceptible format.

Not really, that was not the goal of sysfs at all.

> Further, as there are roughly 200 individual stats in this file and
> calculating each stat requires per-cpu aggregation, the the cost of
> calculating and reading each stat individually is prohibitive, not
> just inefficient.

Have you measured it?  How often does the file get read and by what
tools?

We have learned from our past mistakes in /proc where we did this in the
past and required keeping obsolete values and constantly tweaking
userspace parsers.  That is why we made sysfs one-value-per-file.  If
the file is not there, the value is not there, much easier to handle
future changes.

> So, yes, we might have multiple lines in the file that you can frown
> about, but OTOH the file format has been exposed as a kernel ABI for
> a couple of decades via /proc/fs/xfs/stat.

proc had no such rules, but we have learned :)

> Hence exposing it in
> sysfs to provide a more fine-grained breakdown of the stats (per
> mount instead of global) is a no-brainer. We don't have to rewrite
> the parsing engines in multiple userspace monitoring programs to
> extract this information from the kernel - they just create a new
> instance and read a different file and it all just works.

But then you run into the max size restriction on sysfs files
(PAGE_SIZE) and things break down.

Please don't do this.

> Indeed, there's precedence for such /proc file formats in more
> fine-grained sysfs files. e.g.  /sys/bus/node/devices/node<n>/vmstat
> and /sys/bus/node/devices/node<n>/meminfo retain the same format
> (and hence userspace parsers) for the per-node stats as /proc/vmstat
> and /proc/meminfo use for the global stats...

And I have complained about those files in the past many times.  And
they are running into problems in places dealing with them too.

> tl;dr: the file contains arrays of values, it's inefficient to read
> values one at a time, it's a pre-existing ABI-constrainted file
> format, there's precedence in core kernel statistics
> implementations and the documented guidelines allow this sort of
> usage in these cases.

I would prefer not to do this, and I will not take core sysfs changes to
make this any easier.

Which is one big reason why I don't like just making sysfs use the seq
file api, it would allow stuff like this to propagate to other places in
the kernel.

Maybe I should cut the file size of a sysfs file down to PAGE_SIZE/4 or
less, that might be better :)

thanks,

greg k-h
