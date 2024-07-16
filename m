Return-Path: <linux-fsdevel+bounces-23776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A52932E25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173A61C2039C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236C19E83D;
	Tue, 16 Jul 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="w5Ti5JRE";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="w5Ti5JRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A81DDCE;
	Tue, 16 Jul 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146381; cv=none; b=KZCahLkHdbbKyotQin7P0fL3nFsl4bWJ8FKgiY1kEs7vvIlnkdBAI572TmxH664fxfIKz3EDc9Mmu9rzUkdweDjUKGJ3OE1STSEbBOxYMzu9Y/g9uScNKxPXj68y28PtAmdNjX6oWv2D4jbNE+PG8a0GYxoUfTwJDfAUrgYMsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146381; c=relaxed/simple;
	bh=uVjkJ49b/yBaPoybzQj8BJWIAtzJ2A0MyWEfn24MNKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=udpD7sro4wP/reXdr0qVgC8QLo7xAXSMDULjbIxhqGYUSjp36dRjBN+1hgnOizF+2TwE8h9KiyYdNN52++SQHX2g3urXnfKPFMBgXkyFJiayrGuEl/6K4rhoUP2TIiOiDIW6owFNa8iLWZBbkIMLTZWEHCTsl9ExMEW7vIZI+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=w5Ti5JRE; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=w5Ti5JRE; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721146374;
	bh=uVjkJ49b/yBaPoybzQj8BJWIAtzJ2A0MyWEfn24MNKA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=w5Ti5JRE//Vx3a3OuzV8wkqcdM9o25BnWOnkKOIPpVYAihmxEB6ByOff1/m10QOAj
	 py6wkR3M3X1tu+AvcVcI5EL3dTrPfor6U3VAEPlCcFsgi7fevJCeZzukaGyok6HDG+
	 6u+uHdCeyHj5/D5TVEJ6WZRd2Ek87OwEv4EI0nis=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CBD8012866B5;
	Tue, 16 Jul 2024 12:12:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id seKY2ty1dPDA; Tue, 16 Jul 2024 12:12:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721146374;
	bh=uVjkJ49b/yBaPoybzQj8BJWIAtzJ2A0MyWEfn24MNKA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=w5Ti5JRE//Vx3a3OuzV8wkqcdM9o25BnWOnkKOIPpVYAihmxEB6ByOff1/m10QOAj
	 py6wkR3M3X1tu+AvcVcI5EL3dTrPfor6U3VAEPlCcFsgi7fevJCeZzukaGyok6HDG+
	 6u+uHdCeyHj5/D5TVEJ6WZRd2Ek87OwEv4EI0nis=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 90B851286670;
	Tue, 16 Jul 2024 12:12:50 -0400 (EDT)
Message-ID: <ee1ae815b6e75021709612181a6a4415fda543a4.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	=?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
	 <mic@digikod.net>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>,  Kees Cook <keescook@chromium.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore
 Ts'o <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai
 <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Casey
 Schaufler <casey@schaufler-ca.com>, Christian Heimes
 <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, Eric Biggers
 <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, Fan Wu
 <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, James Morris
 <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>,  Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi
 <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew
 Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Nicolas
 Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,  Scott Shell
 <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>,  Steve Dower <steve.dower@python.org>, Steve Grubb
 <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
 Vincent Strubel <vincent.strubel@ssi.gouv.fr>,  Xiaoming Ni
 <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
 kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Tue, 16 Jul 2024 12:12:49 -0400
In-Reply-To: <9e3df65c2bf060b5833558e9f8d82dcd2fe9325a.camel@huaweicloud.com>
References: <20240704190137.696169-1-mic@digikod.net>
	 <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
	 <20240709.AhJ7oTh1biej@digikod.net>
	 <9e3df65c2bf060b5833558e9f8d82dcd2fe9325a.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-16 at 17:57 +0200, Roberto Sassu wrote:
> But the Clip OS 4 patch does not cover the redirection case:
> 
> # ./bash < /root/test.sh
> Hello World
> 
> Do you have a more recent patch for that?

How far down the rabbit hole do you want to go?  You can't forbid a
shell from executing commands from stdin because logging in then won't
work.  It may be possible to allow from a tty backed file and not from
a file backed one, but you still have the problem of the attacker
manually typing in the script.

The saving grace for this for shells is that they pretty much do
nothing on their own (unlike python) so you can still measure all the
executables they call out to, which provides reasonable safety.

James


