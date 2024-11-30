Return-Path: <linux-fsdevel+bounces-36175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE029DEF15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 06:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D1416356A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 05:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A843145B1B;
	Sat, 30 Nov 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="QaoUrotg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362043179;
	Sat, 30 Nov 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732946133; cv=none; b=ojoc3serz98xfuzxaagUehb40l7q/SyOmwGWM/zNx1BeGeYg47Sy0HBSdUDUYjSg09iVcG1qc3Sqo4qtHYYjc0QM5RA1AJLloiwmhkhxxFiImozDjVdy6NQW6pSSZfMMh7gSm4lUS7upC8MthZLck1i6wD8KqFFNryMnLx3HhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732946133; c=relaxed/simple;
	bh=iS9OUfI8gakpfTYs8PqXB7kKI18YaF5bFkT2kC0tCDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/onqILjNjTdYRKHTvY93TPffTqgXrCFC4Gfc8yfnCMdSiEn1P7xlYYrruT0NBd5GsGYa2a/swIfdGiPHQu2vW8m9K/uMNsF6KHZtlpporM37/CqgeuEcfuDLOeeFdyIAwP0J0QDb+ePxiqZqBrPHMJLy6Vr25rr1R0V6XN1egE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=QaoUrotg; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Y0fQx05vsz9syJ;
	Sat, 30 Nov 2024 06:55:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1732946121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFFyRAYQJxjBoODb1KIsqrLrSJdTbzj1N/mY9TF40uc=;
	b=QaoUrotg7h3oTTzkfAM1BguTvwpsnUA4o2fbRkhsmlPGqW3/Lt6UbsDTRdsWV6uoYUNdZO
	UhoFvWIw29q8SN5MNO1cGDlTdDP03duHdOsjqvUXEdRpJXeNMNE+T4nKdRZapht/qPPZ2u
	h36bmHuTuLzWxY8oCXooKr+E4Z3ZikX/a73NZMkJxcohmVPWxNFxdhMH5AbdReUYxIZ4Bh
	JsMTpaNLwaFebf0S/2jOvLHtJyYlt3TNEb2TQvNV+fM6tBfyuCZEd+0Z9AuXPFvzt8a+tN
	5EZWO/2/ZmAsGs6mY2/a0EpFEc5p4uFYRgvQAAXXl11sQ9VNC/dwFcPYE+j8tQ==
Date: Sat, 30 Nov 2024 16:55:09 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Tycho Andersen <tandersen@netflix.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <20241130.055433-shy.herds.gross.wars-zGaSWwzAa56n@cyphar.com>
References: <20241130045437.work.390-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="42vhhdfvrpiztluk"
Content-Disposition: inline
In-Reply-To: <20241130045437.work.390-kees@kernel.org>
X-Rspamd-Queue-Id: 4Y0fQx05vsz9syJ


--42vhhdfvrpiztluk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
MIME-Version: 1.0

On 2024-11-29, Kees Cook <kees@kernel.org> wrote:
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
>=20
> When the filename passed in is empty (e.g. with AT_EMPTY_PATH), use the
> dentry's filename for "comm" instead of using the useless numeral from
> the synthetic fdpath construction. This way the actual exec machinery
> is unchanged, but cosmetically the comm looks reasonable to admins
> investigating things.
>=20
> Instead of adding TASK_COMM_LEN more bytes to bprm, use one of the unused
> flag bits to indicate that we need to set "comm" from the dentry.

Looks reasonable to me, feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

>=20
> Suggested-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> Suggested-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> Link: https://github.com/uapi-group/kernel-features#set-comm-field-before=
-exec
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
>=20
> Here's what I've put together from the various suggestions. I didn't
> want to needlessly grow bprm, so I just added a flag instead. Otherwise,
> this is very similar to what Linus and Al suggested.
> ---
>  fs/exec.c               | 22 +++++++++++++++++++---
>  include/linux/binfmts.h |  4 +++-
>  2 files changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index 5f16500ac325..d897d60ca5c2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1347,7 +1347,21 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		set_dumpable(current->mm, SUID_DUMP_USER);
> =20
>  	perf_event_exec();
> -	__set_task_comm(me, kbasename(bprm->filename), true);
> +
> +	/*
> +	 * If the original filename was empty, alloc_bprm() made up a path
> +	 * that will probably not be useful to admins running ps or similar.
> +	 * Let's fix it up to be something reasonable.
> +	 */
> +	if (bprm->comm_from_dentry) {
> +		rcu_read_lock();
> +		/* The dentry name won't change while we hold the rcu read lock. */
> +		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_nam=
e.name),
> +				true);
> +		rcu_read_unlock();
> +	} else {
> +		__set_task_comm(me, kbasename(bprm->filename), true);
> +	}
> =20
>  	/* An exec changes our domain. We are no longer part of the thread
>  	   group */
> @@ -1521,11 +1535,13 @@ static struct linux_binprm *alloc_bprm(int fd, st=
ruct filename *filename, int fl
>  	if (fd =3D=3D AT_FDCWD || filename->name[0] =3D=3D '/') {
>  		bprm->filename =3D filename->name;
>  	} else {
> -		if (filename->name[0] =3D=3D '\0')
> +		if (filename->name[0] =3D=3D '\0') {
>  			bprm->fdpath =3D kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
> -		else
> +			bprm->comm_from_dentry =3D 1;
> +		} else {
>  			bprm->fdpath =3D kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
>  						  fd, filename->name);
> +		}
>  		if (!bprm->fdpath)
>  			goto out_free;
> =20
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index e6c00e860951..3305c849abd6 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -42,7 +42,9 @@ struct linux_binprm {
>  		 * Set when errors can no longer be returned to the
>  		 * original userspace.
>  		 */
> -		point_of_no_return:1;
> +		point_of_no_return:1,
> +		/* Set when "comm" must come from the dentry. */
> +		comm_from_dentry:1;
>  	struct file *executable; /* Executable to pass to the interpreter */
>  	struct file *interpreter;
>  	struct file *file;
> --=20
> 2.34.1
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--42vhhdfvrpiztluk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZ0qovQAKCRAol/rSt+lE
b5FTAP93qPm+eNSOs09B1018U/ThWjWGx3wa4e4OQ8UG49LWDgEA4ffCR0fzoQV8
nR57GUKYqfUw7R1e46eST1APMDTMtg0=
=Qnvr
-----END PGP SIGNATURE-----

--42vhhdfvrpiztluk--

