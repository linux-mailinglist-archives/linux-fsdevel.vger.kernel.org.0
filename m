Return-Path: <linux-fsdevel+bounces-74405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA394D3A190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4679A3074693
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E349C33CEA3;
	Mon, 19 Jan 2026 08:22:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4832F74D
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810947; cv=none; b=rhyOahRd9I1Q86kUylX2W2dbF037g0aPwEizqCGY/DioGgRKKlcx0SLxG4dUVJ4OdRpsM2vQuOtfEqZwvMWiVFKkp3pFClFOX1DRxTNqmLf3SvpTXYRiEPEJNaUiA0fPZnVx1+3xxP66FBO0Nr/aitbofVCdNIlpNNZ3Fr1o220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810947; c=relaxed/simple;
	bh=cDB9uZ2SYfUFsV68Gf1FYZDiNkcCykxl4PlpZjrZGDI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n0HmROOKVxsG9MPS1aQom0g/ZKVsXAlmSpI4OHPyeC35Ey3uzmSbrr7NJ6saUzmCB7BP7biTJzUcfmJFJNfAtcQgGMYvqq8gHlkHkZZQNOHof/riTdzAFySO94wm47B6YhHGoyWTUdiBdbES39kRakiDPl5Hl1hRnMPukyay3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cfd9c02747so10435392a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 00:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810945; x=1769415745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAJI0hYlY/s3CHL17rQ+cSnoF1kmTxJ58X5ejSkr/sQ=;
        b=k7u6dKCS2UD2ayG/i8FHZIZ9cTHAIPXhtlwevDGPNBl9Qx4kIi1mnoaT47zgPz2u4H
         xQJAPGxx2Ff1ckNMkHRVy0hR9VA3gUerrgmRSJsqhfqpIzjw7VfzlPuh8l9TX89wAeHx
         bmRDZviDm96nuyR0hu4q8/5VItk2kD3uNEVIwzFwQtKdk90qkflOLoPFexnAAK+fFvYC
         Dswt4A2hRT/XcOONEiybd9yO1QzaQZ3t0eJ5erIdqptPv2CauOYKggbVgi5d4fkQ5mUB
         CC+wMUaqErDtSCD5USCWt4wV1u2t6uRULITnqMbYu6kjUPai1P5NTGgFYmWORvQMSXXo
         YSYg==
X-Forwarded-Encrypted: i=1; AJvYcCXONJgnGot4Ij9Sd/j1+eWI2i7t5AYbRr+zlw5ubZOsBzQpOcPxfrQd4xbCb1uY4xpE184OmesEfpit0mo1@vger.kernel.org
X-Gm-Message-State: AOJu0YwumtgwhPaMXDslutzK6zpQXePv2TrNp4futDVIzKRi0Dp7MUsB
	YJojKOdmfloiDNgHEyQ9DGJ3t2jvu9Du0+QuB1qB4eoxEBWeB86Qt/cqxIgIrAogCDwHevijK3b
	LqFEOOWncU3DmFYyoNfRRJ0jYxq+ccrtBlNeubJmchsyYzVanaDAPlOm3MFo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81d1:b0:65f:6d6c:530e with SMTP id
 006d021491bc7-661189c3857mr4741763eaf.72.1768810945155; Mon, 19 Jan 2026
 00:22:25 -0800 (PST)
Date: Mon, 19 Jan 2026 00:22:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696de9c1.050a0220.3390f1.0040.GAE@google.com>
Subject: [syzbot] [hfs?] WARNING: ODEBUG bug in hfsplus_fill_super (4)
From: syzbot <syzbot+4d36862d0682266c49bf@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0f853ca2a798 Add linux-next specific files for 20260113
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f4f99a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d6e5303d96e21b5
dashboard link: https://syzkaller.appspot.com/bug?extid=4d36862d0682266c49bf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/480cd223f3f6/disk-0f853ca2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ca2f0dbb7cc/vmlinux-0f853ca2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60a0fef5805b/bzImage-0f853ca2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d36862d0682266c49bf@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff88803b48ea38 object type: timer_list hint: delayed_sync_fs+0x0/0xf0 fs/hfsplus/super.c:-1
WARNING: lib/debugobjects.c:615 at debug_print_object lib/debugobjects.c:612 [inline], CPU#1: syz.5.8803/4349
WARNING: lib/debugobjects.c:615 at __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline], CPU#1: syz.5.8803/4349
WARNING: lib/debugobjects.c:615 at debug_check_no_obj_freed+0x405/0x550 lib/debugobjects.c:1129, CPU#1: syz.5.8803/4349
Modules linked in:
CPU: 1 UID: 0 PID: 4349 Comm: syz.5.8803 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:debug_print_object lib/debugobjects.c:612 [inline]
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
RIP: 0010:debug_check_no_obj_freed+0x44a/0x550 lib/debugobjects.c:1129
Code: 89 44 24 20 e8 47 c1 8d fd 48 8b 44 24 20 4c 8b 4d 00 4c 89 ef 48 c7 c6 a0 a3 e0 8b 48 c7 c2 c0 a8 e0 8b 8b 0c 24 4d 89 f8 50 <67> 48 0f b9 3a 48 83 c4 08 4c 8b 6c 24 18 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc9000af5f6b0 EFLAGS: 00010246
RAX: ffffffff829ebf60 RBX: ffffffff99d50010 RCX: 0000000000000000
RDX: ffffffff8be0a8c0 RSI: ffffffff8be0a3a0 RDI: ffffffff8fad4670
RBP: ffffffff8b8d30a0 R08: ffff88803b48ea38 R09: ffffffff8b8d4200
R10: dffffc0000000000 R11: ffffffff81ae2f10 R12: ffff88803b48ec00
R13: ffffffff8fad4670 R14: ffff88803b48e000 R15: ffff88803b48ea38
FS:  00007f64cf5f06c0(0000) GS:ffff888125cf7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f518962949d CR3: 0000000051490000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 slab_free_hook mm/slub.c:2487 [inline]
 slab_free mm/slub.c:6690 [inline]
 kfree+0x13b/0x660 mm/slub.c:6898
 hfsplus_fill_super+0xecc/0x1930 fs/hfsplus/super.c:653
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1204 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x31a/0xcf0 fs/namespace.c:3839
 do_mount fs/namespace.c:4162 [inline]
 __do_sys_mount fs/namespace.c:4351 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4328
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f64ce790eea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f64cf5efe68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f64cf5efef0 RCX: 00007f64ce790eea
RDX: 0000200000000100 RSI: 0000200000002900 RDI: 00007f64cf5efeb0
RBP: 0000200000000100 R08: 00007f64cf5efef0 R09: 0000000002000010
R10: 0000000002000010 R11: 0000000000000246 R12: 0000200000002900
R13: 00007f64cf5efeb0 R14: 00000000000006d8 R15: 00002000000022c0
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 44 24 20          	mov    %eax,0x20(%rsp)
   4:	e8 47 c1 8d fd       	call   0xfd8dc150
   9:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   e:	4c 8b 4d 00          	mov    0x0(%rbp),%r9
  12:	4c 89 ef             	mov    %r13,%rdi
  15:	48 c7 c6 a0 a3 e0 8b 	mov    $0xffffffff8be0a3a0,%rsi
  1c:	48 c7 c2 c0 a8 e0 8b 	mov    $0xffffffff8be0a8c0,%rdx
  23:	8b 0c 24             	mov    (%rsp),%ecx
  26:	4d 89 f8             	mov    %r15,%r8
  29:	50                   	push   %rax
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
  38:	48                   	rex.W
  39:	b9 00 00 00 00       	mov    $0x0,%ecx
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

