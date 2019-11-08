Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C98F4033
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 07:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfKHGF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 01:05:57 -0500
Received: from mx-out.tlen.pl ([193.222.135.148]:5331 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfKHGF5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 01:05:57 -0500
Received: (wp-smtpd smtp.tlen.pl 29828 invoked from network); 8 Nov 2019 07:05:50 +0100
Received: from unknown (HELO [172.20.2.55]) (p.sarna@o2.pl@[50.233.106.125])
          (envelope-sender <p.sarna@tlen.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <viro@zeniv.linux.org.uk>; 8 Nov 2019 07:05:50 +0100
Subject: Re: BUG: Dentry still in use [unmount of hugetlbfs hugetlbfs] (2)
To:     syzbot <syzbot+136d2439a4e6561ea00c@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        mike.kravetz@oracle.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000c620080596cefdf0@google.com>
From:   Piotr Sarna <p.sarna@tlen.pl>
Message-ID: <cc380f1f-129b-4e57-eb14-b659d9033157@tlen.pl>
Date:   Fri, 8 Nov 2019 07:05:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <000000000000c620080596cefdf0@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WP-MailID: 5cbcd82bbaeada83d5d08a62158d2ad0
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000005 [UTa1]                               
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The obvious culprit seems to be the unnecessary call to d_get() when 
creating a tmp file with tmpfile() call, which is then never countered 
by dput()... sloppy of me.  I don't know what the procedure is now, but 
I hope that my patch is simply dequeued from /next. I'll provide a fixed 
and retested version once I'm back from a conference.

On 11/8/19 6:24 AM, syzbot wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c68c5373 Add linux-next specific files for 20191107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f62294e00000
> kernel config: https://syzkaller.appspot.com/x/.config?x=742545dcdea21726
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=136d2439a4e6561ea00c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=12ed5264e00000
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=15fe2a64e00000
>
> The bug was bisected to:
>
> commit efe323d5cfecd2ad9dd4aa485e05312f0fa7617a
> Author: Piotr Sarna <p.sarna@tlen.pl>
> Date:   Wed Nov 6 05:06:34 2019 +0000
>
>     hugetlbfs: add O_TMPFILE support
>
> bisection log: 
> https://syzkaller.appspot.com/x/bisect.txt?x=14ac944ae00000
> final crash: https://syzkaller.appspot.com/x/report.txt?x=16ac944ae00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ac944ae00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the 
> commit:
> Reported-by: syzbot+136d2439a4e6561ea00c@syzkaller.appspotmail.com
> Fixes: efe323d5cfec ("hugetlbfs: add O_TMPFILE support")
>
> BUG: Dentry 00000000c225b886{i=685d,n=#26717}  still in use (1) 
> [unmount of hugetlbfs hugetlbfs]
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8874 at fs/dcache.c:1595 umount_check 
> fs/dcache.c:1586 [inline]
> WARNING: CPU: 1 PID: 8874 at fs/dcache.c:1595 
> umount_check.cold+0xe9/0x10a fs/dcache.c:1576
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 8874 Comm: syz-executor027 Not tainted 
> 5.4.0-rc6-next-20191107 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, 
> BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x197/0x210 lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:221
>  __warn.cold+0x2f/0x35 kernel/panic.c:582
>  report_bug+0x289/0x300 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
>  fixup_bug arch/x86/kernel/traps.c:169 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:umount_check fs/dcache.c:1595 [inline]
> RIP: 0010:umount_check.cold+0xe9/0x10a fs/dcache.c:1576
> Code: 89 ff e8 70 8f ef ff 48 81 c3 88 06 00 00 45 89 e8 4c 89 e1 53 
> 4d 8b 0f 4c 89 f2 4c 89 e6 48 c7 c7 20 d9 b6 87 e8 b1 f4 9c ff <0f> 0b 
> 58 e9 7d 1b ff ff e8 40 8f ef ff e9 29 ff ff ff 45 31 f6 e9
> RSP: 0018:ffff888095c0fbc8 EFLAGS: 00010282
> RAX: 0000000000000060 RBX: ffff888098736688 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815d0b86 RDI: ffffed1012b81f6b
> RBP: ffff888095c0fbf8 R08: 0000000000000060 R09: ffffed1015d26161
> R10: ffffed1015d26160 R11: ffff8880ae930b07 R12: ffff888090c7b300
> R13: 0000000000000001 R14: 000000000000685d R15: ffffffff8910a5e0
>  d_walk+0x27e/0x930 fs/dcache.c:1305
>  do_one_tree+0x28/0x40 fs/dcache.c:1602
>  shrink_dcache_for_umount+0x72/0x170 fs/dcache.c:1618
>  generic_shutdown_super+0x6d/0x370 fs/super.c:447
>  kill_anon_super+0x3e/0x60 fs/super.c:1106
>  kill_litter_super+0x50/0x60 fs/super.c:1115
>  deactivate_locked_super+0x95/0x100 fs/super.c:335
>  deactivate_super fs/super.c:366 [inline]
>  deactivate_super+0x1b2/0x1d0 fs/super.c:362
>  cleanup_mnt+0x351/0x4c0 fs/namespace.c:1102
>  __cleanup_mnt+0x16/0x20 fs/namespace.c:1109
>  task_work_run+0x145/0x1c0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:163
>  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x449707
> Code: 44 00 00 b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ed dc fb 
> ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 a6 00 00 00 0f 05 <48> 3d 
> 01 f0 ff ff 0f 83 cd dc fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe00511778 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00000000000108a6 RCX: 0000000000449707
> RDX: 0000000000400df0 RSI: 0000000000000002 RDI: 00007ffe00511820
> RBP: 00000000000022cb R08: 0000000000000000 R09: 0000000000000009
> R10: 0000000000000005 R11: 0000000000000202 R12: 00007ffe005128d0
> R13: 0000000002133880 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
