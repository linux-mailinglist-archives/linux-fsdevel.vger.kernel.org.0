Return-Path: <linux-fsdevel+bounces-14747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647087ED20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F077B2822CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97A535A0;
	Mon, 18 Mar 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op7SoSV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5D4F61C;
	Mon, 18 Mar 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778331; cv=none; b=h0lT3zPJiKzFSjn2uPQ2D3MuwRRuiVaBlFvzL2njooGhZ+FkgvStU6Q5pAG0lRh07YoQqukqfQhNrE+ilCFDydHWSYL0oHf82zu3/fB2NkW5sNAN46JIgcZXJhKB5r8+mSZavSJ+X/r8VF+utxIQqpLFSqliO0TNnW1u+Qo6XWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778331; c=relaxed/simple;
	bh=Kn4o8Jmzs1wSefviS6SkJNkoV9jzf56ICbsm0aBl1k0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBHV9PJ34+NVzZJ3zYnvAx6JBN+rgW47Pg4YLBuHxivuhtahlTfzGIcT7qNg+bZB6/6fgKSfqLkm8RF5+N89kDmzcWMov6ofmyI70DZeCCxGfggsLIbGhR8fi1uJCY6QNHGs2UGPVtbqS+EKST8pGMihseOyNXR9jaU7wKXSC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op7SoSV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F59AC433C7;
	Mon, 18 Mar 2024 16:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710778331;
	bh=Kn4o8Jmzs1wSefviS6SkJNkoV9jzf56ICbsm0aBl1k0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=op7SoSV3O5v/lsn33DS9CrLL5zZyTwFYeU+33Jz+gxVkLLWoQ7l+0DdWt5E/mGicN
	 t8ll8rQI0ppk9+RpwclBAnHyCOCFeVLC0xJcltquAGUtGPZPN6GTaR33ogWoRn25RL
	 vD8+aDpovrJxqgquCQa9dJJd9V3XC94/8ERDf9X2yk05j1qQ3Fqm0ZwbKpQlHifyTr
	 jWVYUuOOrKLJzhXy5hsSqvJslGyAyGNj8aqvz/2OvDa2aXeeNL9J9Sowp7gEllXEtJ
	 9hpw1dZBxcUJEi/x2V1ls4RhckzTe12Z6guT+uYbMdvxNOujPkwYtbHNVlXmFs976e
	 aD7jr7R2ybE6Q==
Message-ID: <6bf5ecb35cb3c244c072d0ab5248a2b0b1da25e0.camel@kernel.org>
Subject: Re: [PATCH RFC 12/24] nfsd: encoders and decoders for
 GET_DIR_DELEGATION
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexander Aring
 <alex.aring@gmail.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo
 Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Howells <dhowells@redhat.com>, Tyler Hicks
 <code@tyhicks.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org,  samba-technical@lists.samba.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 18 Mar 2024 12:12:06 -0400
In-Reply-To: <ZfcNh4O3i19P25h1@manet.1015granger.net>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
	 <20240315-dir-deleg-v1-12-a1d6209a3654@kernel.org>
	 <ZfcNh4O3i19P25h1@manet.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-17 at 11:34 -0400, Chuck Lever wrote:
