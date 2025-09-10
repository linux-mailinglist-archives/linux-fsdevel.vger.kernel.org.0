Return-Path: <linux-fsdevel+bounces-60826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED881B51DF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A50317A8B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DF2798F5;
	Wed, 10 Sep 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ewWSoeMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC3270575;
	Wed, 10 Sep 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522350; cv=none; b=WvrRnBiHFx8B3oTKuMRubdt055RjcuojGDGMQ0ST9RuZveO1pfKm5T2QRtfwfAkx4D2kCICqOYPArHbhM0/mGezfBKA17ygEr7dw7M56DBYgljbZ2d0GkuynvfttPovw5eG9CoqIRx3sAZwz2uP7xs8hjAV9KnBLp2/9eLjxNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522350; c=relaxed/simple;
	bh=fyoQXQIcHwrUIvNO31TLoM1O9Zqsrhk1xnUmKYMZqYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi67P13Z463vkur+xn1UpmAYx0+RsiFDurQ9FOfx0QaJyjw+pzhqaFksXykjOlloQQlQeoHDxtsBFf0vng8pk+1xrMJ9CkPfLhfnK3Ax9B4P1d40x1o5WE8YusT2OKBnCE635u6jqPDhwImcBlw+XeK+mu/2wUT7S3Gk0NUf50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ewWSoeMZ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cMRGb71wkz9tRH;
	Wed, 10 Sep 2025 18:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1757522344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8UVunKIY45vYhwHOKc5wHVILWcquaDNcktx0K8FPhrs=;
	b=ewWSoeMZyssPl8xHZ8z0V4/zYD98UjxK1j1D8Ai4z0TC10w29jGy6FpB8uECc+AJUzpJyI
	rXoO/2FS4cOGBk3Bzl/R/BaDHBp2ug3CG3cpaGT/6pZaJ6fDdwJT6Vj3c2x+KHyD5jxQ/d
	Xjp2YJ9uCgYoAiD+Nvn+HxKoEz2umqVoBfT9qdd40XIXSrpF0eHaNScBU84zNWCs08LY+e
	StXgQxVVlFntQ501F/WbII+JtnNcxG08vw/27pqOItazwiqOGaK57ut9Om9LujGAzOQ/Tl
	zVJnEDKKy/MlEUv4zXWSGBx705YlE8sKitou80enL+U1k+g3JchbhnqOmlpzpg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 11 Sep 2025 02:38:47 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 26/32] nsfs: add current_in_namespace()
Message-ID: <2025-09-10-personal-preachy-halogen-illness-huN66a@cyphar.com>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-26-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xlc5qqfca35nciqm"
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-26-4dd56e7359d8@kernel.org>
X-Rspamd-Queue-Id: 4cMRGb71wkz9tRH


--xlc5qqfca35nciqm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 26/32] nsfs: add current_in_namespace()
MIME-Version: 1.0

On 2025-09-10, Christian Brauner <brauner@kernel.org> wrote:
> Add a helper to easily check whether a given namespace is the caller's
> current namespace. This is currently open-coded in a lot of places.
> Simply switch on the type and compare the results.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good, feel free to add my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>  include/linux/nsfs.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/nsfs.h b/include/linux/nsfs.h
> index fb84aa538091..e5a5fa83d36b 100644
> --- a/include/linux/nsfs.h
> +++ b/include/linux/nsfs.h
> @@ -5,6 +5,8 @@
>  #define _LINUX_NSFS_H
> =20
>  #include <linux/ns_common.h>
> +#include <linux/cred.h>
> +#include <linux/pid_namespace.h>
> =20
>  struct path;
>  struct task_struct;
> @@ -22,5 +24,17 @@ int ns_get_name(char *buf, size_t size, struct task_st=
ruct *task,
>  			const struct proc_ns_operations *ns_ops);
>  void nsfs_init(void);
> =20
> -#endif /* _LINUX_NSFS_H */
> +#define __current_namespace_from_type(__ns)				\
> +	_Generic((__ns),						\
> +		struct cgroup_namespace *: current->nsproxy->cgroup_ns,	\
> +		struct ipc_namespace *:    current->nsproxy->ipc_ns,	\
> +		struct net *:              current->nsproxy->net_ns,	\
> +		struct pid_namespace *:    task_active_pid_ns(current),	\
> +		struct mnt_namespace *:    current->nsproxy->mnt_ns,	\
> +		struct time_namespace *:   current->nsproxy->time_ns,	\
> +		struct user_namespace *:   current_user_ns(),		\
> +		struct uts_namespace *:    current->nsproxy->uts_ns)
> +
> +#define current_in_namespace(__ns) (__current_namespace_from_type(__ns) =
=3D=3D __ns)
> =20
> +#endif /* _LINUX_NSFS_H */
>=20
> --=20
> 2.47.3
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--xlc5qqfca35nciqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaMGplxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8lPQD+NApDKaW4M8pv6R7a51On
uCLR3fnsMihbWdVUX0stY1cA/AmoZ/8sX104FAD981fIcw2HdcoGpdjKBkLYZdek
JDME
=FNUj
-----END PGP SIGNATURE-----

--xlc5qqfca35nciqm--

