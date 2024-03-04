Return-Path: <linux-fsdevel+bounces-13473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F49870332
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94CD2855B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD583F8C7;
	Mon,  4 Mar 2024 13:48:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450393D542;
	Mon,  4 Mar 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560104; cv=none; b=NZ4wGWay5OyfG9mn1BjWWmRUwzkeNlael8Rp7WU7pUcVMxW4Kacglsj8gHesCbafT1A7U21vkk4Zbd9RX4cZ5+fZkGpjfULmIT3mG0Du4Uq81pQ65V6tsl72ZiDY+qqGugLXYAc1uyiKlePlIQrq0dcmS6lDsaOgmgAGjcivAUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560104; c=relaxed/simple;
	bh=uby7Z8vhLTiM08+HxX4A1oBn8GHa+JawYv/Et6sp3js=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=aR/a0pmAvSnBolDXygbJNcdHEIL5R8gXfCXsW6sLYKQIRd4m8qpfBr5Z+foGZekGMZ9DTn0g4VKORgg2fzWG4g1C/r1iU5X9/pVH/Iykduvs0uCOBEvkw5D2xmoi49T+R5yw0WNNbVIIll3rRfnGnLYzvuOj7Rt1SY0rj/EkRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 76E8C37820CB;
	Mon,  4 Mar 2024 13:48:19 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <20240304-zugute-abtragen-d499556390b3@brauner>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240301213442.198443-1-adrian.ratiu@collabora.com> <20240304-zugute-abtragen-d499556390b3@brauner>
Date: Mon, 04 Mar 2024 13:48:19 +0000
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Kees Cook" <keescook@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Christian Brauner" <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <39e47-65e5d100-1-5e37bd0@176022561>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?proc=3A?= allow restricting 
 /proc/pid/mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Monday, March 04, 2024 15:20 EET, Christian Brauner <brauner@kernel.=
org> wrote:

