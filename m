Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB2170AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBZVpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 16:45:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgBZVpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k6oH184LauRBVJdRIuJcmV3mqSTA26eIXnPYJkT2OvQ=; b=CjYhAjxrA/A37pJzouv5n85kWT
        1yaLOAd0gG+1S+uXClxIWNgGhsBnfuTWKdcx52dwsO3loQQiadMvQ5FlT+iuBYW1qPBUWWeF8Bylg
        9+cGS+GxvS8wjVdkDbguTcUTmP/QYr/UX0Kg+Wck4rcIKlYuJDn2qtrInDKXWtphpWsfNCVMTmFMu
        /P9PUMSfZqMYQEPeQaWWqwclke1h62ZReejsvITeTLrwyyztnX4c5rbPuq1TzzUrkThQptAn6abXb
        etrM9YdjIW6yft90f7I9M4GGQGb1zt5WDXhwZWVfK8kt/0+9RN+QW5OkXvJK8O7PbIi96BsbCnNce
        m2K7Xixg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j74UN-0005gs-Iv; Wed, 26 Feb 2020 21:45:07 +0000
Date:   Wed, 26 Feb 2020 13:45:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200226214507.GE24185@bombadil.infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 02:28:50PM -0700, Andreas Dilger wrote:
> On Feb 26, 2020, at 9:29 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > This is always the wrong approach.  A sysctl is just a way of blaming
> > the sysadmin for us not being very good at programming.
> > 
> > I agree that we need a way to limit the number of negative dentries.
> > But that limit needs to be dynamic and depend on how the system is being
> > used, not on how some overworked sysadmin has configured it.
> > 
> > So we need an initial estimate for the number of negative dentries that
> > we need for good performance.  Maybe it's 1000.  It doesn't really matter;
> > it's going to change dynamically.
> > 
> > Then we need a metric to let us know whether it needs to be increased.
> > Perhaps that's "number of new negative dentries created in the last
> > second".  And we need to decide how much to increase it; maybe it's by
> > 50% or maybe by 10%.  Perhaps somewhere between 10-100% depending on
> > how high the recent rate of negative dentry creation has been.
> > 
> > We also need a metric to let us know whether it needs to be decreased.
> > I'm reluctant to say that memory pressure should be that metric because
> > very large systems can let the number of dentries grow in an unbounded
> > way.  Perhaps that metric is "number of hits in the negative dentry
> > cache in the last ten seconds".  Again, we'll need to decide how much
> > to shrink the target number by.
> 
> OK, so now instead of a single tunable parameter we need three, because
> these numbers are totally made up and nobody knows the right values. :-)
> Defaulting the limit to "disabled/no limit" also has the problem that
> 99.99% of users won't even know this tunable exists, let alone how to
> set it correctly, so they will continue to see these problems, and the
> code may as well not exist (i.e. pure overhead), while Waiman has a
> better idea today of what would be reasonable defaults.

I never said "no limit".  I just said to start at some fairly random
value and not worry about where you start because it'll correct to where
this system needs it to be.  As long as it converges like loadavg does,
it'll be fine.  It needs a fairly large "don't change the target" area,
and it needs to react quickly to real changes in a system's workload.

> I definitely agree that a single fixed value will be wrong for every
> system except the original developer's.  Making the maximum default to
> some reasonable fraction of the system size, rather than a fixed value,
> is probably best to start.  Something like this as a starting point:
> 
> 	/* Allow a reasonable minimum number of negative entries,
> 	 * but proportionately more if the directory/dcache is large.
> 	 */
> 	dir_negative_max = max(num_dir_entries / 16, 1024);
>         total_negative_max = max(totalram_pages / 32, total_dentries / 8);

Those kinds of things are garbage on large machines.  With a terabyte
of RAM, you can end up with tens of millions of dentries clogging up
the system.  There _is_ an upper limit on the useful number of dentries
to keep around.

> (Waiman should decide actual values based on where the problem was hit
> previously), and include tunables to change the limits for testing.
> 
> Ideally there would also be a dir ioctl that allows fetching the current
> positive/negative entry count on a directory (e.g. /usr/bin, /usr/lib64,
> /usr/share/man/man*) to see what these values are.  Otherwise there is
> no way to determine whether the limits used are any good or not.

It definitely needs to be instrumented for testing, but no, not ioctls.
tracepoints, perhaps.

> Dynamic limits are hard to get right, and incorrect state machines can lead
> to wild swings in behaviour due to unexpected feedback.  It isn't clear to
> me that adjusting the limit based on the current rate of negative dentry
> creation even makes sense.  If there are a lot of negative entries being
> created, that is when you'd want to _stop_ allowing more to be added.

That doesn't make sense.  What you really want to know is "If my dcache
had twice as many entries in it, would that significantly reduce the
thrash of new entries being created".  In the page cache, we end up
with a double LRU where once-used entries fall off the list quickly
but twice-or-more used entries get to stay around for a bit longer.
Maybe we could do something like that; keep a victim cache for recently
evicted dentries, and if we get a large hit rate in the victim cache,
expand the size of the primary cache.


