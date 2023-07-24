Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E817375FBB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGXQSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjGXQSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:18:08 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC910CB
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:18:05 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6bb31e13a13so1215457a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690215485; x=1690820285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2E7xmX0eU0Mn68aP8lciI8pTH72hkvKmFi2359KdEhI=;
        b=YsRgqlMbxVbiSHeqZzZli8s6WGlyVHD2nW7CdOMsbg7LU8fWs7NcYFMzCQ6pXZ3LSy
         xfSQxsjsehHkck8yplfJOQ1sA+5vkD+RmyxQUvK8yPjCIo07TmWOBX5wPF0s9Qry61JV
         iZkRZvzJ2tj0ClnhUv9PmdTJ4MunyLSXeFJ1rQlOJrqJsYiUZngw95eog4O0Tsuf3dS/
         ySiNkhLstrYINl7g2K9TFr8nn68urZtQXdiM/Af8Q583XKgJi3wZ7Ert3zbzUqhnceXU
         pZftZvIjTyPlFE3TEDyhOTHivo9aFf7SywO62xhURyaq6ZTRLjQVwd4aAV9KffNyLbiW
         5hjQ==
X-Gm-Message-State: ABy/qLbpcDqjOFbdelzSTdfbzO8Ma4SqNjF8sYZOOxeImwd59seE7r2Z
        GGkFSIC1EMXHDPBjafgyl3mS3vMfh8tGMLaFUnhVxy7z8x/p
X-Google-Smtp-Source: APBJJlEOAlcJyPfi9I5YEj+pZ5mwDeDVBF5Ciuk0lLGH+F2DH1MTPhqdZmoTnwFnLBoeVhAcUNIUqD75L5zlUK3+H1oySAATXCMO
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1145:b0:6bb:2e2c:c6c7 with SMTP id
 x5-20020a056830114500b006bb2e2cc6c7mr3811289otq.4.1690215484868; Mon, 24 Jul
 2023 09:18:04 -0700 (PDT)
Date:   Mon, 24 Jul 2023 09:18:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091ce6f06013df598@google.com>
Subject: [syzbot] [net?] [reiserfs?] [fat?] stack segment fault in __stack_depot_save
From:   syzbot <syzbot+1f564413055af2023f17@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ddd9baa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=1f564413055af2023f17
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154f89d6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135c4f9aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/80468c74d86a/disk-d192f538.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36cbfe6495ed/vmlinux-d192f538.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c7dc916e910/bzImage-d192f538.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/16e268b0a8de/mount_1.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16737b76a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15737b76a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11737b76a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f564413055af2023f17@syzkaller.appspotmail.com

stack segment: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5023 Comm: syz-executor354 Not tainted 6.5.0-rc2-syzkaller-00307-gd192f5382581 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:find_stack lib/stackdepot.c:350 [inline]
RIP: 0010:__stack_depot_save+0x15e/0x510 lib/stackdepot.c:390
Code: 29 c0 89 c3 48 8b 05 49 07 f0 0d 89 d9 23 0d 39 07 f0 0d 48 8d 0c c8 48 8b 29 48 85 ed 75 0b eb 70 48 8b 6d 00 48 85 ed 74 67 <39> 5d 08 75 f2 44 3b 7d 0c 75 ec 31 c0 48 8b 74 c5 18 49 39 34 c6
RSP: 0018:ffffc90003d2f4b0 EFLAGS: 00010206

RAX: ffff88823b400000 RBX: 0000000051095974 RCX: ffff88823b8acba0
RDX: 000000000000000e RSI: 0000000000000001 RDI: 000000002f730f6d
RBP: 4c8b480000441f0f R08: 00000000a4fca10e R09: fffffbfff1d56faa
R10: ffffffff8eab7d57 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000cc0 R14: ffffc90003d2f518 R15: 000000000000000e
FS:  000055555739b480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8d752ba000 CR3: 00000000760e2000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kasan_save_stack+0x43/0x50 mm/kasan/common.c:46
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 kmem_cache_alloc_node+0x185/0x3f0 mm/slub.c:3515
 __alloc_skb+0x287/0x330 net/core/skbuff.c:634
 alloc_skb include/linux/skbuff.h:1289 [inline]
 nlmsg_new include/net/netlink.h:1003 [inline]
 netlink_ack+0x305/0x1370 net/netlink/af_netlink.c:2486
 netlink_rcv_skb+0x345/0x440 net/netlink/af_netlink.c:2555
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 __sys_sendto+0x255/0x340 net/socket.c:2134
 __do_sys_sendto net/socket.c:2146 [inline]
 __se_sys_sendto net/socket.c:2142 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8d7d324613
Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d b1 5a 08 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
RSP: 002b:00007ffd7dc7abf8 EFLAGS: 00000202
 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f8d7d3ac840 RCX: 00007f8d7d324613
RDX: 0000000000000028 RSI: 00007f8d7d3ac890 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007ffd7dc7ac14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f8d7d3ac890 R15: 0000000000000000
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	29 c0                	sub    %eax,%eax
   2:	89 c3                	mov    %eax,%ebx
   4:	48 8b 05 49 07 f0 0d 	mov    0xdf00749(%rip),%rax        # 0xdf00754
   b:	89 d9                	mov    %ebx,%ecx
   d:	23 0d 39 07 f0 0d    	and    0xdf00739(%rip),%ecx        # 0xdf0074c
  13:	48 8d 0c c8          	lea    (%rax,%rcx,8),%rcx
  17:	48 8b 29             	mov    (%rcx),%rbp
  1a:	48 85 ed             	test   %rbp,%rbp
  1d:	75 0b                	jne    0x2a
  1f:	eb 70                	jmp    0x91
  21:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  25:	48 85 ed             	test   %rbp,%rbp
  28:	74 67                	je     0x91
* 2a:	39 5d 08             	cmp    %ebx,0x8(%rbp) <-- trapping instruction
  2d:	75 f2                	jne    0x21
  2f:	44 3b 7d 0c          	cmp    0xc(%rbp),%r15d
  33:	75 ec                	jne    0x21
  35:	31 c0                	xor    %eax,%eax
  37:	48 8b 74 c5 18       	mov    0x18(%rbp,%rax,8),%rsi
  3c:	49 39 34 c6          	cmp    %rsi,(%r14,%rax,8)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
