Return-Path: <linux-fsdevel+bounces-14544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0132387D627
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 22:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7092F1F22DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E04754BF7;
	Fri, 15 Mar 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c93+0HMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A38548F4;
	Fri, 15 Mar 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538182; cv=none; b=TClVImMF3ZDvaiL8ZN08lD8gJAVyYSnOQ5ZCvG6pHFV7UbOcHfgcZsDePvRocgeI48jpoHYcMXg98qCCTR8SPoYdMAPkYHU57ZOlKNrIPJrbwWixz1/5n+ey+Pe8QWmcTHBYgUyuUbseg6Ap+L+XlMdc8OcgiMIEDTcvaCMc/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538182; c=relaxed/simple;
	bh=HbuzOzQe+WdlqjwLri/zzPxm288j3VnRwgNIUgN+o6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Icp+3lQeo2D+FDQTRMHSMzl9ZOExBJQLqUkDxUkqW44OlHkFGsSzBW1LnvZJzenWe/ozNSH0YQv7mE++LAeQ6cNVHucwiES5SNlVXQ7nijM9RgK9DjD++bTeJevRANvO5dCD+nP+KPuqaK51XCc9MR1Nldwji0ySsfftcbiBkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c93+0HMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0553FC433F1;
	Fri, 15 Mar 2024 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710538181;
	bh=HbuzOzQe+WdlqjwLri/zzPxm288j3VnRwgNIUgN+o6Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c93+0HMikje5OmH0+CfM4x+kpEZDsQOxkdjOW//t8I5wCGk32b1GzqRD2JqAHCtqw
	 7LlSo9csYcXV+g08cRMR20muP5tG93zng5+din0upf5tUeBJzirQzcuqyoXVOf8tqg
	 c2v0zzXWn7nDf+6kovBuLlBB8nEjgPyhpAjbbNCR589zDDsuSAg1ZasqqSci7gyqLK
	 hLy22jEo8eZDq4podSmiaERobcWyYBfgipUFKULCF15sOdZMbBJQtMfNEkI2Xqvwqe
	 qcBjb5oVIHLm2cRDEdw0jb/niv0tj2vRwciYsnfVLCKaxWwmnZSnL4rpSh9TjKJDNR
	 vytAf6jrx31Yg==
Message-ID: <4c5c4f4df54f860aee9ba0ef18af815599d8642d.camel@kernel.org>
Subject: Re: [PATCH RFC 21/24] nfs: add a GDD_GETATTR rpc operation
From: Jeff Layton <jlayton@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, Trond
 Myklebust <trond.myklebust@hammerspace.com>, Steve French
 <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Howells
 <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, Neil Brown
 <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
 <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org,  linux-unionfs@vger.kernel.org,
 netdev@vger.kernel.org
Date: Fri, 15 Mar 2024 17:29:37 -0400
In-Reply-To: <CAFX2Jfk_np=agEWY0aPkosssBkfx9S+ur-L1=91psn-hdgK+RA@mail.gmail.com>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
	 <20240315-dir-deleg-v1-21-a1d6209a3654@kernel.org>
	 <CAFX2Jfk_np=agEWY0aPkosssBkfx9S+ur-L1=91psn-hdgK+RA@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-15 at 16:50 -0400, Anna Schumaker wrote:
> Hi Jeff,
>=20
> On Fri, Mar 15, 2024 at 12:54=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > Add a new compound that does a GET_DIR_DELEGATION just before doing a
> > GETATTR on an inode. Add a delegation stateid and a nf_status code to
> > struct nfs4_getattr_res to store the result.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfs/nfs4xdr.c        | 136 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/nfs4.h    |   1 +
> >  include/linux/nfs_xdr.h |   2 +
> >  3 files changed, 139 insertions(+)
> >=20
> > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > index 1416099dfcd1..c28025018bda 100644
> > --- a/fs/nfs/nfs4xdr.c
> > +++ b/fs/nfs/nfs4xdr.c
> > @@ -391,6 +391,22 @@ static int decode_layoutget(struct xdr_stream *xdr=
, struct rpc_rqst *req,
> >                                 XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + 5=
)
> >  #define encode_reclaim_complete_maxsz  (op_encode_hdr_maxsz + 4)
> >  #define decode_reclaim_complete_maxsz  (op_decode_hdr_maxsz + 4)
> > +#define encode_get_dir_delegation_maxsz (op_encode_hdr_maxsz +        =
                 \
> > +                                        4 /* gdda_signal_deleg_avail *=
/ +              \
> > +                                        8 /* gdda_notification_types *=
/ +              \
> > +                                        nfstime4_maxsz  /* gdda_child_=
attr_delay */ +  \
> > +                                        nfstime4_maxsz  /* gdda_dir_at=
tr_delay */ +    \
> > +                                        nfs4_fattr_bitmap_maxsz /* gdd=
a_child_attributes */ + \
> > +                                        nfs4_fattr_bitmap_maxsz /* gdd=
a_dir_attributes */)
> > +
> > +#define decode_get_dir_delegation_maxsz (op_encode_hdr_maxsz +        =
                 \
