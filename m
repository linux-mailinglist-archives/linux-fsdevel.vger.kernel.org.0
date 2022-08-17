Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB1596E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiHQMCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiHQMC3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:02:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0C84EDF;
        Wed, 17 Aug 2022 05:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87791B81D6E;
        Wed, 17 Aug 2022 12:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BA2C433D6;
        Wed, 17 Aug 2022 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660737745;
        bh=Yr0eE/RbYQ00ZOoOi3cPlHUpPs9R71iSMnwoaxspwUE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Aqj3//WHZQgwN1uC+vzT+PX/2FYrryeX4aenFJQR8Z5+HrhexuhSNzXusYmxqEd3D
         7EBQjc5ELp4JZ30G6lG+xmZTeClnSk0X4hK57scrdDlfxiQpdrkg0mD/c8UzJRvjJ3
         gzmRk4vPfn3Lc/wghYc1vTrqQOVuCVzIavmSyrM6g5XY/qKXbE9BxQWkqGUiH50snh
         8PcFs+HDnxQAyuWFMsRuVkbQlSUdDYKZKxC5cE3o7BcIYSxv4dzxX9Rd2BfD0JjKbW
         muhuIrGiYgrkR8KF42kUEVbi8DpW98EOg/WfCMq6erqs+F+P5lLTcKrrJRRAhEFtxW
         /fOlpTYaJLplg==
Message-ID: <b237ae4462b26c88358d4a3aab044f12c86771fb.camel@kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Date:   Wed, 17 Aug 2022 08:02:23 -0400
In-Reply-To: <20220816224257.GV3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
         <Yvu7DHDWl4g1KsI5@magnolia>
         <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
         <20220816224257.GV3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-08-17 at 08:42 +1000, Dave Chinner wrote:
> On Tue, Aug 16, 2022 at 11:58:06AM -0400, Jeff Layton wrote:
> > On Tue, 2022-08-16 at 08:43 -0700, Darrick J. Wong wrote:
> > > On Tue, Aug 16, 2022 at 09:17:36AM -0400, Jeff Layton wrote:
> > > > The i_version in xfs_trans_log_inode is bumped for any inode update=
,
> > > > including atime-only updates due to reads. We don't want to record =
those
> > > > in the i_version, as they don't represent "real" changes. Remove th=
at
> > > > callsite.
> > > >=20
> > > > In xfs_vn_update_time, if S_VERSION is flagged, then attempt to bum=
p the
> > > > i_version and turn on XFS_ILOG_CORE if it happens. In
> > > > xfs_trans_ichgtime, update the i_version if the mtime or ctime are =
being
> > > > updated.
> > >=20
> > > What about operations that don't touch the mtime but change the file
> > > metadata anyway?  There are a few of those, like the blockgc garbage
> > > collector, deduperange, and the defrag tool.
> > >=20
> >=20
> > Do those change the c/mtime at all?
> >=20
> > It's possible we're missing some places that should change the i_versio=
n
> > as well. We may need some more call sites.
> >=20
> > > Zooming out a bit -- what does i_version signal, concretely?  I thoug=
ht
> > > it was used by nfs (and maybe ceph?) to signal to clients that the fi=
le
> > > on the server has moved on, and the client needs to invalidate its
> > > caches.  I thought afs had a similar generation counter, though it's
> > > only used to cache file data, not metadata?  Does an i_version change
> > > cause all of them to invalidate caches, or is there more behavior I
> > > don't know about?
> > >=20
> >=20
> > For NFS, it indicates a change to the change attribute indicates that
> > there has been a change to the data or metadata for the file. atime
> > changes due to reads are specifically exempted from this, but we do bum=
p
> > the i_version if someone (e.g.) changes the atime via utimes().=20
>=20
> We have relatime behaviour to optimise away unnecessary atime
> updates on reads.  Trying to explicitly exclude i_version from atime
> updates in one filesystem just because NFS doesn't need that
> information seems ....  misguided.  The -on disk- i_version
> field behaviour is defined by the filesystem implementation, not the
> NFS requirements.
>=20

-o relatime does not fix this.

> > The NFS client will generally invalidate its caches for the inode when
> > it notices a change attribute change.
> >=20
> > FWIW, AFS may not meet this standard since it doesn't generally
> > increment the counter on metadata changes. It may turn out that we don'=
t
> > want to expose this to the AFS client due to that (or maybe come up wit=
h
> > some way to indicate this difference).
>=20
> In XFS, we've defined the on-disk i_version field to mean
> "increments with any persistent inode data or metadata change",
> regardless of what the high level applications that use i_version
> might actually require.
>=20
> That some network filesystem might only need a subset of the
> metadata to be covered by i_version is largely irrelevant - if we
> don't cover every persistent inode metadata change with i_version,
> then applications that *need* stuff like atime change notification
> can't be supported.
>=20
> > > Does that mean that we should bump i_version for any file data or
> > > attribute that could be queried or observed by userspace?  In which c=
ase
> > > I suppose this change is still correct, even if it relaxes i_version
> > > updates from "any change to the inode whatsoever" to "any change that
> > > would bump mtime".  Unless FIEMAP is part of "attributes observed by
> > > userspace".
> > >=20
> > > (The other downside I can see is that now we have to remember to bump
> > > timestamps for every new file operation we add, unlike the current co=
de
> > > which is centrally located in xfs_trans_log_inode.)
> > >=20
> >=20
> > The main reason for the change attribute in NFS was that NFSv3 is
> > plagued with cache-coherency problems due to coarse-grained timestamp
> > granularity. It was conceived as a way to indicate that the inode had
> > changed without relying on timestamps.
>=20
> Yes, and the most important design consideration for a filesystem is
> that it -must be persistent-. The constraints on i_version are much
> stricter than timestamps, and they are directly related to how the
> filesystem persists metadata changes, not how metadata is changed or
> accessed in memory.
>=20
> > In practice, we want to bump the i_version counter whenever the ctime o=
r
> > mtime would be changed.
>=20
> What about O_NOCMTIME modifications? What about lazytime
> filesystems? These explicilty avoid or delay persisten c/mtime
> updates, and that means bumping i_version only based on c/mtime
> updates cannot be relied on. i_version is supposed to track user
> visible data and metadata changes, *not timestamp updates*.
>=20

