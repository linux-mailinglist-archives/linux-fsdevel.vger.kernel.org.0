Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F2170A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 22:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgBZV2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 16:28:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgBZV2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=22L8bPAzmVdqd1/KzktzA8ztx8DTFzR2iF/v1VHlqz0=; b=u6Qf/0KanA1Wckx/r3ajANog91
        t5mZB2hlR9hC2xHkmV++USC/1wp3rDkQYzFUFm2S3AS2EJX6dfnlOZUsfIw+1oRq3cNPIjuPXOLux
        7b2bZbJzarW5uB37Hi4mqqbHwyFYRsVKnRX18yd3J0/NHuQyy+n4qkS4r4QsC5oxLy0hdqqq+12Yy
        ZJdtVw9lBdWCJYgZzef+VkdDaLswl7mFZvX0aI/+lS85GS6VUgpfUwkaRxSWn1BvJaCYxywjlCCaJ
        NAn1li//Sw89TsCek1PIeAymwqppl7jRajU8kgUZ5AIDFFrrtZdnh6ZEQ2Jm42vgULqfCUXzUob6Z
        6if60eOg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j74EW-0006tG-S4; Wed, 26 Feb 2020 21:28:44 +0000
Date:   Wed, 26 Feb 2020 13:28:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200226212844.GD24185@bombadil.infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <12e8d951-fc35-bce0-e96d-f93bccf2bd3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e8d951-fc35-bce0-e96d-f93bccf2bd3a@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 02:19:59PM -0500, Waiman Long wrote:
> On 2/26/20 11:29 AM, Matthew Wilcox wrote:
> > On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
> >> A new sysctl parameter "dentry-dir-max" is introduced which accepts a
> >> value of 0 (default) for no limit or a positive integer 256 and up. Small
> >> dentry-dir-max numbers are forbidden to avoid excessive dentry count
> >> checking which can impact system performance.
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
> >
> > If the number of negative dentries is at or above the target, then
> > creating a new negative dentry means evicting an existing negative dentry.
> > If the number of negative dentries is lower than the target, then we
> > can just create a new one.
> >
> > Of course, memory pressure (and shrinking the target number) should
> > cause negative dentries to be evicted from the old end of the LRU list.
> > But memory pressure shouldn't cause us to change the target number;
> > the target number is what we think we need to keep the system running
> > smoothly.
> >
> Thanks for the quick response.
> 
> I agree that auto-tuning so that the system administrator don't have to
> worry about it will be the best approach if it is implemented in the
> right way. However, it is hard to do it right.
> 
> How about letting users specify a cap on the amount of total system
> memory allowed for negative dentries like one of my previous patchs.
> Internally, there is a predefined minimum and maximum for
> dentry-dir-max. We sample the total negative dentry counts periodically
> and adjust the dentry-dir-max accordingly.
> 
> Specifying a percentage of total system memory is more intuitive than
> just specifying a hard number for dentry-dir-max. Still some user input
> is required.

If you want to base the whole thing on a per-directory target number,
or a percentage of the system memory target (rather than my suggestion
of a total # of negative dentries), that seems reasonable.  What's not
reasonable is expecting the sysadmin to be able to either predict the
workload, or react to a changing workload in sufficient time.  The system
has to be self-tuning.

Just look how long stale information stays around about how to tune your
Linux system.  Here's an article from 2018 suggesting using the 'intr'
option for NFS mounts:
https://kb.netapp.com/app/answers/answer_view/a_id/1004893/~/hard-mount-vs-soft-mount-
I made that a no-op in 2007.  Any tunable you add to Linux immediately
becomes a cargo-cult solution to any problem people are having.
