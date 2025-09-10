Return-Path: <linux-fsdevel+bounces-60824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A56B51DCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8213A85DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64D270ED7;
	Wed, 10 Sep 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="walGIySX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B8257AEC;
	Wed, 10 Sep 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522026; cv=none; b=jbpUmMPJXw78gE5+ksTL9+gEPJDiVehtK9zVwTbW0KtwW//SXFNJYvRpccWVeN2hKTYhFMZhl3hdkB/+bO/QdNfko+xvwGtgA0mFxF76TalX+Xj96BjMOlXFVgzhB/GUrV+ulbvudDT5HiFFtaEy/UgQizXgIzxVh5ol49nLvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522026; c=relaxed/simple;
	bh=TANS7+tdf/LvPh8rThStViQ9NGrZA+eKprOo3uGZrLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewL3nzMNEfabHLXedisRlZkUkmevn/NkWYNJ7PThUwuAQWd2oNDE31U5YJCSaJ1hQGE2hu2ygVpKeEiLWM/SkXJVgBr9uZhApiByW5NNuqBKKYBzMD4aPQjAmxw29FNr8XC/s5cd4/qyYO2Fa3CAjVpaHgFmpWXItGFQYR/0Kq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=walGIySX; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cMR8M6xjYz9tvZ;
	Wed, 10 Sep 2025 18:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1757522020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFhu/9tuXD479eCt6PebfTg8lX9JB/VHXU3+8U9v9hs=;
	b=walGIySXpnoW4A8BU2yV93WfdaN0bpkt6mBPJdfij7Un1eI21pNdvo++nzR4MIi+MK+FkW
	vrcraKejDnjZjhNZ8yJHiL87JxyP0ubO5NPk11l07SVqSYLmnKEFpCS7r6ZpulXqY+E7/C
	lZfqVRcB90hS3WkhniBSa1I7VLH3tFWenj+jUYiA3C+2VVt9QMtAQt9LC5iqJeW05EHrHs
	m84ociybCF0+PVPpZnqsMavipKHeWiqtkB0TkjqU0WpSu97x0ERYhcaRdWwAE0GJCLlgjO
	F/C8hvkU46ZQp0Qms7X32D4I+NxG2eVrlFFdyoDnPdzZwPukr0Q8hVUU+t8Ghg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 11 Sep 2025 02:33:18 +1000
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
Subject: Re: [PATCH 01/32] pidfs: validate extensible ioctls
Message-ID: <2025-09-10-random-finer-pause-treasury-MBAX3P@cyphar.com>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yjrth425odgu27a4"
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org>
X-Rspamd-Queue-Id: 4cMR8M6xjYz9tvZ


--yjrth425odgu27a4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/32] pidfs: validate extensible ioctls
MIME-Version: 1.0

On 2025-09-10, Christian Brauner <brauner@kernel.org> wrote:
> Validate extensible ioctls stricter than we do now.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c         |  2 +-
>  include/linux/fs.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..0a5083b9cce5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
>  		 * erronously mistook the file descriptor for a pidfd.
>  		 * This is not perfect but will catch most cases.
>  		 */
> -		return (_IOC_TYPE(cmd) =3D=3D _IOC_TYPE(PIDFD_GET_INFO));
> +		return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER=
0);
>  	}
> =20
>  	return false;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..2f2edc53bf3c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -4023,4 +4023,18 @@ static inline bool vfs_empty_path(int dfd, const c=
har __user *path)
> =20
>  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter=
);
> =20
> +static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> +					  unsigned int cmd_b, size_t min_size)
> +{
> +	if (_IOC_DIR(cmd_a) !=3D _IOC_DIR(cmd_b))
> +		return false;
> +	if (_IOC_TYPE(cmd_a) !=3D _IOC_TYPE(cmd_b))
> +		return false;
> +	if (_IOC_NR(cmd_a) !=3D _IOC_NR(cmd_b))
> +		return false;
> +	if (_IOC_SIZE(cmd_a) < min_size)
> +		return false;
> +	return true;
> +}
> +

nit: I know only we use them for now, but does this maybe belong in
ioctl.h (or even uaccess.h with the other extensible struct stuff)?

Otherwise,

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

>  #endif /* _LINUX_FS_H */
>=20
> --=20
> 2.47.3
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--yjrth425odgu27a4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaMGoThsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9tOAEAkwboDbdfy2l6+xUcPkEY
QOcwGOeIOOgORPljUvqTtPgBAMV5PpdlLiP9vSf9td25629vpEsxSAXsP5V30D+v
MPgH
=qT/D
-----END PGP SIGNATURE-----

--yjrth425odgu27a4--

