Return-Path: <linux-fsdevel+bounces-31489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7C69976EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46841F244D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759A1A4AA1;
	Wed,  9 Oct 2024 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="AZtdaNgA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2F13AA27;
	Wed,  9 Oct 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507051; cv=none; b=onUmJLDkFd79X4YG0crpK3mmbGS8TwRb5qBssCtDZmQXdvudZVxnlpR3GtwdnnxJn+b42buZax0oayAObqAmf4wmoRiCk9cfaoJ1yLJTb5PALYpTQb+fIioJXweilkakHIdTRgN3CNVGyxgoPEcQF/y/Yd5N4eojiKiWo35f+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507051; c=relaxed/simple;
	bh=oWkAe6oHQBar7bqi4lKh0QT5Q13cHwY6Mog4HckC4gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6Erev0VMyUj9tDi2TSmjp74a/ZrUDBHe2m7G020P3XEQ+k/qU9heW0HrKsR1gn0BkNE2KLFStCiPButqiAAQv7cEQq6vC0dybGtLugU3dplaS+FSO5s7uzXggsotzCZ9Fn80UOS94uXES58MVLFvShY4/UdqUDYd6rXYI9acC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=AZtdaNgA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XP4m42VsRz9tc8;
	Wed,  9 Oct 2024 22:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728507044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8blDJTKr+NSocRarQOzCN0HAvMGYy058z/lgqfKycKc=;
	b=AZtdaNgAYJjUCHqYKypjoGIDcXbt5VJyU90J6br4WXHn4LYygKnsHQ14XZS0utvJXyEjgq
	khCO5fsWTSReK+OxGFPJERNKvu8DfijYMFD6TmT0F+6HWbxpwok0BAqaZKt4zPq7HltXw2
	1ofQRjWYy/3B1p9BMucMrDE6fzyWrOiKrFdDlCb3tzLZ2VaPQwLrsJmfL8h1/mz3+PfZs/
	NoOzLVzVx6WeWZsM5bwB1VxZkLdgTS6YNELF9eCYtMV3TTFsX4AigLppX7CvZInHYubJmu
	zvt5wH/QZMKiq6F5NT0ODKQ7EpbqDvlB/REG4GUvkPVs5lhfgI1AZMsU+r6bdQ==
Date: Thu, 10 Oct 2024 07:50:36 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: luca.boccassi@gmail.com
Cc: linux-fsdevel@vger.kernel.org, christian@brauner.io, 
	linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241009.202933-chewy.sheen.spooky.icons-4WcDot1Idx9@cyphar.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nhsahgt5tmlv63lp"
Content-Disposition: inline
In-Reply-To: <20241008121930.869054-1-luca.boccassi@gmail.com>


--nhsahgt5tmlv63lp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-08, luca.boccassi@gmail.com <luca.boccassi@gmail.com> wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
>=20
> A common pattern when using pid fds is having to get information
> about the process, which currently requires /proc being mounted,
> resolving the fd to a pid, and then do manual string parsing of
> /proc/N/status and friends. This needs to be reimplemented over
> and over in all userspace projects (e.g.: I have reimplemented
> resolving in systemd, dbus, dbus-daemon, polkit so far), and
> requires additional care in checking that the fd is still valid
> after having parsed the data, to avoid races.
>=20
> Having a programmatic API that can be used directly removes all
> these requirements, including having /proc mounted.
>=20
> As discussed at LPC24, add an ioctl with an extensible struct
> so that more parameters can be added later if needed. Start with
> returning pid/tgid/ppid and creds unconditionally, and cgroupid
> optionally.
>=20
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> v9: drop result_mask and reuse request_mask instead
> v8: use RAII guard for rcu, call put_cred()
> v7: fix RCU issue and style issue introduced by v6 found by reviewer
> v6: use rcu_read_lock() when fetching cgroupid, use task_ppid_nr_ns() to
>     get the ppid, return ESCHR if any of pid/tgid/ppid are 0 at the end
>     of the call to avoid providing incomplete data, document what the
>     callers should expect
> v5: check again that the task hasn't exited immediately before copying
>     the result out to userspace, to ensure we are not returning stale data
>     add an ifdef around the cgroup structs usage to fix build errors when
>     the feature is disabled
> v4: fix arg check in pidfd_ioctl() by moving it after the new call
> v3: switch from pid_vnr() to task_pid_vnr()
> v2: Apply comments from Christian, apart from the one about pid namespaces
>     as I need additional hints on how to implement it.
>     Drop the security_context string as it is not the appropriate
>     metadata to give userspace these days.
>=20
>  fs/pidfs.c                                    | 88 ++++++++++++++++++-
>  include/uapi/linux/pidfd.h                    | 30 +++++++
>  .../testing/selftests/pidfd/pidfd_open_test.c | 80 ++++++++++++++++-
>  3 files changed, 194 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 80675b6bf884..15cdc7fe4968 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -2,6 +2,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/cgroup.h>
>  #include <linux/magic.h>
>  #include <linux/mount.h>
>  #include <linux/pid.h>
> @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, struct=
 poll_table_struct *pts)
