Return-Path: <linux-fsdevel+bounces-27865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501659648B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070B12814F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32D1B0126;
	Thu, 29 Aug 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebVYy2rp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7B19049D;
	Thu, 29 Aug 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942376; cv=none; b=VmAk0f9wqyQVpTtHON0bkKzStidDBeyynwoXOXjiNbT+lyxiagDR778y9iK1qlPiwyBTEsWvGLlqAxXGp81AlKFqJy5iEpYl9fACEIE9G4gBZ/9cTxroM/vW5l6tt4B9N6fBW0+CRuiOI9J598wdCkryjVaSZEMlw0ZjaGf9wrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942376; c=relaxed/simple;
	bh=p1qoXZpaW+FhF17jy99cY4YeL9te/bL8/jkPp+7Yt/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGWsLa90N3LOfkPlp4P2EqJwmWTafkjKsQ81yssfsm1qgBDercrl/gT8EYIw0xJHqq2WCWuTzlBgLK356jR0uBntlwK1lpe9uFlZYXIVAgvRnJaukBp+ybGG6RVTj3FM70UdH86Ccx7iYiZRVNUAqLx6c9Tu5xnPAxvzJjcukTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebVYy2rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BCDC4CEC1;
	Thu, 29 Aug 2024 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724942375;
	bh=p1qoXZpaW+FhF17jy99cY4YeL9te/bL8/jkPp+7Yt/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ebVYy2rpUkULO7q5YfxuHQNjNoDbezlaSBgk031Rai3mB43I/lNpfUa3xLd+eXy/7
	 FG++NDJqwmJ+dh6KhJl9Zk/UAW5YL0g6QSI1wLCrtVYUi9jCgSu0dzyek+O90zbqLH
	 DxJ33pqyc5XaLnq5Mwb2KjEH17FDdU+NQC9ott+KNiIqJxxCpngumOHmz4Me01+O4F
	 8CbRCSvMOkg4sFoQirlWJo10lf5ohu7nb+T8ebPGTFh6ZshO15cXNmIbBSbuGecOtf
	 NZbvacw/53RVl6y0PJ45JlfW0MG7iXPq4ZgROifjzdcurnl/1IhmUYQrU0vGXus/K+
	 DAJj0rrV/f12A==
Message-ID: <1dbdcefe983509154cb32b4cbce088b6b78c300a.camel@kernel.org>
Subject: Re: [PATCH v14 08/25] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 10:39:33 -0400
In-Reply-To: <20240829010424.83693-9-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-9-snitzer@kernel.org>
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

On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> __fh_verify() offers an interface like fh_verify() but doesn't require
> a struct svc_rqst *, instead it also takes the specific parts as
> explicit required arguments.  So it is safe to call __fh_verify() with
> a NULL rqstp, but the net, cred, and client args must not be NULL.
>=20
> __fh_verify() does not use SVC_NET(), nor does the functions it calls.
>=20
> Rather than using rqstp->rq_client pass the client and gssclient
> explicitly to __fh_verify and then to nfsd_set_fh_dentry().
>=20
> Lastly, 4 associated tracepoints are only used if rqstp is not NULL
> (this is a stop-gap that should be properly fixed so localio also
> benefits from the utility these tracepoints provide when debugging
> fh_verify issues).
>=20

nit: this last paragraph doesn't apply anymore with the inclusion of
the previous patch

