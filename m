Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE15597AD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 03:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiHRBHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 21:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiHRBHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:07:33 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F4D371BF2;
        Wed, 17 Aug 2022 18:07:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A4E3D62D843;
        Thu, 18 Aug 2022 11:07:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oOU0N-00EP2F-67; Thu, 18 Aug 2022 11:07:27 +1000
Date:   Thu, 18 Aug 2022 11:07:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220818010727.GB3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <Yvu7DHDWl4g1KsI5@magnolia>
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
 <20220816224257.GV3600936@dread.disaster.area>
 <b237ae4462b26c88358d4a3aab044f12c86771fb.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b237ae4462b26c88358d4a3aab044f12c86771fb.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62fd90d2
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=WtEykgsZ6xC5nPhNo5IA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:02:23AM -0400, Jeff Layton wrote:
> On Wed, 2022-08-17 at 08:42 +1000, Dave Chinner wrote:
> > On Tue, Aug 16, 2022 at 11:58:06AM -0400, Jeff Layton wrote:
> > > On Tue, 2022-08-16 at 08:43 -0700, Darrick J. Wong wrote:
> > > > On Tue, Aug 16, 2022 at 09:17:36AM -0400, Jeff Layton wrote:
> > > > > The i_version in xfs_trans_log_inode is bumped for any inode update,
> > > > > including atime-only updates due to reads. We don't want to record those
> > > > > in the i_version, as they don't represent "real" changes. Remove that
> > > > > callsite.
> > > > > 
> > > > > In xfs_vn_update_time, if S_VERSION is flagged, then attempt to bump the
> > > > > i_version and turn on XFS_ILOG_CORE if it happens. In
> > > > > xfs_trans_ichgtime, update the i_version if the mtime or ctime are being
> > > > > updated.
> > > > 
> > > > What about operations that don't touch the mtime but change the file
> > > > metadata anyway?  There are a few of those, like the blockgc garbage
> > > > collector, deduperange, and the defrag tool.
> > > > 
> > > 
> > > Do those change the c/mtime at all?
> > > 
> > > It's possible we're missing some places that should change the i_version
> > > as well. We may need some more call sites.
> > > 
> > > > Zooming out a bit -- what does i_version signal, concretely?  I thought
> > > > it was used by nfs (and maybe ceph?) to signal to clients that the file
> > > > on the server has moved on, and the client needs to invalidate its
> > > > caches.  I thought afs had a similar generation counter, though it's
> > > > only used to cache file data, not metadata?  Does an i_version change
> > > > cause all of them to invalidate caches, or is there more behavior I
> > > > don't know about?
> > > > 
> > > 
> > > For NFS, it indicates a change to the change attribute indicates that
> > > there has been a change to the data or metadata for the file. atime
> > > changes due to reads are specifically exempted from this, but we do bump
> > > the i_version if someone (e.g.) changes the atime via utimes(). 
> > 
> > We have relatime behaviour to optimise away unnecessary atime
> > updates on reads.  Trying to explicitly exclude i_version from atime
> > updates in one filesystem just because NFS doesn't need that
> > information seems ....  misguided.  The -on disk- i_version
> > field behaviour is defined by the filesystem implementation, not the
> > NFS requirements.
> 
> -o relatime does not fix this.

So why not fix -o relatime to handle this? That way the fix works
for all filesystems and doesn't require hacking around what the VFS
has told us to do in every filesystem.

i.e. the VFS told us to update atime, we updated atime and that is a
persistent metadata change to the inode. Hence a filesystem with a
persistent change counter has to bump the change counter because
we've been asked by the VFS to make a persistent metadata change.

If you want atime updates to not make persistent changes to on disk
metadata, then change the relatime implementation so that it doesn't
ask the filesystem to update the on-disk atime.

Essentially, what I'm hearing is that NFS wants atime updates to
behave like lazytime, not like relatime. With lazytime, atime always
gets updated in memory, but it is not written back to the filesystem
until a timeout or some other modification is made to the inode or
file data. THe filesystem doesn't bump iversion until the timestamp
gets written back in the lazytime case.

IOWs, we already have a mechanism in the kernel for making atime
updates behave exactly as NFS wants: -o lazytime.

