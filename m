Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB4743DB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjF3Ome (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjF3Omd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:42:33 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA91FC2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 07:41:55 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-665bd7fe2f4so1440522b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 07:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136115; x=1690728115;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYsAQ8U6esTUCuxlgJSsi+am1Pv+ZjuDgx5c8wyZ8yQ=;
        b=FhI5Oiu6LQ25HQaDN5j7F9HO/mwbY+u/I+TBqDRIio4K6tYkteCl+bDRiaf+9roTpo
         wArsXJACi4TyhlPNinxyOckQMlmsUQbf+PwVCBJDES3Wc7GNjRUrOzSitXTmFLDZyUr1
         BceKNAz1zeHXzJQwZZUw2Gp3MZoxNcqyZSGKuGt+rDBUYdHgqUhAfzza1alg/kFSfqrC
         6W/kpl/qK0TgJ/dVtbzL31ebocbI11uvZj8Z+5aChXUCF3W8XuNDt+HdriCGu1zqDKNZ
         V1BEiVVHltcPnA84W97bxKOAVi3wkfUg1QphnxDqdfKoyAhkuwxTVR8XZnC6Yu7Wzi3G
         zSiQ==
X-Gm-Message-State: ABy/qLbqZx9TL7yHwiHO4JcL9N1qQDtVixPh49d4cnU33EXH5SquZVMx
        zZUxpvH2X2QiDI9af4GcpTR9lwAVJ2J9kyytTHGu1zNGjRRO
X-Google-Smtp-Source: APBJJlESbafdgXVY0BTJ0KDu0tiD3gFFheTysNcDUL1JhmVFL0ve80aCvnp1vLH9L3L9a+FE2m7ka9XVim0bOfKzV82f8bQduOAx
MIME-Version: 1.0
X-Received: by 2002:a62:7b0e:0:b0:668:7377:1fe3 with SMTP id
 w14-20020a627b0e000000b0066873771fe3mr2817998pfc.2.1688136114967; Fri, 30 Jun
 2023 07:41:54 -0700 (PDT)
Date:   Fri, 30 Jun 2023 07:41:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007720b405ff59d161@google.com>
Subject: [syzbot] [ext4?] general protection fault in ext4_quota_read
From:   syzbot <syzbot+b960a0fea3fa8df1cd22@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6995e2de6891 Linux 6.4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175bc8bf280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4df35260418daa6
dashboard link: https://syzkaller.appspot.com/bug?extid=b960a0fea3fa8df1cd22
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e661af280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f2e8d4aac75/disk-6995e2de.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/db793abf1e91/vmlinux-6995e2de.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60215f5bf9ff/bzImage-6995e2de.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/428a4f7e064c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b960a0fea3fa8df1cd22@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 0 PID: 6808 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:i_size_read include/linux/fs.h:883 [inline]
RIP: 0010:ext4_quota_read+0xd5/0x330 fs/ext4/super.c:7107
Code: ff 41 80 fc 3f 0f 87 00 11 cd 07 e8 05 93 49 ff 48 8b 44 24 08 48 8d 78 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 0d 02 00 00 48 8b 44 24 08 4c 89 ef 45 31 ff 48
RSP: 0018:ffffc9000c17f420 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000000a RSI: ffffffff823ab65b RDI: 0000000000000050
RBP: 0000000000000001 R08: 0000000000000001 R09: 000000000000003f
R10: 000000000000000c R11: 0000000000094001 R12: 000000000000000c
R13: 0000000000000400 R14: ffff888021014800 R15: ffff888028e6fc00
FS:  00007f94b3a7f700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5437a8000 CR3: 000000002826f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 do_insert_tree+0x117/0x12d0 fs/quota/quota_tree.c:347
 dq_insert_tree fs/quota/quota_tree.c:401 [inline]
 qtree_write_dquot+0x3b4/0x570 fs/quota/quota_tree.c:420
 v2_write_dquot+0x120/0x250 fs/quota/quota_v2.c:358
 dquot_acquire+0x3d1/0x6c0 fs/quota/dquot.c:444
 ext4_acquire_dquot+0x2b1/0x3d0 fs/ext4/super.c:6814
 dqget+0x67d/0x1080 fs/quota/dquot.c:914
 __dquot_initialize+0x560/0xbe0 fs/quota/dquot.c:1492
 dquot_initialize fs/quota/dquot.c:1550 [inline]
 dquot_file_open fs/quota/dquot.c:2181 [inline]
 dquot_file_open+0x90/0xb0 fs/quota/dquot.c:2175
 ext4_file_open fs/ext4/file.c:904 [inline]
 ext4_file_open+0x35d/0xbf0 fs/ext4/file.c:873
 do_dentry_open+0x6cc/0x13f0 fs/open.c:920
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f94b2c8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f94b3a7f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f94b2dabf80 RCX: 00007f94b2c8c389
RDX: 000000000000275a RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 00007f94b2cd7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff112e5fcf R14: 00007f94b3a7f300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:i_size_read include/linux/fs.h:883 [inline]
RIP: 0010:ext4_quota_read+0xd5/0x330 fs/ext4/super.c:7107
Code: ff 41 80 fc 3f 0f 87 00 11 cd 07 e8 05 93 49 ff 48 8b 44 24 08 48 8d 78 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 0d 02 00 00 48 8b 44 24 08 4c 89 ef 45 31 ff 48
RSP: 0018:ffffc9000c17f420 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000000a RSI: ffffffff823ab65b RDI: 0000000000000050
RBP: 0000000000000001 R08: 0000000000000001 R09: 000000000000003f
R10: 000000000000000c R11: 0000000000094001 R12: 000000000000000c
R13: 0000000000000400 R14: ffff888021014800 R15: ffff888028e6fc00
FS:  00007f94b3a7f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f5d63e000 CR3: 000000002826f000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	41 80 fc 3f          	cmp    $0x3f,%r12b
   4:	0f 87 00 11 cd 07    	ja     0x7cd110a
   a:	e8 05 93 49 ff       	callq  0xff499314
   f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  14:	48 8d 78 50          	lea    0x50(%rax),%rdi
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 0d 02 00 00    	jne    0x240
  33:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  38:	4c 89 ef             	mov    %r13,%rdi
  3b:	45 31 ff             	xor    %r15d,%r15d
  3e:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
