Return-Path: <linux-fsdevel+bounces-19518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C038C655E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D15F28331A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815E6EB45;
	Wed, 15 May 2024 11:15:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4758AC3;
	Wed, 15 May 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771709; cv=none; b=rYiIfXxP7ct2nzNIoDTET9I5DQYpApBgXg+XU77rnA2P7/ewqOJXMGGI0jesjFEy9GpZjlnDQ5IEAM8qhNig94yPh/tKnfTLEDzfmmnf3XE7jMxxmUI7bDvLNIErrISpmZg+Wto+f1vncl91xeLafNlEcnEupZhkm9+yE2OMF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771709; c=relaxed/simple;
	bh=L7vQUyXOJkNK0AYuGYmtPGMV6piarpkbCvJgTd5Tpzk=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=lJ7YrfjQ1I5WY9hlK2QD+XFgGL7EbCAjJPwwgD3zFW2uecJzyCQrPXTGTg4KnXRsBUcpPY/s9sxoCIjQUrnClYxDxsaJb5tMEPvaq/QD25R2f/yvKZK9vMZKIjoK078CIOSDLY0QkDxab84BOXLjZOdUcH0k1iiSS0C+al7mBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 84769378143B;
	Wed, 15 May 2024 11:15:04 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202405131641.219CD40A62@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240409175750.206445-1-adrian.ratiu@collabora.com>
 <202404261544.1EAD63D@keescook>
 <20240503-nulltarif-karten-82213463dedc@brauner> <202405131641.219CD40A62@keescook>
Date: Wed, 15 May 2024 12:15:04 +0100
Cc: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <144e19-66449900-1-6b6f9280@13589130>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 1/2] =?utf-8?q?proc=3A?= restrict /proc/pid/mem 
 access via param knobs
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 14, 2024 02:50 EEST, Kees Cook <keescook@chromium.org> =
wrote:

> On Fri, May 03, 2024 at 11:57:56AM +0200, Christian Brauner wrote:
> > On Fri, Apr 26, 2024 at 04:10:49PM -0700, Kees Cook wrote:
> > > On Tue, Apr 09, 2024 at 08:57:49PM +0300, Adrian Ratiu wrote:
> > > > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted=
,
> > > > after which it got allowed in commit 198214a7ee50 ("proc: enabl=
e
> > > > writing to /proc/pid/mem"). Famous last words from that patch:
> > > > "no longer a security hazard". :)
> > > >=20
> > > > Afterwards exploits started causing drama like [1]. The exploit=
s
> > > > using /proc/*/mem can be rather sophisticated like [2] which
> > > > installed an arbitrary payload from noexec storage into a runni=
ng
> > > > process then exec'd it, which itself could include an ELF loade=
r
> > > > to run arbitrary code off noexec storage.
> > > >=20
> > > > One of the well-known problems with /proc/*/mem writes is they
> > > > ignore page permissions via FOLL=5FFORCE, as opposed to writes =
via
> > > > process=5Fvm=5Fwritev which respect page permissions. These wri=
tes can
> > > > also be used to bypass mode bits.
> > > >=20
> > > > To harden against these types of attacks, distrbutions might wa=
nt
> > > > to restrict /proc/pid/mem accesses, either entirely or partiall=
y,
> > > > for eg. to restrict FOLL=5FFORCE usage.
> > > >=20
> > > > Known valid use-cases which still need these accesses are:
> > > >=20
> > > > * Debuggers which also have ptrace permissions, so they can acc=
ess
> > > > memory anyway via PTRACE=5FPOKEDATA & co. Some debuggers like G=
DB
> > > > are designed to write /proc/pid/mem for basic functionality.
> > > >=20
> > > > * Container supervisors using the seccomp notifier to intercept
> > > > syscalls and rewrite memory of calling processes by passing
> > > > around /proc/pid/mem file descriptors.
> > > >=20
> > > > There might be more, that's why these params default to disable=
d.
> > > >=20
> > > > Regarding other mechanisms which can block these accesses:
> > > >=20
> > > > * seccomp filters can be used to block mmap/mprotect calls with=
 W|X
> > > > perms, but they often can't block open calls as daemons want to
> > > > read/write their runtime state and seccomp filters cannot check
> > > > file paths, so plain write calls can't be easily blocked.
> > > >=20
> > > > * Since the mem file is part of the dynamic /proc/<pid>/ space,=
 we
