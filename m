Return-Path: <linux-fsdevel+bounces-42890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEC6A4AEC1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AB23B2EE0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 02:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B335973;
	Sun,  2 Mar 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="vAuoFMv2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E712B93
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740883224; cv=none; b=YC75E2PGilZAK91W47/TDrB86QS3DNUhnh4SIOS14PcIkppVH35xjDJdrNgZ733U9x2Lily+kdi/BOFKl8PwVgBbDvnVt1jwqC8fkJr3s9N/yDJ74dwD3mRViCIkolCGqLGNnUTWWSdHiW8EN12v18+mK+O/jktqidaug9iCyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740883224; c=relaxed/simple;
	bh=MQhnNjTeIbu+3BMZhAd37MWDWu3EPymlZlYsWmrlawA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhzKIhL+0p4Q3ijoiaDimrns6paK2ul2DDCvLA3zQj7wZ2NkJ5CPt1DflPy8lMn+GUI3NFVVfZMyVJeff63egB6uazeorMylH1WcdU0gJAwPVbXo/woVzY6WN4IuBvKW7bVWHA2jnmQHFkd4Dx8BoAgQ0iM1rlAk82gECwudfko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=vAuoFMv2; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail3; t=1740883219; x=1741142419;
	bh=9iyBgrATsqQFYNmaQ5d0l9EhehIob+BaG2CUADLPDYo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=vAuoFMv21Y1lwQqrVAx+NB7dqUIsJnvKWxxrEgoiTDC26Vnldl6W/xjLdkEC6/gJr
	 O20z7hBjoTQPvpeV6shlkXhs32yTpQFuaEGhpKGrUgyy4Bt6XiKgsBpg5C4bWtNZeR
	 Ov8HMzBlVCtbAN35nYabh2aySPRIORJuXxVdlClEHNhGUHswD8+cTv07d6D986v2ug
	 +C5DFKMM79Y5BxlNXzx2wYZ8gCnIBjHYJ6pEgl+GAUEEhxXLyaBKp+6JNaG2VWmpMs
	 kWhWkAVTbLK9Wl936MaI/ibZsZrSOO8uytpYXl7RXUjEdUrzEAejYMaJi45OeWhB3d
	 eJsCr+cl/zD9Q==
Date: Sun, 02 Mar 2025 02:40:16 +0000
To: "brauner@kernel.org" <brauner@kernel.org>
From: Mike Yuan <me@yhndnzj.com>
Cc: "oleg@redhat.com" <oleg@redhat.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, "lennart@poettering.net" <lennart@poettering.net>, "daan.j.demeyer@gmail.com" <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <PigydyZoBgz1RFKczs1bdoqAZ_78rpjO1GBZLInZupvPRSLnqu3T9HxUdOrskXFBKCf3tXaIO9f9t2n13Pxf8Nu9Gq8JEl1WaxFwgJpdQb4=@yhndnzj.com>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org> <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 60cbb5f67683811d9852a301870625612b057ab0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/28/25 13:44, Christian Brauner <brauner@kernel.org> wrote:

