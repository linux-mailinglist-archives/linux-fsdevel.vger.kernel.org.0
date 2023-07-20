Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95F75B416
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGTQYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 12:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGTQYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:24:14 -0400
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F859E
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 09:24:13 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6b9e16f97b3so1642349a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 09:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870253; x=1690475053;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hZgxkQMXMHZ9+OC0sKC6qqkU3MCYpI7QdzqJaC1vJ3k=;
        b=RhlYhmIQHKxn162qRMSTclyzIt7SCgYCRD5OdbsuIy7pdvE5ma1RqI7Px23hLCtSvB
         wpaZyMOHdnmCOavQIIKempMviaP1qsV8+pdmowvX6ZyLME9aEz84yiW7/WaLLc8/AIVC
         150WQjJ8iGgtWeiegKrv8WO6HUfYcB8ndCh0EiytTVHdtrxEgvNPjKN1KJ1EtMYBM3Xc
         6S3/GlU23bkdX1CM/19KaLWkIbmJR1C+OAYrLr7vXntaa69DwJN+uBBmJgg4Nfdbfsj/
         psygTnXjJ0HESKUfy4o+7b8Z3I51oVkDypN1shvTeOc7rYTK2Kj+B735QsmfnzC3YXrV
         KRDw==
X-Gm-Message-State: ABy/qLawyfKPkhLd2gJX5PLWR9ncr1G1uqkwFgKrit65HsPECaybIFDa
        bnszwfK3hiupWI35DWXRzWtDcsAcHkdth70cQOfihEFIa3VC
X-Google-Smtp-Source: APBJJlECdsT0/IpdkhEpqH/vawiQlSELUVsBcb1GXH05c8EuNrJil8ny7L5P1rDA3svYF+vDEN037VvWLSrDmNpYNr6ZTtfjSHIN
MIME-Version: 1.0
X-Received: by 2002:a9d:7e85:0:b0:6b9:dc90:e351 with SMTP id
 m5-20020a9d7e85000000b006b9dc90e351mr3865369otp.6.1689870252989; Thu, 20 Jul
 2023 09:24:12 -0700 (PDT)
Date:   Thu, 20 Jul 2023 09:24:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002562100600ed9473@google.com>
Subject: [syzbot] [ntfs?] BUG: unable to handle kernel paging request in lookup_open
From:   syzbot <syzbot+84b5465f68c3eb82c161@syzkaller.appspotmail.com>
To:     anton@tuxera.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    831fe284d827 Merge tag 'spi-fix-v6.5-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=179dc062a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae56ea581f8fd3f3
dashboard link: https://syzkaller.appspot.com/bug?extid=84b5465f68c3eb82c161
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a52a24a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156f908aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/255bb08af694/disk-831fe284.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8739de7ceb20/vmlinux-831fe284.xz
kernel image: https://storage.googleapis.com/syzbot-assets/612168188f94/bzImage-831fe284.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ec45a7fef710/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84b5465f68c3eb82c161@syzkaller.appspotmail.com

ntfs: (device loop0): check_windows_hibernation_status(): Failed to find inode number for hiberfil.sys.
ntfs: (device loop0): load_system_files(): Failed to determine if Windows is hibernated.  Mounting read-only.  Run chkdsk.
BUG: unable to handle page fault for address: ffffffffff0000ab
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD c779067 P4D c779067 PUD c77b067 PMD c79b067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5011 Comm: syz-executor282 Not tainted 6.5.0-rc1-syzkaller-00259-g831fe284d827 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:lookup_open.isra.0+0x94b/0x1360 fs/namei.c:3484
Code: ff 48 85 ed 0f 85 37 05 00 00 e8 40 f4 9a ff 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 73 08 00 00 <48> 83 7b 68 00 0f 85 a3 f9 ff ff e8 15 f4 9a ff 8b 6c 24 20 31 ff
RSP: 0018:ffffc9000340f968 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffffff000043 RCX: 0000000000000000
RDX: 1fffffffffe00015 RSI: ffffffff81ea92c0 RDI: ffffffff8ac7e2e0
RBP: ffffffffff000043 R08: 0000000000000000 R09: fffffbfff1d5590a
R10: ffffffff8eaac857 R11: ffffffff8a30a1e8 R12: 00000000ffffffe2
R13: ffff888071f22540 R14: 0000000010000000 R15: ffffffffff0000ab
FS:  00005555558ec380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff0000ab CR3: 0000000020267000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3790
 do_filp_open+0x1de/0x430 fs/namei.c:3820
 do_sys_openat2+0x176/0x1e0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_creat fs/open.c:1498 [inline]
 __se_sys_creat fs/open.c:1492 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8ff6fb95b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd29797788 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f8ff6fb95b9
RDX: 00007f8ff6fb88b0 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007f8ff704b610 R08: 000000000001ee42 R09: 0000000000000000
R10: 00007ffd29797650 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd29797958 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: ffffffffff0000ab
---[ end trace 0000000000000000 ]---
RIP: 0010:lookup_open.isra.0+0x94b/0x1360 fs/namei.c:3484
Code: ff 48 85 ed 0f 85 37 05 00 00 e8 40 f4 9a ff 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 73 08 00 00 <48> 83 7b 68 00 0f 85 a3 f9 ff ff e8 15 f4 9a ff 8b 6c 24 20 31 ff
RSP: 0018:ffffc9000340f968 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffffffff000043 RCX: 0000000000000000
RDX: 1fffffffffe00015 RSI: ffffffff81ea92c0 RDI: ffffffff8ac7e2e0
RBP: ffffffffff000043 R08: 0000000000000000 R09: fffffbfff1d5590a
R10: ffffffff8eaac857 R11: ffffffff8a30a1e8 R12: 00000000ffffffe2
R13: ffff888071f22540 R14: 0000000010000000 R15: ffffffffff0000ab
FS:  00005555558ec380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff0000ab CR3: 0000000020267000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ff 48 85             	decl   -0x7b(%rax)
   3:	ed                   	in     (%dx),%eax
   4:	0f 85 37 05 00 00    	jne    0x541
   a:	e8 40 f4 9a ff       	call   0xff9af44f
   f:	4c 89 fa             	mov    %r15,%rdx
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  24:	0f 85 73 08 00 00    	jne    0x89d
* 2a:	48 83 7b 68 00       	cmpq   $0x0,0x68(%rbx) <-- trapping instruction
  2f:	0f 85 a3 f9 ff ff    	jne    0xfffff9d8
  35:	e8 15 f4 9a ff       	call   0xff9af44f
  3a:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
  3e:	31 ff                	xor    %edi,%edi


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
