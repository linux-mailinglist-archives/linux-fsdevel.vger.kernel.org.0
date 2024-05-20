Return-Path: <linux-fsdevel+bounces-19844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A7C8CA482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 00:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E871C20D46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD2313956D;
	Mon, 20 May 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="jIgQ5LNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D476374D4;
	Mon, 20 May 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244519; cv=none; b=HDpVbhnoNfqB/qRrs6aWxBmwuqnxBqeO6cHjxqO5k4cztgh+3kODyWy8OZ+gAhgy6gXtRINeI4fdDwafYiHHd5SZ4AhqWP2QEcCBG0mTpucGdwhFfxL5c+1i3mmpvIrZwAutO+/LOXLBNe0OgHCvwet/pz0YvwHiAYsH8iI9ixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244519; c=relaxed/simple;
	bh=cjQG2NXGJNS7kPW9JHk+yfvNEazpSaqk22YzgRY3MUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1YbFqIW1Mwniao8UZplA05esjfE1uN+DVh0+4CAFr/7v6I/5d+RAD7vtxyxDgXQugd8fQXYA8g4r74nEh8Nhj3DNw2ZodVakJD4TRnW9TxL5U9f9M2B3o80Em2fsagB3+w2e5jSfLbNWfRZGsrW4u2EX262/hcwJHfShm8KPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=jIgQ5LNX; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vjsf61dlmz9sGf;
	Tue, 21 May 2024 00:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716244094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAu7tdXVapdGdpTiF+pA8CO37dGS8jdsk02FKT7+Xm8=;
	b=jIgQ5LNXGKAbo/W85Mn/bxfDRn8HFHdswGz6ohLrDANzrP1sV7dl3HUJ6MYP0YzX5jVh4t
	rJ0tITXw+x7m25zdE6DT13VSPO+St9zZoQs8aG4NtX/jAfavLrVjPTgP2XsHOHQzZZMrGx
	zge34VcDsRBOVNi+8xyJU+BrMN5vTJb12NQZ8kjISSKfKVrVDHfJbWB8CiJRzdMk/YySa1
	XYUTsXEzzBFIbNQdmcwbUiU3l5FoXm8sPSIvq/woE0YIJqiU5gyfnN1kl7SSHkWC+jVDqq
	qE/JrNB8GnL3hTkTr2dtJ5aJ80NziYwRXyZLyikjAwbzvG8xaQUuchqcXa1IDg==
Date: Mon, 20 May 2024 16:27:59 -0600
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240520.221843-swanky.buyers.maroon.prison-MAgYEXR0vg7P@cyphar.com>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <f51a4bf68289268206475e3af226994607222be4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xkfzuictmmv2dff"
Content-Disposition: inline
In-Reply-To: <f51a4bf68289268206475e3af226994607222be4.camel@kernel.org>