> > > > can't run chmod once at boot to restrict it (and trying to reac=
t
> > > > to every process and run chmod doesn't scale, and the kernel no
> > > > longer allows chmod on any of these paths).
> > > >=20
> > > > * SELinux could be used with a rule to cover all /proc/*/mem fi=
les,
> > > > but even then having multiple ways to deny an attack is useful =
in
> > > > case one layer fails.
> > > >=20
> > > > Thus we introduce three kernel parameters to restrict /proc/*/m=
em
> > > > access: read, write and foll=5Fforce. All three can be independ=
ently
> > > > set to the following values:
> > > >=20
> > > > all     =3D> restrict all access unconditionally.
> > > > ptracer =3D> restrict all access except for ptracer processes.
> > > >=20
> > > > If left unset, the existing behaviour is preserved, i.e. access
> > > > is governed by basic file permissions.
> > > >=20
> > > > Examples which can be passed by bootloaders:
> > > >=20
> > > > restrict=5Fproc=5Fmem=5Ffoll=5Fforce=3Dall
> > > > restrict=5Fproc=5Fmem=5Fwrite=3Dptracer
> > > > restrict=5Fproc=5Fmem=5Fread=3Dptracer
> > > >=20
> > > > Each distribution needs to decide what restrictions to apply,
> > > > depending on its use-cases. Embedded systems might want to do
> > > > more, while general-purpouse distros might want a more relaxed
> > > > policy, because for e.g. foll=5Fforce=3Dall and write=3Dall bot=
h break
> > > > break GDB, so it might be a bit excessive.
> > > >=20
> > > > Based on an initial patch by Mike Frysinger <vapier@chromium.or=
g>.
> > >=20
> > > Thanks for this new version!
> > >=20
> > > >=20
> > > > Link: https://lwn.net/Articles/476947/ [1]
> > > > Link: https://issues.chromium.org/issues/40089045 [2]
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
> > > >  .../admin-guide/kernel-parameters.txt         |  27 +++++
> > > >  fs/proc/base.c                                | 103 ++++++++++=
+++++++-
> > > >  include/linux/jump=5Flabel.h                    |   5 +
> > > >  3 files changed, 133 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/=
Documentation/admin-guide/kernel-parameters.txt
> > > > index 6e62b8cb19c8d..d7f7db41369c7 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -5665,6 +5665,33 @@
> > > >  	reset=5Fdevices	[KNL] Force drivers to reset the underlying d=
evice
> > > >  			during initialization.
> > > > =20
> > > > +	restrict=5Fproc=5Fmem=5Fread=3D [KNL]
> > > > +			Format: {all | ptracer}
> > > > +			Allows restricting read access to /proc/*/mem files.
> > > > +			Depending on restriction level, open for reads return -EACC=
ESS.
> > > > +			Can be one of:
> > > > +			- 'all' restricts all access unconditionally.
> > > > +			- 'ptracer' allows access only for ptracer processes.
> > > > +			If not specified, then basic file permissions continue to a=
pply.
> > > > +
> > > > +	restrict=5Fproc=5Fmem=5Fwrite=3D [KNL]
> > > > +			Format: {all | ptracer}
> > > > +			Allows restricting write access to /proc/*/mem files.
> > > > +			Depending on restriction level, open for writes return -EAC=
CESS.
> > > > +			Can be one of:
> > > > +			- 'all' restricts all access unconditionally.
> > > > +			- 'ptracer' allows access only for ptracer processes.
> > > > +			If not specified, then basic file permissions continue to a=
pply.
> > > > +
> > > > +	restrict=5Fproc=5Fmem=5Ffoll=5Fforce=3D [KNL]
> > > > +			Format: {all | ptracer}
> > > > +			Restricts the use of the FOLL=5FFORCE flag for /proc/*/mem =
access.
> > > > +			If restricted, the FOLL=5FFORCE flag will not be added to v=
m accesses.
> > > > +			Can be one of:
> > > > +			- 'all' restricts all access unconditionally.
> > > > +			- 'ptracer' allows access only for ptracer processes.
> > > > +			If not specified, FOLL=5FFORCE is always used.
> > >=20
> > > bike shedding: I wonder if this should be a fake namespace (addin=
g a dot
> > > just to break it up for reading more easily), and have words reor=
dered
> > > to the kernel's more common subject-verb-object: proc=5Fmem.restr=
ict=5Fread=3D...
> > >=20
> > > > +
> > > >  	resume=3D		[SWSUSP]
> > > >  			Specify the partition device for software suspend
> > > >  			Format:
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index 18550c071d71c..c733836c42a65 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -152,6 +152,41 @@ struct pid=5Fentry {
> > > >  		NULL, &proc=5Fpid=5Fattr=5Foperations,	\
> > > >  		{ .lsmid =3D LSMID })
> > > > =20
> > > > +/*
> > > > + * each restrict=5Fproc=5Fmem=5F* param controls the following=
 static branches:
> > > > + * key[0] =3D restrict all writes
> > > > + * key[1] =3D restrict writes except for ptracers
> > > > + * key[2] =3D restrict all reads
> > > > + * key[3] =3D restrict reads except for ptracers
> > > > + * key[4] =3D restrict all FOLL=5FFORCE usage
> > > > + * key[5] =3D restrict FOLL=5FFORCE usage except for ptracers
> > > > + */
> > > > +DEFINE=5FSTATIC=5FKEY=5FARRAY=5FFALSE=5FRO(restrict=5Fproc=5Fm=
em, 6);
> > >=20
> > > So, I don't like having open-coded numbers. And I'm not sure ther=
e's a
> > > benefit to stuffing these all into an array? So:
> > >=20
> > > DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fread);
> > > DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fwrite)=
;
> > > DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Ffoll=5F=
force);
> > >=20
> > > > +
> > > > +static int =5F=5Finit early=5Frestrict=5Fproc=5Fmem(char *buf,=
 int offset)
