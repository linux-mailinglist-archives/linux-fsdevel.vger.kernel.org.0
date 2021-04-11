Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959435B137
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Apr 2021 05:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhDKDBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Apr 2021 23:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhDKDBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Apr 2021 23:01:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BF4C06138B;
        Sat, 10 Apr 2021 20:01:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l76so6741920pga.6;
        Sat, 10 Apr 2021 20:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=faFPiLasv8qZMNcFV0rB/lcB63zFqy0xI+cbv40omnc=;
        b=oMR/94x2SajBeyrA/xEuvhNB0tAiMrY1EgZII5loZTgzx5UAALmVz974EAyemq9/We
         4SjvRWH4Vt1P6bRf5eB9Ws3cxOtkoKWR/YkvrkcQ08/gXyMu8pGbs5k+r7BXl05lT4YY
         83tWLxLz3o8WLT84Nz8RnOYnxz7Dyix8APqzIwi0gRbxfa7GEB3i60SB9N5FiIn1BoA3
         7sxZUpKn/MYxAwpPo6V86C5R9cbgnLKElnBN0E8ECg2fudRzUkyQNjoewatzcbUl50qZ
         Ot+DR40U1zYOVVRzDM3Q2DD7ZvFMVjlXLm2NZxsKwH3tpEP+he+MTJbUDrSbqa7Tmaex
         uf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=faFPiLasv8qZMNcFV0rB/lcB63zFqy0xI+cbv40omnc=;
        b=RZim4/sb7vcPjrMIAcGifi3UX/8F3E/X3PZUkdXfsXIg/PCLaOpXQe19OmYeZrCylm
         lAbe3v1cWGzgwBKBCbM5KtTrgZOHuoeCM1ze6J80zppZ7GYSjHv3rwvO2+CZrIMwwovh
         9pugxwmIWSlpNhWsWTNEdJEpCdMbcRilB3eE1Jiey6zTvv2XH0j7tMAucBIlNgyDS5/M
         tiKU4gE3Te5g7U3YnBPVLBdz6s8JF18M5l/wy7z8NLXeGwF1xEy5jYGe4O8WgaZjq/QH
         qkHtIrSeX6iThkOMB9vIp4ORvEiLyQ3YyjAnA2/Ewrb8IaxLgjCgPchdmG2ZC0piBEoU
         nJuQ==
X-Gm-Message-State: AOAM533OU4Ut50nCZZaU3LQG3EjcLBRnQR4k34m8sL6Bsd0FDW/7eoeS
        888GU6sTGYanF7qt8VkXBVxnooQPFDuZ12UtU9789MvssVao
X-Google-Smtp-Source: ABdhPJyuhnAcLtp+DSXkrPwI4pnLrANG2afKmh1PXNoGBzZwegGH6NPrnaIHMkIKVTxOrolEXwa1EIMPr6w5xMoW96k=
X-Received: by 2002:a63:3606:: with SMTP id d6mr20648502pga.349.1618110079827;
 Sat, 10 Apr 2021 20:01:19 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Sun, 11 Apr 2021 11:01:16 +0800
Message-ID: <CACkBjsYCGt_UQN-EpdHJtcixZZSKFDRdMjZwfvF=wByv7N=zuA@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in do_epoll_wait
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

When using Healer(https://github.com/SunHao-0/healer/tree/dev) to fuzz
the Linux kernel, I found a null-ptr-deref bug in do_epoll_wait, but
I'm not sure about this.
Sorry, I do not have a reproducing program for this bug.
I hope that the stack trace information in the crash log can help you
locate the problem.

Here is the details:
commit:   3b9cdafb5358eb9f3790de2f728f765fef100731
version:   linux 5.11
git tree:    upstream
report:
BUG: kernel NULL pointer dereference, address: 0000000000000048
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 23043 Comm: systemd-udevd Not tainted 5.11.0+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:vfs_poll include/linux/poll.h:88 [inline]
RIP: 0010:ep_item_poll fs/eventpoll.c:840 [inline]
RIP: 0010:ep_send_events fs/eventpoll.c:1677 [inline]
RIP: 0010:ep_poll fs/eventpoll.c:1792 [inline]
RIP: 0010:do_epoll_wait+0x68d/0xf00 fs/eventpoll.c:2220
Code: 50 89 84 24 d0 00 00 00 48 8d 7b 28 e8 bc 0f d8 ff 48 8b 6b 28
48 c7 c0 e0 6e c6 85 48 39 c5 74 3c 48 8d 7d 48 e8 a3 0f d8 ff <4c> 8b
75 48 4d 85 f6 0f 84 3f 02 00 00 e8 f1 59 c7 ff 48 89 df 48
RSP: 0018:ffffc9000769fdc8 EFLAGS: 00010246
RAX: ffff88800d87edb8 RBX: ffff888009b0e600 RCX: 00000000000003db
RDX: 0000000000000048 RSI: 0000000000000000 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000004f
R10: 0001ffffffffffff R11: ffff88800d87e300 R12: ffff888041f93d18
R13: ffff888041f93d68 R14: 0000000000000004 R15: ffff888041f93d20
FS:  00007f4f3e1fa8c0(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000048 CR3: 000000000e3c5000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 __do_sys_epoll_wait fs/eventpoll.c:2232 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2227 [inline]
 __x64_sys_epoll_wait+0xf6/0x120 fs/eventpoll.c:2227
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4f3d07b2e3
Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00
66 90 83 3d 29 54 2b 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 34 c3 48 83 ec 08 e8 0b c2 00 00 48 89 04 24
RSP: 002b:00007fff2e5db728 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fff2e5db7f0 RCX: 00007f4f3d07b2e3
RDX: 0000000000000004 RSI: 00007fff2e5db7f0 RDI: 0000000000000004
RBP: 00007fff2e5db8a0 R08: 00005578feaa7410 R09: 00005578fea9b855
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff2e5db7f0
R13: 00007fff2e5db7fc R14: 0000000000000003 R15: 000000000000000e
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000048
---[ end trace 201f1cc113e7b051 ]---
RIP: 0010:vfs_poll include/linux/poll.h:88 [inline]
RIP: 0010:ep_item_poll fs/eventpoll.c:840 [inline]
RIP: 0010:ep_send_events fs/eventpoll.c:1677 [inline]
RIP: 0010:ep_poll fs/eventpoll.c:1792 [inline]
RIP: 0010:do_epoll_wait+0x68d/0xf00 fs/eventpoll.c:2220
Code: 50 89 84 24 d0 00 00 00 48 8d 7b 28 e8 bc 0f d8 ff 48 8b 6b 28
48 c7 c0 e0 6e c6 85 48 39 c5 74 3c 48 8d 7d 48 e8 a3 0f d8 ff <4c> 8b
75 48 4d 85 f6 0f 84 3f 02 00 00 e8 f1 59 c7 ff 48 89 df 48
RSP: 0018:ffffc9000769fdc8 EFLAGS: 00010246
RAX: ffff88800d87edb8 RBX: ffff888009b0e600 RCX: 00000000000003db
RDX: 0000000000000048 RSI: 0000000000000000 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000004f
R10: 0001ffffffffffff R11: ffff88800d87e300 R12: ffff888041f93d18
R13: ffff888041f93d68 R14: 0000000000000004 R15: ffff888041f93d20
FS:  00007f4f3e1fa8c0(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000048 CR3: 000000000e3c5000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
