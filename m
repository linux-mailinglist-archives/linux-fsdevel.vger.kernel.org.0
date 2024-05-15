Return-Path: <linux-fsdevel+bounces-19517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4EB8C655A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC261C21CBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3E6E617;
	Wed, 15 May 2024 11:13:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2B433DC;
	Wed, 15 May 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771615; cv=none; b=ZcoMdJVAOH8jgV9catiwEalp54Oq9DcskwizCqeruX+aYS4enHVs13AlUDprdr/qz+QCgMG68/h56rMuGIv0sMoMzrCkAhkJ5U1L0pFbMxfX5hfWQHBRjO/Wa4rKG44QTlcYQCSXy9uchQCtmlbUmTqmGrSjlKI60KvuMjxCfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771615; c=relaxed/simple;
	bh=Ngr78i216zOx+gi1X8a3X26CgtDatlNShnhTp0n8Jws=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=h2AV4rWoPBYjhnM9Edfi4Ep7WGaorX6xwZ0qd4xOR8iMYPsuYFw44QrBl8mZ1CfvzGYyMBs1tCvxLNazhDj/cyPRoBZSy82Tap+G1X5+Iowqa7Mv+vXHJz0vZXWGeX68zaH7posaM8oT1I7wYqipfcAQgH39l2h6z+VoQnnJIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 4AD87378143B;
	Wed, 15 May 2024 11:13:27 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202404261544.1EAD63D@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240409175750.206445-1-adrian.ratiu@collabora.com> <202404261544.1EAD63D@keescook>
Date: Wed, 15 May 2024 12:13:27 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Christian Brauner" <brauner@kernel.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <144d5b-66449900-7-71f23b80@8510318>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 1/2] =?utf-8?q?proc=3A?= restrict /proc/pid/mem 
 access via param knobs
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Saturday, April 27, 2024 02:10 EEST, Kees Cook <keescook@chromium.or=
g> wrote:

> On Tue, Apr 09, 2024 at 08:57:49PM +0300, Adrian Ratiu wrote:
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> >=20
> > Afterwards exploits started causing drama like [1]. The exploits
> > using /proc/*/mem can be rather sophisticated like [2] which
> > installed an arbitrary payload from noexec storage into a running
> > process then exec'd it, which itself could include an ELF loader
> > to run arbitrary code off noexec storage.
> >=20
> > One of the well-known problems with /proc/*/mem writes is they
> > ignore page permissions via FOLL=5FFORCE, as opposed to writes via
> > process=5Fvm=5Fwritev which respect page permissions. These writes =
can
> > also be used to bypass mode bits.
> >=20
> > To harden against these types of attacks, distrbutions might want
> > to restrict /proc/pid/mem accesses, either entirely or partially,
> > for eg. to restrict FOLL=5FFORCE usage.
> >=20
> > Known valid use-cases which still need these accesses are:
> >=20
> > * Debuggers which also have ptrace permissions, so they can access
> > memory anyway via PTRACE=5FPOKEDATA & co. Some debuggers like GDB
> > are designed to write /proc/pid/mem for basic functionality.
> >=20
> > * Container supervisors using the seccomp notifier to intercept
> > syscalls and rewrite memory of calling processes by passing
> > around /proc/pid/mem file descriptors.
> >=20
> > There might be more, that's why these params default to disabled.
> >=20
> > Regarding other mechanisms which can block these accesses:
> >=20
> > * seccomp filters can be used to block mmap/mprotect calls with W|X
> > perms, but they often can't block open calls as daemons want to
> > read/write their runtime state and seccomp filters cannot check
> > file paths, so plain write calls can't be easily blocked.
> >=20
> > * Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > can't run chmod once at boot to restrict it (and trying to react
> > to every process and run chmod doesn't scale, and the kernel no
> > longer allows chmod on any of these paths).
> >=20
> > * SELinux could be used with a rule to cover all /proc/*/mem files,
> > but even then having multiple ways to deny an attack is useful in
> > case one layer fails.
> >=20
> > Thus we introduce three kernel parameters to restrict /proc/*/mem
> > access: read, write and foll=5Fforce. All three can be independentl=
y
> > set to the following values:
> >=20
> > all     =3D> restrict all access unconditionally.
> > ptracer =3D> restrict all access except for ptracer processes.
> >=20
> > If left unset, the existing behaviour is preserved, i.e. access
> > is governed by basic file permissions.
> >=20
> > Examples which can be passed by bootloaders:
> >=20
> > restrict=5Fproc=5Fmem=5Ffoll=5Fforce=3Dall
> > restrict=5Fproc=5Fmem=5Fwrite=3Dptracer
> > restrict=5Fproc=5Fmem=5Fread=3Dptracer
> >=20
> > Each distribution needs to decide what restrictions to apply,
> > depending on its use-cases. Embedded systems might want to do
> > more, while general-purpouse distros might want a more relaxed
> > policy, because for e.g. foll=5Fforce=3Dall and write=3Dall both br=
eak
> > break GDB, so it might be a bit excessive.
> >=20
> > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
>=20
> Thanks for this new version!

