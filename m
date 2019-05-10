Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475C11A38E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfEJT4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 15:56:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40252 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfEJT4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 15:56:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id w6so6657483otl.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEVyil1EilSaBug97TNEy4uFCkcGv7lGAtDiZWNvKOk=;
        b=ZdWM5Lm/zU96pu+6y9Ri4Q/7buhtSkDFmJeiKJcd/wTQjj6gOln2uvQunEm9PbAome
         w2G4p2AtWIXJMXx7PHeRvmyPQNl58yQCXKzQxnOYoSla7LLFt+PNXMS6BPpUwiK6RAvu
         akbx1dPES80ED4d7elUuiFMnkBlfRg0oxVqwhwPUiGr7b0j1VJ/SGtErOVopaa8LcCuD
         3OAO33SlpDnPoOHVQeOOMn4cxF/DFMhfaHt+RT6y2nIBE5mIV/esVwCqS+OVn6PRJEif
         EUKbKSjkPaxe2JidLXg69q7OdjKqkX01JNGzmSkq71feTDXfRvZ2rAiSsbsz4ZeQ1hRC
         WECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEVyil1EilSaBug97TNEy4uFCkcGv7lGAtDiZWNvKOk=;
        b=FqsJIPIMUFCZsc03MQE87BQ1Fv7WQnwZhMVcoTBNqjsu3MxVyR0bV231HusXH2+ew0
         aFkDf+2caNmU4BuKR065emA+f5dCqWRqdDYZlDbB1vuGFaMBcsM+Jhi5dZiWfUKeEGRA
         boFmfd8WJaUHDQBrsBtE1NNIUZygS5ms3dyQs+aIk/NtNTqm0vktSOEF9Pg2ivLJSua9
         M1Y/vXKX1iVCnlza2HQUw3u47+FLGLrWH0GHEHZ90R1z7Vq4nKb7qiMHr+rAeNCZn5MT
         Wb7ZMyBsEQ8Ep9n3PN4lamhHH4e4zQgeHGVsEUjRI2gjnrtI8N+RBFsCydcykilmGvxa
         +Drg==
X-Gm-Message-State: APjAAAVNnfslijeR1eH51/pdF90Fmwu8n+aeH56i1G9yM1m9tIB3/+NM
        PrX/d7nuYsMY4C91JYICV63W553DE87o9KdnCmDsXA==
X-Google-Smtp-Source: APXvYqywRzQACe8eVT5Ex9bzJgVRItooAXbhM4FkVwLvUMRe/UMkFfs+4t6y6dEBMBM/bhM65zRazNMLJryBZL6RNWE=
X-Received: by 2002:a05:6830:14c3:: with SMTP id t3mr7997187otq.235.1557518179335;
 Fri, 10 May 2019 12:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190412231102.183557-1-almasrymina@google.com> <CAHS8izOXnzkfUoAdd3LcR7eEpjtUUAcFYE+EtnyAN6Y7RNT3Mw@mail.gmail.com>
In-Reply-To: <CAHS8izOXnzkfUoAdd3LcR7eEpjtUUAcFYE+EtnyAN6Y7RNT3Mw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 10 May 2019 12:56:08 -0700
Message-ID: <CAHS8izN8GBqtBGfFsxQvv8cVU=yEmmHCyxjVMNSDoH69xBSm7Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Fix ovl_i_mutex_dir_key/p->lock/cred
 cred_guard_mutex deadlock
To:     Mina Almasry <almasrymina@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel B <shakeelb@google.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mina Almasry <almasrymina@google.com>
Date: Tue, Apr 23, 2019 at 2:32 PM
To: Mina Almasry, Greg Thelen, Shakeel B, overlayfs
Cc: Alexander Viro, open list:FILESYSTEMS (VFS and infrastructure), open list

