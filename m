Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837E85F55FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJEN5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJEN5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:57:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952717C1D1;
        Wed,  5 Oct 2022 06:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C19B81B58;
        Wed,  5 Oct 2022 13:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68FCC433D6;
        Wed,  5 Oct 2022 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664978256;
        bh=4o5uAc68TgM91z72jHrenYorQWCxkZ8HM/tP6gKu8c4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GOTGptbGKp4Y0qn0o7jHwhi/FMFcBlbxswxoALLA2aFncn3rglq4F7K/9NcKvrI9S
         vF3o7B0o08Vu04iMuTbHKvRm19NuKLh97jti10YwhQfgZotWK/6Pn/4W9sd5Ww4v6S
         HOh1WeDZ5caoK9KscHy25ngX4AqNDICiuTujIP32d57F52HVdHlA8QsUUCjrgtJ0Yt
         mBvKK1EekUa9JvyeIbwxcECynGhiIWrDxz0KUEwsZ6nV+ON19WM0mV5kboZ6oG3T/q
         XMGbmEyn4dzuFc2VKHoPkLA8zUg/ZuJp3AuFzi4dq8shvzxNVy4YW76fn2jd8uCDKY
         U0XTZSnt9nWwQ==
Message-ID: <04663cb6b2fa64d540575302e2e8b74e38c9b726.camel@kernel.org>
Subject: Re: [PATCH v6 6/9] nfsd: use the getattr operation to fetch
 i_version
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "neilb@suse.de" <neilb@suse.de>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Wed, 05 Oct 2022 09:57:33 -0400
In-Reply-To: <cdbd9c6917ab66164596b95dad90625f46221b70.camel@hammerspace.com>
References: <20220930111840.10695-1-jlayton@kernel.org>
                 , <20220930111840.10695-7-jlayton@kernel.org>
         <166484034920.14457.15225090674729127890@noble.neil.brown.name>
         <13714490816df1ff36ab06bbf32df5440cad7913.camel@kernel.org>
         <cdbd9c6917ab66164596b95dad90625f46221b70.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-10-05 at 13:34 +0000, Trond Myklebust wrote:
