Return-Path: <linux-fsdevel+bounces-52413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57966AE323A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECE816F55E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D6B1E5729;
	Sun, 22 Jun 2025 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="FXMxv0wu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50ED2EAE5
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626561; cv=none; b=HBhqFcO1QUlWxuaEE2mtAkAGhEqOA3/QZ0SMkDo0vm8IIMhJSqQOk4/POtZiqwsUdZXwiVgRjBRi0x0uULyHSmC95/DBYcRfgGDOHZFBU5Nk+siUVEzNnfI9+/S8kCXx1+h+fPOTyMCGH/OAEpeuNJBf653Qq6dhzE1wKQiuNiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626561; c=relaxed/simple;
	bh=rCHqgWhmfJkulkwll2HX243ED44GnBpeGCGezeOz4E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PphrvhPUioZqwSUsLjMUEwTSxGVIGjTfdc1Z4QRku7vN3+9rjDRibZ+FetQhczwO5OqCTCLPozcGJd2c+QT6mlRrsnZgZ35aydUk7aLhYrepHmN2h/Y4klCOv5Qu7UZhsNZlAjUb3JxEnv2/qUBiZO4eBc3ZRRZo9XiGiOibQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=FXMxv0wu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso3934059e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750626556; x=1751231356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1030B/EDheIG1oe12plcnwdKr4HkqGxWkPJBH6p7FE=;
        b=FXMxv0wuApRd9rbBG3MMpt7NHWyVTuFezk5CIfLJXWnEhTaC0tGpefGje5GAW0Seil
         bLgHsMLH3WA/j+dRnCqVHfcjrYMtbMKum7scKuVJ+JP35uRumngoX6klPGbJYxBNGM4G
         mp/R15Y5AY0UJMNjEBODzPdv6nfJKcvHjmDs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750626556; x=1751231356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1030B/EDheIG1oe12plcnwdKr4HkqGxWkPJBH6p7FE=;
        b=hGOXOVoiVFJn6sp8hc7tcS3HOapI5iKIM7kSbAs8S19O+TofMX3vFDCpf9W7TFjEPU
         ecnoCoC65AQRbm1xbUGD+TIhHYC0/Iv9S9IFKUJKGVhWt5PWcvysY02VevEm7F2n6oR3
         MLdjy+3WtLokHuRFp5UUtNz3Z++92Cmjb81tZa5R82kpX7UEj5qVk3kl6m3T/1jLYQZf
         UOqXvdNnyVffULW5lv1U3Pee2xIiTDdY1GBNp0As9eXl7X4AY+FJZZU1yWYkTdmh4mGJ
         gvb6hD425WmkcJCk2u6AQZXpWnF0QIc/u8FREoDhsH6lYRNYoRT/r0RbNKmBmJLpRZap
         PNsw==
X-Gm-Message-State: AOJu0YywXKwsWUFOrB7b6BOp1+csCU7A4Z8h3lpIUkFhXBlu13inROyh
	z2CsWZwoUDSj1bCzkuF++QLjdMAUgViZx1X9BeC71Cbd+Z7XVcEy49YKt55coI2bZwqbi4L46uz
	Ar8ZxJxfdOUeePNQcqABuQlC24muj6/hgPInDMjLDpg==
X-Gm-Gg: ASbGnct+aYmNODt+sss8COpOe/fJUtyxZAmBZC/ymYWV8VuRFkp+KzJwMA4ZySZ1sDk
	rNx1Ib7nFu89Z8cioNkEVgFVfCx5Vra851F6h/ENIMRcPAagPonBPw584Ns2cfkbXlKuuVrGFYm
	59PWuXgeGC3LSkkWIiHfuZoBs3nJotk2u9S9ZH7JstTwIo2RdWEe9CWcg=
X-Google-Smtp-Source: AGHT+IHKWM5EQzzietrJ7hVLqEh2M2MP5eTd9qaH82ctU7Z38Lr7hL7/8P1wSRow6bdmrzwtPoDh4+LrkumT1lHjiGQ=
X-Received: by 2002:a05:6512:3a95:b0:54e:81ec:2c83 with SMTP id
 2adb3069b0e04-553e3ba8953mr2761583e87.18.1750626555593; Sun, 22 Jun 2025
 14:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-5-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-5-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:09:04 +0200
