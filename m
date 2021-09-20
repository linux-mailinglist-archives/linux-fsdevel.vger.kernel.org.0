Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50D41151C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhITNAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhITNAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:00:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22691C061574;
        Mon, 20 Sep 2021 05:58:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id dw14so11915671pjb.1;
        Mon, 20 Sep 2021 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=hDKAE6H9/GaVI7nfqRfPd7UEvAfLXZKdhI0Zqvun8oY=;
        b=ICHC5SaTqZV+PUi3f1ta5TH3ld/8S8iuf8+aUDAACZtHZuBg+2+xn/IHjQApmaPFGb
         i0kzIGRO30z+ufydmQJxHrnAjejyF8z/DcRslInjSLMSa61tzq+Wa7MTYe8vZSMorbJ+
         qLLTbW0lmqGEiH+K2r2lzsVm6iyGLykaDARnlfcC1hImjCvcT5A1LApKNI+yuPBlcxrB
         wp+NAkB7RSUYF2Jl3t19QR09Qvet8a2GuPGpKWyq0al9HyOuaTf+ylkGS02Maj50r7or
         g06hdk9f2v4RPPTu4dqZXY0u9F9uE5QUGPQKT89wb0MwWr+EnQYXBWk7AjUDawzVJ7Ui
         KKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hDKAE6H9/GaVI7nfqRfPd7UEvAfLXZKdhI0Zqvun8oY=;
        b=AZ5/1w6HxUiJzQYvkTyoUNhQpv5T5RZCBAfdra5txA/01HsYj/HLCqXguIuUfamEGD
         Bxbnfo+bPjIK+WNsuhkOQ3SFJMPZUFohdyfUhZ27pxwhH8qjCWyXSZw45F1EmbrUDXIQ
         rq074dI8k0NSmXwLJoaJh4S3APY2FTgpUWX5MFyM58GX+MNus9X5thKluMmRIowUMZE5
         5UxLm+X7YvdB351Z3fW+Edhj3a3BylbMyvp1Ir8sOu7Boz+hJqsznuKpqL1lumVuHcD7
         6G19mfww9qQ5lyoRyTLTM5Ch+1GIB1zVx4ohm9chBH/YlapAI+eRgngS6sXqX7m+K/wF
         e0gA==
X-Gm-Message-State: AOAM532rFaM7JYCPYZZWOSwOXr/ICEcJPKz1opaArOWUWTiUpIeLVzIB
        5eXOTGT17yMuqZq1wFPF+iLfDTQsDORDR5ORyih7PFlxFA==
X-Google-Smtp-Source: ABdhPJyvAJCi1WVvN/tohwqtKRIcygTnT34AgDguJMMl5adFGdIdUVlfKKUSdfJbp+vh0LhfCjzU9U/P5fI3r5N4Du8=
X-Received: by 2002:a17:902:f08c:b0:13d:8e59:caf5 with SMTP id
 p12-20020a170902f08c00b0013d8e59caf5mr16150094pla.38.1632142713291; Mon, 20
 Sep 2021 05:58:33 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 20 Sep 2021 20:58:40 +0800
Message-ID: <CACkBjsaYSfxKQUUhv2BdU8JTcHL1WP_c039iJ9CvmG5vMMHR4A@mail.gmail.com>
Subject: general protection fault in __block_write_begin_int
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
git tree: upstream
console output:
https://drive.google.com/file/d/1r4iaWNbcFSZEw3dpTM2tbE3sPZbaXQ_Y/view?usp=sharing
kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9CdBus-Tz0/view?usp=sharing
C reproducer: https://drive.google.com/file/d/13JjyIW6yKhM9QIYvC3IfDXAtjw_2Rrmt/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1sxTq_kx4Yw8nD06mQQ7Ah_cCEg75yalF/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

