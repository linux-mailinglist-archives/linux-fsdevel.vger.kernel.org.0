Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9373A76D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjFVRkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjFVRjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:39:53 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702701BF6
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 10:39:49 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77e3eaa1343so472014039f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 10:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687455588; x=1690047588;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMw5eT7Dqt5FIPh3vvSLGqZ/Chp2Isd/CXfCmTLAyNY=;
        b=ir1xfS9Kxk/9KfleF59QX11b4a7JuKdFgC/tEEVQBzbglZ3A4euIzuyNJBc8Bvam8A
         KP9BUKlOnfaTGyFTsQdmWeIpzJ2j+R7RhKu+bGfsbbEqn8lwxPwNkYA5L2oaKtTflOJT
         AolFqOXR++nLKsb2EFWcYLGNayYr6W0JMh6jeYrDWiSrPzQu90z8R7K+hbmAD1pLsxYd
         S22fkYWME5pjSfuHo7lZZFOr7G1YZ5wMpFKvo2E8AbxUU+5bc0oagsUNRMvXOtigAveI
         glfD+v2+HC1tjtSata8ggAdGs6fyGpIIPPm3BvM1eDitYlBnrlgxgDnv9QcEIDvGaC+5
         lOBA==
X-Gm-Message-State: AC+VfDxIH+XxTTNfxcT37z7ZPj6oz/W9fsoam8nakBo5xUpwXz1y/6oc
        xMX1xos5J05HW2P/YUwElI9FXMCF9h0DleQGlVIjE0eL4YjE
X-Google-Smtp-Source: ACHHUZ4uCoU11SiMUR/V6HBOqLN+B+mpGqiVD8qRA7mPGSBQAjIGbL+3K/olNtg/0UFccYA0iiKJgrLRJl206IiNiXg3pbyswm1g
MIME-Version: 1.0
X-Received: by 2002:a6b:d808:0:b0:777:afc6:8da0 with SMTP id
 y8-20020a6bd808000000b00777afc68da0mr6942611iob.1.1687455588688; Thu, 22 Jun
 2023 10:39:48 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:39:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f02c0005febb5e74@google.com>
Subject: [syzbot] [reiserfs?] [fat?] [acpi?] KASAN: slab-use-after-free Write
 in collect_expired_timers
From:   syzbot <syzbot+fb8d39ebb665f80c2ec1@syzkaller.appspotmail.com>
To:     linkinjeon@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dad9774deaf1 Merge tag 'timers-urgent-2023-06-21' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1682f600a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=fb8d39ebb665f80c2ec1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17effe1f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14972500a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd1a285f59ed/disk-dad9774d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3121ad3d6486/vmlinux-dad9774d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a57f0b6184a/bzImage-dad9774d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c4a7e9030518/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb8d39ebb665f80c2ec1@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffff5200002af99
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4993 Comm: syz-executor193 Not tainted 6.4.0-rc7-syzkaller-00072-gdad9774deaf1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:hlist_move_list include/linux/list.h:1029 [inline]
RIP: 0010:collect_expired_timers+0x13b/0x200 kernel/time/timer.c:1772
Code: 49 89 45 00 48 89 44 24 10 74 29 e8 bf 21 11 00 48 8b 44 24 10 48 b9 00 00 00 00 00 fc ff df 48 8d 78 08 48 89 fa 48 c1 ea 03 <80> 3c 0a 00 75 7a 4c 89 68 08 e8 96 21 11 00 4d 89 fd 49 c7 04 24
RSP: 0018:ffffc900001e0e20 EFLAGS: 00010016
RAX: ffffc90000157cc0 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 1ffff9200002af99 RSI: ffffffff81732551 RDI: ffffc90000157cc8
RBP: 00000000ffff9b50 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffff8880b993cf98 R12: ffff8880b99297e0
R13: ffffc900001e0eb8 R14: ffff8880b9929720 R15: ffffc900001e0ec0
FS:  00005555561173c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff5200002af99 CR3: 0000000079098000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
----------------
Code disassembly (best guess):
   0:	49 89 45 00          	mov    %rax,0x0(%r13)
   4:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   9:	74 29                	je     0x34
   b:	e8 bf 21 11 00       	callq  0x1121cf
  10:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  15:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  1c:	fc ff df
  1f:	48 8d 78 08          	lea    0x8(%rax),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 0a 00          	cmpb   $0x0,(%rdx,%rcx,1) <-- trapping instruction
  2e:	75 7a                	jne    0xaa
  30:	4c 89 68 08          	mov    %r13,0x8(%rax)
  34:	e8 96 21 11 00       	callq  0x1121cf
  39:	4d 89 fd             	mov    %r15,%r13
  3c:	49                   	rex.WB
  3d:	c7                   	.byte 0xc7
  3e:	04 24                	add    $0x24,%al


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