> > > > +{
> > > > +	if (!buf)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (strncmp(buf, "all", 3) =3D=3D 0)
> > >=20
> > > I'd use strcmp() to get exact matches. That way "allalksdjflas" d=
oesn't
> > > match. :)
> > >=20
> > > > +		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem[offset]);
> > > > +	else if (strncmp(buf, "ptracer", 7) =3D=3D 0)
> > > > +		static=5Fbranch=5Fenable(&restrict=5Fproc=5Fmem[offset + 1])=
;
> > > > +
> > > > +	return 0;
> > > > +}
> > >=20
> > > Then don't bother with a common helper since you've got a macro, =
and
> > > it'll all get tossed after =5F=5Finit anyway.
> > >=20
> > > > +
> > > > +#define DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(name, offset)		=
	\
> > > > +static int =5F=5Finit early=5Frestrict=5Fproc=5Fmem=5F##name(c=
har *buf)		\
> > > > +{									\
> > > > +	return early=5Frestrict=5Fproc=5Fmem(buf, offset);			\
> > > > +}									\
> > > > +early=5Fparam("restrict=5Fproc=5Fmem=5F" #name, early=5Frestri=
ct=5Fproc=5Fmem=5F##name)
> > > > +
> > > > +DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(write, 0);
> > > > +DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(read, 2);
> > > > +DEFINE=5FEARLY=5FRESTRICT=5FPROC=5FMEM(foll=5Fforce, 4);
> > >=20
> > > #define DEFINE=5FEARLY=5FPROC=5FMEM=5FRESTRICT(name)				\
> > > static int =5F=5Finit early=5Fproc=5Fmem=5Frestrict=5F##name(char=
 *buf)		\
