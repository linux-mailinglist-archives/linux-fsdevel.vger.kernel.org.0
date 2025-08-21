Return-Path: <linux-fsdevel+bounces-58615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4699B2FCB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A751D21EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB5266565;
	Thu, 21 Aug 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Kr5/s2BQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01762EC551;
	Thu, 21 Aug 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786093; cv=none; b=mg6sGOJ3wSfz1FYZu7ve4mBwFpKiJABay7GsWTuLjczhLyEl+cYcrrOHeW6xY+zqVJXtiGHO2O30MwozpeVCrixCvmZM/P3uqWDCYu8vWuT6X/ljF4hsuE9dw8KmEUtt5GbVpDKGXdDK/7WBT2vG71HgZoQfWkHXfBdXe9cLE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786093; c=relaxed/simple;
	bh=Vb2F+1YyfLyYDbBvxHKpFvzAWDyxW1OpfmWp6x/xB0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmM9WpbjSXaBIiLln+CxseXhn9to8SNeaeEutNGYM2N6EPxNEqeM3PauahvvnwOD0mbvCzu4zn4FjqQ/+DXvZFxRZoJO2pRIO0MiTmVbpwKki7FlgeTJL0aSBPwYAUa9q/KW2mk0U/8ftvLnDsE6Bt4iAxVLZL34ATBaW56j7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Kr5/s2BQ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c758y38mCz9smF;
	Thu, 21 Aug 2025 16:21:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755786082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fW3Zzx4J8tGS72KjNJnVUhaHtHsXE0Z0H9CSM70UsDs=;
	b=Kr5/s2BQubpmBB8hHQQAUB6etiNM4h6E6thzMmaQnKfCymVva8DBHBG54j6HuhDhkxWwrV
	5/447MFJJp07PckYe5JoOrb6tPddsM7HT83PDLziKjKa05mbw9zoBA2Yx7u5FtJZlDd55T
	251bJnqvZc/jFMQMz61+I+/zh9yN6agNsuIISsWqd3Kjv1tu1/917TPqqqorL5Rii7pP2z
	pv1L6Uow8egV7ut9UB8zvAQu6CbqawXBxVMvkzOs6ne37GeHV2Lbyzl3RisrJwbiutAWXQ
	BnXDxMojrt/hYumfmgxISnUJEwF+9TghaS4jDP3VyfYuoHAkcdrSBsbUyy21ew==
Date: Fri, 22 Aug 2025 00:21:06 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <2025-08-21.1755785636-rusted-ivory-corgi-salad-fYNRl1@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <198cc8d3da6.124bd761f86893.6196757670555212232@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jsdomwd2btigmqhb"
Content-Disposition: inline
In-Reply-To: <198cc8d3da6.124bd761f86893.6196757670555212232@zohomail.com>


--jsdomwd2btigmqhb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
MIME-Version: 1.0

On 2025-08-21, Askar Safin <safinaskar@zohomail.com> wrote:
> There is one particular case when open_tree is more powerful than openat =
with O_PATH. open_tree supports AT_EMPTY_PATH, and openat supports nothing =
similar.
> This means that we can convert normal O_RDONLY file descriptor to O_PATH =
descriptor using open_tree! I. e.:
>   rd =3D openat(AT_FDCWD, "/tmp/a", O_RDONLY, 0); // Regular file
>   open_tree(rd, "", AT_EMPTY_PATH);
> You can achieve same effect using /proc:
>   rd =3D openat(AT_FDCWD, "/tmp/a", O_RDONLY, 0); // Regular file
>   snprintf(buf, sizeof(buf), "/proc/self/fd/%d", rd);
>   openat(AT_FDCWD, buf, O_PATH, 0);
> But still I think this has security implications. This means that even if=
 we deny access to /proc for container, it still is able to convert O_RDONLY
> descriptors to O_PATH descriptors using open_tree. I. e. this is yet anot=
her thing to think about when creating sandboxes.
> I know you delivered a talk about similar things a lot of time ago: https=
://lwn.net/Articles/934460/ . (I tested this.)

O_RDONLY -> O_PATH is less of an issue than the other way around. There
isn't much you can do with O_PATH that you can't do with a properly open
file (by design you actually should have strictly less privileges but
some operations are only really possible with O_PATH, but they're not
security-critical in that way).

I was working on a new patchset for resolving this issue (and adding
O_EMPTYPATH support) late last year but other things fell on my plate
and the design was quite difficult to get to a place where everyone
agreed to it.

The core issue is that we would need to block not just re-opening but
also any operation that is a write (or read) in disguise, which kind of
implies you need to have capabilities attached to file descriptors. This
is already slightly shaky ground if you look at the history of projects
like capsicum -- but also my impression was that just adding it to
"file_permission" was not sufficient, you need to put it in
"path_permission" which means we have to either bloat "struct path" or
come up with some extended structure that you need to plumb through
everywhere.

But yes, this is a thing that is still on my list of things to do, but
not in the immediate future.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--jsdomwd2btigmqhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKcrThsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9TSwD9Ez8Vfzuiim607l6uNQY4
4f9TZbwHuIVkqc4PsjYgz3UBANuelZQN20hYZ3EVADF7hQ6wiLdCEdTVMElYczRh
XRIJ
=fSGM
-----END PGP SIGNATURE-----

--jsdomwd2btigmqhb--