I was speaking more about the sorts of activity that should result in
the i_version being changed, not about tracking timestamp updates. IOW,
if some activity would cause the mtime or ctime to change, then we want
to also bump the i_version.

Specifically, for NOCMTIME, I think we'd still want the i_version to
change since that option is about timestamps and not i_version.

> > > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/xfs/libxfs/xfs_trans_inode.c | 17 +++--------------
> > > >  fs/xfs/xfs_iops.c               |  4 ++++
> > > >  2 files changed, 7 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_tr=
ans_inode.c
> > > > index 8b5547073379..78bf7f491462 100644
> > > > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > > > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > > > @@ -71,6 +71,8 @@ xfs_trans_ichgtime(
> > > >  		inode->i_ctime =3D tv;
> > > >  	if (flags & XFS_ICHGTIME_CREATE)
> > > >  		ip->i_crtime =3D tv;
> > > > +	if (flags & (XFS_ICHGTIME_MOD|XFS_ICHGTIME_CHG))
> > > > +		inode_inc_iversion(inode);
> > > >  }
>=20
> That looks wrong - this is not the only path through XFS that
> modifies timestamps, and I have to ask why this needs to be an
> explicit i_version bump given that nobody may have looked at
> i_version since the last time it was updated?.
>=20
> What about xfs_fs_dirty_inode() when we actually persist lazytime
> in-memory timestamp updates? We didn't bump i_version when setting
> I_DIRTY_TIME, and this patch now removes the mechanism that is used
> to bump iversion if it is needed when we persist those lazytime
> updates.....
>=20
> > > >  /*
> > > > @@ -116,20 +118,7 @@ xfs_trans_log_inode(
> > > >  		spin_unlock(&inode->i_lock);
> > > >  	}
> > > > =20
> > > > -	/*
> > > > -	 * First time we log the inode in a transaction, bump the inode c=
hange
> > > > -	 * counter if it is configured for this to occur. While we have t=
he
> > > > -	 * inode locked exclusively for metadata modification, we can usu=
ally
> > > > -	 * avoid setting XFS_ILOG_CORE if no one has queried the value si=
nce
> > > > -	 * the last time it was incremented. If we have XFS_ILOG_CORE alr=
eady
> > > > -	 * set however, then go ahead and bump the i_version counter
> > > > -	 * unconditionally.
> > > > -	 */
> > > > -	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> > > > -		if (IS_I_VERSION(inode) &&
> > > > -		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> > > > -			iversion_flags =3D XFS_ILOG_CORE;
> > > > -	}
> > > > +	set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags);
>=20
> .... and this removes the sweep that captures in-memory timestamp
> and i_version peeks between any persistent inode metadata
> modifications that have been made, regardless of whether i_version
> has already been bumped for them or not.
>=20
> IOws, this seems to rely on every future inode modification in XFS
> calling xfs_trans_ichgtime() to bump i_version to sweep previous VFS
> in-memory timestamp updates that this inode modification captures
> and persists to disk.
>=20
> This seems fragile and error prone - it's relying on the
> developers always getting timestamp and iversion updates correct,
> rather the code always guaranteeing that it captures timestamp and
> iversion updates without any extra effort.
>=20
> Hence, I don't think that trying to modify how filesystems persist
> and maintain i_version coherency because NFS "doesn't need i_version
> to cover atime updates" is the wrong approach. On-disk i_version
> coherency has to work for more than just one NFS implementation
> (especially now i_version will be exported to userspace!).=20
> Persistent atime updates are already optimised away by relatime, and
> so I think that any further atime filtering is largely a NFS
> application layer problem and not something that should be solved by
> changing the on-disk definition of back end filesystem structure
> persistence.
>=20

Fair enough. xfs is not really in my wheelhouse so take this as a patch
that helps illustrate the problem, rather than a serious submission.

There are two consumers of the i_version counter today: the kernel NFS
server and IMA. Having the i_version reflect atime updates due to reads
harms both of those use-cases with unneeded cache invalidations on NFS
and extra measurements on IMA. It would also be problematic for userland
NFS servers such as ganesha if we end up exposing this to userland.

atime updates are really a special case when it comes to metadata (and I
maintain that they are one of the worst ideas in POSIX). The way you're
choosing to define i_version doesn't really work properly for any
current or projected use case. I'd like to see that changed.

If the concern is fragility of the code going forward, then maybe we can
go with a different approach. Would it be possible to just have
xfs_trans_log_inode skip bumping the i_version when the log transaction
is _only_ for an atime update due to reads? Maybe we could add a new
XFS_ILOG_ATIME_UPDATE flag or something and set it the appropriate
codepaths?
--=20
Jeff Layton <jlayton@kernel.org>
