Return-Path: <linux-fsdevel+bounces-23767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DDF9329E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915B0B220DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA1119DF78;
	Tue, 16 Jul 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoPTLJPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040B19B3FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142200; cv=none; b=TasPo43ClAaUZ/ajB8AUfEBf08D8UZCxDUKGAtpk4ZsBqdK6q2xOYj3R66zggjUcWTGpzRhMFb0I2SRecRSkLlN08NUDTNn6QHLDGYScWrO2j5tYTAofx8NpaAzRZkSPrRTfDPqn9S+CDZQ2uxlod1cRTmW0Sh26bqq+RIqRBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142200; c=relaxed/simple;
	bh=DHR09VYVRkGUGP0l/vA4+20intCid7dDJWNip64G1sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpkYVdcBYQHDjfluMiywKkiKXKPrDpA3fzdcbkwTUcBo01dOtvIznORe8ZVvFf27CxdwZaWyxUUBxc3tF/bB4s+p3Vt87ewNit5KIrs1VzphXWL61wX55y/jn+AKR9XiW1JQ1WyChM7YsFOkT8w4poYNHkb5JNG+KmR1NqtKNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoPTLJPR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso20349a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721142197; x=1721746997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQXyGuZsqmv7+37GKhT1A2NCIQ7jfA+IZBk14phBRDQ=;
        b=QoPTLJPRSEAsmyiHvuKHvsgRIBssbG+D5pYuQ2mxtkILDMoKSOxa1Fmi0IHDUvobEo
         U5jmx3fQW3bBsTvofTB9b6A5CIrhfJBXcM/tkHbghRK6tTp5TJ8cEufZ1Pw8T6o99wSK
         /m40jaHhdrN2z41LJ6E4pmibGtqGDX+/Jlz3eaT6RR3aQ4MCRY2qEwM2TjTvlxlS2QRJ
         9VzncfEE2XCOZEj4V3UK73T91QHA29DQlyt3Wdi7m59s6pA2VSJl9RMZ2D2Gr40Ej1h6
         tr046IqfIm99zPMMn7TXNXgpTf0zQnHHTe6hNFhZyBgAzcBL/RQNg0Og1pihELrs7k5s
         bugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142197; x=1721746997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQXyGuZsqmv7+37GKhT1A2NCIQ7jfA+IZBk14phBRDQ=;
        b=A5kEDyOStT13I72gKVQK65GX6ntDI/WcVtCwuqdFOd0oQz7m8ksv8tC+VmM657N/ZX
         YGMbcPmrLRzwg1QY+5XOLtjhqhui0d3QG0u2xXozJoHsKaR+pi5IEA3n/qC3JfTg+V1n
         6djkTxOC6ERjYcIezWR3Hfp2XJrT39sKK4IJP3J/7ovX8awzeQDTIJpdsCbSG9XqCyhW
         QBWM9ik5BckImb79nM+sOpjyZZwClg+7z05JxUfylo1eo/xxMioVYdbXhzicwiYu0FEG
         FarhRHPsG19BFmHZ9HDQUJrX7w+Ofl2Lkn4d+jQKlUxlQ7pdIMdT6+5gNERDn1ZIOx0D
         zOig==
X-Forwarded-Encrypted: i=1; AJvYcCV8WLic394TjFEwx+Fkmb0MCyVB2E18ImR/YrFuCMYmMb7tNXDkJdEmJWx/1ANiPMCk+cavVRw9D/AEmVpEsr1KtAQkjyh1ePe3DkD4UQ==
X-Gm-Message-State: AOJu0YyjmttHXqmG1iR/3wzWwBOXgkeKaXd/4nd1EeICedQuab+IrUET
	+zYehk9/oyw2vimFe8Arh3KojmFOFJxy9+dLSwHB1I4GOvACr9cVtkvQlw/BJfcSighe8JkyCoq
	BIxehuN6DZs5U8Wv08KbAUQu+rq8IDtGzo9Mr
X-Google-Smtp-Source: AGHT+IGAbpbbKqsLUGXh464cytP863iXT7qQnuBJhBT38qhaCF0Grsul4hxlGXsYzxPX+jxvJ5qXz6HHJ6C646I/Z5I=
X-Received: by 2002:a05:6402:4304:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-59ec5417830mr368292a12.2.1721142196804; Tue, 16 Jul 2024
 08:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net> <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org> <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net> <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
 <20240710.eiKohpa4Phai@digikod.net> <202407100921.687BE1A6@keescook> <20240711.sequuGhee0th@digikod.net>
