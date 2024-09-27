Return-Path: <linux-fsdevel+bounces-30259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9C9887C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089481C223B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E61C1743;
	Fri, 27 Sep 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLC2x/l2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA981C0DEE;
	Fri, 27 Sep 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449128; cv=none; b=QRDgV/h5WUAdD/7UXYhzAqWeWhuLlzqbpJIkdgVXtboCS9GNZtLC4Z6MQyc1mg8BqueiHjCXwIldOiVYyw7p5RtUTIMdaJ3eMkaYJLBSMutNfKlDyB/4p9NTB/zG6RmsSK/qyi8HNzMICR3QcPY50yEEuyIaPt6GZ/OLVgW6ntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449128; c=relaxed/simple;
	bh=2LuAJMymhapoROcoJ4ULQe6sQGVe4KOQvSunSa3VK+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwiLbbNG4abSsE/ooa9SWONk/chzwUWEmOk/ug3NmM+BIuVFyZH3B68Ph1qO4sZx1a/fM58cF+CNiyP1PsraMqIfI/viCzS8cHLb7QbbVDkDOZoJKi58qaL+005aawBglLZjEKdefTHY4xwWq06rQyTtiu4H3+r69KCPejj7xCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLC2x/l2; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25cb262769so2053043276.0;
        Fri, 27 Sep 2024 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727449126; x=1728053926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RUqpJrC2h++Ip7eYybPM2NPylDUB8GFuauudiOi2DA=;
        b=XLC2x/l2+gpGxwTIK6rwUcS3Z65w2npb1vfublLChIUF2DJ3qTyeLwKDObj4PcZaYb
         BBj3Rh34fsTGDRPPMPQF7Yqwr1CcsPNfs1TNgfrIAN46HJle99d5FKwB33+z7ZW5glDX
         W3MAOI1ChDtUHqkeejVXa+OesVmwp2fMkIvfY/SpnVgJ4gvGLx7sYw2nmFG/hKcTXIqF
         GkCUo+E8hIMNXeCVtiAgYHKGujS2oEiSQUJqidSsHPvLbssoJg6Ye1Y7QkS7Dh3JgMu9
         CLGtiXVZWixRChg4uYHRU1v/NO/3AA0xylkYr8G/hxVTNEZMLrBx7XyUoG25SUsxO0qT
         u9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449126; x=1728053926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RUqpJrC2h++Ip7eYybPM2NPylDUB8GFuauudiOi2DA=;
        b=JrltPR01WvinIKkJl/qGghwxFQfyCLWG8s9thSB/E3PbV7Z4GlEdsAAMKfE5kFkjnF
         AZ6c6lFkvAGsN/tkRueU6bZLv07oJhVqx+ogzHb5bcWM1zMffHtrzd09ReTsI7drvINY
         9tt5b0I27EZ8svGzmV7hNQtGq4mHaZFcTlTFBsCMPxiZLWRec4IssrhGaf030Z1JJmIC
         TP/83pRkzecGCVRipIpPczeUqH3kK8ffQHzQ8/qtt9tHqDgHM+pZ7rzdq7jOat/GdnV+
         XhUQ2Ih329xO3MmEoT8h0PizT3VK//mkAGOS9kfQkgjItVm+T1i1DzNJ/JBUB222r8jV
         7J1g==
X-Forwarded-Encrypted: i=1; AJvYcCUkE69G3YpcyFsy9Wk7fkxFoT4ZYO1zEkxX5YsEuCyMDEx6JxScV7L+C0iuRT50ZwPLyYH3uhoHQPZrJF9J@vger.kernel.org, AJvYcCVry6V5zK7ZsW9BIeFZX4xG/sL9sIuRpqoOrLVkLMnOTEQi9H/mV+czEl5PmmJ7KMSzGbq49BrEUKPfjytw@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWWtENj52whHJNprLRHK/SXiYPbHonExy9rD93zh/W6eLVCYU
	slG19go/o6Tuqvhz1GDYAgMMJqzrbsyEu21dGgQt21n5VP0BfuirCg4/BUK+hZm2V9TkeJpbmpv
	37rL67Oy/ZORwq1R9qCRAmaHqGCTlnmmG5bw=
