Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3620375BD84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 06:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGUExG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 00:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUExF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:53:05 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB287E53
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 21:53:03 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-565f0c7c243so2948642eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 21:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689915183; x=1690519983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Js2Upn+zwZw4WcaAO+zbiZwV46tZ4B6/iX71dX2fu/w=;
        b=bwqNgXid0v0aXI1qQaDkkEgLMG/J87Xnm2pE2nZ32AXJB21/r2gLxMCcxvuTLcVgsu
         BY/mrEPHkeSr9B3u3swVaw0VJ+CGUO4gRjZ/tf/FbRIinKMjOV9e3M6G5vBXYfRmkFqX
         SNtabb/iUYjfx48qGncS/7vfpjZolvaOMbzCwHMELIH8g5VzoG8w60f5A1GaU8/KtUwa
         RszcMCO/6pQYvmfDvz58UgxaAQ5A73Qq52e4vmZ4KcAkvvEQSSq1MFoV8U7JpUj7DEiz
         nkkkkBhheBalcaK0vMs+rT2wvs+oEFLAEtPTgphY/EzKJ6fKCIW8gUsz72jMvIKsmzUU
         MhUA==
X-Gm-Message-State: ABy/qLYNCK4MVlRecReq4+GItFFW8twx98lyQYqxT3J6z2OoUUMWPlhp
        Vyx9g9lPAFsIAbUqlvz/vlmhXhYEV/RDj1xq8cOb3Oy7BqFM
X-Google-Smtp-Source: APBJJlFZEYt289OLUkqWSSa9bn5aO/ez072STodLuKHByuMqpIR4mHNBEcNSOGvrU+SvOMqWDdnZxWkn9wE4DliL4NBIE9+LlCsV
MIME-Version: 1.0
X-Received: by 2002:a4a:52d6:0:b0:569:a08a:d9c2 with SMTP id
 d205-20020a4a52d6000000b00569a08ad9c2mr1830319oob.1.1689915183170; Thu, 20
 Jul 2023 21:53:03 -0700 (PDT)
Date:   Thu, 20 Jul 2023 21:53:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000318ac80600f80ada@google.com>
Subject: [syzbot] [fs?] general protection fault in iommu_deinit_device
From:   syzbot <syzbot+a8bd07230391c0c577c2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2205be537aeb Add linux-next specific files for 20230717
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=110613faa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=173c0f005722ecc3
dashboard link: https://syzkaller.appspot.com/bug?extid=a8bd07230391c0c577c2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e4f18ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1480be3ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30f27c4289e7/disk-2205be53.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67e0e47344f7/vmlinux-2205be53.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e542d8c69716/bzImage-2205be53.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8bd07230391c0c577c2@syzkaller.appspotmail.com

iommufd_mock iommufd_mock0: Adding to iommu group 0
iommufd_mock iommufd_mock0: Removing from iommu group 0
general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 PID: 5031 Comm: syz-executor409 Not tainted 6.5.0-rc1-next-20230717-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:sysfs_remove_link_from_group+0x2b/0x80 fs/sysfs/group.c:413
Code: 0f 1e fa 41 54 49 89 d4 55 48 89 f5 53 48 89 fb e8 ba 13 73 ff 48 8d 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 39 48 8b 7b 30 31 d2 48 89 ee e8 81 f2 fe ff 48 85
RSP: 0018:ffffc90003adfc18 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8213b9d6 RDI: 0000000000000030
RBP: ffffffff8adb0760 R08: 0000000000000001 R09: ffffed10280ca11b
R10: ffff8881406508df R11: ffffffff8a345578 R12: ffff888022507500
R13: ffffffff8d519e20 R14: ffff888015ab8450 R15: ffff888015ab8448
FS:  00005555570f1380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000226b9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommu_deinit_device+0x111/0x580 drivers/iommu/iommu.c:401
 __iommu_group_remove_device+0x296/0x390 drivers/iommu/iommu.c:573
 iommu_group_remove_device+0x7e/0xa0 drivers/iommu/iommu.c:1170
 mock_dev_destroy drivers/iommu/iommufd/selftest.c:396 [inline]
 iommufd_test_mock_domain drivers/iommu/iommufd/selftest.c:452 [inline]
 iommufd_test+0x1b92/0x2c70 drivers/iommu/iommufd/selftest.c:950
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f732a69e2e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe820edd58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe820edf28 RCX: 00007f732a69e2e9
RDX: 0000000020000100 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 00007f732a711610 R08: 0000000000000000 R09: 00007ffe820edf28
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe820edf18 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sysfs_remove_link_from_group+0x2b/0x80 fs/sysfs/group.c:413
Code: 0f 1e fa 41 54 49 89 d4 55 48 89 f5 53 48 89 fb e8 ba 13 73 ff 48 8d 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 39 48 8b 7b 30 31 d2 48 89 ee e8 81 f2 fe ff 48 85
RSP: 0018:ffffc90003adfc18 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8213b9d6 RDI: 0000000000000030
RBP: ffffffff8adb0760 R08: 0000000000000001 R09: ffffed10280ca11b
R10: ffff8881406508df R11: ffffffff8a345578 R12: ffff888022507500
R13: ffffffff8d519e20 R14: ffff888015ab8450 R15: ffff888015ab8448
FS:  00005555570f1380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d13f5f7530 CR3: 00000000226b9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 1e fa             	nop    %edx
   3:	41 54                	push   %r12
   5:	49 89 d4             	mov    %rdx,%r12
   8:	55                   	push   %rbp
   9:	48 89 f5             	mov    %rsi,%rbp
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	e8 ba 13 73 ff       	call   0xff7313cf
  15:	48 8d 7b 30          	lea    0x30(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 39                	jne    0x69
  30:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
  34:	31 d2                	xor    %edx,%edx
  36:	48 89 ee             	mov    %rbp,%rsi
  39:	e8 81 f2 fe ff       	call   0xfffef2bf
  3e:	48                   	rex.W
  3f:	85                   	.byte 0x85


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
