Return-Path: <linux-fsdevel+bounces-13476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD1870393
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C35E2828F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC853FB02;
	Mon,  4 Mar 2024 14:06:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435F224CF;
	Mon,  4 Mar 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561208; cv=none; b=sayZEj/YPLzvxJCpXYmKgqtozy+haEfBlL/ZFUp/pla+esihgdnkGpazG44INQ5APJbiJBTd1X+bdiuQ/Z9Ulz/nVuxyU4d7uwtiu09ZslObU8mcTuz/RY/FUx2VFhP13gvnSqUjwDXCif15Ptbct1ne8uTSdkbqScqmTqK7c+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561208; c=relaxed/simple;
	bh=QvRGs5EWU0opb/4Imc1ATwWWFnnfEerv4pTtl0UeZYY=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Uy4LMmG2+NGf2qYHJYcgxJtqYFfF1WQcne+m50YWX67QB2NEsd+Sn8/30e4Rdme7CAyxAf8w4V74GEqoj8Qth4y4U6lN/b5Y4gkyz+Cl0IjGHCCz0vmY7mJk0g87BAY9n3tNQDUOpjypitXRDdPEIgwYyl1rz9DahyFG2rSpM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id B68F037820C3;
	Mon,  4 Mar 2024 14:06:43 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202403011451.C236A38@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240301213442.198443-1-adrian.ratiu@collabora.com> <202403011451.C236A38@keescook>
Date: Mon, 04 Mar 2024 14:06:43 +0000
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Christian Brauner" <brauner@kernel.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <39f23-65e5d580-3-638b0780@155677577>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?proc=3A?= allow restricting 
 /proc/pid/mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Saturday, March 02, 2024 01:55 EET, Kees Cook <keescook@chromium.org=
> wrote:

> On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> >=20
> > Afterwards exploits appeared started causing drama like [1]. The
>=20
> nit: I think "appeared" can be dropped here.
>=20
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
>=20
> Everything above here is good to keep in the commit log, but it's all
> the "background". Please also write here what has been done to addres=
s
> the background above it. e.g.:
>=20
> "Introduce a CONFIG and a =5F=5Fro=5Fafter=5Finit runtime toggle to m=
ake
> it so only processes that are already tracing the task to write to
> /proc/<pid>/mem." etc
>=20
> >=20
> > [1] https://lwn.net/Articles/476947/
> > [2] https://issues.chromium.org/issues/40089045
>=20
> These can be:
>=20
> Link: https://lwn.net/Articles/476947/ [1]
> Link: https://issues.chromium.org/issues/40089045 [2]
>=20
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
>=20
> Can you mention in the commit log what behaviors have been tested wit=
h
> this patch? For example, I assume gdb still works with
> restrict=5Fproc=5Fmem=5Fwrite=3Dy ?
>=20
> When this is enabled, what =5Fdoes=5F break that people might expect =
to
> work?
>=20
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
>=20
> Please add here:
>=20
> 			Format: <bool>
>=20
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
>=20
> Please drop this CONFIG entirely -- it should be always available for
> all builds of the kernel. Only CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTR=
ICT=5FWRITE=5FDEFAULT=5FON
> needs to remain.
>=20
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
>=20
> PROC=5FPID=5FMEM=5FMODE will need to be a =5F=5Fro=5Fafter=5Finit var=
iable, set by
> early=5Frestrict=5Fproc=5Fmem=5Fwrite, otherwise the mode won't chang=
e based on
> the runtime setting. e.g.:
>=20
> #ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAULT=5F=
ON
> mode=5Ft proc=5Fpid=5Fmem=5Fmode =5F=5Fro=5Fafter=5Finit =3D S=5FIRUS=
R;
> #else
> mode=5Ft proc=5Fpid=5Fmem=5Fmode =5F=5Fro=5Fafter=5Finit =3D (S=5FIRU=
SR|S=5FIWUSR);
> #endif
>=20
> DEFINE=5FSTATIC=5FKEY=5FMAYBE=5FRO(CONFIG=5FSECURITY=5FPROC=5FMEM=5FR=
ESTRICT=5FWRITE=5FDEFAULT=5FON,
> 			   restrict=5Fproc=5Fmem=5Fwrite);
> ...
> 	if (bool=5Fresult) {
> 		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem=5Fwrite);
> 		proc=5Fpid=5Fmem=5Fmode =3D S=5FIRUSR;
> 	} else {
> 		static=5Fbranch=5Fdisable(&restrict=5Fproc=5Fmem=5Fwrite);
> 		proc=5Fpid=5Fmem=5Fmode =3D (S=5FIRUSR|S=5FIWUSR);
> 	}
> ...
> 	REG("mem",        proc=5Fpid=5Fmem=5Fmode, proc=5Fmem=5Foperations),

