Return-Path: <linux-fsdevel+bounces-13654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6C872794
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB051F26EA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCD59B7A;
	Tue,  5 Mar 2024 19:34:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC301B809;
	Tue,  5 Mar 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667279; cv=none; b=KL0BTA0dGaMd2Dm7E0iPsqA8Z0JObFWlsRYOMZqe8NehhWZAEnwpaAqQGyelL86XnLd7sGliT5oExGtfjR8SQQaDczVJYqW/VE2p3X8QC56xDF9QL+zaPATL8Lr+W69Hjkz+qOu3HiC5A9tqK3vclWXlmOYeNTG/jJ6/o0vuIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667279; c=relaxed/simple;
	bh=UdyplhazAm9JcbRu3RQ5VQwxs4WDrQvjdtcSkVIwiPg=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Cnp/49c4kih4FhSFasio2E1NwnXzURpDkv858iAo29LpFCtTIC8RrfJTvrtUY0lBtjirjH0yM5L+iNHT6zlWMTPKaB0xu7Kxo2Bimwgoxfx4tsI7nadm9eOe4k0DzWwtp+lhsaSF2fnnTDmgYDnlnu073ASb+cKUuUET4BDWzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 178E8378204B;
	Tue,  5 Mar 2024 19:34:35 +0000 (UTC)
From: "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <202403051033.9527DD75@keescook>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
 <202403050211.86A44769@keescook>
 <20240305-brotkrumen-vorbild-9709ce924d25@brauner> <202403051033.9527DD75@keescook>
Date: Tue, 05 Mar 2024 19:34:34 +0000
Cc: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, "Guenter Roeck" <groeck@chromium.org>, "Doug Anderson" <dianders@chromium.org>, "Jann Horn" <jannh@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike Frysinger" <vapier@chromium.org>
To: "Kees Cook" <keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <45d98-65e77400-5-31aa8000@248840925>
Subject: =?utf-8?q?Re=3A?= [PATCH v2] =?utf-8?q?proc=3A?= allow restricting 
 /proc/pid/mem writes
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, March 05, 2024 20:37 EET, Kees Cook <keescook@chromium.org>=
 wrote:

> On Tue, Mar 05, 2024 at 11:32:04AM +0100, Christian Brauner wrote:
> > On Tue, Mar 05, 2024 at 02:12:26AM -0800, Kees Cook wrote:
> > > On Tue, Mar 05, 2024 at 10:58:25AM +0100, Christian Brauner wrote=
:
> > > > Since the write handler for /proc/<pid>/mem does raise FOLL=5FF=
ORCE
> > > > unconditionally it likely would implicitly. But I'm not familia=
r enough
> > > > with FOLL=5FFORCE to say for sure.
> > >=20
> > > I should phrase the question better. :) Is the supervisor writing=
 into
> > > read-only regions of the child process?
> >=20
> > Hm... I suspect we don't. Let's take two concrete examples so you c=
an
> > tell me.
> >=20
> > Incus intercepts the sysinfo() syscall. It prepares a struct sysinf=
o
> > with cgroup aware values for the supervised process and then does:
> >=20
> > unix.Pwrite(siov.memFd, &sysinfo, sizeof(struct sysinfo), seccomp=5F=
data.args[0]))
> >=20
> > It also intercepts some bpf system calls attaching bpf programs for=
 the
> > caller. If that fails we update the log buffer for the supervised
> > process:
> >=20
> > union bpf=5Fattr attr =3D {}, new=5Fattr =3D {};
> >=20
> > // read struct bpf=5Fattr from mem=5Ffd
> > ret =3D pread(mem=5Ffd, &attr, attr=5Flen, req->data.args[1]);
> > if (ret < 0)
> >         return -errno;
> >=20
> > // Do stuff with attr. Stuff fails. Update log buffer for supervise=
d process:
> > if ((new=5Fattr.log=5Fsize) > 0 && (pwrite(mem=5Ffd, new=5Fattr.log=
=5Fbuf, new=5Fattr.log=5Fsize, attr.log=5Fbuf) !=3D new=5Fattr.log=5Fsi=
ze))
>=20
> This is almost certainly in writable memory (either stack or .data).

Mostly yes, but we can't be certain where it comes from, because
SECCOMP=5FIOCTL=5FNOTIF=5FRECV passes any addresses set by the
caller to the supervisor process.

It is a kind of "implementation defined" behavior, just like we
can't predict what the supervisor will do with the caller mem :)

>=20
> > But I'm not sure if there are other use-cases that would require th=
is.
>=20
> Maybe this option needs to be per-process (like no=5Fnew=5Fprivs), an=
d with
> a few access levels:
>=20
> - as things are now
> - no FOLL=5FFORCE unless by ptracer
> - no writes unless by ptracer
> - no FOLL=5FFORCE ever
> - no writes ever
> - no reads unless by ptracer
> - no reads ever
>=20
> Which feels more like 3 toggles: read, write, FOLL=5FFORCE. Each set =
to
> "DAC", "ptracer", and "none"?

I really like this approach because it provides a  mechanism
with maximum flexibility without imposing a specific policy.

What does DAC mean in this context? My mind jumps to
Digital to Analog Converter :)

Shall I give it a try in v3?

>=20
> --=20
> Kees Cook


