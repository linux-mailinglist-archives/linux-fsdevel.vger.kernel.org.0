Return-Path: <linux-fsdevel+bounces-21941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0330B90F887
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C49C1F22B1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2762015ADA8;
	Wed, 19 Jun 2024 21:31:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08914277;
	Wed, 19 Jun 2024 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832714; cv=none; b=f9ME3kFLehw7LjsJ8Xdds4dLO4OvKKmo7LZk1LioU3b1cPN/TTbwaBPwFFjGmBg5YFJBDJhJqXleXPnP0tqsaqsNxeiKuPsEIZpXMoNLKHDlw1kKjElJun0674GpyfvBz1zQzi8EdZFDFgUfyzfLFm1Y8un5hWMAxY/RFKppFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832714; c=relaxed/simple;
	bh=xNw6YyCAfigbFukmre3FSwB3waVjHWXIn4Bkmgrj2as=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=VGH8a22GkTzfK9ADxRxHBpLCMbOR9zXXLElAJ7BspOabY7sUhUs1QqqJpo4wpFDVnPp8XH2UKGunxCCu7hHPlcCnH40aJItp++JK5uV+IRuxNxWyNxXLZQGe5KlBLAyVENC1SJWDQ9bEWrg8SEh4XV2XC4Ml6vVWtaYk8Gs0rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 4BCA33782173;
	Wed, 19 Jun 2024 21:31:49 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202406191336.AC7F803123@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
 <20240613133937.2352724-2-adrian.ratiu@collabora.com>
 <CABi2SkXY20M24fcUgejAMuJpNZqsLxd0g1PZ-8RcvzxO6NO6cA@mail.gmail.com> <202406191336.AC7F803123@keescook>
Date: Wed, 19 Jun 2024 22:31:49 +0100
Cc: "Jeff Xu" <jeffxu@chromium.org>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Christian Brauner" <brauner@kernel.org>, "Jeff Xu" <jeffxu@google.com>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3304e0-66734e80-1857-33d83680@76729138>
Subject: =?utf-8?q?Re=3A?= [PATCH v6 2/2] =?utf-8?q?proc=3A?= restrict /proc/pid/mem
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, June 19, 2024 23:41 EEST, Kees Cook <kees@kernel.org> wro=
te:

> On Tue, Jun 18, 2024 at 03:39:44PM -0700, Jeff Xu wrote:
> > Hi
> >=20
> > Thanks for the patch !
> >=20
> > On Thu, Jun 13, 2024 at 6:40=E2=80=AFAM Adrian Ratiu <adrian.ratiu@=
collabora.com> wrote:
> > >
> > > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > > writing to /proc/pid/mem"). Famous last words from that patch:
> > > "no longer a security hazard". :)
> > >
> > > Afterwards exploits started causing drama like [1]. The exploits
> > > using /proc/*/mem can be rather sophisticated like [2] which
> > > installed an arbitrary payload from noexec storage into a running
> > > process then exec'd it, which itself could include an ELF loader
> > > to run arbitrary code off noexec storage.
> > >
> > > One of the well-known problems with /proc/*/mem writes is they
> > > ignore page permissions via FOLL=5FFORCE, as opposed to writes vi=
a
> > > process=5Fvm=5Fwritev which respect page permissions. These write=
s can
> > > also be used to bypass mode bits.
> > >
> > > To harden against these types of attacks, distrbutions might want
> > > to restrict /proc/pid/mem accesses, either entirely or partially,
> > > for eg. to restrict FOLL=5FFORCE usage.
> > >
> > > Known valid use-cases which still need these accesses are:
> > >
> > > * Debuggers which also have ptrace permissions, so they can acces=
s
> > > memory anyway via PTRACE=5FPOKEDATA & co. Some debuggers like GDB
> > > are designed to write /proc/pid/mem for basic functionality.
> > >
> > > * Container supervisors using the seccomp notifier to intercept
> > > syscalls and rewrite memory of calling processes by passing
> > > around /proc/pid/mem file descriptors.
> > >
> > > There might be more, that's why these params default to disabled.
> > >
> > > Regarding other mechanisms which can block these accesses:
> > >
> > > * seccomp filters can be used to block mmap/mprotect calls with W=
|X
> > > perms, but they often can't block open calls as daemons want to
> > > read/write their runtime state and seccomp filters cannot check
> > > file paths, so plain write calls can't be easily blocked.
> > >
> > > * Since the mem file is part of the dynamic /proc/<pid>/ space, w=
e
> > > can't run chmod once at boot to restrict it (and trying to react
> > > to every process and run chmod doesn't scale, and the kernel no
> > > longer allows chmod on any of these paths).
> > >
> > > * SELinux could be used with a rule to cover all /proc/*/mem file=
s,
> > > but even then having multiple ways to deny an attack is useful in
> > > case one layer fails.
> > >
> > > Thus we introduce four kernel parameters to restrict /proc/*/mem
> > > access: open-read, open-write, write and foll=5Fforce. All these =
can
> > > be independently set to the following values:
> > >
> > > all     =3D> restrict all access unconditionally.
> > > ptracer =3D> restrict all access except for ptracer processes.
> > >
> > > If left unset, the existing behaviour is preserved, i.e. access
> > > is governed by basic file permissions.
> > >
> > > Examples which can be passed by bootloaders:
> > >
> > > proc=5Fmem.restrict=5Ffoll=5Fforce=3Dall
> > > proc=5Fmem.restrict=5Fopen=5Fwrite=3Dptracer
> > > proc=5Fmem.restrict=5Fopen=5Fread=3Dptracer
> > > proc=5Fmem.restrict=5Fwrite=3Dall
> > >
> > > These knobs can also be enabled via Kconfig like for eg:
> > >
> > > CONFIG=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FPTRACE=5FDEFAULT=3Dy
> > > CONFIG=5FPROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FPTRACE=5FDEFAULT=3D=
y
> > >
> > > Each distribution needs to decide what restrictions to apply,
> > > depending on its use-cases. Embedded systems might want to do
> > > more, while general-purpouse distros might want a more relaxed
> > > policy, because for e.g. foll=5Fforce=3Dall and write=3Dall both =
break
> > > break GDB, so it might be a bit excessive.
> > >
> > > Based on an initial patch by Mike Frysinger <vapier@chromium.org>=
.
> > >
> > It is noteworthy that ChromeOS has benefited from blocking
> > /proc/pid/mem write since 2017 [1], owing to the patch implemented =
by
> > Mike Frysinger.
> >=20
> > It is great that upstream can consider this patch, ChromeOS will us=
e
> > the solution once it is accepted.
> >=20
> > > Link: https://lwn.net/Articles/476947/ [1]
> > > Link: https://issues.chromium.org/issues/40089045 [2]
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jeff Xu <jeffxu@google.com>
> > > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> >=20
> > Reviewed-by: Jeff Xu <jeffxu@chromium.org>
> > Tested-by: Jeff Xu <jeffxu@chromium.org>
> > [1] https://chromium-review.googlesource.com/c/chromiumos/third=5Fp=
arty/kernel/+/764773
>=20
> Thanks for the testing! What settings did you use? I think Chrome OS =
was
> effectively doing this?
>=20
> PROC=5FMEM=5FRESTRICT=5FOPEN=5FREAD=5FOFF=3Dy
> CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5FWRITE=5FALL=3Dy
> CONFIG=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FALL=3Dy
> CONFIG=5FPROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FALL=3Dy

Correct except for CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5FWRITE=5FALL=3D=
y
which will make ChromeOS boot loop because upstart/systemd-tmpfiles
will fail and trigger a recovery + reboot, then the kernel will again b=
lock
opening the file and so on. :)

ChromeOS effectively only blocks all writes which also blocks all foll=5F=
force.

>=20
> Though I don't see the FOLL=5FFORCE changes in the linked Chrome OS p=
atch,
> but I suspect it's unreachable with
> CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5FWRITE=5FALL=3Dy.
=20
That is correct, CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5FWRITE=5FALL=3D=
y also
blocks FOLL=5FFORCE.

The idea there is to restrict writes entirely in production images via
Kconfig and then relax the restriction in dev/test images via boot para=
ms
proc=5Fmem.restrict=5Fwrite=3Dptracer proc=5Fmem.restrict=5Ffoll=5Fforc=
e=3Dptracer

See this CL:
https://chromium-review.googlesource.com/c/chromiumos/platform/vboot=5F=
reference/+/5631026


