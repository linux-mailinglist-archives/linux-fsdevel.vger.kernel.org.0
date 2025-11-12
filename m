Return-Path: <linux-fsdevel+bounces-68082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B33C53DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62A4F4E4929
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6662348862;
	Wed, 12 Nov 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE+xa5Uq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAC340DA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970473; cv=none; b=jFakN4ugBs36BbWlxtVz1MDqVZrQ1ePJCWxI4yXKqOSHVPvQGz9V8JxSJ9DxnLbGjrR/VM0rtgmAxBKtz/WBTpCnQR7wRV38+ofShHekstF1T2NwtuhT/vo+/1vM1gF9aPk9qDptzVdCL0+QWZKqEU9jXaIF4DFTlB1likOSxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970473; c=relaxed/simple;
	bh=4qD1jUco1jr47ENGds1DcMO4dfiXyeaiJTxui3XN5t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTtmUZjw7xn7b0pGs+xavuJLuw11z5Q8dqlUGC69o3miLZ6q0k4erDrcZi3OKJ2dsUbeLLH7a+dUic9loQ1sBtYaDdjfVPCqeas41QDHZiKGoKW2e9phq5eadXA7/YvkE/RAbyjDmpca3XC+h+vPNxwZZCXAVNXKREyHKUmTlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE+xa5Uq; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e10d1477afso882782fac.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 10:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970470; x=1763575270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYHff2DoQzWoHno1pJ6Z7AZPPk8OrhvVJJd5+s+K1QA=;
        b=nE+xa5Uq4+9n7+FVxYSxRd01LY3EppjH8NzeSs4Ajo2BB1LTGNogyO3FwxgN2L/nlj
         FqwJe2Htw8NC41uV8QsxpgA2TsV4hpGsBR7hdzkhvIsOGrLJFm7vhfYXZ8FHtD+YUX27
         I+h+z4pSMSyyyNOj0QZ3sT5gphTmTnmGGjL+edEaN2qsJF41ThgXMPiFUwietyioKsUi
         S1aM49305lVOLOzLL4OSU4DqdZw7cV6CoMFGLuw8kN9dlqtCPnkgP6FUdNq9Mq9nP9YR
         U8Sb/3bElUG/m320atUTwYF2tyV5fepZ6DEJPihiGhNxDeOFrq7rEl3//A55X2alPWmG
         I8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970470; x=1763575270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bYHff2DoQzWoHno1pJ6Z7AZPPk8OrhvVJJd5+s+K1QA=;
        b=e2MmzYmkDrp85WR6y2DAA27Hj4cCFoaiTDqfqzW/mtzyC0W4SEeV+Ef4qm5tD9TdhT
         HLSrkx2ckC5WJT7cnc+gszLEyzN1L0bLtyZTYa0QYp4VjvknZvNQzRmT8256B1WwhrPw
         fD9rojLy/DTL2Qje6R2CL9Sj4eRnydJmW3iU8nXerzOfpuQN3zLdKSsjGrD1MAZt14Uu
         0kG8/AhO/C1KDOJUwW7aLA56oQWnIqYF6GCi52n/DDXSuFjJySdFEP0wRhhhp6zl5xl1
         6YQelRaEPe6diq2KtGfF3PG1QtOrdOOU7jZ8FbtXH9ACRjws8gUwPunfqEO7I5ilBj1Q
         zwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIbunXp1o7ih8SjKzdcIt58qnbv50dIYarL6bYWg15CB7SiKOw4r4qaN0v3vapfDnJ2AgmBUrL8vaUkv5g@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYbdEBaGE7KzWeUJIuw052OAd+NbPd6TkL9QkOvSO3BIh2rOm
	shZ+1EP7cCMk3uKzSyfnZQm5nUZLXzuqxoJQvBNkEmpBKwFj8BqBIEcrDB1W/5RI0CZfJaeONjl
	3xcHvCPpdmxhb+wHJLs/bdTTT3kK+DUY=