>  Some tools like systemd's jounral need to retrieve the exit and cgroup
>  information after a process has already been reaped. This can e.g.,
>  happen when retrieving a pidfd via SCM_PIDFD or SCM_PEERPIDFD.
> =20
>  Signed-off-by: Christian Brauner <brauner@kernel.org>
>  ---
>   fs/pidfs.c                 | 70 +++++++++++++++++++++++++++++++++++++--=
-------
>   include/uapi/linux/pidfd.h |  3 +-
>   2 files changed, 59 insertions(+), 14 deletions(-)
> =20
>  diff --git a/fs/pidfs.c b/fs/pidfs.c
>  index 433f676c066c..e500bc4c5af2 100644
>  --- a/fs/pidfs.c
>  +++ b/fs/pidfs.c
>  @@ -32,11 +32,12 @@ static struct kmem_cache *pidfs_cachep __ro_after_in=
it;
>    */
>   struct pidfs_exit_info {
>   =09__u64 cgroupid;
>  -=09__u64 exit_code;
>  +=09__s32 exit_code;
>   };
> =20
>   struct pidfs_inode {
>  -=09struct pidfs_exit_info exit_info;
>  +=09struct pidfs_exit_info __pei;
>  +=09struct pidfs_exit_info *exit_info;
>   =09struct inode vfs_inode;
>   };
> =20
>  @@ -228,11 +229,14 @@ static __poll_t pidfd_poll(struct file *file, stru=
ct poll_table_struct *pts)
>   =09return poll_flags;
>   }
> =20
>  -static long pidfd_info(struct task_struct *task, unsigned int cmd, unsi=
gned long arg)
>  +static long pidfd_info(struct file *file, struct task_struct *task,
>  +=09=09       unsigned int cmd, unsigned long arg)
>   {
>   =09struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg;
>   =09size_t usize =3D _IOC_SIZE(cmd);
>   =09struct pidfd_info kinfo =3D {};
>  +=09struct pidfs_exit_info *exit_info;
>  +=09struct inode *inode =3D file_inode(file);
>   =09struct user_namespace *user_ns;
>   =09const struct cred *c;
>   =09__u64 mask;
>  @@ -248,6 +252,39 @@ static long pidfd_info(struct task_struct *task, un=
signed int cmd, unsigned long
>   =09if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
>   =09=09return -EFAULT;
> =20
>  +=09exit_info =3D READ_ONCE(pidfs_i(inode)->exit_info);
>  +=09if (exit_info) {
>  +=09=09/*
>  +=09=09 * TODO: Oleg, I didn't see a reason for putting
>  +=09=09 * retrieval of the exit status of a task behind some
>  +=09=09 * form of permission check. Maybe there's some
>  +=09=09 * potential concerns with seeing the exit status of a
>  +=09=09 * SIGKILLed suid binary or something but even then I'm
>  +=09=09 * not sure that's a problem.
>  +=09=09 *
>  +=09=09 * If we want this we could put this behind some *uid
>  +=09=09 * check similar to what ptrace access does by recording
>  +=09=09 * parts of the creds we'd need for checking this. But
>  +=09=09 * only if we really need it.
>  +=09=09 */
>  +=09=09kinfo.exit_code =3D exit_info->exit_code;
>  +#ifdef CONFIG_CGROUPS
>  +=09=09kinfo.cgroupid =3D exit_info->cgroupid;
>  +=09=09kinfo.mask |=3D PIDFD_INFO_EXIT | PIDFD_INFO_CGROUPID;
>  +#endif
>  +=09}
>  +
>  +=09/*
>  +=09 * If the task has already been reaped only exit information
>  +=09 * can be provided. It's entirely possible that the task has
>  +=09 * already been reaped but we managed to grab a reference to it
>  +=09 * before that. So a full set of information about @task doesn't
>  +=09 * mean it hasn't been waited upon. Similarly, a full set of
>  +=09 * information doesn't mean that the task hasn't already exited.
>  +=09 */
>  +=09if (!task)
>  +=09=09goto copy_out;
>  +
>   =09c =3D get_task_cred(task);
>   =09if (!c)
>   =09=09return -ESRCH;
>  @@ -267,11 +304,13 @@ static long pidfd_info(struct task_struct *task, u=
nsigned int cmd, unsigned long
>   =09put_cred(c);
> =20
>   #ifdef CONFIG_CGROUPS
>  -=09rcu_read_lock();
>  -=09cgrp =3D task_dfl_cgroup(task);
>  -=09kinfo.cgroupid =3D cgroup_id(cgrp);
>  -=09kinfo.mask |=3D PIDFD_INFO_CGROUPID;
>  -=09rcu_read_unlock();
>  +=09if (!kinfo.cgroupid) {
>  +=09=09rcu_read_lock();
>  +=09=09cgrp =3D task_dfl_cgroup(task);
>  +=09=09kinfo.cgroupid =3D cgroup_id(cgrp);
>  +=09=09kinfo.mask |=3D PIDFD_INFO_CGROUPID;
>  +=09=09rcu_read_unlock();
>  +=09}
>   #endif
> =20
>   =09/*
>  @@ -291,6 +330,7 @@ static long pidfd_info(struct task_struct *task, uns=
igned int cmd, unsigned long
>   =09if (kinfo.pid =3D=3D 0 || kinfo.tgid =3D=3D 0 || (kinfo.ppid =3D=3D =
0 && kinfo.pid !=3D 1))
>   =09=09return -ESRCH;
> =20
>  +copy_out:
>   =09/*
>   =09 * If userspace and the kernel have the same struct size it can just
>   =09 * be copied. If userspace provides an older struct, only the bits t=
hat
>  @@ -341,12 +381,13 @@ static long pidfd_ioctl(struct file *file, unsigne=
d int cmd, unsigned long arg)
>   =09}
> =20
>   =09task =3D get_pid_task(pid, PIDTYPE_PID);
>  -=09if (!task)
>  -=09=09return -ESRCH;

Hmm, this breaks our current assumption/assertion on the API in systemd (se=
e pidfd_get_pid_ioctl() in basic/pidfd-util.c).
Moreover, it now imposes an inconsistency: if the pidfd refers to a process=
 from foreign pidns, the current impl treats it as if the process didn't ex=
ist, and returns -ESRCH. Now a truly exited task deviates from that...

I'd prefer to retain the current behavior of returning -ESRCH unless PIDFD_=
INFO_EXIT is specified in mask, in which case it's then guaranteed that -ES=
RCH would never be seen. IOW the caller should be explicit on what they wan=
t, which feels semantically more reasonable to me and probably even simpler=
?

> =20
>   =09/* Extensible IOCTL that does not open namespace FDs, take a shortcu=
t */
>   =09if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
>  -=09=09return pidfd_info(task, cmd, arg);
>  +=09=09return pidfd_info(file, task, cmd, arg);
>  +
>  +=09if (!task)
>  +=09=09return -ESRCH;
> =20
>   =09if (arg)
>   =09=09return -EINVAL;
>  @@ -486,7 +527,7 @@ void pidfs_exit(struct task_struct *tsk)
>   =09=09struct cgroup *cgrp;
>   #endif
>   =09=09inode =3D d_inode(dentry);
>  -=09=09exit_info =3D &pidfs_i(inode)->exit_info;
>  +=09=09exit_info =3D &pidfs_i(inode)->__pei;
> =20
>   =09=09/* TODO: Annoy Oleg to tell me how to do this correctly. */
>   =09=09if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
>  @@ -501,6 +542,8 @@ void pidfs_exit(struct task_struct *tsk)
>   =09=09rcu_read_unlock();
>   #endif
> =20
>  +=09=09/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
>  +=09=09smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__=
pei);
>   =09=09dput(dentry);
>   =09}
>   }
>  @@ -568,7 +611,8 @@ static struct inode *pidfs_alloc_inode(struct super_=
block *sb)
>   =09if (!pi)
>   =09=09return NULL;
> =20
>  -=09memset(&pi->exit_info, 0, sizeof(pi->exit_info));
>  +=09memset(&pi->__pei, 0, sizeof(pi->__pei));
>  +=09pi->exit_info =3D NULL;
> =20
>   =09return &pi->vfs_inode;
>   }
>  diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
>  index e0abd0b18841..e5966f1a7743 100644
>  --- a/include/uapi/linux/pidfd.h
>  +++ b/include/uapi/linux/pidfd.h
>  @@ -20,6 +20,7 @@
>   #define PIDFD_INFO_PID=09=09=09(1UL << 0) /* Always returned, even if n=
ot requested */
>   #define PIDFD_INFO_CREDS=09=09(1UL << 1) /* Always returned, even if no=
t requested */
>   #define PIDFD_INFO_CGROUPID=09=09(1UL << 2) /* Always returned if avail=
able, even if not requested */
>  +#define PIDFD_INFO_EXIT=09=09=09(1UL << 3) /* Always returned if availa=
ble, even if not requested */
> =20
>   #define PIDFD_INFO_SIZE_VER0=09=0964 /* sizeof first published struct *=
/
> =20
>  @@ -86,7 +87,7 @@ struct pidfd_info {
>   =09__u32 sgid;
>   =09__u32 fsuid;
>   =09__u32 fsgid;
>  -=09__u32 spare0[1];
>  +=09__s32 exit_code;
>   };
> =20
>   #define PIDFS_IOCTL_MAGIC 0xFF
> =20
>  --
>  2.47.2
> =20
>  

