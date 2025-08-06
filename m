Return-Path: <linux-fsdevel+bounces-56816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D301B1C03A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DC217A3F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77183202F7B;
	Wed,  6 Aug 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="J0hMM8ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F32BCF5;
	Wed,  6 Aug 2025 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460403; cv=none; b=VjvGB6jn05bqN6cdgm9HpiuxrnldLERNxmD9Ull/itSLWpq2nInMjtIgf55yF04CZCg0Lxo3vmZVOqPBboYzKCmNShzoj2o6OpZx/7lq/e7/7TuPcOcwmjtqg6Y0cyQrz++UGH69WejwZxhhaGyhmxPHpTaLt8x9AsMM8jkZw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460403; c=relaxed/simple;
	bh=Uyp/hwAtSj9mNIQo3obU6b0vPzN5bqdhduVEfNnkYZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+ueK1lzqCa008WNpRm+DvSaEieU7Q0iMAseW/Qo8lmB8SNsmpFvkvcGBagC33wDNOXItIO0JrfRIOnPxOfrZFcfh55CO3hqEdurJ8FBdRdmS8hi0MsIyUXkMd3qJjw7CwauSAOdcRx5sVDhRAMCpUs+M4ft58H99Be2kmrE6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=J0hMM8ls; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxfv06z22z9t7F;
	Wed,  6 Aug 2025 08:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754460397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWGw+MqcaJwpm2eZf0xXjZFgzKUTXlAI5B5hrd4w16o=;
	b=J0hMM8lsR4+LICqo3o73kgSqqEg64JQhVbGFB8NSS6VvD4kOAkixPmObk5gQuD72kAg7jV
	c6umHHkEbd4aFtlK6ft3ZGckGRyBq3bA2nhYbf9IhqmrgXeKvHjSV8p0HmC3S8JQaAte/Y
	HViFLaA+q9FtaoKrEVMrHV0KDclPa06L5RtKiVHximtcU2754KlbNedcmMEmUfrQgo6D7h
	YnveOae+SdGzrbl1ais5UN1cpnFeqKzk91UQ/KSRjPwlr70poFrqpiZFxbUDmGl7xdRv1L
	9+2vxq8+pgANqIZhXIzIpRUmzVFmMEIyrGvrZWgySIp2FD/IO0aiHishEd4QFA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 6 Aug 2025 16:06:26 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: output mount_too_revealing() errors to fscontext
Message-ID: <2025-08-06.1754460368-noisy-refuge-smug-prawn-butch-motel-aC7jBh@cyphar.com>
References: <20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>
 <20250806-errorfc-mount-too-revealing-v1-2-536540f51560@cyphar.com>
 <20250806054116.GE222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eyrb2zn4om7t3wfb"
Content-Disposition: inline
In-Reply-To: <20250806054116.GE222315@ZenIV>
X-Rspamd-Queue-Id: 4bxfv06z22z9t7F


--eyrb2zn4om7t3wfb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] vfs: output mount_too_revealing() errors to fscontext
MIME-Version: 1.0

On 2025-08-06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Aug 06, 2025 at 02:48:30PM +1000, Aleksa Sarai wrote:
>=20
> >  	error =3D security_sb_kern_mount(sb);
> > -	if (!error && mount_too_revealing(sb, &mnt_flags))
> > +	if (!error && mount_too_revealing(sb, &mnt_flags)) {
> >  		error =3D -EPERM;
> > +		errorfcp(fc, "VFS", "Mount too revealing");
> > +	}
>=20
> Hmm...  For aesthetics sake, I'd probably do logging first; otherwise
> fine by me.

Good point, I'll send a v2.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--eyrb2zn4om7t3wfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJLw4gAKCRAol/rSt+lE
bx0sAQCJIBvgtzUFuI6m65xu+otz0kwLnDDkqJNCVWbZQTjfIQEA6QYACdvvXHCp
RcLUYEYnrardXGDALugPC9O3K9S9hAM=
=Mmre
-----END PGP SIGNATURE-----

--eyrb2zn4om7t3wfb--

