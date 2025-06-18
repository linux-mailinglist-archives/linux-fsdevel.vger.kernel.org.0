Return-Path: <linux-fsdevel+bounces-52104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5833AADF6E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22574A1567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6BD212FA2;
	Wed, 18 Jun 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="hD9xx1li"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71F3085A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275307; cv=none; b=F6UPsPlSjkw7ZOBDE0kQwl64PWEq/Mj9Hdrg8lF/nkLLrdPYJlNxltjJ55PVr6CQZrrOLSwiD1VnH5nE3xAlfJmmCxjJG+ziD0BUqEKY3KGvX0EElQxlGsACLROJLThVNeImnKNV8EwJt+SPw0VZiZ1MRK7+hLKcIT4JTRgksog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275307; c=relaxed/simple;
	bh=3BeqTKI3GYEurHxfVoKJ9289Kd8vp4BUhFYUuTQCBco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sD1BnLTLVkXciL91bsouzi1THXc9afKHVQsfxGUV6jJyotQLYx6NAS2ko8D20IMUmbUgRwtyl6hPT/foX8tGGW/jAdBTtcqBAI6jwjBBmQJOQSJGVgNPN79tzDz3nO2MmaUyVHyAlzmqiu9eqRePMS/gdSL1LQ8kA35U032DpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=hD9xx1li; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54d98aa5981so9500224e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750275302; x=1750880102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6K2nC2N5QbIZD0l1g/EwA7JkYSqt+UQonQe/J+c8Ho=;
        b=hD9xx1lib63aXcHl8M5od8NMK0YmUOVKs+ubRc0QuPCBF8eF5zxBUvQ88uRiRYwYuz
         6mBn3wVm9EMcO4CHYVIP4dvz6egK/eJB15pL/W24BezbGnkXv3KszmgryPIHd+T3WicN
         SDGb0yxbhiCZ/+w+6GJeN4azeJVpP3KK4g9x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275303; x=1750880103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6K2nC2N5QbIZD0l1g/EwA7JkYSqt+UQonQe/J+c8Ho=;
        b=aPO9HCqZBOdHYJL1mQ5iJD+CMlvHNea9Nfgj5wNZwzueSoN47ncL2nHUNWvE/pf6LE
         yAAwf/n4KR7oDo720iN5zacZQqiJiGPZ1UAd3dN5hGkVStjqQa4tjcD1wKDvoOn/mfky
         l128UaD39/nwU8X5dfw6EI/WJ5GAhIp2g3QLRG/A7y4hCp33d6C+vBP4WK4PFTmTSiSU
         JzejuFnNV9pFJgMnzMMG/y1d5ZWkchjIVAKPzsBEKcL3BIv8ShDKotyfM/VSJ7q2rGky
         uUbplVksfV1i3/hFPXwz8HCHqzlIlEWPISmJMG6EipxnjLiXlnIKWA10s3VUB+9Dg94f
         vWyQ==
X-Gm-Message-State: AOJu0YyG0O9Wd0vwCyWNCLHJ/A7P2bFER0RcimPeCmXInUZCLbHEi9X5
	J43/OJ1skMo88a7XcRoKEZCOqHh1e1uR/64pLkURK/QwEwpYJaHnQeVYVNEfZn84DsITuo8AKos
	3Z5UDFrwDPQr45DMdkGspNgn6oDvnWveeYKdGVG6cIA==
X-Gm-Gg: ASbGnctuTGfP28wcRZPRTdpKv5p0d1gwkCAsiO4F6q7UpUNB0ib+MscVZ0cHuaEVQX0
	njLUEkdJ2XTdTNuPThv+wahVTSTzJGJzyNQ7dwuRIp3tvwS9TFQXTCcZFD/h4opTrKeE36UdCRu
	Yjk2ADeDdAW8txa0Xwo20AaS4g8PfBJV1OknH0//dbr5Zc
