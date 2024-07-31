Return-Path: <linux-fsdevel+bounces-24688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44700943156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AA31C2147A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76C1B29C9;
	Wed, 31 Jul 2024 13:48:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F3F1B0136;
	Wed, 31 Jul 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433722; cv=none; b=kmiFGLBy5mqTSOtw+t2yWcwsOiYB/7eFcQrr2Da00XvKBB6xOIktnJEYWbREULeNVeMfWSRWkSy+RydVmgxdq/eP2KexgDOL5oO9Pk3V0YZXqNjV+ylpdSDQnMJ0g0soaeYu03Bv7lyBCKt/A0CxFafKYR+sy0Sx/I1vsaVPqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433722; c=relaxed/simple;
	bh=HV6dzrwe4DmyWuF2+mUBzeqHTzldsxegkksIA2omFeE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=KXnYZSWMorQE7V/INDAaIlBbufQQJoucdiqOiDwCXZrkpnBXnyAZk66bWCEw9R2fMIpAn+999RLL/KkzWyk4n5pqQd87ApxXTNhAwErPuv+HMC8ExWwPI+ZKOpH4sLRyyAihKGrLyAnD3S4EE0Tsibnkci5UXUG3tQW02Q5ZUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 394D437821DB;
	Wed, 31 Jul 2024 13:48:38 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240730132528.1143520-1-adrian.ratiu@collabora.com> <CALmYWFumfPxoEE-jJEadnep=38edT7KZaY7KO9HLod=tdsOG=w@mail.gmail.com>
Date: Wed, 31 Jul 2024 14:48:38 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, inglorion@google.com, ajordanr@google.com, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Kees Cook" <kees@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
To: "Jeff Xu" <jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3eabcc-66aa4080-7-7f37ea80@3556857>
Subject: =?utf-8?q?Re=3A?= [PATCH v4] =?utf-8?q?proc=3A?= add config & param to 
 block forcing mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 31, 2024 02:08 EEST, Jeff Xu <jeffxu@google.com> wro=
te:

> On Tue, Jul 30, 2024 at 6:25=E2=80=AFAM Adrian Ratiu <adrian.ratiu@co=
llabora.com> wrote:
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
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> > Changes in v4:
> > * Fixed doc punctuation, used passive tense, improved
> >   wording consistency, fixed default value wording
> > * Made struct constant=5Ftable a static const =5F=5Finitconst
> > * Reworked proc=5Fmem=5Ffoll=5Fforce() indentation and var
> >   declarations to make code clearer
> > * Reworked enum + struct definition so lookup=5Fconstant()
> >   defaults to 'always'.
> >
> > Changes in v3:
> > * Simplified code to use shorthand ifs and a
> >   lookup=5Fconstant() table
> >
> > Changes in v2:
> > * Added bootparam on top of Linus' patch
> > * Slightly reworded commit msg
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 10 ++++
> >  fs/proc/base.c                                | 54 +++++++++++++++=
+++-
> >  security/Kconfig                              | 32 +++++++++++
> >  3 files changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > index f1384c7b59c9..8396e015aab3 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4788,6 +4788,16 @@
> >         printk.time=3D    Show timing data prefixed to each printk =
message line
> >                         Format: <bool>  (1/Y/y=3Denable, 0/N/n=3Ddi=
sable)
> >
> > +       proc=5Fmem.force=5Foverride=3D [KNL]
> > +                       Format: {always | ptrace | never}
> > +                       Traditionally /proc/pid/mem allows memory p=
ermissions to be
> > +                       overridden without restrictions. This optio=
n may be set to
> > +                       restrict that. Can be one of:
> > +                       - 'always': traditional behavior always all=
ows mem overrides.
> > +                       - 'ptrace': only allow mem overrides for ac=
tive ptracers.
> > +                       - 'never':  never allow mem overrides.
> > +                       If not specified, default is the CONFIG=5FP=
ROC=5FMEM=5F* choice.
> > +
> >         processor.max=5Fcstate=3D   [HW,ACPI]
> >                         Limit processor to maximum C-state
> >                         max=5Fcstate=3D9 overrides any DMI blacklis=
t limit.
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 72a1acd03675..daacb8070042 100644
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
> > +       IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FNO=5FFORCE) ? PROC=5FMEM=
=5FFORCE=5FNEVER :
> > +       IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FFORCE=5FPTRACE) ? PROC=5F=
MEM=5FFORCE=5FPTRACE :
> > +       PROC=5FMEM=5FFORCE=5FALWAYS;
> > +
> > +static const struct constant=5Ftable proc=5Fmem=5Fforce=5Ftable[] =
=5F=5Finitconst =3D {
> > +       { "never", PROC=5FMEM=5FFORCE=5FNEVER },
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
> > +       proc=5Fmem=5Fforce=5Foverride =3D lookup=5Fconstant(proc=5F=
mem=5Fforce=5Ftable,
> > +                                                 buf, PROC=5FMEM=5F=
FORCE=5FALWAYS);
> proc=5Fmem=5Fforce=5Ftable has two entries, this means:
> if kernel cmdline has proc=5Fmem.force=5Foverride=3D"invalid",
>     PROC=5FMEM=5FFORCE=5FALWAYS will be used.
>=20
> Another option is to have 3 entries in proc=5Fmem=5Fforce=5Ftable: ad=
ding
> {"aways", PROC=5FMEM=5FFORCE=5FALWAYS}
>=20
> and let lookup=5Fconstant return -1 when not found, and not override
> proc=5Fmem=5Fforce=5Foverride.

Thanks Jeff for spotting this! :)

