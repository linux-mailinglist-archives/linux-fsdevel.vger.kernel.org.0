Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D095F650E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJFLPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 07:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiJFLPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:15:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B4B4B;
        Thu,  6 Oct 2022 04:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27A58B82064;
        Thu,  6 Oct 2022 11:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6832C433C1;
        Thu,  6 Oct 2022 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665054906;
        bh=i83rk773bIlMl/lhhxfKiM+2pC52aLVNb2rW7QrbO70=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h67zJZiksKPfsBZ9je/AlkhyI2X9dBWVPgzV2Qv/KbcJman8cpJqgavb3G14je7JU
         nFdBXFD3j2F2rSz8neXCEPJf+pN/E+/6szcQ5lgmugB7Yl4yc3tqrHt4IGDyv/1HH/
         eCwzZ783f9Wqm+xcaIz/OeDiEMhoEt6aZW/QU7Usr/bjvqteYeio7qhJh3qGLA4oAj
         zuKSlPDjOFcWmjgmG0LjFZzVISBCOuMQcM4w1xuyhkGgJkWiDvZ1lbeqraJyMs+GTy
         Y896eWsAIXs7JvOzQ4Q2rK/8jwGK0Tfw9rEB8VXyTH4n0PPeqSqI3DAW9z0oIx2Uju
         qU3YMqOlKxI+Q==
Message-ID: <c1a669c511c758bd22796f0c285e0c8097de06dd.camel@kernel.org>
Subject: Re: [PATCH v6 6/9] nfsd: use the getattr operation to fetch
 i_version
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Thu, 06 Oct 2022 07:15:03 -0400
In-Reply-To: <166500444418.16615.7547789313879225413@noble.neil.brown.name>
References: <20220930111840.10695-1-jlayton@kernel.org>
        , <20220930111840.10695-7-jlayton@kernel.org>
        , <166484034920.14457.15225090674729127890@noble.neil.brown.name>
        , <13714490816df1ff36ab06bbf32df5440cad7913.camel@kernel.org>
         <166500444418.16615.7547789313879225413@noble.neil.brown.name>
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

On Thu, 2022-10-06 at 08:14 +1100, NeilBrown wrote:
> On Wed, 05 Oct 2022, Jeff Layton wrote:
> > On Tue, 2022-10-04 at 10:39 +1100, NeilBrown wrote:
> > > On Fri, 30 Sep 2022, Jeff Layton wrote:
> > > > Now that we can call into vfs_getattr to get the i_version field, u=
se
> > > > that facility to fetch it instead of doing it in nfsd4_change_attri=
bute.
> > > >=20
> > > > Neil also pointed out recently that IS_I_VERSION directory operatio=
ns
> > > > are always logged, and so we only need to mitigate the rollback pro=
blem
> > > > on regular files. Also, we don't need to factor in the ctime when
> > > > reexporting NFS or Ceph.
> > > >=20
> > > > Set the STATX_VERSION (and BTIME) bits in the request when we're de=
aling
> > > > with a v4 request. Then, instead of looking at IS_I_VERSION when
> > > > generating the change attr, look at the result mask and only use it=
 if
