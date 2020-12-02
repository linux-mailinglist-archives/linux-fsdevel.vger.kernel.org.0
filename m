Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C62CC7FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 21:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgLBUla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 15:41:30 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:40973 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgLBUla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:41:30 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C356A3C6E96;
        Thu,  3 Dec 2020 07:40:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kkYvd-00HQG7-3Z; Thu, 03 Dec 2020 07:40:45 +1100
Date:   Thu, 3 Dec 2020 07:40:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201202204045.GM2842436@dread.disaster.area>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
 <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com>
 <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
 <641397.1606926232@warthog.procyon.org.uk>
 <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
 <X8flmVAwl0158872@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8flmVAwl0158872@kroah.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=0kp6ayLdEpwmuLgMGL4A:9 a=CjuIK1q_8ugA:10
        a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:06:01PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 02, 2020 at 06:41:43PM +0100, Miklos Szeredi wrote:
> > On Wed, Dec 2, 2020 at 5:24 PM David Howells <dhowells@redhat.com> wrote:
> > >
> > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > > Stable cc also?
> > > >
> > > > Cc: <stable@vger.kernel.org> # 5.8
> > >
> > > That seems to be unnecessary, provided there's a Fixes: tag.
> > 
> > Is it?
> > 
> > Fixes: means it fixes a patch, Cc: stable means it needs to be
> > included in stable kernels.  The two are not necessarily the same.
> > 
> > Greg?
> 
> You are correct.  cc: stable, as is documented in
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> ensures that the patch will get merged into the stable tree.
> 
> Fixes: is independent of it.  It's great to have for stable patches so
> that I know how far back to backport patches.
> 
> We do scan all commits for Fixes: tags that do not have cc: stable, and
> try to pick them up when we can and have the time to do so.  But it's
> not guaranteed at all that this will happen.
> 
> I don't know why people keep getting confused about this, we don't
> document the "Fixes: means it goes to stable" anywhere...

Except that is exactly what happens, sometimes within a day of two
of a patch with a Fixes tag hitting Linus' kernel. We have had a
serious XFS regression in the 5.9.9 stable kernel that should never
have happened as a result of exactly this "Fixes = automatically
swept immediately into stable kernels" behaviour. See here for
post-mortem analysis:

https://lore.kernel.org/linux-xfs/20201126071323.GF2842436@dread.disaster.area/T/#m26e14ebd28ad306025f4ebf37e2aae9a304345a5

This happened because these auotmated Fixes scans seem to occur
weekly during -rcX release periods, which means there really is *no
practical difference* between the way the stable process treats
Fixes tags and cc: stable.

Hence instead of developers having some control over "urgent, must
backport now" fixes versus fixes that still need the -rcX
stabilisation and integration testing to shake them out fully, the
regular scans result in everything with a fixes tag is treated as an
"urgent, must backport now" category of fix. It effectively
removes the stabilisation and integration testing process from
the changes stable kernel users are being exposed to...

That's not right. It gives upstream developers no margin for error,
and it exposes stable kernel users to bugs that the normal upstream
kernel stabilisation process prevents users from ever seeing in
released kernels. And it is exactly this behaviour that lead people
to understand that "fixes" and "cc: stable" essentially mean the
same thing from a stable kernel perspective.

It seems like this can all be avoided simply by scheduling the
automated fixes scans once the upstream kernel is released, not
while it is still being stabilised by -rc releases. That way stable
kernels get better tested fixes, they still get the same quantity of
fixes, and upstream developers have some margin to detect and
correct regressions in fixes before they get propagated to users.

It also creates a clear demarcation between fixes and cc: stable for
maintainers and developers: only patches with a cc: stable will be
backported immediately to stable. Developers know what patches need
urgent backports and, unlike developers, the automated fixes scan
does not have the subject matter expertise or background to make
that judgement....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
