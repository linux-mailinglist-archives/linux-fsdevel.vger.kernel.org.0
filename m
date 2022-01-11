Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9056D48A67C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 04:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiAKDjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 22:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiAKDjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:39:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25ACC06173F;
        Mon, 10 Jan 2022 19:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ts/n3siA3nMVMadT3uCIkpSxRREOFD9Q0gbm2aG02OE=; b=nBsDDkttTOd7ZQsB5LQnQnAN2X
        57ss9ztEQtVysHd8qzJrjnjJcYIe8VsLj2IdJ/xXOoNwId1dU/Y/gvjCzuGx2dHhhL5K4SacQ0hdr
        LV0AzxmU8/bjo6g5dQtbjkz4f7nsNOW0HtNXa4XOmxTM4Ooql8XcoQ5cO9/cl4HCV1hLXNrFRrzhM
        UT71eRmc3bFnyIIc0G3CaWdFGxb1LBzqoiPbLMdj/ICCNB95ukDTwRp0IBlhApd6bgV848wsOwhh6
        RSG6ifM9zdXSTp+sux/WGIq48EkT+myoLjN2W3uWkNe9lAj9Yxp7ozGAjDyLWNTiBTVk0QlrARvfD
        hKO3Wj9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n77zx-002wLj-H6; Tue, 11 Jan 2022 03:39:01 +0000
Date:   Tue, 11 Jan 2022 03:39:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     cruise k <cruise4k@gmail.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunhao.th@gmail.com, syzkaller@googlegroups.com
Subject: Re: INFO: task hung in path_openat
Message-ID: <Ydz71Ux9fCVB2bGB@casper.infradead.org>
References: <CAKcFiNCg-hp7g-yBZFBB4D8yJ7uXyLvsZ_1P8804YgqLhWUt8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKcFiNCg-hp7g-yBZFBB4D8yJ7uXyLvsZ_1P8804YgqLhWUt8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dmitry,

Please stop syzbot from playing with the SCHED_FIFO setting.
We're being inundated with these useless bug reports.