X-Google-Smtp-Source: AGHT+IEQbtS7IroqfYS5eHhrGtye6C7gjD7XvDc51nYf15Q66/uM2t/Ep+NY0fceb/lYZolVRp1qijTV6dcGEd/ZAg8=
X-Received: by 2002:a05:6902:1ac7:b0:e1d:16be:1b9d with SMTP id
 3f1490d57ef6-e2604b471d0mr2457834276.25.1727449124484; Fri, 27 Sep 2024
 07:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhrSSpPijzeuFWRZBrgZvEyk6aLK=q7fBz3rpiZcHZrvg@mail.gmail.com>
 <20240927143642.2369508-1-lizhi.xu@windriver.com>
In-Reply-To: <20240927143642.2369508-1-lizhi.xu@windriver.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 16:58:32 +0200
Message-ID: <CAOQ4uxjp6FupO1qDPY=4CJC2qEnhNt_ASs3PAgzQTh1VhPBscw@mail.gmail.com>
Subject: Re: [PATCH V3] inotify: Fix possible deadlock in fsnotify_destroy_mark
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net, 
	syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 4:36=E2=80=AFPM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> [Syzbot reported]
> WARNING: possible circular locking dependency detected
> 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0 Not tainted
> ------------------------------------------------------
> kswapd0/78 is trying to acquire lock:
> ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_group_loc=
k include/linux/fsnotify_backend.h:270 [inline]
> ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_destroy_m=
ark+0x38/0x3c0 fs/notify/mark.c:578
>
> but task is already holding lock:
> ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:=
6841 [inline]
> ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vms=
can.c:7223
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>        __fs_reclaim_acquire mm/page_alloc.c:3818 [inline]
>        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3832
>        might_alloc include/linux/sched/mm.h:334 [inline]
>        slab_pre_alloc_hook mm/slub.c:3939 [inline]
>        slab_alloc_node mm/slub.c:4017 [inline]
>        kmem_cache_alloc_noprof+0x3d/0x2a0 mm/slub.c:4044
>        inotify_new_watch fs/notify/inotify/inotify_user.c:599 [inline]
>        inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
>        __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [i=
nline]
>        __se_sys_inotify_add_watch+0x72e/0x1070 fs/notify/inotify/inotify_=
user.c:729
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (&group->mark_mutex){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3133 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3252 [inline]
>        validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
>        __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
>        fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
>        fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
>        fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
>        dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:403
>        __dentry_kill+0x20d/0x630 fs/dcache.c:610
>        shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
>        shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
>        prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
>        super_cache_scan+0x34f/0x4b0 fs/super.c:221
>        do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
>        shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
>        shrink_one+0x43b/0x850 mm/vmscan.c:4815
>        shrink_many mm/vmscan.c:4876 [inline]
>        lru_gen_shrink_node mm/vmscan.c:4954 [inline]
>        shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
>        kswapd_shrink_node mm/vmscan.c:6762 [inline]
>        balance_pgdat mm/vmscan.c:6954 [inline]
>        kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&group->mark_mutex);
>                                lock(fs_reclaim);
>   lock(&group->mark_mutex);
>
>  *** DEADLOCK ***
>
> [Analysis]
> The inotify_new_watch() call passes through GFP_KERNEL, use memalloc_nofs=
_save/
> memalloc_nofs_restore to make sure we don't end up with the fs reclaim de=
pendency.
>
> That any notification group needs to use NOFS allocations to be safe
> against this race so we can just remove FSNOTIFY_GROUP_NOFS and
> unconditionally do memalloc_nofs_save() in fsnotify_group_lock().
>
> Reported-and-tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc679f13773f295d2da53
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: remove FSNOTIFY_GROUP_NOFS in fsnotify_group_lock and unlock
> V2 -> V3: remove nofs_marks_lock and FSNOTIFY_GROUP_NOFS

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
>  fs/nfsd/filecache.c                |  2 +-
>  fs/notify/dnotify/dnotify.c        |  3 +--
>  fs/notify/fanotify/fanotify_user.c |  2 +-
>  fs/notify/group.c                  | 11 -----------
>  include/linux/fsnotify_backend.h   | 10 +++-------
>  5 files changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 24e8f1fbcebb..2bb8465474dc 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -764,7 +764,7 @@ nfsd_file_cache_init(void)
>         }
>
>         nfsd_file_fsnotify_group =3D fsnotify_alloc_group(&nfsd_file_fsno=
tify_ops,
> -                                                       FSNOTIFY_GROUP_NO=
FS);
> +                                                       0);
>         if (IS_ERR(nfsd_file_fsnotify_group)) {
>                 pr_err("nfsd: unable to create fsnotify group: %ld\n",
>                         PTR_ERR(nfsd_file_fsnotify_group));
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 46440fbb8662..d5dbef7f5c95 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -406,8 +406,7 @@ static int __init dnotify_init(void)
>                                           SLAB_PANIC|SLAB_ACCOUNT);
>         dnotify_mark_cache =3D KMEM_CACHE(dnotify_mark, SLAB_PANIC|SLAB_A=
CCOUNT);
>
> -       dnotify_group =3D fsnotify_alloc_group(&dnotify_fsnotify_ops,
> -                                            FSNOTIFY_GROUP_NOFS);
> +       dnotify_group =3D fsnotify_alloc_group(&dnotify_fsnotify_ops, 0);
>         if (IS_ERR(dnotify_group))
>                 panic("unable to allocate fsnotify group for dnotify\n");
>         dnotify_sysctl_init();
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 13454e5fd3fb..9644bc72e457 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1480,7 +1480,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>
>         /* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release=
 */
