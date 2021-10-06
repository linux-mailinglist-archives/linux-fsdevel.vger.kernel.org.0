Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631AE423A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhJFJfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhJFJfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:35:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D6CC061749;
        Wed,  6 Oct 2021 02:33:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 133so1996228pgb.1;
        Wed, 06 Oct 2021 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ib9q1FXf/davE4MXyLdOzyGSWmIcAUtLGH0oh1ik9BY=;
        b=TYeai1wIIZiQKY75VQD0vGYcDb448tXeGpDod/3imAgBeBYn+ipnPEaq6K0LnaptUE
         jENWsqPAcFE7315KkZGrb3G1zlj3E9kwK1udsYRydpCRMMntFr/soSH7QD3j1/gilY8k
         EG7pc/il1kPLFQ0S/jjdA52yZ82F/MDsJCHcxd5kbAqgFpiUEOiS9IU2X0RqNWmM9SX9
         /qvpCxMnDrkNhowSzV5wK1IfXFVX4OD2fNf+za0QaeR2j6ubFwRQDHiu+uR1LeDP7883
         MLImHAQRTu9CdjPwc9x5p9tF2omfpVP0rRg+SpPfA8vKWQbeNkiGiXGNtJ492KlkERbo
         nMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ib9q1FXf/davE4MXyLdOzyGSWmIcAUtLGH0oh1ik9BY=;
        b=gyi4VZn5FZ45lQT1Rl7CTnIDQLayRcLtSof62T9WHZ8uzLTEGZY+HvHpsRzYpL+LGV
         4EFOOXSV/cTjxxNDBn5aHHjVk0Jx7VJjKmj0uCDbLhNuAiIlk0Pfn6D00aP8nMT4KPmn
         AbP2Nx0BqAZfdTBQWJloo3sRTjnh/knvkwztkh0XDdGiAzUVS5/x5BXlDddyL4/XmmsS
         jxPOxgvGMgud0beLbSoYwiG0CewbGE7n0MjUoSrZD7uelTKmRhxdSmtPNkKNlbX7IgIr
         DlStpqyIyLgBzlUejlsbZpBJiQy1jWKg71XAYp6zwiT3sbh/9Ait802pTpz3ptpNfWTa
         lSQA==
X-Gm-Message-State: AOAM530mHu6nOmHd6411FFi7LM5MXZcPsH5pspgCqtFIiRmLTPgtCB9S
        4kqQBOzoBEMBNGloalp2OiNzCyKwHb8WF+/s6VvDFj8cwg/B3i4=
X-Google-Smtp-Source: ABdhPJz0d/K3zZrOwYOgIohIMdLEfLuWyNC76/iYyFN9gnmhOgno7r66wc4gtZxJw1bMfkoIJw46kDwTksB2rAs2NE0=
X-Received: by 2002:a63:594a:: with SMTP id j10mr19730031pgm.205.1633512838615;
 Wed, 06 Oct 2021 02:33:58 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 17:33:47 +0800
Message-ID: <CACkBjsbPsmUiC7NFgOZcVcwPA7RLpiCFkgEA=LsnvcFsWFG34Q@mail.gmail.com>
Subject: WARNING in __kernel_read
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
git tree: upstream
console output:
https://drive.google.com/file/d/1RomE2Ls4uFB-AfgRtQr6739q4npqS-_Y/view?usp=sharing
kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1RzAsyIZzw5X_m340nY9fu4KWjGdG98pv/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1QqdmE15ktTdJIQK9s6u-btC5YuajI9XH/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 1 PID: 28082 at fs/read_write.c:429
__kernel_read+0x3bb/0x410 fs/read_write.c:429
Modules linked in:
CPU: 1 PID: 28082 Comm: syz-executor Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__kernel_read+0x3bb/0x410 fs/read_write.c:429
Code: 8b 04 25 40 70 01 00 8b 88 60 05 00 00 4c 8d 80 c8 07 00 00 e8
88 c7 c6 02 48 c7 c5 ea ff ff ff e9 6a fe ff ff e8 65 cf dd ff <0f> 0b
48 c7 c5 ea ff ff ff e9 57 fe ff ff e8 52 cf dd ff b9 01 00
RSP: 0018:ffffc900025e7cf8 EFLAGS: 00010216
RAX: 00000000000081cb RBX: ffff888109c16c00 RCX: ffffc90002c55000
RDX: 0000000000040000 RSI: ffffffff8159c1fb RDI: ffff888109c16c00
RBP: 000000004808801c R08: 0000000000000000 R09: 0000000000000000
R10: ffffc900025e7d40 R11: 0000000000000000 R12: ffffc9000f315000
R13: ffffc900025e7df8 R14: 0000000000206590 R15: ffffc9000f315000
FS:  00007f55dbd06700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000003 CR3: 000000001a3ac000 CR4: 0000000000752ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000003
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 kernel_read+0x47/0x60 fs/read_write.c:461
 kernel_read_file+0x20a/0x370 fs/kernel_read_file.c:93
 kernel_read_file_from_fd+0x55/0x90 fs/kernel_read_file.c:184
 __do_sys_finit_module+0x89/0x110 kernel/module.c:4180
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f55dbd05c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000003 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c0a0
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffeee82e7a0