> > +                                        4 /* gddrnf_status */ +       =
                 \
> > +                                        encode_verifier_maxsz /* gddr_=
cookieverf */ +  \
> > +                                        encode_stateid_maxsz /* gddr_s=
tateid */ +      \
> > +                                        8 /* gddr_notification */ +   =
                 \
> > +                                        nfs4_fattr_bitmap_maxsz /* gdd=
r_child_attributes */ + \
> > +                                        nfs4_fattr_bitmap_maxsz /* gdd=
r_dir_attributes */)
> > +
> >  #define encode_getdeviceinfo_maxsz (op_encode_hdr_maxsz + \
> >                                 XDR_QUADLEN(NFS4_DEVICEID4_SIZE) + \
> >                                 1 /* layout type */ + \
> > @@ -636,6 +652,18 @@ static int decode_layoutget(struct xdr_stream *xdr=
, struct rpc_rqst *req,
> >                                 decode_putfh_maxsz + \
> >                                 decode_getattr_maxsz + \
> >                                 decode_renew_maxsz)
> > +#define NFS4_enc_gdd_getattr_sz        (compound_encode_hdr_maxsz + \
> > +                               encode_sequence_maxsz + \
> > +                               encode_putfh_maxsz + \
> > +                               encode_get_dir_delegation_maxsz + \
> > +                               encode_getattr_maxsz + \
> > +                               encode_renew_maxsz)
> > +#define NFS4_dec_gdd_getattr_sz        (compound_decode_hdr_maxsz + \
> > +                               decode_sequence_maxsz + \
> > +                               decode_putfh_maxsz + \
> > +                               decode_get_dir_delegation_maxsz + \
> > +                               decode_getattr_maxsz + \
> > +                               decode_renew_maxsz)
> >  #define NFS4_enc_lookup_sz     (compound_encode_hdr_maxsz + \
> >                                 encode_sequence_maxsz + \
> >                                 encode_putfh_maxsz + \
> > @@ -1981,6 +2009,30 @@ static void encode_sequence(struct xdr_stream *x=
dr,
> >  }
> >=20
> >  #ifdef CONFIG_NFS_V4_1
> > +static void
> > +encode_get_dir_delegation(struct xdr_stream *xdr, struct compound_hdr =
*hdr)
> > +{
> > +       __be32 *p;
> > +       struct timespec64 ts =3D {};
> > +       u32 zerobm[1] =3D {};
> > +
> > +       encode_op_hdr(xdr, OP_GET_DIR_DELEGATION, decode_get_dir_delega=
tion_maxsz, hdr);
> > +
> > +       /* We can't handle CB_RECALLABLE_OBJ_AVAIL yet */
> > +       xdr_stream_encode_bool(xdr, false);
> > +
> > +       /* for now, we request no notification types */
> > +       xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
> > +
> > +       /* Request no attribute updates */
> > +       p =3D reserve_space(xdr, 12 + 12);
> > +       p =3D xdr_encode_nfstime4(p, &ts);
> > +       xdr_encode_nfstime4(p, &ts);
> > +
> > +       xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
> > +       xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
> > +}
> > +
> >  static void
> >  encode_getdeviceinfo(struct xdr_stream *xdr,
> >                      const struct nfs4_getdeviceinfo_args *args,
> > @@ -2334,6 +2386,25 @@ static void nfs4_xdr_enc_getattr(struct rpc_rqst=
 *req, struct xdr_stream *xdr,
> >         encode_nops(&hdr);
> >  }
> >=20
> > +/*
> > + * Encode GDD_GETATTR request
> > + */
> > +static void nfs4_xdr_enc_gdd_getattr(struct rpc_rqst *req, struct xdr_=
stream *xdr,
> > +                                    const void *data)
> > +{
> > +       const struct nfs4_getattr_arg *args =3D data;
> > +       struct compound_hdr hdr =3D {
> > +               .minorversion =3D nfs4_xdr_minorversion(&args->seq_args=
),
> > +       };
> > +
> > +       encode_compound_hdr(xdr, req, &hdr);
> > +       encode_sequence(xdr, &args->seq_args, &hdr);
> > +       encode_putfh(xdr, args->fh, &hdr);
> > +       encode_get_dir_delegation(xdr, &hdr);
> > +       encode_getfattr(xdr, args->bitmask, &hdr);
> > +       encode_nops(&hdr);
> > +}
> > +
>=20
> This function should be under a "#ifdef CONFIG_NFS_V4_1" to avoid the
> following compiler error:
>=20
> fs/nfs/nfs4xdr.c:2403:2: error: call to undeclared function
> 'encode_get_dir_delegation'; ISO C99 and later do not support implicit
> function declarations [-Wimplicit-function-declaration]
>  2403 |         encode_get_dir_delegation(xdr, &hdr);
>       |         ^
>=20

Thanks Anna! I'll fix up both problems before the next iteration.

>=20
> >  /*
> >   * Encode a CLOSE request
> >   */
> > @@ -5919,6 +5990,43 @@ static int decode_layout_stateid(struct xdr_stre=
am *xdr, nfs4_stateid *stateid)
> >         return decode_stateid(xdr, stateid);
> >  }
> >=20
> > +static int decode_get_dir_delegation(struct xdr_stream *xdr,
> > +                                    struct nfs4_getattr_res *res)
> > +{
> > +       nfs4_verifier   cookieverf;
> > +       int             status;
> > +       u32             bm[1];
> > +
> > +       status =3D decode_op_hdr(xdr, OP_GET_DIR_DELEGATION);
> > +       if (status)
> > +               return status;
> > +
> > +       if (xdr_stream_decode_u32(xdr, &res->nf_status))
> > +               return -EIO;
> > +
> > +       if (res->nf_status =3D=3D GDD4_UNAVAIL)
> > +               return xdr_inline_decode(xdr, 4) ? 0 : -EIO;
> > +
> > +       status =3D decode_verifier(xdr, &cookieverf);
> > +       if (status)
> > +               return status;
> > +
> > +       status =3D decode_delegation_stateid(xdr, &res->deleg);
> > +       if (status)
> > +               return status;
> > +
> > +       status =3D decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
> > +       if (status < 0)
> > +               return status;
> > +       status =3D decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
> > +       if (status < 0)
> > +               return status;
> > +       status =3D decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
> > +       if (status < 0)
> > +               return status;
> > +       return 0;
> > +}
> > +
> >  static int decode_getdeviceinfo(struct xdr_stream *xdr,
> >                                 struct nfs4_getdeviceinfo_res *res)
> >  {
> > @@ -6455,6 +6563,33 @@ static int nfs4_xdr_dec_getattr(struct rpc_rqst =
*rqstp, struct xdr_stream *xdr,
> >         return status;
> >  }
> >=20
> > +/*
> > + * Decode GDD_GETATTR response
> > + */
> > +static int nfs4_xdr_dec_gdd_getattr(struct rpc_rqst *rqstp, struct xdr=
_stream *xdr,
> > +                                   void *data)
> > +{
> > +       struct nfs4_getattr_res *res =3D data;
> > +       struct compound_hdr hdr;
> > +       int status;
> > +
> > +       status =3D decode_compound_hdr(xdr, &hdr);
> > +       if (status)
> > +               goto out;
> > +       status =3D decode_sequence(xdr, &res->seq_res, rqstp);
> > +       if (status)
> > +               goto out;
> > +       status =3D decode_putfh(xdr);
> > +       if (status)
> > +               goto out;
> > +       status =3D decode_get_dir_delegation(xdr, res);
> > +       if (status)
> > +               goto out;
> > +       status =3D decode_getfattr(xdr, res->fattr, res->server);
> > +out:
> > +       return status;
> > +}
> > +
>=20
> This needs to be under the same #ifdef, too.
>=20
> Thanks,
>  Anna
>=20
> >  /*
> >   * Encode an SETACL request
> >   */
> > @@ -7704,6 +7839,7 @@ const struct rpc_procinfo nfs4_procedures[] =3D {
> >         PROC41(BIND_CONN_TO_SESSION,
> >                         enc_bind_conn_to_session, dec_bind_conn_to_sess=
ion),
> >         PROC41(DESTROY_CLIENTID,enc_destroy_clientid,   dec_destroy_cli=
entid),
> > +       PROC41(GDD_GETATTR,     enc_gdd_getattr,        dec_gdd_getattr=
),
> >         PROC42(SEEK,            enc_seek,               dec_seek),
> >         PROC42(ALLOCATE,        enc_allocate,           dec_allocate),
> >         PROC42(DEALLOCATE,      enc_deallocate,         dec_deallocate)=
,
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 11ad088b411d..86cbfd50ecd1 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -681,6 +681,7 @@ enum {
> >         NFSPROC4_CLNT_LISTXATTRS,
> >         NFSPROC4_CLNT_REMOVEXATTR,
> >         NFSPROC4_CLNT_READ_PLUS,
> > +       NFSPROC4_CLNT_GDD_GETATTR,
> >  };
> >=20
> >  /* nfs41 types */
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index d09b9773b20c..85ee37ccc25e 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -1072,6 +1072,8 @@ struct nfs4_getattr_res {
> >         struct nfs4_sequence_res        seq_res;
> >         const struct nfs_server *       server;
> >         struct nfs_fattr *              fattr;
> > +       nfs4_stateid                    deleg;
> > +       u32                             nf_status;
> >  };
> >=20
> >  struct nfs4_link_arg {
> >=20
> > --
> > 2.44.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