> > > The NFS client will generally invalidate its caches for the inode when
> > > it notices a change attribute change.
> > > 
> > > FWIW, AFS may not meet this standard since it doesn't generally
> > > increment the counter on metadata changes. It may turn out that we don't
> > > want to expose this to the AFS client due to that (or maybe come up with
> > > some way to indicate this difference).
> > 
> > In XFS, we've defined the on-disk i_version field to mean
> > "increments with any persistent inode data or metadata change",
> > regardless of what the high level applications that use i_version
> > might actually require.
> > 
> > That some network filesystem might only need a subset of the
> > metadata to be covered by i_version is largely irrelevant - if we
> > don't cover every persistent inode metadata change with i_version,
> > then applications that *need* stuff like atime change notification
> > can't be supported.
> > 
> > > > Does that mean that we should bump i_version for any file data or
> > > > attribute that could be queried or observed by userspace?  In which case
> > > > I suppose this change is still correct, even if it relaxes i_version
> > > > updates from "any change to the inode whatsoever" to "any change that
> > > > would bump mtime".  Unless FIEMAP is part of "attributes observed by
> > > > userspace".
> > > > 
> > > > (The other downside I can see is that now we have to remember to bump
> > > > timestamps for every new file operation we add, unlike the current code
> > > > which is centrally located in xfs_trans_log_inode.)
> > > > 
> > > 
> > > The main reason for the change attribute in NFS was that NFSv3 is
> > > plagued with cache-coherency problems due to coarse-grained timestamp
> > > granularity. It was conceived as a way to indicate that the inode had
> > > changed without relying on timestamps.
> > 
> > Yes, and the most important design consideration for a filesystem is
> > that it -must be persistent-. The constraints on i_version are much
> > stricter than timestamps, and they are directly related to how the
> > filesystem persists metadata changes, not how metadata is changed or
> > accessed in memory.
> > 
> > > In practice, we want to bump the i_version counter whenever the ctime or
> > > mtime would be changed.
> > 
> > What about O_NOCMTIME modifications? What about lazytime
> > filesystems? These explicilty avoid or delay persisten c/mtime
> > updates, and that means bumping i_version only based on c/mtime
> > updates cannot be relied on. i_version is supposed to track user
> > visible data and metadata changes, *not timestamp updates*.
> 
> I was speaking more about the sorts of activity that should result in
> the i_version being changed, not about tracking timestamp updates. IOW,
> if some activity would cause the mtime or ctime to change, then we want
> to also bump the i_version.
> 
> Specifically, for NOCMTIME, I think we'd still want the i_version to
> change since that option is about timestamps and not i_version.

Exactly my point: this is what XFS currently does. It is also what
your proposed changes break by tying i_version updates to c/mtime
updates.

> > Hence, I don't think that trying to modify how filesystems persist
> > and maintain i_version coherency because NFS "doesn't need i_version
> > to cover atime updates" is the wrong approach. On-disk i_version
> > coherency has to work for more than just one NFS implementation
> > (especially now i_version will be exported to userspace!). 
> > Persistent atime updates are already optimised away by relatime, and
> > so I think that any further atime filtering is largely a NFS
> > application layer problem and not something that should be solved by
> > changing the on-disk definition of back end filesystem structure
> > persistence.
> > 
> 
> Fair enough. xfs is not really in my wheelhouse so take this as a patch
> that helps illustrate the problem, rather than a serious submission.
> 
> There are two consumers of the i_version counter today: the kernel NFS
> server and IMA. Having the i_version reflect atime updates due to reads
> harms both of those use-cases with unneeded cache invalidations on NFS
> and extra measurements on IMA. It would also be problematic for userland
> NFS servers such as ganesha if we end up exposing this to userland.

So you're wanting define an exact behaviour for atime vs I_VERSION
where atime doesn't bump iversion.

However, the definition we baked into the XFS on-disk format is that
the on-disk iversion filed changes for every persistent change made
to the inode. That includes atime updates. We did this for two
reasons - the first is so that we could support any application that
needed change detection, and the second was that knowing how many
changes have occurred to an inode is extremely useful for forensic
purposes (especially given the ability to use O_NOCMTIME to modify
file data).

> atime updates are really a special case when it comes to metadata (and I
> maintain that they are one of the worst ideas in POSIX). The way you're
> choosing to define i_version doesn't really work properly for any
> current or projected use case. I'd like to see that changed.

We chose to do that a decade ago, knowing that it is the
responsibility of the VFS to avoid unnecessary atime updates, not
the responsibility of the filesystem. That was the whole point of
introducing the relatime functionality: fix the problem at the VFS,
not have to work around generic atime behaviour in every filesystem.

> If the concern is fragility of the code going forward, then maybe we can
> go with a different approach. Would it be possible to just have
> xfs_trans_log_inode skip bumping the i_version when the log transaction
> is _only_ for an atime update due to reads? Maybe we could add a new
> XFS_ILOG_ATIME_UPDATE flag or something and set it the appropriate
> codepaths?

No, I don't think this is something we should be hacking around in
individual filesystems. If the VFS tells us we should be updating
atime, we should be updating it and bumping persistent change
counters because *that's what the VFS asked us to do*.

IOWs, if NFS wants atime to be considered "in memory only" as per
the lazytime behaviour, then that behaviour needs to be
supported/changed at the VFS, not at the individual fileystem level.

You could add a subset of SB_LAZYTIME functionality just for atime
updates, handle that entirely within the existing lazytime
infrastructure. THis means the VFS supports non-persistent,
best-effort, non-persistent atime updates directly. The VFS will not
ack filesystems to persist atime updates the moment they are made,
it will tell the filesystem via ->dirty_inode() that it needs to
persist the in-memory timestamps.

This gives all the filesystems the same atime behaviour. If the VFS
is going to expose the persistent change counter to userspace, we
need to have consistent, VFS enforced rules on what is coverred by
the change counter. If atime is not covered by the ipersistent
change counter, then the VFS must not ask the filesystems to persist
atime changes every time atime changes.

Then all filesystems will avoid on-disk atime updates as much as
possible, whilst still gathering them correctly when other
modifications are made.

Until we've got a definition of what this persistent change counter
actually describes and guarantees for userspace, changing filesystem
implementations is premature. And if it is decided that atime is not
going to be considered a "persistent change" by itself, then that
behaviour needs to be encoded at the VFS, not in individual
filesystems....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