On Tue, Jan 11, 2022 at 10:15:26AM +0800, cruise k wrote:
> Hi,
> 
> Syzkaller found the following issue:
> 
> HEAD commit: 75acfdb Linux 5.16-rc8
> git tree: upstream
> console output: https://pastebin.com/raw/7TSe1kGF
> kernel config: https://pastebin.com/raw/XsnKfdRt
> 
> And hope the report log can help you.
> 
> INFO: task systemd-udevd:27429 blocked for more than 146 seconds.
>       Not tainted 5.16.0-rc8+ #10
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:systemd-udevd   state:D stack:26528 pid:27429 ppid:  3127 flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:4972 [inline]
>  __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
>  schedule+0xd2/0x260 kernel/sched/core.c:6326
>  rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
>  __down_write_common kernel/locking/rwsem.c:1268 [inline]
>  __down_write_common kernel/locking/rwsem.c:1265 [inline]
>  __down_write kernel/locking/rwsem.c:1277 [inline]
>  down_write+0x135/0x150 kernel/locking/rwsem.c:1524
>  inode_lock include/linux/fs.h:783 [inline]
>  open_last_lookups fs/namei.c:3347 [inline]
>  path_openat+0xa66/0x26c0 fs/namei.c:3556
>  do_filp_open+0x1c1/0x290 fs/namei.c:3586
>  do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
>  do_sys_open+0xc3/0x140 fs/open.c:1228
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fde8feb06f0
> RSP: 002b:00007ffdc8b61368 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
> RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8ca9880
> RBP: 000000000003a2f8 R08: 000000000000fefe R09: 00007fde8ff03740
> R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8ca9895
> R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
>  </TASK>
> INFO: task systemd-udevd:27467 blocked for more than 148 seconds.
>       Not tainted 5.16.0-rc8+ #10
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:systemd-udevd   state:D stack:27072 pid:27467 ppid:  3127 flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:4972 [inline]
>  __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
>  schedule+0xd2/0x260 kernel/sched/core.c:6326
>  rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
>  __down_write_common kernel/locking/rwsem.c:1268 [inline]
>  __down_write_common kernel/locking/rwsem.c:1265 [inline]
>  __down_write kernel/locking/rwsem.c:1277 [inline]
>  down_write+0x135/0x150 kernel/locking/rwsem.c:1524
>  inode_lock include/linux/fs.h:783 [inline]
>  open_last_lookups fs/namei.c:3347 [inline]
>  path_openat+0xa66/0x26c0 fs/namei.c:3556
>  do_filp_open+0x1c1/0x290 fs/namei.c:3586
>  do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
>  do_sys_open+0xc3/0x140 fs/open.c:1228
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fde8feb06f0
> RSP: 002b:00007ffdc8b60d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
> RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8c989c0
> RBP: 000000000003a2f8 R08: 000000000000fcfe R09: 00007fde8ff03740
> R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8c989d6
> R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
>  </TASK>
> INFO: task systemd-udevd:27515 blocked for more than 150 seconds.
>       Not tainted 5.16.0-rc8+ #10
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:systemd-udevd   state:D stack:27584 pid:27515 ppid:  3127 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:4972 [inline]
>  __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
>  schedule+0xd2/0x260 kernel/sched/core.c:6326
>  rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
>  __down_write_common kernel/locking/rwsem.c:1268 [inline]
>  __down_write_common kernel/locking/rwsem.c:1265 [inline]
>  __down_write kernel/locking/rwsem.c:1277 [inline]
>  down_write+0x135/0x150 kernel/locking/rwsem.c:1524
>  inode_lock include/linux/fs.h:783 [inline]
>  open_last_lookups fs/namei.c:3347 [inline]
>  path_openat+0xa66/0x26c0 fs/namei.c:3556
>  do_filp_open+0x1c1/0x290 fs/namei.c:3586
>  do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
>  do_sys_open+0xc3/0x140 fs/open.c:1228
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fde8feb06f0
> RSP: 002b:00007ffdc8b60d78 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
> RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8cad110
> RBP: 000000000003a2f8 R08: 000000000000fefe R09: 00007fde8ff03740
> R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8cad126
> R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
>  </TASK>
> INFO: task systemd-udevd:27530 blocked for more than 153 seconds.
>       Not tainted 5.16.0-rc8+ #10
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:systemd-udevd   state:D stack:26048 pid:27530 ppid:  3127 flags:0x00000000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:4972 [inline]
>  __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
>  schedule+0xd2/0x260 kernel/sched/core.c:6326
>  rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
>  __down_write_common kernel/locking/rwsem.c:1268 [inline]
>  __down_write_common kernel/locking/rwsem.c:1265 [inline]
>  __down_write kernel/locking/rwsem.c:1277 [inline]
>  down_write+0x135/0x150 kernel/locking/rwsem.c:1524
>  inode_lock include/linux/fs.h:783 [inline]
>  open_last_lookups fs/namei.c:3347 [inline]
>  path_openat+0xa66/0x26c0 fs/namei.c:3556
>  do_filp_open+0x1c1/0x290 fs/namei.c:3586
>  do_sys_openat2+0x61b/0x9a0 fs/open.c:1212
>  do_sys_open+0xc3/0x140 fs/open.c:1228
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fde8feb06f0
> RSP: 002b:00007ffdc8b61368 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fde8feb06f0
> RDX: 0000000000000180 RSI: 00000000000800c2 RDI: 00005624b8ca9880
> RBP: 000000000003a2f8 R08: 000000000000fefe R09: 00007fde8ff03740
> R10: 0000000000000000 R11: 0000000000000246 R12: 00005624b8ca9896
> R13: 8421084210842109 R14: 00000000000800c2 R15: 00007fde8ff3e540
>  </TASK>