> Signed-off-by: NeilBrown <neilb@suse.de>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsfh.c | 90 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 77acc26e8b02..80c06e170e9a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -142,7 +142,11 @@ static inline __be32 check_pseudo_root(struct dentry=
 *dentry,
>   * dentry.  On success, the results are used to set fh_export and
>   * fh_dentry.
>   */
> -static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *=
fhp)
> +static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net=
,
> +				 struct svc_cred *cred,
> +				 struct auth_domain *client,
> +				 struct auth_domain *gssclient,
> +				 struct svc_fh *fhp)
>  {
>  	struct knfsd_fh	*fh =3D &fhp->fh_handle;
>  	struct fid *fid =3D NULL;
> @@ -184,8 +188,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct svc_fh *fhp)
>  	data_left -=3D len;
>  	if (data_left < 0)
>  		return error;
> -	exp =3D rqst_exp_find(&rqstp->rq_chandle, SVC_NET(rqstp),
> -			    rqstp->rq_client, rqstp->rq_gssclient,
> +	exp =3D rqst_exp_find(rqstp ? &rqstp->rq_chandle : NULL,
> +			    net, client, gssclient,
>  			    fh->fh_fsid_type, fh->fh_fsid);
>  	fid =3D (struct fid *)(fh->fh_fsid + len);
> =20
> @@ -220,7 +224,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct svc_fh *fhp)
>  		put_cred(override_creds(new));
>  		put_cred(new);
>  	} else {
> -		error =3D nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
> +		error =3D nfsd_setuser_and_check_port(rqstp, cred, exp);
>  		if (error)
>  			goto out;
>  	}
> @@ -297,43 +301,21 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *r=
qstp, struct svc_fh *fhp)
>  	return error;
>  }
> =20
> -/**
> - * fh_verify - filehandle lookup and access checking
> - * @rqstp: pointer to current rpc request
> - * @fhp: filehandle to be verified
> - * @type: expected type of object pointed to by filehandle
> - * @access: type of access needed to object
> - *
> - * Look up a dentry from the on-the-wire filehandle, check the client's
> - * access to the export, and set the current task's credentials.
> - *
> - * Regardless of success or failure of fh_verify(), fh_put() should be
> - * called on @fhp when the caller is finished with the filehandle.
> - *
> - * fh_verify() may be called multiple times on a given filehandle, for
> - * example, when processing an NFSv4 compound.  The first call will look
> - * up a dentry using the on-the-wire filehandle.  Subsequent calls will
> - * skip the lookup and just perform the other checks and possibly change
> - * the current task's credentials.
> - *
> - * @type specifies the type of object expected using one of the S_IF*
> - * constants defined in include/linux/stat.h.  The caller may use zero
> - * to indicate that it doesn't care, or a negative integer to indicate
> - * that it expects something not of the given type.
> - *
> - * @access is formed from the NFSD_MAY_* constants defined in
> - * fs/nfsd/vfs.h.
> - */
> -__be32
> -fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int =
access)
> +static __be32
> +__fh_verify(struct svc_rqst *rqstp,
> +	    struct net *net, struct svc_cred *cred,
> +	    struct auth_domain *client,
> +	    struct auth_domain *gssclient,
> +	    struct svc_fh *fhp, umode_t type, int access)

I don't consider is a show-stopper, but it might be good to have a
kerneldoc header on this, just because it has so many parameters.
Having them clearly spelled out, and the rules around what must be set
when rqstp is NULL would make it less likely we'll break those
assumptions in the future.

>  {
> -	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_export *exp =3D NULL;
>  	struct dentry	*dentry;
>  	__be32		error;
> =20
>  	if (!fhp->fh_dentry) {
> -		error =3D nfsd_set_fh_dentry(rqstp, fhp);
> +		error =3D nfsd_set_fh_dentry(rqstp, net, cred, client,
> +					   gssclient, fhp);
>  		if (error)
>  			goto out;
>  	}
> @@ -362,7 +344,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 umode_t type, int access)
>  	if (error)
>  		goto out;
> =20
> -	error =3D nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
> +	error =3D nfsd_setuser_and_check_port(rqstp, cred, exp);
>  	if (error)
>  		goto out;
> =20
> @@ -392,7 +374,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 umode_t type, int access)
> =20
>  skip_pseudoflavor_check:
>  	/* Finally, check access permissions. */
> -	error =3D nfsd_permission(&rqstp->rq_cred, exp, dentry, access);
> +	error =3D nfsd_permission(cred, exp, dentry, access);
>  out:
>  	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
>  	if (error =3D=3D nfserr_stale)
> @@ -400,6 +382,40 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp=
, umode_t type, int access)
>  	return error;
>  }
> =20
> +/**
> + * fh_verify - filehandle lookup and access checking
> + * @rqstp: pointer to current rpc request
> + * @fhp: filehandle to be verified
> + * @type: expected type of object pointed to by filehandle
> + * @access: type of access needed to object
> + *
> + * Look up a dentry from the on-the-wire filehandle, check the client's
> + * access to the export, and set the current task's credentials.
> + *
> + * Regardless of success or failure of fh_verify(), fh_put() should be
> + * called on @fhp when the caller is finished with the filehandle.
> + *
> + * fh_verify() may be called multiple times on a given filehandle, for
> + * example, when processing an NFSv4 compound.  The first call will look
> + * up a dentry using the on-the-wire filehandle.  Subsequent calls will
> + * skip the lookup and just perform the other checks and possibly change
> + * the current task's credentials.
> + *
> + * @type specifies the type of object expected using one of the S_IF*
> + * constants defined in include/linux/stat.h.  The caller may use zero
> + * to indicate that it doesn't care, or a negative integer to indicate
> + * that it expects something not of the given type.
> + *
> + * @access is formed from the NFSD_MAY_* constants defined in
> + * fs/nfsd/vfs.h.
> + */
> +__be32
> +fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int =
access)
> +{
> +	return __fh_verify(rqstp, SVC_NET(rqstp), &rqstp->rq_cred,
> +			   rqstp->rq_client, rqstp->rq_gssclient,
> +			   fhp, type, access);
> +}
> =20
>  /*
>   * Compose a file handle for an NFS reply.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