> On Fri, Apr 12, 2019 at 4:11 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > These 3 locks are acquired simultaneously in different order causing
> > deadlock:
> >
> > https://syzkaller.appspot.com/bug?id=00f119b8bb35a3acbcfafb9d36a2752b364e8d66
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 4.19.0-rc5+ #253 Not tainted
> > ------------------------------------------------------
> > syz-executor1/545 is trying to acquire lock:
> > 00000000b04209e4 (&ovl_i_mutex_dir_key[depth]){++++}, at: inode_lock_shared include/linux/fs.h:748 [inline]
> > 00000000b04209e4 (&ovl_i_mutex_dir_key[depth]){++++}, at: do_last fs/namei.c:3323 [inline]
> > 00000000b04209e4 (&ovl_i_mutex_dir_key[depth]){++++}, at: path_openat+0x250d/0x5160 fs/namei.c:3534
> >
> > but task is already holding lock:
> > 0000000044500cca (&sig->cred_guard_mutex){+.+.}, at: prepare_bprm_creds+0x53/0x120 fs/exec.c:1404
> >
> > which lock already depends on the new lock.
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #3 (&sig->cred_guard_mutex){+.+.}:
> >        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
> >        __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
> >        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1102
> >        lock_trace+0x4c/0xe0 fs/proc/base.c:384
> >        proc_pid_stack+0x196/0x3b0 fs/proc/base.c:420
> >        proc_single_show+0x101/0x190 fs/proc/base.c:723
> >        seq_read+0x4af/0x1150 fs/seq_file.c:229
> >        do_loop_readv_writev fs/read_write.c:700 [inline]
> >        do_iter_read+0x4a3/0x650 fs/read_write.c:924
> >        vfs_readv+0x175/0x1c0 fs/read_write.c:986
> >        do_preadv+0x1cc/0x280 fs/read_write.c:1070
> >        __do_sys_preadv fs/read_write.c:1120 [inline]
> >        __se_sys_preadv fs/read_write.c:1115 [inline]
> >        __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1115
> >        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #2 (&p->lock){+.+.}:
> >        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
> >        __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
> >        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
> >        seq_read+0x71/0x1150 fs/seq_file.c:161
> >        do_loop_readv_writev fs/read_write.c:700 [inline]
> >        do_iter_read+0x4a3/0x650 fs/read_write.c:924
> >        vfs_readv+0x175/0x1c0 fs/read_write.c:986
> >        kernel_readv fs/splice.c:362 [inline]
> >        default_file_splice_read+0x53c/0xb20 fs/splice.c:417
> >        do_splice_to+0x12e/0x190 fs/splice.c:881
> >        splice_direct_to_actor+0x270/0x8f0 fs/splice.c:953
> >        do_splice_direct+0x2d4/0x420 fs/splice.c:1062
> >        do_sendfile+0x62a/0xe20 fs/read_write.c:1440
> >        __do_sys_sendfile64 fs/read_write.c:1495 [inline]
> >        __se_sys_sendfile64 fs/read_write.c:1487 [inline]
> >        __x64_sys_sendfile64+0x15d/0x250 fs/read_write.c:1487
> >        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #1 (sb_writers#5){.+.+}:
> >        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
> >        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
> >        __sb_start_write+0x214/0x370 fs/super.c:1387
> >        sb_start_write include/linux/fs.h:1566 [inline]
> >        mnt_want_write+0x3f/0xc0 fs/namespace.c:360
> >        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
> >        ovl_create_object+0x142/0x3a0 fs/overlayfs/dir.c:596
> >        ovl_create+0x2b/0x30 fs/overlayfs/dir.c:627
> >        lookup_open+0x1319/0x1b90 fs/namei.c:3234
> >        do_last fs/namei.c:3324 [inline]
> >        path_openat+0x15e7/0x5160 fs/namei.c:3534
> >        do_filp_open+0x255/0x380 fs/namei.c:3564
> >        do_sys_open+0x568/0x700 fs/open.c:1063
> >        ksys_open include/linux/syscalls.h:1276 [inline]
> >        __do_sys_creat fs/open.c:1121 [inline]
> >        __se_sys_creat fs/open.c:1119 [inline]
> >        __x64_sys_creat+0x61/0x80 fs/open.c:1119
> >        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #0 (&ovl_i_mutex_dir_key[depth]){++++}:
> >        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
> >        down_read+0xb0/0x1d0 kernel/locking/rwsem.c:24
> >        inode_lock_shared include/linux/fs.h:748 [inline]
> >        do_last fs/namei.c:3323 [inline]
> >        path_openat+0x250d/0x5160 fs/namei.c:3534
> >        do_filp_open+0x255/0x380 fs/namei.c:3564
> >        do_open_execat+0x221/0x8e0 fs/exec.c:853
> >        __do_execve_file.isra.33+0x173f/0x2540 fs/exec.c:1755
> >        do_execveat_common fs/exec.c:1866 [inline]
> >        do_execve fs/exec.c:1883 [inline]
> >        __do_sys_execve fs/exec.c:1964 [inline]
> >        __se_sys_execve fs/exec.c:1959 [inline]
> >        __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
> >        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   &ovl_i_mutex_dir_key[depth] --> &p->lock --> &sig->cred_guard_mutex
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&sig->cred_guard_mutex);
> >                                lock(&p->lock);
> >                                lock(&sig->cred_guard_mutex);
> >   lock(&ovl_i_mutex_dir_key[depth]);
> >
> >  *** DEADLOCK ***
> >
> > Solution: I establish this locking order for these locks:
> >
> > 1. ovl_i_mutex_dir_key
> > 2. p->lock
> > 3. sig->cred_guard_mutex
> >
> > In this change i fix the locking order of exec.c, which is the only
> > instance that voilates this order.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >
> >  v2: Fix wrong jump to wrong label on failure.
> >
> >  fs/exec.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 2e0033348d8e1..a23f2a7603eee 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1742,6 +1742,12 @@ static int __do_execve_file(int fd, struct filename *filename,
> >         if (retval)
> >                 goto out_ret;
> >
> > +       if (!file)
> > +               file = do_open_execat(fd, filename, flags);
> > +       retval = PTR_ERR(file);
> > +       if (IS_ERR(file))
> > +               goto out_files;
> > +
> >         retval = -ENOMEM;
> >         bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
> >         if (!bprm)
> > @@ -1754,12 +1760,6 @@ static int __do_execve_file(int fd, struct filename *filename,
> >         check_unsafe_exec(bprm);
> >         current->in_execve = 1;
> >
> > -       if (!file)
> > -               file = do_open_execat(fd, filename, flags);
> > -       retval = PTR_ERR(file);
> > -       if (IS_ERR(file))
> > -               goto out_unmark;
> > -
> >         sched_exec();
> >
> >         bprm->file = file;
> > --
> > 2.21.0.392.gf8f6787159e-goog

Friendly ping on this review.
