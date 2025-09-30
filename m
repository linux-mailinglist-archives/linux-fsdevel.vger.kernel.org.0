Return-Path: <linux-fsdevel+bounces-63125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7BABAE823
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D2F3AD0AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 20:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CEB235045;
	Tue, 30 Sep 2025 20:17:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502534BA32
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263456; cv=none; b=ZpSc2Abl7MsSrKBn8sv6YjAkNjkTlN37GUFDds+hLNPgqS8OEMvCJk0rDDHc3PDK04L4N81wDTqMgwPPDHoe9ojI1hZQEDcWZa/UKWRD9RtILfYSKddgwxE/hO0l5UD8j5bkevfzaOWEMVGfqbdzrExn2G2ZGV7bQZd9DYXWuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263456; c=relaxed/simple;
	bh=cAIg9/uPNKwCmtU2FlBr8tfahlzGJedBW+czINNLHC8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F6re3cB/FmbqwZr7KXUmahUu30Fourvqp7C0nFHDx9fLPal0uMgGjsfO7nhjbKvK6srdKDA2mcpadHAADS/Fmfzyag1gX3vm9mNzW2NKv8IhN/WiqWh6CHodLgLxxNI3l0HDD9pIBAEJu5EvHDUs7sQF+oFzGbvFKU8SCPvinaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42d82499321so3970405ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 13:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263454; x=1759868254;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imYVyFLoW8Lx5IenAuDtwzh/rTjhBRKJiMfcM+p+yW8=;
        b=i1Ftca4ur3sm3goaVvzYvt2XlWaHg4x/Wisa4TEP6OOgkl4P/aEuHae1HcvtIvtGK1
         Gs0KPO4U2kqtiGMmWV41vnuG2hI12QVTxdAIYNkWle+ClXCHfZ6PbHelSv0Smt/INzPl
         4pZfvJIFEEeI+EOyhYFwmc/1LjSbvDd8QWxTF8ycrQtuTVwkl9rRVUr9mT6jPDbLTD2e
         IECFoQzWmrkWiWc7HH8TOSJZUMocL4/qaA5atY5o8kDkBdzRUnwhST0LLtS7ylE5yvwY
         /Ez6+niZEKK5nJIuL71HiMKabNaYCKf8ZpQ7bRB29W18n9fw8w1CNV0w40Dp8vnMMeIE
         mjOg==
X-Forwarded-Encrypted: i=1; AJvYcCUTgn5W9pXKJY8WZDLavxrjnBmaKVgF8bJts9FhoY+xh+ZGDTKxoB9WW2IXhNrrQtqeFgbTOnTwLXSWgm4A@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5xfaiznnws7rqMVvXOC6qi6ba4uruRT9aTLYjtrCXFdhOxm6
	y4qaexzzWvgvOk9TymsiLy5q5C9H6AnU97ZKFM+oImsXim/TjMH+fmpXs4CVM/2ZVHGqiKkUi67
	QMFB2E9cteswUCRsWMuvOwr5dJ+R0ai3/RnxwfxKWn52PF8FbFGsxAUnzCWQ=
X-Google-Smtp-Source: AGHT+IEvi3ZUUdgyMCecZ94IYWbSb9OgCzFJ4lzc7VTcsbHz93zWE4mlXeuyyGAd5BE10k9YRhgghfauZkiLPJjoX5Zi+AgOjOcb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:427:6510:650b with SMTP id
 e9e14a558f8ab-42d8161957amr17936155ab.22.1759263454279; Tue, 30 Sep 2025
 13:17:34 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:17:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc3ade.a70a0220.10c4b.015b.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] WARNING in path_noexec (2)
From: syzbot <syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    30d4efb2f5a5 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f085cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f17deb9fdc33e902
dashboard link: https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175496e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e5fd6f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3e36b0a1279/disk-30d4efb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c964999afe48/vmlinux-30d4efb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b49e62d3fb02/bzImage-30d4efb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9391462075ffb9f77c6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6000 at fs/exec.c:119 path_noexec+0x1af/0x200 fs/exec.c:118
Modules linked in:
CPU: 1 UID: 0 PID: 6000 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:path_noexec+0x1af/0x200 fs/exec.c:118
Code: 02 31 ff 48 89 de e8 c0 e2 89 ff d1 eb eb 07 e8 d7 dd 89 ff b3 01 89 d8 5b 41 5e 41 5f 5d e9 98 51 04 09 cc e8 c2 dd 89 ff 90 <0f> 0b 90 e9 48 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c a6
RSP: 0018:ffffc9000384fbd8 EFLAGS: 00010293
RAX: ffffffff823437ce RBX: ffff888077b40780 RCX: ffff88802eebbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000080000 R08: ffff88802eebbc00 R09: 0000000000000003
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000011
R13: 1ffff92000709f90 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055558a5c5500(0000) GS:ffff88812647e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b63fff CR3: 00000000213d4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_mmap+0xa43/0x10d0 mm/mmap.c:469
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:580
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea4258eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0d346898 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fea427e5fa0 RCX: 00007fea4258eec9
RDX: 0000000003000007 RSI: 0000000000003000 RDI: 0000200000000000
RBP: 00007fea42611f91 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fea427e5fa0 R14: 00007fea427e5fa0 R15: 0000000000000006
 </TASK>


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

