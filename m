Return-Path: <linux-fsdevel+bounces-31493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F0997713
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B022831B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592521E25FF;
	Wed,  9 Oct 2024 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="dNYyzfgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46941E2316;
	Wed,  9 Oct 2024 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507431; cv=none; b=c4MqLAfq0hsYO01y0nmzf+4XDCLs3z++RSGpZRntQ0fk/WrG4tF+aCIJe8xP0cvjP4rSrO1KbiOP4T3/+eisDrs4WKoq0K8AI/hnvLop7QrCR9QqzWaQn/VHSZPqReSO+TlV7le5xHMusdhWgxcAp2+AShNhuppSg/ThcHpez+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507431; c=relaxed/simple;
	bh=OhXzzYRz/FznOqT31/spFj8IGR43NqoxMfupYzzSpyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds5C4APxLGEL1vArKk2AJHgQjmJDXojkTUa4mbh5ctInm145VEQauoZ2g5bN/1eZw27b5wDeE2wHTfczQB2v/x07hMOK2pvDOzSEszfK+Kydk7mu+ekuPHCY6AZ6itnsQeyevQkK9f+ClDS3H/JSUe5N83jZiu2EGL7pEB4h/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=dNYyzfgE; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XP4vP6gznz9tFG;
	Wed,  9 Oct 2024 22:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728507426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXtC4ki0Cgt4wUQPkF8ctVO2OLggLPi73aR2RRs0kuQ=;
	b=dNYyzfgEJYLByOdtBexIuEd06qlE90YKpABTagw/Uiro6Ddaj7wXXla3tIfWXLI18n0Mw0
	VZNHUC4WFf07QXEXKDA0oApOZsfu7yfFYw2JTxBe4kiCK1UnkWmo1/n+Do4IAsIXoYJVQD
	9VW/4WKGajmxvnGLNUy1WeoofurrKLTUkIiy1wYFo1z0WM04j0BrLzXGlv/BYbUabymtHY
	mDrA4+mrWtomfsjFs4Cs+qv/B1jDPoTyjwQKy5NH1D75bbMifC5bzqUQ6nG28dTnlcd5wO
	iPjABS10QAhcqdwlZJR8/+mGzPEv1jNZmR3hzF/JnWGIidZCRtUFsq3cpnxPdw==
Date: Thu, 10 Oct 2024 07:56:53 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d55dcuzddrcqkjin"
Content-Disposition: inline
In-Reply-To: <87msjd9j7n.fsf@trenco.lwn.net>


--d55dcuzddrcqkjin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-09, Jonathan Corbet <corbet@lwn.net> wrote:
> luca.boccassi@gmail.com writes:
>=20
> > As discussed at LPC24, add an ioctl with an extensible struct
> > so that more parameters can be added later if needed. Start with
> > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > optionally.
>=20
> I was looking this over, and a couple of questions came to mind...
>=20
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
>=20
> [...]
>=20
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index 80675b6bf884..15cdc7fe4968 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/anon_inodes.h>
> >  #include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/magic.h>
> >  #include <linux/mount.h>
> >  #include <linux/pid.h>
> > @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, stru=
ct poll_table_struct *pts)
> >  	return poll_flags;
> >  }
> > =20
> > +static long pidfd_info(struct task_struct *task, unsigned int cmd, uns=
igned long arg)
> > +{
> > +	struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg;
> > +	size_t usize =3D _IOC_SIZE(cmd);
> > +	struct pidfd_info kinfo =3D {};
> > +	struct user_namespace *user_ns;
> > +	const struct cred *c;
> > +	__u64 request_mask;
> > +
> > +	if (!uinfo)
> > +		return -EINVAL;
> > +	if (usize < sizeof(struct pidfd_info))
> > +		return -EINVAL; /* First version, no smaller struct possible */
> > +
> > +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(reques=
t_mask)))
> > +		return -EFAULT;
>=20
> You don't check request_mask for unrecognized flags, so user space will
> not get an error if it puts random gunk there.  That, in turn, can make
> it harder to add new options in the future.

In fairness, this is how statx works and statx does this to not require
syscall retries to figure out what flags the current kernel supports and
instead defers that to stx_mask.

However, I think verifying the value is slightly less fragile -- as long
as we get a cheap way for userspace to check what flags are supported
(such as CHECK_FIELDS[1]). It would kind of suck if userspace would have
to do 50 syscalls to figure out what request_mask values are valid.

[1]: https://lore.kernel.org/all/20241010-extensible-structs-check_fields-v=
3-0-d2833dfe6edd@cyphar.com/

>=20
> > +	c =3D get_task_cred(task);
> > +	if (!c)
> > +		return -ESRCH;
>=20
> [...]
>=20
> > +
> > +	/*
> > +	 * If userspace and the kernel have the same struct size it can just
> > +	 * be copied. If userspace provides an older struct, only the bits th=
at
> > +	 * userspace knows about will be copied. If userspace provides a new
> > +	 * struct, only the bits that the kernel knows about will be copied a=
nd
> > +	 * the size value will be set to the size the kernel knows about.
> > +	 */
> > +	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> > +		return -EFAULT;
>=20
> Which "size value" are you referring to here; I can't see it.
>=20
> If user space has a bigger struct, should you perhaps zero-fill the part
> the kernel doesn't know about?
>=20
> > +	return 0;
> > +}
>=20
> Thanks,
>=20
> jon
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--d55dcuzddrcqkjin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZwbuFQAKCRAol/rSt+lE
b+61AP9z34v88831vNhUGO4J98E8hhrVDOwy/Tb7RXMibZ3xXAEA0s0kMSF5Fhii
t9QCkSeLpRkv9NQj420kdMg3O+RnUQk=
=TOuq
-----END PGP SIGNATURE-----

--d55dcuzddrcqkjin--

