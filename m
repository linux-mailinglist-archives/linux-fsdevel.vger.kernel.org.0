Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD55F523B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJEKG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJEKG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:06:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6495C94C;
        Wed,  5 Oct 2022 03:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E29B81D26;
        Wed,  5 Oct 2022 10:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DB8C433C1;
        Wed,  5 Oct 2022 10:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664964411;
        bh=fNo5dsnOQdxgDNOIlvUZf4zaRP16kQfZ7E5TnUPsNqc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dOI/YiHeiekjpEAtH2wfyif8VtSz7tIXHDLuYIihbP3KXBIZGFk2f3XbJC6YNAqqE
         PCjSG0jbSRgRJWFClizTxynAXME8AJjc5oQOL0CMYKZ58ms/YtgeOE3mapw1Gggict
         T43hyyUp/2AvENR0N75y02/iuBoE9Rr4tSWOcKNYJge7KTPhUSF3m8e18yqGpFs6eP
         POeYA87wbyBhVJffSJAkPGiXxtI1xH03zDAZEec6QcSfjLTwiw/GyG56qM5T0mugtI
         NDcQ1AxTXMiE72U98ouqvK4rXylPXbeC6pZ8aYCzSdoeKJ/S2uMghGPdqsgRF2VMJO
         BFCweFU4dnRjQ==
Message-ID: <13714490816df1ff36ab06bbf32df5440cad7913.camel@kernel.org>
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
Date:   Wed, 05 Oct 2022 06:06:48 -0400
In-Reply-To: <166484034920.14457.15225090674729127890@noble.neil.brown.name>
References: <20220930111840.10695-1-jlayton@kernel.org>
        , <20220930111840.10695-7-jlayton@kernel.org>
         <166484034920.14457.15225090674729127890@noble.neil.brown.name>
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

On Tue, 2022-10-04 at 10:39 +1100, NeilBrown wrote:
> On Fri, 30 Sep 2022, Jeff Layton wrote:
> > Now that we can call into vfs_getattr to get the i_version field, use
> > that facility to fetch it instead of doing it in nfsd4_change_attribute=
.
> >=20
> > Neil also pointed out recently that IS_I_VERSION directory operations
> > are always logged, and so we only need to mitigate the rollback problem
> > on regular files. Also, we don't need to factor in the ctime when
> > reexporting NFS or Ceph.
> >=20
> > Set the STATX_VERSION (and BTIME) bits in the request when we're dealin=
g
> > with a v4 request. Then, instead of looking at IS_I_VERSION when
> > generating the change attr, look at the result mask and only use it if
> > STATX_VERSION is set. With this change, we can drop the fetch_iversion
> > export operation as well.
> >=20
> > Move nfsd4_change_attribute into nfsfh.c, and change it to only factor
> > in the ctime if it's a regular file and the fs doesn't advertise
> > STATX_ATTR_VERSION_MONOTONIC.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfs/export.c          |  7 -------
> >  fs/nfsd/nfs4xdr.c        |  4 +++-
> >  fs/nfsd/nfsfh.c          | 40 ++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfsfh.h          | 29 +----------------------------
> >  fs/nfsd/vfs.h            |  7 ++++++-
> >  include/linux/exportfs.h |  1 -
> >  6 files changed, 50 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > index 01596f2d0a1e..1a9d5aa51dfb 100644
> > --- a/fs/nfs/export.c
> > +++ b/fs/nfs/export.c
> > @@ -145,17 +145,10 @@ nfs_get_parent(struct dentry *dentry)
> >  	return parent;
> >  }
> > =20
> > -static u64 nfs_fetch_iversion(struct inode *inode)
> > -{
> > -	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
> > -	return inode_peek_iversion_raw(inode);
> > -}
> > -
> >  const struct export_operations nfs_export_ops =3D {
> >  	.encode_fh =3D nfs_encode_fh,
> >  	.fh_to_dentry =3D nfs_fh_to_dentry,
> >  	.get_parent =3D nfs_get_parent,
> > -	.fetch_iversion =3D nfs_fetch_iversion,
> >  	.flags =3D EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> >  		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> >  		EXPORT_OP_NOATOMIC_ATTR,
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 1e9690a061ec..779c009314c6 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -2869,7 +2869,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct=
 svc_fh *fhp,
> >  			goto out;
> >  	}
> > =20
> > -	err =3D vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS=
_STAT);
> > +	err =3D vfs_getattr(&path, &stat,
> > +			  STATX_BASIC_STATS | STATX_BTIME | STATX_VERSION,
> > +			  AT_STATX_SYNC_AS_STAT);
> >  	if (err)
> >  		goto out_nfserr;
> >  	if (!(stat.result_mask & STATX_BTIME))
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index a5b71526cee0..9168bc657378 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -634,6 +634,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> >  		stat.mtime =3D inode->i_mtime;
> >  		stat.ctime =3D inode->i_ctime;
> >  		stat.size  =3D inode->i_size;
> > +		if (v4 && IS_I_VERSION(inode)) {
> > +			stat.version =3D inode_query_iversion(inode);
> > +			stat.result_mask |=3D STATX_VERSION;
> > +		}
>=20
> This is increasingly ugly.  I wonder if it is justified at all...
>=20

