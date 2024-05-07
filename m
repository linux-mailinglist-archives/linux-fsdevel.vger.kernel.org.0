Return-Path: <linux-fsdevel+bounces-18877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 252388BDCB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E9B1C229ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 07:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166413C81A;
	Tue,  7 May 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="dCkyrJBG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F078274;
	Tue,  7 May 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068282; cv=none; b=mo4qSMbCY2q2lLs/SzkmW7vfa2xjFfd6IqBMIa2JRjP0PNju2LKgTdVTwb5mX3ASmWw/Eg3bNWcSffxgVGl/0aUgmB2bwCb6ORA7uey70ubgGve0npIYPnbi3DIGm5SBZI23st8MAcnnouh6M2wkm4LBgIX16viQnX2pZ+yE2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068282; c=relaxed/simple;
	bh=Yt1ERYjJEdTGYm8TRtzABKvuMdbrTzwn9Sc8/9cixag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvESmCZTO1G/FG6foVNfWGZsZNE8einqZMxrYx2RWEgBYOq085KteR1+q6k9nQWZZKZJHw1lGM1ioPKTKz63MbejxJZosmZDm6LK6XSnVkJ7/3ojVt/dgpsh8UqQEr5VHOiYLYZny3thR02QVJaa4ba6B2c2X6OxsF3qU+VvscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=dCkyrJBG; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VYVpB3Qxsz9sls;
	Tue,  7 May 2024 09:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1715068274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt1ERYjJEdTGYm8TRtzABKvuMdbrTzwn9Sc8/9cixag=;
	b=dCkyrJBG5z7WLTGoSi3Di7SZ1dymYcoHun/rKWymCVjq6wOgRGVO65Y12Xt1MWmNUsWezI
	vV424TbvVZnEV6NCJoGw8WpQTDzyR2gzcIqFjQgiF02bZRQITTXUZiJdWtnttUXuBllZEa
	UdEWR8Z1jhyjoS9s4BRi49T62IoRQelINWy9jUrMK27lchoPA1wNlXKVPrKdIPwnnbhbXq
	qXVFeA7Cfozrt36mPhtTahiuEVHo8T2+OLR7uZaYwt/Hqa4/hHhu0X0dTAteABkpx/dPPT
	bNkw1/ynZ+viD6psUfEgo+W3iz/A/U7bQENQbEUC4ubVUYTFOqgLPxe8Dk+QDA==
Date: Tue, 7 May 2024 17:50:58 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
Message-ID: <20240506.071502-teak.lily.alpine.girls-aiKJgErDohK@cyphar.com>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyexfaaq2zqn7bci"
Content-Disposition: inline
In-Reply-To: <20240427112451.1609471-1-stsp2@yandex.ru>


--lyexfaaq2zqn7bci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-27, Stas Sergeev <stsp2@yandex.ru> wrote:
> This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLOW
> flag. This allows the process to pre-open some dirs and switch eUID
> (and other UIDs/GIDs) to the less-privileged user, while still retaining
> the possibility to open/create files within the pre-opened directory set.
>=20
> The sand-boxing is security-oriented: symlinks leading outside of a
> sand-box are rejected. /proc magic links are rejected. fds opened with
> O_CRED_ALLOW are always closed on exec() and cannot be passed via unix
> socket.
> The more detailed description (including security considerations)
> is available in the log messages of individual patches.

(I meant to reply last week but I couldn't get my mail server to send
mail...)

It seems to me that this can already be implemented using
MOUNT_ATTR_IDMAP, without creating a new form of credential overriding
within the filesystem (and with such a deceptively simple
implementation...)

If you are a privileged process which plans to change users, you can
create a detached tree with a user mapping that gives that user access
to only that tree. This is far more effective at restricting possible
attacks because id-mapped mounts don't override credentials during VFS
operations (meaning that if you miss something, you have a big problem),
instead they only affect uid-related operations within the filesystem
for that mount. Since this implementation does no inherit
CAP_DAC_OVERRIDE, being able to rewrite uid/gids is all you need.

A new attack I just thought of while writing this mail is that because
there is no RESOLVE_NO_XDEV requirement, it should be possible for the
process to get an arbitrary write primitive by creating a new
userns+mountns and then bind-mounting / underneath the directory. Since
O_CRED_INHERIT uses override_creds, it doesn't care about whether
something about the O_CRED_ALLOW directory changed afterwards. Yes, you
can "just fix this" by adding a RESOLVE_NO_XDEV requirement too, but
given that there have been 2-3 security issues with this design found
already, it makes me feel really uneasy. Using id-mapped mounts avoids
this issue because the new mount will not have the id-mapping applied
and thus there is no security issue.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--lyexfaaq2zqn7bci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZjndYQAKCRAol/rSt+lE
b2oOAQCmKy2OE9MgmZTVxlKN+/Sdcj0IpZ+qML12Z2Jmhr8r6QD+JguvCHBD2QUw
5QTi+WIy7+VPoIpn+aXJKiYsm0xm4AU=
=VQBl
-----END PGP SIGNATURE-----

--lyexfaaq2zqn7bci--

