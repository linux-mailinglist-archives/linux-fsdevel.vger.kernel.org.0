Return-Path: <linux-fsdevel+bounces-62228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6822B89704
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A0A17738E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E8311C2D;
	Fri, 19 Sep 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="KEG8D4RK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA731079C;
	Fri, 19 Sep 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284647; cv=none; b=M8exR3H1hCKCV9Lgv6JpMYpcD4/74jwTDUPr+rfwiKu/HJpComA6pV7ZBrAIa6CSSX/5QalQ3g9U8xddFNDgGZhcEz7UnbUtzGU5obhnaXRBDRRQ6n3jipJwTt9eQM57bNDgdQ7kg5WVZLaR5pB6+v/dXxammwQKDFWULzwjAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284647; c=relaxed/simple;
	bh=48XYnCxrzuH16uBlEv1kRze0Jj/p7JOo3IlEZ/mmKos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2xH6VVSVlb94Q/2BMA2cSNFJPPHvHr4fP8GFti+fqjbgFNLuszvAJqq/6QVoGHdtKRgEATwCF96VWn+uYSTgblSyA/8wt+O0y2u2Y1ezjg222++LCQJMO7TNSLuxvaWiQD+LHAv0+Du8iA7GK6zTUyJcjdjpQ4usrDBN9t5IFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=KEG8D4RK; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSsB95mHJz9tKf;
	Fri, 19 Sep 2025 14:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758284641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rh6Z5Z0CEMmSPdcpAoas408EgFHWJGPGyj0yviBdFn8=;
	b=KEG8D4RKebUI06Gm9mQZw9ngooUIOQAtlgV5Xkymn4K6M3Qho1aVrId6iVlFhAar/SaMGL
	VX3VouqWmVxvMPTMX5p+YqdmvOnsRpzhvT5lWEislxA1c86w5XeVuGk0sJ7oIqRqHCtATc
	fKDNyJjhNNBkEaAYYqwIJqBS0Umdg9fqc6/cL1A1WMV9LlFZyAcQbZhrn7CHxqmnR8GRtf
	hS/Eg3ui1ZdYh8QEii5K2h7rbPmIY5zp5daGzXnnlsI2+zwJ/ILpfPHauz4nfVmWE8ZkDN
	JnZZALSIBAqEGyAkUlH9N7qURGAVBoD18se7CX0VEnAZGcQjbSGb04Bsg1cbiQ==
Date: Fri, 19 Sep 2025 22:23:47 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note
 about attribute-parameter distinction
Message-ID: <2025-09-19-retro-married-traction-cinch-dgVzgj@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esn6txawyawfxu7d"
Content-Disposition: inline
In-Reply-To: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>


--esn6txawyawfxu7d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note
 about attribute-parameter distinction
MIME-Version: 1.0

On 2025-09-19, Aleksa Sarai <cyphar@cyphar.com> wrote:
> This was not particularly well documented in mount(8) nor mount(2), and
> since this is a fairly notable aspect of the new mount API, we should
> probably add some words about it.
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man/man2/fsconfig.2      | 12 ++++++++++++
>  man/man2/mount_setattr.2 | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
> index 5a18e08c700ac93aa22c341b4134944ee3c38d0b..d827a7b96e08284fb025f94c3=
348a4acc4571b7d 100644
> --- a/man/man2/fsconfig.2
> +++ b/man/man2/fsconfig.2
> @@ -579,6 +579,18 @@ .SS Generic filesystem parameters
>  Linux Security Modules (LSMs)
>  are also generic with respect to the underlying filesystem.
>  See the documentation for the LSM you wish to configure for more details.
> +.SS Mount attributes and filesystem parameters
> +Some filesystem parameters
> +(traditionally associated with
> +.BR mount (8)-style
> +options)
> +have a sibling mount attribute
> +with superficially similar user-facing behaviour.
> +.P
> +For a description of the distinction between
> +mount attributes and filesystem parameters,
> +see the "Mount attributes and filesystem parameters" subsection of
> +.BR mount_setattr (2).
>  .SH CAVEATS
>  .SS Filesystem parameter types
>  As a result of
> diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> index b27db5b96665cfb0c387bf5b60776d45e0139956..f7d0b96fddf97698e36cab020=
f1d695783143025 100644
> --- a/man/man2/mount_setattr.2
> +++ b/man/man2/mount_setattr.2
> @@ -790,6 +790,46 @@ .SS ID-mapped mounts
>  .BR chown (2)
>  system call changes the ownership globally and permanently.
>  .\"
> +.SS Mount attributes and filesystem parameters
> +Some mount attributes
> +(traditionally associated with
> +.BR mount (8)-style
> +options)
> +have a sibling mount attribute
> +with superficially similar user-facing behaviour.
> +For example, the
> +.I -o ro
> +option to
> +.BR mount (8)
> +can refer to the
> +"read-only" filesystem parameter,
> +or the "read-only" mount attribute.
> +Both of these result in mount objects becoming read-only,
> +but they do have different behaviour.
> +.P
> +The distinction between these two kinds of option is that
> +mount object attributes are applied per-mount-object
> +(allowing different mount objects
> +derived from a given filesystem instance
> +to have different attributes),
> +while filesystem instance parameters
> +("superblock flags" in kernel-developer parlance)
> +apply to all mount objects
> +derived from the same filesystem instance.
> +.P
> +When using
> +.BR mount (2),
> +the line between these two types of mount options was blurred.
> +However, with
> +.BR mount_setattr ()
> +and
> +.BR fsconfig (2),
> +the distinction is made much clearer.
> +Mount attributes are configured with
> +.BR mount_setattr (),
> +while filesystem parameters can be configured using
                               are configured using

probably reads a bit better here. I'll include it in the next version if
this isn't merged, but I won't resend the whole patchset for a one-word
change.

> +.BR fsconfig (2).
> +.\"
>  .SS Extensibility
>  In order to allow for future extensibility,
>  .BR mount_setattr ()
>=20
> --=20
> 2.51.0
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--esn6txawyawfxu7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaM1LUxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+KdQEAmB6gnRX4SP/rkb3R9Oan
CRdJBvXYZpUFgqVlaibiN+IA/jJ7rIeFWwI6HFxhFM0CYosCsidSJxb/tlHaE8Pb
YRoO
=Q2XP
-----END PGP SIGNATURE-----

--esn6txawyawfxu7d--

