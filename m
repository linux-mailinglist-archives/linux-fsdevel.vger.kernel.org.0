Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D743CDC43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbhGSOvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344431AbhGSOss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:48:48 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D66C0613A9
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 07:41:35 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id h5so9504653vsg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjiH1/YnFLckwUasoeKSaPcZP1uajCNCDPTrO6JXzNs=;
        b=WFch/tkRRnxVJ17Dby1P3cYgzcNJA1oLTdtUroWQqsYM5RAajIoMecg+MX/OIm3rjx
         n9W068o6YreyOSfhHhCQ8WoJTXJN+nOIyQnJkOadRBWhrO1uVbqwlE8yo9cAiDJU7x+J
         W96hUEygPS4ZAeGWBZTMmWSXX3riBwG68ESZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjiH1/YnFLckwUasoeKSaPcZP1uajCNCDPTrO6JXzNs=;
        b=YlNrX5hgH5R90SDBi/wFZBqkOnhlDG6JNo3xjYME78GtFF3lC0YtM4ALNO1ZfCZS6Z
         VIOeQ1Bf+79PuHeH8CNv/IsJaLmr8LDFKGUhsl0TJLAwjSU1nXRw5rIuJPmfSNYKLKch
         C4wcT9ZgDNffTAlZPdq1OMO4bXCry/2a2vVGB+24UJdUHSR2/g1glFmDVtGyhrMw+8+z
         gCQGYzQbzUisYZ5TwmQkQbkstq3splyfCTTIzMDmAuKsnHWEYux/wZcp2e23gqAqyaKv
         bIh7xSZZnf4pVP0rbUBNoScmtABmKLo5Sy6Jq/GUX+Q5RrxjjF9TuTW5oL7btTtLqfrD
         ZFxA==
X-Gm-Message-State: AOAM53352mY0ZfS+mrJHOwj9VgTmgBf3rFyjHjKgSm5tuks5jFpmzBZb
        hcB62e5oUl3PpAxaixc+M0Kg6MfrZmhc0/EDplLOVIfvQZ6yug==
X-Google-Smtp-Source: ABdhPJy/kVV4j1YiP2Dwqz+GRGm0j7Za8dDJP8TPfNlhMLX2qbeoU5pogatCV4NLvaFEeCQzeCdkBUtQnqD3ko8wWX0=
X-Received: by 2002:a05:6102:209c:: with SMTP id h28mr21982028vsr.21.1626707500317;
 Mon, 19 Jul 2021 08:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000067d24205c4d0e599@google.com>
In-Reply-To: <00000000000067d24205c4d0e599@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 19 Jul 2021 17:11:29 +0200
Message-ID: <CAJfpegsYNcv+mEVpLBxVGSQhXr0Q_UnOUC1VkYuYB=xzRt+f-A@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
To:     syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC: linux-intergrity]