> On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> >=20
> > Afterwards exploits appeared started causing drama like [1]. The
> > /proc/*/mem exploits can be rather sophisticated like [2] which
> > installed an arbitrary payload from noexec storage into a running
> > process then exec'd it, which itself could include an ELF loader
> > to run arbitrary code off noexec storage.
> >=20
> > As part of hardening against these types of attacks, distrbutions
> > can restrict /proc/*/mem to only allow writes when they makes sense=
,
> > like in case of debuggers which have ptrace permissions, as they
> > are able to access memory anyway via PTRACE=5FPOKEDATA and friends.
> >=20
> > Dropping the mode bits disables write access for non-root users.
> > Trying to `chmod` the paths back fails as the kernel rejects it.
> >=20
> > For users with CAP=5FDAC=5FOVERRIDE (usually just root) we have to
> > disable the mem=5Fwrite callback to avoid bypassing the mode bits.
> >=20
> > Writes can be used to bypass permissions on memory maps, even if a
> > memory region is mapped r-x (as is a program's executable pages),
> > the process can open its own /proc/self/mem file and write to the
> > pages directly.
> >=20
> > Even if seccomp filters block mmap/mprotect calls with W|X perms,
> > they often cannot block open calls as daemons want to read/write
> > their own runtime state and seccomp filters cannot check file paths=
.
> > Write calls also can't be blocked in general via seccomp.
> >=20
> > Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > can't run chmod once at boot to restrict it (and trying to react
> > to every process and run chmod doesn't scale, and the kernel no
> > longer allows chmod on any of these paths).
> >=20
> > SELinux could be used with a rule to cover all /proc/*/mem files,
> > but even then having multiple ways to deny an attack is useful in
> > case on layer fails.
> >=20
> > [1] https://lwn.net/Articles/476947/
> > [2] https://issues.chromium.org/issues/40089045
> >=20
> > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> >=20
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> > Changes in v2:
> >  * Added boot time parameter with default kconfig option
> >  * Moved check earlier in mem=5Fopen() instead of mem=5Fwrite()
> >  * Simplified implementation branching
> >  * Removed dependency on CONFIG=5FMEMCG
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 ++
> >  fs/proc/base.c                                | 47 +++++++++++++++=
+++-
> >  security/Kconfig                              | 22 +++++++++
> >  3 files changed, 71 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > index 460b97a1d0da..0647e2f54248 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5618,6 +5618,10 @@
> >  	reset=5Fdevices	[KNL] Force drivers to reset the underlying devic=
e
> >  			during initialization.
> > =20
> > +	restrict=5Fproc=5Fmem=5Fwrite=3D [KNL]
> > +			Enable or disable write access to /proc/*/mem files.
> > +			Default is SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAULT=5F=
ON.
> > +
> >  	resume=3D		[SWSUSP]
> >  			Specify the partition device for software suspend
> >  			Format:
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 98a031ac2648..92f668191312 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -152,6 +152,30 @@ struct pid=5Fentry {
> >  		NULL, &proc=5Fpid=5Fattr=5Foperations,	\
> >  		{ .lsmid =3D LSMID })
> > =20
> > +#ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > +DEFINE=5FSTATIC=5FKEY=5FMAYBE=5FRO(CONFIG=5FSECURITY=5FPROC=5FMEM=5F=
RESTRICT=5FWRITE=5FDEFAULT=5FON,
> > +			   restrict=5Fproc=5Fmem=5Fwrite);
> > +static int =5F=5Finit early=5Frestrict=5Fproc=5Fmem=5Fwrite(char *=
buf)
> > +{
> > +	int ret;
> > +	bool bool=5Fresult;
> > +
> > +	ret =3D kstrtobool(buf, &bool=5Fresult);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (bool=5Fresult)
> > +		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem=5Fwrite);
> > +	else
> > +		static=5Fbranch=5Fdisable(&restrict=5Fproc=5Fmem=5Fwrite);
> > +	return 0;
> > +}
> > +early=5Fparam("restrict=5Fproc=5Fmem=5Fwrite", early=5Frestrict=5F=
proc=5Fmem=5Fwrite);
> > +# define PROC=5FPID=5FMEM=5FMODE S=5FIRUSR
> > +#else
> > +# define PROC=5FPID=5FMEM=5FMODE (S=5FIRUSR|S=5FIWUSR)
> > +#endif
> > +
> >  /*
> >   * Count the number of hardlinks for the pid=5Fentry table, exclud=
ing the .
> >   * and .. links.
> > @@ -829,6 +853,25 @@ static int mem=5Fopen(struct inode *inode, str=
uct file *file)
> >  {
> >  	int ret =3D =5F=5Fmem=5Fopen(inode, file, PTRACE=5FMODE=5FATTACH)=
;
> > =20
> > +#ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > +	struct mm=5Fstruct *mm =3D file->private=5Fdata;
> > +	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> > +
> > +	if (mm && task) {
> > +		/* Only allow writes by processes already ptracing the target ta=
sk */
> > +		if (file->f=5Fmode & FMODE=5FWRITE &&
> > +		    static=5Fbranch=5Fmaybe(CONFIG=5FSECURITY=5FPROC=5FMEM=5FRES=
TRICT=5FWRITE=5FDEFAULT=5FON,
> > +					&restrict=5Fproc=5Fmem=5Fwrite)) {
> > +			rcu=5Fread=5Flock();
> > +			if (!ptracer=5Fcapable(current, mm->user=5Fns) ||
> > +			    current !=3D ptrace=5Fparent(task))
> > +				ret =3D -EACCES;
>=20
> Uhm, this will break the seccomp notifier, no? So you can't turn on
> SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE when you want to use the sec=
comp
> notifier to do system call interception and rewrite memory locations =
of
> the calling task, no? Which is very much relied upon in various
> container managers and possibly other security tools.
>=20
> Which means that you can't turn this on in any of the regular distros=
.
>=20
> So you need to either account for the calling task being a seccomp
> supervisor for the task whose memory it is trying to access or you ne=
ed
> to provide a migration path by adding an api that let's caller's perf=
orm
> these writes through the seccomp notifier.

Thanks for raising this!

I did test seccomp filtering/blocking functionality which seemed to wor=
k but I'll make sure to also test syscall interception before sending v=
3, to confirm whether it breaks.

The simplest solution is to add an exception for seccomp supervisors ju=
st like we did for tracers, yes, so I'm inclined to go with that if nee=
ded. :)

Ideally we find all exceptions and fix them before defaulting this to o=
n -- unforeseen breakages is why I want to default it to OFF, at least =
initially, until we can be reasonably sure all cases have been covered.


