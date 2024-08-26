Return-Path: <linux-fsdevel+bounces-27193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAB95F636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 18:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32731282911
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2871946B8;
	Mon, 26 Aug 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4zmKzgj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19218785F;
	Mon, 26 Aug 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688834; cv=none; b=EtP5ngsVeZ7z+ceDdpGUyZR+9UBOodY4HIn7JpaWZeIp/szW5Br/blK7ybZkqMx8h3anq0Jq7RdHJT3C0bgOWd6K6xDortKb7YgGZBOxrtSSJxieVcGtomXh+X74DKebP9njv9WeuWtFzuuRcSJAZg8ySgXSnysWZzsfZYx0pPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688834; c=relaxed/simple;
	bh=jFpZK9nsKs4mWto4bNPc+h/jFB4uki0lG3Gwb9eCM+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIaPfKqXCSX5/0701m/Q1giXtYRS6VtVBPCS4fB/en7WyDjdMuoWNERwPK/f/j0Ju5L2FVZ7LV47N2nQwb4NKOFPYNBPiWZycAGyxhGvhL9G2iIZAnhjinBbK6Mm+fpj5IR4MNwTgfKNCBkWRiHhdNH6560jlZ2KU69aIr/ax2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4zmKzgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0E8C52FC0;
	Mon, 26 Aug 2024 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688834;
	bh=jFpZK9nsKs4mWto4bNPc+h/jFB4uki0lG3Gwb9eCM+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I4zmKzgj8xrqcNeD57cNr23aOraaojN/ZomzJ48tjL8euhKFhbrs0FxoX9MhYiKOx
	 XF0uOnr0STR6aTE+tAVXECMwqlpGO5ELAuEPSS/EbLp/ca3+/8iy2pYln0yk9DiHz9
	 5tIvQ+Vk3K/ILrv0foahD4aqekO2IiFrIMrAm+GDuxxPWdFUrdK3WXR6w5TehTxL6R
	 gT8JqlGrFm4ju2zyZA9Zkow7SV/SfKvJcROGtIl0pAYjZhb0PiB5Pj7LTp8K7biSA9
	 nI8ZGl89gJp+Eb1yH+KmsD8zXcC+TsZ2ixOiuUWxqmUQaqqG7aM4NN+oue+xZEL2wO
	 6XS6xKV/KxD9g==
Message-ID: <d438bc3a58fcb6bdbbf39b5ce585deef8d44c0eb.camel@kernel.org>
Subject: Re: [PATCH] fs/nfsd: fix update of inode attrs in CB_GETATTR
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Tom Talpey
 <tom@talpey.com>,  Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Mon, 26 Aug 2024 12:13:51 -0400
In-Reply-To: <8708e2e4-b9e9-45a7-8aa5-2f06234d3ae2@oracle.com>
References: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
	 <8708e2e4-b9e9-45a7-8aa5-2f06234d3ae2@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-26 at 08:31 -0700, Dai Ngo wrote:
>=20
> On 8/24/24 5:46 AM, Jeff Layton wrote:
> > Currently, we copy the mtime and ctime to the in-core inode and then
> > mark the inode dirty. This is fine for certain types of filesystems, bu=
t
> > not all. Some require a real setattr to properly change these values
> > (e.g. ceph or reexported NFS).
> >=20
> > Fix this code to call notify_change() instead, which is the proper way
> > to effect a setattr. There is one problem though:
> >=20
> > In this case, the client is holding a write delegation and has sent us
> > attributes to update our cache. We don't want to break the delegation
> > for this since that would defeat the purpose.
>=20
> I think this won't happen with NFS since nfsd_breaker_owns_lease detects
> its own lease and won't break the delegation.
>=20

I don't think that works here. In this case, we've gotten a GETATTR
request from a different client than the lease holder. So the breaker
in this case does _not_ own the lease.