--3xkfzuictmmv2dff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-20, Jeff Layton <jlayton@kernel.org> wrote:
> On Mon, 2024-05-20 at 17:35 -0400, Aleksa Sarai wrote:
> > Now that we have stabilised the unique 64-bit mount ID interface in
> > statx, we can now provide a race-free way for name_to_handle_at(2) to
> > provide a file handle and corresponding mount without needing to worry
> > about racing with /proc/mountinfo parsing.
> >=20
> > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
> > that doesn't make sense for name_to_handle_at(2).
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  fs/fhandle.c               | 27 +++++++++++++++++++--------
> >  include/uapi/linux/fcntl.h |  2 ++
> >  2 files changed, 21 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index 8a7f86c2139a..6bc7ffccff8c 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -16,7 +16,8 @@
> > =20
> >  static long do_sys_name_to_handle(const struct path *path,
> >  				  struct file_handle __user *ufh,
> > -				  int __user *mnt_id, int fh_flags)
> > +				  void __user *mnt_id, bool unique_mntid,
> > +				  int fh_flags)
> >  {
> >  	long retval;
> >  	struct file_handle f_handle;
> > @@ -69,10 +70,16 @@ static long do_sys_name_to_handle(const struct path=
 *path,
> >  	} else
> >  		retval =3D 0;
> >  	/* copy the mount id */
> > -	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
> > -	    copy_to_user(ufh, handle,
> > -			 struct_size(handle, f_handle, handle_bytes)))
> > -		retval =3D -EFAULT;
> > +	if (unique_mntid)
> > +		retval =3D put_user(real_mount(path->mnt)->mnt_id_unique,
> > +				  (u64 __user *) mnt_id);
> > +	else
> > +		retval =3D put_user(real_mount(path->mnt)->mnt_id,
> > +				  (int __user *) mnt_id);
> > +	/* copy the handle */
> > +	if (!retval)
> > +		retval =3D copy_to_user(ufh, handle,
> > +				struct_size(handle, f_handle, handle_bytes));
> >  	kfree(handle);
> >  	return retval;
> >  }
> > @@ -83,6 +90,7 @@ static long do_sys_name_to_handle(const struct path *=
path,
> >   * @name: name that should be converted to handle.
> >   * @handle: resulting file handle
> >   * @mnt_id: mount id of the file system containing the file
> > + *          (u64 if AT_HANDLE_UNIQUE_MNT_ID, otherwise int)
> >   * @flag: flag value to indicate whether to follow symlink or not
> >   *        and whether a decodable file handle is required.
> >   *
> > @@ -92,7 +100,7 @@ static long do_sys_name_to_handle(const struct path =
*path,
> >   * value required.
> >   */
> >  SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> > -		struct file_handle __user *, handle, int __user *, mnt_id,
> > +		struct file_handle __user *, handle, void __user *, mnt_id,
> >=20
>=20
> Changing the syscall signature like this is rather nasty. The new flag
> seems like it should safely gate the difference, but I still have some
> concerns about misuse and people passing in too small a buffer for the
> mnt_id.

Yeah, it's a little ugly, but an name_to_handle_at2 feels like overkill
for such a minor change. I'm also not sure there's a huge risk of users
accidentally passing AT_HANDLE_UNIQUE_MNT_ID with an (int *).

> >  		int, flag)
> >  {
> >  	struct path path;
> > @@ -100,7 +108,8 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const =
char __user *, name,
> >  	int fh_flags;
> >  	int err;
> > =20
> > -	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID))
> > +	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
> > +		     AT_HANDLE_UNIQUE_MNT_ID))
> >  		return -EINVAL;
> > =20
> >  	lookup_flags =3D (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
> > @@ -109,7 +118,9 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const =
char __user *, name,
> >  		lookup_flags |=3D LOOKUP_EMPTY;
> >  	err =3D user_path_at(dfd, name, lookup_flags, &path);
> >  	if (!err) {
> > -		err =3D do_sys_name_to_handle(&path, handle, mnt_id, fh_flags);
> > +		err =3D do_sys_name_to_handle(&path, handle, mnt_id,
> > +					    flag & AT_HANDLE_UNIQUE_MNT_ID,
> > +					    fh_flags);
> >  		path_put(&path);
> >  	}
> >  	return err;
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index c0bcc185fa48..fda970f92fba 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -118,6 +118,8 @@
> >  #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
> >  					compare object identity and may not
> >  					be usable to open_by_handle_at(2) */
> > +#define AT_HANDLE_UNIQUE_MNT_ID	AT_STATX_FORCE_SYNC /* returned mount =
id is
> > +					the u64 unique mount id */
> >  #if defined(__KERNEL__)
> >  #define AT_GETATTR_NOSEC	0x80000000
> >  #endif
> >=20
> > ---
> > base-commit: 584bbf439d0fa83d728ec49f3a38c581bdc828b4
> > change-id: 20240515-exportfs-u64-mount-id-9ebb5c58b53c
> >=20
> > Best regards,
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3xkfzuictmmv2dff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZkvObwAKCRAol/rSt+lE
bwUfAQDJ1QAS/wUGElxABHqGXlyPczux/CTWK0l4A18oK8U2QgD+P9KvqyLdkR2T
BfXcI3kYe3uiCAAV9MQNxLze73EAggg=
=RY/e
-----END PGP SIGNATURE-----

--3xkfzuictmmv2dff--

