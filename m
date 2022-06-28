Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33E55F1B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 01:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiF1W73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 18:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiF1W71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:59:27 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE91EC56
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 15:59:26 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id h73-20020a6bb74c000000b0067275998ba8so7838303iof.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 15:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rzdTqI/xXB1Renj0b/qWiIJWiHq9oMlR5fhU+0ALxts=;
        b=M1zh0o9S3JLwkdk+HlihBfm/i/Rh50UQ6v2Ii5/6wmTTsGtZkShl3+l0g+gQcwnQyG
         EeV9QVHq93MNzhKqr5a7SZdMsi0cPMCN0e5gegOwFeedCitqk9eZYpEmAECfVcyCDPFZ
         swoddGIzCQOItKHClRxLTVs2Tdp567+/T7y7J6+2Yy+J6wj1fSUyJmNsv5TOkuIu7++Z
         j9o7/InGC2qRMUL74TmxNsz1Rjo0pqbrfOz11GdC61zbfKnIgmhlIurBcvX7KAGmQ++r
         iYW7QJMxuxBDOScsGSEJVgUz8ENBcs07AcZBrsaPdX1ZMqln9Ap7mknUQSy/s0AU9a67
         +IKA==
X-Gm-Message-State: AJIora/mHkdFWUA8cD6gOmAaIpdW1Yplo9svp/k/vrd1QDGTAcVizx0F
        EvUFn7RQERbj39t6dB+QhILrNzwfPDeMbe+/6w4jZOuK/2KC
X-Google-Smtp-Source: AGRyM1vU9YUt/wPxpu6ITCx4zJxRL00VP5btHOhzsm6VfD7PQXPmQAOgnNPJc0H3r191rJNHtKF6pO+6q5akz1BqZ+Sg4pnPMUBr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4813:b0:33c:8b87:3175 with SMTP id
 cp19-20020a056638481300b0033c8b873175mr285374jab.182.1656457166145; Tue, 28
 Jun 2022 15:59:26 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f94c4805e289fc47@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in truncate_inode_partial_folio
From:   syzbot <syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    941e3e791269 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1670ded4080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=9bd2b7adbd34b30b87e4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140f9ba8080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15495188080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff888021f7e005
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 zero_user_segments include/linux/highmem.h:272 [inline]
 folio_zero_range include/linux/highmem.h:428 [inline]
 truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
 truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
 truncate_inode_pages mm/truncate.c:452 [inline]
 truncate_pagecache+0x63/0x90 mm/truncate.c:753
 simple_setattr+0xed/0x110 fs/libfs.c:535
 secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
 notify_change+0xb8c/0x12b0 fs/attr.c:424
 do_truncate+0x13c/0x200 fs/open.c:65
 do_sys_ftruncate+0x536/0x730 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fb29d900899
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: ffff888021f7e005
---[ end trace 0000000000000000 ]---
RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c1 e9 03             	shr    $0x3,%ecx
   3:	40 0f b6 f6          	movzbl %sil,%esi
   7:	48 b8 01 01 01 01 01 	movabs $0x101010101010101,%rax
   e:	01 01 01
  11:	48 0f af c6          	imul   %rsi,%rax
  15:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  18:	89 d1                	mov    %edx,%ecx
  1a:	f3 aa                	rep stos %al,%es:(%rdi)
  1c:	4c 89 c8             	mov    %r9,%rax
  1f:	c3                   	retq
  20:	90                   	nop
  21:	49 89 f9             	mov    %rdi,%r9
  24:	40 88 f0             	mov    %sil,%al
  27:	48 89 d1             	mov    %rdx,%rcx
* 2a:	f3 aa                	rep stos %al,%es:(%rdi) <-- trapping instruction
  2c:	4c 89 c8             	mov    %r9,%rax
  2f:	c3                   	retq
  30:	90                   	nop
  31:	49 89 fa             	mov    %rdi,%r10
  34:	40 0f b6 ce          	movzbl %sil,%ecx
  38:	48                   	rex.W
  39:	b8 01 01 01 01       	mov    $0x1010101,%eax
  3e:	01 01                	add    %eax,(%rcx)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
