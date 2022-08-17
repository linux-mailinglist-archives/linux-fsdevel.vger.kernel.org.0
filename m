Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB1596E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiHQMKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiHQMK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7480B55;
        Wed, 17 Aug 2022 05:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 448BDB81D9F;
        Wed, 17 Aug 2022 12:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51463C433D7;
        Wed, 17 Aug 2022 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660738225;
        bh=ECCgVD28WiBQDCOksTrZMEtBKgLCb1GPrNi12Ine4+M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YcrCmOv6m4bDRALlgvuwVvEst0GEDYkkymlJxM1VPTPsWhMsurxjuenov53NQGPb2
         LA/unFmRB8QTlK4abBG3uAY0NG1V3RPR0ZB/XZSpUsdWagsSODpt/Tqnt7JPkL7l9/
         6lNFLfkIsgMMfhPJ6IZzC1yfMlVFPkUgLkJADVsdZj01wF1605ezuyizs6F9XZTVCe
         ba4/uVmTLR76xiX0z945cjpmWLwnjb5ZDn+pfN2TM8GAKgqiCwt94O+67gPe0/1vnM
         fsfl+OvN/5/plWbO7mdI3fEoUDUSVDJzof/gaGo5cDfvSs/WEnFoYz5ASfacQn8wXd
         2C61wg16rmEOw==
Message-ID: <939469eb788014a76d5e85b4534ceb8045332622.camel@kernel.org>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        David Wysochanski <dwysocha@redhat.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Date:   Wed, 17 Aug 2022 08:10:22 -0400
In-Reply-To: <20220816233729.GX3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
         <CALF+zO=OrT5tBvyL1ERD+YDSXkSAFvqQu-cQkSgWvQN8z+E_rA@mail.gmail.com>
         <20220816233729.GX3600936@dread.disaster.area>
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

On Wed, 2022-08-17 at 09:37 +1000, Dave Chinner wrote:
> On Tue, Aug 16, 2022 at 01:14:55PM -0400, David Wysochanski wrote:
> > On Tue, Aug 16, 2022 at 9:19 AM Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > The i_version in xfs_trans_log_inode is bumped for any inode update,
> > > including atime-only updates due to reads. We don't want to record th=
ose
> > > in the i_version, as they don't represent "real" changes. Remove that
> > > callsite.
> > >=20
> > > In xfs_vn_update_time, if S_VERSION is flagged, then attempt to bump =
the
> > > i_version and turn on XFS_ILOG_CORE if it happens. In
> > > xfs_trans_ichgtime, update the i_version if the mtime or ctime are be=
ing
> > > updated.
> > >=20
> > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/xfs/libxfs/xfs_trans_inode.c | 17 +++--------------
> > >  fs/xfs/xfs_iops.c               |  4 ++++
> > >  2 files changed, 7 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_tran=
s_inode.c
> > > index 8b5547073379..78bf7f491462 100644
> > > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > > @@ -71,6 +71,8 @@ xfs_trans_ichgtime(
> > >                 inode->i_ctime =3D tv;
> > >         if (flags & XFS_ICHGTIME_CREATE)
> > >                 ip->i_crtime =3D tv;
> > > +       if (flags & (XFS_ICHGTIME_MOD|XFS_ICHGTIME_CHG))
> > > +               inode_inc_iversion(inode);
> > >  }
> > >=20
> > >  /*
> > > @@ -116,20 +118,7 @@ xfs_trans_log_inode(
> > >                 spin_unlock(&inode->i_lock);
> > >         }
> > >=20
> > > -       /*
> > > -        * First time we log the inode in a transaction, bump the ino=
de change
> > > -        * counter if it is configured for this to occur. While we ha=
ve the
> > > -        * inode locked exclusively for metadata modification, we can=
 usually
> > > -        * avoid setting XFS_ILOG_CORE if no one has queried the valu=
e since
> > > -        * the last time it was incremented. If we have XFS_ILOG_CORE=
 already
> > > -        * set however, then go ahead and bump the i_version counter
> > > -        * unconditionally.
> > > -        */
> > > -       if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags))=
 {
> > > -               if (IS_I_VERSION(inode) &&
> > > -                   inode_maybe_inc_iversion(inode, flags & XFS_ILOG_=
CORE))
> > > -                       iversion_flags =3D XFS_ILOG_CORE;
> > > -       }
> > > +       set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags);
> > >=20
> > >         /*
> > >          * If we're updating the inode core or the timestamps and it'=
s possible
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index 45518b8c613c..162e044c7f56 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -718,6 +718,7 @@ xfs_setattr_nonsize(
> > >         }
> > >=20
> > >         setattr_copy(mnt_userns, inode, iattr);
> > > +       inode_inc_iversion(inode);
> > >         xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > >=20
> > >         XFS_STATS_INC(mp, xs_ig_attrchg);
> > > @@ -943,6 +944,7 @@ xfs_setattr_size(
> > >=20
> > >         ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
> > >         setattr_copy(mnt_userns, inode, iattr);
> > > +       inode_inc_iversion(inode);
> > >         xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > >=20
> > >         XFS_STATS_INC(mp, xs_ig_attrchg);
> > > @@ -1047,6 +1049,8 @@ xfs_vn_update_time(
> > >                 inode->i_mtime =3D *now;
> > >         if (flags & S_ATIME)
> > >                 inode->i_atime =3D *now;
> > > +       if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, fa=
lse))
> > > +               log_flags |=3D XFS_ILOG_CORE;
> > >=20
> > >         xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
> > >         xfs_trans_log_inode(tp, ip, log_flags);
> > > --
> > > 2.37.2
> > >=20
> >=20
> > I have a test (details below) that shows an open issue with NFSv4.x +
> > fscache where an xfs exported filesystem would trigger unnecessary
> > over the wire READs after a umount/mount cycle of the NFS mount.  I
> > previously tracked this down to atime updates, but never followed
> > through on any patch.  Now that Jeff worked it out and this patch is
> > under review, I built 5.19 vanilla, retested, then built 5.19 + this
> > patch and verified the problem is fixed.
>=20
> And so the question that needs to be answered is "why isn't relatime
> working for this workload to avoid unnecessary atime updates"?
>=20
> Which then makes me ask "what's changing atime on the server between
> client side reads"?
>=20
> Which then makes me wonder "what's actually changing iversion on the
> server?" because I don't think atime is the issue here.
>=20
> I suspect that Jeff's patch is affecting this test case by removing
> iversion updates when the data is written back on the server. i.e.
> delayed allocation and unwritten extent conversion will no longer
> bump iversion when they log the inode metadata changes associated
> with extent allocation to store the data being written.  There may
> be other places where Jeff's patch removes implicit iversion
> updates, too, so it may not be writeback that is the issue here.
>=20
> How that impacts on the observed behaviour is dependent on things I
> don't know, like what cachefiles is doing in the background,
> especially across NFS client unmount/mount cycles. However, this all
> makes me think the "atime is updated" behaviour is an observed
> symptom of something else changing iversion and/or cmtime between
> reads from the server...
>=20

You may be right here.

What I see with both noatime and relatime is that the first read after a
write to a file results in the i_version being incremented, but then it
doesn't change on subsequent reads. Write to the file again, and the
i_version will get incremented again on the next read and then not again
until there is a write.

--=20
Jeff Layton <jlayton@kernel.org>
