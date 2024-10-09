Return-Path: <linux-fsdevel+bounces-31491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5498E9976F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE731F248A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575B1E260A;
	Wed,  9 Oct 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Uag3j7SZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0D188926;
	Wed,  9 Oct 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507152; cv=none; b=RJlnDt0pzXCFI3cbLoL8UU6EentTcWXX1+hWcuhxAhqJTvZ0/HvjfBgbSURTHZaNSENnMN2v7SI7Dlojhi4/ZMhM+bG5V2hGW32MCr8I3Amy/NyvkpTTYSxA1YYonskgyU565tYZ9ZIILQ8bTDQeX9WCSL5DHHjd5lwwtJoghfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507152; c=relaxed/simple;
	bh=DXe0nSk4UOS3xOoBy02IUS5IT5Af0zijj0s4s+oB2Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkeL+ciWokQMiuZy7OXHx5GTRfWXwvXc+hy6oq5ddmmFJTG95WNbw8zZiaq62bc+LJmK2DJW/hoxTKM6goRWhZFkEnIiJsWYg9QD5zjVwIlapzGwThWu6Y6QVTVcaFdWcLNXBmUkMhZmeFAe1qp17B7qilsCwMamFaCBI5MwA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Uag3j7SZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XP4p25Jpvz9tCV;
	Wed,  9 Oct 2024 22:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728507146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENt63T2mqyJFo/8wMRUgfmolruPGEMaV20ncirwreUs=;
	b=Uag3j7SZaEipa+rEjhusFrEo9nJ5xy6a/nGuQp2JsCeo39vXwjnZe3Nkk1gpJoKFwQJaaC
	cJtPOE0Lgzk3SIoymzD0Neb2uY32NWU2zOhi+lrdzr9Zu+FJJDQktTOLgur2H6+5pY1K0I
	dYYm46fTjve81SYFV4RRHMFkKvQ/bD1bFyHHb1zdAPVRGFnt4P5f9QdqpXiH/kqJIyxN8B
	XrlfH08MlG2sw+Arn/RDQZAfsh6Spl6IMyaKJvZF15Rbwm6Ch5s96CuJ4Mkf8/vCfHXDEs
	pdlaiVm9CCnmCHTn0s0M5E22yqHgRJOsVeECKOamUjTiR2/NeXetp2Ms1YseQQ==
Date: Thu, 10 Oct 2024 07:52:20 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241009.205103-sudsy.thunder.enamel.kennel-kyrq7lTfmNRZ@cyphar.com>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <20241008-parkraum-wegrand-4e42c89b1742@brauner>
 <CAMw=ZnSEwOXw-crX=JmGvYJrQ9C6-v40-swLhALNH0DBPLoyXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dsi44jpzumxx35nr"
Content-Disposition: inline
In-Reply-To: <CAMw=ZnSEwOXw-crX=JmGvYJrQ9C6-v40-swLhALNH0DBPLoyXQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4XP4p25Jpvz9tCV


--dsi44jpzumxx35nr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-08, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> On Tue, 8 Oct 2024 at 14:06, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Oct 08, 2024 at 01:18:20PM GMT, luca.boccassi@gmail.com wrote:
> > > From: Luca Boccassi <luca.boccassi@gmail.com>
> > >
> > > A common pattern when using pid fds is having to get information
> > > about the process, which currently requires /proc being mounted,
> > > resolving the fd to a pid, and then do manual string parsing of
> > > /proc/N/status and friends. This needs to be reimplemented over
> > > and over in all userspace projects (e.g.: I have reimplemented
> > > resolving in systemd, dbus, dbus-daemon, polkit so far), and
> > > requires additional care in checking that the fd is still valid
> > > after having parsed the data, to avoid races.
> > >
> > > Having a programmatic API that can be used directly removes all
> > > these requirements, including having /proc mounted.
> > >
> > > As discussed at LPC24, add an ioctl with an extensible struct
> > > so that more parameters can be added later if needed. Start with
> > > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > > optionally.
> > >
> > > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > ---
> > > v9: drop result_mask and reuse request_mask instead
> > > v8: use RAII guard for rcu, call put_cred()
> > > v7: fix RCU issue and style issue introduced by v6 found by reviewer
> > > v6: use rcu_read_lock() when fetching cgroupid, use task_ppid_nr_ns()=
 to
> > >     get the ppid, return ESCHR if any of pid/tgid/ppid are 0 at the e=
nd
> > >     of the call to avoid providing incomplete data, document what the
> > >     callers should expect
> > > v5: check again that the task hasn't exited immediately before copying
> > >     the result out to userspace, to ensure we are not returning stale=
 data
