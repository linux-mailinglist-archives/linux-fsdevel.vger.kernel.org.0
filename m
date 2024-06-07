Return-Path: <linux-fsdevel+bounces-21170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB8900113
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486A61F25979
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DA15EFBA;
	Fri,  7 Jun 2024 10:38:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA52158214;
	Fri,  7 Jun 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756705; cv=none; b=UGmxGz4GBqAYhee+EBmk6+Eg9BOPwbHB0XI+Lu18lXEBqIQuII+t5UCNucqnw9gUgNlbiiLlYcEdyCEP/O4gvLRN+eoqHRzYyex1seMOfUgH48xWvDFMhiG87rEXPnPwL37IIfNzZMUjGNdPfIIHfkOMa39elsCcQ7pR6FP7Pd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756705; c=relaxed/simple;
	bh=DT7FNHmQI0I2WJM1Vw3SgQZACIUEah+Ky8z8hPcqO3k=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=RGTuMeCrzFz6ZcOxFnbzYSpzOZVpxJnOhXT4xRmYN/JYBK7L04n/C1QpSxW2IvIHPff2Wb0ttSbrTYWUpDZdeQbufrrRkLCNnh2DSVZgOnWtWafdNn0SP+trd8fgRUwT+ulOW5EIEo52/5STOGnMQ0JDKhMSRGLY0okAUUkR9Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 211DB37810C3;
	Fri,  7 Jun 2024 10:38:21 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202406060917.8DEE8E3@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240605164931.3753-1-adrian.ratiu@collabora.com>
 <20240605164931.3753-2-adrian.ratiu@collabora.com> <202406060917.8DEE8E3@keescook>
Date: Fri, 07 Jun 2024 11:38:12 +0100
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com, jorgelo@chromium.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Christian Brauner" <brauner@kernel.org>, "Jeff Xu" <jeffxu@google.com>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2724ac-6662e300-3-2336898@243510220>
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

Indeed, having CONFIG-enabled and disabling entirely via kernel
params is a valid usecase (eg for debug images with no restriction).

Will do in v6.

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

No real reason, my mind was just more attuned to the inc/dec
semantics, however in this case we can just use enable/disable,
especially if they're faster.

I'll do this in v6.

>=20
> And we should report misparsing too, so perhaps:

Ack

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

Yes, will do in v6.

> Can we adjust the Kconfigs to match the bootparam arguments? i.e.
> instead of two for each mode, how about one with 3 settings ("all",
> "ptrace", or "off")

Sure. Thank you for all the code! All your help designing this
and code contributions are very much appreciated!

Do you want to be listed as co-author in v6?


