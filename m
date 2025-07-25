Return-Path: <linux-fsdevel+bounces-56002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406A5B1165E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA779AC2781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795B23496F;
	Fri, 25 Jul 2025 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="qsn8bUit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FF3A8F7;
	Fri, 25 Jul 2025 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410291; cv=none; b=r5HmSpbSc+nmGRyL8Rh7Vw9723vGjyG6HDGoDqAM/J8Z6oCtljRti8mkaQOyei+3I+jmii9KH5vefM3s0QU6Sh5qKR2faYUvPZj9uENFVWPfOsrEiF7mFBYie72Q06sYbzON24GUiUp1Mq136sDlnlCzx7b2lYJKZTm1CXhbpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410291; c=relaxed/simple;
	bh=R0gyDQsE2RK9GbZmbn/aytjFFK2zjfIs2PFOw3ryOUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFbG8zdCOGeVcL98BldCb5CwwWU/X+JHPYdTWY61OFzJvbAnkWmEreSNdfVkqpqvrETB/UlfGzCuUKWErLbwcBsmmzyA6cYMQgiy3x9yhZM6t5u3MoSa+92swZ3LMTtTuAGv/6cUaVMu4uOsQVn5r0W+hoCWnG8/F/cwn98RqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=qsn8bUit; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bpBXR1Fthz9shW;
	Fri, 25 Jul 2025 04:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753410279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMejGemVd5Qb9NzRJlqYEZgyvvRoRW8ILJ/WPpe83j4=;
	b=qsn8bUitlA297yHD6NGUh6FC0bqJm4siYYS/O+rVeRgwVEkEGobUrzt2gBh48jb1BR4NMk
	1sO2TQ8Q5rOs4b9fOZspv7zcnuO3j5jQjhSfQWkO5dSXGuQmWNz7sTR3uv5K+4IJBX8uVB
	hfwLgPSzIVBXV/SMM0EUGW+MDUmHp1zkibiK4/5tgbk/xn+Wf4Q1r7LPk1wZVzya72bLEs
	cCAamoY1C8FcevSiptG3vEhklNpsNUU+qqo2utAl+yI8GUSYdqOfo5bKcEvxK7blNRLaWs
	VJtOTJ/iR5Pe3d5JZawuMCm+n/elG7iw5TxnSctBXx4SOWK9g9bw+wKe0MFTlw==
Date: Fri, 25 Jul 2025 12:24:28 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Message-ID: <2025-07-25.1753409614-vile-track-icky-epidemic-frail-antidote-d7NYuu@cyphar.com>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
 <20250723-procfs-pidns-api-v2-3-621e7edd8e40@cyphar.com>
 <20250724-beobachten-verfassen-9a39c0318341@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irrba6ksnd6hn26k"
Content-Disposition: inline
In-Reply-To: <20250724-beobachten-verfassen-9a39c0318341@brauner>


--irrba6ksnd6hn26k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
MIME-Version: 1.0

