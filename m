Return-Path: <linux-fsdevel+bounces-12889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB98683C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614F41F24B03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E47A134752;
	Mon, 26 Feb 2024 22:33:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C61DDD7;
	Mon, 26 Feb 2024 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986814; cv=none; b=pFy292831mnBljUmzDXnYle3fEHugdXHDRUhnwekAGQXecseW/hEaLoiSss8wlW2Rw7Y7i2xYi+z8RrdEpO+jMFFil0l2GTR3DCn3fH6sYUf/daJUMF+W71V6M8Ptfxsc24pJyf7/doZsFGnPDEJy013Y14wf8Jknr29GSLqQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986814; c=relaxed/simple;
	bh=XzkLglHncfPugzyDyH7vIDjIn0LxhOMGEOoaYlwJ2m8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=nyxKze1Kn0R9dYh8JEmaQf03zAlX8y4ug1BSd7VXpN6Gn6fXyk39/OmN5v5uoTRE5XF3MgIoxW2B/k4tnV6PPEsJo0kweSSa8tcNNmGTBU0Mv8xVlaTe/cC9nfg0s0lse+U6P+QWJPu7e4RQ2/K9XRCpDGxeeFVJkZIcqLWjNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 5514B3780016;
	Mon, 26 Feb 2024 22:33:29 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202402261123.B2A1D0DE@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook>
Date: Mon, 26 Feb 2024 22:33:29 +0000
Cc: jannh@google.com, "Doug Anderson" <dianders@chromium.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, "Guenter Roeck" <groeck@chromium.org>, "Mike Frysinger" <vapier@chromium.org>, linux-hardening@vger.kernel.org
To: "Kees Cook" <keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1405e4-65dd1180-3-7a785380@32026879>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?proc=3A?= allow restricting 
 /proc/pid/mem writes
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

Hello

On Monday, February 26, 2024 21:24 EET, Kees Cook <keescook@chromium.or=
g> wrote:

> [sorry for the duplicate, fixing Jann's email address]
>=20
> On Mon, Feb 26, 2024 at 09:10:54AM -0800, Doug Anderson wrote:
> > Hi,
> >=20
> > On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@=
collabora.com> wrote:
> > >
> > > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > > writing to /proc/pid/mem"). Famous last words from that patch:
> > > "no longer a security hazard". :)
> > >
> > > Afterwards exploits appeared started causing drama like [1]. The
> > > /proc/*/mem exploits can be rather sophisticated like [2] which
> > > installed an arbitrary payload from noexec storage into a running
> > > process then exec'd it, which itself could include an ELF loader
> > > to run arbitrary code off noexec storage.
> > >
> > > As part of hardening against these types of attacks, distrbutions
> > > can restrict /proc/*/mem to only allow writes when they makes sen=
se,
> > > like in case of debuggers which have ptrace permissions, as they
> > > are able to access memory anyway via PTRACE=5FPOKEDATA and friend=
s.
> > >
> > > Dropping the mode bits disables write access for non-root users.
> > > Trying to `chmod` the paths back fails as the kernel rejects it.
> > >
> > > For users with CAP=5FDAC=5FOVERRIDE (usually just root) we have t=
o
> > > disable the mem=5Fwrite callback to avoid bypassing the mode bits=
.
> > >
> > > Writes can be used to bypass permissions on memory maps, even if =
a
> > > memory region is mapped r-x (as is a program's executable pages),
> > > the process can open its own /proc/self/mem file and write to the
> > > pages directly.
> > >
> > > Even if seccomp filters block mmap/mprotect calls with W|X perms,
> > > they often cannot block open calls as daemons want to read/write
> > > their own runtime state and seccomp filters cannot check file pat=
hs.
> > > Write calls also can't be blocked in general via seccomp.
> > >
> > > Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > > can't run chmod once at boot to restrict it (and trying to react
> > > to every process and run chmod doesn't scale, and the kernel no
> > > longer allows chmod on any of these paths).
> > >
> > > SELinux could be used with a rule to cover all /proc/*/mem files,
> > > but even then having multiple ways to deny an attack is useful in
> > > case on layer fails.
> > >
> > > [1] https://lwn.net/Articles/476947/
> > > [2] https://issues.chromium.org/issues/40089045
> > >
> > > Based on an initial patch by Mike Frysinger <vapier@chromium.org>=
.
> > >
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Signed-off-by: Mike Frysinger <vapier@chromium.org>
>=20
> This should have a "Co-developed-by: Mike..." tag, since you're makin=
g
> changes and not just passing it along directly.

Thanks, I'll address this in v2.

>=20
> > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > > ---
> > > Tested on next-20240220.
> > >
> > > I would really like to avoid depending on CONFIG=5FMEMCG which is
> > > required for the struct mm=5Fstryct "owner" pointer.
> > >
> > > Any suggestions how check the ptrace owner without MEMCG?
> > > ---
> > >  fs/proc/base.c   | 26 ++++++++++++++++++++++++--
> > >  security/Kconfig | 13 +++++++++++++
> > >  2 files changed, 37 insertions(+), 2 deletions(-)
> >=20
> > Thanks for posting this! This looks reasonable to me, but I'm nowhe=
re
> > near an expert on this so I won't add a Reviewed-by tag.
> >=20
> > This feels like the kind of thing that Kees might be interested in
> > reviewing, so adding him to the "To" list.
>=20
> I'd love to make /proc/$pid/mem more strict. A few comments:
>=20
> > [...]
> > +	if (ptracer=5Fcapable(current, mm->user=5Fns) &&
>=20
> It really looks like you're trying to do a form of ptrace=5Fmay=5Facc=
ess(),
> but =5Fwithout=5F the introspection exception?
>=20
> Also, using "current" in the write path can lead to problems[1], so t=
his
> should somehow use file->f=5Fcred, or limit write access during the o=
pen()
> instead?

I think Mike explained pretty well why we need to check if current alre=
ady
is a ptracer. The point you raise is valid (thanks again) so we need to=
 check
a bit earlier, during open().

>=20
> > [...]
> > +config SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITES
>=20
> Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
> sysctl, but that's be harder given the perms). That this is selectabl=
e
> by distro users, etc, and they don't need to rebuild their kernel to
> benefit from it.

Ack, I'll implement a cmdline arg in v2.

>=20
> Jann Horn has tried to restrict access to this file in the past as we=
ll,
> so he may have some additional advice about it.

I'll leave this a few more days in case others have more ideas, then wi=
ll
send v2 and also add Jann to the "To:" list.

>=20
> -Kees
>=20
> [1] https://docs.kernel.org/security/credentials.html#open-file-crede=
ntials
>=20
> --=20
> Kees Cook


