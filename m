Return-Path: <linux-fsdevel+bounces-56416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D4B17326
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC40177B6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E99716F8E9;
	Thu, 31 Jul 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="fSxhT26R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E72F24;
	Thu, 31 Jul 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971723; cv=none; b=KgyX3WVZ7HrO7lUIQ7Sg5m+HZ2pjE237dmRpvTmnUkecG4AWMWa0F35dJZUuzaMVyS8Kb+ghZKJaUYGozF2itgudnxQ89uRnz9V5bAAR3iv145aZ3LgqMa9NdjdcB1SAR+OFC8uyeIu9qBwBABkUAL0igLJmuHYlCLBP/JitgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971723; c=relaxed/simple;
	bh=IraNA8HTuhadpvynlNEEmtD7drpccg1KpgtEBN3GQWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFxVGh0GcMe+w2uE6oeVVLU095BEWXEzk1Ci193e1igaDdN13U3x8HsogqVa1bnqTrgNVRMDyfRmza9sztKLtbWk9NXDd8g8zmQ6rJyAHhgx5zODGs5/Dv8CNnEzA11cU83PcqKQ8vvEIE2l3Q4pgpCUZbY29SxnAsMmehTOSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=fSxhT26R; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4btB9C2WM7z9sQm;
	Thu, 31 Jul 2025 16:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753971711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nx7s0z1EH5FszrdcRN7llIs5P/UhYM04dWI3hk+qTCc=;
	b=fSxhT26R7FIdX7IsYL6TTqWc7hAA8xDFEG7EooVGRkH4Xvx17IgMaxM9Nx5o5ce8bgXYhE
	SxtHz2Sxy96iUsi0+CyrFad/uWxefqow3XNHHuJ8R3Z6XTYLt7zxifpbtiQYqOgXcLnpHQ
	ITXjikMtUK8NUBdfL1EW8vrL6HQKJbDIOJrAbaOzG1wSN3uKmskmwpaSP7BykvGwr5inyv
	40JO2o+wdhzOLuwyrCH7PJNXMPZbQK3LXusXsDAuYHjRBWAYBOYmCLU2xv3Hm4b/YOM90u
	ZQSqMTxdJMfR6uOBWcS9lfkJRRxJvm2JO47853ZKmXPDTOd3iMLnaAQV00lRTQ==
Date: Fri, 1 Aug 2025 00:21:37 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Message-ID: <2025-07-31.1753971633-unlucky-spatula-dismal-smirk-chalky-beasts-Secy8D@cyphar.com>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
 <20250723-procfs-pidns-api-v2-3-621e7edd8e40@cyphar.com>
 <20250724-beobachten-verfassen-9a39c0318341@brauner>
 <2025-07-25.1753409614-vile-track-icky-epidemic-frail-antidote-d7NYuu@cyphar.com>
 <20250731-angliederung-mahlt-9e5811969817@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqlqvmb7rrrsrgkq"
Content-Disposition: inline
In-Reply-To: <20250731-angliederung-mahlt-9e5811969817@brauner>


--vqlqvmb7rrrsrgkq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
MIME-Version: 1.0

On 2025-07-31, Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Jul 25, 2025 at 12:24:28PM +1000, Aleksa Sarai wrote:
> > On 2025-07-24, Christian Brauner <brauner@kernel.org> wrote:
> > > On Wed, Jul 23, 2025 at 09:18:53AM +1000, Aleksa Sarai wrote:
> > > > /proc has historically had very opaque semantics about PID namespac=
es,
> > > > which is a little unfortunate for container runtimes and other prog=
rams
> > > > that deal with switching namespaces very often. One common issue is=
 that
> > > > of converting between PIDs in the process's namespace and PIDs in t=
he
> > > > namespace of /proc.
> > > >=20
> > > > In principle, it is possible to do this today by opening a pidfd wi=
th
> > > > pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
> > > > contain a PID value translated to the pid namespace associated with=
 that
