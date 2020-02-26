Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D217045D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgBZQ36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:29:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQ36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f1bv7k+aR95JLaRnibgjh33tWs/5T1jZciQ/wlmBMxs=; b=drlUX7Cthr4H9sggJz4h6/3Y5G
        mo/5uBnR1hfM10WWin7v8ZrcDr7KIs1mpcF6JYjbDP8axE8K12+2yE1dRgEoe0JkNdBVR6konO36L
        v3FvtY2daDQI3Gxc6w0U1zAJaYE5qtmKV9inPLcETf2TyHgRdeS9kfssNNk9mpuPmtIEmOX0yrQIQ
        yG1PVIGbktpGvcMbun68CEcwUVIut75rKPT3wx1/X5WQiCz0SF/+G0iN43AS5VQqvGKzrN33qoWRY
        uCiTaJkuWH3Ve0ffsRDJDWjzD68U4huwGUTkXyUiK713MvpoLADsSp5G/y3jyvL0y2l36IORoC94R
        FUg4DiEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6zZK-0008I8-Rs; Wed, 26 Feb 2020 16:29:54 +0000
Date:   Wed, 26 Feb 2020 08:29:54 -0800
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
Message-ID: <20200226162954.GC24185@bombadil.infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
> A new sysctl parameter "dentry-dir-max" is introduced which accepts a
> value of 0 (default) for no limit or a positive integer 256 and up. Small
> dentry-dir-max numbers are forbidden to avoid excessive dentry count
> checking which can impact system performance.

This is always the wrong approach.  A sysctl is just a way of blaming
the sysadmin for us not being very good at programming.

I agree that we need a way to limit the number of negative dentries.
But that limit needs to be dynamic and depend on how the system is being
used, not on how some overworked sysadmin has configured it.

So we need an initial estimate for the number of negative dentries that
we need for good performance.  Maybe it's 1000.  It doesn't really matter;
it's going to change dynamically.

Then we need a metric to let us know whether it needs to be increased.
Perhaps that's "number of new negative dentries created in the last
second".  And we need to decide how much to increase it; maybe it's by
50% or maybe by 10%.  Perhaps somewhere between 10-100% depending on
how high the recent rate of negative dentry creation has been.

We also need a metric to let us know whether it needs to be decreased.
I'm reluctant to say that memory pressure should be that metric because
very large systems can let the number of dentries grow in an unbounded
way.  Perhaps that metric is "number of hits in the negative dentry
cache in the last ten seconds".  Again, we'll need to decide how much
to shrink the target number by.

If the number of negative dentries is at or above the target, then
creating a new negative dentry means evicting an existing negative dentry.
If the number of negative dentries is lower than the target, then we
can just create a new one.

Of course, memory pressure (and shrinking the target number) should
cause negative dentries to be evicted from the old end of the LRU list.
But memory pressure shouldn't cause us to change the target number;
the target number is what we think we need to keep the system running
smoothly.
