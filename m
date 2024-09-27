Return-Path: <linux-fsdevel+bounces-30249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95098869A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 15:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D36B1F21157
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B01BF333;
	Fri, 27 Sep 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK7q693o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41714B948;
	Fri, 27 Sep 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445566; cv=none; b=RSlmvIFIjOAZKjNzle+/UNXGVeM/IBgP/T7Kbj/37mwcO+VJ36CHRwFK/Z3Rck8q9qztZ3HsmRYO1S/g+b2h9CJ3Qk/HZs4QS1OuJOtYYKdVm/53avdTFt/ZAspYcD11SlPl0HbtUhaDpVazhmYg4L/whUv5K8igthAGlUEzLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445566; c=relaxed/simple;
	bh=QOO7bM3BxCld4I7w3SKm6fR/fATGrMJwlKz/o5jA1dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTBPyMrnAjrWywZE5ufgaRlvHTv5SpODsetGoVCf4zhI/HwEK31kAcD0X0PcblasTaha0xIGMAma/xIce5n8HFjkRLu227866u2KPYk2C2TqMix9Ihtzg7QRjepkPrMjUiJWMJQ8bBJhJx4NSYC7KFHeEdjOw25XoVN8Y3Bx5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK7q693o; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9b049251eso153576885a.2;
        Fri, 27 Sep 2024 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727445563; x=1728050363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC84xRtiM2EHhYrzttd5edITO3mZ2UNQ01fEBAONKVQ=;
        b=bK7q693ouekQujBCcFqmxt8HIM8QNa/Loa6jqvsc7W4AO1GwEi+yp1c5iuGzPB9q+T
         yHjI3k+wlBg9fWf4m0wqreAcH5wJlVzkXseSJo3oIEyBnSb9Bb0zTEiAaky22PTtTrNP
         kamSNAHecJu8EcnvIpFzNLOPrKvpDa6nyDXW6lgBp0k69SB7bCiHpdZjHFQYujUNYLS9
         rczeNoDQYa0qEmSSaUfmYMcczdvxueBlosXUyemU42oVGNZ2RCugRfWhm0FzufP8LePR
         B8/X4ZzwsKqqIJ8HqaAWrUj0kCn/CDustdBAIpGCuXK8Xj5Xk+L7atTiZtCSDeCS0/A1
         PFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727445563; x=1728050363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC84xRtiM2EHhYrzttd5edITO3mZ2UNQ01fEBAONKVQ=;
        b=GemfiTCXKYdD3GnzTqTKhlSCnabIWKYh9PiDIFpesHYsb3JdIfX2BTxvbqQ/HPMuKP
         WPBapqzV6/T2AT8ufdTMG5f3BfXNvVF4v+KFpSGwNwMneO3E9CAOMlCIrfv8JcxllaIA
         kRbGvf5dbhRH3E9IlxcJu/rht+SD2dDcHynmHG4lrTPQcmWaKlZ6s8iAjqyBPSqIPeU1
         95YqJSu9c7zsKlReuZZqywhpo68U70m+mjLSnPHuXKxNCEOBfmVkqnZveUd9r9g4pYtR
         KEE+rMiqvIIGj/KdbMfz1De+LgErZSPldDrwFyS+phgojyhqgCUHur+oqfWGq6GE//X2
         JMdw==
X-Forwarded-Encrypted: i=1; AJvYcCUSNWCONh3RaNa6z6I5i3QR+ueX8C55NSvh5wXaDUvyfTTd9U/1BUk/pEB5VslGNeoQoQvRlfhV/e+SacHX@vger.kernel.org, AJvYcCV38WOiiep18i5bRVlk1kkuxci3YMAq7tDCrjSj9hWozpUezC/KX7piaS8rKAOwE7v77JyEKLYKmr1/NVD/@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkZj1wOUIAhMdFrT0GLT22fEDYx2LcZqAtmU7DqrAn90JlohF
	P0wppWbXt03cPfHjsdpymmxliuJ0iCOwWPh/gW/qxqD0+bug60aF+pQH1S/ODYBmTJPoKIqAt23
	wzsTUpVYAjCrZRPOnwsHteyStsME=
X-Google-Smtp-Source: AGHT+IEGgVbTI6rRNCD7pZtEj3ilFW9TedoUVleeLwkzfoBUcEEbG6RX5Mm1endL3sQDchKRXHWEoacW+QnTOAjyn1c=
X-Received: by 2002:a05:620a:462b:b0:7a2:32e:3c40 with SMTP id
 af79cd13be357-7ae37825ff7mr458844585a.10.1727445563058; Fri, 27 Sep 2024
 06:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927102050.cfr4ovprdbgiicgk@quack3> <20240927133826.2037827-1-lizhi.xu@windriver.com>
In-Reply-To: <20240927133826.2037827-1-lizhi.xu@windriver.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 15:59:11 +0200
Message-ID: <CAOQ4uxhrSSpPijzeuFWRZBrgZvEyk6aLK=q7fBz3rpiZcHZrvg@mail.gmail.com>
Subject: Re: [PATCH V2] inotify: Fix possible deadlock in fsnotify_destroy_mark
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net, 
	syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:38=E2=80=AFPM Lizhi Xu <lizhi.xu@windriver.com> w=
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
>
>  fs/notify/inotify/inotify_user.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 8be029bc50b1..7b0a2809fc2d 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -268,14 +268,12 @@ struct fsnotify_group {
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

You missed several more instances of FSNOTIFY_GROUP_NOFS
that need to be removed, and please also remove the definition of the
flag as well as the nofs_marks_lock lockdep key that is no longer needed.

Thanks,
Amir.

