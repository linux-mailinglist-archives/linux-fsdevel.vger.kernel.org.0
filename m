Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25FC4F54B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 07:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349583AbiDFFPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 01:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1840321AbiDFBHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 21:07:46 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85E29232114;
        Tue,  5 Apr 2022 16:04:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8A01D10E56A4;
        Wed,  6 Apr 2022 09:04:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbsDk-00EERK-OM; Wed, 06 Apr 2022 09:04:20 +1000
Date:   Wed, 6 Apr 2022 09:04:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220405230420.GX1609613@dread.disaster.area>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220222221614.GC3061737@dread.disaster.area>
 <20220402105749.GB16346@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402105749.GB16346@amd>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=624ccaf7
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=_MjYSGqaCGpKE7YW:21 a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=AvG-BbIAFkt7vrdm4KcA:9 a=CjuIK1q_8ugA:10
        a=xNNtwZicer8A:10 a=aebnku51ZD03SSuSuSm5:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 02, 2022 at 12:57:49PM +0200, Pavel Machek wrote:
> > > So from my distro experience installed userbase of reiserfs is pretty small
> > > and shrinking. We still do build reiserfs in openSUSE / SLES kernels but
> > > for enterprise offerings it is unsupported (for like 3-4 years) and the module
> > > is not in the default kernel rpm anymore.
> > > 
> > > So clearly the filesystem is on the deprecation path, the question is
> > > whether it is far enough to remove it from the kernel completely. Maybe
> > > time to start deprecation by printing warnings when reiserfs gets mounted
> > > and then if nobody yells for year or two, we'll go ahead and remove it?
> > 
> > Yup, I'd say we should deprecate it and add it to the removal
> > schedule. The less poorly tested legacy filesystem code we have to
> > maintain the better.
> > 
> > Along those lines, I think we really need to be more aggressive
> > about deprecating and removing filesystems that cannot (or will not)
> > be made y2038k compliant in the new future. We're getting to close
> > to the point where long term distro and/or product development life
> > cycles will overlap with y2038k, so we should be thinking of
> > deprecating and removing such filesystems before they end up in
> > products that will still be in use in 15 years time.
> > 
> > And just so everyone in the discussion is aware: XFS already has a
> > deprecation and removal schedule for the non-y2038k-compliant v4
> > filesystem format. It's officially deprecated right now, we'll stop
> > building kernels with v4 support enabled by default in 2025, and
> > we're removing the code that supports the v4 format entirely in
> > 2030.
> 
> Haha.
> 
> It is not up to you. You can't remove feature people are
> using. Sorry. Talk to Linus about that.

I think you have the wrong end of the stick. We're not removing
stuff that people use, we're removing support for functionality that
will be *fundamentally broken* and *unfixable* come 2038. Hence we
need a process for ensuring that nobody is still requiring us to
support it by the scheduled removal date.

Every long term project needs to have a deprecation process so that
they can clean out unmaintained, broken, unfixable and/or unused
code without putting users at risk. If we can't/won't/don't clear
out unmaintained or unfixable code, the risk of data loss, security
breaches, etc in that code is a real and present danger to
any kernel that includes that code. We learnt this lesson the hard
way recently, and we simply removed the legacy code responsible in
response. Even Linus agreed that prompt removal of the functionality
was the right thing to do.

This occurred despite the fact we had a feature deprecation policy
for XFS long before that incident occurred - we just had not been
applying it to dusty corners of the user API we inherited from Irix.
It has been used for things like proc/sysfs knobs and mount options
that are no longer supported, and the lesson we learn is that is
should be applied to user APIs as well. We'd already extended that
process for deprecation and removal of support for on-disk formats
(i.e. the V4 format) but not legacy user APIS.

W.r.t to the V4 format deprecation, the kernel issues warnings
at mount time right now to say that the v4 format is deprecated and
will be going away.

XFS (dm-0): Deprecated V4 format (crc=0) will not be supported after September 2030.
XFS (dm-0): Mounting V4 Filesystem
XFS (dm-0): Ending clean mount
xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)

mkfs.xfs warns if you explicitly make a v4 fielsystem:

# mkfs.xfs -N -m crc=0 /dev/mapper/fast
V4 filesystems are deprecated and will not be supported by future versions.
....
#

The timeframe for support is documented in both the mkfs.xfs man
page and the XFS section of the kernel admin guide published here:

https://docs.kernel.org/admin-guide/xfs.html#deprecation-of-v4-format

Indeed, if you keep reading down that link, you'll see all the
deprecated mount options, sysctls, etc and their removal schedule,
as well as all the removed options and when they were removed.

Deprecation and removal of old features is something that all long
term projects need to be able to perform, and the Linux kernel is no
different.  Just because the Linux kernel project as a whole
doesn't have full software lifecycle management processes, it
doesn't mean that every kernel subsystems have no full software
lifecycle management processes.

Rather than saying "you cannot do X", it is better to learn why "we
*need* to do X" and then come up with a sane process for allowing X
to occur. The recent a.out removal and the reverted /dev/urandom
changes are good examples of how having a well thought out feature
deprecation and removal process is a really good thing to have.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