Thank you for the great feedback and sorry for the delayed response.
I had to go offline for 2 weeks during Eastern Easter period.

I'll implement all your suggestions and then send a v4.

>=20
> >=20
> > Link: https://lwn.net/Articles/476947/ [1]
> > Link: https://issues.chromium.org/issues/40089045 [2]
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
> >  .../admin-guide/kernel-parameters.txt         |  27 +++++
> >  fs/proc/base.c                                | 103 ++++++++++++++=
+++-
> >  include/linux/jump=5Flabel.h                    |   5 +
> >  3 files changed, 133 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > index 6e62b8cb19c8d..d7f7db41369c7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5665,6 +5665,33 @@
> >  	reset=5Fdevices	[KNL] Force drivers to reset the underlying devic=
e
> >  			during initialization.
> > =20
> > +	restrict=5Fproc=5Fmem=5Fread=3D [KNL]
> > +			Format: {all | ptracer}
> > +			Allows restricting read access to /proc/*/mem files.
> > +			Depending on restriction level, open for reads return -EACCESS.
> > +			Can be one of:
> > +			- 'all' restricts all access unconditionally.
> > +			- 'ptracer' allows access only for ptracer processes.
> > +			If not specified, then basic file permissions continue to apply=
.
> > +
> > +	restrict=5Fproc=5Fmem=5Fwrite=3D [KNL]
> > +			Format: {all | ptracer}
> > +			Allows restricting write access to /proc/*/mem files.
> > +			Depending on restriction level, open for writes return -EACCESS=
.
> > +			Can be one of:
> > +			- 'all' restricts all access unconditionally.
> > +			- 'ptracer' allows access only for ptracer processes.
> > +			If not specified, then basic file permissions continue to apply=
.
> > +
> > +	restrict=5Fproc=5Fmem=5Ffoll=5Fforce=3D [KNL]
> > +			Format: {all | ptracer}
> > +			Restricts the use of the FOLL=5FFORCE flag for /proc/*/mem acce=
ss.
> > +			If restricted, the FOLL=5FFORCE flag will not be added to vm ac=
cesses.
> > +			Can be one of:
> > +			- 'all' restricts all access unconditionally.
> > +			- 'ptracer' allows access only for ptracer processes.
> > +			If not specified, FOLL=5FFORCE is always used.
>=20
> bike shedding: I wonder if this should be a fake namespace (adding a =
dot
> just to break it up for reading more easily), and have words reordere=
d
> to the kernel's more common subject-verb-object: proc=5Fmem.restrict=5F=
read=3D...
>=20
> > +
> >  	resume=3D		[SWSUSP]
> >  			Specify the partition device for software suspend
> >  			Format:
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 18550c071d71c..c733836c42a65 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -152,6 +152,41 @@ struct pid=5Fentry {
> >  		NULL, &proc=5Fpid=5Fattr=5Foperations,	\
> >  		{ .lsmid =3D LSMID })
> > =20
> > +/*
> > + * each restrict=5Fproc=5Fmem=5F* param controls the following sta=
tic branches:
> > + * key[0] =3D restrict all writes
> > + * key[1] =3D restrict writes except for ptracers
> > + * key[2] =3D restrict all reads
> > + * key[3] =3D restrict reads except for ptracers
> > + * key[4] =3D restrict all FOLL=5FFORCE usage
> > + * key[5] =3D restrict FOLL=5FFORCE usage except for ptracers
> > + */
> > +DEFINE=5FSTATIC=5FKEY=5FARRAY=5FFALSE=5FRO(restrict=5Fproc=5Fmem, =
6);
>=20
> So, I don't like having open-coded numbers. And I'm not sure there's =
a
> benefit to stuffing these all into an array? So:
>=20
> DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fread);
> DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fwrite);
> DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Ffoll=5Ffor=
ce);
>=20
> > +
> > +static int =5F=5Finit early=5Frestrict=5Fproc=5Fmem(char *buf, int=
 offset)
