Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFCC221CD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 08:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgGPGtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 02:49:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46838 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgGPGtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:49:21 -0400
Received: by mail-io1-f69.google.com with SMTP id z65so2981050iof.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 23:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UBM1ZQ1vxsrt5dmWmOn+Igq2ZFK6NeciJNL2ibwCIE8=;
        b=baz50rjg2X/PuyH0HtfzTlPc7duiE77wp3qq9kwpjRz8PqU3VeBajFalO4q2scvSFY
         EJNgNTUY/lIjwUuhln33ZbqL3/hOZ3G2TA3gu9ybtBGoJ72wHeY/Hn/CpvK8XhqswkEE
         UCdbQ63KNGA7dIn0qA2NJL8Y8XRnrkbpSS/Pik9OLTlaAMcUM3GuBl2aqBwSN2IA1Xgf
         niV48hNPMWUJUdGczlfu1kXzH/8CKtv7KL2dvrP5+LvJxaFV0wC1FtcQVHmA5B2oDqr9
         4tlQTN/H1MpVUz89wosFYZs73k36TAoWMYpmpkFlZEV9OcTtcAveBAqFJJJOo9kLjRRi
         vYdQ==
X-Gm-Message-State: AOAM533eosFSVZ+AFKBEQMimJ/fTgyT+hEzQ10XSrUXaekKG5OBXXdY0
        9iQWp6aoo40gUF5VxXPk0my79pRrHBVNIXjeoW5jrFVDHT/3
X-Google-Smtp-Source: ABdhPJz6w8MmiNs2Rg3hqRlaVwKidNkc8SOw4i2Ri5cbjsCduwfVpLy8C/8boBtoDcHHmu97cv80sK6BGRHxc9sP91GzOLr3oDKX
MIME-Version: 1.0
X-Received: by 2002:a05:6602:229a:: with SMTP id d26mr3098830iod.57.1594882160875;
 Wed, 15 Jul 2020 23:49:20 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8634905aa897000@google.com>
Subject: KASAN: user-memory-access Read in filp_close (2)
From:   syzbot <syzbot+5ec02913b4e4d22f3045@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d31958b3 Add linux-next specific files for 20200710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11cbc800900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=5ec02913b4e4d22f3045
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ec02913b4e4d22f3045@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in instrument_atomic_read include/linux/instrumented.h:56 [inline]
BUG: KASAN: user-memory-access in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
BUG: KASAN: user-memory-access in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
BUG: KASAN: user-memory-access in filp_close+0x22/0x170 fs/open.c:1270
Read of size 8 at addr 00000000070007ef by task syz-executor.1/14036

CPU: 0 PID: 14036 Comm: syz-executor.1 Not tainted 5.8.0-rc4-next-20200710-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:56 [inline]
 atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
 filp_close+0x22/0x170 fs/open.c:1270
 __close_fd+0x2f/0x50 fs/file.c:671
 __do_sys_close fs/open.c:1295 [inline]
 __se_sys_close fs/open.c:1293 [inline]
 __x64_sys_close+0x69/0x100 fs/open.c:1293
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416721
Code: Bad RIP value.
RSP: 002b:00007fff8ed6e800 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000000416721
RDX: 0000000000000000 RSI: 000000000000023e RDI: 0000000000000007
RBP: 0000000000000001 R08: 000000003293423e R09: 0000000032934242
R10: 00007fff8ed6e8f0 R11: 0000000000000293 R12: 000000000078c900
R13: 000000000078c900 R14: ffffffffffffffff R15: 000000000078c04c
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
