Return-Path: <linux-fsdevel+bounces-26817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A75495BCC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD2C1C23A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635C1CDFC7;
	Thu, 22 Aug 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND0NkgFL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6E1CEABD;
	Thu, 22 Aug 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346451; cv=none; b=HwRL+mMtXfVVpVK5obYsYA/bkVWuiPLmsGcGJ1davnIAcIktAfldDw2GpK/qXNnfUup6kZAUmNP0vZ+fwGJSwrwpNfTEbsDUez2ltIyAv2L+FLfmuXqrHuLBwcrYdJOauFPCw5+Cazyjr8mkzJifOFd/jDumImDd8MnFeYx2HWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346451; c=relaxed/simple;
	bh=hyZ17YMYo2nHdX12LVZVi6QKQwQp3oYS+0PDTpKNHRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjJW0P+U23qq20R0TYKd7sDTPXlRxtkaKhmKKS/KXqaakPkZflK64KxYTY/uztx4BQESY2eBwdIaUoDB3CwgNDK8SmiwatGyCqoILL2nrDeNVdalI0mpb1LU66SRwNDEdNJq1zMI3RiuYa5uIJ4L9f6HerGIHXxjEyQMEu9cUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND0NkgFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FE9C32782;
	Thu, 22 Aug 2024 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724346450;
	bh=hyZ17YMYo2nHdX12LVZVi6QKQwQp3oYS+0PDTpKNHRQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ND0NkgFLEsWxbcGOKSmZ2IFyrgdVi42xFqsdUYT/Nr06w3PW3DC0Z/3CmY1YxBgET
	 1IjlnJRQl6WfeC1M8xERPPwVdbk4sJgSkD4J+UWQtpbxnQdTSLUenWwpuMOCGrRdwv
	 9elgfXXXgM9jKVVCbZgY7Sc7G2JJpXHr5u/YEx5LCFgYXyfEiV9S0lFyiUf8KGRbSE
	 Vkee3MTnSVVCxnKJgOUEZlK2yLxi2PGqRyRM0TUq3RcuavecUvtxom9QYNgMVR32Jb
	 FxaSizlRqzb0ZmoWC1pQ8lToqlXAf0gmXhSD+521QCwITtw/XBekpqC7MWZEqnxFZT
	 SsQog3YIrB3QQ==
Message-ID: <b6cee2822295de115681d9f26f0a473e9d69e2c4.camel@kernel.org>
Subject: Re: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly
 handle NULL rqstp
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, Trond
 Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 22 Aug 2024 13:07:29 -0400
In-Reply-To: <ZsdhhIY8WQCPWete@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
	 <20240819181750.70570-6-snitzer@kernel.org>
	 <4ab36f95604da25d8c5b419c927d85d362bca2e8.camel@kernel.org>
	 <ZsZa7PX0QtZKWt_R@kernel.org> <ZsdUQ1t4L8dfB0BF@tissot.1015granger.net>
	 <ZsdhhIY8WQCPWete@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 12:04 -0400, Mike Snitzer wrote:
