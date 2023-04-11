Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E76DE077
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDKQGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKQGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37314E4A;
        Tue, 11 Apr 2023 09:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6D9961521;
        Tue, 11 Apr 2023 16:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF29C433D2;
        Tue, 11 Apr 2023 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681229155;
        bh=UhFoUimr4E+kAi0DTUaR5SoiaG0yY7YeJ3s83ABlPnQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nVHHH8o0xPJq3ovnT8qOLgkdAJT0eGwj7204IcQReuHJUxFDmZSnpzWlND2AN9VJU
         jmwrxXEDH2imFkbD15V0MPXftO/lYyKYP1UL7FmSMg7no9sfktv/J+dPC6MZ+doXrE
         yWXGYepApuc5EVf/kWle73g3/BRlXoyYy+owZ8FshA5fPAA/YbrNWrJKucvhoK0cPd
         E165ccN5qTL3WOvznEghkExgz3Km0sBIlWOC+T/KuyNEcLmu94LKQd0wNf/TWesFNa
         duT/U4f5jfC+15OQWIq3TggvEqWRufuRLxKXDoihphRJ95cFNqNU2z1eTShuUfpZWn
         5n9mpRfskTB1w==
Message-ID: <2ce237b80e2b134d86042f69e6857dcb8ae53629.camel@kernel.org>
Subject: Re: [RFC PATCH 3/3][RESEND] xfs: mark the inode for high-res
 timestamp update in getattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Date:   Tue, 11 Apr 2023 12:05:52 -0400
In-Reply-To: <20230411-schokolade-hegemonie-83b1f0ecfd6c@brauner>
References: <20230411143702.64495-1-jlayton@kernel.org>
         <20230411143702.64495-4-jlayton@kernel.org>
         <20230411145446.GG360895@frogsfrogsfrogs>
         <20230411-schokolade-hegemonie-83b1f0ecfd6c@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-11 at 17:15 +0200, Christian Brauner wrote:
> On Tue, Apr 11, 2023 at 07:54:46AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 11, 2023 at 10:37:02AM -0400, Jeff Layton wrote:
> > > When the mtime or ctime is being queried via getattr, ensure that we
> > > mark the inode for a high-res timestamp update on the next pass. Also=
,
> > > switch to current_cmtime for other c/mtime updates.
> > >=20
> > > With this change, we're better off having the NFS server just ignore
> > > the i_version field and have it use the ctime instead, so clear the
> > > STATX_CHANGE_COOKIE flag in the result mask in ->getattr.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
> > >  fs/xfs/xfs_acl.c                |  2 +-
> > >  fs/xfs/xfs_inode.c              |  2 +-
> > >  fs/xfs/xfs_iops.c               | 15 ++++++++++++---
> > >  4 files changed, 15 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_tran=
s_inode.c
> > > index 8b5547073379..9ad7c229c617 100644
> > > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > > @@ -63,7 +63,7 @@ xfs_trans_ichgtime(
> > >  	ASSERT(tp);
> > >  	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> > > =20
> > > -	tv =3D current_time(inode);
> > > +	tv =3D current_cmtime(inode);
> > > =20
> > >  	if (flags & XFS_ICHGTIME_MOD)
> > >  		inode->i_mtime =3D tv;
> > > diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
> > > index 791db7d9c849..461adc58cf8c 100644
> > > --- a/fs/xfs/xfs_acl.c
> > > +++ b/fs/xfs/xfs_acl.c
> > > @@ -233,7 +233,7 @@ xfs_acl_set_mode(
> > >  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > >  	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
> > >  	inode->i_mode =3D mode;
> > > -	inode->i_ctime =3D current_time(inode);
> > > +	inode->i_ctime =3D current_cmtime(inode);
> >=20
> > Hmm, now we're adding a spinlock to all these updates.
> > Does lockdep have anything exciting to say about this?
> >=20
> > (I don't think it will, just wondering aloud...)
> >=20
> > >  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > > =20
> > >  	if (xfs_has_wsync(mp))
> > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > index 5808abab786c..80f9d731e261 100644
> > > --- a/fs/xfs/xfs_inode.c
> > > +++ b/fs/xfs/xfs_inode.c
> > > @@ -843,7 +843,7 @@ xfs_init_new_inode(
> > >  	ip->i_df.if_nextents =3D 0;
> > >  	ASSERT(ip->i_nblocks =3D=3D 0);
> > > =20
> > > -	tv =3D current_time(inode);
> > > +	tv =3D current_cmtime(inode);
> > >  	inode->i_mtime =3D tv;
> > >  	inode->i_atime =3D tv;
> > >  	inode->i_ctime =3D tv;
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index 24718adb3c16..a0b07f90e16c 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -565,6 +565,15 @@ xfs_vn_getattr(
> > >  	if (xfs_is_shutdown(mp))
> > >  		return -EIO;
> > > =20
> > > +	/*
> > > +	 * XFS uses the i_version infrastructure to track any change to
> > > +	 * the inode, including atime updates. This means that the i_versio=
n
> > > +	 * returned by getattr doesn't conform to what the callers expect.
> > > +	 * Clear it here so that nfsd will fake up a change cookie from the
> > > +	 * ctime instead.
> > > +	 */
> > > +	stat->result_mask &=3D ~STATX_CHANGE_COOKIE;
> > > +
> > >  	stat->size =3D XFS_ISIZE(ip);
> > >  	stat->dev =3D inode->i_sb->s_dev;
> > >  	stat->mode =3D inode->i_mode;
> > > @@ -573,8 +582,8 @@ xfs_vn_getattr(
> > >  	stat->gid =3D vfsgid_into_kgid(vfsgid);
> > >  	stat->ino =3D ip->i_ino;
> > >  	stat->atime =3D inode->i_atime;
> > > -	stat->mtime =3D inode->i_mtime;
> > > -	stat->ctime =3D inode->i_ctime;
> > > +	if (request_mask & (STATX_CTIME|STATX_MTIME))
> > > +		fill_cmtime_and_mark(inode, stat);
> >=20
> > Should we be setting STATX_[CM]TIME in the result_mask, just in case th=
e
> > caller asked for ctime and not mtime?
>=20
> I think the expectation is that everything in STATX_BASIC_MASK is always
> returned to allow equivalence between stat() and statx(). So requesting
> STATX_CTIME separately from STATX_MTIME isn't implemented widely, maybe
> even not at atll?, yet.

Right. Probably we ought to be more selective with how the result_mask
gets set in vfs_getattr_nosec. Applications that use statx() effectively
are still pretty rare, so most calls will fetch both times anyway.
--=20
Jeff Layton <jlayton@kernel.org>