I'm fine with dropping that. So if the getattrs fail, we should just not
offer up pre/post attrs?

> >  	}
> >  	if (v4)
> >  		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
> > @@ -665,6 +669,8 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> >  	if (err) {
> >  		fhp->fh_post_saved =3D false;
> >  		fhp->fh_post_attr.ctime =3D inode->i_ctime;
> > +		if (v4 && IS_I_VERSION(inode))
> > +			fhp->fh_post_attr.version =3D inode_query_iversion(inode);
>=20
> ... ditto ...
>=20
> >  	} else
> >  		fhp->fh_post_saved =3D true;
> >  	if (v4)
> > @@ -754,3 +760,37 @@ enum fsid_source fsid_source(const struct svc_fh *=
fhp)
> >  		return FSIDSOURCE_UUID;
> >  	return FSIDSOURCE_DEV;
> >  }
> > +
> > +/*
> > + * We could use i_version alone as the change attribute.  However, i_v=
ersion
> > + * can go backwards on a regular file after an unclean shutdown.  On i=
ts own
> > + * that doesn't necessarily cause a problem, but if i_version goes bac=
kwards
> > + * and then is incremented again it could reuse a value that was previ=
ously
> > + * used before boot, and a client who queried the two values might inc=
orrectly
> > + * assume nothing changed.
> > + *
> > + * By using both ctime and the i_version counter we guarantee that as =
long as
> > + * time doesn't go backwards we never reuse an old value. If the files=
ystem
> > + * advertises STATX_ATTR_VERSION_MONOTONIC, then this mitigation is no=
t needed.
> > + *
> > + * We only need to do this for regular files as well. For directories,=
 we
> > + * assume that the new change attr is always logged to stable storage =
in some
> > + * fashion before the results can be seen.
> > + */
> > +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
> > +{
> > +	u64 chattr;
> > +
> > +	if (stat->result_mask & STATX_VERSION) {
> > +		chattr =3D stat->version;
> > +
> > +		if (S_ISREG(inode->i_mode) &&
> > +		    !(stat->attributes & STATX_ATTR_VERSION_MONOTONIC)) {
>=20
> I would really rather that the fs got to make this decision.
> If it can guarantee that the i_version is monotonic even over a crash
> (which is probably can for directory, and might need changes to do for
> files) then it sets STATX_ATTR_VERSION_MONOTONIC and nfsd trusts it
> completely.
> If it cannot, then it doesn't set the flag.
> i.e. the S_ISREG() test should be in the filesystem, not in nfsd.
>=20

This sounds reasonable, but for one thing.

From RFC 7862:

   While Section 5.4 of [RFC5661] discusses
   per-file system attributes, it is expected that the value of
   change_attr_type will not depend on the value of "homogeneous" and
   will only change in the event of a migration.

The change_attr_type4 must be the same for all filehandles under a
particular filesystem.

If we do what you suggest though, then it's easily possible for the fs
to set STATX_ATTR_VERSION_MONOTONIC on=A0directories but not files. If we
later want to allow nfsd to advertise a change_attr_type4, we won't be
able to rely on the STATX_ATTR_VERSION_MONOTONIC to tell us how to fill
that out.

Maybe that's ok. I suppose we could add a new field to the export
options that filesystems can set to advertise what sort of change attr
they offer?

>=20
> > +			chattr +=3D (u64)stat->ctime.tv_sec << 30;
> > +			chattr +=3D stat->ctime.tv_nsec;
> > +		}
> > +	} else {
> > +		chattr =3D time_to_chattr(&stat->ctime);
> > +	}
> > +	return chattr;
> > +}
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index c3ae6414fc5c..4c223a7a91d4 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -291,34 +291,7 @@ static inline void fh_clear_pre_post_attrs(struct =
svc_fh *fhp)
> >  	fhp->fh_pre_saved =3D false;
> >  }
> > =20
> > -/*
> > - * We could use i_version alone as the change attribute.  However,
> > - * i_version can go backwards after a reboot.  On its own that doesn't
> > - * necessarily cause a problem, but if i_version goes backwards and th=
en
> > - * is incremented again it could reuse a value that was previously use=
d
> > - * before boot, and a client who queried the two values might
> > - * incorrectly assume nothing changed.
> > - *
> > - * By using both ctime and the i_version counter we guarantee that as
> > - * long as time doesn't go backwards we never reuse an old value.
> > - */
> > -static inline u64 nfsd4_change_attribute(struct kstat *stat,
> > -					 struct inode *inode)
> > -{
> > -	if (inode->i_sb->s_export_op->fetch_iversion)
> > -		return inode->i_sb->s_export_op->fetch_iversion(inode);
> > -	else if (IS_I_VERSION(inode)) {
> > -		u64 chattr;
> > -
> > -		chattr =3D  stat->ctime.tv_sec;
> > -		chattr <<=3D 30;
> > -		chattr +=3D stat->ctime.tv_nsec;
> > -		chattr +=3D inode_query_iversion(inode);
> > -		return chattr;
> > -	} else
> > -		return time_to_chattr(&stat->ctime);
> > -}
> > -
> > +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
> >  extern void fh_fill_pre_attrs(struct svc_fh *fhp);
> >  extern void fh_fill_post_attrs(struct svc_fh *fhp);
> >  extern void fh_fill_both_attrs(struct svc_fh *fhp);
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index c95cd414b4bb..a905f59481ee 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -168,9 +168,14 @@ static inline void fh_drop_write(struct svc_fh *fh=
)
> > =20
> >  static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat =
*stat)
> >  {
> > +	u32 request_mask =3D STATX_BASIC_STATS;
> >  	struct path p =3D {.mnt =3D fh->fh_export->ex_path.mnt,
> >  			 .dentry =3D fh->fh_dentry};
> > -	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
> > +
> > +	if (fh->fh_maxsize =3D=3D NFS4_FHSIZE)
> > +		request_mask |=3D (STATX_BTIME | STATX_VERSION);
> > +
> > +	return nfserrno(vfs_getattr(&p, stat, request_mask,
> >  				    AT_STATX_SYNC_AS_STAT));
> >  }
> > =20
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index fe848901fcc3..9f4d4bcbf251 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -213,7 +213,6 @@ struct export_operations {
> >  			  bool write, u32 *device_generation);
> >  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> >  			     int nr_iomaps, struct iattr *iattr);
> > -	u64 (*fetch_iversion)(struct inode *);
> >  #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
> >  #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
> >  #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unli=
nk */
> > --=20
> > 2.37.3
> >=20
> >=20
>=20
> Definitely more to like than to dislike here, so
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown

--=20
Jeff Layton <jlayton@kernel.org>
