Return-Path: <linux-fsdevel+bounces-31494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EB399773D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 23:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01E1B21374
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6111E1A36;
	Wed,  9 Oct 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="PnIHSVnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07913A409;
	Wed,  9 Oct 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508017; cv=none; b=Mauw9pcwzi5OczQpuwVCjIbajTBa7SwA5BV3CLvaVmA03co8LjP3pkJGkrJ/qsB9qRPv+MEBY32X4Kr3XOlcnezgL4KCb2J1bj+0LptksztZvGUDK28QmrbyjtiJYsNddOHJe/JxhXJwAXZ800uvQ1ITir90pNECo5uXEPep5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508017; c=relaxed/simple;
	bh=5KVHH6st84LeYGoFXg34NLO88KcY3/iymKc/NmHqTwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT1q9qR0H4TOhj70FbGLxF9BgATIYyCpH+WwfKiR9jqFPqLyWcGOXUmip5js1iCz0nA0mfnJJDP7GK5Hik5QGtxbKcHqNRSquSL7e37fSaK5jzHsAhuCf841WPW9nt+CBKbHqP8v8EbxwwO+E9KBddqIq/LVyN4BzHgOCei3As8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=PnIHSVnU; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XP56f6j7rz9tkZ;
	Wed,  9 Oct 2024 23:06:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728508011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thuBoLHIm6U4EHRwPs4+cilp+u3Urmn+GlVFejTXhCY=;
	b=PnIHSVnUturPQWmkKXqyX5404qtG3WbwpxjTB7VUQ1AwdZeQknWl5gCMMjteayehzbNekR
	geLDxhSRZNZmJzzbLrc/Q8bwplye0CE3b+j8wjQVGyJWMYxp+rg/GwaQNvX+Yq7KWbm48t
	ycFmHQgCzQwUoV1psGKHypdCxTxWTH/d4+td5JVYA5Lpz6eiZXCRePmkUKmE3GBC87UpAu
	Z1H64kgHFYmW/VGtnOaMui2Zyop5GJUft02N588QOikEvfgCj3VtM3jLx9Np6va/dKIgxH
	wNudreZfo+O0lnfDd61c+pZ/ZZe5GOkMmaJ1ved5JsyYxQAChgn+bwajxmdJGw==
Date: Thu, 10 Oct 2024 08:06:44 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241009.210353-murky.mole.elite.putt-JnYGYHfGrAtK@cyphar.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
 <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57z5kvqx5z2wfdae"
Content-Disposition: inline
In-Reply-To: <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
X-Rspamd-Queue-Id: 4XP56f6j7rz9tkZ


--57z5kvqx5z2wfdae
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-10, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2024-10-09, Jonathan Corbet <corbet@lwn.net> wrote:
> > luca.boccassi@gmail.com writes:
> >=20
> > > As discussed at LPC24, add an ioctl with an extensible struct
> > > so that more parameters can be added later if needed. Start with
> > > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > > optionally.
> >=20
> > I was looking this over, and a couple of questions came to mind...
> >=20
> > > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > ---
> >=20
> > [...]
> >=20
> > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > index 80675b6bf884..15cdc7fe4968 100644
> > > --- a/fs/pidfs.c
> > > +++ b/fs/pidfs.c
> > > @@ -2,6 +2,7 @@
> > >  #include <linux/anon_inodes.h>
> > >  #include <linux/file.h>
> > >  #include <linux/fs.h>
> > > +#include <linux/cgroup.h>
> > >  #include <linux/magic.h>
> > >  #include <linux/mount.h>
> > >  #include <linux/pid.h>
> > > @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, st=
ruct poll_table_struct *pts)
> > >  	return poll_flags;
> > >  }
> > > =20
> > > +static long pidfd_info(struct task_struct *task, unsigned int cmd, u=
nsigned long arg)
> > > +{
> > > +	struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg;
> > > +	size_t usize =3D _IOC_SIZE(cmd);
> > > +	struct pidfd_info kinfo =3D {};
> > > +	struct user_namespace *user_ns;
> > > +	const struct cred *c;
> > > +	__u64 request_mask;
> > > +
> > > +	if (!uinfo)
> > > +		return -EINVAL;
> > > +	if (usize < sizeof(struct pidfd_info))
> > > +		return -EINVAL; /* First version, no smaller struct possible */
> > > +
> > > +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(requ=
est_mask)))
> > > +		return -EFAULT;
> >=20
> > You don't check request_mask for unrecognized flags, so user space will
> > not get an error if it puts random gunk there.  That, in turn, can make
> > it harder to add new options in the future.
>=20
> In fairness, this is how statx works and statx does this to not require
> syscall retries to figure out what flags the current kernel supports and
> instead defers that to stx_mask.
>=20
> However, I think verifying the value is slightly less fragile -- as long
> as we get a cheap way for userspace to check what flags are supported
> (such as CHECK_FIELDS[1]). It would kind of suck if userspace would have
> to do 50 syscalls to figure out what request_mask values are valid.

Unfortunately, we probably need to find a different way to do
CHECK_FIELDS for extensible-struct ioctls because CHECK_FIELDS uses the
top bit in a u64 but we can't set a size that large with ioctl
numbers...

Then again, _IOC_SIZEBITS is 14 so we could easily set the ioctl size to
something >PAGE_SIZE fairly easily at least...

> [1]: https://lore.kernel.org/all/20241010-extensible-structs-check_fields=
-v3-0-d2833dfe6edd@cyphar.com/
>=20
> >=20
> > > +	c =3D get_task_cred(task);
> > > +	if (!c)
> > > +		return -ESRCH;
> >=20
> > [...]
> >=20
> > > +
> > > +	/*
> > > +	 * If userspace and the kernel have the same struct size it can just
> > > +	 * be copied. If userspace provides an older struct, only the bits =
that
> > > +	 * userspace knows about will be copied. If userspace provides a new
> > > +	 * struct, only the bits that the kernel knows about will be copied=
 and
> > > +	 * the size value will be set to the size the kernel knows about.
> > > +	 */
> > > +	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> > > +		return -EFAULT;
> >=20
> > Which "size value" are you referring to here; I can't see it.
> >=20
> > If user space has a bigger struct, should you perhaps zero-fill the part
> > the kernel doesn't know about?
> >=20
> > > +	return 0;
> > > +}
> >=20
> > Thanks,
> >=20
> > jon
> >=20
>=20
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--57z5kvqx5z2wfdae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZwbwZAAKCRAol/rSt+lE
b/t6AP4oQ3DHdJAeYSOk3qxzyT8nhRDxIvyE8VJYV/VRGBDgNwEA6wwrbKQFdopZ
vt65Uj1g0wGGX5D0KkI2uKu03UT4TQg=
=8+Qn
-----END PGP SIGNATURE-----

--57z5kvqx5z2wfdae--