In-Reply-To: <20240711.sequuGhee0th@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 16 Jul 2024 08:02:37 -0700
Message-ID: <CALmYWFt7X0v8k1N9=aX6BuT2gCiC9SeWwPEBckvBk8GQtb0rqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, Steve Dower <steve.dower@python.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:57=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Wed, Jul 10, 2024 at 09:26:14AM -0700, Kees Cook wrote:
> > On Wed, Jul 10, 2024 at 11:58:25AM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > Here is another proposal:
> > >
> > > We can change a bit the semantic by making it the norm to always chec=
k
> > > file executability with AT_CHECK, and using the securebits to restric=
t
> > > file interpretation and/or command injection (e.g. user supplied shel=
l
> > > commands).  Non-executable checked files can be reported/logged at th=
e
> > > kernel level, with audit, configured by sysadmins.
> > >
> > > New securebits (feel free to propose better names):
> > >
> > > - SECBIT_EXEC_RESTRICT_FILE: requires AT_CHECK to pass.
> >
> > Would you want the enforcement of this bit done by userspace or the
> > kernel?
> >
> > IIUC, userspace would always perform AT_CHECK regardless of
> > SECBIT_EXEC_RESTRICT_FILE, and then which would happen?
> >
> > 1) userspace would ignore errors from AT_CHECK when
> >    SECBIT_EXEC_RESTRICT_FILE is unset
>
> Yes, that's the idea.
>
> >
> > or
> >
> > 2) kernel would allow all AT_CHECK when SECBIT_EXEC_RESTRICT_FILE is
> >    unset
> >
> > I suspect 1 is best and what you intend, given that
> > SECBIT_EXEC_DENY_INTERACTIVE can only be enforced by userspace.
>
> Indeed. We don't want AT_CHECK's behavior to change according to
> securebits.
>
One bit is good.

> >
> > > - SECBIT_EXEC_DENY_INTERACTIVE: deny any command injection via
> > >   command line arguments, environment variables, or configuration fil=
es.
> > >   This should be ignored by dynamic linkers.  We could also have an
> > >   allow-list of shells for which this bit is not set, managed by an
> > >   LSM's policy, if the native securebits scoping approach is not enou=
gh.
> > >
> > > Different modes for script interpreters:
> > >
> > > 1. RESTRICT_FILE=3D0 DENY_INTERACTIVE=3D0 (default)
> > >    Always interpret scripts, and allow arbitrary user commands.
> > >    =3D> No threat, everyone and everything is trusted, but we can get
> > >    ahead of potential issues with logs to prepare for a migration to =
a
> > >    restrictive mode.
> > >
> > > 2. RESTRICT_FILE=3D1 DENY_INTERACTIVE=3D0
> > >    Deny script interpretation if they are not executable, and allow
> > >    arbitrary user commands.
> > >    =3D> Threat: (potential) malicious scripts run by trusted (and not
> > >       fooled) users.  That could protect against unintended script
> > >       executions (e.g. sh /tmp/*.sh).
> > >    =3D=3D> Makes sense for (semi-restricted) user sessions.
> > >
> > > 3. RESTRICT_FILE=3D1 DENY_INTERACTIVE=3D1
> > >    Deny script interpretation if they are not executable, and also de=
ny
> > >    any arbitrary user commands.
> > >    =3D> Threat: malicious scripts run by untrusted users.
> > >    =3D=3D> Makes sense for system services executing scripts.
> > >
> > > 4. RESTRICT_FILE=3D0 DENY_INTERACTIVE=3D1
> > >    Always interpret scripts, but deny arbitrary user commands.
> > >    =3D> Goal: monitor/measure/assess script content (e.g. with IMA/EV=
M) in
> > >       a system where the access rights are not (yet) ready.  Arbitrar=
y
> > >       user commands would be much more difficult to monitor.
> > >    =3D=3D> First step of restricting system services that should not
> > >        directly pass arbitrary commands to shells.
> >
> > I like these bits!
>
> Good! Jeff, Steve, Florian, Matt, others, what do you think?

For below two cases: will they be restricted by one (or some) mode above ?

1> cat /tmp/a.sh | sh

2> sh -c "$(cat /tmp/a.sh)"

