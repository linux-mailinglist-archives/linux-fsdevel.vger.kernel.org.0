Return-Path: <linux-fsdevel+bounces-73891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81047D22FFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5989A301503D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB032B9BB;
	Thu, 15 Jan 2026 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="CNBb5r92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F12DC781
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464363; cv=none; b=lxC5lrcP3IS+LwVZQ0nP6j4vEI2aV8tRc4acYZMHZIXH4CIkU7SXHy5Lcy9IhYBs6u49M+KNkZzFEGp6ibvVHYMY56Bs35sXyG/LgWPqk4V6GfdMV08fSbzlFVTjFvu+DztNm3fCudUSXbiCUDAi/4YAFm1iHSyZwlySdDDSZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464363; c=relaxed/simple;
	bh=Pke2mtwVAhr+tf/SMwTMuDM2D4BIZ9xVMuSa0st1F5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NXY4IxVPuc1b+o0vjEEzt9t2CUFVIEubgrbhDphxDPEJi2jzuvOKorXerldbCJhRucznCpijAEJK6BYG8xmlzipciUsgLUk8jDMCPv1pgcTfrKa+A3Dlt3dVJU5ZswP6KD3q7nFIGy1mqUFX8x+KLRB1NpBlag+ZMRAJCj6JUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=CNBb5r92; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1768463982;
	bh=Pke2mtwVAhr+tf/SMwTMuDM2D4BIZ9xVMuSa0st1F5A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CNBb5r92qMUKm885rC5HkbYAu4MdCpe4mw0KzWQwcwer+KiR58PMd3+5DJxC5lDWJ
	 n7eQWnEsZPAy6oClMIo/L089oQqomUYRsYd6YGfeBBOQFvrQFfVSwSKVIJIHd+Jo8w
	 TXrqvy54YhXTqXNZ34crbiQzVzERO/graow9TdaQ=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BC2B066CE6;
	Thu, 15 Jan 2026 02:59:41 -0500 (EST)
Message-ID: <7b964b35e86d73816a395e72bac7e2e73ff8dd6d.camel@xry111.site>
Subject: Behavior difference of copy_file_range of compat syscall vs. real
 32-bit kernel (was: [PATCH 0/3] Fix and improve tst-copy_file_range on
 Linux >= 6.18)
From: Xi Ruoyao <xry111@xry111.site>
To: Miklos Szeredi <mszeredi@redhat.com>, Adhemerval Zanella Netto
	 <adhemerval.zanella@linaro.org>, Stefan Liebler <stli@linux.ibm.com>, 
	libc-alpha@sourceware.org
Cc: linux-fsdevel@vger.kernel.org
Date: Thu, 15 Jan 2026 15:59:39 +0800
In-Reply-To: <68ad3720281ba534a5fdb3f5c5251dc5426f23db.camel@xry111.site>
References: <20260108072756.47858-1-xry111@xry111.site>
	 <7467585.QJadu78ljV@kona>
	 <f1942599cc16166b56e08927c53c2471d0bea477.camel@xry111.site>
	 <8357318.ejJDZkT8p0@kona>
	 <e05fd602-1267-4419-aa3a-24254b7b5ee0@linux.ibm.com>
	 <bd764907-b130-426d-bc8d-d042fb4afea4@linaro.org>
	 <68ad3720281ba534a5fdb3f5c5251dc5426f23db.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 10:40 +0800, Xi Ruoyao wrote:
> On Tue, 2026-01-13 at 10:45 -0300, Adhemerval Zanella Netto wrote:
>=20
> > > But in 32bit-compat mode (on i686 and s390), they still fail on linux
> > > > =3D6.18:
> > > ../sysdeps/unix/sysv/linux/tst-copy_file_range-large.c:201: numeric
> > > comparison failure (widths 32 and 64)
> > > =C2=A0=C2=A0 left: 2147479552 (0x7ffff000); from: copied
> > > =C2=A0 right: 2147483647 (0x7fffffff); from: size
> > > ...
> > > error: 6 test failures
> > >=20
> > > Without the exact comparison ...
> > > =C2=A0 if (atomic_load (&fuse_has_copy_file_range_64))
> > > =C2=A0=C2=A0=C2=A0 TEST_COMPARE (copied, size);
> > >=20
> > > ... there are no fails and thus it also passes the follow-on comparis=
on:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 We must AND the expression with SSIZE_MAX fo=
r 32-bit platforms where
> > > =C2=A0=C2=A0=C2=A0=C2=A0 SSIZE_MAX is less than UINT_MAX.
> > > =C2=A0 */
> > > =C2=A0 if (copied !=3D size)
> > > =C2=A0=C2=A0=C2=A0 TEST_COMPARE (copied, (UINT_MAX & ~(getpagesize ()=
 - 1)) & SSIZE_MAX);
> > >=20
> > >=20
> > > Do you also see those fails?
> >=20
> > I have tested only on x86_64 and aarch64; but I can confirm that at lea=
st
> > with i686 the test still fails.
>=20
> Oops, in compat syscall the length is already clamped in fs/read_write.c
> by the kernel:
>=20
> =C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0 * Make sure return value doesn't overflow in 32b=
it compat mode.=C2=A0 Also
> =C2=A0=C2=A0=C2=A0=C2=A0 * limit the size for all cases except when calli=
ng ->copy_file_range().
> =C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0 if (splice || !file_out->f_op->copy_file_range || in_c=
ompat_syscall())
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D min_t(size_t, MAX_RW_C=
OUNT, len);
>=20
> But then FUSE still uses COPY_FILE_RANGE_64, thus our
> fuse_has_copy_file_range_64 flag is still raised.=C2=A0 Maybe we should j=
ust
> skip setting fuse_has_copy_file_range_64 on 32-bit.
>=20
> Also I'm unsure if the check in kernel is really sufficient: what will
> happen if we call copy_file_range() on a real 32-bit kernel instead of
> as a compat syscall?

Hmm, we indeed have a behavior difference here.

On a real 32-bit kernel, when len is in (0x7ffff000, 0x80000000), the
value is used as-is; and when len is 0x80000000 or larger, EINVAL is
returned.

For a compat syscall on a 64-bit kernel, when len is 0x7ffff001 or
larger, it's clamped to 0x7ffff000.

I think I'll adapt the Glibc test case for the difference, but I'm
unsure if we need to strictly keep the behavior aligned on real 32-bit
kernel and for the compat syscall on 64-bit (maybe it can be considered
a "bug-level compatibility" that we never guarantee but I'm just
unsure).

--=20
Xi Ruoyao <xry111@xry111.site>

