Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F050D595FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiHPQAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiHPP7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79262C661;
        Tue, 16 Aug 2022 08:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 539A66120F;
        Tue, 16 Aug 2022 15:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1A0C433C1;
        Tue, 16 Aug 2022 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660665488;
        bh=Pb2OtpTjDkN7Ae+1Vf4Zt/xqyOYvTLGy0CE/8cgs/Po=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YxsrZWpX/cfv/F8Ao5G20/mS+vUKD4tiWV3aJFXzKWhLCduQLoiW2OSq9B6iJMJ2N
         qd02XWMP+yx2Fl1SYONqHNsPxjPeiI+3W3spjuDGT+jYmVc6DfJ2WOkvYLdZuZr32M
         mYMCNiKTAlJgmv/PHzQhc6iSjwvwbI36LpbugYilfqx1LesMKmXi1FqxS3crWilvWN
         t1gD3kFONilYyr8oEhZEQybHTz4cB7w0CRRzKrcXfulRItkmjx83vgW21NFlfZVz90
         m4dfSW5nWwkDzlH7JKlnIE7ZT8C1GFczlRQUOAiMLAhvJq8/XtiK6nzz7WEIF2r4pt
         laCNhLXX5FrgA==
Message-ID: <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Date:   Tue, 16 Aug 2022 11:58:06 -0400
In-Reply-To: <Yvu7DHDWl4g1KsI5@magnolia>
References: <20220816131736.42615-1-jlayton@kernel.org>
         <Yvu7DHDWl4g1KsI5@magnolia>
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

On Tue, 2022-08-16 at 08:43 -0700, Darrick J. Wong wrote:
> On Tue, Aug 16, 2022 at 09:17:36AM -0400, Jeff Layton wrote:
> > The i_version in xfs_trans_log_inode is bumped for any inode update,
> > including atime-only updates due to reads. We don't want to record thos=
e
> > in the i_version, as they don't represent "real" changes. Remove that
> > callsite.
> >=20
> > In xfs_vn_update_time, if S_VERSION is flagged, then attempt to bump th=
e
> > i_version and turn on XFS_ILOG_CORE if it happens. In
> > xfs_trans_ichgtime, update the i_version if the mtime or ctime are bein=
g
> > updated.
>=20
> What about operations that don't touch the mtime but change the file
> metadata anyway?  There are a few of those, like the blockgc garbage
> collector, deduperange, and the defrag tool.
>=20

Do those change the c/mtime at all?

It's possible we're missing some places that should change the i_version
as well. We may need some more call sites.

> Zooming out a bit -- what does i_version signal, concretely?  I thought
> it was used by nfs (and maybe ceph?) to signal to clients that the file
> on the server has moved on, and the client needs to invalidate its
> caches.  I thought afs had a similar generation counter, though it's
> only used to cache file data, not metadata?  Does an i_version change
> cause all of them to invalidate caches, or is there more behavior I
> don't know about?
>=20

For NFS, it indicates a change to the change attribute indicates that
there has been a change to the data or metadata for the file. atime
changes due to reads are specifically exempted from this, but we do bump
the i_version if someone (e.g.) changes the atime via utimes().=20

The NFS client will generally invalidate its caches for the inode when
it notices a change attribute change.

FWIW, AFS may not meet this standard since it doesn't generally
increment the counter on metadata changes. It may turn out that we don't
want to expose this to the AFS client due to that (or maybe come up with
some way to indicate this difference).

> Does that mean that we should bump i_version for any file data or
> attribute that could be queried or observed by userspace?  In which case
> I suppose this change is still correct, even if it relaxes i_version
> updates from "any change to the inode whatsoever" to "any change that
> would bump mtime".  Unless FIEMAP is part of "attributes observed by
> userspace".
>=20
> (The other downside I can see is that now we have to remember to bump
> timestamps for every new file operation we add, unlike the current code
> which is centrally located in xfs_trans_log_inode.)
>=20

The main reason for the change attribute in NFS was that NFSv3 is
plagued with cache-coherency problems due to coarse-grained timestamp
granularity. It was conceived as a way to indicate that the inode had
changed without relying on timestamps.

In practice, we want to bump the i_version counter whenever the ctime or
mtime would be changed.

> --D
>=20
> > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_trans_inode.c | 17 +++--------------
> >  fs/xfs/xfs_iops.c               |  4 ++++
> >  2 files changed, 7 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_=
inode.c
> > index 8b5547073379..78bf7f491462 100644
> > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > @@ -71,6 +71,8 @@ xfs_trans_ichgtime(
> >  		inode->i_ctime =3D tv;
> >  	if (flags & XFS_ICHGTIME_CREATE)
> >  		ip->i_crtime =3D tv;
> > +	if (flags & (XFS_ICHGTIME_MOD|XFS_ICHGTIME_CHG))
> > +		inode_inc_iversion(inode);
> >  }
> > =20
> >  /*
> > @@ -116,20 +118,7 @@ xfs_trans_log_inode(
> >  		spin_unlock(&inode->i_lock);
> >  	}
> > =20
> > -	/*
> > -	 * First time we log the inode in a transaction, bump the inode chang=
e
> > -	 * counter if it is configured for this to occur. While we have the
> > -	 * inode locked exclusively for metadata modification, we can usually
> > -	 * avoid setting XFS_ILOG_CORE if no one has queried the value since
> > -	 * the last time it was incremented. If we have XFS_ILOG_CORE already
> > -	 * set however, then go ahead and bump the i_version counter
> > -	 * unconditionally.
> > -	 */
> > -	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> > -		if (IS_I_VERSION(inode) &&
> > -		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> > -			iversion_flags =3D XFS_ILOG_CORE;
> > -	}
> > +	set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags);
> > =20
> >  	/*
> >  	 * If we're updating the inode core or the timestamps and it's possib=
le
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 45518b8c613c..162e044c7f56 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -718,6 +718,7 @@ xfs_setattr_nonsize(
> >  	}
> > =20
> >  	setattr_copy(mnt_userns, inode, iattr);
> > +	inode_inc_iversion(inode);
> >  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > =20
> >  	XFS_STATS_INC(mp, xs_ig_attrchg);
> > @@ -943,6 +944,7 @@ xfs_setattr_size(
> > =20
> >  	ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
> >  	setattr_copy(mnt_userns, inode, iattr);
> > +	inode_inc_iversion(inode);
> >  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > =20
> >  	XFS_STATS_INC(mp, xs_ig_attrchg);
> > @@ -1047,6 +1049,8 @@ xfs_vn_update_time(
> >  		inode->i_mtime =3D *now;
> >  	if (flags & S_ATIME)
> >  		inode->i_atime =3D *now;
> > +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +		log_flags |=3D XFS_ILOG_CORE;
> > =20
> >  	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
> >  	xfs_trans_log_inode(tp, ip, log_flags);
> > --=20
> > 2.37.2
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
