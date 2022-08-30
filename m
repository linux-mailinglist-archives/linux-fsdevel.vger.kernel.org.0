Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359035A58C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 03:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiH3BE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 21:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH3BEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:04:54 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D972BDA;
        Mon, 29 Aug 2022 18:04:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-4-169.pa.nsw.optusnet.com.au [49.195.4.169])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1884D62D9C7;
        Tue, 30 Aug 2022 11:04:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oSpgI-001XKz-SX; Tue, 30 Aug 2022 11:04:42 +1000
Date:   Tue, 30 Aug 2022 11:04:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
Message-ID: <20220830010442.GW3600936@dread.disaster.area>
References: <20220826214703.134870-1-jlayton@kernel.org>
 <20220826214703.134870-2-jlayton@kernel.org>
 <20220829075651.GS3600936@dread.disaster.area>
 <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=630d622e
        a=FOdsZBbW/tHyAhIVFJ0pRA==:117 a=FOdsZBbW/tHyAhIVFJ0pRA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=zVjiu_gZAAAA:8 a=SEtKQCMJAAAA:8
        a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8 a=qmMTymrXjTok30Q9744A:9
        a=CjuIK1q_8ugA:10 a=DXoJjCrjhysRDS3qLJti:22 a=kyTSok1ft720jgMXX5-3:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:39:04AM -0400, Jeff Layton wrote:
> On Mon, 2022-08-29 at 17:56 +1000, Dave Chinner wrote:
> > On Fri, Aug 26, 2022 at 05:46:57PM -0400, Jeff Layton wrote:
> > > The i_version field in the kernel has had different semantics over
> > > the decades, but we're now proposing to expose it to userland via
> > > statx. This means that we need a clear, consistent definition of
> > > what it means and when it should change.
> > > 
> > > Update the comments in iversion.h to describe how a conformant
> > > i_version implementation is expected to behave. This definition
> > > suits the current users of i_version (NFSv4 and IMA), but is
> > > loose enough to allow for a wide range of possible implementations.
> > > 
> > > Cc: Colin Walters <walters@verbum.org>
> > > Cc: NeilBrown <neilb@suse.de>
> > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  include/linux/iversion.h | 23 +++++++++++++++++++++--
> > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > index 3bfebde5a1a6..45e93e1b4edc 100644
> > > --- a/include/linux/iversion.h
> > > +++ b/include/linux/iversion.h
> > > @@ -9,8 +9,19 @@
> > >   * ---------------------------
> > >   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
> > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
> > > - * appear different to observers if there was a change to the inode's data or
> > > - * metadata since it was last queried.
> > > + * appear different to observers if there was an explicit change to the inode's
> > > + * data or metadata since it was last queried.
> > > + *
> > > + * An explicit change is one that would ordinarily result in a change to the
> > > + * inode status change time (aka ctime). The version must appear to change, even
> > > + * if the ctime does not (since the whole point is to avoid missing updates due
> > > + * to timestamp granularity). If POSIX mandates that the ctime must change due
> > > + * to an operation, then the i_version counter must be incremented as well.
> > > + *
> > > + * A conformant implementation is allowed to increment the counter in other
> > > + * cases, but this is not optimal. NFSv4 and IMA both use this value to determine
> > > + * whether caches are up to date. Spurious increments can cause false cache
> > > + * invalidations.
> > 
> > "not optimal", but never-the-less allowed - that's "unspecified
> > behaviour" if I've ever seen it. How is userspace supposed to
> > know/deal with this?
> > 
> > Indeed, this loophole clause doesn't exist in the man pages that
> > define what statx.stx_ino_version means. The man pages explicitly
> > define that stx_ino_version only ever changes when stx_ctime
> > changes.
> > 
> 
> We can fix the manpage to make this more clear.
> 
> > IOWs, the behaviour userspace developers are going to expect *does
> > not include* stx_ino_version changing it more often than ctime is
> > changed. Hence a kernel iversion implementation that bumps the
> > counter more often than ctime changes *is not conformant with the
> > statx version counter specification*. IOWs, we can't export such
> > behaviour to userspace *ever* - it is a non-conformant
> > implementation.
> > 
> 
> Nonsense. The statx version counter specification is *whatever we decide
> to make it*.

Yes, but...

> If we define it to allow for spurious version bumps, then
> these implementations would be conformant.

... that's _not how you defined stx_ino_version to behave_!

> Given that you can't tell what or how much changed in the inode whenever
> the value changes, allowing it to be bumped on non-observable changes is
> ok and the counter is still useful. When you see it change you need to
> go stat/read/getxattr etc, to see what actually happened anyway.

IDGI. If this is acceptible, then you're forcing userspace into
"store and filter" implementations as the only viable method of
using the change notification usefully.

That means atime is just another attribute in the "store and
filter" algorithm, so if this is how we define stx_ino_version
behaviour, why carve out an explicit exception for atime?

> Most applications won't be interested in every possible explicit change
> that can happen to an inode. It's likely these applications would check
> the parts of the inode they're interested in, and then go back to
> waiting for the next bump if the change wasn't significant to them.

Yes, that is exactly my point.

You make the argument that we must not bump iversion in certain
situations (atime) because it will cause spurious cache
invalidations, but then say it is OK to bump it in others regardless
of the fact that it will cause spurious cache invalidations. And you
justify this latter behaviour by saying it is up to the application
to avoid spurious invalidations by using "store and filter"
algorithms.

If the application has to store state and filter changes indicated
by stx_ino_version changing, then by definition *it must be capable
of filtering iversion bumps as a result of atime changes*.

The iversion exception carved out for atime requires the application
to implement "store and filter" algorithms only if it needs to care
about atime changes. The "invisible bump" exception carved out here
*requires* applications to implement "store and filter" algorithms
to filter out invisible bumps.

Hence if we combine both these behaviours, atime bumping iversion
appears to userspace exactly the same as "invisible bump occurred,
followed by access that changes atime".  IOWs, userspace cannot tell the
difference between a filesystem implementation that doesn't bump
iversion on atime but has invisible bump, and a filesystem that
bumps iversion on atime updates and so it always needs to filter
atime changes if it doesn't care about them.

Hence if stx_ino_version can have invisible bumps, it makes no
difference to userspace if atime updates bump iversion or not. They
will have to filter atime if they don't care about it, and they have
to store the new stx_ino_version every time they filter out an
invisible bump that doesn't change anything their filters care
about (e.g. atime!).

At which point I have to ask: if we are expecting userspace to
filter out invisible iversion bumps because that's allowed,
conformant behaviour, then why aren't we requiring both the NFS
server and IMA applications to filter spurious iversion bumps as
well?

> > Hence I think anything that bumps iversion outside the bounds of the
> > statx definition should be declared as such:
> > 
> > "Non-conformant iversion implementations:
> > 	- MUST NOT be exported by statx() to userspace
> > 	- MUST be -tolerated- by kernel internal applications that
> > 	  use iversion for their own purposes."
> > 
> 
> I think this is more strict than is needed. An implementation that bumps
> this value more often than is necessary is still useful.

I never said that non-conformant implementations aren't useful. What
I said is they aren't conformant with the provided definition of
stx_ino_version, and as a result we should not allow them to be
exposed to userspace.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