On Tue, 15 Jun 2021 at 18:59, syzbot
<syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    06af8679 coredump: Limit what can interrupt coredumps
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=162f99afd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
> dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.13.0-rc5-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor.1/21398 is trying to acquire lock:
> ffff8881485a6460 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:375
>
> but task is already holding lock:
> ffff888034945bc0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x75a/0x1ba0 security/integrity/ima/ima_main.c:253
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&iint->mutex){+.+.}-{3:3}:
>        lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
>        __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
>        __mutex_lock kernel/locking/mutex.c:1104 [inline]
>        mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
>        process_measurement+0x75a/0x1ba0 security/integrity/ima/ima_main.c:253
>        ima_file_check+0xe0/0x130 security/integrity/ima/ima_main.c:499
>        do_open fs/namei.c:3363 [inline]
>        path_openat+0x293d/0x39b0 fs/namei.c:3494
>        do_filp_open+0x221/0x460 fs/namei.c:3521
>        do_sys_openat2+0x124/0x460 fs/open.c:1187
>        do_sys_open fs/open.c:1203 [inline]
>        __do_sys_open fs/open.c:1211 [inline]
>        __se_sys_open fs/open.c:1207 [inline]
>        __x64_sys_open+0x221/0x270 fs/open.c:1207
>        do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> -> #0 (sb_writers#5){.+.+}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:2938 [inline]
>        check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
>        validate_chain kernel/locking/lockdep.c:3676 [inline]
>        __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
>        lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1763 [inline]
>        sb_start_write+0x4f/0x180 include/linux/fs.h:1833
>        mnt_want_write+0x3b/0x80 fs/namespace.c:375
>        ovl_maybe_copy_up+0x117/0x180 fs/overlayfs/copy_up.c:996
>        ovl_open+0xa2/0x200 fs/overlayfs/file.c:149
>        do_dentry_open+0x7cb/0x1010 fs/open.c:826
>        vfs_open fs/open.c:940 [inline]
>        dentry_open+0xc6/0x120 fs/open.c:956
>        ima_calc_file_hash+0x157/0x1b00 security/integrity/ima/ima_crypto.c:557
>        ima_collect_measurement+0x283/0x520 security/integrity/ima/ima_api.c:252
>        process_measurement+0xf79/0x1ba0 security/integrity/ima/ima_main.c:330
>        ima_file_check+0xe0/0x130 security/integrity/ima/ima_main.c:499
>        do_open fs/namei.c:3363 [inline]
>        path_openat+0x293d/0x39b0 fs/namei.c:3494
>        do_filp_open+0x221/0x460 fs/namei.c:3521
>        do_sys_openat2+0x124/0x460 fs/open.c:1187
>        do_sys_open fs/open.c:1203 [inline]
>        __do_sys_open fs/open.c:1211 [inline]
>        __se_sys_open fs/open.c:1207 [inline]
>        __x64_sys_open+0x221/0x270 fs/open.c:1207
>        do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&iint->mutex);
>                                lock(sb_writers#5);
>                                lock(&iint->mutex);
>   lock(sb_writers#5);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor.1/21398:
>  #0: ffff888034945bc0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x75a/0x1ba0 security/integrity/ima/ima_main.c:253
>
> stack backtrace:
> CPU: 0 PID: 21398 Comm: syz-executor.1 Not tainted 5.13.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x202/0x31e lib/dump_stack.c:120
>  print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2007
>  check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2129
>  check_prev_add kernel/locking/lockdep.c:2938 [inline]
>  check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
>  validate_chain kernel/locking/lockdep.c:3676 [inline]
>  __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
>  lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
>  percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>  __sb_start_write include/linux/fs.h:1763 [inline]
>  sb_start_write+0x4f/0x180 include/linux/fs.h:1833
>  mnt_want_write+0x3b/0x80 fs/namespace.c:375
>  ovl_maybe_copy_up+0x117/0x180 fs/overlayfs/copy_up.c:996
>  ovl_open+0xa2/0x200 fs/overlayfs/file.c:149
>  do_dentry_open+0x7cb/0x1010 fs/open.c:826
>  vfs_open fs/open.c:940 [inline]
>  dentry_open+0xc6/0x120 fs/open.c:956
>  ima_calc_file_hash+0x157/0x1b00 security/integrity/ima/ima_crypto.c:557
>  ima_collect_measurement+0x283/0x520 security/integrity/ima/ima_api.c:252
>  process_measurement+0xf79/0x1ba0 security/integrity/ima/ima_main.c:330
>  ima_file_check+0xe0/0x130 security/integrity/ima/ima_main.c:499
>  do_open fs/namei.c:3363 [inline]
>  path_openat+0x293d/0x39b0 fs/namei.c:3494
>  do_filp_open+0x221/0x460 fs/namei.c:3521
>  do_sys_openat2+0x124/0x460 fs/open.c:1187
>  do_sys_open fs/open.c:1203 [inline]
>  __do_sys_open fs/open.c:1211 [inline]
>  __se_sys_open fs/open.c:1207 [inline]
>  __x64_sys_open+0x221/0x270 fs/open.c:1207
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665d9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f28cc64c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000020000200
> RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
> R13: 00007ffdd1759cef R14: 00007f28cc64c300 R15: 0000000000022000
> overlayfs: upperdir is in-use as upperdir/workdir of another mount, mount with '-o index=off' to override exclusive upperdir protection.
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