X-Gm-Gg: ASbGncuc1ie+9qDZ3Of9VdC3PCOgP4O4bT6CPW2FCnE7njOFgPrNMyBvIFdAFz7iow/
	lFL3XhzvvBg6gqjl0daR3Vco/QQ469yvZxVUF636ximmDFITvzyvB4xOwCSvnSZAzTN/7EHFpCX
	yRQEmYgF4mzu7P7zcoTJtRv3o2u2VgXvRiApfAASRuJgMzefhWJ2EdtCiQQ1Bn8WJHrx9mDrLHX
	haA8MJo9ScoPh3rYNO9E6YQC8fHSIW2AJ4dVCsI7AGCUDNt8YJX3TEYbNHbIFbqI7No8vD8CCJn
	RcGxANP2n6hA63ZShIBbjv0=
X-Google-Smtp-Source: AGHT+IF1ABAWiADbaJ5KokPc8XM9rC4iC3qtmBG6QWPxfuxgASEL+w7DHekPkzBrZdqOsGOVj60GWu2qML+pQscx5Vk=
X-Received: by 2002:a05:6871:1c9:b0:3d3:5ea0:5dd3 with SMTP id
 586e51a60fabf-3e833fc8ec2mr1950483fac.10.1762970468945; Wed, 12 Nov 2025
 10:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109053921.1320977-2-b.sachdev1904@gmail.com>
In-Reply-To: <20251109053921.1320977-2-b.sachdev1904@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 12 Nov 2025 10:00:57 -0800
X-Gm-Features: AWmQ_blpB86EJX2qEbD8jXOZ0UVykpyfmWXZSJ5d8AtMIY8m5hyNfayw5ES0u5U
Message-ID: <CANaxB-wjqGDiy523w6s+CDKpC0JbQLsQB6ZipW20jieNPe3G6Q@mail.gmail.com>
Subject: Re: [PATCH v5] statmount: accept fd as a parameter
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Jan Kara <jack@suse.cz>, 
	John Garry <john.g.garry@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 9:40=E2=80=AFPM Bhavik Sachdev <b.sachdev1904@gmail.=
com> wrote:
>
> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_BY_FD
> flag. When a valid fd is provided and STATMOUNT_BY_FD is set, statmount
> will return mountinfo about the mount the fd is on.

It would be great to add self-tests for this new feature in
`tools/testing/selftests/filesystems/statmount/`. These tests would
serve two purposes:
demonstrate the functionality of the new feature and ensure its
continued stability
against future changes.

>
> This even works for "unmounted" mounts (mounts that have been umounted
> using umount2(mnt, MNT_DETACH)), if you have access to a file descriptor
> on that mount. These "umounted" mounts will have no mountpoint hence we
> return "[unmounted]" and the mnt_ns_id to be 0.
>
> Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
> ---
> We would like to add support for checkpoint/restoring file descriptors
> open on these "unmounted" mounts to CRIU (Checkpoint/Restore in
> Userspace) [1].
>
> Currently, we have no way to get mount info for these "unmounted" mounts
> since they do appear in /proc/<pid>/mountinfo and statmount does not
> work on them, since they do not belong to any mount namespace.
>
> This patch helps us by providing a way to get mountinfo for these
> "unmounted" mounts by using a fd on the mount.
>
> Changes from v4 [2] to v5:
> Check only for s->root.mnt to be NULL instead of checking for both
> s->root.mnt and s->root.dentry (I did not find a case where only one of
> them would be NULL).
>
> * Only allow system root (CAP_SYS_ADMIN in init_user_ns) to call
> statmount() on fd's on "unmounted" mounts. We (mostly Pavel) spent some
> time thinking about how our previous approach (of checking the opener's
> file credentials) caused problems.

Probably a bit late to the discussion, but I think it is worth describing a=
ll
these aspects in the commit message.

What specific information reported by `statmount` should be protected by
`CAP_SYS_ADMIN`? We have some precedents where similar information is avail=
able
without capability checks:
* `statfs` can be called on any file descriptor.
* `/proc/<PID>/mountinfo` provides mount information for a process without
  requiring any special capabilities.

Is protecting *all* `statmount` information truly necessary, or could we be
more selective?

