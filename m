Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37537B7A85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjJDIqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 04:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjJDIqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:46:53 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53E4A9;
        Wed,  4 Oct 2023 01:46:45 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4547322a756so883365137.3;
        Wed, 04 Oct 2023 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696409205; x=1697014005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc8qrZXDSoL7kpl3gyjhpQEKwXowbxIhbU9agf01R5g=;
        b=DhYbXYVS5kmM+HnklJ0KL5XYytip4NaAYOzTNholuCjQCFwl1ChjKlZj16SLn0UvrW
         5j7U8le8mB1m1nfiofwicVjK50CzngyjC2lKR5YMRsg1NkLO1VSTCd408V1yL50Cfrlx
         27pIjwk0tclsfSTMF/P8sf4N1jmxwO098wubaXMzAS4gScZ8LQESB7g7PpUsdRs6RtOk
         SAqQY9kTSpPI2uH1M5g+fN1Ym01s5fZTz9sF2vRx/I5F6Xhs3blh7hqGvVJQ0mqX1QWV
         SYHPChkcz+GkajxZMxzeau0LVuxwPcYX6P6ndWFKkPzXuVhWhNMZC6S8svvAzFatAmxU
         O/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696409205; x=1697014005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jc8qrZXDSoL7kpl3gyjhpQEKwXowbxIhbU9agf01R5g=;
        b=LXYMME8wKXkLqeBhxheQJYilHVG0k1hXnO7lyJXqHRnNHPY8KyW6IFaUs9ZDbQ3FAH
         Zyticiw96EYIZ7PAN4yEsQ7CQ+9DtqPzW1anD9dA2ThdK0WrSazPrHzuamKEv+fvLFXT
         C2w7V3Q2wxjtJW6/n+fdVmKOEYz0EP7VLVk62cIpfqV88G9G4tfs5J0CMWg5Vx+Co0Cb
         OJoYugO/Lww1xMUkpvJO7sDjnY9MA3IVVk0tW3aRiHLYSzZHIawFVnktSaleuU0ovzug
         Hx2bvmq3XdPWUpUnCb1eTO1Vl41XhKBc9xGMZFecEYAnSIXsF1+1QPDe5h22sxCn7vZm
         MMVA==
X-Gm-Message-State: AOJu0YyJQ81e+sbxfPXFamWVRUJE2+w9RzeWnJt67b1MGvc8DKOME9A1
        XjQMDNIhkqASUhuXHWChSVw+3VzWIutRqeIyqEU=
X-Google-Smtp-Source: AGHT+IEm5NmgzTa0Leub7LeZ39qMTVoZ6WBfLn7YVM/M9zVEcQWMn1fpproHR4QjJB8jEt96o3CUQoH2F/v0ZOYfZ2k=
X-Received: by 2002:a05:6102:3c7:b0:44d:4fc0:3340 with SMTP id
 n7-20020a05610203c700b0044d4fc03340mr1529589vsq.7.1696409204878; Wed, 04 Oct
 2023 01:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ca2df5060676b6d8@google.com>
