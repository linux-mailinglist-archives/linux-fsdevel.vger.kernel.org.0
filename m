Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225ED48A57C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 03:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346228AbiAKCPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 21:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346248AbiAKCPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:15:38 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D077EC061748;
        Mon, 10 Jan 2022 18:15:37 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g14so14759783ybs.8;
        Mon, 10 Jan 2022 18:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Bpbhj9chJ1cFWhe/L/TNeVRPVCjrK1BPCGK92a8982k=;
        b=ApvR2fnsmJAmeBhPxVnn/v6O3rGWYJ5DREI2xFtlaIOafPUnziA2HzNnAvJKsgOBXX
         HEuwD1EhgRX2rrj2XkC6EMWfrWL/qM2LP90AEgtSgCqDpNclILAIplQpttXnppLus1+Q
         xmNvJh9irhvk1BLNS19/J0Hnw7UWHRv14oEAmFtkGwhgNU6ae63dnLdVDs5FbNmY4336
         RSsFvtFl7pR6TXrbinGmVayK0syM5sRyKzlJm2T7LoztOFr2GODll6YX1W5vPQxKdjpj
         eGtdz5EEwomR1iVsS6RLcfnkJa6GJX9amDVDTdlPANdhPepZnazzKHFJ3Le9GlTjnG57
         Z86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Bpbhj9chJ1cFWhe/L/TNeVRPVCjrK1BPCGK92a8982k=;
        b=wq63VDK14yvLFlEizrdo74iv5WVzQ+QgRWt/33I+wkSozFAEwq7+7Kx2Cn9VcjQoCr
         Hl6TMVTZnMF5cnq0Y/Gc+shsJ5qvmI93bOOL8WT0G3bVfqJoNkRPEVu5sYe7aaa1R021
         5VJspVfgbEuFjpdhfFv0Y3cRFLl2OTv3uQyZip8Mua9aahyfAUkMkLIYelrGIs9pLGw9
         h80/8g76eqFRiv7VfEvVeaCSaXMnH4FZqbcDhzmCYa+oI2MCCUj2bcAHis5CA3JXP7dk
         SnaSMFRuL5zDxzvDrwRqWNqn9NkobF6tcsdHN1ZLMh1XVUwkI1hrxweZFLc8kN/CAfKm
         ch3A==
X-Gm-Message-State: AOAM532Q3GvVAkqXW5gUqsxNUILyOCbeI7pj3Varmkg/7qqufwWTzy7F
        kfWHfkZ4rm2nlPOpny+dyRXVISfZcWLu+fhTd3U=
X-Google-Smtp-Source: ABdhPJxyiQrIagKIeSB54QAVSTA7LZg3wom9rPtoeR3CWGVj4CR8Qfo3y+U9WefmBni6Sa4Z7KgVLKhXtNY4AIb0FFM=
X-Received: by 2002:a25:348b:: with SMTP id b133mr3662054yba.21.1641867336713;
 Mon, 10 Jan 2022 18:15:36 -0800 (PST)
MIME-Version: 1.0
From:   cruise k <cruise4k@gmail.com>
Date:   Tue, 11 Jan 2022 10:15:26 +0800
Message-ID: <CAKcFiNCg-hp7g-yBZFBB4D8yJ7uXyLvsZ_1P8804YgqLhWUt8w@mail.gmail.com>
Subject: INFO: task hung in path_openat
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Syzkaller found the following issue:

HEAD commit: 75acfdb Linux 5.16-rc8
git tree: upstream
console output: https://pastebin.com/raw/7TSe1kGF
kernel config: https://pastebin.com/raw/XsnKfdRt

And hope the report log can help you.

INFO: task systemd-udevd:27429 blocked for more than 146 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:26528 pid:27429 ppid:  3127 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 inode_lock include/linux/fs.h:783 [inline]
 open_last_lookups fs/namei.c:3347 [inline]
 path_openat+0xa66/0x26c0 fs/namei.c:3556
 do_filp_open+0x1c1/0x290 fs/namei.c:3586
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
 do_sys_open+0xc3/0x140 fs/open.c:1228
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fde8feb06f0
RSP: 002b:00007ffdc8b61368 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8ca9880
RBP: 000000000003a2f8 R08: 000000000000fefe R09: 00007fde8ff03740
R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8ca9895
R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
 </TASK>
INFO: task systemd-udevd:27467 blocked for more than 148 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:27072 pid:27467 ppid:  3127 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 inode_lock include/linux/fs.h:783 [inline]
 open_last_lookups fs/namei.c:3347 [inline]
 path_openat+0xa66/0x26c0 fs/namei.c:3556
 do_filp_open+0x1c1/0x290 fs/namei.c:3586
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
 do_sys_open+0xc3/0x140 fs/open.c:1228
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fde8feb06f0
RSP: 002b:00007ffdc8b60d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8c989c0
RBP: 000000000003a2f8 R08: 000000000000fcfe R09: 00007fde8ff03740
R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8c989d6
R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
 </TASK>
INFO: task systemd-udevd:27515 blocked for more than 150 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:27584 pid:27515 ppid:  3127 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 inode_lock include/linux/fs.h:783 [inline]
 open_last_lookups fs/namei.c:3347 [inline]
 path_openat+0xa66/0x26c0 fs/namei.c:3556
 do_filp_open+0x1c1/0x290 fs/namei.c:3586
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
 do_sys_open+0xc3/0x140 fs/open.c:1228
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fde8feb06f0
RSP: 002b:00007ffdc8b60d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8cad110
RBP: 000000000003a2f8 R08: 000000000000fefe R09: 00007fde8ff03740
R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8cad126
R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
 </TASK>
INFO: task systemd-udevd:27530 blocked for more than 153 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd-udevd   state:D stack:26048 pid:27530 ppid:  3127 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write+0x135/0x150 kernel/locking/rwsem.c:1524
 inode_lock include/linux/fs.h:783 [inline]
 open_last_lookups fs/namei.c:3347 [inline]
 path_openat+0xa66/0x26c0 fs/namei.c:3556
 do_filp_open+0x1c1/0x290 fs/namei.c:3586
 do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
 do_sys_open+0xc3/0x140 fs/open.c:1228
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fde8feb06f0
RSP: 002b:00007ffdc8b61368 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8ca9880
RBP: 000000000003a2f8 R08: 000000000000fefe R09: 00007fde8ff03740
R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8ca9896
R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
 </TASK>