>  	return poll_flags;
>  }
> =20
> +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsig=
ned long arg)
> +{
> +	struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg;
> +	size_t usize =3D _IOC_SIZE(cmd);
> +	struct pidfd_info kinfo =3D {};
> +	struct user_namespace *user_ns;
> +	const struct cred *c;
> +	__u64 request_mask;
> +
> +	if (!uinfo)
> +		return -EINVAL;
> +	if (usize < sizeof(struct pidfd_info))
> +		return -EINVAL; /* First version, no smaller struct possible */
> +
> +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_=
mask)))
> +		return -EFAULT;
> +
> +	c =3D get_task_cred(task);
> +	if (!c)
> +		return -ESRCH;
> +
> +	/* Unconditionally return identifiers and credentials, the rest only on=
 request */
> +
> +	user_ns =3D current_user_ns();
> +	kinfo.ruid =3D from_kuid_munged(user_ns, c->uid);
> +	kinfo.rgid =3D from_kgid_munged(user_ns, c->gid);
> +	kinfo.euid =3D from_kuid_munged(user_ns, c->euid);
> +	kinfo.egid =3D from_kgid_munged(user_ns, c->egid);
> +	kinfo.suid =3D from_kuid_munged(user_ns, c->suid);
> +	kinfo.sgid =3D from_kgid_munged(user_ns, c->sgid);
> +	kinfo.fsuid =3D from_kuid_munged(user_ns, c->fsuid);
> +	kinfo.fsgid =3D from_kgid_munged(user_ns, c->fsgid);
> +	put_cred(c);
> +
> +#ifdef CONFIG_CGROUPS
> +	if (request_mask & PIDFD_INFO_CGROUPID) {
> +		struct cgroup *cgrp;
> +
> +		guard(rcu)();
> +		cgrp =3D task_cgroup(task, pids_cgrp_id);
> +		if (!cgrp)
> +			return -ENODEV;
> +		kinfo.cgroupid =3D cgroup_id(cgrp);
> +
> +		kinfo.request_mask |=3D PIDFD_INFO_CGROUPID;
> +	}
> +#endif
> +
> +	/*
> +	 * Copy pid/tgid last, to reduce the chances the information might be
> +	 * stale. Note that it is not possible to ensure it will be valid as the
> +	 * task might return as soon as the copy_to_user finishes, but that's ok
> +	 * and userspace expects that might happen and can act accordingly, so
> +	 * this is just best-effort. What we can do however is checking that all
> +	 * the fields are set correctly, or return ESRCH to avoid providing
> +	 * incomplete information. */
> +
> +	kinfo.ppid =3D task_ppid_nr_ns(task, NULL);
> +	kinfo.tgid =3D task_tgid_vnr(task);
> +	kinfo.pid =3D task_pid_vnr(task);
> +
> +	if (kinfo.pid =3D=3D 0 || kinfo.tgid =3D=3D 0 || (kinfo.ppid =3D=3D 0 &=
& kinfo.pid !=3D 1))
> +		return -ESRCH;
> +
> +	/*
> +	 * If userspace and the kernel have the same struct size it can just
> +	 * be copied. If userspace provides an older struct, only the bits that
> +	 * userspace knows about will be copied. If userspace provides a new
> +	 * struct, only the bits that the kernel knows about will be copied and
> +	 * the size value will be set to the size the kernel knows about.
> +	 */
> +	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> +		return -EFAULT;

If usize > ksize, we also want to clear_user() the trailing bytes to
avoid userspace thinking that any garbage bytes they had are valid.

Also, you mention "the size value" but there is no size in pidfd_info. I
don't think it's actually necessary to include such a field (especially
when you have a statx-like request_mask), but it means you really should
clear the trailing bytes to avoid userspace bugs.

