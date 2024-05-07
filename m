Return-Path: <linux-fsdevel+bounces-18896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF25F8BE17E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21881C223E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA5156F32;
	Tue,  7 May 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="pww/xPVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77667156C72;
	Tue,  7 May 2024 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083125; cv=none; b=e86sAzGQk69FdLDKHtGD3fh0wD9JwzAjSDs3qrPKIyTML5JydtFspR5LaxXm+cF2xrxdRjQTaiOH4N3r3ZGm01Vgs0epQ25dpGPHXjJuHGZla721MTq5mu9V4UAtPdWE+Vj/GccafWuYsXlmXsi8EzcmdeUDFnfwlqFO0A3EzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083125; c=relaxed/simple;
	bh=1JLVOeG+T1ele47nAYsMj1m+TdlREm1qkH259oH7ICA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/7zMV7Ji6GxXV6xxBx4SwZYkUI/QRpe2sEXBG4eoJoaMW6mu0h4wq+qgloYUgTp3i2RZuVfTW5tlrWCjsL8mksrd2TX+KiftgfbLTVC3FySoKCj+vJ203rhPh4bHRVBqfuupIafxU389Ee79yZqfF47sbiNCoulYYO+OAuzFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=pww/xPVw; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VYcHg1Rhbz9t20;
	Tue,  7 May 2024 13:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1715083119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1JLVOeG+T1ele47nAYsMj1m+TdlREm1qkH259oH7ICA=;
	b=pww/xPVwzAxKY9c+J6AjFCTmE1QyYGSxoX3yWPBl9TzdYgW3yAWivr9neoQpGqjdgdSktC
	tGOUZdOlran81AEROkYnm+0HXcIi02eEit1thF1eBBQEjNf5+aP9cvldlD3UeNFGOwkjoq
	WR9CypPZy+0c0+q4wAvysE+Rtyuh32NYsnFv/TyW24tokAtHMLE8Nxt287rmgzUlKv4Dig
	x8uX7c0MWkWd6KJ9g8wZOK8GL+LAMAWziJqxzIP7pZSFQwF3ltkwHYEi8ZJm1r1fpv/+s+
	3a7hZ5EwApGMvcVfBB/ZrIzwtNppqHGCzMAtGKcwvL80z+KjTQD2XZm+Fh5m5g==
Date: Tue, 7 May 2024 21:58:20 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: stsp <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
Message-ID: <20240507.110127-muggy.duff.trained.hobby-u9ZNUZ9CW5k@cyphar.com>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
 <20240506.071502-teak.lily.alpine.girls-aiKJgErDohK@cyphar.com>
 <5b5cc31f-a5be-4f64-a97b-7708466ace82@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paylazfw3lu3brm2"
Content-Disposition: inline
In-Reply-To: <5b5cc31f-a5be-4f64-a97b-7708466ace82@yandex.ru>


--paylazfw3lu3brm2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-07, stsp <stsp2@yandex.ru> wrote:
> 07.05.2024 10:50, Aleksa Sarai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > If you are a privileged process which plans to change users,
>=20
> Not privileged at all. But I think what you say is still possible with
> userns?

It is possible to configure MOUNT_ATTR_IDMAP in a user namespace but
there are some restrictions that I suspect will make this complicated.
If you try to do something with a regular filesystem you'll probably run
into issues because you won't have CAP_SYS_ADMIN in the super block's
userns. But you could probably do it with tmpfs.

> > A new attack I just thought of while writing this mail is that because
> > there is no RESOLVE_NO_XDEV requirement, it should be possible for the
> > process to get an arbitrary write primitive by creating a new
> > userns+mountns and then bind-mounting / underneath the directory.
> Doesn't this need a write perm to a
> directory? In his case this is not a threat,
> because you are not supposed to have a
> write perm to that dir. OA2_CRED_INHERIT
> is the only way to write.

No, bind-mounts don't require write permission. As long as you can
resolve the target path you can bind-mount on top of it, so if there's a
subdirectory you can bind-mount / underneath (and if there is only a
file you can bind-mount any file you want to access/overwrite instead).

There are restrictions on mounting through /proc/self/fd/... but they
don't apply here (all files opened by a process doing setns/unshare have
their vfsmounts updated to be from the new mount namespace, meaning you
can do mounts through them with /proc/self/fd/... without issue.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--paylazfw3lu3brm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZjoXXAAKCRAol/rSt+lE
bwBpAQDJLvNL6vyCxjxPYD9pP16jEV0rj3t7mnaAuDs1gq4CYwEAgA8SmbRKKmKq
NYHAIR8GuMIKwyGzCC1o6VMeQ5reHgc=
=o7No
-----END PGP SIGNATURE-----

--paylazfw3lu3brm2--

