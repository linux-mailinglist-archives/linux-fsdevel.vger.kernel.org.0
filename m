Return-Path: <linux-fsdevel+bounces-56843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1757B1C773
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32650565461
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900AD28DEE2;
	Wed,  6 Aug 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZJj1LhE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AF289357;
	Wed,  6 Aug 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489593; cv=none; b=kZWx1jiE642Wbpsm6Bc6NM5sPMR7E5R9gIKcB+X5224HpKqLZT56S4ViYCK1RkP0zTtMoBUz4tFcPLaEomJIWR56B8lKjQiCpXOZEXfe8lar0kkqNdKhYSGA6BX6j0FXyqEuAjtEXRnAxUMG68HRWc7qkv6b1Nnh17k6z6AxOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489593; c=relaxed/simple;
	bh=FlMpSLf2yOkuHS3jx0q7g7C74Flm3+kVPHDysv1Z34E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZblHLfC4MrkfDyu9V/M9QU6PdsVrJyn4Xp8Koqy4UoLvpyIKEl6NxOztl6BsTKGKQXTyOZPUdlzXZWkxY/YxrTfse/XxC7fNoW4aTFuUYEjZMsxQ71OsEBmvr9G0soPS7E3BSKniJ8VDdRr+yJ93hDqW+6guEVKzE8uSnWJtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZJj1LhE3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxshM0w2hz9sWC;
	Wed,  6 Aug 2025 16:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754489587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlMpSLf2yOkuHS3jx0q7g7C74Flm3+kVPHDysv1Z34E=;
	b=ZJj1LhE3XyHa5IXw8AMDjIl2cfdjHrJDmLX7MNh4WpURzMs6EDnk2iQO8/+Of3JbAM3FgA
	4vca7881HoPDoMk4RcbzIXRG5LhGn7Vfi+GphkO86B2R4ZniIb8CgtxM5RZmmjhRzwdo9F
	HwZvsWttmmXM0X2Z8yZVcbgSFqaAwTrUKHWXoLB2ugmmrkCUhF2q7kdDEs8CCV5TwonxA7
	2LuAtNFNZ09YhhLzhln/F9EU4G5JgcgWoZztRsxC5/HkRjZlS2yAxgMveHe4mbx09Wbmv5
	o+jJgikmBtHfN9u+2u84E5a6+74wAwm49j2Gh6AkmpDdredvm8p13pIV17u5PQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 7 Aug 2025 00:12:57 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, corbet@lwn.net, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, luto@amacapital.net, 
	shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
Message-ID: <2025-08-06.1754489257-elated-baubles-defiant-growls-beloved-jewelry-9Ofm2b@cyphar.com>
References: <2025-08-05.1754378656-steep-harps-muscled-mailroom-lively-gosling-VVGNTP@cyphar.com>
 <20250806102501.75104-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vg7hvx6zdovvdlvh"
Content-Disposition: inline
In-Reply-To: <20250806102501.75104-1-safinaskar@zohomail.com>
X-Rspamd-Queue-Id: 4bxshM0w2hz9sWC


--vg7hvx6zdovvdlvh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
MIME-Version: 1.0

On 2025-08-06, Askar Safin <safinaskar@zohomail.com> wrote:
> > I just realised that we probably also want to support FSCONFIG_SET_PATH
>=20
> I just checked kernel code. Indeed nobody uses FSCONFIG_SET_PATH.
> Moreover, fsparam_path macro is present since 5.1. And for all this
> time nobody used it. So, let's just remove FSCONFIG_SET_PATH. Nobody
> used it, so this will not break anything.
>=20
> If you okay with that, I can submit patch, removing it.

I would prefer you didn't -- "*at()" semantics are very useful to a lot
of programs (*especially* AT_EMPTY_PATH). I would like the pidns=3D stuff
to support it, and probably also overlayfs...

I suspect the primary issue is that when migrating to the new mount API,
filesystem devs just went with the easiest thing to use
(FSCONFIG_SET_STRING) even though FSCONFIG_SET_PATH would be better. I
suspect the lack of documentation around fsconfig(2) played a part too.

My impression is that interest in the minutia about fsconfig(2) is quite
low on the list of priorities for most filesystem devs, and so the neat
aspects of fsconfig(2) haven't been fully utilised. (In LPC last year,
we struggled to come to an agreement on how filesystems should use the
read(2)-based error interface.)

We can very easily move fsparam_string() or fsparam_file_or_string()
parameters to fsparam_path() and a future fsparam_file_or_path(). I
would much prefer that as a user.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--vg7hvx6zdovvdlvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJNi6QAKCRAol/rSt+lE
b3F9AQCE4SkPMlgg2PcJbT8RKOExtd1DlYHS3cpgw7AFtviNkQD/dwBRoLanCy4P
XTz8xL1cJlBrIEYb0j2KmePVf/mvUQ4=
=0c79
-----END PGP SIGNATURE-----

--vg7hvx6zdovvdlvh--

