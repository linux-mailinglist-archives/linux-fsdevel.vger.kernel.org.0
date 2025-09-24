Return-Path: <linux-fsdevel+bounces-62545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE404B986AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 08:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139383ABBB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566F24A049;
	Wed, 24 Sep 2025 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="RVBAXic5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31C22ACEB;
	Wed, 24 Sep 2025 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696093; cv=none; b=dmeW2iRINxlX5c4AAHrPMpt5lP8JJQCXiXTjLHMbkTdrf/Zk8+bJUuEYd5+qqnaJha4arTM3qMAJF/DEhkKXynm15cJJbIPA2I6tUWNsfsXb48hdumnYMnCpgWLH8xYB3ZlOgIFbNuV5BrSoEOiJ1udUYU8paT0GnTuv5JF5cnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696093; c=relaxed/simple;
	bh=yGkTY8uoRqT7zpMJS5a7NKh20LU+wAcIr4LJghOIirE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfndgwMYybDkPgpvrXRGnQ9ra2aJhT4OmDpvTbmeCXxEAvajYowsVcGVfa7eZkWCZeYH/Xv6SzxI8vk+bexP2rojhXs9/5MZKnj0wczihfE0uZoA0KDn9wIEceaDBb4QoX+V7QANUQ+E+M8E5oKpZMUwG5UeNCRvtPaOaJTfXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=RVBAXic5; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cWnLb6pnDz9sjG;
	Wed, 24 Sep 2025 08:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758696088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yGkTY8uoRqT7zpMJS5a7NKh20LU+wAcIr4LJghOIirE=;
	b=RVBAXic52XARAhRefV+3Cml+wjPazu4ZWET1R5BVXmbNd0g031KQdZuntHS0j74EZQb73q
	pPrTf1/YZ1D+U/7m2GvCRKZDmybgOjzHqwcBdStK1uznVZZKSMZLpnjLAt88BHLpM8tBGH
	Oazb6BJbxPitOZlil7Jm9oXrm5TL/GgU3oJWcpZ81Hj8sUGsz/sUisSxSfx97+5WnfsvHG
	qjc5fUrsb3Xad4EmghyJ0GcIOSr/vJOvX03cqPIi/YevVGMP/PO98qUNPp3zMJr4uGlXQ+
	8dAon+0q9C9lCyp3planqwHArbL904bk7chQOTrgIHXK3XiX9FIWTXF7LLZcRA==
Date: Wed, 24 Sep 2025 16:41:16 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 04/10] man/man2/fsconfig.2: document "new" mount API
Message-ID: <2025-09-24-sterile-elderly-drone-sum-LHA7Fs@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-4-1261201ab562@cyphar.com>
 <e4jtqbymqguq64zup5qr6rnppwjyveqdzvqdbnz3c7v55zplbs@6bpdfbv6sh7d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvtemruvm5nlo26n"
Content-Disposition: inline
In-Reply-To: <e4jtqbymqguq64zup5qr6rnppwjyveqdzvqdbnz3c7v55zplbs@6bpdfbv6sh7d>


--cvtemruvm5nlo26n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 04/10] man/man2/fsconfig.2: document "new" mount API
MIME-Version: 1.0

On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> On Fri, Sep 19, 2025 at 11:59:45AM +1000, Aleksa Sarai wrote:
> > +The list of valid
> > +.I cmd
> > +values are:
>=20
> I think I would have this page split into one page per command.
>=20
> I would keep an overview in this page, of the main system call, and the
> descriptions of each subcommand would go into each separate page.
>=20
> You could have a look at fcntl(2), which has been the most recent page
> split, and let me know what you think.

To be honest, I think this makes the page less useful to most readers.

I get that you want to try to improve the "wall of text" problem but as
a very regular reader of man-pages, I find indirections annoying every
time I have to do deal with them. Maybe there is an argument for
fcntl(2) to undergo this treatment (as it has a menagerie of disparate
commands) but this applies even less to fsconfig(2) in my view.

If you feel strongly that fsconfig(2) needs this treatment, it would
probably be better for you to do it instead. In particular, I would've
expected to only have two extra pages if we went that route (one for
FSCONFIG_SET_* commands and one for FSCONFIG_CMD_* commands) so I'm not
quite sure what you'd like the copy to look like for 10 man-pages...

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--cvtemruvm5nlo26n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNOSjBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/5TAEA/ubRFDGuG4Sm301RkUoS
zSgu+sNStxtRmAOX/HWHYkQBAI035sIw3M4G/al0osOvw8NAGHjuJw64VEVmC5R7
+IIM
=p2GY
-----END PGP SIGNATURE-----

--cvtemruvm5nlo26n--

