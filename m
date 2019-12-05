Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70035113B68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 06:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfLEFpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 00:45:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44007 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLEFpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:45:08 -0500
Received: by mail-io1-f72.google.com with SMTP id b17so1646873ioh.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 21:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hbk8dpEVaqWWM6KdvtUeNGp8UKgFEwT9m36xDP3TGQA=;
        b=gzE+5NF0sTyZe4diW8xrx4usOlslBayEwwoAQ6++yv+kGcsGPQIDh8PYRPywy03ZOj
         +AEPX2dNeJpG3Dm460pGqBTB+62wznjWuPNRZT44xInnHbXNSi0w5PjlEWe8j4Xs6R2E
         /ra6wWeON590129enqYrQT07IsCpudnU8Zoh4TO/6nPkWgfr9tMeRcSeMxoXXTvbP9l3
         JzasVwT2yfSuS7IZalXa3UhCQreUrTaa3e2uAd/MR+i2PWYE7wgmsXmfuMfBESDvYWLi
         Udsbtepjswyao178kwqROZrFnDUm+/SFsLhrp711nIIopCTwDl/QCXRcjZBNqDb06yjj
         eMBw==
X-Gm-Message-State: APjAAAXkW85tF3q2/twuQt3NkZLqVVRwe53dB+MhB+4HB+KezTGXxS8J
        7aHALEWTQj913MMmw4Ef2uq0hFzN/InlgomouEk/Dj+CCy3M
X-Google-Smtp-Source: APXvYqxp6JgOevX+srs+s+AdEBdfEoYzH4Gg1/DnrUSa+a/pBQVGvsUt92hQfgW1QyQclDsAhqZtEwNWTOvJG2eWVBgLImOt6d9R
MIME-Version: 1.0
X-Received: by 2002:a6b:7846:: with SMTP id h6mr4866164iop.33.1575524707888;
 Wed, 04 Dec 2019 21:45:07 -0800 (PST)
Date:   Wed, 04 Dec 2019 21:45:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c72510598ee6ee7@google.com>
Subject: kmsan boot error: KMSAN: uninit-value in proc_task_name
From:   syzbot <syzbot+c0d17fd100b00692b701@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, glider@google.com,
        john.ogness@linutronix.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    818fcf71 Revert "kmsan: disable strscpy() optimization und..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11b8bb7ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fde150fb1e865232
dashboard link: https://syzkaller.appspot.com/bug?extid=c0d17fd100b00692b701
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c0d17fd100b00692b701@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in seq_commit include/linux/seq_file.h:89 [inline]
BUG: KMSAN: uninit-value in proc_task_name+0x574/0x590 fs/proc/array.c:121
CPU: 1 PID: 5202 Comm: ps Not tainted 5.4.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
  kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
  __msan_warning+0x57/0xa0 mm/kmsan/kmsan_instr.c:245
  seq_commit include/linux/seq_file.h:89 [inline]
  proc_task_name+0x574/0x590 fs/proc/array.c:121
  do_task_stat+0x1a7b/0x3090 fs/proc/array.c:540
  proc_tgid_stat+0xbe/0xf0 fs/proc/array.c:632
  proc_single_show+0x1a8/0x2b0 fs/proc/base.c:756
  seq_read+0xac6/0x1d90 fs/seq_file.c:229
  __vfs_read+0x1a9/0xc90 fs/read_write.c:425
  vfs_read+0x359/0x6f0 fs/read_write.c:461
  ksys_read+0x265/0x430 fs/read_write.c:587
  __do_sys_read fs/read_write.c:597 [inline]
  __se_sys_read+0x92/0xb0 fs/read_write.c:595
  __x64_sys_read+0x4a/0x70 fs/read_write.c:595
  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fd34fa40310
Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb  
ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 6e 8a 01 00 48 89 04 24
RSP: 002b:00007ffc157facf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fd34fa40310
RDX: 0000000000000fff RSI: 00007fd34ff0dd00 RDI: 0000000000000006
RBP: 0000000000000fff R08: 0000000000000000 R09: 00007fd34fd08a10
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd34ff0dd00
R13: 0000000001a59150 R14: 0000000000000005 R15: 0000000000000000

Local variable description: ----tcomm@proc_task_name
Variable was created at:
  proc_task_name+0x8d/0x590 fs/proc/array.c:103
  proc_task_name+0x8d/0x590 fs/proc/array.c:103
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
