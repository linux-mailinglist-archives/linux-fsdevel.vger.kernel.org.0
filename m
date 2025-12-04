Return-Path: <linux-fsdevel+bounces-70615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E80CA205C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 01:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D6A130025BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 00:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8726ACC;
	Thu,  4 Dec 2025 00:07:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82631DA23
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806849; cv=none; b=Gb3VC/fS4nimHJuCQGA4p7+lNq4EgGF1iQ22UtFqzg7iyp8gkfBkrKTTP03pLog0D4gyqzo1xE16Y6Hu6XI6eI88wVXCoK1wfkf9oqOqtPvBGmzLFVR/HYaal/xmoOBZ+8XdJvIfSme/3nOr3kdFSCB+Auq99TM6b7X9kT27OBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806849; c=relaxed/simple;
	bh=Hhd6qhkMOFtRMXOzjXXtMjMCWZmum2+dHFo4ltC2eYY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZQv+YopSKu+b1eEPBbZPCCfxlGKBZ1vEyJRwTttDlpKknlY5hiY7YhpYdwK32Sibv4G9qgKWh354ODxo2u8E4UTxhsl1cYm5l70uKyFQOxtd94sOK96HPKwhErKGxJe5DWZvhxl3UVSgKzKTt68xwgsHslUrMaLcM2/0Adcfd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6597c6a8be9so289913eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 16:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764806847; x=1765411647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/KvjPqGywNLBRRIaOhbTeNXmoX6F9bkpWUvYQerGq0=;
        b=ZbAzwwDPsRxg2cSdX31JfoGN++eXZGt47U/fc+T5zmun3VTAkHaanpaIcfcZCDEM33
         K5pXzBJxyYEbtbEfgZuHX/gL5bxEOLkD+uZkVxyN/xqFYCRSudIq9PzuTt2ft4/jzkfM
         E4xrWcTU5X9o4T3Iwtc22pscQ2MgIVEywKQniFb+5WkwH//GJ/XcMeq2CCpLXtxcqCs8
         6RXpU6q83C1MW+bFfSDEnhywb6qFYIKbOuHtjXVBXYrvyOKFNBfiBRlsV12wKMdLwhIN
         2afZ0XyDQYt4GLOcXqJJ+rfNMFsGRFtGNVjAtLf8fkDgLezXd0n0rJFhGk0dgtYNtCLz
         otUg==
X-Forwarded-Encrypted: i=1; AJvYcCUa3F9SlqZKAI3pbsnDm3cz7WWFPskxKeNSIie+jx5LRbgvCsgFrY9Dfp4xalihMqVpTR6/ZFUBvY3v3ZqR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0AbN1PUBYxrQE8PVfwP2iCJALH/8Bns0kYJyYvO/pZOs+pXa
	XsuKHLTxBOsuCeNNi2xoricpIAnEnH6/xuTWN+NWHu6MsFAUIAVzTp+tUeYHtXfcd3ukeG9O4Ie
	rtseBxwVaUwhnAuDTk+LJtyBoa2/B7iGMIYETc4NkiBs2oD7XohrDUywVHr8=
X-Google-Smtp-Source: AGHT+IFv+LovpJmCMQ/zMe5E4XAOHRmdHZC1CJkJwhTp69v6ThfqdhShBTis4wqippMu1YhlMpjr4HJ4vTP8o/Gcn1Mcl20dLfoV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:211c:b0:451:4d80:5ab1 with SMTP id
 5614622812f47-45378fd5919mr767993b6e.33.1764806847030; Wed, 03 Dec 2025
 16:07:27 -0800 (PST)
Date: Wed, 03 Dec 2025 16:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6930d0bf.a70a0220.2ea503.00d4.GAE@google.com>
Subject: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
From: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1612b912580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172c8192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c3b0c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ec39deb2cf11/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=12c3b0c2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com

VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) encountered for inode ffff88805618b338
fs ocfs2 mode 100000 opflags 0x2 flags 0x20 state 0x0 count 2
------------[ cut here ]------------
kernel BUG at fs/namei.c:630!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6303 Comm: syz.0.92 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:lookup_inode_permission_may_exec fs/namei.c:630 [inline]
RIP: 0010:may_lookup fs/namei.c:1900 [inline]
RIP: 0010:link_path_walk+0x18cb/0x18d0 fs/namei.c:2537
Code: e8 5a 1f ea fe 90 0f 0b e8 b2 96 83 ff 44 89 fd e9 6a fd ff ff e8 a5 96 83 ff 48 89 ef 48 c7 c6 40 d8 79 8b e8 36 1f ea fe 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55
RSP: 0018:ffffc900046ef8a0 EFLAGS: 00010282
RAX: 000000000000008e RBX: ffffc900046efc58 RCX: f91f6529a96d0200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88805618b338 R08: ffffc900046ef567 R09: 1ffff920008ddeac
R10: dffffc0000000000 R11: fffff520008ddead R12: 0000000000008000
R13: ffffc900046efc20 R14: 0000000000008000 R15: ffff88802509b320
FS:  000055555cffa500(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc32730f000 CR3: 0000000072f4e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 path_openat+0x2b3/0x3dd0 fs/namei.c:4783
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_open fs/open.c:1444 [inline]
 __se_sys_open fs/open.c:1440 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1440
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4644d8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe02ccf2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f4644fe5fa0 RCX: 00007f4644d8f749
RDX: 0000000000000000 RSI: 0000000000145142 RDI: 0000200000000240
RBP: 00007f4644e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4644fe5fa0 R14: 00007f4644fe5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lookup_inode_permission_may_exec fs/namei.c:630 [inline]
RIP: 0010:may_lookup fs/namei.c:1900 [inline]
RIP: 0010:link_path_walk+0x18cb/0x18d0 fs/namei.c:2537
Code: e8 5a 1f ea fe 90 0f 0b e8 b2 96 83 ff 44 89 fd e9 6a fd ff ff e8 a5 96 83 ff 48 89 ef 48 c7 c6 40 d8 79 8b e8 36 1f ea fe 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55
RSP: 0018:ffffc900046ef8a0 EFLAGS: 00010282
RAX: 000000000000008e RBX: ffffc900046efc58 RCX: f91f6529a96d0200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88805618b338 R08: ffffc900046ef567 R09: 1ffff920008ddeac
R10: dffffc0000000000 R11: fffff520008ddead R12: 0000000000008000
R13: ffffc900046efc20 R14: 0000000000008000 R15: ffff88802509b320
FS:  000055555cffa500(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc32730f000 CR3: 0000000072f4e000 CR4: 00000000003526f0


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