X-Google-Smtp-Source: AGHT+IEMF+DqyaxqgQYwhstBvREQwqK66kVUwPm2IvkTHpvHdwMZZamKCRJZ57pKjjplTh+VwZ1Qoc8aDReZiPduwDo=
X-Received: by 2002:a05:6512:3090:b0:553:a4a8:b860 with SMTP id
 2adb3069b0e04-553b6da30fdmr5634094e87.0.1750275302140; Wed, 18 Jun 2025
 12:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org> <20250617-work-pidfs-xattr-v1-1-2d0df10405bb@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-1-2d0df10405bb@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Jun 2025 21:34:50 +0200
X-Gm-Features: Ac12FXziyxomSjwz9TCstCavSYaJ1o1AHkIXQwxC-418SMcSDZTtSiL1g9v3jHs
Message-ID: <CAJqdLrpi3nULpjycvZqj6UXpwtjkgy4AJTibM2jcS0ySe2svRw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] pidfs: keep pidfs dentry stashed once created
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 17. Juni 2025 um 17:42 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Keep pidfs dentries around after a pidfd has been created for it. The
> pidfs dentry will only be cleaned up once the struct pid gets reaped.
>
> The current scheme allocated pidfs dentries on-demand repeatedly.
> This scheme is reaching it's limits as it makes it impossible to pin
> information that needs to be available after the task has exited or
> coredumped and that should not be lost simply because the pidfd got
> closed temporarily. The next opener should still see the stashed
> information.
>
> If someone opens a pidfd for a struct pid a pidfs dentry is allocated
> and stashed in pid->stashed. Once the last pidfd for the struct pid is
> closed the pidfs dentry is released and removed from pid->stashed.
>
> So if 10 callers create a pidfs for the same struct pid sequentially,
> i.e., each closing the pidfd before the other creates a new one then a
> new pidfs dentry is allocated every time.
>
> Because multiple tasks acquiring and releasing a pidfd for the same
> struct pid can race with each another a task may still find a valid
> pidfs entry from the previous task in pid->stashed and reuse it. Or it
> might find a dead dentry in there and fail to reuse it and so stashes a
> new pidfs dentry. Multiple tasks may race to stash a new pidfs dentry
> but only one will succeed, the other ones will put their dentry.
>
> The current scheme aims to ensure that a pidfs dentry for a struct pid
> can only be created if the task is still alive or if a pidfs dentry
> already existed before the task was reaped and so exit information has
> been was stashed in the pidfs inode.
>
> That's great expect that it's buggy. If a pidfs dentry is stashed in
> pid->stashed after pidfs_exit() but before __unhash_process() is called
> we will return a pidfd for a reaped task without exit information being
> available.
>
> The pidfds_pid_valid() check does not guard against this race as it
> doens't sync at all with pidfs_exit(). The pid_has_task() check might be
> successful simply because we're before __unhash_process() but after
> pidfs_exit().
>
> This switches to a scheme were pidfs entries are retained after a pidfd
> was created for the struct pid. So when allocating a pidfds dentry an
> extra reference is retained that is owned by the exit path and that will
> be put once the task does get reaped. In the new model pidfs dentries
> are still allocated on-demand but then kept until the task gets reaped.
>
> The synchronization mechanism uses the pid->wait_pidfd.lock in struct
> pid to synchronize with pidfs_exit() called when the task is reaped. If
> the path_from_stashed() fastpath fails, a new pidfs dentry is allocated
> and afterwards the pid->wait_pidfd.lock is taken. If no other task
> managed to stash its dentry there the callers will be stashed.
>
> When the task is reaped and calls pidfs_exit() the pid->wait_pidfd.lock
> is taken. Once pidfs_exit() holds the pid->wait_pidfd.lock and sees that
> no pidfs dentry is available in pid->stashed it knows that no new dentry
> can be stashed while it holds the pid->wait_pidfd.lock. It thus sets a
> ERR_PTR(-ESRCH) sentinel in pid->stashed. That sentinel allows
> pidfs_stash_dentry() to detect that the struct pid has already been
> reaped and refuse to stash a new dentry in pid->stashed. That works both
> in the fast- and slowpath.
>
> This in turn allows us to fix the bug mentioned earlier where we hand
> out a pidfd for a reaped task without having exit information set as we
> now sync with pidfs_exit() and thus release_task().
>
> This also has some subtle interactions with the path_from_stashed()
> fastpath that need to be considered. The path_from_stashed() fast path
> will try go get a reference to an already existing pidfs dentry in
> pid->stashed to avoid having to allocate and stash a pidfs dentry. If it
> finds a dentry in there it will return it.
>
> To not confuse path_from_stashed() pidfs_exit() must not replace a pidfs
> dentry stashed in pid->stashed with the ERR_PTR(-ESRCH) sentinel as
> path_from_stashed() could legitimately obtain another reference before
> pidfs_exit() was able to call dput() to put the final pidfs dentry
> reference. If it were to put the sentinel into pid->stashed it would
> invalidate a struct pid even though a pidfd was just created for it.
>
> So if a pidfs dentry is stashed in pid->stashed pidfs_exit() must leave
> clearing out pid->stashed to dentry->d_prune::pidfs_dentry_prune(). When
> pruning a dentry we must take care to not take the pid->wait_pidfd.lock
> as this would cause a lock inversion with dentry->d_lock in
> pidfs_stash_dentry(). This should fortunately not at all be necessary as
> by the time we call pidfs_dentry_prune() we know that the struct pid is
> dead as the task is reaped and that anyone concurrently trying to get a
> reference to the stashed dentry will fail to do so.
>
> IOW, it doesn't matter whether the path_from_stashed() fast path sees
> NULL, a dead dentry, or the ERR_PTR(-ESRCH) sentinel in pid->stashed.
> Any of those forces path_from_stashed() into the slowpath at which point
> pid->wait_pidfd.lock must be acquired. The slowpath will then see either
> a dead dentry or the ERR_PTR(-ESRCH) sentinel but never NULL and thus
> fail the creation of a new pidfs dentry.
>
> path_from_stashed() must take care to not try and take a reference on
> the ERR_PTR(-ESRCH) sentinel. So stashed_dentry_get() must be prepared
> to see a ERR_PTR(-ESRCH) sentinel in pid->stashed.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/internal.h |   2 +
>  fs/libfs.c    |  22 +++++++--
>  fs/pidfs.c    | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  kernel/pid.c  |   2 +-
>  4 files changed, 147 insertions(+), 22 deletions(-)
>
> diff --git a/fs/internal.h b/fs/internal.h
> index 393f6c5c24f6..180b367c192b 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -322,6 +322,8 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
>  struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
>  void mnt_idmap_put(struct mnt_idmap *idmap);
>  struct stashed_operations {
> +       struct dentry *(*stash_dentry)(struct dentry **stashed,
> +                                      struct dentry *dentry);
>         void (*put_data)(void *data);
>         int (*init_inode)(struct inode *inode, void *data);
>  };
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 9ea0ecc325a8..f496373869fb 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2128,6 +2128,8 @@ struct dentry *stashed_dentry_get(struct dentry **stashed)
>         dentry = rcu_dereference(*stashed);
>         if (!dentry)
>                 return NULL;
> +       if (IS_ERR(dentry))
> +               return dentry;
>         if (!lockref_get_not_dead(&dentry->d_lockref))
>                 return NULL;
>         return dentry;
> @@ -2218,12 +2220,15 @@ static struct dentry *stash_dentry(struct dentry **stashed,
>  int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>                       struct path *path)
>  {
> -       struct dentry *dentry;
> +       struct dentry *dentry, *res;
>         const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
>
>         /* See if dentry can be reused. */
> -       path->dentry = stashed_dentry_get(stashed);
> -       if (path->dentry) {
> +       res = stashed_dentry_get(stashed);
> +       if (IS_ERR(res))
> +               return PTR_ERR(res);
> +       if (res) {
> +               path->dentry = res;
>                 sops->put_data(data);
>                 goto out_path;
>         }
> @@ -2234,8 +2239,15 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>                 return PTR_ERR(dentry);
>
>         /* Added a new dentry. @data is now owned by the filesystem. */
> -       path->dentry = stash_dentry(stashed, dentry);
> -       if (path->dentry != dentry)
> +       if (sops->stash_dentry)
> +               res = sops->stash_dentry(stashed, dentry);
> +       else
> +               res = stash_dentry(stashed, dentry);
> +       if (IS_ERR(res))

Shouldn't we do
dput(dentry);
in here?

> +               return PTR_ERR(res);
> +       path->dentry = res;
> +       /* A dentry was reused. */
> +       if (res != dentry)
>                 dput(dentry);
>
>  out_path:
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c1f0a067be40..ee5e9a18c2d3 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -25,6 +25,20 @@
>  #include "internal.h"
>  #include "mount.h"
>
> +/*
> + * Usage:
> + * pid->wait_pidfd.lock protects:
> + *   - insertion of dentry into pid->stashed
> + *   - deletion of pid[PIDTYPE_TGID] task linkage
> + *   - pidfs_exit() which sets pid->stashed to NULL
> + *
> + * Ordering:
> + *   -> dentry->d_lock
> + *      -> pid->wait_pidfd.lock
> + */
> +
> +#define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
> +
>  static struct kmem_cache *pidfs_cachep __ro_after_init;
>
>  /*
> @@ -552,30 +566,47 @@ struct pid *pidfd_pid(const struct file *file)
>   * task has been reaped which cannot happen until we're out of
>   * release_task().
>   *
> - * If this struct pid is referred to by a pidfd then
> - * stashed_dentry_get() will return the dentry and inode for that struct
> - * pid. Since we've taken a reference on it there's now an additional
> - * reference from the exit path on it. Which is fine. We're going to put
> - * it again in a second and we know that the pid is kept alive anyway.
> + * If this struct pid has at least once been referred to by a pidfd then
> + * pid->stashed will contain a dentry. One reference exclusively belongs
> + * to pidfs_exit(). There might of course be other references.
>   *
>   * Worst case is that we've filled in the info and immediately free the
> - * dentry and inode afterwards since the pidfd has been closed. Since
> - * pidfs_exit() currently is placed after exit_task_work() we know that
> - * it cannot be us aka the exiting task holding a pidfd to ourselves.
> + * dentry and inode afterwards when no one holds an open pidfd anymore.
> + * Since pidfs_exit() currently is placed after exit_task_work() we know
> + * that it cannot be us aka the exiting task holding a pidfd to itself.
>   */
>  void pidfs_exit(struct task_struct *tsk)
>  {
>         struct dentry *dentry;
> +       struct pid *pid = task_pid(tsk);
>
>         might_sleep();
>
> -       dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
> -       if (dentry) {
> -               struct inode *inode = d_inode(dentry);
> -               struct pidfs_exit_info *exit_info = &pidfs_i(inode)->__pei;
> +       scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
> +               struct inode *inode;
> +               struct pidfs_exit_info *exit_info;
>  #ifdef CONFIG_CGROUPS
>                 struct cgroup *cgrp;
> +#endif
>
> +               dentry = rcu_dereference_raw(pid->stashed);
> +               if (!dentry) {
> +                       /*
> +                        * No one held a pidfd for this struct pid.
> +                        * Mark it as dead so no one can add a pidfs
> +                        * entry anymore. We're about to be reaped and
> +                        * so no exit information would be available.
> +                        */
> +                       rcu_assign_pointer(pid->stashed, PIDFS_PID_DEAD);
> +                       return;
> +               }
> +
> +               /* We own a reference assert that clearly. */
> +               VFS_WARN_ON_ONCE(__lockref_is_dead(&dentry->d_lockref));
> +               inode = d_inode(dentry);
> +               exit_info = &pidfs_i(inode)->__pei;
> +
> +#ifdef CONFIG_CGROUPS
>                 rcu_read_lock();
>                 cgrp = task_dfl_cgroup(tsk);
>                 exit_info->cgroupid = cgroup_id(cgrp);
> @@ -585,8 +616,15 @@ void pidfs_exit(struct task_struct *tsk)
>
>                 /* Ensure that PIDFD_GET_INFO sees either all or nothing. */
>                 smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
> -               dput(dentry);
>         }
> +
> +       /*
> +        * If there was a dentry in there we own a reference to it. So
> +        * accessing pid->stashed is safe. Note, pid->stashed will be
> +        * cleared by pidfs. Leave it alone as we could end up in a
> +        * legitimate race with path_from_stashed()'s fast path.
> +        */
> +       dput(dentry);
>  }
>
>  #ifdef CONFIG_COREDUMP
> @@ -683,9 +721,44 @@ static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
>         return dynamic_dname(buffer, buflen, "anon_inode:[pidfd]");
>  }
>
> +static void pidfs_dentry_prune(struct dentry *dentry)
> +{
> +       struct dentry **stashed = dentry->d_fsdata;
> +       struct inode *inode = d_inode(dentry);
> +       struct pid *pid;
> +
> +       if (WARN_ON_ONCE(!stashed))
> +               return;
> +
> +       if (!inode)
> +               return;
> +
> +       pid = inode->i_private;
> +       VFS_WARN_ON_ONCE(!pid);
> +       /*
> +        * We can't acquire pid->wait_pidfd.lock as we're holding
> +        * dentry->d_lock and pidfs_stash_dentry() needs to be able to
> +        * hold dentry->d_lock under pid->wait_pidfd.lock.
> +        *
> +        * Also, we don't really need it...
> +        */
> +       VFS_WARN_ON_ONCE(!__lockref_is_dead(&dentry->d_lockref));
> +       VFS_WARN_ON_ONCE(*stashed != dentry);
> +
> +       /*
> +        * ... Because to get here the struct pid must have been reaped
> +        * already && no one holds a pidfd open anymore. The only one
> +        * that can race us is pidfd_stash_dentry(). Either it sees a
> +        * dead dentry in pid->stashed or it sees our sentinel marking
> +        * the struct pid as dead. There's no need to synchronize this
> +        * with a lock.
> +        */
> +       smp_store_release(stashed, PIDFS_PID_DEAD);
> +}
> +
>  const struct dentry_operations pidfs_dentry_operations = {
>         .d_dname        = pidfs_dname,
> -       .d_prune        = stashed_dentry_prune,
> +       .d_prune        = pidfs_dentry_prune,
>  };
>
>  static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> @@ -878,9 +951,47 @@ static void pidfs_put_data(void *data)
>         put_pid(pid);
>  }
>
> +static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
> +                                        struct dentry *dentry)
> +{
> +       struct pid *pid = d_inode(dentry)->i_private;
> +       struct dentry *d;
> +
> +       VFS_WARN_ON_ONCE(stashed != &pid->stashed);
> +
> +       /* We need to synchronize with pidfs_exit(). */
> +       guard(spinlock_irq)(&pid->wait_pidfd.lock);
> +       guard(rcu)();
> +
> +       d = rcu_dereference(*stashed);
> +       if (!d) {
> +               /*
> +                * There's nothing stashed in here so no pidfs dentry
> +                * exists for this task yet and we're definitely not
> +                * past pidfs_exit() and everyone else will wait for us.
> +                */
> +               rcu_assign_pointer(*stashed, dget(dentry));
> +               return dentry;
> +       }
> +
> +       /* The struct pid is already marked dead. */
> +       if (IS_ERR(d))
> +               return d;
> +
> +       /*
> +        * The struct pid isn't yet marked dead but there's a dead
> +        * dentry in there which is just as well.
> +        */
> +       if (!lockref_get_not_dead(&d->d_lockref))
> +               return ERR_PTR(-ESRCH);
> +
> +       return d;
> +}
> +
>  static const struct stashed_operations pidfs_stashed_ops = {
> -       .init_inode = pidfs_init_inode,
> -       .put_data = pidfs_put_data,
> +       .stash_dentry   = pidfs_stash_dentry,
> +       .init_inode     = pidfs_init_inode,
> +       .put_data       = pidfs_put_data,
>  };
>
>  static int pidfs_init_fs_context(struct fs_context *fc)
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 8317bcbc7cf7..30518852d990 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -100,7 +100,7 @@ void put_pid(struct pid *pid)
>
>         ns = pid->numbers[pid->level].ns;
>         if (refcount_dec_and_test(&pid->count)) {
> -               WARN_ON_ONCE(pid->stashed);
> +               WARN_ON_ONCE(!IS_ERR(pid->stashed));
>                 kmem_cache_free(ns->pid_cachep, pid);
>                 put_pid_ns(ns);
>         }
>
> --
> 2.47.2
>

