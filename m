Return-Path: <linux-fsdevel+bounces-33582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C969BA754
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F741C20D88
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC11531C8;
	Sun,  3 Nov 2024 18:07:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39A7083B
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Nov 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730657250; cv=none; b=fE4L+Xnvh5piCPxYZ11y3u9JyvIAj5IH4E3fRRVOirPNr2iGprOVWuf55iFkGjaoN4GJO1RP17BtEUsvSZ32KcFYuTWLGGR/L5KzeGBzX0wug1CzAeYWhl5w3jFpfNkoF95sJBGXjoimb3YZ5sagFkUcxjrzEYLWEuvAO5rZPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730657250; c=relaxed/simple;
	bh=BQrRmYptwfbHJgFxgQKS8slwy1ZZYNutY56I40YfetU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BRQJqQC2FKlsufYPZACAiDHYVnrC5x1XBZBaabjGfJwIyF14u+4hNNXQ/tTAw4YfoR/xvhN3bW3RY0YgXrKEIktN1v6mI9n+hoH1MIQqMtioYfgI51SaT082KLh7SMbO8OFNPaDYpAXa8F1QkL6WqMDcLb5LfmmpTr/qh2iNHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6ca616500so6941665ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2024 10:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730657248; x=1731262048;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yImpYZEnH+vWFV3oS/mAA3Zjq+/w7LOuUQNMesugDxA=;
        b=UZmbut+p0j72uInm72oj2It9/WGVKNvNvuY3Bqfz1IWH5JnUvDX000QtiC8iiSdNnO
         QHgtoZMy8P3I/fvGacRKxG/wjECoa09+SsDgeu/PSeo8MsywLSImvvROOcAQrdLSWBRF
         qvrJ7p9i+joH2I5oGaUEfTGxjhbYBCG9Srzppe98Yl2pGkvgq7IA6qMfq1VkyxABGTlM
         o48BxaNhE8fwTBgVAvffb+yk8e0nxsTAE/LNcRFXXaUNgmTmZGFz29pVDV2QrS+oOZ3k
         hoWNx+EpjOROOhji4EO4/2ihAUM6A2ZCLte9k3ScTZY5HQxIL64rJtMkfIwu7KFXqj3g
         wdGA==
X-Gm-Message-State: AOJu0YxC8QFtlBeTIRrOeUkPttyMdwCHgYXVpSLBKl38n5QWS9p0Lpuq
	1BTUurTOYxFWOrPcizv70sAUvmLJd0Bh4Zl3w/waai9SRXnPLNYspGYIVBQJxTfUYVIQWXhP0vy
	oMqQ3RE6k+OKpA4IHQDIvm1Y9APzvy2K3HLdN1GyuXSIqBiJHKqBonkg=
X-Google-Smtp-Source: AGHT+IGbLx7LMVXnnMhYZAHCJaHZvpkbgxxyTUMHZC2jPSfOzB2PpsMR/QcG4GgTBlv1Q0aIC1xpwVI0pCMDILM0QxX8mZwDKNRh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220a:b0:3a6:c89d:4eb5 with SMTP id
 e9e14a558f8ab-3a6c89d50e2mr23314235ab.15.1730657247826; Sun, 03 Nov 2024
 10:07:27 -0800 (PST)
Date: Sun, 03 Nov 2024 10:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
Subject: [syzbot] [fuse?] general protection fault in fuse_do_readpage
From: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1e939a21eb1 Merge tag 'cgroup-for-6.12-rc5-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173f255f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12401540580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e64630580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c1e939a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f1b9c52b9e0/vmlinux-c1e939a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f31f28c172e/bzImage-c1e939a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 3 UID: 0 PID: 5947 Comm: syz-executor314 Not tainted 6.12.0-rc5-syzkaller-00044-gc1e939a21eb1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:fuse_read_args_fill fs/fuse/file.c:631 [inline]
RIP: 0010:fuse_do_readpage+0x276/0x640 fs/fuse/file.c:880
Code: e8 9f c7 91 fe 8b 44 24 10 89 44 24 78 41 89 c4 e8 8f c7 91 fe 48 8d 7b 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1d 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90006a0f820 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82fbb4c9
RDX: 000000000000000c RSI: ffffffff82fbb4f1 RDI: 0000000000000060
RBP: 0000000000000000 R08: 0000000000000007 R09: 7fffffffffffffff
R10: 0000000000000fff R11: ffffffff961d4b88 R12: 0000000000001000
R13: ffff8880382b8000 R14: ffff888025153780 R15: ffffc90006a0f8b8
FS:  00007f7583f3d6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000240 CR3: 0000000030d30000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_read_folio+0xb0/0x100 fs/fuse/file.c:905
 filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2367
 do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3825
 read_mapping_folio include/linux/pagemap.h:1011 [inline]
 erofs_bread+0x34d/0x7e0 fs/erofs/data.c:41
 erofs_read_superblock fs/erofs/super.c:281 [inline]
 erofs_fc_fill_super+0x2b9/0x2500 fs/erofs/super.c:625
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xda/0x190 fs/super.c:1299
 erofs_fc_get_tree+0x1fe/0x2e0 fs/erofs/super.c:723
 vfs_get_tree+0x8f/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount fs/namespace.c:4034 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7583f813b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7583f3d218 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f758400d3e8 RCX: 00007f7583f813b9
RDX: 00000000200000c0 RSI: 0000000020000000 RDI: 0000000020000240
RBP: 00007f758400d3e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 00007f7583fda034
R13: 0030656c69662f2e R14: 00007f7583fda050 R15: 00007f7583fd800e
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fuse_read_args_fill fs/fuse/file.c:631 [inline]
RIP: 0010:fuse_do_readpage+0x276/0x640 fs/fuse/file.c:880
Code: e8 9f c7 91 fe 8b 44 24 10 89 44 24 78 41 89 c4 e8 8f c7 91 fe 48 8d 7b 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1d 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90006a0f820 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82fbb4c9
RDX: 000000000000000c RSI: ffffffff82fbb4f1 RDI: 0000000000000060
RBP: 0000000000000000 R08: 0000000000000007 R09: 7fffffffffffffff
R10: 0000000000000fff R11: ffffffff961d4b88 R12: 0000000000001000
R13: ffff8880382b8000 R14: ffff888025153780 R15: ffffc90006a0f8b8
FS:  00007f7583f3d6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000240 CR3: 0000000030d30000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 9f c7 91 fe       	call   0xfe91c7a4
   5:	8b 44 24 10          	mov    0x10(%rsp),%eax
   9:	89 44 24 78          	mov    %eax,0x78(%rsp)
   d:	41 89 c4             	mov    %eax,%r12d
  10:	e8 8f c7 91 fe       	call   0xfe91c7a4
  15:	48 8d 7b 60          	lea    0x60(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 1d 03 00 00    	jne    0x351
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