general protection fault, probably for non-canonical address
0xdead000000000200: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 11649 Comm: syz-executor Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__block_write_begin_int+0xde/0xae0 fs/buffer.c:1973
Code: 00 00 0f 87 65 06 00 00 e8 df bd d6 ff 45 85 e4 0f 85 5e 06 00
00 e8 d1 bd d6 ff 48 8b 45 18 31 d2 48 89 ef 41 bc 0c 00 00 00 <48> 8b
00 48 89 c6 48 89 44 24 20 e8 02 a4 ff ff 4c 8b 7d 20 48 8b
RSP: 0018:ffffc9000ab13980 EFLAGS: 00010246
RAX: dead000000000200 RBX: ffffea0004568000 RCX: ffffc900025b9000
RDX: 0000000000000000 RSI: ffffffff8160d34f RDI: ffffea0004568040
RBP: ffffea0004568040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000c
R13: ffffc9000ab13aa0 R14: ffffffff821f8f70 R15: 0000000000000000
FS:  00007f39bbe26700(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100000001 CR3: 000000010b767000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x58/0x150 fs/buffer.c:2116
 generic_perform_write+0xce/0x220 mm/filemap.c:3770
 __generic_file_write_iter+0x20d/0x240 mm/filemap.c:3897
 blkdev_write_iter+0xed/0x1d0 block/fops.c:518
 call_write_iter include/linux/fs.h:2163 [inline]
 do_iter_readv_writev+0x1e8/0x2b0 fs/read_write.c:729
 do_iter_write+0xaf/0x250 fs/read_write.c:855
 vfs_iter_write+0x38/0x60 fs/read_write.c:896
 iter_file_splice_write+0x2d8/0x450 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x4a/0x80 fs/splice.c:936
 splice_direct_to_actor+0x123/0x2d0 fs/splice.c:891
 do_splice_direct+0xc3/0x110 fs/splice.c:979
 do_sendfile+0x338/0x740 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1314 [inline]
 __se_sys_sendfile64 fs/read_write.c:1300 [inline]
 __x64_sys_sendfile64+0xc7/0xe0 fs/read_write.c:1300
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f39bbe25c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000006
RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000464e681a R11: 0000000000000246 R12: 000000000078c158
R13: 0000000000000000 R14: 000000000078c158 R15: 00007ffeddcbc7a0
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 39bb45a4a4cd76d5 ]---
RIP: 0010:__block_write_begin_int+0xde/0xae0 fs/buffer.c:1973
Code: 00 00 0f 87 65 06 00 00 e8 df bd d6 ff 45 85 e4 0f 85 5e 06 00
00 e8 d1 bd d6 ff 48 8b 45 18 31 d2 48 89 ef 41 bc 0c 00 00 00 <48> 8b
00 48 89 c6 48 89 44 24 20 e8 02 a4 ff ff 4c 8b 7d 20 48 8b
RSP: 0018:ffffc9000ab13980 EFLAGS: 00010246
RAX: dead000000000200 RBX: ffffea0004568000 RCX: ffffc900025b9000
RDX: 0000000000000000 RSI: ffffffff8160d34f RDI: ffffea0004568040
RBP: ffffea0004568040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000c
R13: ffffc9000ab13aa0 R14: ffffffff821f8f70 R15: 0000000000000000
FS:  00007f39bbe26700(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f81b40af020 CR3: 000000010b767000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0:   00 00                   add    %al,(%rax)
   2:   0f 87 65 06 00 00       ja     0x66d
   8:   e8 df bd d6 ff          callq  0xffd6bdec
   d:   45 85 e4                test   %r12d,%r12d
  10:   0f 85 5e 06 00 00       jne    0x674
  16:   e8 d1 bd d6 ff          callq  0xffd6bdec
  1b:   48 8b 45 18             mov    0x18(%rbp),%rax
  1f:   31 d2                   xor    %edx,%edx
  21:   48 89 ef                mov    %rbp,%rdi
  24:   41 bc 0c 00 00 00       mov    $0xc,%r12d
* 2a:   48 8b 00                mov    (%rax),%rax <-- trapping instruction
  2d:   48 89 c6                mov    %rax,%rsi
  30:   48 89 44 24 20          mov    %rax,0x20(%rsp)
  35:   e8 02 a4 ff ff          callq  0xffffa43c
  3a:   4c 8b 7d 20             mov    0x20(%rbp),%r15
  3e:   48                      rex.W
  3f:   8b                      .byte 0x8b