> On Thu, Aug 22, 2024 at 11:07:47AM -0400, Chuck Lever wrote:
> > On Wed, Aug 21, 2024 at 05:23:56PM -0400, Mike Snitzer wrote:
> > > On Wed, Aug 21, 2024 at 01:46:02PM -0400, Jeff Layton wrote:
> > > > On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > > > > Fixes stop-gap used in previous commit where caller avoided using
> > > > > tracepoint if rqstp is NULL.=C2=A0 Instead, have each tracepoint =
avoid
> > > > > dereferencing NULL rqstp.
> > > > >=20
> > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > ---
> > > > > =C2=A0fs/nfsd/nfsfh.c | 12 ++++--------
> > > > > =C2=A0fs/nfsd/trace.h | 36 +++++++++++++++++++++---------------
> > > > > =C2=A02 files changed, 25 insertions(+), 23 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > > index 19e173187ab9..bae727e65214 100644
> > > > > --- a/fs/nfsd/nfsfh.c
> > > > > +++ b/fs/nfsd/nfsfh.c
> > > > > @@ -195,8 +195,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_r=
qst
> > > > > *rqstp, struct net *net,
> > > > > =C2=A0
> > > > > =C2=A0	error =3D nfserr_stale;
> > > > > =C2=A0	if (IS_ERR(exp)) {
> > > > > -		if (rqstp)
> > > > > -			trace_nfsd_set_fh_dentry_badexport(rqstp,
> > > > > fhp, PTR_ERR(exp));
> > > > > +		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp,
> > > > > PTR_ERR(exp));
> > > > > =C2=A0
> > > > > =C2=A0		if (PTR_ERR(exp) =3D=3D -ENOENT)
> > > > > =C2=A0			return error;
> > > > > @@ -244,8 +243,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_r=
qst
> > > > > *rqstp, struct net *net,
> > > > > =C2=A0						data_left,
> > > > > fileid_type, 0,
> > > > > =C2=A0						nfsd_acceptable,
> > > > > exp);
> > > > > =C2=A0		if (IS_ERR_OR_NULL(dentry)) {
> > > > > -			if (rqstp)
> > > > > -
> > > > > 				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> > > > > +			trace_nfsd_set_fh_dentry_badhandle(rqstp,
> > > > > fhp,
> > > > > =C2=A0					dentry ?=C2=A0 PTR_ERR(dentry) :
> > > > > -ESTALE);
> > > > > =C2=A0			switch (PTR_ERR(dentry)) {
> > > > > =C2=A0			case -ENOMEM:
> > > > > @@ -321,8 +319,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > =C2=A0	dentry =3D fhp->fh_dentry;
> > > > > =C2=A0	exp =3D fhp->fh_export;
> > > > > =C2=A0
> > > > > -	if (rqstp)
> > > > > -		trace_nfsd_fh_verify(rqstp, fhp, type, access);
> > > > > +	trace_nfsd_fh_verify(net, rqstp, fhp, type, access);
> > > > > =C2=A0
> > > > > =C2=A0	/*
> > > > > =C2=A0	 * We still have to do all these permission checks, even
> > > > > when
> > > > > @@ -376,8 +373,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > > > > =C2=A0	/* Finally, check access permissions. */
> > > > > =C2=A0	error =3D nfsd_permission(cred, exp, dentry, access);
> > > > > =C2=A0out:
> > > > > -	if (rqstp)
> > > > > -		trace_nfsd_fh_verify_err(rqstp, fhp, type, access,
> > > > > error);
> > > > > +	trace_nfsd_fh_verify_err(net, rqstp, fhp, type, access,
> > > > > error);
> > > > > =C2=A0	if (error =3D=3D nfserr_stale)
> > > > > =C2=A0		nfsd_stats_fh_stale_inc(nn, exp);
> > > > > =C2=A0	return error;
> > > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > > index 77bbd23aa150..d49b3c1e3ba9 100644
> > > > > --- a/fs/nfsd/trace.h
> > > > > +++ b/fs/nfsd/trace.h
> > > > > @@ -195,12 +195,13 @@ TRACE_EVENT(nfsd_compound_encode_err,
> > > > > =C2=A0
> > > > > =C2=A0TRACE_EVENT(nfsd_fh_verify,
> > > > > =C2=A0	TP_PROTO(
> > > > > +		const struct net *net,
> > > > > =C2=A0		const struct svc_rqst *rqstp,
> > > > > =C2=A0		const struct svc_fh *fhp,
> > > > > =C2=A0		umode_t type,
> > > > > =C2=A0		int access
> > > > > =C2=A0	),
> > > > > -	TP_ARGS(rqstp, fhp, type, access),
> > > > > +	TP_ARGS(net, rqstp, fhp, type, access),
> > > > > =C2=A0	TP_STRUCT__entry(
> > > > > =C2=A0		__field(unsigned int, netns_ino)
> > > > > =C2=A0		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > > > > @@ -212,12 +213,14 @@ TRACE_EVENT(nfsd_fh_verify,
> > > > > =C2=A0		__field(unsigned long, access)
> > > > > =C2=A0	),
> > > > > =C2=A0	TP_fast_assign(
> > > > > -		__entry->netns_ino =3D SVC_NET(rqstp)->ns.inum;
> > > > > -		__assign_sockaddr(server, &rqstp->rq_xprt-
> > > > > > xpt_local,
> > > > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rqstp->rq_xprt->xpt_local=
len);
> > > > > -		__assign_sockaddr(client, &rqstp->rq_xprt-
> > > > > > xpt_remote,
> > > > > -				=C2=A0 rqstp->rq_xprt->xpt_remotelen);
> > > > > -		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> > > > > +		__entry->netns_ino =3D net->ns.inum;
> > > > > +		if (rqstp) {
> > > > > +			__assign_sockaddr(server, &rqstp->rq_xprt-
> > > > > > xpt_local,
> > > > > +					=C2=A0 rqstp->rq_xprt-
> > > > > > xpt_locallen);
> > > > > +			__assign_sockaddr(client, &rqstp->rq_xprt-
> > > > > > xpt_remote,
> > > > > +					=C2=A0 rqstp->rq_xprt-
> > > > > > xpt_remotelen);
> > > > > +		}
> > > >=20
> > > > Does this need an else branch to set these values to something when
> > > > rqstp is NULL, or are we guaranteed that they are already zeroed ou=
t
> > > > when they aren't assigned?
> > >=20
> > > I'm not sure.  It isn't immediately clear what is actually using thes=
e.
> > >=20
> > > But I did just notice an inconsistency, these entry members are defin=
ed:
> > >=20
> > >                 __sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > >                 __sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
> > >=20
> > > Yet they go on to use rqstp->rq_xprt->xpt_locallen and
> > > rqstp->rq_xprt->xpt_remotelen respectively.
> > >=20
> > > Chuck, would welcome your feedback on how to properly fix these
> > > tracepoints to handle rqstp being NULL.  And the inconsistency I just
> > > noted is something extra.
> >=20
> > First, a comment about patch ordering: I think you can preserve
> > attribution but make these a little easier to digest if you reverse
> > 4/ and 5/. Fix the problem before it becomes a problem, as it were.
> >=20
> > As a general remark, I would prefer to retain the trace points and
> > even the address information in the local I/O case: the client
> > address is an important part of the decision to permit or deny
> > access to the FH in question. The issue is how to make that
> > happen...
> >=20
> > The __sockaddr() macros I think will trigger an oops if
> > rqstp =3D=3D NULL. The second argument determines the size of a
> > variable-length trace field IIRC. One way to avoid that is to use a
> > fixed size field for the addresses (big enough to store an IPv6
> > address?  or an abstract address? those can get pretty big)
> >=20
> > I need to study 4/ more closely; perhaps it is doing too much in a
> > single patch. (ie, the code ends up in a better place, but the
> > details of the transition are obscured by being lumped together into
> > one patch).
> >=20
> > So, can you or Neil answer: what would appear as the client address
> > for local I/O ?
>=20
> Before when there was the "fake" svc_rqst it was initialized with:
>=20
>        /* Note: we're connecting to ourself, so source addr =3D=3D peer a=
ddr */
>        rqstp->rq_addrlen =3D rpc_peeraddr(rpc_clnt,
>                        (struct sockaddr *)&rqstp->rq_addr,
>                        sizeof(rqstp->rq_addr));
>=20
> Anyway, as the code is also now: the rpc_clnt passed to
> nfsd_open_local_fh() will reflect the same address as the server.
>=20
> My thinking was that for localio there doesn't need to be any explicit
> listing of the address info in the tracepoints (but that'd be more
> convincing if we at least logged localio by looking for and logging
> NFSD_MAY_LOCALIO in mayflags passed to nfsd_file_acquire_local).
>=20
> But I agree it'd be nice to have tracepoints log matching 127.0.0.1 or
> ::1, etc -- just don't think it strictly necessary.
>=20
> Open to whatever you think best.
>=20

The client is likely to be coming from a different container in many
cases and so won't be coming in via the loopback interface. Presenting
a loopback address in that case seems wrong.

What would be ideal IMO would be to still display the addresses from
the rpc_clnt and just display a flag or something that shows that this
is a localio request. Having to pass that as an additional arg to
__fh_verify would be pretty ugly though (and may be a layering
violation).

--=20
Jeff Layton <jlayton@kernel.org>

