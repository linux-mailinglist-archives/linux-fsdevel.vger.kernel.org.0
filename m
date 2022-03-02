Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06A84CB110
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245338AbiCBVPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 16:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245340AbiCBVO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:14:57 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DC3115A13;
        Wed,  2 Mar 2022 13:12:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 36C13534859;
        Thu,  3 Mar 2022 08:12:27 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nPWGo-000lxc-Vj; Thu, 03 Mar 2022 08:12:27 +1100
Date:   Thu, 3 Mar 2022 08:12:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] Generic per-sb io stats
Message-ID: <20220302211226.GG3927073@dread.disaster.area>
References: <20220301184221.371853-1-amir73il@gmail.com>
 <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=621fddbd
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=ckS1yfGm2Iay7nX_clAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:59:51PM +0200, Amir Goldstein wrote:
> On Wed, Mar 2, 2022 at 10:27 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Mar 02, 2022 at 09:43:50AM +0200, Amir Goldstein wrote:
> > > On Wed, Mar 2, 2022 at 8:59 AM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Tue, Mar 01, 2022 at 08:42:15PM +0200, Amir Goldstein wrote:
> > > > > Miklos,
> > > > >
> > > > > Following your feedback on v2 [1], I moved the iostats to per-sb.
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > > >
> > > > > [1] https://lore.kernel.org/linux-unionfs/20220228113910.1727819-1-amir73il@gmail.com/
> > > > >
> > > > > Changes since v2:
> > > > > - Change from per-mount to per-sb io stats (szeredi)
> > > > > - Avoid percpu loop when reading mountstats (dchinner)
> > > > >
> > > > > Changes since v1:
> > > > > - Opt-in for per-mount io stats for overlayfs and fuse
> > > >
> > > > Why make it optional only for specific filesystem types? Shouldn't
> > > > every superblock capture these stats and export them in exactly the
> > > > same place?
> > > >
> > >
> > > I am not sure what you are asking.
> > >
> > > Any filesystem can opt-in to get those generic io stats.
> >
> > Yes, but why even make it opt-in? Why not just set these up
> > unconditionally in alloc_super() for all filesystems? Either this is
> > useful information for userspace montioring and diagnostics, or it's
> > not useful at all. If it is useful, then all superblocks should
> > export this stuff rather than just some special subset of
> > filesystems where individual maintainers have noticed it and thought
> > "that might be useful".
> >
> > Just enable it for every superblock....
> >
> 
> Not that simple.
> First of all alloc_super() is used for all sorts of internal kernel sb
> (e.g. pipes) that really don't need those stats.

Doesn't change anything - it still should be entirely set up and
managed by alloc_super/deactivate_locked_super.

If it really has to be selected by filesystem, alloc_super() has
a fstype passes to it and you can put a falg in the fstype to say
this is supported. Then filesystems only need to set a feature flag
to enable it, not have to manage allocation/freeing of something
that only the core VFS code uses.

> Second, counters can have performance impact.

So does adding branches for feature checks that nobody except some
special case uses.

But if the counters have perf overhead, then fix the counter
implementation to have less overhead.

> Depending on the fs, overhead may or may not be significant.
> I used the attached patch for testing and ran some micro benchmarks
> on tmpfs (10M small read/writes).
> The patch hacks -omand for enabling iostats [*]
> 
> The results were not great. up to 20% slower when io size > default
> batch size (32).
> Increasing the counter batch size for rchar/wchar to 1K fixed this
> micro benchmark,

Why do you think that is? Think about it: what size IO did you test?
I bet it was larger than 32 bytes and so it was forcing the
default generic percpu counter implementation to take a spin lock on
every syscall.  Yes?

Which means this addition will need to use a custom batch size for
*all* filesystems, and it will have to be substantially larger than
PAGE_SIZE because we need to amortise the cost of the global percpu
counter update across multiple IOs, not just one. IOWs, the counter
batch size likely needs to be set to several megabytes so that we
don't need to take the per-cpu spinlock in every decent sized IO
that applications issue.

So this isn't a negative against enabling the feature for all
superblocks - you just discovered a general problem because you
hadn't considered the impact of the counter implementation on 
high performance, high concurrency IO. overlay does get used in such
environments hence if the implementation isn't up to spec for
filesystems like XFS, tmpfs, etc that overlay might sit on top of
then it's not good enough for overlay, either.

> but it may not be a one size fits all situation.
> So I'd rather be cautious and not enable the feature unconditionally.

But now that you've realised that the counter configs need to be
specifically tuned for the use case and the perf overhead is pretty
much a non-issue, what's the argument against enabling it for
all superblocks?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
