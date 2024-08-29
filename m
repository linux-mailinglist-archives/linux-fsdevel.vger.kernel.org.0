Return-Path: <linux-fsdevel+bounces-27887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4CF964AE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6541C24C06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFE31B3B24;
	Thu, 29 Aug 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy0rQimh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B61A2C0A;
	Thu, 29 Aug 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947289; cv=none; b=GESVXJooVW7/6gZTeG4Hpqz1Ed3aB7CVFHEUJd3YweJDN287ZkPyI0qfvmYfOcd5i379xVR2j/mfiIvhJbVTBvb+rnIU99R+6oJf1u0gjjzTXPhE64n6FhRiJYAGtlYPt4Fqr7bctWN+v6J1GJ/tYyJq8RTbJj7orrbo+Rdj2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947289; c=relaxed/simple;
	bh=C8qf+s+XYvecrUkzEezH8R7UaFIkF9gx9JAwSeMyL/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yj7AuiCLa+XHePZpBVXg83eXIEPyeOUyZ1FZlaFZpGj1aOwKfR5G4pGNqptCqHasoVdgJjS0R4DFXhWl1ZQc86U4uPT4yUjtAvWHT8pwxIChxwGe/i85XXsWPAlfgg0Ep1Ue9SqC7At6IMVbPBPIrNY3BsQBqVxThAw18jWajIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy0rQimh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B567C4CEC2;
	Thu, 29 Aug 2024 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947288;
	bh=C8qf+s+XYvecrUkzEezH8R7UaFIkF9gx9JAwSeMyL/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Gy0rQimhGsOzyL3x9F+nUQcspHsqLRKpPuRPzTXtdZ7UZqpU0uiKUzzQl2EgF8zQR
	 ePKlvKlQi2eXDKkMdxza5t75rLGPSCSMNqKjn4do0DkeyZ4tJ+eP+O9aJ8oTOvVtjO
	 S4uhdke3vfkK5bgRUePNcY+gRIbE8Bf+3e81FLESqrQVuCcnTrlSwdzygQaBlY/fhF
	 UVm3PZ3j73cFYu/NZdnjfGYs5Fh2b49rStfm8BaluzDGrwrlpJu8RfPzFbPxbCR8JP
	 /f89p6FBFlPjCgttV2fKPNys0ojGnP9pUKtx/tsrGCNQOk+bMRkrN15XVP8GnU+qBq
	 a5kVkEvrAsIGQ==
Message-ID: <db33990c28c6318fa689150e09784420e1b5d0f1.camel@kernel.org>
Subject: Re: [PATCH v14 12/25] SUNRPC: add svcauth_map_clnt_to_svc_cred_local
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 12:01:27 -0400
In-Reply-To: <20240829010424.83693-13-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-13-snitzer@kernel.org>
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
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add new funtion svcauth_map_clnt_to_svc_cred_local which maps a
> generic cred to a svc_cred suitable for use in nfsd.
>=20
> This is needed by the localio code to map nfs client creds to nfs
> server credentials.
>=20
> Following from net/sunrpc/auth_unix.c:unx_marshal() it is clear that
> ->fsuid and ->fsgid must be used (rather than ->uid and ->gid).  In
> addition, these uid and gid must be translated with from_kuid_munged()
> so local client uses correct uid and gid when acting as local server.
>=20
> Suggested-by: NeilBrown <neilb@suse.de> # to approximate unx_marshal()
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  include/linux/sunrpc/svcauth.h |  5 +++++
>  net/sunrpc/svcauth.c           | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcaut=
h.h
> index 63cf6fb26dcc..2e111153f7cd 100644
> --- a/include/linux/sunrpc/svcauth.h
> +++ b/include/linux/sunrpc/svcauth.h
> @@ -14,6 +14,7 @@
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/cache.h>
>  #include <linux/sunrpc/gss_api.h>
> +#include <linux/sunrpc/clnt.h>
>  #include <linux/hash.h>
>  #include <linux/stringhash.h>
>  #include <linux/cred.h>
> @@ -157,6 +158,10 @@ extern enum svc_auth_status svc_set_client(struct sv=
c_rqst *rqstp);
>  extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *a=
ops);
>  extern void	svc_auth_unregister(rpc_authflavor_t flavor);
> =20
> +extern void	svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
> +						   const struct cred *,
> +						   struct svc_cred *);
> +
>  extern struct auth_domain *unix_domain_find(char *name);
>  extern void auth_domain_put(struct auth_domain *item);
>  extern struct auth_domain *auth_domain_lookup(char *name, struct auth_do=
main *new);
> diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
> index 93d9e949e265..55b4d2874188 100644
> --- a/net/sunrpc/svcauth.c
> +++ b/net/sunrpc/svcauth.c
> @@ -18,6 +18,7 @@
>  #include <linux/sunrpc/svcauth.h>
>  #include <linux/err.h>
>  #include <linux/hash.h>
> +#include <linux/user_namespace.h>
> =20
>  #include <trace/events/sunrpc.h>
> =20
> @@ -175,6 +176,33 @@ rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rq=
stp)
>  }
>  EXPORT_SYMBOL_GPL(svc_auth_flavor);
> =20
> +/**
> + * svcauth_map_clnt_to_svc_cred_local - maps a generic cred
> + * to a svc_cred suitable for use in nfsd.
> + * @clnt: rpc_clnt associated with nfs client
> + * @cred: generic cred associated with nfs client
> + * @svc: returned svc_cred that is suitable for use in nfsd
> + */
> +void svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
> +					const struct cred *cred,
> +					struct svc_cred *svc)
> +{
> +	struct user_namespace *userns =3D clnt->cl_cred ?
> +		clnt->cl_cred->user_ns : &init_user_ns;
> +
> +	memset(svc, 0, sizeof(struct svc_cred));
> +
> +	svc->cr_uid =3D KUIDT_INIT(from_kuid_munged(userns, cred->fsuid));
> +	svc->cr_gid =3D KGIDT_INIT(from_kgid_munged(userns, cred->fsgid));
> +	svc->cr_flavor =3D clnt->cl_auth->au_flavor;
> +	if (cred->group_info)
> +		svc->cr_group_info =3D get_group_info(cred->group_info);
> +	/* These aren't relevant for local (network is bypassed) */
> +	svc->cr_principal =3D NULL;
> +	svc->cr_gss_mech =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(svcauth_map_clnt_to_svc_cred_local);
> +
>  /**************************************************
>   * 'auth_domains' are stored in a hash table indexed by name.
>   * When the last reference to an 'auth_domain' is dropped,

This is where the magic happens. Took me a bit to understand, but since
we're working in kuid_t/kgid_t, we don't need to worry about further
idmapping.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

