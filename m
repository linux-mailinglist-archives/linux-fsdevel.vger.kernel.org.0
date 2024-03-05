Return-Path: <linux-fsdevel+bounces-13634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C28722F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335331C22F15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C70127B53;
	Tue,  5 Mar 2024 15:38:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7B1272B7;
	Tue,  5 Mar 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653114; cv=none; b=PBiVXoV3ooAzvIXipj11i9k7Cw9+fFzzqBr9UUGXxQDg9Ii6ccxKYTTUErNEgPX/L8hLe3u+f0BmJTScCP0FypeCOYuSGYECMaL6vlpLnyUvWhCfxcOilT8INl/hhby94sOd49Xfq5q9wZaVlXTJjX9B37gWEGgBi42URrLQ/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653114; c=relaxed/simple;
	bh=D5pJEtWFcbrQJzHq8eXEwOZZKupXoLaKjU5YgHvZuN0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=oZW1f8N6kgYdlKsMNbwBfBXAvHWbcE7qUEa99LhNYjwY/pAZ69dj/jjwFSyWUOcvsbEp08MqghuZqVy2KkXtmgOOWapJAHq4Ib1vDnEKm1u+XhTLRmpn4MIez5BL9cMfbsIn+MwQlBY7WxxFAHojOWEMsznvj+zK0egc2iCH+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 6863737813B5;
	Tue,  5 Mar 2024 15:38:30 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202403050134.784D787337@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner> <202403050134.784D787337@keescook>
Date: Tue, 05 Mar 2024 15:38:30 +0000
Cc: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <keescook@chromium.org>, vapier@chromium.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <44043-65e73c80-15-1c4f8760@112682428>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?proc=3A?= allow restricting 
 /proc/pid/mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, March 05, 2024 11:41 EET, Kees Cook <keescook@chromium.org>=
 wrote:

> On Tue, Mar 05, 2024 at 09:59:47AM +0100, Christian Brauner wrote:
> > > > Uhm, this will break the seccomp notifier, no? So you can't tur=
n on
> > > > SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE when you want to use t=
he seccomp
> > > > notifier to do system call interception and rewrite memory loca=
tions of
> > > > the calling task, no? Which is very much relied upon in various
> > > > container managers and possibly other security tools.
> > > >=20
> > > > Which means that you can't turn this on in any of the regular d=
istros.
> > >=20
> > > FWIW, it's a run-time toggle, but yes, let's make sure this works
> > > correctly.
> > >=20
> > > > So you need to either account for the calling task being a secc=
omp
> > > > supervisor for the task whose memory it is trying to access or =
you need
> > > > to provide a migration path by adding an api that let's caller'=
s perform
> > > > these writes through the seccomp notifier.
> > >=20
> > > How do seccomp supervisors that use USER=5FNOTIF do those kinds o=
f
> > > memory writes currently? I thought they were actually using ptrac=
e?
> > > Everything I'm familiar with is just using SECCOMP=5FIOCTL=5FNOTI=
F=5FADDFD,
> > > and not doing fancy memory pokes.
> >=20
> > For example, incus has a seccomp supervisor such that each containe=
r
> > gets it's own goroutine that is responsible for handling system cal=
l
> > interception.
> >=20
> > If a container is started the container runtime connects to an AF=5F=
UNIX
> > socket to register with the seccomp supervisor. It stays connected =
until
> > it stops. Everytime a system call is performed that is registered i=
n the
> > seccomp notifier filter the container runtime will send a AF=5FUNIX
> > message to the seccomp supervisor. This will include the following =
fds:
> >=20
> > - the pidfd of the task that performed the system call (we should
> >   actually replace this with SO=5FPEERPIDFD now that we have that)
> > - the fd of the task's memory to /proc/<pid>/mem
> >=20
> > The seccomp supervisor will then perform the system call intercepti=
on
> > including the required memory reads and writes.
>=20
> Okay, so the patch would very much break that. Some questions, though=
:
> - why not use process=5Fvm=5Fwritev()?
> - does the supervisor depend on FOLL=5FFORCE?
>=20
> Perhaps is is sufficient to block the use of FOLL=5FFORCE?
>=20
> I took a look at the Chrome OS exploit, and I =5Fthink=5F it is depen=
ding
> on the FOLL=5FFORCE behavior (it searches for a symbol to overwrite t=
hat
> if I'm following correctly is in a read-only region), but some of the
> binaries don't include source code, so I couldn't easily see what was
> being injected. Mike or Adrian can you confirm this?

I can't speak for what is acceptable for ChromeOS security because=20
I'm not part of that project, so I'll let Mike answer whether blocking
writes is mandatory for them or blocking FOLL=5FFORCE is enough.

From a design perspective, the question is whether to
1. block writes and allow known good exceptions=20
or
2. allow writes and block known bad/exploitable exceptions.=20
=20
I am looking into reproducing and adding an exception for the
container syscall intercept use-case raised by Christian, because
I think it's easier to justify allowing known good exceptions from
a security perspective.

Otherwise I'm fine with both approaches.

@Mike WDYT ?


