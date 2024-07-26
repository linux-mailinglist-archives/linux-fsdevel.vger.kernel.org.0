Return-Path: <linux-fsdevel+bounces-24335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD293D6C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 18:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2476BB23156
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D817C7B1;
	Fri, 26 Jul 2024 16:15:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983314A8F;
	Fri, 26 Jul 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010530; cv=none; b=hCAu3l6PM1o2L4aTuSZthvlVYF/FKCWtiRgOTSDwOSZaLEwjrOV1k5cCb4eVnvr5rn+9Tqey7ekpal77rgM0ENOQRE09dgyxo1crpygVHlgXbbK8QGFZid1KdHBD9dEuf6phxGVkRCN0kfV+sxb5FhD5xCMGCTOXLt+gUlkOt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010530; c=relaxed/simple;
	bh=oiBSAVxN+28J9TUxzrNPVMGXKUjt5Et+zB978GWXo7c=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=TFnk3XMsJ37+lvR93lNtZSEAmRVv0ZrOm0Veo7koEI5D2t20aFxGajAdW6+p+19o33RJ+uafqqUM6h2GB/sQ9ab56+2Wxa7+68h9F+5pA5k+2WzYOJ7g9uyrOHoqMXm0wVSOa/QSSg/w0LClTfnn+tjlQVEx1OqoyhzFlhFGTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 21F863780C1F;
	Fri, 26 Jul 2024 16:15:26 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <CAMj1kXE-MLYdckRptBzaLM26nFqOB9K2xLuKdVAzdkHOS=FFCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240726090858.71541-1-adrian.ratiu@collabora.com> <CAMj1kXE-MLYdckRptBzaLM26nFqOB9K2xLuKdVAzdkHOS=FFCA@mail.gmail.com>
Date: Fri, 26 Jul 2024 17:15:25 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, inglorion@google.com, ajordanr@google.com, "Doug Anderson" <dianders@chromium.org>, "Jeff Xu" <jeffxu@google.com>, "Jann Horn" <jannh@google.com>, "Kees Cook" <kees@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
To: "Ard Biesheuvel" <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1502ec-66a3cb80-9-1954e7c0@250617140>
Subject: =?utf-8?q?Re=3A?= [PATCH v3] =?utf-8?q?proc=3A?= add config & param to 
 block forcing mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Friday, July 26, 2024 13:18 EEST, Ard Biesheuvel <ardb@kernel.org> w=
rote:

> On Fri, 26 Jul 2024 at 11:11, Adrian Ratiu <adrian.ratiu@collabora.co=
m> wrote:
> >
> > This adds a Kconfig option and boot param to allow removing
> > the FOLL=5FFORCE flag from /proc/pid/mem write calls because
> > it can be abused.
> >
> > The traditional forcing behavior is kept as default because
> > it can break GDB and some other use cases.
> >
> > Previously we tried a more sophisticated approach allowing
> > distributions to fine-tune /proc/pid/mem behavior, however
> > that got NAK-ed by Linus [1], who prefers this simpler
> > approach with semantics also easier to understand for users.
> >
> > Link: https://lore.kernel.org/lkml/CAHk-=3DwiGWLChxYmUA5HrT5aopZrB7=
=5F2VTa0NLZcxORgkUe5tEQ@mail.gmail.com/ [1]
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Jeff Xu <jeffxu@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> > Changes in v3:
> > * Simplified code to use shorthand ifs and a
> >   lookup=5Fconstant() table.
> >
> > Changes in v2:
> > * Added bootparam on top of Linus' patch.
> > * Slightly reworded commit msg.
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 10 ++++
> >  fs/proc/base.c                                | 54 +++++++++++++++=
+++-
> >  security/Kconfig                              | 32 +++++++++++
> >  3 files changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > index c1134ad5f06d..793301f360ec 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4791,6 +4791,16 @@
> >         printk.time=3D    Show timing data prefixed to each printk =
message line
> >                         Format: <bool>  (1/Y/y=3Denable, 0/N/n=3Ddi=
sable)
> >
> > +       proc=5Fmem.force=5Foverride=3D [KNL]
> > +                       Format: {always | ptrace | never}
> > +                       Traditionally /proc/pid/mem allows users to=
 override memory
> > +                       permissions. This allows people to limit th=
at.
>=20
> Better to use passive tense here rather than referring to 'users' and=
 'people'.
>=20
> 'Traditionally, /proc/pid/mem allows memory permissions to be
> overridden without restrictions.
> This option may be set to restrict that'
>=20
> > +                       Can be one of:
> > +                       - 'always' traditional behavior always allo=
ws mem overrides.
>=20
> punctuation please
>=20
> > +                       - 'ptrace' only allow for active ptracers.
> > +                       - 'never'  never allow mem permission overr=
ides.
>=20
> Please be consistent: 'mem overrides' or 'mem permission overrides' i=
n
> both instances.
>=20
> > +                       If not specified, default is always.
>=20
> 'always'
>=20
> > +
> >         processor.max=5Fcstate=3D   [HW,ACPI]
> >                         Limit processor to maximum C-state
> >                         max=5Fcstate=3D9 overrides any DMI blacklis=
t limit.
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 72a1acd03675..0ca3fc3d9e0e 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -85,6 +85,7 @@
> >  #include <linux/elf.h>
> >  #include <linux/pid=5Fnamespace.h>
> >  #include <linux/user=5Fnamespace.h>
> > +#include <linux/fs=5Fparser.h>
> >  #include <linux/fs=5Fstruct.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched/autogroup.h>
> > @@ -117,6 +118,35 @@
> >  static u8 nlink=5Ftid =5F=5Fro=5Fafter=5Finit;
> >  static u8 nlink=5Ftgid =5F=5Fro=5Fafter=5Finit;
> >
> > +enum proc=5Fmem=5Fforce {
> > +       PROC=5FMEM=5FFORCE=5FALWAYS,
> > +       PROC=5FMEM=5FFORCE=5FPTRACE,
> > +       PROC=5FMEM=5FFORCE=5FNEVER
> > +};
> > +
> > +static enum proc=5Fmem=5Fforce proc=5Fmem=5Fforce=5Foverride =5F=5F=
ro=5Fafter=5Finit =3D
> > +       IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FALWAYS=5FFORCE) ? PROC=5F=
MEM=5FFORCE=5FALWAYS :
> > +       IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FFORCE=5FPTRACE) ? PROC=5F=
MEM=5FFORCE=5FPTRACE :
> > +       PROC=5FMEM=5FFORCE=5FNEVER;
> > +
> > +struct constant=5Ftable proc=5Fmem=5Fforce=5Ftable[] =3D {
>=20
> This can be static const =5F=5Finitconst
>=20
> > +       { "always", PROC=5FMEM=5FFORCE=5FALWAYS },
> > +       { "ptrace", PROC=5FMEM=5FFORCE=5FPTRACE },
> > +       { }
> > +};
> > +
> > +static int =5F=5Finit early=5Fproc=5Fmem=5Fforce=5Foverride(char *=
buf)
> > +{
> > +       if (!buf)
> > +               return -EINVAL;
> > +
>=20
> Can this ever happen?

Not sure, many calls simply ignore this case while others
like this [1] printk example do test it. I'm inclined to think
it can't happen however it's still to good to error check.

Thanks for all the suggestions, I'll leave this a bit for others
to get a chance to review, then send another iteration.

[1] https://elixir.bootlin.com/linux/v6.10.1/source/kernel/printk/print=
k.c#L1051


