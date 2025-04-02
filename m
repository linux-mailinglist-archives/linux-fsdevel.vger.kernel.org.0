Return-Path: <linux-fsdevel+bounces-45517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA9BA79044
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1401D1889C77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484F23BCE8;
	Wed,  2 Apr 2025 13:46:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF023AE7C
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601589; cv=none; b=jQ/ldQE4bKWsMHsHojZQ5Jr/UCIAgJsYT7TFdaZQE88IdC/2ZAQkhtV7rcSnuz48/7/da79EISxb2vqpJUxs0DuCMs6lTI7cogaff6BGdjs5Gag5jBYTGNhpcbOOBGrwLwyXGPp7WkuGBaoLsYYZcoF7FLJMM4wee/LFpbGDTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601589; c=relaxed/simple;
	bh=LkVDSPltO/4LKS8g7rkHP+IaIzHSM36i6RLISeeESSc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eVrERej95WTc6qX7N6qByzmPaKqTp2CXQMqZ67BzJI+WPdnRZw2ohv2TaDwjwS1Bu56KKwQfaCT0bJlSBbBulhoNvLDQIAeU/++EfsjZypaj7o/ZoFMO17b1D0SVsvTAtas9HQDoOWejcq2xLKDJtzFk7rg1d2rp/bldwgheYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so72611065ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 06:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743601587; x=1744206387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ktRWU455sF5wpDF7EHmHRc0yXQjU7v9FJ6vP0iuNis=;
        b=fKP5gpB1m7NFPNYycNP0+x4nNKwmuM5TdYvQP2SE6RlTxCXGygd+eVzk4+W5p5Ta1E
         L8mE20qqvAqMmxda7Poz1bPYdAxXtrJW+EQJR5PCwIwwMoMXtcaUS0vqLJY8UfEVYbSR
         uin8oHMv7FQZMJhp++2k8U/CjmI4FokIhQ6sd+j5xj+tgpbnDXqgEP9CBb6neIBb+fVn
         RBnNNvfqi+Ui63um1+EQpw7+wo87RvtNFSOf3hJivWA5pwF9Wtz0VBCjRMYMr8mFeJSR
         I0BDDDf9LlmQPM7pipiLw+DWGFKasGBchFyw+fUsXNP10OdkuUWgjEh/e9l+0CwZ3fua
         FyUA==
X-Forwarded-Encrypted: i=1; AJvYcCV5julJP5E6xWYJZ7yNroG9TVOZUGSF5VLSqwzmJ4xw+RbXx5lfT83RTjKJanWXFEESICXlau7qBkZB5PCX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4bRn/cRtZ0olZwxbVIvq0xnjbLKHOoPAhTHS4GssL/lvYdpxN
	hn1n7Tra999nUSIPW1z7jkILOK1kYxx4fIgjHVkbUSNI4h4ZRlU8Bv7TD1kkvgD7inVrP7ATFNN
	0VSAsnmO4gpmqen9A7nPUdH8feDiGt69IjyGK4o1f6uhdcbPVX0q+bsM=
X-Google-Smtp-Source: AGHT+IFGsE0AL/83BoJ5UblCfEht5ofdX0GbyWWuVbVWeyX65H6x8faNZkXFRcgGCcUUY+JN1STCtArBpf5LVJuOAdkwRKMxbXCb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3d4:3ab3:5574 with SMTP id
 e9e14a558f8ab-3d5e08ede54mr206189425ab.3.1743601587266; Wed, 02 Apr 2025
 06:46:27 -0700 (PDT)
Date: Wed, 02 Apr 2025 06:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ed3fb3.050a0220.14623d.0009.GAE@google.com>
Subject: [syzbot] [fs?] kernel BUG in may_open
From: syzbot <syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08733088b566 Merge tag 'rust-fixes-6.15-merge' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10c8a178580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acce2ca43d1e8c46
dashboard link: https://syzkaller.appspot.com/bug?extid=5d8e79d323a13aa0b248
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bb094c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c2b7b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ec0ad16833c/disk-08733088.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aaa58ee04595/vmlinux-08733088.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9799f5b55d91/bzImage-08733088.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com

VFS_BUG_ON_INODE(1) encountered for inode ffff888148c44000
------------[ cut here ]------------
kernel BUG at fs/namei.c:3432!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5828 Comm: syz-executor329 Not tainted 6.14.0-syzkaller-11270-g08733088b566 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:may_open+0x450/0x460 fs/namei.c:3432
Code: 38 c1 0f 8c 95 fe ff ff 48 89 df e8 aa 3c eb ff e9 88 fe ff ff e8 10 b3 84 ff 4c 89 ef 48 c7 c6 c0 f6 58 8c e8 81 21 05 00 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc90003ce78d8 EFLAGS: 00010246
RAX: 000000000000003a RBX: 00000000000fffff RCX: 8d133bf8e6cb7a00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffffff8ee96300 R08: ffffffff81a29bdc R09: 1ffff9200079ceb8
R10: dffffc0000000000 R11: fffff5200079ceb9 R12: 0000000000000006
R13: ffff888148c44000 R14: dffffc0000000000 R15: ffffc90003ce7ba0
FS:  0000555582428380(0000) GS:ffff888124fe2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056466efce608 CR3: 0000000033c36000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_open fs/namei.c:3843 [inline]
 path_openat+0x2b39/0x35d0 fs/namei.c:4004
 do_filp_open+0x284/0x4e0 fs/namei.c:4031
 do_sys_openat2+0x12b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x249/0x2a0 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d8acfc7e1
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 8a 88 07 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007fff2f6ce680 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5d8acfc7e1
RDX: 0000000000000002 RSI: 00007fff2f6ce700 RDI: 00000000ffffff9c
RBP: 00007fff2f6ce700 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
R13: 00007fff2f6ce938 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:may_open+0x450/0x460 fs/namei.c:3432
Code: 38 c1 0f 8c 95 fe ff ff 48 89 df e8 aa 3c eb ff e9 88 fe ff ff e8 10 b3 84 ff 4c 89 ef 48 c7 c6 c0 f6 58 8c e8 81 21 05 00 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc90003ce78d8 EFLAGS: 00010246
RAX: 000000000000003a RBX: 00000000000fffff RCX: 8d133bf8e6cb7a00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffffff8ee96300 R08: ffffffff81a29bdc R09: 1ffff9200079ceb8
R10: dffffc0000000000 R11: fffff5200079ceb9 R12: 0000000000000006
R13: ffff888148c44000 R14: dffffc0000000000 R15: ffffc90003ce7ba0
FS:  0000555582428380(0000) GS:ffff888124fe2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056466efce608 CR3: 0000000033c36000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

