Return-Path: <linux-fsdevel+bounces-13478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A62870448
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAD41F23AC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC9C46535;
	Mon,  4 Mar 2024 14:35:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF7726AE7;
	Mon,  4 Mar 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562934; cv=none; b=tjY8e/hJhJDbs7EWGbrJjju2Azr0J9nVrmGAKMWwyoUo1UaowTVwbsZMTdVMQ5X0xw+Qq7r85tME4fxx5YkSt1J9pBrO+uda5R0QRItOn4nLAYppTvE6Z6pEPZ+i27c3AQhr8IJOQ0yu0csUHW4qE20H96U+4xuoQZ74DecL/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562934; c=relaxed/simple;
	bh=oFUPtkeNn1/+FKXpTBt46QI393bkUx54iU0uh+uZ2M8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=X99gzWUFO62AgfR8P++IXm4wDT4gmFWMbblohj+A0EC2jJA9Zz0cz993c1ETGMOUOc+i8SEnW8xpkTb2nQUmqDdULK42Zh3czc0r38OpDoYFYUCIbPW6X4WTCQHQzuoUvrxHI02BiUqMM+ilwMYj9zjr6bOzbZWURwRqcsRQ328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 9B1B3378000B;
	Mon,  4 Mar 2024 14:35:29 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <20240304-legten-pelzmantel-1dca3659a892@brauner>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <39e47-65e5d100-1-5e37bd0@176022561> <20240304-legten-pelzmantel-1dca3659a892@brauner>
Date: Mon, 04 Mar 2024 14:35:29 +0000
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Kees Cook" <keescook@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Christian Brauner" <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a1eb-65e5dc00-15-364077c0@216340496>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?proc=3A?= allow restricting 
 /proc/pid/mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Monday, March 04, 2024 16:05 EET, Christian Brauner <brauner@kernel.=
org> wrote:

> On Mon, Mar 04, 2024 at 01:48:19PM +0000, Adrian Ratiu wrote:
> > On Monday, March 04, 2024 15:20 EET, Christian Brauner <brauner@ker=
nel.org> wrote:
> >=20
> > > On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> > > > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted=
,
> > > > after which it got allowed in commit 198214a7ee50 ("proc: enabl=
e
> > > > writing to /proc/pid/mem"). Famous last words from that patch:
> > > > "no longer a security hazard". :)
> > > >=20
> > > > Afterwards exploits appeared started causing drama like [1]. Th=
e
> > > > /proc/*/mem exploits can be rather sophisticated like [2] which
> > > > installed an arbitrary payload from noexec storage into a runni=
ng
> > > > process then exec'd it, which itself could include an ELF loade=
r
> > > > to run arbitrary code off noexec storage.
> > > >=20
> > > > As part of hardening against these types of attacks, distrbutio=
ns
> > > > can restrict /proc/*/mem to only allow writes when they makes s=
ense,
> > > > like in case of debuggers which have ptrace permissions, as the=
y
> > > > are able to access memory anyway via PTRACE=5FPOKEDATA and frie=
nds.
> > > >=20
> > > > Dropping the mode bits disables write access for non-root users=
.
> > > > Trying to `chmod` the paths back fails as the kernel rejects it=
.
> > > >=20
> > > > For users with CAP=5FDAC=5FOVERRIDE (usually just root) we have=
 to