> > > > procfs superblock). However, allocating a new file for each PID to =
be
> > > > converted is less than ideal for programs that may need to scan pro=
cfs,
> > > > and it is generally useful for userspace to be able to finally get =
this
> > > > information from procfs.
> > > >=20
> > > > So, add a new API for this in the form of an ioctl(2) you can call =
on
> > > > the root directory of procfs. The returned file descriptor will have
> > > > O_CLOEXEC set. This acts as a sister feature to the new "pidns" mou=
nt
> > > > option, finally allowing userspace full control of the pid namespac=
es
> > > > associated with procfs instances.
> > > >=20
> > > > The permission model for this is a bit looser than that of the "pid=
ns"
> > > > mount option, but this is mainly because /proc/1/ns/pid provides the
> > > > same information, so as long as you have access to that magic-link =
(or
> > > > something equivalently reasonable such as privileges with CAP_SYS_A=
DMIN
> > > > or being in an ancestor pid namespace) it makes sense to allow user=
space
> > > > to grab a handle. setns(2) will still have their own permission che=
cks,
> > > > so being able to open a pidns handle doesn't really provide too many
> > > > other capabilities.
> > > >=20
> > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > ---
> > > >  Documentation/filesystems/proc.rst |  4 +++
> > > >  fs/proc/root.c                     | 54 ++++++++++++++++++++++++++=
++++++++++--
> > > >  include/uapi/linux/fs.h            |  3 +++
> > > >  3 files changed, 59 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/fil=
esystems/proc.rst
> > > > index c520b9f8a3fd..506383273c9d 100644
> > > > --- a/Documentation/filesystems/proc.rst
> > > > +++ b/Documentation/filesystems/proc.rst
> > > > @@ -2398,6 +2398,10 @@ pidns=3D specifies a pid namespace (either a=
s a string path to something like
> > > >  will be used by the procfs instance when translating pids. By defa=
ult, procfs
> > > >  will use the calling process's active pid namespace.
> > > > =20
> > > > +Processes can check which pid namespace is used by a procfs instan=
ce by using
> > > > +the `PROCFS_GET_PID_NAMESPACE` ioctl() on the root directory of th=
e procfs
> > > > +instance.
> > > > +
> > > >  Chapter 5: Filesystem behavior
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > =20
> > > > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > > > index 057c8a125c6e..548a57ec2152 100644
> > > > --- a/fs/proc/root.c
> > > > +++ b/fs/proc/root.c
> > > > @@ -23,8 +23,10 @@
> > > >  #include <linux/cred.h>
> > > >  #include <linux/magic.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/ptrace.h>
> > > > =20
> > > >  #include "internal.h"
> > > > +#include "../internal.h"
> > > > =20
> > > >  struct proc_fs_context {
> > > >  	struct pid_namespace	*pid_ns;
> > > > @@ -418,15 +420,63 @@ static int proc_root_readdir(struct file *fil=
e, struct dir_context *ctx)
> > > >  	return proc_pid_readdir(file, ctx);
> > > >  }
> > > > =20
> > > > +static long int proc_root_ioctl(struct file *filp, unsigned int cm=
d, unsigned long arg)
> > > > +{
> > > > +	switch (cmd) {
> > > > +#ifdef CONFIG_PID_NS
> > > > +	case PROCFS_GET_PID_NAMESPACE: {
> > > > +		struct pid_namespace *active =3D task_active_pid_ns(current);
> > > > +		struct pid_namespace *ns =3D proc_pid_ns(file_inode(filp)->i_sb);
> > > > +		bool can_access_pidns =3D false;
> > > > +
> > > > +		/*
> > > > +		 * If we are in an ancestors of the pidns, or have join
> > > > +		 * privileges (CAP_SYS_ADMIN), then it makes sense that we
> > > > +		 * would be able to grab a handle to the pidns.
> > > > +		 *
> > > > +		 * Otherwise, if there is a root process, then being able to
> > > > +		 * access /proc/$pid/ns/pid is equivalent to this ioctl and so
> > > > +		 * we should probably match the permission model. For empty
> > > > +		 * namespaces it seems unlikely for there to be a downside to
> > > > +		 * allowing unprivileged users to open a handle to it (setns
> > > > +		 * will fail for unprivileged users anyway).
> > > > +		 */
> > > > +		can_access_pidns =3D pidns_is_ancestor(ns, active) ||
> > > > +				   ns_capable(ns->user_ns, CAP_SYS_ADMIN);
> > >=20
> > > This seems to imply that if @ns is a descendant of @active that the
> > > caller holds privileges over it. Is that actually always true?
> > >=20
> > > IOW, why is the check different from the previous pidns=3D mount opti=
on
> > > check. I would've expected:
> > >=20
> > > ns_capable(_no_audit)(ns->user_ns) && pidns_is_ancestor(ns, active)
> > >=20
> > > and then the ptrace check as a fallback.
> >=20
> > That would mirror pidns_install(), and I did think about it. The primary
> > (mostly handwave-y) reasoning I had for making it less strict was that:
> >=20
> >  * If you are in an ancestor pidns, then you can already see those
> >    processes in your own /proc. In theory that means that you will be
> >    able to access /proc/$pid/ns/pid for at least some subprocess there
> >    (even if some subprocesses have SUID_DUMP_DISABLE, that flag is
> >    cleared on ).
> >=20
> >    Though hypothetically if they are all running as a different user,
> >    this does not apply (and you could create scenarios where a child
> >    pidns is owned by a userns that you do not have privileges over -- if
> >    you deal with setuid binaries). Maybe that risk means we should just
> >    combine them, I'm not sure.
> >=20
> >  * If you have CAP_SYS_ADMIN permissions over the pidns, it seems
> >    strange to disallow access even if it is not in an ancestor
> >    namespace. This is distinct to pidns_install(), where you want to
> >    ensure you cannot escape to a parent pid namespace, this is about
> >    getting a handle to do other operations (i.e. NS_GET_{P,TG}ID_*_PIDN=
S).
> >=20
> > Maybe they should be combined to match pidns_install(), but then I would
> > expect the ptrace_may_access() check to apply to all processes in the
> > pidns to make it less restrictive, which is not something you can
> > practically do (and there is a higher chance that pid1 will have
> > SUID_DUMP_DISABLE than some random subprocess, which almost certainly
> > will not be SUID_DUMP_DISABLE).
> >=20
> > Fundamentally, I guess I'm still trying to see what the risk is of
> > allowing a process to get a handle to a pidns that they have some kind
> > of privilege over (whether it's CAP_SYS_ADMIN, or by the virtue of being
>=20
> There shouldn't be. For example, you kinda implicitly do that with a
> pidfd, no? Because you can pass the pidfd to setns() instead of a
> namespace fd itself. Maybe that's the argument you're lookin for?

That argument works for me! I'll rewrite the commit message to make sure
it sounds like I came up with it. ;)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--vqlqvmb7rrrsrgkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaIt78QAKCRAol/rSt+lE
b4KJAP9yYgg+3KR8dfc439kDY8r9NIKyuj6dnu3tOYDwDw54KQD/WA6Kev9V9C0u
YQgoYZsOxr+MhZz9igC+/6ZSuFIAXg0=
=WpMr
-----END PGP SIGNATURE-----

--vqlqvmb7rrrsrgkq--

