Return-Path: <linux-fsdevel+bounces-39582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF47A15D17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54F7166162
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800A318FC7B;
	Sat, 18 Jan 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="g+/ltgPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23113A95C;
	Sat, 18 Jan 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205395; cv=none; b=hHIUTJEzplPHBDn4E9c9nRzInjvkJ3IDNNONQ80Db1t+t4H7Ya8CqtnNzQW1KthfkXX4/9Ha9WFnEPaa1p5Z3bbBNSYUFotM23KSwmcUZbz+6kgjEEppvzn1iax6Wr21ieyRcA/pEQ65gmsMEJ4KaziQO1eVZYFq721ywOeOC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205395; c=relaxed/simple;
	bh=bk5+IY+MFyT26OgGMhQokVXki5wHxvFtxMyZoYGoUAc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5fAkgKDlssWogDYIAUZOx12WIE+MkeESqNSCajUWeMfRQ5zdx+m0kawJqgFqg/5dBGj67damU+ITpId8uoz/NWoEf4eg1IMOwdE6El1B9YUO0Ky5Fji7rI90GlpFXX9PsaBrCHoK9Qnto4xUEr8wML+Ad7M4u9Y4vOSLNvXY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=g+/ltgPL; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1737205381;
	bh=IiXluqJc7X9wx8W9hZ+AuKkT6+QyneEy0IjgPMhf5/c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=g+/ltgPLZKIJFZFuok3s6zcdi7cJGTes8nPDDz7dxUDPO2U8zee/c5cwrgO60GJ4o
	 ZHlSePK2qwz6QrFWh6P67cSJ+9QC4xKkEoUVpccPaTcJTc2y/zhEdTY4HhNOjoStei
	 m517Y+cZNhZcm+jiVonJCRkviIHs1pBh6dmvrBHw=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 53C9A1A41DC;
	Sat, 18 Jan 2025 08:02:57 -0500 (EST)
Message-ID: <82ee186ae5580548fe6b0edd2720359c18f6fa9a.camel@xry111.site>
Subject: Re: [PATCH RFC v3 02/10] sched_getattr: port to copy_struct_to_user
From: Xi Ruoyao <xry111@xry111.site>
To: Christian Brauner <brauner@kernel.org>, Florian Weimer
 <fweimer@redhat.com>,  Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar
 <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Alexander Viro
	 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Arnd Bergmann
 <arnd@arndb.de>,  Shuah Khan <shuah@kernel.org>, Kees Cook
 <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, libc-alpha@sourceware.org
Date: Sat, 18 Jan 2025 21:02:54 +0800
In-Reply-To: <20241211-gemsen-zuarbeiten-ae8d062ec251@brauner>
References: 
	<20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
	 <20241010-extensible-structs-check_fields-v3-2-d2833dfe6edd@cyphar.com>
	 <87y10nz9qo.fsf@oldenburg.str.redhat.com>
	 <20241211-gemsen-zuarbeiten-ae8d062ec251@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 11:23 +0100, Christian Brauner wrote:
> On Tue, Dec 10, 2024 at 07:14:07PM +0100, Florian Weimer wrote:
> > * Aleksa Sarai:
> >=20
> > > sched_getattr(2) doesn't care about trailing non-zero bytes in the
> > > (ksize > usize) case, so just use copy_struct_to_user() without check=
ing
> > > ignored_trailing.
> >=20
> > I think this is what causes glibc's misc/tst-sched_setattr test to fail
> > on recent kernels.=C2=A0 The previous non-modifying behavior was docume=
nted
> > in the manual page:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If the caller-provided attr buffer=
 is larger than the kernel's
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_attr structure, the addition=
al bytes in the user-space
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 structure are not touched.
> >=20
> > I can just drop this part of the test if the kernel deems both behavior=
s
> > valid.

> I think in general both behaviors are valid but I would consider zeroing
> the unknown parts of the provided buffer to be the safer option. And all
> newer extensible struct system calls do that.

Florian,

So should we drop the test before Glibc-2.41 release?  I'm seeing the
failure during my machine test.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