>=20
> > =C2=A0 Add a new ATTR_DELEG flag
> > that makes notify_change bypass the try_break_deleg call.
> >=20
> > Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegati=
on")
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > One more CB_GETATTR fix. This one involves a little change at the VFS
> > layer to avoid breaking the delegation.
> >=20
> > Christian, unless you have objections, this should probably go in
> > via Chuck's tree as this patch depends on a nfsd patch [1] that I sent
> > yesterday. An A-b or R-b would be welcome though.
> >=20
> > [1]: https://lore.kernel.org/linux-nfs/20240823-nfsd-fixes-v1-1-fc99aa1=
6f6a0@kernel.org/T/#u
> > ---
> > =C2=A0 fs/attr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 ++++++---
> > =C2=A0 fs/nfsd/nfs4state.c | 18 +++++++++++++-----
> > =C2=A0 fs/nfsd/nfs4xdr.c=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 fs/nfsd/state.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 include/linux/fs.h=C2=A0 |=C2=A0 1 +
> > =C2=A0 5 files changed, 22 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/attr.c b/fs/attr.c
> > index 960a310581eb..a40a2fb406f0 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -489,9 +489,12 @@ int notify_change(struct mnt_idmap *idmap, struct =
dentry *dentry,
> > =C2=A0=C2=A0	error =3D security_inode_setattr(idmap, dentry, attr);
> > =C2=A0=C2=A0	if (error)
> > =C2=A0=C2=A0		return error;
> > -	error =3D try_break_deleg(inode, delegated_inode);
> > -	if (error)
> > -		return error;
> > +
> > +	if (!(ia_valid & ATTR_DELEG)) {
> > +		error =3D try_break_deleg(inode, delegated_inode);
> > +		if (error)
> > +			return error;
> > +	}
> > =C2=A0=20
> > =C2=A0=C2=A0	if (inode->i_op->setattr)
> > =C2=A0=C2=A0		error =3D inode->i_op->setattr(idmap, dentry, attr);
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index dafff707e23a..e0e3d3ca0d45 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -8815,7 +8815,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_stat=
e *cstate,
> > =C2=A0 /**
> > =C2=A0=C2=A0 * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes =
conflict
> > =C2=A0=C2=A0 * @rqstp: RPC transaction context
> > - * @inode: file to be checked for a conflict
> > + * @dentry: dentry of inode to be checked for a conflict
> > =C2=A0=C2=A0 * @modified: return true if file was modified
> > =C2=A0=C2=A0 * @size: new size of file if modified is true
> > =C2=A0=C2=A0 *
> > @@ -8830,7 +8830,7 @@ nfsd4_get_writestateid(struct nfsd4_compound_stat=
e *cstate,
> > =C2=A0=C2=A0 * code is returned.
> > =C2=A0=C2=A0 */
> > =C2=A0 __be32
> > -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *ino=
de,
> > +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *de=
ntry,
> > =C2=A0=C2=A0				bool *modified, u64 *size)
> > =C2=A0 {
> > =C2=A0=C2=A0	__be32 status;
> > @@ -8840,6 +8840,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqs=
tp, struct inode *inode,
> > =C2=A0=C2=A0	struct nfs4_delegation *dp;
> > =C2=A0=C2=A0	struct iattr attrs;
> > =C2=A0=C2=A0	struct nfs4_cb_fattr *ncf;
> > +	struct inode *inode =3D d_inode(dentry);
> > =C2=A0=20
> > =C2=A0=C2=A0	*modified =3D false;
> > =C2=A0=C2=A0	ctx =3D locks_inode_context(inode);
> > @@ -8887,15 +8888,22 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *r=
qstp, struct inode *inode,
> > =C2=A0=C2=A0					ncf->ncf_cur_fsize !=3D ncf->ncf_cb_fsize))
> > =C2=A0=C2=A0				ncf->ncf_file_modified =3D true;
> > =C2=A0=C2=A0			if (ncf->ncf_file_modified) {
> > +				int err;
> > +
> > =C2=A0=C2=A0				/*
> > =C2=A0=C2=A0				 * Per section 10.4.3 of RFC 8881, the server would
> > =C2=A0=C2=A0				 * not update the file's metadata with the client's
> > =C2=A0=C2=A0				 * modified size
> > =C2=A0=C2=A0				 */
> > =C2=A0=C2=A0				attrs.ia_mtime =3D attrs.ia_ctime =3D current_time(inod=
e);
> > -				attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME;
> > -				setattr_copy(&nop_mnt_idmap, inode, &attrs);
> > -				mark_inode_dirty(inode);
> > +				attrs.ia_valid =3D ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> > +				inode_lock(inode);
> > +				err =3D notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > +				inode_unlock(inode);
> > +				if (err) {
> > +					nfs4_put_stid(&dp->dl_stid);
> > +					return nfserrno(err);
> > +				}
> > =C2=A0=C2=A0				ncf->ncf_cur_fsize =3D ncf->ncf_cb_fsize;
> > =C2=A0=C2=A0				*size =3D ncf->ncf_cur_fsize;
> > =C2=A0=C2=A0				*modified =3D true;
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 43ccf6119cf1..97f583777972 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3565,7 +3565,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr,
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	args.size =3D 0;
> > =C2=A0=C2=A0	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE=
)) {
> > -		status =3D nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry),
> > +		status =3D nfsd4_deleg_getattr_conflict(rqstp, dentry,
> > =C2=A0=C2=A0					&file_modified, &size);
> > =C2=A0=C2=A0		if (status)
> > =C2=A0=C2=A0			goto out;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index ffc217099d19..ec4559ecd193 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -781,5 +781,5 @@ static inline bool try_to_expire_client(struct nfs4=
_client *clp)
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqst=
p,
> > -		struct inode *inode, bool *file_modified, u64 *size);
> > +		struct dentry *dentry, bool *file_modified, u64 *size);
> > =C2=A0 #endif=C2=A0=C2=A0 /* NFSD4_STATE_H */
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 0283cf366c2a..3fe289c74869 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -208,6 +208,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff=
_t offset,
> > =C2=A0 #define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
> > =C2=A0 #define ATTR_TIMES_SET	(1 << 16)
> > =C2=A0 #define ATTR_TOUCH	(1 << 17)
> > +#define ATTR_DELEG	(1 << 18) /* Delegated attrs (don't break) */
> > =C2=A0=20
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Whiteout is represented by a char device.=C2=A0 The foll=
owing constants define the
> >=20
> > ---
> > base-commit: a204501e1743d695ca2930ed25a2be9f8ced96d3
> > change-id: 20240823-nfsd-fixes-61f0c785d125
> >=20
> > Best regards,

--=20
Jeff Layton <jlayton@kernel.org>