> On Wed, 2022-10-05 at 06:06 -0400, Jeff Layton wrote:
> > On Tue, 2022-10-04 at 10:39 +1100, NeilBrown wrote:
> > > On Fri, 30 Sep 2022, Jeff Layton wrote:
> > > > Now that we can call into vfs_getattr to get the i_version field,
> > > > use
> > > > that facility to fetch it instead of doing it in
> > > > nfsd4_change_attribute.
> > > >=20
> > > > Neil also pointed out recently that IS_I_VERSION directory
> > > > operations
> > > > are always logged, and so we only need to mitigate the rollback
> > > > problem
> > > > on regular files. Also, we don't need to factor in the ctime when
> > > > reexporting NFS or Ceph.
> > > >=20
> > > > Set the STATX_VERSION (and BTIME) bits in the request when we're
> > > > dealing
> > > > with a v4 request. Then, instead of looking at IS_I_VERSION when
> > > > generating the change attr, look at the result mask and only use
> > > > it if
> > > > STATX_VERSION is set. With this change, we can drop the
> > > > fetch_iversion
> > > > export operation as well.
> > > >=20
> > > > Move nfsd4_change_attribute into nfsfh.c, and change it to only
> > > > factor
> > > > in the ctime if it's a regular file and the fs doesn't advertise
> > > > STATX_ATTR_VERSION_MONOTONIC.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > =A0fs/nfs/export.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 7 -------
> > > > =A0fs/nfsd/nfs4xdr.c=A0=A0=A0=A0=A0=A0=A0 |=A0 4 +++-
> > > > =A0fs/nfsd/nfsfh.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 40
> > > > ++++++++++++++++++++++++++++++++++++++++
> > > > =A0fs/nfsd/nfsfh.h=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 29 +---------------=
-------------
> > > > =A0fs/nfsd/vfs.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 7 ++++++-
> > > > =A0include/linux/exportfs.h |=A0 1 -
> > > > =A06 files changed, 50 insertions(+), 38 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > > > index 01596f2d0a1e..1a9d5aa51dfb 100644
> > > > --- a/fs/nfs/export.c
> > > > +++ b/fs/nfs/export.c
> > > > @@ -145,17 +145,10 @@ nfs_get_parent(struct dentry *dentry)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0return parent;
> > > > =A0}
> > > > =A0
> > > > -static u64 nfs_fetch_iversion(struct inode *inode)
> > > > -{
> > > > -=A0=A0=A0=A0=A0=A0=A0nfs_revalidate_inode(inode, NFS_INO_INVALID_C=
HANGE);
> > > > -=A0=A0=A0=A0=A0=A0=A0return inode_peek_iversion_raw(inode);
> > > > -}
> > > > -
> > > > =A0const struct export_operations nfs_export_ops =3D {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0.encode_fh =3D nfs_encode_fh,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0.fh_to_dentry =3D nfs_fh_to_dentry,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0.get_parent =3D nfs_get_parent,
> > > > -=A0=A0=A0=A0=A0=A0=A0.fetch_iversion =3D nfs_fetch_iversion,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBT=
REECHK|
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0EXPORT_OP_CLOSE_BEF=
ORE_UNLINK|EXPORT_OP_REMOTE_FS
> > > > >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0EXPORT_OP_NOATOMIC_=
ATTR,
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index 1e9690a061ec..779c009314c6 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -2869,7 +2869,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr,
> > > > struct svc_fh *fhp,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0goto out;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0}
> > > > =A0
> > > > -=A0=A0=A0=A0=A0=A0=A0err =3D vfs_getattr(&path, &stat, STATX_BASIC=
_STATS,
> > > > AT_STATX_SYNC_AS_STAT);
> > > > +=A0=A0=A0=A0=A0=A0=A0err =3D vfs_getattr(&path, &stat,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 STATX_BASIC_STATS | STATX_BTIME |
> > > > STATX_VERSION,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 AT_STATX_SYNC_AS_STAT);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (err)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto out_nfserr;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (!(stat.result_mask & STATX_BTIME))
> > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > index a5b71526cee0..9168bc657378 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -634,6 +634,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0stat.mtime =3D inod=
e->i_mtime;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0stat.ctime =3D inod=
e->i_ctime;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0stat.size=A0 =3D in=
ode->i_size;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (v4 && IS_I_VERSIO=
N(inode)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0stat.version =3D
> > > > inode_query_iversion(inode);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0stat.result_mask |=3D STATX_VERSION;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > >=20
> > > This is increasingly ugly.=A0 I wonder if it is justified at all...
> > >=20
> >=20
> > I'm fine with dropping that. So if the getattrs fail, we should just
> > not
> > offer up pre/post attrs?
> >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0}
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (v4)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_pre_change =
=3D
> > > > nfsd4_change_attribute(&stat, inode);
> > > > @@ -665,6 +669,8 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (err) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_saved =
=3D false;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_attr.c=
time =3D inode->i_ctime;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (v4 && IS_I_VERSIO=
N(inode))
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0fhp->fh_post_attr.version =3D
> > > > inode_query_iversion(inode);
> > >=20
> > > ... ditto ...
> > >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0} else
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0fhp->fh_post_saved =
=3D true;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (v4)
> > > > @@ -754,3 +760,37 @@ enum fsid_source fsid_source(const struct
> > > > svc_fh *fhp)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return FSIDSOURCE_U=
UID;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0return FSIDSOURCE_DEV;
> > > > =A0}
> > > > +
> > > > +/*
> > > > + * We could use i_version alone as the change attribute.=A0
> > > > However, i_version
> > > > + * can go backwards on a regular file after an unclean
> > > > shutdown.=A0 On its own
> > > > + * that doesn't necessarily cause a problem, but if i_version
> > > > goes backwards
> > > > + * and then is incremented again it could reuse a value that was
> > > > previously
> > > > + * used before boot, and a client who queried the two values
> > > > might incorrectly
> > > > + * assume nothing changed.
> > > > + *
> > > > + * By using both ctime and the i_version counter we guarantee
> > > > that as long as
> > > > + * time doesn't go backwards we never reuse an old value. If the
> > > > filesystem
> > > > + * advertises STATX_ATTR_VERSION_MONOTONIC, then this mitigation
> > > > is not needed.
> > > > + *
> > > > + * We only need to do this for regular files as well. For
> > > > directories, we
> > > > + * assume that the new change attr is always logged to stable
> > > > storage in some
> > > > + * fashion before the results can be seen.
> > > > + */
> > > > +u64 nfsd4_change_attribute(struct kstat *stat, struct inode
> > > > *inode)
> > > > +{
> > > > +=A0=A0=A0=A0=A0=A0=A0u64 chattr;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0if (stat->result_mask & STATX_VERSION) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0chattr =3D stat->vers=
ion;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (S_ISREG(inode->i_=
mode) &&
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !(stat->att=
ributes &
> > > > STATX_ATTR_VERSION_MONOTONIC)) {
> > >=20
> > > I would really rather that the fs got to make this decision.
> > > If it can guarantee that the i_version is monotonic even over a
> > > crash
> > > (which is probably can for directory, and might need changes to do
> > > for
> > > files) then it sets STATX_ATTR_VERSION_MONOTONIC and nfsd trusts it
> > > completely.
> > > If it cannot, then it doesn't set the flag.
> > > i.e. the S_ISREG() test should be in the filesystem, not in nfsd.
> > >=20
> >=20
> > This sounds reasonable, but for one thing.
> >=20
> > From RFC 7862:
> >=20
> > =A0=A0 While Section 5.4 of [RFC5661] discusses
> > =A0=A0 per-file system attributes, it is expected that the value of
> > =A0=A0 change_attr_type will not depend on the value of "homogeneous" a=
nd
> > =A0=A0 will only change in the event of a migration.
> >=20
> > The change_attr_type4 must be the same for all filehandles under a
> > particular filesystem.
> >=20
> > If we do what you suggest though, then it's easily possible for the
> > fs
> > to set STATX_ATTR_VERSION_MONOTONIC on=A0directories but not files. If
> > we
> > later want to allow nfsd to advertise a change_attr_type4, we won't
> > be
> > able to rely on the STATX_ATTR_VERSION_MONOTONIC to tell us how to
> > fill
> > that out.
>=20
> That will break clients. So no, that's not acceptable.
>=20

Yeah. This is why I mentioned that this flag would have been better
advertised via fsinfo(), had that been a thing.

One option is to just document that an fs must advertise the same flag
value for all inodes.

Alternately, we could allow the fs to set the STATX_ATTR_* flag with
per-inode granularity, and for nfsd, just add a new change_attr_type()
op to export_operations. Most filesystems would just have that return a
hardcoded value, but an nfs reexport could just pass through whatever
value it got from the server.
--=20
Jeff Layton <jlayton@kernel.org>
