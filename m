Return-Path: <linux-fsdevel+bounces-56281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B86B154EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC45618871FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301AE27E1DC;
	Tue, 29 Jul 2025 21:59:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E7224898
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826373; cv=none; b=SBuSZwvPEWfvWnQ90Di4ewNo/zPhnLNb9D37plqhL7Mlv+UR+yg6Cu+qX0f0CjPHOwWFKXItawUE3b0bmMA43qGZ3z/mMF9OSbv8bVTm4/pzLJBkQc/aik2rw4TrNEs97k/EreePDfmN96jyHtUxGZyV+Vsk1kQi7GTcXmNAOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826373; c=relaxed/simple;
	bh=9pHYKpxMS7a704q/ZX5wKegVR3mYFKPyExxNq2P++rg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mC8bCV4ALv4jQ+eom5cQjFz+vpQm44g/Fmuf8k0mX5RvegDepGP/GHIU2yJKZbYuua5DL+tq9ATXO0aArUO4r4MiBfqT5DhDGrSEqelTGVjldar64Ce4Pek3XSoAQ7VHzWnSUdeqhTXh5XAoRrZvWUB2kz3VROeupfwi9S/1dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c1cc3c42aso1113539539f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753826371; x=1754431171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otBD7CKYmzUlzr0WVN8+T3QSXQV1LtvL0a1k3Ws5is0=;
        b=psZ8pAurxg22UW2aE0vXEbxL0b1btuZHKmjGXYK1ooveBLPHEzMZ7IdVuM7cMgnOGd
         jfTd3WYE6mpUazfnTxxaXGsKeOF3ar7jbBP0iJlqILLU7Hr4eZVdY7wY1H1p6Fc0TSPL
         VwBTa0xqDYa1oJw9p7r9bRIebh5EKTAuLzt+kEACa4VESx1nHnYk/B6QpDI5+U870qnr
         CRQX0mCmTR3Dt8/pkPnl/HCuDsUshiQQBFt0ASZpAPEK3LO0qCYFODIbpIVmDQwabUyS
         CvCMmcsj47vcWLmskYXSViqIvPkoxcmh9cvuxqUybtJgxWdi35npk0GX3B/D7l/LH2+J
         MQCg==
X-Forwarded-Encrypted: i=1; AJvYcCWd22GDiGKE8P+az07x4WciSlHj0H0G/pRsbPeAf7voGh41BcY6RxqekWCW4CKBqARuBAvMpFcI5d2ZNnVF@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzoPYPoBVtKlFPYIsm50TqYyZakAO4oGGdORM9dA2hQgUfBzJ
	bT9vl16VrvSgw9Hyh91MddVgGszVdcnvjroD7EoEAbFMmjOSwj0iCUYGL/ELKpAJc9i4K0JFzo1
	RMCJ9bGZSfAjtbf4pwmBUl90k9uuEG90qs+XFGW7z4A9g6RVEuQtkK8SgKsA=
X-Google-Smtp-Source: AGHT+IF5VYKrl0LdDJpnUjvYUpstTin4U0s6m1WgeAoj7hXfa+gejT98Z5veYO6MHEzrnmFn+ariqo/aQyvuZFvwfXn4M29lSBYq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:380f:b0:87c:4496:329d with SMTP id
 ca18e2360f4ac-881378184f8mr150606539f.5.1753826371389; Tue, 29 Jul 2025
 14:59:31 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68894443.a00a0220.26d0e1.0014.GAE@google.com>
Subject: [syzbot] [fuse?] WARNING: refcount bug in process_one_work
From: syzbot <syzbot+a638ae70fa7b6a1353b4@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mingo@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12219034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c12ce9080f644c
dashboard link: https://syzkaller.appspot.com/bug?extid=a638ae70fa7b6a1353b4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e784a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154d94a2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ced1b9e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c709b0d9538c/vmlinux-ced1b9e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/129af0799fa3/bzImage-ced1b9e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a638ae70fa7b6a1353b4@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 34 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 3 UID: 0 PID: 34 Comm: kworker/3:0 Not tainted 6.16.0-syzkaller-00857-gced1b9e0392d #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: md_misc mddev_delayed_delete
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 d8 7f da fc 84 db 0f 85 66 ff ff ff e8 eb 84 da fc c6 05 19 50 b0 0b 01 90 48 c7 c7 e0 6a 15 8c e8 d7 8b 99 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 c8 84 da fc 0f b6 1d f4 4f b0 0b 31
RSP: 0018:ffffc900006dfc10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817b01b8
RDX: ffff88801eaac880 RSI: ffffffff817b01c5 RDI: 0000000000000001
RBP: ffff88802a5f4130 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88802a5f4134
R13: dffffc0000000000 R14: ffff88802a5f4130 R15: ffffc900006dfd10
FS:  0000000000000000(0000) GS:ffff8880d69f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f43c9dddd58 CR3: 0000000032cdc000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 kref_put include/linux/kref.h:64 [inline]
 kobject_put+0x230/0x5a0 lib/kobject.c:737
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