> > > {									\
> > > 	if (!buf)							\
> > > 		return -EINVAL;						\
> > > 									\
> > > 	if (strcmp(buf, "all") =3D=3D 0)					\
> > > 		static=5Fbranch=5Fenable(&proc=5Fmem=5Frestrict=5F##name);	\
> > > 	else if (strcmp(buf, "ptracer") =3D=3D 0)				\
> > > 		static=5Fbranch=5Fenable(&proc=5Fmem=5Frestrict=5F##name);	\
> > > 									\
> > > 	return 0;							\
> > > }									\
> > > early=5Fparam("proc=5Fmem=5Frestrict=5F" #name, early=5Fproc=5Fme=
m=5Frestrict=5F##name)
> > >=20
> > >=20
> > > > +
> > > >  /*
> > > >   * Count the number of hardlinks for the pid=5Fentry table, ex=
cluding the .
> > > >   * and .. links.
> > > > @@ -825,9 +860,58 @@ static int =5F=5Fmem=5Fopen(struct inode *=
inode, struct file *file, unsigned int mode)
> > > >  	return 0;
> > > >  }
> > > > =20
> > > > +static bool =5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(struct f=
ile *file)
> > > > +{
> > > > +	struct inode *inode =3D file=5Finode(file);
> > > > +	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> > > > +	int ret =3D false;
> > > > +
> > > > +	if (task) {
> > > > +		rcu=5Fread=5Flock();
> > > > +		if (current =3D=3D ptrace=5Fparent(task))
> > > > +			ret =3D true;
> > > > +		rcu=5Fread=5Funlock();
> > > > +		put=5Ftask=5Fstruct(task);
> > > > +	}
> > >=20
> > > This creates a ToCToU race between this check (which releases the=
 task)
> > > and the later memopen which make get a different task (and mm).
> > >=20
> > > To deal with this, I think you need to add a new mode flag for
> > > proc=5Fmem=5Fopen(), and add the checking there.
> > >=20
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int =5F=5Fmem=5Fopen=5Fcheck=5Faccess=5Frestriction(str=
uct file *file)
> > > > +{
> > > > +	if (file->f=5Fmode & FMODE=5FWRITE) {
> > > > +		/* Deny if writes are unconditionally disabled via param */
> > > > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[0]))
> > > > +			return -EACCES;
> > > > +
> > > > +		/* Deny if writes are allowed only for ptracers via param */
> > > > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[1]) &&
> > > > +		    !=5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(file))
> > > > +			return -EACCES;
> > > > +
> > > > +	} else if (file->f=5Fmode & FMODE=5FREAD) {
> > >=20
> > > I think this "else" means that O=5FRDWR opens will only check the=
 write
> > > flag, so drop the "else".
> > >=20
> > > > +		/* Deny if reads are unconditionally disabled via param */
> > > > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[2]))
> > > > +			return -EACCES;
> > > > +
> > > > +		/* Deny if reads are allowed only for ptracers via param */
> > > > +		if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[3]) &&
> > > > +		    !=5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(file))
> > > > +			return -EACCES;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int mem=5Fopen(struct inode *inode, struct file *file)
> > > >  {
> > > > -	int ret =3D =5F=5Fmem=5Fopen(inode, file, PTRACE=5FMODE=5FATT=
ACH);
> > > > +	int ret;
> > > > +
> > > > +	ret =3D =5F=5Fmem=5Fopen=5Fcheck=5Faccess=5Frestriction(file)=
;
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D =5F=5Fmem=5Fopen(inode, file, PTRACE=5FMODE=5FATTACH)=
;
> > > > =20
> > > >  	/* OK to pass negative loff=5Ft, we can catch out-of-range */
> > > >  	file->f=5Fmode |=3D FMODE=5FUNSIGNED=5FOFFSET;
> > > > @@ -835,6 +919,20 @@ static int mem=5Fopen(struct inode *inode,=
 struct file *file)
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > +static unsigned int =5F=5Fmem=5Frw=5Fget=5Ffoll=5Fforce=5Fflag=
(struct file *file)
> > > > +{
> > > > +	/* Deny if FOLL=5FFORCE is disabled via param */
> > > > +	if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[4]))
> > > > +		return 0;
> > > > +
> > > > +	/* Deny if FOLL=5FFORCE is allowed only for ptracers via para=
m */
> > > > +	if (static=5Fbranch=5Funlikely(&restrict=5Fproc=5Fmem[5]) &&
> > > > +	    !=5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(file))
> > >=20
> > > This is like the ToCToU: the task may have changed out from under=
 us
> > > between the open the read/write.
> >=20
> > But why would you care? As long as the task is the ptracer it doesn=
't
> > really matter afaict.
>=20
> Because the mm you're writing to may no longer be associated with the
> task.
>=20
> proc=5Fmem=5Foperations.open() will take a reference to the current t=
ask's
> mm, via proc=5Fmem=5Fopen() through =5F=5Fmem=5Fopen():
>=20
>         struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> 	...
> 	mm =3D mm=5Faccess(task, mode | PTRACE=5FMODE=5FFSCREDS);
> 	...
> 	file->private=5Fdata =3D mm;
>=20
>=20
> And in the proposed check added to mem=5Frw(), if get=5Fproc=5Ftask(i=
node)
> returns a different task (i.e. the pid got recycled and the original =
mm
> is still associated with a forked task), then it could write to the
> forked task using the ptrace check against the new task.
>=20
> Looking at it again now, I think it should be possible to just revali=
date
> the mm in =5F=5Fmem=5Fopen=5Fcurrent=5Fis=5Fptracer(), though. i.e. i=
t would be
> allowed if ptrace check passes and file->private=5Fdata =3D=3D mm=5Fa=
ccess(...),
> for the mem=5Frw case...

Ack, I'll do this in v4, thanks again!