> > > > STATX_VERSION is set. With this change, we can drop the fetch_ivers=
ion
> > > > export operation as well.
> > > >=20
> > > > Move nfsd4_change_attribute into nfsfh.c, and change it to only fac=
tor
> > > > in the ctime if it's a regular file and the fs doesn't advertise
> > > > STATX_ATTR_VERSION_MONOTONIC.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/nfs/export.c          |  7 -------
> > > >  fs/nfsd/nfs4xdr.c        |  4 +++-
> > > >  fs/nfsd/nfsfh.c          | 40 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  fs/nfsd/nfsfh.h          | 29 +----------------------------
> > > >  fs/nfsd/vfs.h            |  7 ++++++-
> > > >  include/linux/exportfs.h |  1 -
> > > >  6 files changed, 50 insertions(+), 38 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > > > index 01596f2d0a1e..1a9d5aa51dfb 100644
> > > > --- a/fs/nfs/export.c
> > > > +++ b/fs/nfs/export.c
> > > > @@ -145,17 +145,10 @@ nfs_get_parent(struct dentry *dentry)
> > > >  	return parent;
> > > >  }
> > > > =20
> > > > -static u64 nfs_fetch_iversion(struct inode *inode)
> > > > -{
> > > > -	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
> > > > -	return inode_peek_iversion_raw(inode);
> > > > -}
> > > > -
> > > >  const struct export_operations nfs_export_ops =3D {
> > > >  	.encode_fh =3D nfs_encode_fh,
> > > >  	.fh_to_dentry =3D nfs_fh_to_dentry,
> > > >  	.get_parent =3D nfs_get_parent,
> > > > -	.fetch_iversion =3D nfs_fetch_iversion,
> > > >  	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> > > >  		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> > > >  		EXPORT_OP_NOATOMIC_ATTR,
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index 1e9690a061ec..779c009314c6 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -2869,7 +2869,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, st=
ruct svc_fh *fhp,
> > > >  			goto out;
> > > >  	}
> > > > =20
> > > > -	err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYN=
C_AS_STAT);
> > > > +	err =3D vfs_getattr(&path, &stat,
> > > > +			  STATX_BASIC_STATS | STATX_BTIME | STATX_VERSION,
> > > > +			  AT_STATX_SYNC_AS_STAT);
> > > >  	if (err)
> > > >  		goto out_nfserr;
> > > >  	if (!(stat.result_mask & STATX_BTIME))
> > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > index a5b71526cee0..9168bc657378 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -634,6 +634,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> > > >  		stat.mtime =3D inode->i_mtime;
> > > >  		stat.ctime =3D inode->i_ctime;
> > > >  		stat.size  =3D inode->i_size;
> > > > +		if (v4 && IS_I_VERSION(inode)) {
> > > > +			stat.version =3D inode_query_iversion(inode);
> > > > +			stat.result_mask |=3D STATX_VERSION;
> > > > +		}
> > >=20
> > > This is increasingly ugly.  I wonder if it is justified at all...
> > >=20
> >=20
> > I'm fine with dropping that. So if the getattrs fail, we should just no=
t
> > offer up pre/post attrs?
> >=20
> > > >  	}
> > > >  	if (v4)
> > > >  		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
> > > > @@ -665,6 +669,8 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> > > >  	if (err) {
> > > >  		fhp->fh_post_saved =3D false;
> > > >  		fhp->fh_post_attr.ctime =3D inode->i_ctime;
> > > > +		if (v4 && IS_I_VERSION(inode))
> > > > +			fhp->fh_post_attr.version =3D inode_query_iversion(inode);
> > >=20
> > > ... ditto ...
> > >=20
> > > >  	} else
> > > >  		fhp->fh_post_saved =3D true;
> > > >  	if (v4)
> > > > @@ -754,3 +760,37 @@ enum fsid_source fsid_source(const struct svc_=
fh *fhp)
> > > >  		return FSIDSOURCE_UUID;
> > > >  	return FSIDSOURCE_DEV;
> > > >  }
> > > > +
> > > > +/*
> > > > + * We could use i_version alone as the change attribute.  However,=
 i_version
> > > > + * can go backwards on a regular file after an unclean shutdown.  =
On its own
> > > > + * that doesn't necessarily cause a problem, but if i_version goes=
 backwards
> > > > + * and then is incremented again it could reuse a value that was p=
reviously
> > > > + * used before boot, and a client who queried the two values might=
 incorrectly
> > > > + * assume nothing changed.
> > > > + *
> > > > + * By using both ctime and the i_version counter we guarantee that=
 as long as
> > > > + * time doesn't go backwards we never reuse an old value. If the f=
ilesystem
> > > > + * advertises STATX_ATTR_VERSION_MONOTONIC, then this mitigation i=
s not needed.
> > > > + *
> > > > + * We only need to do this for regular files as well. For director=
ies, we
> > > > + * assume that the new change attr is always logged to stable stor=
age in some
> > > > + * fashion before the results can be seen.
> > > > + */
> > > > +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode=
)
> > > > +{
> > > > +	u64 chattr;
> > > > +
> > > > +	if (stat->result_mask & STATX_VERSION) {
> > > > +		chattr =3D stat->version;
> > > > +
> > > > +		if (S_ISREG(inode->i_mode) &&
> > > > +		    !(stat->attributes & STATX_ATTR_VERSION_MONOTONIC)) {
> > >=20
> > > I would really rather that the fs got to make this decision.
> > > If it can guarantee that the i_version is monotonic even over a crash
> > > (which is probably can for directory, and might need changes to do fo=
r
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
> >    While Section 5.4 of [RFC5661] discusses
> >    per-file system attributes, it is expected that the value of
> >    change_attr_type will not depend on the value of "homogeneous" and
> >    will only change in the event of a migration.
> >=20
> > The change_attr_type4 must be the same for all filehandles under a
> > particular filesystem.
> >=20
> > If we do what you suggest though, then it's easily possible for the fs
> > to set STATX_ATTR_VERSION_MONOTONIC on=A0directories but not files. If =
we
> > later want to allow nfsd to advertise a change_attr_type4, we won't be
> > able to rely on the STATX_ATTR_VERSION_MONOTONIC to tell us how to fill
> > that out.
> >=20
> > Maybe that's ok. I suppose we could add a new field to the export
> > options that filesystems can set to advertise what sort of change attr
> > they offer?
> >=20
>=20
> There are 3 cases:
> 1/ a file/dir which advertises MONOTONIC is easy to handle.
> 2/ an IS_I_VERSION file/dir that does not advertise MONOTONIC will only f=
ail
>    to be MONOTONIC across unclean restart (correct?).  nfsd can
>    compensate using an xattr on the root to count crashes, or just adding=
 ctime.
> 3/ a non-IS_I_VERSION fs that does not advertise MONOTONIC cannot
>    be compensated for by nfsd.
>=20
> If we ever want nfsd to advertise MONOTONIC, then we must be able to
> reject non-IS_I_VERSION filesystems that don't advertise MONOTONIC on
> all files.
>=20
> Maybe we need a global nfsd option which defaults to "monotoric" and
> causes those files to be rejected, but can be set to "non-monotonic" and
> then allows all files to be exported.
>=20
> It would be nice to make it easy to run multiple nfsd instances each on a
> different IP address.  Each can then have different options.  This could
> also be used to reexport an NFS mount using unmodified filehandles.
>=20
> Currently you need a network namespace to create a new nfsd.  I wonder
> if that is a little too much of a barrier.  But maybe we could automate
> the creation of working network namespaces for nfsd....
>=20

My current thinking is to just allow the filesystem to set
STATX_ATTR_VERSION_MONOTONIC flag on a per-inode basis, and create a new
change_attr_type() export operation and leave it up to the filesystem to
fill that out appropriately.

I think that'll give us maximum flexibility, and would also allow NFS to
pass the change attr type from the server directly through to the client
when reexporting.
--=20
Jeff Layton <jlayton@kernel.org>
