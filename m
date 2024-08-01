Return-Path: <linux-fsdevel+bounces-24835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ABA94537E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B921C232DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1E14A4F8;
	Thu,  1 Aug 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly2BxRyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639D3C062;
	Thu,  1 Aug 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541597; cv=none; b=kCjkz51GTeOToNh7DfXQ1wd5Uqxt8TL/Nrxl2AegHyH+F8Q+KHJ5ku1XnOvMAXOgADIjK6qPXBrQQ6D4M0GxjYEMw4NflzxBUb0yugyEQVaSQUqwWNrdA2NN81lVld/suhVU1I9lg+fGbrmqIwuCSNK5UL9nt2n5ZpvyoXif6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541597; c=relaxed/simple;
	bh=cvgVp/KFbBa9VY7EcJnmpHK375fkBr0I622XMeQskDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNN+g4OeZhnunhNaQ9LwP80FP54jzkcC71d2aBuxk1HPk5xV14JQ4JMgtEjMOPAqYnD++IjdJdMugrojlFDEBrbn/AYjno7DHIbOXkKZF9GVlRo1JqcjXvkwNe9mrtDhmzerKO5w6VECyB34sACWOIhQBgie12bs+uadmH+CGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly2BxRyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D92EC4AF0B;
	Thu,  1 Aug 2024 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722541597;
	bh=cvgVp/KFbBa9VY7EcJnmpHK375fkBr0I622XMeQskDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ly2BxRyZPEA2WhuS5aeULjLcrVRgIQiQ/DX4zYpvRGtul/Be966RQUjgTIKVTzUqN
	 DKGC8UcuiIv1V6A1Wgg+GOSo/+ZbxonDM+wbUOhM2/bNOtwZN176t2tozyaQ2hqaTB
	 E2ycr4r9RSY2YSp1QodQC3/MhtVi1oca+LPEM+7wL3vArGY17OT7FMsSrlCbgGHO4c
	 F5VxBygl3fncV/270frR2Kj7cgqZGpOYiSkmVFUcfhRdLac4ZkRdeCLo5LbJ/ldpEc
	 e4EVoEWZn/4ofmD15/yELMcWCB1Sl+Ffch/8EpY/6i2YdCdQCpzsvKyckO5pv0SUAR
	 mTd89DDib68tw==