> > +{
> > +	if (!buf)
> > +		return -EINVAL;
> > +
> > +	if (strncmp(buf, "all", 3) =3D=3D 0)
>=20
> I'd use strcmp() to get exact matches. That way "allalksdjflas" doesn=
't
> match. :)
>=20
> > +		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem[offset]);
> > +	else if (strncmp(buf, "ptracer", 7) =3D=3D 0)
> > +		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem[offset + 1]);
> > +
> > +	return 0;
> > +}
>=20
> Then don't bother with a common helper since you've got a macro, and
> it'll all get tossed after =5F=5Finit anyway.
>=20
> > +
> > +#define DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(name, offset)			\
> > +static int =5F=5Finit early=5Frestrict=5Fproc=5Fmem=5F##name(char =
*buf)		\
> > +{									\
> > +	return early=5Frestrict=5Fproc=5Fmem(buf, offset);			\
> > +}									\
> > +early=5Fparam("restrict=5Fproc=5Fmem=5F" #name, early=5Frestrict=5F=
proc=5Fmem=5F##name)
> > +
> > +DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(write, 0);
> > +DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(read, 2);
> > +DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(foll=5Fforce, 4);
>=20
> #define DEFINE=5FEARLY=5FPROC=5FMEM=5FRESTRICT(name)				\
> static int =5F=5Finit early=5Fproc=5Fmem=5Frestrict=5F##name(char *bu=
f)		\
> {									\
> 	if (!buf)							\
> 		return -EINVAL;						\
> 									\
> 	if (strcmp(buf, "all") =3D=3D 0)					\
> 		static=5Fbranch=5Fenable(&proc=5Fmem=5Frestrict=5F##name);	\
> 	else if (strcmp(buf, "ptracer") =3D=3D 0)				\
> 		static=5Fbranch=5Fenable(&proc=5Fmem=5Frestrict=5F##name);	\
> 									\
> 	return 0;							\
> }									\
> early=5Fparam("proc=5Fmem=5Frestrict=5F" #name, early=5Fproc=5Fmem=5F=
restrict=5F##name)
>=20
>=20
> > +
> >  /*
> >   * Count the number of hardlinks for the pid=5Fentry table, exclud=
ing the .
> >   * and .. links.
> > @@ -825,9 +860,58 @@ static int =5F=5Fmem=5Fopen(struct inode *inod=
e, struct file *file, unsigned int mode)
> >  	return 0;
> >  }
> > =20
> > +static bool =5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(struct file =
*file)
> > +{
> > +	struct inode *inode =3D file=5Finode(file);
> > +	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> > +	int ret =3D false;
> > +
> > +	if (task) {
> > +		rcu=5Fread=5Flock();
> > +		if (current =3D=3D ptrace=5Fparent(task))
> > +			ret =3D true;
> > +		rcu=5Fread=5Funlock();
> > +		put=5Ftask=5Fstruct(task);
> > +	}
>=20
> This creates a ToCToU race between this check (which releases the tas=
k)
> and the later memopen which make get a different task (and mm).

Especially thanks for noticing I introduced this in v3!

It was an accident, my mistake :)

I'll pay close attention to fixing this in v4, will come back if any qu=
estions.

>=20
> To deal with this, I think you need to add a new mode flag for
> proc=5Fmem=5Fopen(), and add the checking there.
>=20
> > +
> > +	return ret;
> > +}
> > +
> > +static int =5F=5Fmem=5Fopen=5Fcheck=5Faccess=5Frestriction(struct =
file *file)
> > +{
> > +	if (file->f=5Fmode & FMODE=5FWRITE) {
> > +		/* Deny if writes are unconditionally disabled via param */
> > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[0]))
> > +			return -EACCES;
> > +
> > +		/* Deny if writes are allowed only for ptracers via param */
> > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[1]) &&
> > +		    !=5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(file))
> > +			return -EACCES;
> > +
> > +	} else if (file->f=5Fmode & FMODE=5FREAD) {
>=20
> I think this "else" means that O=5FRDWR opens will only check the wri=
te
> flag, so drop the "else".
>=20
> > +		/* Deny if reads are unconditionally disabled via param */
> > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[2]))
> > +			return -EACCES;
> > +
> > +		/* Deny if reads are allowed only for ptracers via param */
> > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[3]) &&
> > +		    !=5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(file))
> > +			return -EACCES;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mem=5Fopen(struct inode *inode, struct file *file)
> >  {
> > -	int ret =3D =5F=5Fmem=5Fopen(inode, file, PTRACE=5FMODE=5FATTACH)=
;
> > +	int ret;
> > +
> > +	ret =3D =5F=5Fmem=5Fopen=5Fcheck=5Faccess=5Frestriction(file);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D =5F=5Fmem=5Fopen(inode, file, PTRACE=5FMODE=5FATTACH);
> > =20
> >  	/* OK to pass negative loff=5Ft, we can catch out-of-range */
> >  	file->f=5Fmode |=3D FMODE=5FUNSIGNED=5FOFFSET;
> > @@ -835,6 +919,20 @@ static int mem=5Fopen(struct inode *inode, str=
uct file *file)
> >  	return ret;
> >  }
> > =20
> > +static unsigned int =5F=5Fmem=5Frw=5Fget=5Ffoll=5Fforce=5Fflag(str=
uct file *file)
> > +{
> > +	/* Deny if FOLL=5FFORCE is disabled via param */
> > +	if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[4]))
> > +		return 0;
> > +
> > +	/* Deny if FOLL=5FFORCE is allowed only for ptracers via param */
> > +	if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[5]) &&
> > +	    !=5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(file))
>=20
> This is like the ToCToU: the task may have changed out from under us
> between the open the read/write.
>=20
> I'm not sure how to store this during "open" though... Hmmm
>=20
> > +		return 0;
> > +
> > +	return FOLL=5FFORCE;
> > +}
> > +
> >  static ssize=5Ft mem=5Frw(struct file *file, char =5F=5Fuser *buf,
> >  			size=5Ft count, loff=5Ft *ppos, int write)
> >  {
> > @@ -855,7 +953,8 @@ static ssize=5Ft mem=5Frw(struct file *file, ch=
ar =5F=5Fuser *buf,
> >  	if (!mmget=5Fnot=5Fzero(mm))
> >  		goto free;
> > =20
> > -	flags =3D FOLL=5FFORCE | (write ? FOLL=5FWRITE : 0);
> > +	flags =3D (write ? FOLL=5FWRITE : 0);
> > +	flags |=3D =5F=5Fmem=5Frw=5Fget=5Ffoll=5Fforce=5Fflag(file);
>=20
> I wonder if we need some way to track openers in the mm? That sounds
> not-fun.
>=20
> > =20
> >  	while (count > 0) {
> >  		size=5Ft this=5Flen =3D min=5Ft(size=5Ft, count, PAGE=5FSIZE);
> > diff --git a/include/linux/jump=5Flabel.h b/include/linux/jump=5Fla=
bel.h
> > index f5a2727ca4a9a..ba2460fe878c5 100644
> > --- a/include/linux/jump=5Flabel.h
> > +++ b/include/linux/jump=5Flabel.h
> > @@ -398,6 +398,11 @@ struct static=5Fkey=5Ffalse {
> >  		[0 ... (count) - 1] =3D STATIC=5FKEY=5FFALSE=5FINIT,	\
> >  	}
> > =20
> > +#define DEFINE=5FSTATIC=5FKEY=5FARRAY=5FFALSE=5FRO(name, count)		\
> > +	struct static=5Fkey=5Ffalse name[count] =5F=5Fro=5Fafter=5Finit =3D=
 {	\
> > +		[0 ... (count) - 1] =3D STATIC=5FKEY=5FFALSE=5FINIT,	\
> > +	}
>=20
> Let's not add this. :)
>=20
> > +
> >  #define =5FDEFINE=5FSTATIC=5FKEY=5F1(name)	DEFINE=5FSTATIC=5FKEY=5F=
TRUE(name)
> >  #define =5FDEFINE=5FSTATIC=5FKEY=5F0(name)	DEFINE=5FSTATIC=5FKEY=5F=
FALSE(name)
> >  #define DEFINE=5FSTATIC=5FKEY=5FMAYBE(cfg, name)			\
>=20
> So, yes, conceptually, I really like this -- we've got some good
> granularity now, and wow do I love being able to turn off FOLL=5FFORC=
E.  :)
>=20
> Safely checking for ptracer is tricky, though. I wonder how we could
> store the foll=5Fforce state in the private=5Fdata somehow. Seems a b=
it
> painful to allocate a struct for it. We could do some really horrid
> hacks like store it in the low bit of the mm address that gets stored=
 to
> private=5Fdata and mask it out when used, but that's really ugly too.=
..
>=20
> -Kees
>=20
> --=20
> Kees Cook


