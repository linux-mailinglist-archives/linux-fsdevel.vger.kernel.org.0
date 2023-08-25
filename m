Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9C788721
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbjHYMY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbjHYMYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:24:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102126B2;
        Fri, 25 Aug 2023 05:24:07 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXJty6GNmzVkMk;
        Fri, 25 Aug 2023 20:20:26 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 20:22:45 +0800
Subject: Re: [syzbot] [ext4?] BUG: unable to handle kernel paging request in
 ext4_calculate_overhead
To:     syzbot <syzbot+b3123e6d9842e526de39@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <nathan@kernel.org>, <ndesaulniers@google.com>,
        <syzkaller-bugs@googlegroups.com>, <trix@redhat.com>,
        <tytso@mit.edu>
References: <000000000000b1426e0603bc40b6@google.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <a220f4f7-e8b4-d8f8-0840-522ca123d21a@huawei.com>
Date:   Fri, 25 Aug 2023 20:22:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <000000000000b1426e0603bc40b6@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/25 17:48, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    47d9bb711707 Add linux-next specific files for 20230821
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=124d6a4ba80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
> dashboard link: https://syzkaller.appspot.com/bug?extid=b3123e6d9842e526de39
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110f9c0fa80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b8867fa80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ffbe03c733b7/disk-47d9bb71.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a61a31d6caf9/vmlinux-47d9bb71.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/37e6f882b2d9/bzImage-47d9bb71.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/bf27f1330349/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 99d6c5d892bfff3be40f83ec34d91d562125afd4
> Author: Zhang Yi <yi.zhang@huawei.com>
> Date:   Fri Aug 11 06:36:10 2023 +0000
> 
>     ext4: ext4_get_{dev}_journal return proper error value
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a381cfa80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=106381cfa80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a381cfa80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b3123e6d9842e526de39@syzkaller.appspotmail.com
> Fixes: 99d6c5d892bf ("ext4: ext4_get_{dev}_journal return proper error value")
> 
> EXT4-fs (loop0): ext4_check_descriptors: Checksum for group 0 failed (394!=20869)
> EXT4-fs error (device loop0): ext4_get_journal_inode:5719: comm syz-executor999: inode #33: comm syz-executor999: iget: illegal inode #
> EXT4-fs (loop0): no journal found
> BUG: unable to handle page fault for address: ffffffffffffffdb

Thanks for the report, It's a real issue and I'm sorry to introduce
it due to my carelessness on commit '99d6c5d892bf ("ext4:
ext4_get_{dev}_journal return proper error value")'. The problem is
that I forgot to modify ext4_calculate_overhead() together to handle
the error return value from ext4_get_journal_inode() properly. I will
fix it soon.

Thanks,
Yi.

> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD c979067 P4D c979067 PUD c97b067 PMD 0 
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5041 Comm: syz-executor999 Not tainted 6.5.0-rc7-next-20230821-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:ext4_calculate_overhead+0xfd2/0x1380 fs/ext4/super.c:4182
> Code: 7b 50 48 89 fa 48 c1 ea 03 44 0f b6 60 14 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 72 03 00 00 44 89 e6 bf 3f 00 00 00 <48> 8b 6b 50 e8 95 20 43 ff 41 80 fc 3f 0f 87 cb 20 ef 07 e8 56 25
> RSP: 0018:ffffc9000399fa00 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffffffffffff8b RCX: 0000000000000000
> RDX: 1ffffffffffffffb RSI: 000000000000000a RDI: 000000000000003f
> RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000001 R12: 000000000000000a
> R13: ffff888020936000 R14: dffffc0000000000 R15: ffff8880242a4000
> FS:  0000555555f06380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffdb CR3: 0000000074f9b000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __ext4_fill_super fs/ext4/super.c:5391 [inline]
>  ext4_fill_super+0x85e3/0xade0 fs/ext4/super.c:5643
>  get_tree_bdev+0x390/0x630 fs/super.c:1351
>  vfs_get_tree+0x88/0x350 fs/super.c:1524
>  do_new_mount fs/namespace.c:3335 [inline]
>  path_mount+0x1492/0x1ed0 fs/namespace.c:3662
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount fs/namespace.c:3861 [inline]
>  __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f73494babba
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffae0148e8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fffae0148f0 RCX: 00007f73494babba
> RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 00007fffae0148f0
> RBP: 0000000000000004 R08: 00007fffae014930 R09: 00007fffae014930
> R10: 0000000001000403 R11: 0000000000000202 R12: 00007fffae014930
> R13: 0000000000000003 R14: 0000000000080000 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> CR2: ffffffffffffffdb
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ext4_calculate_overhead+0xfd2/0x1380 fs/ext4/super.c:4182
> Code: 7b 50 48 89 fa 48 c1 ea 03 44 0f b6 60 14 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 72 03 00 00 44 89 e6 bf 3f 00 00 00 <48> 8b 6b 50 e8 95 20 43 ff 41 80 fc 3f 0f 87 cb 20 ef 07 e8 56 25
> RSP: 0018:ffffc9000399fa00 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffffffffffff8b RCX: 0000000000000000
> RDX: 1ffffffffffffffb RSI: 000000000000000a RDI: 000000000000003f
> RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000001 R12: 000000000000000a
> R13: ffff888020936000 R14: dffffc0000000000 R15: ffff8880242a4000
> FS:  0000555555f06380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffdb CR3: 0000000074f9b000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	7b 50                	jnp    0x52
>    2:	48 89 fa             	mov    %rdi,%rdx
>    5:	48 c1 ea 03          	shr    $0x3,%rdx
>    9:	44 0f b6 60 14       	movzbl 0x14(%rax),%r12d
>    e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   15:	fc ff df
>   18:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>   1c:	0f 85 72 03 00 00    	jne    0x394
>   22:	44 89 e6             	mov    %r12d,%esi
>   25:	bf 3f 00 00 00       	mov    $0x3f,%edi
> * 2a:	48 8b 6b 50          	mov    0x50(%rbx),%rbp <-- trapping instruction
>   2e:	e8 95 20 43 ff       	call   0xff4320c8
>   33:	41 80 fc 3f          	cmp    $0x3f,%r12b
>   37:	0f 87 cb 20 ef 07    	ja     0x7ef2108
>   3d:	e8                   	.byte 0xe8
>   3e:	56                   	push   %rsi
>   3f:	25                   	.byte 0x25
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> .
> 