> > > > disable the mem=5Fwrite callback to avoid bypassing the mode bi=
ts.
> > > >=20
> > > > Writes can be used to bypass permissions on memory maps, even i=
f a
> > > > memory region is mapped r-x (as is a program's executable pages=
),
> > > > the process can open its own /proc/self/mem file and write to t=
he
> > > > pages directly.
> > > >=20
> > > > Even if seccomp filters block mmap/mprotect calls with W|X perm=
s,
> > > > they often cannot block open calls as daemons want to read/writ=
e
> > > > their own runtime state and seccomp filters cannot check file p=
aths.
> > > > Write calls also can't be blocked in general via seccomp.
> > > >=20
> > > > Since the mem file is part of the dynamic /proc/<pid>/ space, w=
e
> > > > can't run chmod once at boot to restrict it (and trying to reac=
t
> > > > to every process and run chmod doesn't scale, and the kernel no
> > > > longer allows chmod on any of these paths).
> > > >=20
> > > > SELinux could be used with a rule to cover all /proc/*/mem file=
s,
> > > > but even then having multiple ways to deny an attack is useful =
in
> > > > case on layer fails.
> > > >=20
> > > > [1] https://lwn.net/Articles/476947/
> > > > [2] https://issues.chromium.org/issues/40089045
> > > >=20
> > > > Based on an initial patch by Mike Frysinger <vapier@chromium.or=
g>.
> > > >=20
> > > > Cc: Guenter Roeck <groeck@chromium.org>
> > > > Cc: Doug Anderson <dianders@chromium.org>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Co-developed-by: Mike Frysinger <vapier@chromium.org>
> > > > Signed-off-by: Mike Frysinger <vapier@chromium.org>
> > > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > > > ---
> > > > Changes in v2:
> > > >  * Added boot time parameter with default kconfig option
> > > >  * Moved check earlier in mem=5Fopen() instead of mem=5Fwrite()
> > > >  * Simplified implementation branching
> > > >  * Removed dependency on CONFIG=5FMEMCG
> > > > ---
> > > >  .../admin-guide/kernel-parameters.txt         |  4 ++
> > > >  fs/proc/base.c                                | 47 +++++++++++=
+++++++-
> > > >  security/Kconfig                              | 22 +++++++++
> > > >  3 files changed, 71 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/=
Documentation/admin-guide/kernel-parameters.txt
> > > > index 460b97a1d0da..0647e2f54248 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -5618,6 +5618,10 @@
> > > >  	reset=5Fdevices	[KNL] Force drivers to reset the underlying d=
evice
> > > >  			during initialization.
> > > > =20
> > > > +	restrict=5Fproc=5Fmem=5Fwrite=3D [KNL]
> > > > +			Enable or disable write access to /proc/*/mem files.
> > > > +			Default is SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE=5FDEFAU=
LT=5FON.
> > > > +
> > > >  	resume=3D		[SWSUSP]
> > > >  			Specify the partition device for software suspend
> > > >  			Format:
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index 98a031ac2648..92f668191312 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -152,6 +152,30 @@ struct pid=5Fentry {
> > > >  		NULL, &proc=5Fpid=5Fattr=5Foperations,	\
> > > >  		{ .lsmid =3D LSMID })
> > > > =20
> > > > +#ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > > > +DEFINE=5FSTATIC=5FKEY=5FMAYBE=5FRO(CONFIG=5FSECURITY=5FPROC=5F=
MEM=5FRESTRICT=5FWRITE=5FDEFAULT=5FON,
> > > > +			   restrict=5Fproc=5Fmem=5Fwrite);
> > > > +static int =5F=5Finit early=5Frestrict=5Fproc=5Fmem=5Fwrite(ch=
ar *buf)
> > > > +{
> > > > +	int ret;
> > > > +	bool bool=5Fresult;
> > > > +
> > > > +	ret =3D kstrtobool(buf, &bool=5Fresult);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (bool=5Fresult)
> > > > +		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem=5Fwrite);
> > > > +	else
> > > > +		static=5Fbranch=5Fdisable(&restrict=5Fproc=5Fmem=5Fwrite);
> > > > +	return 0;
> > > > +}
> > > > +early=5Fparam("restrict=5Fproc=5Fmem=5Fwrite", early=5Frestric=
t=5Fproc=5Fmem=5Fwrite);
> > > > +# define PROC=5FPID=5FMEM=5FMODE S=5FIRUSR
> > > > +#else
> > > > +# define PROC=5FPID=5FMEM=5FMODE (S=5FIRUSR|S=5FIWUSR)
> > > > +#endif
> > > > +
> > > >  /*
> > > >   * Count the number of hardlinks for the pid=5Fentry table, ex=
cluding the .
> > > >   * and .. links.
> > > > @@ -829,6 +853,25 @@ static int mem=5Fopen(struct inode *inode,=
 struct file *file)
> > > >  {
> > > >  	int ret =3D =5F=5Fmem=5Fopen(inode, file, PTRACE=5FMODE=5FATT=
ACH);
> > > > =20
> > > > +#ifdef CONFIG=5FSECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE
> > > > +	struct mm=5Fstruct *mm =3D file->private=5Fdata;
> > > > +	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> > > > +
> > > > +	if (mm && task) {
> > > > +		/* Only allow writes by processes already ptracing the targe=
t task */
> > > > +		if (file->f=5Fmode & FMODE=5FWRITE &&
> > > > +		    static=5Fbranch=5Fmaybe(CONFIG=5FSECURITY=5FPROC=5FMEM=5F=
RESTRICT=5FWRITE=5FDEFAULT=5FON,
> > > > +					&restrict=5Fproc=5Fmem=5Fwrite)) {
> > > > +			rcu=5Fread=5Flock();
> > > > +			if (!ptracer=5Fcapable(current, mm->user=5Fns) ||
> > > > +			    current !=3D ptrace=5Fparent(task))
> > > > +				ret =3D -EACCES;
> > >=20
> > > Uhm, this will break the seccomp notifier, no? So you can't turn =
on
> > > SECURITY=5FPROC=5FMEM=5FRESTRICT=5FWRITE when you want to use the=
 seccomp
> > > notifier to do system call interception and rewrite memory locati=
ons of
> > > the calling task, no? Which is very much relied upon in various
> > > container managers and possibly other security tools.
> > >=20
> > > Which means that you can't turn this on in any of the regular dis=
tros.
> > >=20
> > > So you need to either account for the calling task being a seccom=
p
> > > supervisor for the task whose memory it is trying to access or yo=
u need
> > > to provide a migration path by adding an api that let's caller's =
perform
> > > these writes through the seccomp notifier.
> >=20
> > Thanks for raising this!
> >=20
> > I did test seccomp filtering/blocking functionality which seemed to
> > work but I'll make sure to also test syscall interception before
> > sending v3, to confirm whether it breaks.
> >=20
> > The simplest solution is to add an exception for seccomp supervisor=
s
> > just like we did for tracers, yes, so I'm inclined to go with that =
if
> > needed. :)
>=20
> Ok. Note that your patch also doesn't cover process=5Fvm=5Fwritev() w=
hich
> means that you can still use that as an alternative to write to memor=
y -
> albeit with a lote more raciness. IOW, a seccomp notifier can do the
> dance of:
>=20
> pidfd =3D clone3(CLONE=5FPIDFD)
> // handle error
> int fd=5Fmem =3D open("/proc/$pid/mem", O=5FRDWR);:
> // handle error
> if (pidfd=5Fsend=5Fsignal(pidfd, 0, ...) =3D=3D 0)
>         write(fd=5Fmem, ...);
>=20
> which lets it avoid the raciness. That's not possible with
> process=5Fvm=5Fwritev() especially if it's received via AF=5FUNIX soc=
kets
> which happens if the seccomp notifier lives in a proxy process. I kno=
w
> that happens in the wild.
>=20
> So overall, it seems a bit odd to me because why block /proc/<pid>/me=
m
> specifically and not also cover process=5Fvm=5Fwritev()? Because that=
's easy
> to block via regular seccomp system call filtering?

Yes, easy to block and also respect page permissions (can't write read-=
only memory) as well as require ptrace access anyway by checking PTRACE=
=5FMODE=5FATTACH=5FREALCREDS.