X-Gm-Features: Ac12FXzZ0TsR5wjLLDe0FObYThtNeVqUj5DnmjALkYHeHYECxvBb2NCaPGIVsfQ
Message-ID: <CAJqdLrrEHa4_uOnTgQQ78Jp9V3pM8kXz7uAZTQ=tEZOSoaKmwg@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] pidfs: persist information
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Persist exit and coredump information independent of whether anyone
> currently holds a pidfd for the struct pid.
>
> The current scheme allocated pidfs dentries on-demand repeatedly.
> This scheme is reaching it's limits as it makes it impossible to pin
> information that needs to be available after the task has exited or
> coredumped and that should not be lost simply because the pidfd got
> closed temporarily. The next opener should still see the stashed
> information.
>
> This is also a prerequisite for supporting extended attributes on
> pidfds to allow attaching meta information to them.
>
> If someone opens a pidfd for a struct pid a pidfs dentry is allocated
> and stashed in pid->stashed. Once the last pidfd for the struct pid is
> closed the pidfs dentry is released and removed from pid->stashed.
>
> So if 10 callers create a pidfs dentry for the same struct pid
> sequentially, i.e., each closing the pidfd before the other creates a
> new one then a new pidfs dentry is allocated every time.
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
> That's great except that it's buggy. If a pidfs dentry is stashed in
> pid->stashed after pidfs_exit() but before __unhash_process() is called
> we will return a pidfd for a reaped task without exit information being
> available.
>
> The pidfds_pid_valid() check does not guard against this race as it
> doens't sync at all with pidfs_exit(). The pid_has_task() check might be
> successful simply because we're before __unhash_process() but after
> pidfs_exit().
>
> Introduce a new scheme where the lifetime of information associated with
> a pidfs entry (coredump and exit information) isn't bound to the
> lifetime of the pidfs inode but the struct pid itself.
>
> The first time a pidfs dentry is allocated for a struct pid a struct
> pidfs_attr will be allocated which will be used to store exit and
> coredump information.
>
> If all pidfs for the pidfs dentry are closed the dentry and inode can be
> cleaned up but the struct pidfs_attr will stick until the struct pid
> itself is freed. This will ensure minimal memory usage while persisting
> relevant information.
>
> The new scheme has various advantages. First, it allows to close the
> race where we end up handing out a pidfd for a reaped task for which no
> exit information is available. Second, it minimizes memory usage.
> Third, it allows to remove complex lifetime tracking via dentries when
> registering a struct pid with pidfs. There's no need to get or put a
> reference. Instead, the lifetime of exit and coredump information
> associated with a struct pid is bound to the lifetime of struct pid
> itself.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c            | 212 ++++++++++++++++++++++++++++++++++----------------
>  include/linux/pid.h   |   3 +
>  include/linux/pidfs.h |   1 +
>  kernel/pid.c          |   2 +-
>  4 files changed, 151 insertions(+), 67 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index ff2560b34ed1..6a907457b1fe 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -25,7 +25,10 @@
>  #include "internal.h"
>  #include "mount.h"
>
> +#define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
> +
>  static struct kmem_cache *pidfs_cachep __ro_after_init;
> +static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
>
>  /*
>   * Stashes information that userspace needs to access even after the
> @@ -37,6 +40,11 @@ struct pidfs_exit_info {
>         __u32 coredump_mask;
>  };
>
> +struct pidfs_attr {
> +       struct pidfs_exit_info __pei;
> +       struct pidfs_exit_info *exit_info;
> +};
> +
>  struct pidfs_inode {
>         struct pidfs_exit_info __pei;
>         struct pidfs_exit_info *exit_info;
> @@ -125,6 +133,7 @@ void pidfs_add_pid(struct pid *pid)
>
>         pid->ino = pidfs_ino_nr;
>         pid->stashed = NULL;
> +       pid->attr = NULL;
>         pidfs_ino_nr++;
>
>         write_seqcount_begin(&pidmap_lock_seq);
> @@ -139,6 +148,18 @@ void pidfs_remove_pid(struct pid *pid)
>         write_seqcount_end(&pidmap_lock_seq);
>  }
>
> +void pidfs_free_pid(struct pid *pid)
> +{
> +       /*
> +        * Any dentry must've been wiped from the pid by now.
> +        * Otherwise there's a reference count bug.
> +        */
> +       VFS_WARN_ON_ONCE(pid->stashed);
> +
> +       if (!IS_ERR(pid->attr))
> +               kfree(pid->attr);
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  /**
>   * pidfd_show_fdinfo - print information about a pidfd
> @@ -261,13 +282,13 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
>  static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> -       struct inode *inode = file_inode(file);
>         struct pid *pid = pidfd_pid(file);
>         size_t usize = _IOC_SIZE(cmd);
>         struct pidfd_info kinfo = {};
>         struct pidfs_exit_info *exit_info;
>         struct user_namespace *user_ns;
>         struct task_struct *task;
> +       struct pidfs_attr *attr;
>         const struct cred *c;
>         __u64 mask;
>
> @@ -286,8 +307,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         if (!pid_in_current_pidns(pid))
>                 return -ESRCH;
>
> +       attr = READ_ONCE(pid->attr);
>         if (mask & PIDFD_INFO_EXIT) {
> -               exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
> +               exit_info = READ_ONCE(attr->exit_info);
>                 if (exit_info) {
>                         kinfo.mask |= PIDFD_INFO_EXIT;
>  #ifdef CONFIG_CGROUPS
> @@ -300,7 +322,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>
>         if (mask & PIDFD_INFO_COREDUMP) {
>                 kinfo.mask |= PIDFD_INFO_COREDUMP;
> -               kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
> +               kinfo.coredump_mask = READ_ONCE(attr->__pei.coredump_mask);
>         }
>
>         task = get_pid_task(pid, PIDTYPE_PID);
> @@ -552,41 +574,61 @@ struct pid *pidfd_pid(const struct file *file)
>   * task has been reaped which cannot happen until we're out of
>   * release_task().
>   *
> - * If this struct pid is referred to by a pidfd then
> - * stashed_dentry_get() will return the dentry and inode for that struct
> - * pid. Since we've taken a reference on it there's now an additional
> - * reference from the exit path on it. Which is fine. We're going to put
> - * it again in a second and we know that the pid is kept alive anyway.
> + * If this struct pid has at least once been referred to by a pidfd then
> + * pid->attr will be allocated. If not we mark the struct pid as dead so
> + * anyone who is trying to register it with pidfs will fail to do so.
> + * Otherwise we would hand out pidfs for reaped tasks without having
> + * exit information available.
>   *
> - * Worst case is that we've filled in the info and immediately free the
> - * dentry and inode afterwards since the pidfd has been closed. Since
> + * Worst case is that we've filled in the info and the pid gets freed
> + * right away in free_pid() when no one holds a pidfd anymore. Since
>   * pidfs_exit() currently is placed after exit_task_work() we know that
> - * it cannot be us aka the exiting task holding a pidfd to ourselves.
> + * it cannot be us aka the exiting task holding a pidfd to itself.
>   */
>  void pidfs_exit(struct task_struct *tsk)
>  {
> -       struct dentry *dentry;
> +       struct pid *pid = task_pid(tsk);
> +       struct pidfs_attr *attr;
> +       struct pidfs_exit_info *exit_info;
> +#ifdef CONFIG_CGROUPS
> +       struct cgroup *cgrp;
> +#endif
>
>         might_sleep();
>
> -       dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
> -       if (dentry) {
> -               struct inode *inode = d_inode(dentry);
> -               struct pidfs_exit_info *exit_info = &pidfs_i(inode)->__pei;
> -#ifdef CONFIG_CGROUPS
> -               struct cgroup *cgrp;
> +       guard(spinlock_irq)(&pid->wait_pidfd.lock);
> +       attr = pid->attr;
> +       if (!attr) {
> +               /*
> +                * No one ever held a pidfd for this struct pid.
> +                * Mark it as dead so no one can add a pidfs
> +                * entry anymore. We're about to be reaped and
> +                * so no exit information would be available.
> +                */
> +               pid->attr = PIDFS_PID_DEAD;
> +               return;
> +       }
>
> -               rcu_read_lock();
> -               cgrp = task_dfl_cgroup(tsk);
> -               exit_info->cgroupid = cgroup_id(cgrp);
> -               rcu_read_unlock();
> +       /*
> +        * If @pid->attr is set someone might still legitimately hold a
> +        * pidfd to @pid or someone might concurrently still be getting
> +        * a reference to an already stashed dentry from @pid->stashed.
> +        * So defer cleaning @pid->attr until the last reference to @pid
> +        * is put
> +        */
> +
> +       exit_info = &attr->__pei;
> +
> +#ifdef CONFIG_CGROUPS
> +       rcu_read_lock();
> +       cgrp = task_dfl_cgroup(tsk);
> +       exit_info->cgroupid = cgroup_id(cgrp);
> +       rcu_read_unlock();
>  #endif
> -               exit_info->exit_code = tsk->exit_code;
> +       exit_info->exit_code = tsk->exit_code;
>
> -               /* Ensure that PIDFD_GET_INFO sees either all or nothing. */
> -               smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
> -               dput(dentry);
> -       }
> +       /* Ensure that PIDFD_GET_INFO sees either all or nothing. */
> +       smp_store_release(&attr->exit_info, &attr->__pei);
>  }
>
>  #ifdef CONFIG_COREDUMP
> @@ -594,16 +636,15 @@ void pidfs_coredump(const struct coredump_params *cprm)
>  {
>         struct pid *pid = cprm->pid;
>         struct pidfs_exit_info *exit_info;
> -       struct dentry *dentry;
> -       struct inode *inode;
> +       struct pidfs_attr *attr;
>         __u32 coredump_mask = 0;
>
> -       dentry = pid->stashed;
> -       if (WARN_ON_ONCE(!dentry))
> -               return;
> +       attr = READ_ONCE(pid->attr);
>
> -       inode = d_inode(dentry);
> -       exit_info = &pidfs_i(inode)->__pei;
> +       VFS_WARN_ON_ONCE(!attr);
> +       VFS_WARN_ON_ONCE(attr == PIDFS_PID_DEAD);
> +
> +       exit_info = &attr->__pei;
>         /* Note how we were coredumped. */
>         coredump_mask = pidfs_coredump_mask(cprm->mm_flags);
>         /* Note that we actually did coredump. */
> @@ -663,7 +704,7 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
>
>  static void pidfs_free_inode(struct inode *inode)
>  {
> -       kmem_cache_free(pidfs_cachep, pidfs_i(inode));
> +       kfree(pidfs_i(inode));
>  }
>
>  static const struct super_operations pidfs_sops = {
> @@ -831,8 +872,13 @@ static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
>          * recorded and published can be handled correctly.
>          */
>         if (unlikely(!pid_has_task(pid, type))) {
> -               struct inode *inode = d_inode(path->dentry);
> -               return !!READ_ONCE(pidfs_i(inode)->exit_info);
> +               struct pidfs_attr *attr;
> +
> +               attr = READ_ONCE(pid->attr);
> +               if (!attr)
> +                       return false;
> +               if (!READ_ONCE(attr->exit_info))
> +                       return false;
>         }
>
>         return true;
> @@ -878,9 +924,67 @@ static void pidfs_put_data(void *data)
>         put_pid(pid);
>  }
>
> +/**
> + * pidfs_register_pid - register a struct pid in pidfs
> + * @pid: pid to pin
> + *
> + * Register a struct pid in pidfs. Needs to be paired with
> + * pidfs_put_pid() to not risk leaking the pidfs dentry and inode.
> + *
> + * Return: On success zero, on error a negative error code is returned.
> + */
> +int pidfs_register_pid(struct pid *pid)
> +{
> +       struct pidfs_attr *new_attr __free(kfree) = NULL;
> +       struct pidfs_attr *attr;
> +
> +       might_sleep();
> +
> +       if (!pid)
> +               return 0;
> +
> +       attr = READ_ONCE(pid->attr);
> +       if (unlikely(attr == PIDFS_PID_DEAD))
> +               return PTR_ERR(PIDFS_PID_DEAD);
> +       if (attr)
> +               return 0;
> +
> +       new_attr = kmem_cache_zalloc(pidfs_attr_cachep, GFP_KERNEL);
> +       if (!new_attr)
> +               return -ENOMEM;
> +
> +       /* Synchronize with pidfs_exit(). */
> +       guard(spinlock_irq)(&pid->wait_pidfd.lock);
> +
> +       attr = pid->attr;
> +       if (unlikely(attr == PIDFS_PID_DEAD))
> +               return PTR_ERR(PIDFS_PID_DEAD);
> +       if (unlikely(attr))
> +               return 0;
> +
> +       pid->attr = no_free_ptr(new_attr);
> +       return 0;
> +}
> +
> +static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
> +                                        struct dentry *dentry)
> +{
> +       int ret;
> +       struct pid *pid = d_inode(dentry)->i_private;
> +
> +       VFS_WARN_ON_ONCE(stashed != &pid->stashed);
> +
> +       ret = pidfs_register_pid(pid);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return stash_dentry(stashed, dentry);
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
> @@ -936,33 +1040,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>         return pidfd_file;
>  }
>
> -/**
> - * pidfs_register_pid - register a struct pid in pidfs
> - * @pid: pid to pin
> - *
> - * Register a struct pid in pidfs. Needs to be paired with
> - * pidfs_put_pid() to not risk leaking the pidfs dentry and inode.
> - *
> - * Return: On success zero, on error a negative error code is returned.
> - */
> -int pidfs_register_pid(struct pid *pid)
> -{
> -       struct path path __free(path_put) = {};
> -       int ret;
> -
> -       might_sleep();
> -
> -       if (!pid)
> -               return 0;
> -
> -       ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
> -       if (unlikely(ret))
> -               return ret;
> -       /* Keep the dentry and only put the reference to the mount. */
> -       path.dentry = NULL;
> -       return 0;
> -}
> -
>  /**
>   * pidfs_get_pid - pin a struct pid through pidfs
>   * @pid: pid to pin
> @@ -1008,6 +1085,9 @@ void __init pidfs_init(void)
>                                          (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
>                                           SLAB_ACCOUNT | SLAB_PANIC),
>                                          pidfs_inode_init_once);
> +       pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
> +                                        (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
> +                                         SLAB_ACCOUNT | SLAB_PANIC), NULL);
>         pidfs_mnt = kern_mount(&pidfs_type);
>         if (IS_ERR(pidfs_mnt))
>                 panic("Failed to mount pidfs pseudo filesystem");
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 00646a692dd4..003a1027d219 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -47,6 +47,8 @@
>
>  #define RESERVED_PIDS 300
>
> +struct pidfs_attr;
> +
>  struct upid {
>         int nr;
>         struct pid_namespace *ns;
> @@ -60,6 +62,7 @@ struct pid {
>                 u64 ino;
>                 struct rb_node pidfs_node;
>                 struct dentry *stashed;
> +               struct pidfs_attr *attr;
>         };
>         /* lists of tasks that use this pid */
>         struct hlist_head tasks[PIDTYPE_MAX];
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 77e7db194914..8f6ed59bb3fb 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -16,5 +16,6 @@ extern const struct dentry_operations pidfs_dentry_operations;
>  int pidfs_register_pid(struct pid *pid);
>  void pidfs_get_pid(struct pid *pid);
>  void pidfs_put_pid(struct pid *pid);
> +void pidfs_free_pid(struct pid *pid);
>
>  #endif /* _LINUX_PID_FS_H */
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 8317bcbc7cf7..07db7d8d066c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -100,7 +100,7 @@ void put_pid(struct pid *pid)
>
>         ns = pid->numbers[pid->level].ns;
>         if (refcount_dec_and_test(&pid->count)) {
> -               WARN_ON_ONCE(pid->stashed);
> +               pidfs_free_pid(pid);
>                 kmem_cache_free(ns->pid_cachep, pid);
>                 put_pid_ns(ns);
>         }
>
> --
> 2.47.2
>

