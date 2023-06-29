Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF1742B82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 19:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF2Rrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjF2Rrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:47:51 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7901FC3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 10:47:48 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1b34e23df61so371907fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 10:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688060867; x=1690652867;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqeJGSO+6mKx9mSGLaZAKOae/381NKNuveT6K24vxfg=;
        b=NWkGUHN4b8IKKQT6hAZqC53HgD0iD8OFk8IVEgn7l5sTvOVtW5h86REc7eRxCNxq6f
         VQOjoUl0an6eZCb7ehxJQjxVbgqsdl7auzDlUP8H0o+13rxnqBfTWMS30MMuVUoTwbsx
         9nHwk9n4pFAnz2M3yvpLADwQr9hTsUYaBaWb+bmPakUJJ8xGboK8YmQ2g8uv36mIkAwz
         ri569/jFbewyH0mXRxVfTwlZgULtz2/4zvF0hPvEsUH5jEDvY/8lwoEsi1oIQMtYP3Md
         XMoAGBuU/+7UGKwSqE2FmGOcG5oi7cMkTwR3LkkDXZ6AZXxd0kYLp4PThqy4pNm+3NgH
         Vlzg==
X-Gm-Message-State: AC+VfDxFPFf/KhXuOmvEw93bpGLk78JarMJrQHeHvK7+Pmu+ochmnYPE
        rMj01IMZUbTGyGqOrN/cp3Rt13NXP47z6rplVYs5Tqc7TQj/
X-Google-Smtp-Source: APBJJlH61aLO6HzohyCF4GOPTTpma/uLhk+bk4SmPwgDhoT8lQgiSxVIcpdBvVJ+qlI3IE+Y9rRRuPd6Qk3KhIpghv3yts8NFmVA
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6b96:b0:1b0:9643:6f69 with SMTP id
 ms22-20020a0568706b9600b001b096436f69mr520078oab.4.1688060867287; Thu, 29 Jun
 2023 10:47:47 -0700 (PDT)
Date:   Thu, 29 Jun 2023 10:47:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a9fab05ff484cc4@google.com>
Subject: [syzbot] [lsm?] [reiserfs?] general protection fault in fsnotify_perm
From:   syzbot <syzbot+1d7062c505b34792ef90@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, jmorris@namei.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        reiserfs-devel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cd10e0a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=1d7062c505b34792ef90
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1066cc77280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116850bf280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0158c6c02c9/disk-a92b7d26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91b4daaa4521/vmlinux-a92b7d26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5e6c2198af0/bzImage-a92b7d26.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d48571c9b971/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d7062c505b34792ef90@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 4987 Comm: udevd Not tainted 6.4.0-rc7-syzkaller-00226-ga92b7d26c743 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:fsnotify_parent include/linux/fsnotify.h:62 [inline]
RIP: 0010:fsnotify_file include/linux/fsnotify.h:99 [inline]
RIP: 0010:fsnotify_perm.part.0+0x12e/0x610 include/linux/fsnotify.h:124
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 75 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 68 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 5c 04 00 00 4c 8b 73 28 be 08 00 00 00 4d 8d a6
RSP: 0018:ffffc9000347fa00 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000005 RSI: ffffffff83cbf5e3 RDI: 0000000000000028
RBP: ffff888067875bc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88802d0722d0 R14: ffff88802d07233c R15: 0000000000010000
FS:  00007f538cf63c80(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b7c4d8718 CR3: 000000002eb3f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fsnotify_perm include/linux/fsnotify.h:108 [inline]
 security_file_open+0x86/0xb0 security/security.c:2801
 do_dentry_open+0x575/0x13f0 fs/open.c:907
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
RIP: 0033:0x7f538cb169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff8a905c40 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f538cb169a4
RDX: 0000000000080241 RSI: 00007fff8a906188 RDI: 00000000ffffff9c
RBP: 00007fff8a906188 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
R13: 000056095d45972e R14: 0000000000000001 R15: 000056095e6332c0
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 75 04 00 00    	jne    0x486
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	48 8b 5d 68          	mov    0x68(%rbp),%rbx
  1f:	48 8d 7b 28          	lea    0x28(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 5c 04 00 00    	jne    0x490
  34:	4c 8b 73 28          	mov    0x28(%rbx),%r14
  38:	be 08 00 00 00       	mov    $0x8,%esi
  3d:	4d                   	rex.WRB
  3e:	8d                   	.byte 0x8d
  3f:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)


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
