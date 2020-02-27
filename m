Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD56172B92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 23:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgB0Wjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 17:39:54 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50979 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729722AbgB0Wjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:39:54 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 34B677EA9D0;
        Fri, 28 Feb 2020 09:39:47 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j7Ron-0004eO-8O; Fri, 28 Feb 2020 09:39:45 +1100
Date:   Fri, 28 Feb 2020 09:39:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200227223945.GN10737@dread.disaster.area>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <0e5124a2-d730-5c41-38fd-2c78d9be4940@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e5124a2-d730-5c41-38fd-2c78d9be4940@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=5xOlfOR4AAAA:8 a=z2cq81k1AAAA:20 a=7-415B0cAAAA:8
        a=mlMlIRDalk7ZbqZ7_3gA:9 a=bReWesNirA5XSw2M:21 a=cHR_8xpGokDfY6ir:21
        a=CjuIK1q_8ugA:10 a=SGlsW6VomvECssOqsvzv:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:04:40AM -0800, Eric Sandeen wrote:
> On 2/26/20 8:29 AM, Matthew Wilcox wrote:
> > On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
> >> A new sysctl parameter "dentry-dir-max" is introduced which accepts a
> >> value of 0 (default) for no limit or a positive integer 256 and up. Small
> >> dentry-dir-max numbers are forbidden to avoid excessive dentry count
> >> checking which can impact system performance.
> > 
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
> 
> There are pitfalls to this approach as well.  Consider what libnss
> does every time it starts up (via curl in this case)
> 
> # cat /proc/sys/fs/dentry-state
> 3154271	3131421	45	0	2863333	0
> # for I in `seq 1 10`; do curl https://sandeen.net/ &>/dev/null; done
> # cat /proc/sys/fs/dentry-state
> 3170738	3147844	45	0	2879882	0
> 
> voila, 16k more negative dcache entries, thanks to:
> 
> https://github.com/nss-dev/nss/blob/317cb06697d5b953d825e050c1d8c1ee0d647010/lib/softoken/sdb.c#L390
> 
> i.e. each time it inits, it will intentionally create up to 10,000 negative
> dentries which will never be looked up again.

Sandboxing via memcg restricted cgroups means users and/or
applications cannot create unbound numbers of negative dentries, and
that largely solves this problem.

For a system daemons whose environment is controlled by a
systemd unit file, this should be pretty trivial to do, and memcg
directed memory reclaim will control negative dentry buildup.

For short-lived applications, teardown of the cgroup will free
all the negative dentries it created - they don't hang around
forever.

For long lived applications, negative dentries are bound by the
application memcg limits, and buildup will only affect the
applications own performance, not that of the whole system.

IOWs, I'd expect this sort of resource control problem to be solved
at the user, application and/or distro level, not with a huge kernel
hammer.

> I /think/ the original intent of this work was to limit such rogue
> applications, so scaling with use probably isn't the way to go.

The original intent was to prevent problems on old kernels that
supported terabytes of memory but could not use cgroup/memcg
infrastructure to isolate and contain negative dentry growth.
That was a much simpler, targeted negative dentry limiting solution,
not the ... craziness that can be found in this patchset.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