In addition to adding all the 3 entries as you suggested, I think we
can also do the following:

proc=5Fmem=5Fforce=5Foverride =3D lookup=5Fconstant(proc=5Fmem=5Fforce=5F=
table,
                                                 buf, proc=5Fmem=5Fforc=
e=5Foverride);

This will ensure that if something like "invalid" gets passed, the
proc=5Fmem=5Fforce=5Foverride value remains unchanged. In other words
it remains equal to the default choice set via Kconfig and correctly
matches the doc description.

I'll address this before sending v5 in a few days to give others time
to review.

>=20
> This enforces the kernel cmd line must be set to one of three choices
> "always|ptrace|never" to be effective.
>=20
> If you choose this path: please modify kernel-parameters.txt to
> "If not specified or invalid, default is the CONFIG=5FPROC=5FMEM=5F* =
choice."
>=20
> or else please clarify in the kernel-parameters.text:
> If not specified, default is the CONFIG=5FPROC=5FMEM=5F* choice
> If invalid str or empty string, PROC=5FMEM=5FFORCE=5FALWAYS will be u=
sed
> regardless CONFIG=5FPROC=5FMEM=5F* choice
>=20
> > +
> > +       return 0;
> > +}
> > +early=5Fparam("proc=5Fmem.force=5Foverride", early=5Fproc=5Fmem=5F=
force=5Foverride);
> > +
> >  struct pid=5Fentry {
> >         const char *name;
> >         unsigned int len;
> > @@ -835,6 +865,26 @@ static int mem=5Fopen(struct inode *inode, str=
uct file *file)
> >         return ret;
> >  }
> >
> > +static bool proc=5Fmem=5Ffoll=5Fforce(struct file *file, struct mm=
=5Fstruct *mm)
> > +{
> > +       struct task=5Fstruct *task;
> > +       bool ptrace=5Factive =3D false;
> > +
> > +       switch (proc=5Fmem=5Fforce=5Foverride) {
> > +       case PROC=5FMEM=5FFORCE=5FNEVER:
> > +               return false;
> > +       case PROC=5FMEM=5FFORCE=5FPTRACE:
> > +               task =3D get=5Fproc=5Ftask(file=5Finode(file));
> > +               if (task) {
> > +                       ptrace=5Factive =3D task->ptrace && task->m=
m =3D=3D mm && task->parent =3D=3D current;
> Do we need to call "read=5Flock(&tasklist=5Flock);" ?
> see comments in ptrace=5Fcheck=5Fattach() of  kernel/ptrace.c
>=20
>=20
>=20
> > +                       put=5Ftask=5Fstruct(task);
> > +               }
> > +               return ptrace=5Factive;
> > +       default:
> > +               return true;
> > +       }
> > +}
> > +
> >  static ssize=5Ft mem=5Frw(struct file *file, char =5F=5Fuser *buf,
> >                         size=5Ft count, loff=5Ft *ppos, int write)
> >  {
> > @@ -855,7 +905,9 @@ static ssize=5Ft mem=5Frw(struct file *file, ch=
ar =5F=5Fuser *buf,
> >         if (!mmget=5Fnot=5Fzero(mm))
> >                 goto free;
> >
> > -       flags =3D FOLL=5FFORCE | (write ? FOLL=5FWRITE : 0);
> > +       flags =3D write ? FOLL=5FWRITE : 0;
> > +       if (proc=5Fmem=5Ffoll=5Fforce(file, mm))
> > +               flags |=3D FOLL=5FFORCE;
> >
> >         while (count > 0) {
> >                 size=5Ft this=5Flen =3D min=5Ft(size=5Ft, count, PA=
GE=5FSIZE);
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 412e76f1575d..a93c1a9b7c28 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -19,6 +19,38 @@ config SECURITY=5FDMESG=5FRESTRICT
> >
> >           If you are unsure how to answer this question, answer N.
> >
> > +choice
> > +       prompt "Allow /proc/pid/mem access override"
> > +       default PROC=5FMEM=5FALWAYS=5FFORCE
> > +       help
> > +         Traditionally /proc/pid/mem allows users to override memo=
ry
> > +         permissions for users like ptrace, assuming they have ptr=
ace
> > +         capability.
> > +
> > +         This allows people to limit that - either never override,=
 or
> > +         require actual active ptrace attachment.
> > +
> > +         Defaults to the traditional behavior (for now)
> > +
> > +config PROC=5FMEM=5FALWAYS=5FFORCE
> > +       bool "Traditional /proc/pid/mem behavior"
> > +       help
> > +         This allows /proc/pid/mem accesses to override memory map=
ping
> > +         permissions if you have ptrace access rights.
> > +
> > +config PROC=5FMEM=5FFORCE=5FPTRACE
> > +       bool "Require active ptrace() use for access override"
> > +       help
> > +         This allows /proc/pid/mem accesses to override memory map=
ping
> > +         permissions for active ptracers like gdb.
> > +
> > +config PROC=5FMEM=5FNO=5FFORCE
> > +       bool "Never"
> > +       help
> > +         Never override memory mapping permissions
> > +
> > +endchoice
> > +
> >  config SECURITY
> >         bool "Enable different security models"
> >         depends on SYSFS
> > --
> > 2.44.2
> >