On 2025-07-24, Christian Brauner <brauner@kernel.org> wrote:
> On Wed, Jul 23, 2025 at 09:18:53AM +1000, Aleksa Sarai wrote:
> > /proc has historically had very opaque semantics about PID namespaces,
> > which is a little unfortunate for container runtimes and other programs
> > that deal with switching namespaces very often. One common issue is that
> > of converting between PIDs in the process's namespace and PIDs in the
> > namespace of /proc.
> >=20
> > In principle, it is possible to do this today by opening a pidfd with
> > pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
> > contain a PID value translated to the pid namespace associated with that
> > procfs superblock). However, allocating a new file for each PID to be
> > converted is less than ideal for programs that may need to scan procfs,
> > and it is generally useful for userspace to be able to finally get this
> > information from procfs.
> >=20
> > So, add a new API for this in the form of an ioctl(2) you can call on
> > the root directory of procfs. The returned file descriptor will have
> > O_CLOEXEC set. This acts as a sister feature to the new "pidns" mount
> > option, finally allowing userspace full control of the pid namespaces
> > associated with procfs instances.
> >=20
> > The permission model for this is a bit looser than that of the "pidns"
> > mount option, but this is mainly because /proc/1/ns/pid provides the
> > same information, so as long as you have access to that magic-link (or
> > something equivalently reasonable such as privileges with CAP_SYS_ADMIN
> > or being in an ancestor pid namespace) it makes sense to allow userspace
> > to grab a handle. setns(2) will still have their own permission checks,
> > so being able to open a pidns handle doesn't really provide too many
> > other capabilities.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  Documentation/filesystems/proc.rst |  4 +++
> >  fs/proc/root.c                     | 54 ++++++++++++++++++++++++++++++=
++++++--
> >  include/uapi/linux/fs.h            |  3 +++
> >  3 files changed, 59 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index c520b9f8a3fd..506383273c9d 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -2398,6 +2398,10 @@ pidns=3D specifies a pid namespace (either as a =
string path to something like
> >  will be used by the procfs instance when translating pids. By default,=
 procfs
> >  will use the calling process's active pid namespace.
> > =20
> > +Processes can check which pid namespace is used by a procfs instance b=
y using
> > +the `PROCFS_GET_PID_NAMESPACE` ioctl() on the root directory of the pr=
ocfs
> > +instance.
> > +
> >  Chapter 5: Filesystem behavior
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > =20
> > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > index 057c8a125c6e..548a57ec2152 100644
> > --- a/fs/proc/root.c
> > +++ b/fs/proc/root.c
> > @@ -23,8 +23,10 @@
> >  #include <linux/cred.h>
> >  #include <linux/magic.h>
> >  #include <linux/slab.h>
> > +#include <linux/ptrace.h>
> > =20
> >  #include "internal.h"
> > +#include "../internal.h"
> > =20
> >  struct proc_fs_context {
> >  	struct pid_namespace	*pid_ns;
> > @@ -418,15 +420,63 @@ static int proc_root_readdir(struct file *file, s=
truct dir_context *ctx)
> >  	return proc_pid_readdir(file, ctx);
> >  }
> > =20
> > +static long int proc_root_ioctl(struct file *filp, unsigned int cmd, u=
nsigned long arg)
> > +{
> > +	switch (cmd) {
> > +#ifdef CONFIG_PID_NS
> > +	case PROCFS_GET_PID_NAMESPACE: {
> > +		struct pid_namespace *active =3D task_active_pid_ns(current);
> > +		struct pid_namespace *ns =3D proc_pid_ns(file_inode(filp)->i_sb);
> > +		bool can_access_pidns =3D false;
> > +
> > +		/*
> > +		 * If we are in an ancestors of the pidns, or have join
> > +		 * privileges (CAP_SYS_ADMIN), then it makes sense that we
> > +		 * would be able to grab a handle to the pidns.
> > +		 *
> > +		 * Otherwise, if there is a root process, then being able to
> > +		 * access /proc/$pid/ns/pid is equivalent to this ioctl and so
> > +		 * we should probably match the permission model. For empty
> > +		 * namespaces it seems unlikely for there to be a downside to
> > +		 * allowing unprivileged users to open a handle to it (setns
> > +		 * will fail for unprivileged users anyway).
> > +		 */
> > +		can_access_pidns =3D pidns_is_ancestor(ns, active) ||
> > +				   ns_capable(ns->user_ns, CAP_SYS_ADMIN);
>=20
> This seems to imply that if @ns is a descendant of @active that the
> caller holds privileges over it. Is that actually always true?
>=20
> IOW, why is the check different from the previous pidns=3D mount option
> check. I would've expected:
>=20
> ns_capable(_no_audit)(ns->user_ns) && pidns_is_ancestor(ns, active)
>=20
> and then the ptrace check as a fallback.

That would mirror pidns_install(), and I did think about it. The primary
(mostly handwave-y) reasoning I had for making it less strict was that:

 * If you are in an ancestor pidns, then you can already see those
   processes in your own /proc. In theory that means that you will be
   able to access /proc/$pid/ns/pid for at least some subprocess there
   (even if some subprocesses have SUID_DUMP_DISABLE, that flag is
   cleared on ).

   Though hypothetically if they are all running as a different user,
   this does not apply (and you could create scenarios where a child
   pidns is owned by a userns that you do not have privileges over -- if
   you deal with setuid binaries). Maybe that risk means we should just
   combine them, I'm not sure.

 * If you have CAP_SYS_ADMIN permissions over the pidns, it seems
   strange to disallow access even if it is not in an ancestor
   namespace. This is distinct to pidns_install(), where you want to
   ensure you cannot escape to a parent pid namespace, this is about
   getting a handle to do other operations (i.e. NS_GET_{P,TG}ID_*_PIDNS).

Maybe they should be combined to match pidns_install(), but then I would
expect the ptrace_may_access() check to apply to all processes in the
pidns to make it less restrictive, which is not something you can
practically do (and there is a higher chance that pid1 will have
SUID_DUMP_DISABLE than some random subprocess, which almost certainly
will not be SUID_DUMP_DISABLE).

Fundamentally, I guess I'm still trying to see what the risk is of
allowing a process to get a handle to a pidns that they have some kind
of privilege over (whether it's CAP_SYS_ADMIN, or by the virtue of being
able to see and address all processes in the namespace, or by being able
to open /proc/$pidns_pid1/ns/pid anyway) but cannot join.

Then again, maybe the fact that it is kind of strange to explain is
enough of a reason to just make it simpler...

> > +		if (!can_access_pidns) {
> > +			bool cannot_ptrace_pid1 =3D false;
> > +
> > +			read_lock(&tasklist_lock);
> > +			if (ns->child_reaper)
> > +				cannot_ptrace_pid1 =3D ptrace_may_access(ns->child_reaper,
> > +								       PTRACE_MODE_READ_FSCREDS);
> > +			read_unlock(&tasklist_lock);
> > +			can_access_pidns =3D !cannot_ptrace_pid1;
> > +		}
> > +		if (!can_access_pidns)
> > +			return -EPERM;
> > +
> > +		/* open_namespace() unconditionally consumes the reference. */
> > +		get_pid_ns(ns);
> > +		return open_namespace(to_ns_common(ns));
> > +	}
> > +#endif /* CONFIG_PID_NS */
> > +	default:
> > +		return -ENOIOCTLCMD;
> > +	}
> > +}
> > +
> >  /*
> >   * The root /proc directory is special, as it has the
> >   * <pid> directories. Thus we don't use the generic
> >   * directory handling functions for that..
> >   */
> >  static const struct file_operations proc_root_operations =3D {
> > -	.read		 =3D generic_read_dir,
> > -	.iterate_shared	 =3D proc_root_readdir,
> > +	.read		=3D generic_read_dir,
> > +	.iterate_shared	=3D proc_root_readdir,
> >  	.llseek		=3D generic_file_llseek,
> > +	.unlocked_ioctl =3D proc_root_ioctl,
> > +	.compat_ioctl   =3D compat_ptr_ioctl,
> >  };
> > =20
> >  /*
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 0bd678a4a10e..aa642cb48feb 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -437,6 +437,9 @@ typedef int __bitwise __kernel_rwf_t;
> > =20
> >  #define PROCFS_IOCTL_MAGIC 'f'
> > =20
> > +/* procfs root ioctls */
> > +#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 1)
> > +
> >  /* Pagemap ioctl */
> >  #define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
> > =20
> >=20
> > --=20
> > 2.50.0
> >=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--irrba6ksnd6hn26k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaILq3AAKCRAol/rSt+lE
b2ZsAQCYpc1N4JckOptTYOacjdOIF+u5XdQY+FSQKHWRBvCwRQD7BTlWGi2YHzzy
YZY83Iw1DKtFLj3vj18+MI34Wf6g0Qk=
=L8Pd
-----END PGP SIGNATURE-----

--irrba6ksnd6hn26k--