I implemented all of these semantics as copy_struct_to_user() in the
CHECK_FIELDS patch I sent a few weeks ago (I just sent v3[1]). Maybe you
can cherry-pick this patch and use it? The semantics when we extend this
pidfd_info to accept new request_mask values with larger structures is
going to get a little ugly and copy_struct_to_user() makes this a little
easier to deal with.

[1]: https://lore.kernel.org/all/20241010-extensible-structs-check_fields-v=
3-1-d2833dfe6edd@cyphar.com/

> +
> +	return 0;
> +}
> +
>  static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned lo=
ng arg)
>  {
>  	struct task_struct *task __free(put_task) =3D NULL;
> @@ -122,13 +200,17 @@ static long pidfd_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
>  	struct ns_common *ns_common =3D NULL;
>  	struct pid_namespace *pid_ns;
> =20
> -	if (arg)
> -		return -EINVAL;
> -
>  	task =3D get_pid_task(pid, PIDTYPE_PID);
>  	if (!task)
>  		return -ESRCH;
> =20
> +	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
> +	if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
> +		return pidfd_info(task, cmd, arg);
> +
> +	if (arg)
> +		return -EINVAL;
> +
>  	scoped_guard(task_lock, task) {
>  		nsp =3D task->nsproxy;
>  		if (nsp)
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 565fc0629fff..d685eeeedc51 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -16,6 +16,35 @@
>  #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
>  #define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
> =20
> +/* Flags for pidfd_info. */
> +#define PIDFD_INFO_CGROUPID		(1UL << 0)

While it isn't strictly necessary, maybe we should provide some
always-set bits like statx does? While they would always be set, it
might incentivise programs to write code that checks if the request_mask
bits are set after the ioctl(2) returns from the outset. Then again,
PIDFD_INFO_CGROUPID is probably enough to justify writing code correctly
=66rom the outset.

> +
> +struct pidfd_info {
> +	/* Let userspace request expensive stuff explictly, and let the kernel
> +	 * indicate whether it knows about it. */

I would prefer a slightly more informative comment (which mentions that
this will also be used for extensibility), something like:


/*
 * This mask is similar to the request_mask in statx(2).
 *
 * Userspace indicates what extensions or expensive-to-calculate fields
 * they want by setting the corresponding bits in request_mask.
 *
 * When filling the structure, the kernel will only set bits
 * corresponding to the fields that were actually filled by the kernel.
 * This also includes any future extensions that might be automatically
 * filled. If the structure size is too small to contain a field
 * (requested or not), to avoid confusion the request_mask will not
 * contain a bit for that field.
 *
 * As such, userspace MUST verify that request_mask contains the
 * corresponding flags after the ioctl(2) returns to ensure that it is
 * using valid data.
 */


The bit about request_mask not containing a bit if the structure size is
too small is one of the things that copy_struct_to_user() helps with
implementing (see the patch for some more docs).

> +	__u64 request_mask;
> +	/*
> +	 * The information contained in the following fields might be stale at =
the
> +	 * time it is received, as the target process might have exited as soon=
 as
> +	 * the IOCTL was processed, and there is no way to avoid that. However,=
 it
> +	 * is guaranteed that if the call was successful, then the information =
was
> +	 * correct and referred to the intended process at the time the work was
> +	 * performed. */
> +	__u64 cgroupid;
> +	__u32 pid;
> +	__u32 tgid;
> +	__u32 ppid;
> +	__u32 ruid;
> +	__u32 rgid;
> +	__u32 euid;
> +	__u32 egid;
> +	__u32 suid;
> +	__u32 sgid;
> +	__u32 fsuid;
> +	__u32 fsgid;
> +	__u32 spare0[1];
> +};
> +
>  #define PIDFS_IOCTL_MAGIC 0xFF
> =20
>  #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
> @@ -28,5 +57,6 @@
>  #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
>  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
>  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> +#define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 1=
1, struct pidfd_info)
> =20
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/test=
ing/selftests/pidfd/pidfd_open_test.c
> index c62564c264b1..b2a8cfb19a74 100644
> --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> @@ -13,6 +13,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> +#include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/wait.h>
> @@ -21,6 +22,34 @@
>  #include "pidfd.h"
>  #include "../kselftest.h"
> =20
> +#ifndef PIDFS_IOCTL_MAGIC
> +#define PIDFS_IOCTL_MAGIC 0xFF
> +#endif
> +
> +#ifndef PIDFD_GET_INFO
> +#define PIDFD_GET_INFO _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
> +#define PIDFD_INFO_CGROUPID		(1UL << 0)
> +
> +struct pidfd_info {
> +	/* Let userspace request expensive stuff explictly, and let the kernel
> +	 * indicate whether it knows about it. */
> +	__u64 request_mask;
> +	__u64 cgroupid;
> +	__u32 pid;
> +	__u32 tgid;
> +	__u32 ppid;
> +	__u32 ruid;
> +	__u32 rgid;
> +	__u32 euid;
> +	__u32 egid;
> +	__u32 suid;
> +	__u32 sgid;
> +	__u32 fsuid;
> +	__u32 fsgid;
> +	__u32 spare0[1];
> +};
> +#endif
> +
>  static int safe_int(const char *numstr, int *converted)
>  {
>  	char *err =3D NULL;
> @@ -120,10 +149,13 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, co=
nst char *key, size_t keylen)
> =20
>  int main(int argc, char **argv)
>  {
> +	struct pidfd_info info =3D {
> +		.request_mask =3D PIDFD_INFO_CGROUPID,
> +	};
>  	int pidfd =3D -1, ret =3D 1;
>  	pid_t pid;
> =20
> -	ksft_set_plan(3);
> +	ksft_set_plan(4);
> =20
>  	pidfd =3D sys_pidfd_open(-1, 0);
>  	if (pidfd >=3D 0) {
> @@ -153,6 +185,52 @@ int main(int argc, char **argv)
>  	pid =3D get_pid_from_fdinfo_file(pidfd, "Pid:", sizeof("Pid:") - 1);
>  	ksft_print_msg("pidfd %d refers to process with pid %d\n", pidfd, pid);
> =20
> +	if (ioctl(pidfd, PIDFD_GET_INFO, &info) < 0) {
> +		ksft_print_msg("%s - failed to get info from pidfd\n", strerror(errno)=
);
> +		goto on_error;
> +	}
> +	if (info.pid !=3D pid) {
> +		ksft_print_msg("pid from fdinfo file %d does not match pid from ioctl =
%d\n",
> +			       pid, info.pid);
> +		goto on_error;
> +	}
> +	if (info.ppid !=3D getppid()) {
> +		ksft_print_msg("ppid %d does not match ppid from ioctl %d\n",
> +			       pid, info.pid);
> +		goto on_error;
> +	}
> +	if (info.ruid !=3D getuid()) {
> +		ksft_print_msg("uid %d does not match uid from ioctl %d\n",
> +			       getuid(), info.ruid);
> +		goto on_error;
> +	}
> +	if (info.rgid !=3D getgid()) {
> +		ksft_print_msg("gid %d does not match gid from ioctl %d\n",
> +			       getgid(), info.rgid);
> +		goto on_error;
> +	}
> +	if (info.euid !=3D geteuid()) {
> +		ksft_print_msg("euid %d does not match euid from ioctl %d\n",
> +			       geteuid(), info.euid);
> +		goto on_error;
> +	}
> +	if (info.egid !=3D getegid()) {
> +		ksft_print_msg("egid %d does not match egid from ioctl %d\n",
> +			       getegid(), info.egid);
> +		goto on_error;
> +	}
> +	if (info.suid !=3D geteuid()) {
> +		ksft_print_msg("suid %d does not match suid from ioctl %d\n",
> +			       geteuid(), info.suid);
> +		goto on_error;
> +	}
> +	if (info.sgid !=3D getegid()) {
> +		ksft_print_msg("sgid %d does not match sgid from ioctl %d\n",
> +			       getegid(), info.sgid);
> +		goto on_error;
> +	}
> +	ksft_test_result_pass("get info from pidfd test: passed\n");
> +
>  	ret =3D 0;
> =20
>  on_error:
>=20
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> --=20
> 2.45.2
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nhsahgt5tmlv63lp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZwbsnAAKCRAol/rSt+lE
bxHIAP43A1Y93iXxqC2dp0UC9S8ens82SC3FYdTA8+Em+8Zj6gD/UhO+OXYFDjIG
k3R9rz06qTjwj8dCOvUjMQNxN/TRegU=
=ev03
-----END PGP SIGNATURE-----

--nhsahgt5tmlv63lp--