> > >     add an ifdef around the cgroup structs usage to fix build errors =
when
> > >     the feature is disabled
> > > v4: fix arg check in pidfd_ioctl() by moving it after the new call
> > > v3: switch from pid_vnr() to task_pid_vnr()
> > > v2: Apply comments from Christian, apart from the one about pid names=
paces
> > >     as I need additional hints on how to implement it.
> > >     Drop the security_context string as it is not the appropriate
> > >     metadata to give userspace these days.
> > >
> > >  fs/pidfs.c                                    | 88 +++++++++++++++++=
+-
> > >  include/uapi/linux/pidfd.h                    | 30 +++++++
> > >  .../testing/selftests/pidfd/pidfd_open_test.c | 80 ++++++++++++++++-
> > >  3 files changed, 194 insertions(+), 4 deletions(-)
> > >
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
> > >       return poll_flags;
> > >  }
> > >
> > > +static long pidfd_info(struct task_struct *task, unsigned int cmd, u=
nsigned long arg)
> > > +{
> > > +     struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *=
)arg;
> > > +     size_t usize =3D _IOC_SIZE(cmd);
> > > +     struct pidfd_info kinfo =3D {};
> > > +     struct user_namespace *user_ns;
> > > +     const struct cred *c;
> > > +     __u64 request_mask;
> > > +
> > > +     if (!uinfo)
> > > +             return -EINVAL;
> > > +     if (usize < sizeof(struct pidfd_info))
> > > +             return -EINVAL; /* First version, no smaller struct pos=
sible */
> > > +
> > > +     if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(=
request_mask)))
> > > +             return -EFAULT;
> > > +
> > > +     c =3D get_task_cred(task);
> > > +     if (!c)
> > > +             return -ESRCH;
> > > +
> > > +     /* Unconditionally return identifiers and credentials, the rest=
 only on request */
> > > +
> > > +     user_ns =3D current_user_ns();
> > > +     kinfo.ruid =3D from_kuid_munged(user_ns, c->uid);
> > > +     kinfo.rgid =3D from_kgid_munged(user_ns, c->gid);
> > > +     kinfo.euid =3D from_kuid_munged(user_ns, c->euid);
> > > +     kinfo.egid =3D from_kgid_munged(user_ns, c->egid);
> > > +     kinfo.suid =3D from_kuid_munged(user_ns, c->suid);
> > > +     kinfo.sgid =3D from_kgid_munged(user_ns, c->sgid);
> > > +     kinfo.fsuid =3D from_kuid_munged(user_ns, c->fsuid);
> > > +     kinfo.fsgid =3D from_kgid_munged(user_ns, c->fsgid);
> > > +     put_cred(c);
> > > +
> > > +#ifdef CONFIG_CGROUPS
> > > +     if (request_mask & PIDFD_INFO_CGROUPID) {
> > > +             struct cgroup *cgrp;
> > > +
> > > +             guard(rcu)();
> > > +             cgrp =3D task_cgroup(task, pids_cgrp_id);
> > > +             if (!cgrp)
> > > +                     return -ENODEV;
> >
> > Afaict this means that the task has already exited. In other words, the
> > cgroup id cannot be retrieved anymore for a task that has exited but not
> > been reaped. Frankly, I would have expected the cgroup id to be
> > retrievable until the task has been reaped but that's another
> > discussion.
> >
> > My point is if you contrast this with the other information in here: If
> > the task has exited but hasn't been reaped then you can still get
> > credentials such as *uid/*gid, and pid namespace relative information
> > such as pid/tgid/ppid.
> >
> > So really, I would argue that you don't want to fail this but only
> > report 0 here. That's me working under the assumption that cgroup ids
> > start from 1...
> >
> > /me checks
> >
> > Yes, they start from 1 so 0 is invalid.
> >
> > > +             kinfo.cgroupid =3D cgroup_id(cgrp);
> >
> > Fwiw, it looks like getting the cgroup id is basically just
> > dereferencing pointers without having to hold any meaningful locks. So
> > it should be fast. So making it unconditional seems fine to me.
>=20
> There's an ifdef since it's an optional kernel feature, and there's
> also this thing that we might not have it, so I'd rather keep the
> flag, and set it only if we can get the information (instead of
> failing). As a user that seems clearer to me.

I think we should keep the request_mask flag when returning from the
kernel, but it's not necessary for the user to request it explicitly
because it's cheap to get. This is how STATX_MNT_ID works and I think it
makes sense to do it that way.

(Though there are some complications when we add extensions in the
future -- see my other mail about copy_struct_to_user().)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--dsi44jpzumxx35nr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZwbtBAAKCRAol/rSt+lE
bwL1AQCI/oB6HF8S943TWBwmM5kfndOKMoFRsv1/cj3kzXqFzQD/ZTzEDZgjNtbU
CJ7yfXmXmaXF8UMtCzjm5cOoVS3tRgk=
=uKQ3
-----END PGP SIGNATURE-----

--dsi44jpzumxx35nr--