> On Fri, Mar 15, 2024 at 12:53:03PM -0400, Jeff Layton wrote:
> > This adds basic infrastructure for handing GET_DIR_DELEGATION calls fro=
m
> > clients, including the  decoders and encoders. For now, the server side
> > always just returns that the  delegation is GDDR_UNAVAIL (and that we
> > won't call back).
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c   | 30 ++++++++++++++++++++++
> >  fs/nfsd/nfs4xdr.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  fs/nfsd/xdr4.h       |  8 ++++++
> >  include/linux/nfs4.h |  5 ++++
> >  4 files changed, 113 insertions(+), 2 deletions(-)
>=20
> Just a handful of style preferences below.
>=20

Those comments all make sense. I'll respin along those lines.

Also, I may go ahead and send this patch separately from the rest of the
series. I think it would be best to have trivial support for
GET_DIR_DELEGATION in the kernel server as soon as possible.

Eventually, clients may start sending these calls, and it's better if we
can just return a non-fatal error instead of sending back NFSERR_NOTSUPP
when they do.


>=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 2927b1263f08..7973fe17bf3c 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2173,6 +2173,18 @@ nfsd4_layout_verify(struct svc_export *exp, unsi=
gned int layout_type)
> >  	return nfsd4_layout_ops[layout_type];
> >  }
> > =20
> > +static __be32
> > +nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
> > +			 struct nfsd4_compound_state *cstate,
> > +			 union nfsd4_op_u *u)
> > +{
> > +	struct nfsd4_get_dir_delegation *gdd =3D &u->get_dir_delegation;
> > +
> > +	/* FIXME: actually return a delegation */
> > +	gdd->nf_status =3D GDD4_UNAVAIL;
> > +	return nfs_ok;
> > +}
> > +
> >  static __be32
> >  nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
> >  		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> > @@ -3082,6 +3094,18 @@ static u32 nfsd4_copy_notify_rsize(const struct =
svc_rqst *rqstp,
> >  		* sizeof(__be32);
> >  }
> > =20
> > +static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp=
,
> > +					  const struct nfsd4_op *op)
> > +{
> > +	return (op_encode_hdr_size +
> > +		1 /* gddr_status */ +
> > +		op_encode_verifier_maxsz +
> > +		op_encode_stateid_maxsz +
> > +		2 /* gddr_notification */ +
> > +		2 /* gddr_child_attributes */ +
> > +		2 /* gddr_dir_attributes */);
> > +}
> > +
> >  #ifdef CONFIG_NFSD_PNFS
> >  static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
> >  				     const struct nfsd4_op *op)
> > @@ -3470,6 +3494,12 @@ static const struct nfsd4_operation nfsd4_ops[] =
=3D {
> >  		.op_get_currentstateid =3D nfsd4_get_freestateid,
> >  		.op_rsize_bop =3D nfsd4_only_status_rsize,
> >  	},
> > +	[OP_GET_DIR_DELEGATION] =3D {
> > +		.op_func =3D nfsd4_get_dir_delegation,
> > +		.op_flags =3D OP_MODIFIES_SOMETHING,
> > +		.op_name =3D "OP_GET_DIR_DELEGATION",
> > +		.op_rsize_bop =3D nfsd4_get_dir_delegation_rsize,
> > +	},
> >  #ifdef CONFIG_NFSD_PNFS
> >  	[OP_GETDEVICEINFO] =3D {
> >  		.op_func =3D nfsd4_getdeviceinfo,
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index fac938f563ad..3718bef74e9f 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -1732,6 +1732,40 @@ nfsd4_decode_free_stateid(struct nfsd4_compounda=
rgs *argp,
> >  	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
> >  }
> > =20
> > +static __be32
> > +nfsd4_decode_get_dir_delegation(struct nfsd4_compoundargs *argp,
> > +		union nfsd4_op_u *u)
> > +{
> > +	struct nfsd4_get_dir_delegation *gdd =3D &u->get_dir_delegation;
> > +	struct timespec64 ts;
> > +	u32 signal_deleg_avail;
> > +	u32 attrs[1];
>=20
> I know this isn't how we've done XDR in the past, but I'd rather
> see these dummy args as fields in struct nfsd4_get_dir_delegation,
> and also move the comments about whether each argument is supported
> to the putative nfsd4_proc_get_dir_delegation().
>=20
> The actual implementation of GET_DIR_DELEGATION is in nfs4proc.c,
> after all, not here. This is simply a translation function.
>=20
>=20
> > +	__be32 status;
> > +
> > +	memset(gdd, 0, sizeof(*gdd));
> > +
> > +	/* No signal_avail support for now (and maybe never) */
> > +	if (xdr_stream_decode_bool(argp->xdr, &signal_deleg_avail) < 0)
> > +		return nfserr_bad_xdr;
> > +	status =3D nfsd4_decode_bitmap4(argp, gdd->notification_types,
> > +				      ARRAY_SIZE(gdd->notification_types));
> > +	if (status)
> > +		return status;
> > +
> > +	/* For now, we don't support child or dir attr change notification */
> > +	status =3D nfsd4_decode_nfstime4(argp, &ts);
> > +	if (status)
> > +		return status;
> > +	/* No dir attr notification support yet either */
> > +	status =3D nfsd4_decode_nfstime4(argp, &ts);
> > +	if (status)
> > +		return status;
> > +	status =3D nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
> > +	if (status)
> > +		return status;
> > +	return nfsd4_decode_bitmap4(argp, attrs, ARRAY_SIZE(attrs));
> > +}
> > +
> >  #ifdef CONFIG_NFSD_PNFS
> >  static __be32
> >  nfsd4_decode_getdeviceinfo(struct nfsd4_compoundargs *argp,
> > @@ -2370,7 +2404,7 @@ static const nfsd4_dec nfsd4_dec_ops[] =3D {
> >  	[OP_CREATE_SESSION]	=3D nfsd4_decode_create_session,
> >  	[OP_DESTROY_SESSION]	=3D nfsd4_decode_destroy_session,
> >  	[OP_FREE_STATEID]	=3D nfsd4_decode_free_stateid,
> > -	[OP_GET_DIR_DELEGATION]	=3D nfsd4_decode_notsupp,
> > +	[OP_GET_DIR_DELEGATION]	=3D nfsd4_decode_get_dir_delegation,
> >  #ifdef CONFIG_NFSD_PNFS
> >  	[OP_GETDEVICEINFO]	=3D nfsd4_decode_getdeviceinfo,
> >  	[OP_GETDEVICELIST]	=3D nfsd4_decode_notsupp,
> > @@ -5002,6 +5036,40 @@ nfsd4_encode_device_addr4(struct xdr_stream *xdr=
,
> >  	return nfserr_toosmall;
> >  }
> > =20
> > +static __be32
> > +nfsd4_encode_get_dir_delegation(struct nfsd4_compoundres *resp, __be32=
 nfserr,
> > +				union nfsd4_op_u *u)
> > +{
> > +	struct xdr_stream *xdr =3D resp->xdr;
> > +	struct nfsd4_get_dir_delegation *gdd =3D &u->get_dir_delegation;
> > +
> > +	/* Encode the GDDR_* status code */
>=20
> In other encoders, I've used simply the name of the field as it is
> in the RFC as a documenting comment. That's more clear, and is
> easily grep-able. So:
>=20
> 	/* gddrnf_status */
>=20
>=20
> > +	if (xdr_stream_encode_u32(xdr, gdd->nf_status) !=3D XDR_UNIT)
> > +		return nfserr_resource;
> > +
> > +	/* if it's GDD4_UNAVAIL then we're (almost) done */
> > +	if (gdd->nf_status =3D=3D GDD4_UNAVAIL) {
>=20
> I prefer using a switch for XDR unions. That makes our
> implementation look more like the XDR definition; easier for humans
> to audit and modify.
>=20
>=20
> > +		/* We never call back */
> > +		return nfsd4_encode_bool(xdr, false);
>=20
> Again, let's move this boolean to struct nfsd4_get_dir_delegation to
> enable nfsd4_proc_get_dir_delegation to decide in the future.
>=20
>=20
> > +	}
> > +
> > +	/* GDD4_OK case */
>=20
> If a switch is used, then this comment becomes a real piece of
> self-verifying code:
>=20
> 	case GDD4_OK:
>=20
>=20
> > +	nfserr =3D nfsd4_encode_verifier4(xdr, &gdd->cookieverf);
> > +	if (nfserr)
> > +		return nfserr;
> > +	nfserr =3D nfsd4_encode_stateid4(xdr, &gdd->stateid);
> > +	if (nfserr)
> > +		return nfserr;
> > +	/* No notifications (yet) */
> > +	nfserr =3D nfsd4_encode_bitmap4(xdr, 0, 0, 0);
> > +	if (nfserr)
> > +		return nfserr;
> > +	nfserr =3D nfsd4_encode_bitmap4(xdr, 0, 0, 0);
> > +	if (nfserr)
> > +		return nfserr;
> > +	return nfsd4_encode_bitmap4(xdr, 0, 0, 0);
>=20
> All these as well can go in struct nfsd4_get_dir_delegation.
>=20
>=20
> > +}
> > +
> >  static __be32
> >  nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfse=
rr,
> >  		union nfsd4_op_u *u)
> > @@ -5580,7 +5648,7 @@ static const nfsd4_enc nfsd4_enc_ops[] =3D {
> >  	[OP_CREATE_SESSION]	=3D nfsd4_encode_create_session,
> >  	[OP_DESTROY_SESSION]	=3D nfsd4_encode_noop,
> >  	[OP_FREE_STATEID]	=3D nfsd4_encode_noop,
> > -	[OP_GET_DIR_DELEGATION]	=3D nfsd4_encode_noop,
> > +	[OP_GET_DIR_DELEGATION]	=3D nfsd4_encode_get_dir_delegation,
> >  #ifdef CONFIG_NFSD_PNFS
> >  	[OP_GETDEVICEINFO]	=3D nfsd4_encode_getdeviceinfo,
> >  	[OP_GETDEVICELIST]	=3D nfsd4_encode_noop,
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index 415516c1b27e..27de75f32dea 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -518,6 +518,13 @@ struct nfsd4_free_stateid {
> >  	stateid_t	fr_stateid;         /* request */
> >  };
> > =20
> > +struct nfsd4_get_dir_delegation {
> > +	u32		notification_types[1];	/* request */
> > +	u32		nf_status;		/* response */
> > +	nfs4_verifier	cookieverf;		/* response */
> > +	stateid_t	stateid;		/* response */
> > +};
> > +
> >  /* also used for NVERIFY */
> >  struct nfsd4_verify {
> >  	u32		ve_bmval[3];        /* request */
> > @@ -797,6 +804,7 @@ struct nfsd4_op {
> >  		struct nfsd4_reclaim_complete	reclaim_complete;
> >  		struct nfsd4_test_stateid	test_stateid;
> >  		struct nfsd4_free_stateid	free_stateid;
> > +		struct nfsd4_get_dir_delegation	get_dir_delegation;
> >  		struct nfsd4_getdeviceinfo	getdeviceinfo;
> >  		struct nfsd4_layoutget		layoutget;
> >  		struct nfsd4_layoutcommit	layoutcommit;
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index ef8d2d618d5b..11ad088b411d 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -701,6 +701,11 @@ enum state_protect_how4 {
> >  	SP4_SSV		=3D 2
> >  };
> > =20
> > +enum get_dir_delegation_non_fatal_res {
> > +	GDD4_OK		=3D 0,
> > +	GDD4_UNAVAIL	=3D 1
> > +};
> > +
> >  enum pnfs_layouttype {
> >  	LAYOUT_NFSV4_1_FILES  =3D 1,
> >  	LAYOUT_OSD2_OBJECTS =3D 2,
> >=20
> > --=20
> > 2.44.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