Message-ID: <9290a079840812e1e8616484ba0a9910d15fe730.camel@kernel.org>
Subject: Re: [PATCH RFC v3 2/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
From: Jeff Layton <jlayton@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, Amir Goldstein
 <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Date: Thu, 01 Aug 2024 15:46:34 -0400
In-Reply-To: <20240801-exportfs-u64-mount-id-v3-2-be5d6283144a@cyphar.com>
References: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
	 <20240801-exportfs-u64-mount-id-v3-2-be5d6283144a@cyphar.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-01 at 13:52 +1000, Aleksa Sarai wrote:
> Now that we provide a unique 64-bit mount ID interface in statx(2), we
> can now provide a race-free way for name_to_handle_at(2) to provide a
> file handle and corresponding mount without needing to worry about
> racing with /proc/mountinfo parsing or having to open a file just to do
> statx(2).
>=20
> While this is not necessary if you are using AT_EMPTY_PATH and don't
> care about an extra statx(2) call, users that pass full paths into
> name_to_handle_at(2) need to know which mount the file handle comes from
> (to make sure they don't try to open_by_handle_at a file handle from a
> different filesystem) and switching to AT_EMPTY_PATH would require
> allocating a file for every name_to_handle_at(2) call, turning
>=20
> =C2=A0 err =3D name_to_handle_at(-EBADF, "/foo/bar/baz", &handle, &mntid,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 AT_HANDLE_MNT_ID_UNIQUE);
>=20
> into
>=20
> =C2=A0 int fd =3D openat(-EBADF, "/foo/bar/baz", O_PATH | O_CLOEXEC);
> =C2=A0 err1 =3D name_to_handle_at(fd, "", &handle, &unused_mntid, AT_EMPT=
Y_PATH);
> =C2=A0 err2 =3D statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &statxb=
uf);
> =C2=A0 mntid =3D statxbuf.stx_mnt_id;
> =C2=A0 close(fd);
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> =C2=A0fs/fhandle.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 29 ++++++++++++++++------
> =C2=A0include/linux/syscalls.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0include/uapi/linux/fcntl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/perf/trace/beauty/include/uapi/linux/fcntl.h |=C2=A0 1 +
> =C2=A04 files changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 6e8cea16790e..8cb665629f4a 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -16,7 +16,8 @@
> =C2=A0
> =C2=A0static long do_sys_name_to_handle(const struct path *path,
> =C2=A0				=C2=A0 struct file_handle __user *ufh,
> -				=C2=A0 int __user *mnt_id, int fh_flags)
> +				=C2=A0 void __user *mnt_id, bool unique_mntid,
> +				=C2=A0 int fh_flags)
> =C2=A0{
> =C2=A0	long retval;
> =C2=A0	struct file_handle f_handle;
> @@ -69,9 +70,19 @@ static long do_sys_name_to_handle(const struct path *p=
ath,
> =C2=A0	} else
> =C2=A0		retval =3D 0;
> =C2=A0	/* copy the mount id */
> -	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
> -	=C2=A0=C2=A0=C2=A0 copy_to_user(ufh, handle,
> -			 struct_size(handle, f_handle, handle_bytes)))
> +	if (unique_mntid) {
> +		if (put_user(real_mount(path->mnt)->mnt_id_unique,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (u64 __user *) mnt_id))
> +			retval =3D -EFAULT;
> +	} else {
> +		if (put_user(real_mount(path->mnt)->mnt_id,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 (int __user *) mnt_id))
> +			retval =3D -EFAULT;
> +	}
> +	/* copy the handle */
> +	if (retval !=3D -EFAULT &&
> +		copy_to_user(ufh, handle,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct_size(handle, f_handle, handle_bytes))=
)
> =C2=A0		retval =3D -EFAULT;
> =C2=A0	kfree(handle);
> =C2=A0	return retval;
> @@ -83,6 +94,7 @@ static long do_sys_name_to_handle(const struct path *pa=
th,
> =C2=A0 * @name: name that should be converted to handle.
> =C2=A0 * @handle: resulting file handle
> =C2=A0 * @mnt_id: mount id of the file system containing the file
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u64 if AT_HAND=
LE_MNT_ID_UNIQUE, otherwise int)
> =C2=A0 * @flag: flag value to indicate whether to follow symlink or not
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and whether a decodabl=
e file handle is required.
> =C2=A0 *
> @@ -92,7 +104,7 @@ static long do_sys_name_to_handle(const struct path *p=
ath,
> =C2=A0 * value required.
> =C2=A0 */
> =C2=A0SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, n=
ame,
> -		struct file_handle __user *, handle, int __user *, mnt_id,
> +		struct file_handle __user *, handle, void __user *, mnt_id,
> =C2=A0		int, flag)
> =C2=A0{
> =C2=A0	struct path path;
> @@ -100,7 +112,8 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const ch=
ar __user *, name,
> =C2=A0	int fh_flags;
> =C2=A0	int err;
> =C2=A0
> -	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID))
> +	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
> +		=C2=A0=C2=A0=C2=A0=C2=A0 AT_HANDLE_MNT_ID_UNIQUE))
> =C2=A0		return -EINVAL;
> =C2=A0
> =C2=A0	lookup_flags =3D (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
> @@ -109,7 +122,9 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const ch=
ar __user *, name,
> =C2=A0		lookup_flags |=3D LOOKUP_EMPTY;
> =C2=A0	err =3D user_path_at(dfd, name, lookup_flags, &path);
> =C2=A0	if (!err) {
> -		err =3D do_sys_name_to_handle(&path, handle, mnt_id, fh_flags);
> +		err =3D do_sys_name_to_handle(&path, handle, mnt_id,
> +					=C2=A0=C2=A0=C2=A0 flag & AT_HANDLE_MNT_ID_UNIQUE,
> +					=C2=A0=C2=A0=C2=A0 fh_flags);
> =C2=A0		path_put(&path);
> =C2=A0	}
> =C2=A0	return err;
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 4bcf6754738d..5758104921e6 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -870,7 +870,7 @@ asmlinkage long sys_fanotify_mark(int fanotify_fd, un=
signed int flags,
> =C2=A0#endif
> =C2=A0asmlinkage long sys_name_to_handle_at(int dfd, const char __user *n=
ame,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file_handle __user *handl=
e,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int __user *mnt_id, int flag);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __user *mnt_id, int flag);
> =C2=A0asmlinkage long sys_open_by_handle_at(int mountdirfd,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file_handle __user *handl=
e,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags);
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 38a6d66d9e88..87e2dec79fea 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -152,6 +152,7 @@
> =C2=A0#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
> =C2=A0					=C2=A0=C2=A0 object identity and may not be
> =C2=A0					=C2=A0=C2=A0 usable with open_by_handle_at(2). */
> +#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID.=
 */
> =C2=A0
> =C2=A0#if defined(__KERNEL__)
> =C2=A0#define AT_GETATTR_NOSEC	0x80000000
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/p=
erf/trace/beauty/include/uapi/linux/fcntl.h
> index 38a6d66d9e88..87e2dec79fea 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> @@ -152,6 +152,7 @@
> =C2=A0#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
> =C2=A0					=C2=A0=C2=A0 object identity and may not be
> =C2=A0					=C2=A0=C2=A0 usable with open_by_handle_at(2). */
> +#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID.=
 */
> =C2=A0
> =C2=A0#if defined(__KERNEL__)
> =C2=A0#define AT_GETATTR_NOSEC	0x80000000
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

