Return-Path: <linux-fsdevel+bounces-66875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B526C2F01E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 03:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781DC189A5F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 02:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73322459CF;
	Tue,  4 Nov 2025 02:43:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E752248BE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224184; cv=none; b=WBOmO4bjzh65exptj5H8N81IiGHw+HdSCZscnEWzgZ8m0Zuuyi/JZ5HP7m5EBzRod81TfE8r8VQ+ON0PAzrjtCZTO/W1iVqdfG9MlEFZLgo1+Tptt4IPBIhHPdM5F62Km93wzHs+/4WtLUWBLyU1gbW9KhbcdvbPTbbNaJHkzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224184; c=relaxed/simple;
	bh=/PwqJgpx6d83krd2BR/Q94EK2b4ZhuINslZXJfgaVy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YKeHoR2PuBwNrxB2luzZckisBcXxIFYE48lo41w4alwqX5pVSP6GcUzCQi3Gu75OO80yY/kCfqSZVKSb5zcxNGkgFk40C8FYQ6ERfyV/whIAinXtyvSVdBIf5DmHTjiQoxzdUY+PkmAsoT9XAbkvUiqNf/LtJ4SDTGNhkYe6THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8870219dce3so518108739f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 18:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762224182; x=1762828982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBIw0SYrhKhi35dC1UwvoNNnW3Il9lAar0bIukFldbU=;
        b=TIj3KW63e9JnZ7pZeHZtmwJbA0NpUed8Xfp8W4jTxlbX4fY2afpW3OfWADj0KmjGns
         aP4cJUpIJB24tt+yE2vQw2HSp6m43/O4V4MEdQEOnxvasuZWduTv5wPJe5P7+hZhFe6w
         lnQVH3my+2ErDsI5k4avc1olNjeUFaiKhRtkxO4JH6qMJ3bQtqkYio0eyVW3V3ETLa4c
         E1f5zTWMdbiG+DjjrVMAIdie7TL7hkG4lg0f1xKKWURVN43GN1/mPr4VPKJu1azmh5j6
         QyySRqLcRSt4if/IkYlJ2QoIPZePKCdRQKOE2j3Lpf5YdCQy0rtHUi1RW4zCUl/3mG3e
         76Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXqK3Zl0FxVf2VzSkmWkKVlgCsNfmqlgtoY99dHz7JJLNKcaaWnsR0i5JM58xFiuHOjQWcJQsrDXII+ZgCE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0EdBOp9gg9WuJBuYnSquWDcVLm+HqIzzz0Fi9/a6BbXVSQU/c
	7He0t2+8i2Q4DMTVXfDrQRn1fHvl0Ad/+v6IxfgUX1EhL5oOq3HMU+htNLqlgaTO1wwC0G6k0CX
	GAeEs5w1uSCt1NPheHoc0+IElxcvZ9RlJoqVai3fZxudPwb7AbU0OyFYURf4=
X-Google-Smtp-Source: AGHT+IE4zHEzVucOPYL+xz6/nTZPc+2B+jS+5ktcuCcpH5NHB6J00PeRw7cjAnyYOnMky1QPFtvntV155LaF0SvX5p90Y5mObxH1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3416:b0:948:27b1:3d0f with SMTP id
 ca18e2360f4ac-94827b13dd6mr1845011939f.15.1762224182127; Mon, 03 Nov 2025
 18:43:02 -0800 (PST)
Date: Mon, 03 Nov 2025 18:43:02 -0800
In-Reply-To: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69096836.a70a0220.88fb8.0006.GAE@google.com>
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
From: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, jaegeuk@kernel.org, 
	joannelkoong@gmail.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in get_data

loop0: detected capacity change from 0 to 16
------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: syz.0.585/7652
Modules linked in:
CPU: 1 UID: 0 PID: 7652 Comm: syz.0.585 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 a7 19 1f 00 90 <0f> 0b 90 eb 05 e8 9c 19 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0018:ffffc900035170e0 EFLAGS: 00010293
RAX: ffffffff81a1eee9 RBX: 00003fffffffffff RCX: ffff888033255b80
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: 0000000000000e55 R09: 000000325e213cc7
R10: 000000325e213cc7 R11: 00001de4c2000037 R12: 0000000000000012
R13: 0000000000000000 R14: ffffc90003517228 R15: 1ffffffff1bca646
FS:  00007f44eb8da6c0(0000) GS:ffff888125fda000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f44ea9722e0 CR3: 0000000066344000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
 prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
 _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
 prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
 printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3062 [inline]
 console_flush_one_record kernel/printk/printk.c:3194 [inline]
 console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
 __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 _erofs_printk+0x349/0x410 fs/erofs/super.c:33
 erofs_fc_fill_super+0x1591/0x1b20 fs/erofs/super.c:746
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x92/0x2b0 fs/super.c:1752
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3641 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3717
 do_mount fs/namespace.c:4040 [inline]
 __do_sys_mount fs/namespace.c:4228 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4205
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44ea99076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f44eb8d9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f44eb8d9ef0 RCX: 00007f44ea99076a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f44eb8d9eb0
RBP: 0000200000000180 R08: 00007f44eb8d9ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f44eb8d9eb0 R14: 00000000000001a1 R15: 0000200000000080
 </TASK>


Tested on:

commit:         98231209 Add linux-next specific files for 20251103
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1370a292580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43cc0e31558cb527
dashboard link: https://syzkaller.appspot.com/bug?extid=3686758660f980b402dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

