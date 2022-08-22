Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC959C93B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiHVTsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 15:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiHVTse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:48:34 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60F013F51
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 12:48:32 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso8993654ilj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 12:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=MalLwQaiGlhzIrxCHC2o/INfRJWqzd8HOJsi21AnIho=;
        b=cbdk9NUeB07RzfSpsfMSQMgk+PgAQRpif2kRBHYQW5ElWuZ4iUibQ/MA7ZUy73azq1
         EG/rdQaj/n0nMp+v91WMwuAYtuhNdMi1CSKkixtgEcaFrtodxV5ep24+guPZXd24H+8J
         21O7BiurxhTdoxMmR9TaNfeQzmOz//s4KB3ANcsBKIUThQQoGAoEM2BeP0AS2ctfe01u
         IGjXBmWWG5oJZ+KtWJz76FYoDbHmx2Lv7EUt2ta8yTqRZnknQmeaUfZyjrJ643sCQQRi
         bxNFhL3lzEF2e53Ndoi91NIScoWl2QtvC9qBQdUkJJBt3Nis/Mcrup65iZerYbCFr6u5
         KrHA==
X-Gm-Message-State: ACgBeo3GRfpqNhgsIifSyinjigMwVumwpTEfVidevREMoeKoqv36iLUD
        YTK/Peli8hsiNQikzNekYKqO4NTS3iOrPmQiA16fqc7QpCYn
X-Google-Smtp-Source: AA6agR7mUVz1zH8YW88I3sZKwQYF/yWh8IAsjogMXWzV6tuZHBKQB9KU/e59S2iZXuBBVtWDIjdraQTFd0o0JqK8a8NaYRIUjXSF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b83:b0:2e5:b254:69e5 with SMTP id
 h3-20020a056e021b8300b002e5b25469e5mr10654334ili.292.1661197712023; Mon, 22
 Aug 2022 12:48:32 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:48:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086ea5105e6d9bb44@google.com>
Subject: [syzbot] usb-testing boot error: general protection fault in alloc_bprm
From:   syzbot <syzbot+b3c801d39e8c3daed0fa@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    ad57410d231d usb: gadget: rndis: use %u instead of %d to p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17c13aa5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=b3c801d39e8c3daed0fa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3c801d39e8c3daed0fa@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffff000000000100: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000000800-0xfff8200000000807]
CPU: 1 PID: 375 Comm: kworker/u4:0 Not tainted 6.0.0-rc1-syzkaller-00005-gad57410d231d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x15e/0x3b0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 9d 01 00 00 48 85 c0 0f 84 94 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 a0 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900018afe28 EFLAGS: 00010246
RAX: ffff000000000000 RBX: ffff88810eae1100 RCX: 0000000000000100
RDX: 0000000000001411 RSI: 0000000000000dc0 RDI: 000000000003b380
RBP: ffff888100041c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000dc0
R13: 00000000000001a0 R14: 0000000000000dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 alloc_bprm+0x51/0x900 fs/exec.c:1514
 kernel_execve+0xab/0x500 fs/exec.c:1974
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:

---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:kmem_cache_alloc_trace+0x15e/0x3b0 mm/slub.c:3282
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 9d 01 00 00 48 85 c0 0f 84 94 01 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 a0 01 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0000:ffffc900018afe28 EFLAGS: 00010246

RAX: ffff000000000000 RBX: ffff88810eae1100 RCX: 0000000000000100
RDX: 0000000000001411 RSI: 0000000000000dc0 RDI: 000000000003b380
RBP: ffff888100041c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000dc0
R13: 00000000000001a0 R14: 0000000000000dc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 51 08             	mov    0x8(%rcx),%edx
   3:	48 8b 01             	mov    (%rcx),%rax
   6:	48 83 79 10 00       	cmpq   $0x0,0x10(%rcx)
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	0f 84 9d 01 00 00    	je     0x1b3
  16:	48 85 c0             	test   %rax,%rax
  19:	0f 84 94 01 00 00    	je     0x1b3
  1f:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  23:	8b 4d 28             	mov    0x28(%rbp),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 a0 01 00 00    	jne    0x1d4
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
