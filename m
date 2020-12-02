Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CF2CC896
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 22:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgLBVFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 16:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgLBVFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 16:05:03 -0500
Date:   Wed, 2 Dec 2020 22:04:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606943062;
        bh=Lov+rl2zMsm/DNiknCS71Nefh+Dku1EKItYVB/Sc7X0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=1K48tAXxw42dVwFAhEqj3JOIUkCoSekEIDrMwliXlTFI/wEmnXSElRiKdsEx/7yQW
         Y8I4/21n9TiR9oC0zszhjrLazN/gs+JtC0oy4FteTBaeiQQxV0bwMMOj3DF3HLqszO
         2a5VL5wOBDskzNvsh5AF6RoqImctJXn+Wya2AHg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <X8gBUc0fkdh6KK01@kroah.com>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
 <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com>
 <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
 <641397.1606926232@warthog.procyon.org.uk>
 <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
 <X8flmVAwl0158872@kroah.com>
 <20201202204045.GM2842436@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202204045.GM2842436@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 07:40:45AM +1100, Dave Chinner wrote:
> On Wed, Dec 02, 2020 at 08:06:01PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 02, 2020 at 06:41:43PM +0100, Miklos Szeredi wrote:
> > > On Wed, Dec 2, 2020 at 5:24 PM David Howells <dhowells@redhat.com> wrote:
> > > >
> > > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > > Stable cc also?
> > > > >
> > > > > Cc: <stable@vger.kernel.org> # 5.8
> > > >
> > > > That seems to be unnecessary, provided there's a Fixes: tag.
> > > 
> > > Is it?
> > > 
> > > Fixes: means it fixes a patch, Cc: stable means it needs to be
> > > included in stable kernels.  The two are not necessarily the same.
> > > 
> > > Greg?
> > 
> > You are correct.  cc: stable, as is documented in
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > ensures that the patch will get merged into the stable tree.
> > 
> > Fixes: is independent of it.  It's great to have for stable patches so
> > that I know how far back to backport patches.
> > 
> > We do scan all commits for Fixes: tags that do not have cc: stable, and
> > try to pick them up when we can and have the time to do so.  But it's
> > not guaranteed at all that this will happen.
> > 
> > I don't know why people keep getting confused about this, we don't
> > document the "Fixes: means it goes to stable" anywhere...
> 
> Except that is exactly what happens, sometimes within a day of two
> of a patch with a Fixes tag hitting Linus' kernel. We have had a
> serious XFS regression in the 5.9.9 stable kernel that should never
> have happened as a result of exactly this "Fixes = automatically
> swept immediately into stable kernels" behaviour. See here for
> post-mortem analysis:
> 
> https://lore.kernel.org/linux-xfs/20201126071323.GF2842436@dread.disaster.area/T/#m26e14ebd28ad306025f4ebf37e2aae9a304345a5
> 
> This happened because these auotmated Fixes scans seem to occur
> weekly during -rcX release periods, which means there really is *no
> practical difference* between the way the stable process treats
> Fixes tags and cc: stable.

Sometimes, yes, that is true.  But as it went into Linus's tree at the
same time, we just ended up with "bug compatible" trees :)

Not a big deal overall, happens every few releases, we fix it up and
move on.  The benifits in doing all of this _FAR_ outweigh the very
infrequent times that kernel developers get something wrong.

As always, if you do NOT want your subsystem to have fixes: tags picked
up automatically by us for stable trees, just email us and let us know
to not do that and we gladly will.

> It seems like this can all be avoided simply by scheduling the
> automated fixes scans once the upstream kernel is released, not
> while it is still being stabilised by -rc releases. That way stable
> kernels get better tested fixes, they still get the same quantity of
> fixes, and upstream developers have some margin to detect and
> correct regressions in fixes before they get propagated to users.

So the "magic" -final release from Linus would cause this to happen?
That means that the world would go for 3 months without some known fixes
being applied to the tree?  That's not acceptable to me, as I started
doing this because it was needed to be done, not just because I wanted
to do more work...

> It also creates a clear demarcation between fixes and cc: stable for
> maintainers and developers: only patches with a cc: stable will be
> backported immediately to stable. Developers know what patches need
> urgent backports and, unlike developers, the automated fixes scan
> does not have the subject matter expertise or background to make
> that judgement....

Some subsystems do not have such clear demarcation at all.  Heck, some
subsystems don't even add a cc: stable to known major fixes.  And that's
ok, the goal of the stable kernel work is to NOT impose additional work
on developers or maintainers if they don't want to do that work.

thanks,

greg k-h