I'm having trouble implementing this because the proc=5Fpid=5Fmem=5Fmod=
e initializer needs to be a compile-time constant, so I can't set a run=
time value in the REG() definition like suggested above.

This was not an issue in v2 because we had two separate kconfigs:
-  one which enabled the feature and controlled the static build-time f=
ile modes (CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE)
- another which set the default runtime value and more importantly whic=
h depended on the first one so the values are consistent (CONFIG=5FSECU=
RITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAULT=5FON)

Do you have a suggestion how to fix this? Maybe store the flags in a st=
atic key? I'm asking because I'm not very familiar with static keys.

Or maybe we can continue using the 2 kconfig options?

>=20
>=20
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
>=20
> Drop this ifdef (as mentioned above).
>=20
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
>=20
> Do we need to also do an mm=5Faccess() on the task to verify that the=
 task
> we're about to check has its mm still matching file->private=5Fdata? =
The
> PID can change out from under us (but the mm cannot).
>=20
> > +			rcu=5Fread=5Flock();
> > +			if (!ptracer=5Fcapable(current, mm->user=5Fns) ||
> > +			    current !=3D ptrace=5Fparent(task))
>=20
> If you're just allowing "already ptracing", why include the
> ptracer=5Fcapable() check?
>=20
> > +				ret =3D -EACCES;
> > +			rcu=5Fread=5Funlock();
> > +		}
> > +		put=5Ftask=5Fstruct(task);
> > +	}
> > +#endif
> > +
> >  	/* OK to pass negative loff=5Ft, we can catch out-of-range */
> >  	file->f=5Fmode |=3D FMODE=5FUNSIGNED=5FOFFSET;
> > =20
> > @@ -3281,7 +3324,7 @@ static const struct pid=5Fentry tgid=5Fbase=5F=
stuff[] =3D {
> >  #ifdef CONFIG=5FNUMA
> >  	REG("numa=5Fmaps",  S=5FIRUGO, proc=5Fpid=5Fnuma=5Fmaps=5Foperati=
ons),
> >  #endif
> > -	REG("mem",        S=5FIRUSR|S=5FIWUSR, proc=5Fmem=5Foperations),
> > +	REG("mem",        PROC=5FPID=5FMEM=5FMODE, proc=5Fmem=5Foperation=
s),
> >  	LNK("cwd",        proc=5Fcwd=5Flink),
> >  	LNK("root",       proc=5Froot=5Flink),
> >  	LNK("exe",        proc=5Fexe=5Flink),
> > @@ -3631,7 +3674,7 @@ static const struct pid=5Fentry tid=5Fbase=5F=
stuff[] =3D {
> >  #ifdef CONFIG=5FNUMA
> >  	REG("numa=5Fmaps", S=5FIRUGO, proc=5Fpid=5Fnuma=5Fmaps=5Foperatio=
ns),
> >  #endif
> > -	REG("mem",       S=5FIRUSR|S=5FIWUSR, proc=5Fmem=5Foperations),
> > +	REG("mem",       PROC=5FPID=5FMEM=5FMODE, proc=5Fmem=5Foperations=
),
> >  	LNK("cwd",       proc=5Fcwd=5Flink),
> >  	LNK("root",      proc=5Froot=5Flink),
> >  	LNK("exe",       proc=5Fexe=5Flink),
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 412e76f1575d..ffee9e847ed9 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -19,6 +19,28 @@ config SECURITY=5FDMESG=5FRESTRICT
> > =20
> >  	  If you are unsure how to answer this question, answer N.
> > =20
> > +config SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > +	bool "Restrict /proc/*/mem write access"
> > +	default n
> > +	help
> > +	  This restricts writes to /proc/<pid>/mem, except when the curre=
nt
> > +	  process ptraces the /proc/<pid>/mem task, because a ptracer alr=
eady
> > +	  has write access to the tracee memory.
> > +
> > +	  Write access to this file allows bypassing memory map permissio=
ns,
> > +	  such as modifying read-only code.
> > +
> > +	  If you are unsure how to answer this question, answer N.
> > +
> > +config SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAULT=5FON
> > +	bool "Default state of /proc/*/mem write restriction"
> > +	depends on SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > +	default y
> > +	help
> > +	  /proc/*/mem write access is controlled by kernel boot param
> > +	  "restrict=5Fproc=5Fmem=5Fwrite" and this config chooses the def=
ault
> > +	  boot state.
>=20
> As mentioned, I'd say merge the help texts here, but drop
> SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE.
>=20
> > +
> >  config SECURITY
> >  	bool "Enable different security models"
> >  	depends on SYSFS
> > --=20
> > 2.30.2
> >=20
>=20
> Thanks for this! I look forward to turning it on. :)
>=20
> -Kees
>=20
> --=20
> Kees Cook


