Return-Path: <linux-fsdevel+bounces-21555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B21905A81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781F61C20ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBB18307F;
	Wed, 12 Jun 2024 18:13:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32E1822F3;
	Wed, 12 Jun 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216026; cv=none; b=kqtizF+CM7sSk1l6GU7NIRE2ALwjSxPVZIOud5TjUNQ4wJU6EYvbBPvGY3KFPoG+OHa+MoBjmkzLHO3hM1lXghI5ZJxq8TdkUG+zDDKRoC6vaAeNDJ0VHIqp1ERRLT12W4NCGXlfH28yhfCdReIJf4sTM8C2o2RjuJrGGSZfkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216026; c=relaxed/simple;
	bh=cZp+m7GoUyD511OLhwA5NzHdSoU4z+QAg2M2yrL4/y0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=dAbu+Xy4moMWf4T2MiCDU45OX8JFFdV5XrOQaeKhC8arJma4XYumLah1/RurXpG/riP/0N/wP00+ZXN6GHOLNYAo7SXXJ7Iw6Qi0hGXdnHs+n+HJx1fILoRtVagHm+kDFtucIMjYdoWZh42kjYPp8NsoiRGKeG/kkm+eODdrISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id DB9E03781139;
	Wed, 12 Jun 2024 18:13:41 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202406060917.8DEE8E3@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240605164931.3753-1-adrian.ratiu@collabora.com>
 <20240605164931.3753-2-adrian.ratiu@collabora.com> <202406060917.8DEE8E3@keescook>
Date: Wed, 12 Jun 2024 19:13:41 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Christian Brauner" <brauner@kernel.org>, "Jeff Xu" <jeffxu@google.com>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3304e0-6669e580-9f9-33d83680@155585222>
Subject: =?utf-8?q?Re=3A?= [PATCH v5 2/2] =?utf-8?q?proc=3A?= restrict /proc/pid/mem
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Thursday, June 06, 2024 20:45 EEST, Kees Cook <kees@kernel.org> wrot=
e:

> On Wed, Jun 05, 2024 at 07:49:31PM +0300, Adrian Ratiu wrote:
> > +	proc=5Fmem.restrict=5Ffoll=5Fforce=3D [KNL]
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
> It dawns on me that we likely need an "off" setting for these in case=
 it
