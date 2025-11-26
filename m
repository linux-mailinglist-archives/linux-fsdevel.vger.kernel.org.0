Return-Path: <linux-fsdevel+bounces-69895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29FC8A4D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF9744E062A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4442FA0DB;
	Wed, 26 Nov 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVYxNYWl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF8258CDC
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166963; cv=none; b=eG8BlZaj2xw7lYnK+VKnj4622HhbTYhhIUxAkRcxjAU4O+oIIqYAmaOwc/mcuqCm8SKeL2dsW7RPV5qen0dQekNNDGyjH0SiGSsNo+4LwaaxTDt55+JCgRYWQqLlys+Hxn3qBO5PhEXT3U4lJQKoVYILusOSm115jItyKrM1rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166963; c=relaxed/simple;
	bh=RY1bRcxqRc86CcKiNe1eU3xI+9QYthwhSOn82WxQJ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8/LFoKOZRZ6brZ0ndXalW4RFJjvVen+A0/WttbMFgsbQUnF26YQSofbrNHKmWN5r8DAx+j73CRXk9Sbh6L/B1hSpD5JV2wKuLxrxHEU6xNRhTRX11h9quVkEUd29fVnjiIYWV3DN47i+pG/4uQU9lgiZWFFZ1HXwScqyTdOsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVYxNYWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A851FC4CEF8;
	Wed, 26 Nov 2025 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764166963;
	bh=RY1bRcxqRc86CcKiNe1eU3xI+9QYthwhSOn82WxQJ34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVYxNYWl+0TKd/vsXNquim4JWMD1z+IZMUT+d9xRrCZaTk7OXFhX6uBhKOB/x/VET
	 oXyg0ChYSBL8+h30A7yg+EXwNA00txD042spwFnejm/QlAdhHiQ19u3vq+CkSKEYR1
	 ajmPQXReBMXVZQc7yTEY5wQeAjs2eQ+o55LWvsAX5wYPLMfjV0t6V3qCYuzbor/l5o
	 daCxZJyW/OhCn0lzcS4WuOMFoCsu6jvrVAIcnInARgUfyBWOv1umjwkzxpWPCNqoGn
	 x0Dg/YMyBsEyjiXjKvebQBsh5UT3qHo5BpEO+D8w/wMtW8f8PdUBj2pfEIT1uW5v3v
	 ehHbh60nxbpQw==
Date: Wed, 26 Nov 2025 14:22:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 42/47] tty: convert ptm_open_peer() to FD_PREPARE()
Message-ID: <d59dab4d-d66b-4638-b790-5e02ea89c4bd@sirena.org.uk>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-42-b6efa1706cfd@kernel.org>
 <37ac7af5-584f-4768-a462-4d1071c43eaf@sirena.org.uk>
 <20251126-simulation-vertiefen-ad4be4d47f0d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v+dqM9jv8hjcVOCI"
Content-Disposition: inline
In-Reply-To: <20251126-simulation-vertiefen-ad4be4d47f0d@brauner>
X-Cookie: Murphy was an optimist.


--v+dqM9jv8hjcVOCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 02:35:33PM +0100, Christian Brauner wrote:
> On Tue, Nov 25, 2025 at 10:39:37PM +0000, Mark Brown wrote:

> > I'm seeing a regression in -next in the filesystems devpts_pts kselftest
> > which bisects to this patch:
> >=20
> > # selftests: filesystems: devpts_pts
> > # Failed to perform TIOCGPTPEER ioctl
> > # Failed to unmount "/dev/pts": Device or resource busy
>=20
> Yeah, this is a dumb bug. I fixed that.
>=20
> Adding:
>=20
> commit 138027e74e9f602e3bb91112dd38840c7a5007e4
> Author:     Christian Brauner <brauner@kernel.org>
>=20
>     devpts: preserve original file opening pattern
>=20
>     LTP seems to have assertions about what errnos are surfaced in what
>     order. I think that's often misguided but we can accomodate this here
>     and preserve the original order.
>=20
>     This also makes sure to unconditionally release the reference on the
>     mount that we've taken after we opened the file.

With this kselftest one the return code that's affected appears to be
the ABI for determining if the ioctl() is supported:

#ifdef TIOCGPTPEER
	slave =3D ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);
#endif
	if (slave < 0) {
		if (errno =3D=3D EINVAL) {
			fprintf(stderr, "TIOCGPTPEER is not supported. "
					"Skipping test.\n");
			fret =3D KSFT_SKIP;
		} else {
			fprintf(stderr,
				"Failed to perform TIOCGPTPEER ioctl\n");
			fret =3D EXIT_FAILURE;
		}
		goto do_cleanup;
	}

which seems sensible enough and reasonable to test for, even if -EINVAL
isn't a great return code for this usage (I'll send a patch
fixing/removing the !TOCGPTPEER case).

--v+dqM9jv8hjcVOCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmknDS4ACgkQJNaLcl1U
h9BUtAf8DsF231b9abDZADVGz5PI35VjAOUBzeiTy+apnmPZOYL434ecwdQr/KR/
3Bl820sLuIF47ErMG1kPSb5pUGOz36+7kXWYYirOwvnCLHSZcF/MVttGgbC/jvJX
7WOWEdIiT2UifqmQPK5ZyYqSOaksM36ByHDFh1c4EUhpSxGfgwURO+S8dp/Ml2iJ
am8QFNbcHlXHumfLaQxKDCpePeuYGreFgkFjsNlwQD1uTMVd1aykgkEGWUHadqpE
i+kf1vJpPm8BNZOg5fkczmZM9CYmTEOPBt3Yrb7UHEMQ52JFLa4o/2GUggXLbNEU
1miljnrnlxg37iQeCqTqjBAKei5IwQ==
=XY3A
-----END PGP SIGNATURE-----

--v+dqM9jv8hjcVOCI--

