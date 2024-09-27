Return-Path: <linux-fsdevel+bounces-30237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF298988164
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2C5281894
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4C1BA29B;
	Fri, 27 Sep 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKFVmRIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D015ADAB;
	Fri, 27 Sep 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429525; cv=none; b=S0bz7xTWGMFTJ5PMKiZJjG6CH9yKKGMAK3QYSWOj2uQmVYaUIUlDih4q3ymrhAgB2SMZ2p+ABF2v5GO7nifKgCpkCkk/DNn+Vkl0hzNicAWSAe9YN5y28ovjAypquXva1GRv8jzDuAzx+WOUZGm2vj3g/HbGi7TONSNhsGqjKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429525; c=relaxed/simple;
	bh=1u3Jh/UIZuJLDJnw7d+7fH8k3dsYsJrTqdYJqGUbpDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuCiRpLy7xvobUM9VF/HwHeXVshwSGoHY8bI4fyKIGfv65CNOFMCaM+cfWLOdQ+0KRSzC36XEjAZqcuizTPEuzFDmAHADmDVgW8GQCkNvSowiLDJ0F3BIvSJpo9uUIHxZEPvmSEtAhMrEnI+SnpttY03Bd1P/g6pbHo1ZqmaQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKFVmRIf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9ae8fc076so197095785a.2;
        Fri, 27 Sep 2024 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727429522; x=1728034322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c+I7gHUH1e9sdXZem1htz7bPvM2fmVIcsfmToZQMSg=;
        b=dKFVmRIf511t6mCrzt6N0sTuBnxlCGytCGc0yihQmsRGXAiodO0vgbMn0WESzItNcS
         xOckZJJ75nV4cLwvLxiZ4rf4ReLNZBz+0wNGSlC/jwnON3ZS2hTpia6ll3CUztL0RFa/
         V4LWT5n/pdKwFgH++ct5QMdlupyBrRlIUXCLll1hMH7E7JZxxxJrQo6dLBBap6/ZU4LO
         bjIIOh/+CGkMflYnNY7ngQt0gTDoBf00+57/OOGuBHivPZfcFlQ2+gMX2EbVpYS5uBJX
         8sobGxutIU5H7/2frzF5kLcT/NwPaEPcqZpI+nsJYCZip0RVMcbS6dRZ7g+zKbR64v4C
         d5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727429522; x=1728034322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c+I7gHUH1e9sdXZem1htz7bPvM2fmVIcsfmToZQMSg=;
        b=Z/cdkdMebw2y1csZjGXOCu8QKKx93KU+dBMUA8FPHecE5o+LbaqM8u2oNWQvtrbJdw
         eWkayszmAnxSNg5oB2xQaSMwuR7GBtlcY75FSuGda18sTSddRFGvNhfLJMdTNLgVeW3W
         LytHM0+d5xJ7Se6MhR96e1Fp9PQfMH/h1PYHqlcn/uGrKaGMn+ISJXBUDieGUyseOkGa
         d+rU/xmuAPR6GVmp63qwbmXQN1m9HGKbML6qmpCPPasynJcyBRvq7tvj8VmSU6ehYMuX
         I72yM/o+FG7H3fyBgtGTPnSSJ1obfZJ7XBXZCsMZOljfoTs5pnNF4VVy92M/ieUV0b+9
         43mA==
X-Forwarded-Encrypted: i=1; AJvYcCUjthSaICPPI9sXvPJfEmMv5HSGFpcJ/AJvql46YAiJWxxd9Mmwiwb1hLvGZxwPPfngTU1H58Ro6OuFl6KW@vger.kernel.org, AJvYcCW+IsZj/vagxopXNe8KOcM6G2uoBpfjZzD50mcmrAxB7zkdNLdiWjtgt2W+It4e9A/bys+KrGd+kFDRJfCq@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLza099t2YkHp0atdISZ8ZI5WQlNJErh1L7EcZ7DGQShkc2uo
	5S2EdEYsll7oYJzLtyBWcSmv0TpQiSVXDU8x9oCp8iS9iJdQPeF0Vp0B5qVIRP5IKrUxRbVvIEp
	08guMUAfaKHh/ABm+Rf9S6LH/gXM=
X-Google-Smtp-Source: AGHT+IF1NuPXfaKfAxBNpri7aAOKoZiHK/lYhFguw0ncwR6N8hJueOWy4KntXXBTxPEkRNxcxPMGlq3dhrDqzQM60Ww=
X-Received: by 2002:a05:620a:bc8:b0:7a9:bdd4:b4ea with SMTP id
 af79cd13be357-7ae37822083mr371011585a.9.1727429522024; Fri, 27 Sep 2024
 02:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ae63710620417f67@google.com> <20240927091231.360334-1-lizhi.xu@windriver.com>
In-Reply-To: <20240927091231.360334-1-lizhi.xu@windriver.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 11:31:50 +0200
Message-ID: <CAOQ4uxisuBYc6Zy7D8p+RkWxq3g=Hij99wKMrL_FqRmOFx-wXQ@mail.gmail.com>
Subject: Re: [PATCH] inotify: Fix possible deadlock in fsnotify_destroy_mark
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:12=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> =
wrote:
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

I don't think this can actually happen, because an inode with
an inotify mark cannot get evicted, but I cannot think of a way to annotate
this to lockdep, so if we need to silence lockdep, this is what
FSNOTIFY_GROUP_NOFS was created for.

Thanks,
Amir.

>
> Reported-and-tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc679f13773f295d2da53
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/notify/inotify/inotify_user.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify=
_user.c
> index c7e451d5bd51..70b77b6186a6 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -643,8 +643,13 @@ static int inotify_update_watch(struct fsnotify_grou=
p *group, struct inode *inod
>         /* try to update and existing watch with the new arg */
>         ret =3D inotify_update_existing_watch(group, inode, arg);
>         /* no mark present, try to add a new one */
> -       if (ret =3D=3D -ENOENT)
> +       if (ret =3D=3D -ENOENT) {
> +               unsigned int nofs_flag;
> +
> +               nofs_flag =3D memalloc_nofs_save();
>                 ret =3D inotify_new_watch(group, inode, arg);
> +               memalloc_nofs_restore(nofs_flag);
> +       }
>         fsnotify_group_unlock(group);
>
>         return ret;
> --
> 2.43.0
>

