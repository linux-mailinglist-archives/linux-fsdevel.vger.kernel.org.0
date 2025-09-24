Return-Path: <linux-fsdevel+bounces-62559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE1AB998D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A0E4A578E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13772E7BA7;
	Wed, 24 Sep 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="NBc3OUtS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1D2E6CBF;
	Wed, 24 Sep 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712294; cv=none; b=ki3GxWb5TePk0XCbW/Ip+zEoXKW1Od989W0I4lNvjSaYae6mDMPuFmb4OW4eV/KmWBuFAB+iQzMsUA96PDonwrbySox5xw4c+XEMtgiYUyj2v82jauji8jn/qQU3WyVo6jH3V/KaNJZgx0eCP9BQoQnQA7abrpmW7t/2ycLwFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712294; c=relaxed/simple;
	bh=I8jx9+Z0HjYNcAxzspRrl8uDMBIJGiwKSq3Hc99rbtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTGvK1G4KBqG0tN9bLoOEPG7uojezulgeoCdOaRBdggW+rb16SupCd3ENwtz6JqSU6n0VytNcuH4VtJZAEMZz3DmeenlXHm8ceh9Ih2K6Zk/O2+TCClNKiJHKIbADSfOTnxhsIRH1p3vtES+JttTc34+l7iTiirkA+JGLQ8vOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=NBc3OUtS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cWvL40nMXz9sss;
	Wed, 24 Sep 2025 13:11:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758712284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eaWyp7zLjG4L7gCVal+UDP6Kkng9cKICGymTr7A2Hw=;
	b=NBc3OUtSn3cXLksE1cQM2evp/cln0cQAGhk7mwTMw7u0vPzpd6ltC5yfOgxwyE0V6PfFvN
	0sQdEzdNIzo3aAo5L6e+e2mE0jD+9Ab0AYN5Ldnwb0DLINMl5x2UF9sgzzYxuVOUFh2rHl
	VNNF4w7brru4B2knSIagdia6F1fp+f+REJbe2HPJONJl+/j2FYx7PLilKXICQ+u+aRA/+R
	AxWXCeMV6MsqEu7bJdCvjdgu3HDr2jm7VBQPQlTYuYoYKwuzxk3lfmdVgf1LVWXnI0RvDH
	21Qp3t3011ewu/MFVK3Eb4Idg7Z3ixvvqqRwbsUuCLNzeiyf58muENPseheO4g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 24 Sep 2025 21:11:13 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: alx@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	g.branden.robinson@gmail.com, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	mtk.manpages@gmail.com, safinaskar@zohomail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 00/10] man2: document "new" mount API
Message-ID: <2025-09-24-grubby-secure-felon-sabotage-7t35lM@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250921024310.80511-1-safinaskar@gmail.com>
 <2025-09-21-eldest-expert-wrists-cuddle-CQWTLx@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2qa2nezhot5sjfdi"
Content-Disposition: inline
In-Reply-To: <2025-09-21-eldest-expert-wrists-cuddle-CQWTLx@cyphar.com>
X-Rspamd-Queue-Id: 4cWvL40nMXz9sss


--2qa2nezhot5sjfdi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/10] man2: document "new" mount API
MIME-Version: 1.0

On 2025-09-21, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-09-21, Askar Safin <safinaskar@gmail.com> wrote:
> > * open_tree(2) still says:
> > > If flags does not contain OPEN_TREE_CLONE, open_tree() returns a file=
 descriptor
> > > that is exactly equivalent to one produced by openat(2) when called w=
ith the same dirfd and path.
> >=20
> > This is not true if automounts are involved. I suggest adding "modulo a=
utomounts". But you may
> > keep everything, of course.
>=20
> Hmmm. As we discussed last time, this sentence is more intended to
> indicate that the file descriptor is just a regular open file (with no
> dissolve_on_fput() + FMODE_NEED_UNMOUNT magic) rather than the exact
> behaviour you get with regards to path lookup.
>=20
> I would honestly prefer to remove "when called with the same dirfd and
> path" rather than add caveats, but I think it makes the sentence less
> readable... I'll think about it and try to fix this wording up somehow
> for v5.

I've gone with the following:

   In either case, the resultant file descriptor
   acts the same as one produced by
   .BR open (2)
   with
   .BR O_PATH ,
   meaning it can also be used as a
   .I dirfd
   argument to
   "*at()" system calls.
  +However,
  +unlike
  +.BR open (2)
  +called with
  +.BR O_PATH ,
  +automounts will
  +by default
  +be triggered by
  +.BR open_tree ()
  +unless
  +.B \%AT_NO_AUTOMOUNT
  +is included in
  +.IR flags .

After looking at it a few times, I decided adding it to the proceeding
paragraph (as you suggested) didn't really make sense since the O_PATH
equivalence is only mentioned in this following paragraph.

Also, the automount behaviour also applies to OPEN_TREE_CLONE, so it's
best to not mislead a reader into thinking it only applies to one of the
cases.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--2qa2nezhot5sjfdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNPR0RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8ncAEA/+ks+fyeLSrpiOijgl1r
c8kiwHqZrEGphFbPVsqPMW8BAPaCYhMGgT7e/eyscqpAY0NoBUaH1xVw1U0nm9to
LnQA
=FVAb
-----END PGP SIGNATURE-----

--2qa2nezhot5sjfdi--