> was CONFIG-enabled...
>=20
> > +static int =5F=5Finit early=5Fproc=5Fmem=5Frestrict=5F##name(char =
*buf)			\
> > +{										\
> > +	if (!buf)								\
> > +		return -EINVAL;							\
> > +										\
> > +	if (strcmp(buf, "all") =3D=3D 0)						\
> > +		static=5Fkey=5Fslow=5Finc(&proc=5Fmem=5Frestrict=5F##name##=5Fal=
l.key);	\
> > +	else if (strcmp(buf, "ptracer") =3D=3D 0)					\
> > +		static=5Fkey=5Fslow=5Finc(&proc=5Fmem=5Frestrict=5F##name##=5Fpt=
racer.key);	\
> > +	return 0;								\
> > +}										\
> > +early=5Fparam("proc=5Fmem.restrict=5F" #name, early=5Fproc=5Fmem=5F=
restrict=5F##name)
>=20
> Why slow=5Finc here instead of the normal static=5Fkey=5Fenable/disab=
le?
>=20
> And we should report misparsing too, so perhaps:
>=20
> static int =5F=5Finit early=5Fproc=5Fmem=5Frestrict=5F##name(char *bu=
f)			\
> {										\
> 	if (!buf)								\
> 		return -EINVAL;							\
> 										\
> 	if (strcmp(buf, "all") =3D=3D 0) {						\
> 		static=5Fkey=5Fenable(&proc=5Fmem=5Frestrict=5F##name##=5Fall.key);=
		\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fptracer.=
key);	\
> 	} else if (strcmp(buf, "ptracer") =3D=3D 0) {				\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fall.key)=
;	\
> 		static=5Fkey=5Fenable(&proc=5Fmem=5Frestrict=5F##name##=5Fptracer.k=
ey);	\
> 	} else if (strcmp(buf, "off") =3D=3D 0) {					\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fall.key)=
;	\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fptracer.=
key);	\
> 	} else									\
> 		pr=5Fwarn("%s: ignoring unknown option '%s'\n",			\
> 			"proc=5Fmem.restrict=5F" #name, buf);			\
> 	return 0;								\
> }										\
> early=5Fparam("proc=5Fmem.restrict=5F" #name, early=5Fproc=5Fmem=5Fre=
strict=5F##name)
>=20
> > +static int =5F=5Fmem=5Fopen=5Faccess=5Fpermitted(struct file *file=
, struct task=5Fstruct *task)
> > +{
> > +	bool is=5Fptracer;
> > +
> > +	rcu=5Fread=5Flock();
> > +	is=5Fptracer =3D current =3D=3D ptrace=5Fparent(task);
> > +	rcu=5Fread=5Funlock();
> > +
> > +	if (file->f=5Fmode & FMODE=5FWRITE) {
> > +		/* Deny if writes are unconditionally disabled via param */
> > +		if (static=5Fbranch=5Fmaybe(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPE=
N=5FWRITE=5FDEFAULT,
> > +					&proc=5Fmem=5Frestrict=5Fopen=5Fwrite=5Fall))
> > +			return -EACCES;
> > +
> > +		/* Deny if writes are allowed only for ptracers via param */
> > +		if (static=5Fbranch=5Fmaybe(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPE=
N=5FWRITE=5FPTRACE=5FDEFAULT,
> > +					&proc=5Fmem=5Frestrict=5Fopen=5Fwrite=5Fptracer) &&
> > +		    !is=5Fptracer)
> > +			return -EACCES;
> > +	}
> > +
> > +	if (file->f=5Fmode & FMODE=5FREAD) {
> > +		/* Deny if reads are unconditionally disabled via param */
> > +		if (static=5Fbranch=5Fmaybe(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPE=
N=5FREAD=5FDEFAULT,
> > +					&proc=5Fmem=5Frestrict=5Fopen=5Fread=5Fall))
> > +			return -EACCES;
> > +
> > +		/* Deny if reads are allowed only for ptracers via param */
> > +		if (static=5Fbranch=5Fmaybe(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPE=
N=5FREAD=5FPTRACE=5FDEFAULT,
> > +					&proc=5Fmem=5Frestrict=5Fopen=5Fread=5Fptracer) &&
> > +		    !is=5Fptracer)
> > +			return -EACCES;
> > +	}
> > +
> > +	return 0; /* R/W are not restricted */
> > +}
>=20
> Given how deeply some of these behaviors may be in userspace, it migh=
t
> be more friendly to report the new restrictions with a pr=5Fnotice() =
so
> problems can be more easily tracked down. For example:
>=20
> static void report=5Fmem=5Frw=5Frejection(const char *action, struct =
task=5Fstruct *task)
> {
> 	pr=5Fwarn=5Fratelimited("Denied %s of /proc/%d/mem (%s) by pid %d (%=
s)\n",
> 			    action, task=5Fpid=5Fnr(task), task->comm,
> 			    task=5Fpid=5Fnr(current), current->comm);
> }
>=20
> ...
>=20
> 	if (file->f=5Fmode & FMODE=5FWRITE) {
> 		/* Deny if writes are unconditionally disabled via param */
> 		if (static=5Fbranch=5Fmaybe(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5F=
WRITE=5FDEFAULT,
> 					&proc=5Fmem=5Frestrict=5Fopen=5Fwrite=5Fall)) {
> 			report=5Fmem=5Frw=5Freject("all open-for-write");
> 			return -EACCES;
> 		}
>=20
> 		/* Deny if writes are allowed only for ptracers via param */
> 		if (static=5Fbranch=5Fmaybe(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5F=
WRITE=5FPTRACE=5FDEFAULT,
> 					&proc=5Fmem=5Frestrict=5Fopen=5Fwrite=5Fptracer) &&
> 		    !is=5Fptracer)
> 			report=5Fmem=5Frw=5Freject("non-ptracer open-for-write");
> 			return -EACCES;
> 	}
>=20
> etc
>=20
> > +static bool =5F=5Fmem=5Frw=5Fcurrent=5Fis=5Fptracer(struct file *f=
ile)
> > +{
> > +	struct inode *inode =3D file=5Finode(file);
> > +	struct task=5Fstruct *task =3D get=5Fproc=5Ftask(inode);
> > +	struct mm=5Fstruct *mm =3D NULL;
> > +	int is=5Fptracer =3D false, has=5Fmm=5Faccess =3D false;
> > +
> > +	if (task) {
> > +		rcu=5Fread=5Flock();
> > +		is=5Fptracer =3D current =3D=3D ptrace=5Fparent(task);
> > +		rcu=5Fread=5Funlock();
> > +
> > +		mm =3D mm=5Faccess(task, PTRACE=5FMODE=5FREAD=5FFSCREDS);
> > +		if (mm && file->private=5Fdata =3D=3D mm) {
> > +			has=5Fmm=5Faccess =3D true;
> > +			mmput(mm);
> > +		}
> > +
> > +		put=5Ftask=5Fstruct(task);
> > +	}
> > +
> > +	return is=5Fptracer && has=5Fmm=5Faccess;
> > +}
>=20
> Thanks; this looks right to me now!
>=20
> > +menu "Procfs mem restriction options"
> > +
> > +config PROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FDEFAULT
> > +	bool "Restrict all FOLL=5FFORCE flag usage"
> > +	default n
> > +	help
> > +	  Restrict all FOLL=5FFORCE usage during /proc/*/mem RW.
> > +	  Debuggers like GDB require using FOLL=5FFORCE for basic
> > +	  functionality.
> > +
> > +config PROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FPTRACE=5FDEFAULT
> > +	bool "Restrict FOLL=5FFORCE usage except for ptracers"
> > +	default n
> > +	help
> > +	  Restrict FOLL=5FFORCE usage during /proc/*/mem RW, except
> > +	  for ptracer processes. Debuggers like GDB require using
> > +	  FOLL=5FFORCE for basic functionality.
>=20
> Can we adjust the Kconfigs to match the bootparam arguments? i.e.
> instead of two for each mode, how about one with 3 settings ("all",
> "ptrace", or "off")
>=20
> choice
> 	prompt "Restrict /proc/pid/mem FOLL=5FFORCE usage"
> 	default PROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FOFF
> 	help
> 	  Reading and writing of /proc/pid/mem bypasses memory permission
> 	  checks due to the internal use of the FOLL=5FFORCE flag. This can =
be
> 	  used by attackers to manipulate process memory contents that
> 	  would have been otherwise protected. However, debuggers, like GDB,
> 	  use this to set breakpoints, etc. To force debuggers to fall back
> 	  to PEEK/POKE, see PROC=5FMEM=5FRESTRICT=5FOPEN=5FWRITE=5FALL.
>=20
> 	config PROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FOFF
> 	bool "Do not restrict FOLL=5FFORCE usage with /proc/pid/mem (regular=
)"
> 	help
> 	  Regular behavior: continue to use the FOLL=5FFORCE flag for
> 	  /proc/pid/mem access.
>=20
> 	config PROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FPTRACE
> 	bool "Only allow ptracers to use FOLL=5FFORCE with /proc/pid/mem (sa=
fer)"
> 	help
> 	  Only use the FOLL=5FFORCE flag for /proc/pid/mem access when the
> 	  current task is the active ptracer of the target task. (Safer,
> 	  least disruptive to most usage patterns.)
>=20
> 	config PROC=5FMEM=5FRESTRICT=5FFOLL=5FFORCE=5FALL
> 	bool "Do not use FOLL=5FFORCE with /proc/pid/mem (safest)"
> 	help
> 	  Remove the FOLL=5FFORCE flag for all /proc/pid/mem accesses.
> 	  (Safest, but may be disruptive to some usage patterns.)
> endchoice
>=20
> Then the static=5Fkeys can be defined like this mess (I couldn't find=
 a
> cleaner way to do it):
>=20
> #define DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FALL(name) \
> 	DEFINE=5FSTATIC=5FKEY=5FTRUE=5FRO(proc=5Fmem=5Frestrict=5F##name##=5F=
all);	\
> 	DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5F##name##=5F=
ptracer);
> #define DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FPTRACE(name) \
> 	DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5F##name##=5F=
all);	\
> 	DEFINE=5FSTATIC=5FKEY=5FTRUE=5FRO(proc=5Fmem=5Frestrict=5F##name##=5F=
ptracer);
> #define DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FOFF(name) \
> 	DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5F##name##=5F=
all);	\
> 	DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5F##name##=5F=
ptracer);
>=20
> #define DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5F0(level, name)
> #define DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5F1(level, name)		\
> 	DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5F##level(name)
>=20
> #define =5FDEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FPICK(enabled, level, =
name)   \
> DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5F##enabled(level, name)
>=20
> #define DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FPICK(enabled, level, nam=
e)   \
> =5FDEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FPICK(enabled, level, name)
>=20
> #define DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM(CFG, name)			\
> DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FPICK(IS=5FENABLED(CONFIG=5FPROC=5F=
MEM=5FRESTRICT=5F##CFG##=5FALL), ALL, name)
> DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FPICK(IS=5FENABLED(CONFIG=5FPROC=5F=
MEM=5FRESTRICT=5F##CFG##=5FPTRACE), PTRACE, name)
> DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM=5FPICK(IS=5FENABLED(CONFIG=5FPROC=5F=
MEM=5FRESTRICT=5F##CFG##=5FOFF), OFF, name)
>=20
> #define DEFINE=5FEARLY=5FPROC=5FMEM=5FRESTRICT(CFG, name)				\
> DEFINE=5FSTATIC=5FKEY=5FPROC=5FMEM(CFG, name)						\
> static int =5F=5Finit early=5Fproc=5Fmem=5Frestrict=5F##name(char *bu=
f)			\
> {										\
> 	if (!buf)								\
> 		return -EINVAL;							\
> 										\
> 	if (strcmp(buf, "all") =3D=3D 0) {						\
> 		static=5Fkey=5Fenable(&proc=5Fmem=5Frestrict=5F##name##=5Fall.key);=
		\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fptracer.=
key);	\
> 	} else if (strcmp(buf, "ptracer") =3D=3D 0) {				\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fall.key)=
;	\
> 		static=5Fkey=5Fenable(&proc=5Fmem=5Frestrict=5F##name##=5Fptracer.k=
ey);	\
> 	} else if (strcmp(buf, "off") =3D=3D 0) {					\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fall.key)=
;	\
> 		static=5Fkey=5Fdisable(&proc=5Fmem=5Frestrict=5F##name##=5Fptracer.=
key);	\
> 	} else									\
> 		pr=5Fwarn("%s: ignoring unknown option '%s'\n",			\
> 			"proc=5Fmem.restrict=5F" #name, buf);			\
> 	return 0;								\
> }										\
> early=5Fparam("proc=5Fmem.restrict=5F" #name, early=5Fproc=5Fmem=5Fre=
strict=5F##name)
>=20
> DEFINE=5FEARLY=5FPROC=5FMEM=5FRESTRICT(OPEN=5FREAD, open=5Fread);
> DEFINE=5FEARLY=5FPROC=5FMEM=5FRESTRICT(OPEN=5FWRITE, open=5Fwrite);
> DEFINE=5FEARLY=5FPROC=5FMEM=5FRESTRICT(WRITE, write);
> DEFINE=5FEARLY=5FPROC=5FMEM=5FRESTRICT(FOLL=5FFORCE, foll=5Fforce);

Hello again,

I tried very hard to make the above work these past few days and gave u=
p.
Couldn't find a way to get it to compile.
Tried to also debug the compiler preprocess output and my head hurts. :=
)

Would macros like the following be acceptable?
I know it's more verbose but also much easier to understand and it work=
s.

#if IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5FREAD=5FALL)
DEFINE=5FSTATIC=5FKEY=5FTRUE=5FRO(proc=5Fmem=5Frestrict=5Fopen=5Fread=5F=
all);
DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fopen=5Fread=5F=
ptracer);
#elif IS=5FENABLED(CONFIG=5FPROC=5FMEM=5FRESTRICT=5FOPEN=5FREAD=5FPTRAC=
E)
DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fopen=5Fread=5F=
all);
DEFINE=5FSTATIC=5FKEY=5FTRUE=5FRO(proc=5Fmem=5Frestrict=5Fopen=5Fread=5F=
ptracer);
#else
DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fopen=5Fread=5F=
all);
DEFINE=5FSTATIC=5FKEY=5FFALSE=5FRO(proc=5Fmem=5Frestrict=5Fopen=5Fread=5F=
ptracer);
#endif