In-Reply-To: <000000000000ca2df5060676b6d8@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Oct 2023 11:46:34 +0300
Message-ID: <CAOQ4uxgS3HK5eZCm-YRuqSZ8932PafmqWBZfB5diYyj7qhAfQQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in ovl_copy_up_start (2)
To:     syzbot <syzbot+e8628856801e9809216f@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 6:06=E2=80=AFAM syzbot
<syzbot+e8628856801e9809216f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    940fcc189c51 Add linux-next specific files for 20230921
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12dea70e68000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1f140ae6e669a=
c24
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De8628856801e980=
9216f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b8921b235c24/dis=
k-940fcc18.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c80a9f6bcdd4/vmlinu=
x-940fcc18.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ed10a4df6950/b=
zImage-940fcc18.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e8628856801e9809216f@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.6.0-rc2-next-20230921-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.3/15498 is trying to acquire lock:
> ffff88808e717968 (&ovl_i_lock_key[depth]#2){+.+.}-{3:3}, at: ovl_inode_lo=
ck_interruptible fs/overlayfs/overlayfs.h:630 [inline]
> ffff88808e717968 (&ovl_i_lock_key[depth]#2){+.+.}-{3:3}, at: ovl_copy_up_=
start+0x4d/0x290 fs/overlayfs/util.c:692
>
> but task is already holding lock:
> ffff88801d8b13e0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x89=
3/0x1cc0 security/integrity/ima/ima_main.c:266
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&iint->mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
>        process_measurement+0x893/0x1cc0 security/integrity/ima/ima_main.c=
:266
>        ima_file_check+0xc2/0x110 security/integrity/ima/ima_main.c:543
>        do_open fs/namei.c:3622 [inline]
>        path_openat+0x17a1/0x29c0 fs/namei.c:3777
>        do_filp_open+0x1de/0x430 fs/namei.c:3804
>        do_sys_openat2+0x176/0x1e0 fs/open.c:1422
>        do_sys_open fs/open.c:1437 [inline]
>        __do_sys_open fs/open.c:1445 [inline]
>        __se_sys_open fs/open.c:1441 [inline]
>        __x64_sys_open+0x154/0x1e0 fs/open.c:1441
>        do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> -> #1 (sb_writers#4){.+.+}-{0:0}:
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1572 [inline]
>        sb_start_write include/linux/fs.h:1647 [inline]
>        ovl_start_write+0xfe/0x2d0 fs/overlayfs/util.c:31
>        ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:830 [inline]
>        ovl_do_copy_up fs/overlayfs/copy_up.c:945 [inline]
>        ovl_copy_up_one+0x16a5/0x3250 fs/overlayfs/copy_up.c:1137
>        ovl_copy_up_flags+0x189/0x200 fs/overlayfs/copy_up.c:1192
>        ovl_xattr_set+0x387/0x4e0 fs/overlayfs/xattrs.c:56
>        __vfs_setxattr+0x173/0x1d0 fs/xattr.c:201
>        __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:235
>        __vfs_setxattr_locked+0x17e/0x250 fs/xattr.c:296
>        vfs_setxattr+0x146/0x350 fs/xattr.c:322
>        do_setxattr+0x142/0x170 fs/xattr.c:630
>        setxattr+0x159/0x170 fs/xattr.c:653
>        path_setxattr+0x1a3/0x1d0 fs/xattr.c:672
>        __do_sys_setxattr fs/xattr.c:688 [inline]
>        __se_sys_setxattr fs/xattr.c:684 [inline]
>        __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:684
>        do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> -> #0 (&ovl_i_lock_key[depth]#2){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain kernel/locking/lockdep.c:3868 [inline]
>        __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
>        lock_acquire kernel/locking/lockdep.c:5753 [inline]
>        lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
>        ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:630 [inline]
>        ovl_copy_up_start+0x4d/0x290 fs/overlayfs/util.c:692
>        ovl_copy_up_one+0x598/0x3250 fs/overlayfs/copy_up.c:1130
>        ovl_copy_up_flags+0x189/0x200 fs/overlayfs/copy_up.c:1192
>        ovl_maybe_copy_up+0x124/0x160 fs/overlayfs/copy_up.c:1222
>        ovl_open+0x16f/0x330 fs/overlayfs/file.c:166
>        do_dentry_open+0x88b/0x1730 fs/open.c:929
>        vfs_open fs/open.c:1063 [inline]
>        dentry_open+0x13f/0x1d0 fs/open.c:1079
>        ima_calc_file_hash+0x2c4/0x4a0 security/integrity/ima/ima_crypto.c=
:558
>        ima_collect_measurement+0x5e2/0x6f0 security/integrity/ima/ima_api=
.c:289
>        process_measurement+0xc87/0x1cc0 security/integrity/ima/ima_main.c=
:345
>        ima_file_check+0xc2/0x110 security/integrity/ima/ima_main.c:543
>        do_open fs/namei.c:3622 [inline]
>        path_openat+0x17a1/0x29c0 fs/namei.c:3777
>        do_filp_open+0x1de/0x430 fs/namei.c:3804
>        do_sys_openat2+0x176/0x1e0 fs/open.c:1422
>        do_sys_open fs/open.c:1437 [inline]
>        __do_sys_openat fs/open.c:1453 [inline]
>        __se_sys_openat fs/open.c:1448 [inline]
>        __x64_sys_openat+0x175/0x210 fs/open.c:1448
>        do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>        do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> other info that might help us debug this:
>
> Chain exists of:
>   &ovl_i_lock_key[depth]#2 --> sb_writers#4 --> &iint->mutex
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&iint->mutex);
>                                lock(sb_writers#4);
>                                lock(&iint->mutex);
>   lock(&ovl_i_lock_key[depth]#2);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor.3/15498:
>  #0: ffff88801d8b13e0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement=
+0x893/0x1cc0 security/integrity/ima/ima_main.c:266
>
> stack backtrace:
> CPU: 0 PID: 15498 Comm: syz-executor.3 Not tainted 6.6.0-rc2-next-2023092=
1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/04/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain kernel/locking/lockdep.c:3868 [inline]
>  __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
>  lock_acquire kernel/locking/lockdep.c:5753 [inline]
>  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
>  __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>  __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
>  ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:630 [inline]
>  ovl_copy_up_start+0x4d/0x290 fs/overlayfs/util.c:692
>  ovl_copy_up_one+0x598/0x3250 fs/overlayfs/copy_up.c:1130
>  ovl_copy_up_flags+0x189/0x200 fs/overlayfs/copy_up.c:1192
>  ovl_maybe_copy_up+0x124/0x160 fs/overlayfs/copy_up.c:1222
>  ovl_open+0x16f/0x330 fs/overlayfs/file.c:166
>  do_dentry_open+0x88b/0x1730 fs/open.c:929
>  vfs_open fs/open.c:1063 [inline]
>  dentry_open+0x13f/0x1d0 fs/open.c:1079
>  ima_calc_file_hash+0x2c4/0x4a0 security/integrity/ima/ima_crypto.c:558
>  ima_collect_measurement+0x5e2/0x6f0 security/integrity/ima/ima_api.c:289
>  process_measurement+0xc87/0x1cc0 security/integrity/ima/ima_main.c:345
>  ima_file_check+0xc2/0x110 security/integrity/ima/ima_main.c:543
>  do_open fs/namei.c:3622 [inline]
>  path_openat+0x17a1/0x29c0 fs/namei.c:3777
>  do_filp_open+0x1de/0x430 fs/namei.c:3804
>  do_sys_openat2+0x176/0x1e0 fs/open.c:1422
>  do_sys_open fs/open.c:1437 [inline]
>  __do_sys_openat fs/open.c:1453 [inline]
>  __se_sys_openat fs/open.c:1448 [inline]
>  __x64_sys_openat+0x175/0x210 fs/open.c:1448
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f30bf67cae9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f30c03990c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f30bf79c050 RCX: 00007f30bf67cae9
> RDX: 0000000000008443 RSI: 0000000020004280 RDI: ffffffffffffff9c
> RBP: 00007f30bf6c847a R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000000cc R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000006e R14: 00007f30bf79c050 R15: 00007ffce77ebe68
>  </TASK>
>
>

This looks like a new report that started after:
346f114cc506 ovl: reorder ovl_want_write() after ovl_inode_lock()

but the root cause looks like the same old false positive

#syz dup: possible deadlock in mnt_want_write (2)