>         group =3D fsnotify_alloc_group(&fanotify_fsnotify_ops,
> -                                    FSNOTIFY_GROUP_USER | FSNOTIFY_GROUP=
_NOFS);
> +                                    FSNOTIFY_GROUP_USER);
>         if (IS_ERR(group)) {
>                 return PTR_ERR(group);
>         }
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index 1de6631a3925..18446b7b0d49 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -115,7 +115,6 @@ static struct fsnotify_group *__fsnotify_alloc_group(
>                                 const struct fsnotify_ops *ops,
>                                 int flags, gfp_t gfp)
>  {
> -       static struct lock_class_key nofs_marks_lock;
>         struct fsnotify_group *group;
>
>         group =3D kzalloc(sizeof(struct fsnotify_group), gfp);
> @@ -136,16 +135,6 @@ static struct fsnotify_group *__fsnotify_alloc_group=
(
>
>         group->ops =3D ops;
>         group->flags =3D flags;
> -       /*
> -        * For most backends, eviction of inode with a mark is not expect=
ed,
> -        * because marks hold a refcount on the inode against eviction.
> -        *
> -        * Use a different lockdep class for groups that support evictabl=
e
> -        * inode marks, because with evictable marks, mark_mutex is NOT
> -        * fs-reclaim safe - the mutex is taken when evicting inodes.
> -        */
> -       if (flags & FSNOTIFY_GROUP_NOFS)
> -               lockdep_set_class(&group->mark_mutex, &nofs_marks_lock);
>
>         return group;
>  }
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 8be029bc50b1..3ecf7768e577 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -217,7 +217,6 @@ struct fsnotify_group {
>
>  #define FSNOTIFY_GROUP_USER    0x01 /* user allocated group */
>  #define FSNOTIFY_GROUP_DUPS    0x02 /* allow multiple marks per object *=
/
> -#define FSNOTIFY_GROUP_NOFS    0x04 /* group lock is not direct reclaim =
safe */
>         int flags;
>         unsigned int owner_flags;       /* stored flags of mark_mutex own=
er */
>
> @@ -268,22 +267,19 @@ struct fsnotify_group {
>  static inline void fsnotify_group_lock(struct fsnotify_group *group)
>  {
>         mutex_lock(&group->mark_mutex);
> -       if (group->flags & FSNOTIFY_GROUP_NOFS)
> -               group->owner_flags =3D memalloc_nofs_save();
> +       group->owner_flags =3D memalloc_nofs_save();
>  }
>
>  static inline void fsnotify_group_unlock(struct fsnotify_group *group)
>  {
> -       if (group->flags & FSNOTIFY_GROUP_NOFS)
> -               memalloc_nofs_restore(group->owner_flags);
> +       memalloc_nofs_restore(group->owner_flags);
>         mutex_unlock(&group->mark_mutex);
>  }
>
>  static inline void fsnotify_group_assert_locked(struct fsnotify_group *g=
roup)
>  {
>         WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
> -       if (group->flags & FSNOTIFY_GROUP_NOFS)
> -               WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
> +       WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
>  }
>
>  /* When calling fsnotify tell it if the data is a path or inode */
> --
> 2.43.0
>

