Return-Path: <linux-fsdevel+bounces-67253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E2C38B69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 02:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A422B3B5B02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 01:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D737221FBD;
	Thu,  6 Nov 2025 01:35:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF241465B4
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392930; cv=none; b=hII9imRD9ZmB+uzT+skuBECPQY0ijrZ1Y3DC74h1T3N1ek7CheIatUJEx4YPdwYmJZeEesvbLnKyC2QW62a7W+pHy9hUBKxoA8qmcMzI8xtf5SsMVNmH/u4M+g33U0nwDz/c/auUGCAO3it7pJWjFPeA4ZDbi92qAQzLOdtNg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392930; c=relaxed/simple;
	bh=PdRE7aLzg4GTd27ocexaQacYM6XvijSaCEDL3O+bVdE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GEaVNcSylU1zug+x0Rl0rk6nwAtuqmOQmNJJnKmulTdX5S6lKFff3ChX49/mo8fFLt8/d3MKyX17A3+Y/NGe6pNsVGYRAZue0BO9uoMGoANwPvWW0w1cTr7tJvuyCNrT/Z+1xDE3AXgS9nxSlqpCyc6LtdFoDPf9bZymCXtzLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43322c01a48so5290515ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 17:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762392928; x=1762997728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKul6iG7keXbS/hf9CoezWgQ+oYZfKw7E5oU/uszxVQ=;
        b=Esenl5PoEiBk0RBfii+hLJuWqfATeEUNInHfan7NBowyjdWlCJ/HSz/sM3kIjwNqfA
         6Iafd5JUgAj4JNQpSmaUQ49IcPOXrpvYQGkQpHDPzNhRZSXrHml/iPP2mHIQHZp3hWGJ
         ff98b6EbJhg5tW05bItRkL0EXSiYsVEgrQ1y+m0l45ggN64Re5hR4PkS+OWXlBwb5Zx4
         2ylUgde57Sp0ZjLHVXEntZygon17OEfXb8WGF41FCTbDMCSFVjD2/+8ScPE0CRuJvyXw
         i1IUSVZ6SNfpnCEB6jUWgM/2jR7B7BsWK+yljznrUzIce7P2jJB8bW+okdsqD7tZx8wA
         5pdg==
X-Forwarded-Encrypted: i=1; AJvYcCV8xJJRnVXZ7Gp0qwcNakVW8vHIXOsCThK6/oeCrPVc7hO2RwKYi80edrEJe7Ow60B68mppfSKJfIk270Ca@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCRsioiyMNMXIYTqFkiOzn8X0Y8sYeJWflf6fdxcQxY77ri1B
	95SbMWu8pcdAZzc/cvIyMQW36Cl2qFLDGYWhyzI7Irwn90LAa1D7CqtBDjuDAQVV63W+REr3EOV
	zj16SYAIsq1kyPnJwKJYY9/WPMvIBF4zGdwDccM6ztxeFyBkiFI+oQber3JA=
X-Google-Smtp-Source: AGHT+IGWoC7uysYCk1FSnzzc7apNvC0hEWJoDC4pBY+r4h2NZp0KmGuTtwQm6LWJkyxGg7ORf0FPueICeSkjhoNHGJ//bHIKqAmj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:433:2400:2eef with SMTP id
 e9e14a558f8ab-4334ee78384mr24853605ab.13.1762392928395; Wed, 05 Nov 2025
 17:35:28 -0800 (PST)
Date: Wed, 05 Nov 2025 17:35:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bfb60.050a0220.2e3c35.0012.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in nsproxy_ns_active_get
From: syzbot <syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17490bd0527f Add linux-next specific files for 20251104
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1006532f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9995c0d2611ab121
dashboard link: https://syzkaller.appspot.com/bug?extid=0a8655a80e189278487e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1406532f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1166ff34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4d318147846/disk-17490bd0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86641a470170/vmlinux-17490bd0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35c008a540c8/bzImage-17490bd0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:288 at __ns_ref_active_get include/linux/ns_common.h:288 [inline], CPU#1: syz.0.20/6007
WARNING: ./include/linux/ns_common.h:288 at nsproxy_ns_active_get+0x8ab/0xcb0 fs/nsfs.c:690, CPU#1: syz.0.20/6007
Modules linked in:
CPU: 1 UID: 0 PID: 6007 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_get include/linux/ns_common.h:288 [inline]
RIP: 0010:nsproxy_ns_active_get+0x8ab/0xcb0 fs/nsfs.c:690
Code: 5f 5d e9 08 ca 18 09 cc e8 32 8c 77 ff 90 0f 0b 90 e9 ee f7 ff ff e8 24 8c 77 ff 90 0f 0b 90 e9 12 f8 ff ff e8 16 8c 77 ff 90 <0f> 0b 90 e9 dc f8 ff ff e8 08 8c 77 ff 90 0f 0b 90 e9 03 f9 ff ff
RSP: 0018:ffffc900039cfd40 EFLAGS: 00010293
RAX: ffffffff8249d07a RBX: ffff8880582bb680 RCX: ffff88806aeb5b80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 00000000f0000301 R08: ffff88807ca21913 R09: 1ffff1100f944322
R10: dffffc0000000000 R11: ffffed100f944323 R12: dffffc0000000000
R13: 1ffff1100d52d683 R14: ffff88807ca21910 R15: ffff88807ca216c0
FS:  0000555570bd2500(0000) GS:ffff888125b92000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30163fff CR3: 000000007d256000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 switch_task_namespaces+0x3e/0x110 kernel/nsproxy.c:240
 commit_nsset kernel/nsproxy.c:555 [inline]
 __do_sys_setns kernel/nsproxy.c:591 [inline]
 __se_sys_setns+0x784/0x17d0 kernel/nsproxy.c:559
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc583f8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2014d848 EFLAGS: 00000246 ORIG_RAX: 0000000000000134
RAX: ffffffffffffffda RBX: 00007fc5841e5fa0 RCX: 00007fc583f8f6c9
RDX: 0000000000000000 RSI: 0000000024020000 RDI: 0000000000000003
RBP: 00007fc584011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc5841e5fa0 R14: 00007fc5841e5fa0 R15: 0000000000000002
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

