Return-Path: <linux-fsdevel+bounces-30438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A09F98B68E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B1C1C22064
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106501BE223;
	Tue,  1 Oct 2024 08:09:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337861BDAAA
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770170; cv=none; b=gxpWaU4bfW5Jx4H5sMKKEjClT6RN4pFXjjEFWISf0SA1IZ5zGOmnSSeEGLo/sRGhmdg7jDsylNcJx1reevLojJz8PaNAL2FOOoZLh5nntfQ7Cuzr6fGDwa2twqfXVP9DFOsOPu54FBEnKf0GjwHHWYz2/8SavikHOz5SVitVM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770170; c=relaxed/simple;
	bh=EbGBpRHnvl6IvzXCA9jp3xcrqQjFWk+0/sKdxxv7f5A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qtzWkT9zKF1kTKKqN4CfeCmZqsQf1YP4UViUAnE4PMqW444VcUkxcUIVYA44Jcchaj+LMy1woB84oozxqyA4FFcVvmAhz4peJlfd0+0eSU6IOX3G5p3J/wqIB+5GFOhlp1dw0Af1KvYTfSjlp/oIe5hYNWN84XsIercyIGN4P/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342620d49so46781915ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 01:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770168; x=1728374968;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7V6fRL7UjAsnDR6dRn4CiYM7Ws9Jq2H2tMuf/ISe00=;
        b=byuMzhm39HBqD5vLSzhI7jLu9yAyeHn4oQlpSqYyZKU16aONFEqfhbozICrgaIgPbs
         8obvJdkxLSdbUycDBsNTGyTDnV5/VVtPahjI2ipwTk47Zy4g6eEwfokBoeez7/26k6UP
         4nEhzjusABWGmCjPg3NXxIpzO42ixQcsGTNo56WAs1UDU9Bz1ne3txgTW/C2LuaSTOfQ
         q9aRy8o8M8Y2MlHZoAo//zPBRJviOVLpdYOcnlXtRyFldMdhL2umHCKq/jtD8RGgSKw4
         Juv7rB1qTA08toxlcA8buUVYXHUr8+EHY+8nNXLPIDUuzR9+iAOVaZS6FlEq0dJqMUIB
         jZfg==
X-Gm-Message-State: AOJu0Yxaeclap05ifBUd1HzeUPBIvX9ogdx+BHb+JRmxXLQ7XINbXv36
	7eciZzudTFxpP1TqqvohgfrTzCZUq0smJ+b8LZbGjyrHN8fJil/41XGdBsqDVXz9dUIBtk2xobO
	4i6QF7twZZLM+QMcAGTAlxqtrp1YzkGGRDICWWn64jF3YYdN74Z9wzvU=
X-Google-Smtp-Source: AGHT+IHvwPpOTbWnjjgHECUbOyyXGi3Q2t54HQTs8Eu3KoRGFooAKRrP2mQnEePL+pKAldgpmK4DT0+7ZaCkcLIxFzgM/a4dIHLp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:39f:53b3:ca63 with SMTP id
 e9e14a558f8ab-3a345155676mr109902515ab.3.1727770168249; Tue, 01 Oct 2024
 01:09:28 -0700 (PDT)
Date: Tue, 01 Oct 2024 01:09:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbae38.050a0220.6bad9.0051.GAE@google.com>
Subject: [syzbot] [fuse?] WARNING in fuse_write_file_get (2)
From: syzbot <syzbot+f69287fa1bf99c7c3321@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cea5425829f7 Add linux-next specific files for 20240930
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=161c439f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41a28720ed564c6a
dashboard link: https://syzkaller.appspot.com/bug?extid=f69287fa1bf99c7c3321
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/566995596f19/disk-cea54258.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e7c506c1c71d/vmlinux-cea54258.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fcb4468b8c0/bzImage-cea54258.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f69287fa1bf99c7c3321@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 12 at fs/fuse/file.c:1989 fuse_write_file_get+0xb8/0xf0 fs/fuse/file.c:1989
Modules linked in:
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-rc1-next-20240930-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-0:57)
RIP: 0010:fuse_write_file_get+0xb8/0xf0 fs/fuse/file.c:1989
Code: ff ff ff ff e8 29 d2 7b fe 09 dd 78 3c e8 e0 cd 7b fe 4c 89 f7 e8 78 79 b8 08 eb 11 e8 d1 cd 7b fe 4c 89 f7 e8 69 79 b8 08 90 <0f> 0b 90 4c 89 e0 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc e8 b0 cd
RSP: 0018:ffffc900001170d0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805dbe4610 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc90000117210 R08: ffff88805dbe477b R09: 1ffff1100bb7c8ef
R10: dffffc0000000000 R11: ffffed100bb7c8f0 R12: 0000000000000000
R13: 1ffff92000022e28 R14: ffff88805dbe4778 R15: ffff88805dbe4140
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c302213 CR3: 0000000067444000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_writepages+0x259/0x4f0 fs/fuse/file.c:2368
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1658
 writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1954
 wb_writeback+0x41b/0xbd0 fs/fs-writeback.c:2134
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2321
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