>
> Please take a look at the linked pictures they describe everything more
> clearly.
>
> Case 1: A fd is on a normal mount (Link to Picture: [3])
> Consider, a situation where we have two processes P1 and P2 and a file
> F1. F1 is opened on mount ns M1 by P1. P1 is nested inside user
> namespace U1 and U2. P2 is also in U1. P2 is also in a pid namespace and
> mount namespace separate from M1.
>
> P1 sends F1 to P2 (using a unix socket). But, P2 is unable to call
> statmount() on F1 because since it is a separate pid and mount
> namespace. This is good and expected.
>
> Case 2: A fd is on a "unmounted" mount (Link to Picture: [4])
> Consider a similar situation as Case 1. But now F1 is on a mounted that
> has been "unmounted". Now, since we used openers credentials to check
> for permissions P2 ends up having the ability call statmount() and get
> mount info for this "unmounted" mount.
>
> Hence, It is better to restrict the ability to call statmount() on fds
> on "unmounted" mounts to system root only (There could also be other
> cases than the one described above).
>
> Changes from v3 [5] to v4:
> * Change the string returned when there is no mountpoint to be
> "[unmounted]" instead of "[detached]".
> * Remove the new DEFINE_FREE put_file and use the one already present in
> include/linux/file.h (fput) [6].
> * Inside listmount consistently pass 0 in flags to copy_mnt_id_req and
> prepare_klistmount()->grab_requested_mnt_ns() and remove flags from the
> prepare_klistmount prototype.
> * If STATMOUNT_BY_FD is set, check for mnt_ns_id =3D=3D 0 && mnt_id =3D=
=3D 0.
>
> Changes from v2 [7] to v3:
> * Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
> * Fixed UAF bug caused by the reference to fd_mount being bound by scope
> of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
> * Reused @spare parameter in mnt_id_req instead of adding new fields to
> the struct.
>
> Changes from v1 [8] to v2:
> v1 of this patchset, took a different approach and introduced a new
> umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
> their namespace being NULL) thus allowing them to be still available via
> statmount.
>
> Introducing umount_mnt_ns complicated namespace locking and modified
> performance sensitive code [9] and it was agreed upon that fd-based
> statmount would be better.
>
> This code is also available on github [10].
>
> [1]: https://github.com/checkpoint-restore/criu/pull/2754
> [2]: https://lore.kernel.org/all/20251029052037.506273-2-b.sachdev1904@gm=
ail.com/
> [3]: https://github.com/bsach64/linux/blob/statmount-fd-v5/fd_on_normal_m=
ount.png
> [4]: https://github.com/bsach64/linux/blob/statmount-fd-v5/file_on_unmoun=
ted_mount.png
> [5]: https://lore.kernel.org/all/20251024181443.786363-1-b.sachdev1904@gm=
ail.com/
> [6]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/include/linux/file.h#n97
> [7]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sac=
hdev1904@gmail.com/
> [8]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sach=
dev1904@gmail.com/
> [9]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233=
f082d0@virtuozzo.com/
> [10]: https://github.com/bsach64/linux/tree/statmount-fd-v5
> ---
>  fs/namespace.c             | 101 ++++++++++++++++++++++++++-----------
>  include/uapi/linux/mount.h |   7 ++-
>  2 files changed, 77 insertions(+), 31 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..153c0ea85386 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5207,6 +5207,12 @@ static int statmount_mnt_root(struct kstatmount *s=
, struct seq_file *seq)
>         return 0;
>  }
>
> +static int statmount_mnt_point_unmounted(struct kstatmount *s, struct se=
q_file *seq)
> +{
> +       seq_puts(seq, "[unmounted]");
> +       return 0;
> +}
> +
>  static int statmount_mnt_point(struct kstatmount *s, struct seq_file *se=
q)
>  {
>         struct vfsmount *mnt =3D s->mnt;
> @@ -5262,7 +5268,10 @@ static int statmount_sb_source(struct kstatmount *=
s, struct seq_file *seq)
>  static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespa=
ce *ns)
>  {
>         s->sm.mask |=3D STATMOUNT_MNT_NS_ID;
> -       s->sm.mnt_ns_id =3D ns->ns.ns_id;
> +       if (ns)
> +               s->sm.mnt_ns_id =3D ns->ns.ns_id;
> +       else
> +               s->sm.mnt_ns_id =3D 0;
>  }
>
>  static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq=
)
> @@ -5431,7 +5440,10 @@ static int statmount_string(struct kstatmount *s, =
u64 flag)
>                 break;
>         case STATMOUNT_MNT_POINT:
>                 offp =3D &sm->mnt_point;
> -               ret =3D statmount_mnt_point(s, seq);
> +               if (!s->root.mnt)
> +                       ret =3D statmount_mnt_point_unmounted(s, seq);
> +               else
> +                       ret =3D statmount_mnt_point(s, seq);
>                 break;
>         case STATMOUNT_MNT_OPTS:
>                 offp =3D &sm->mnt_opts;
> @@ -5572,29 +5584,33 @@ static int grab_requested_root(struct mnt_namespa=
ce *ns, struct path *root)
>
>  /* locks: namespace_shared */
>  static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
> -                       struct mnt_namespace *ns)
> +                       struct mnt_namespace *ns, unsigned int flags)
>  {
>         struct mount *m;
>         int err;
>
>         /* Has the namespace already been emptied? */
> -       if (mnt_ns_id && mnt_ns_empty(ns))
> +       if (!(flags & STATMOUNT_BY_FD) && mnt_ns_id && mnt_ns_empty(ns))
>                 return -ENOENT;
>
> -       s->mnt =3D lookup_mnt_in_ns(mnt_id, ns);
> -       if (!s->mnt)
> -               return -ENOENT;
> +       if (!(flags & STATMOUNT_BY_FD)) {
> +               s->mnt =3D lookup_mnt_in_ns(mnt_id, ns);
> +               if (!s->mnt)
> +                       return -ENOENT;
> +       }
>
> -       err =3D grab_requested_root(ns, &s->root);
> -       if (err)
> -               return err;
> +       if (ns) {
> +               err =3D grab_requested_root(ns, &s->root);
> +               if (err)
> +                       return err;
> +       }
>
>         /*
>          * Don't trigger audit denials. We just want to determine what
>          * mounts to show users.
>          */
>         m =3D real_mount(s->mnt);
> -       if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
> +       if (ns && !is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
>             !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
>
> @@ -5718,7 +5734,7 @@ static int prepare_kstatmount(struct kstatmount *ks=
, struct mnt_id_req *kreq,
>  }
>
>  static int copy_mnt_id_req(const struct mnt_id_req __user *req,
> -                          struct mnt_id_req *kreq)
> +                          struct mnt_id_req *kreq, unsigned int flags)
>  {
>         int ret;
>         size_t usize;
> @@ -5736,11 +5752,16 @@ static int copy_mnt_id_req(const struct mnt_id_re=
q __user *req,
>         ret =3D copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
>         if (ret)
>                 return ret;
> -       if (kreq->spare !=3D 0)
> -               return -EINVAL;
> -       /* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. *=
/
> -       if (kreq->mnt_id <=3D MNT_UNIQUE_ID_OFFSET)
> -               return -EINVAL;
> +       if (flags & STATMOUNT_BY_FD) {
> +               if (kreq->mnt_id || kreq->mnt_ns_id)
> +                       return -EINVAL;
> +       } else {
> +               if (kreq->fd !=3D 0)
> +                       return -EINVAL;
> +               /* The first valid unique mount id is MNT_UNIQUE_ID_OFFSE=
T + 1. */
> +               if (kreq->mnt_id <=3D MNT_UNIQUE_ID_OFFSET)
> +                       return -EINVAL;
> +       }
>         return 0;
>  }
>
> @@ -5749,20 +5770,21 @@ static int copy_mnt_id_req(const struct mnt_id_re=
q __user *req,
>   * that, or if not simply grab a passive reference on our mount namespac=
e and
>   * return that.
>   */
> -static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_r=
eq *kreq)
> +static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_r=
eq *kreq,
> +                                                  unsigned int flags)
>  {
>         struct mnt_namespace *mnt_ns;
>
> -       if (kreq->mnt_ns_id && kreq->spare)
> +       if (kreq->mnt_ns_id && kreq->fd)
>                 return ERR_PTR(-EINVAL);

>
>         if (kreq->mnt_ns_id)
>                 return lookup_mnt_ns(kreq->mnt_ns_id);
>
> -       if (kreq->spare) {
> +       if (!(flags & STATMOUNT_BY_FD) && kreq->fd) {
>                 struct ns_common *ns;
>
> -               CLASS(fd, f)(kreq->spare);
> +               CLASS(fd, f)(kreq->fd);
>                 if (fd_empty(f))
>                         return ERR_PTR(-EBADF);
>
> @@ -5788,23 +5810,39 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_re=
q __user *, req,
>  {
>         struct mnt_namespace *ns __free(mnt_ns_release) =3D NULL;
>         struct kstatmount *ks __free(kfree) =3D NULL;
> +       struct file *file_from_fd __free(fput) =3D NULL;
> +       struct vfsmount *fd_mnt;
>         struct mnt_id_req kreq;
>         /* We currently support retrieval of 3 strings. */
>         size_t seq_size =3D 3 * PATH_MAX;
>         int ret;
>
> -       if (flags)
> +       if (flags & ~STATMOUNT_BY_FD)
>                 return -EINVAL;
>
> -       ret =3D copy_mnt_id_req(req, &kreq);
> +       ret =3D copy_mnt_id_req(req, &kreq, flags);
>         if (ret)
>                 return ret;
>
> -       ns =3D grab_requested_mnt_ns(&kreq);
> -       if (!ns)
> -               return -ENOENT;
> +       if (flags & STATMOUNT_BY_FD) {
> +               file_from_fd =3D fget_raw(kreq.fd);
> +               if (!file_from_fd)
> +                       return -EBADF;
> +
> +               fd_mnt =3D file_from_fd->f_path.mnt;
> +               ns =3D real_mount(fd_mnt)->mnt_ns;
> +               if (ns)
> +                       refcount_inc(&ns->passive);
> +               else
> +                       if (!capable(CAP_SYS_ADMIN))
> +                               return -ENOENT;

We can consider moving this code into grab_requested_mnt_ns.

> +       } else {
> +               ns =3D grab_requested_mnt_ns(&kreq, flags);


Actually, `grab_requested_mnt_ns` returns an error code. I found this while
reviewing the patch. The issue was fixed in
https://www.spinics.net/lists/kernel/msg5921099.html

> +               if (!ns)
> +                       return -ENOENT;
> +       }
>
> -       if (kreq.mnt_ns_id && (ns !=3D current->nsproxy->mnt_ns) &&
> +       if (ns && (ns !=3D current->nsproxy->mnt_ns) &&
>             !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>                 return -ENOENT;
>
> @@ -5817,8 +5855,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req=
 __user *, req,
>         if (ret)
>                 return ret;
>
> +       if (flags & STATMOUNT_BY_FD)
> +               ks->mnt =3D fd_mnt;
> +
>         scoped_guard(namespace_shared)
> -               ret =3D do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns)=
;
> +               ret =3D do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns,=
 flags);
>
>         if (!ret)
>                 ret =3D copy_statmount_to_user(ks);
> @@ -5927,7 +5968,7 @@ static inline int prepare_klistmount(struct klistmo=
unt *kls, struct mnt_id_req *
>         if (!kls->kmnt_ids)
>                 return -ENOMEM;
>
> -       kls->ns =3D grab_requested_mnt_ns(kreq);
> +       kls->ns =3D grab_requested_mnt_ns(kreq, 0);
>         if (!kls->ns)
>                 return -ENOENT;
>
> @@ -5957,7 +5998,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req =
__user *, req,
>         if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
>                 return -EFAULT;
>
> -       ret =3D copy_mnt_id_req(req, &kreq);
> +       ret =3D copy_mnt_id_req(req, &kreq, 0);
>         if (ret)
>                 return ret;
>
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 7fa67c2031a5..3eaa21d85531 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -197,7 +197,7 @@ struct statmount {
>   */
>  struct mnt_id_req {
>         __u32 size;
> -       __u32 spare;
> +       __u32 fd;
>         __u64 mnt_id;
>         __u64 param;
>         __u64 mnt_ns_id;
> @@ -232,4 +232,9 @@ struct mnt_id_req {
>  #define LSMT_ROOT              0xffffffffffffffff      /* root mount */
>  #define LISTMOUNT_REVERSE      (1 << 0) /* List later mounts first */
>
> +/*
> + * @flag bits for statmount(2)
> + */
> +#define STATMOUNT_BY_FD                0x0000001U /* want mountinfo for =
given fd */
> +
>  #endif /* _UAPI_LINUX_MOUNT_H */
> --
> 2.51.1
>

