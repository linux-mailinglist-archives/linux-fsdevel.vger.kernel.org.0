Return-Path: <linux-fsdevel+bounces-39657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCF1A1692B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 10:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334381643A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3161AE863;
	Mon, 20 Jan 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Pd3CvVot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B619D8BC;
	Mon, 20 Jan 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737364888; cv=none; b=lddkh+Aee+KbbGoqxvlcCslprlrE4heOHjQQYSfbw3zpAvsZJ5FM9+J8SHdubTuvzPQo7+7A/Wy++cU7UuQO8LyKNTSSczTzuT4Bn+t9PR+IBWeCYJCd1oSHtkHg3cUMTS9s1RiTVC381z6LTPBqH2iOmyhEAwwFwMpP4juLzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737364888; c=relaxed/simple;
	bh=XYJLdAWVBtsQKxdvGPaVK24yz2JTZ6Lmt7SMEZeykoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DSGLP83hf9ng/WnAAu2V3yPGHr8d4J8SIPIMwA47O49eF0kiF5e+hZwD2TYRt6yQXnWLKpaXJ5AYqbl/wcKFpOJmc9qT0nQd9IiBlyHVzaKawmzyKYuY97ClZhZ2wA3cbiPNHWnlMdihYU5ByzVk6spReKTmPgDD7RTlpRrTqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Pd3CvVot; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1737364875;
	bh=C2GshIBvBAURLHFGRQF/C6H94DvfHjSPrFbhN9PBMlI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pd3CvVotiZE1Qs54jvgNYEb6ofM1CvA28bqkHJAaO8M+y55pbVVlXfx/w/zXG+rUc
	 dOteMEW2yKJLUERcJa6sFI11EZRhAnv/Ld9dIczRMmN72itO2bkO+NgpmSm+RqSShB
	 qdDmZtKWob/GpOdVJe2AUGJD+CXO/l06SMqz6dwU=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7DB5C66999;
	Mon, 20 Jan 2025 04:21:10 -0500 (EST)
Message-ID: <b66580447aa94593136186a4046fd350e598943a.camel@xry111.site>
Subject: Re: [PATCH RFC v3 02/10] sched_getattr: port to copy_struct_to_user
From: Xi Ruoyao <xry111@xry111.site>
To: Florian Weimer <fweimer@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot	 <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>,  Arnd Bergmann	 <arnd@arndb.de>, Shuah Khan
 <shuah@kernel.org>, Kees Cook <kees@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 libc-alpha@sourceware.org
Date: Mon, 20 Jan 2025 17:21:08 +0800
In-Reply-To: <87jzaqdpfe.fsf@oldenburg.str.redhat.com>
References: 
	<20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
		<20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
		<87y10nz9qo.fsf@oldenburg.str.redhat.com>
		<20241211-gemsen-zuarbeiten-ae8d062ec251@brauner>
		<82ee186ae5580548fe6b0edd2720359c18f6fa9a.camel@xry111.site>
	 <87jzaqdpfe.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-20 at 06:28 +0100, Florian Weimer wrote:
> * Xi Ruoyao:
>=20
> > On Wed, 2024-12-11 at 11:23 +0100, Christian Brauner wrote:
> > > On Tue, Dec 10, 2024 at 07:14:07PM +0100, Florian Weimer wrote:
> > > > * Aleksa Sarai:
> > > >=20
> > > > > sched_getattr(2) doesn't care about trailing non-zero bytes in th=
e
> > > > > (ksize > usize) case, so just use copy_struct_to_user() without c=
hecking
> > > > > ignored_trailing.
> > > >=20
> > > > I think this is what causes glibc's misc/tst-sched_setattr test to =
fail
> > > > on recent kernels.=C2=A0 The previous non-modifying behavior was do=
cumented
> > > > in the manual page:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If the caller-provided attr bu=
ffer is larger than the kernel's
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_attr structure, the addi=
tional bytes in the user-space
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 structure are not touched.
> > > >=20
> > > > I can just drop this part of the test if the kernel deems both beha=
viors
> > > > valid.
> >=20
> > > I think in general both behaviors are valid but I would consider zero=
ing
> > > the unknown parts of the provided buffer to be the safer option. And =
all
> > > newer extensible struct system calls do that.
> >=20
> > Florian,
> >=20
> > So should we drop the test before Glibc-2.41 release?=C2=A0 I'm seeing =
the
> > failure during my machine test.
> I was waiting for a verdict from the kernel developers.=C2=A0 I didn't ex=
pect
> such a change to happen given the alleged UAPI policy.

But 6.13 is already released without reverting the behavior change
now...  So is this the "final" verdict?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

