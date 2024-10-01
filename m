Return-Path: <linux-fsdevel+bounces-30568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6898C5F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 21:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A5284390
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 19:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D11CCEE1;
	Tue,  1 Oct 2024 19:20:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658271C32FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810422; cv=none; b=AdqiiYvxJjWiRn40jnDkH2RLwQczLrk6yRHCtu87UpF5LWr1Z/9PuebhI7OImHVod4IvqRXgpfP9FchGqtERAnySkoYP6hK2lIyK7pqIXLLDQxEqzXEEzW/Eew9HH5zGyArfFduhnbna/l+ZZYGXebO3eUlFhuexz1jOlwVUP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810422; c=relaxed/simple;
	bh=l8OYaEgK8rWIvqiCcS9aOfiCpVz6pegQvvwXGV+5ddg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ovf68YrVRa4nV4t/lPnoBfB3coHn7C8RlfKqF0M9xLrxPHCv7dFBPbjDvI6KM0jZA/ntak2lKi0UhMKnAJgGc/6xJkiQm/XYc54XW3Yu1nUlMOizCfYwMgqqJHEPgA5pfJB99w1leszWQSi9rSwxCfKRMRQK9NNFt66lxekZKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1925177fdso56615035ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 12:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810420; x=1728415220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpD9/fvZE/BXOJ9tA2sRSNvX4bC2KiiW9AZPVj6j7Pg=;
        b=ebdQrSyZOiTJeEhpaNcxgedi48EUUAiCMrw4OMprDGgMU/Gj0jAJxs64SN0sVoYFMG
         2BVwMecu6g0tLjkXLoxAg1C4eG2x1ssVRXmPONcbVNCtRU5o8xgz47eKo7FfKPA8xTY9
         dasFDsfq4VWkntG7YxUaBlSVkslwNPuNBuKp5FfcWfHnd6YDdnxeB+dNwo3IQ9MwNQjB
         mhTxfFRI3yQRRFFxLkXWBuQpsII7Q8Dpzn9+v7o5o7kJv11Z8TZXIqkzc1FBEMv3gpjE
         IKu5GwOdXTFsbPY/thXzvYRq2A8hc6ow3BKE9cD/BWyxxPaPVuYwUDMJeklmHl8pPmGN
         zVFw==
X-Gm-Message-State: AOJu0Yz6SG7X0RHAGxAUD66cecv5sd17seEL9RZr3DJ+vYF2NNDDyLoD
	Nez92R2dUIAFJRYEpd8NjsN6gxcOObOcQUxVt5NOQUlLn0gZvTBGAvgoC8QOJ0y3pscA+eeAij3
	P6EwoZRDMoUgdnKoToqQlSkhftKu31RJkpGRBA9c4vN9XSgPDSviwqIo=
X-Google-Smtp-Source: AGHT+IFm+ztl6vR3+lrL4Gle17B1HZdm0JeMgYfyjtT9afU8WEZdxcK2bTNBBzsUyFcdGh0XljrNHYnk0BFBt4uwz+lB77/aMN2y
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1386:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a36594a26emr6079915ab.15.1727810420523; Tue, 01 Oct 2024
 12:20:20 -0700 (PDT)
Date: Tue, 01 Oct 2024 12:20:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com>
Subject: [syzbot] [fuse?] WARNING in fuse_writepages
From: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e8bdd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b5201b91035a876
dashboard link: https://syzkaller.appspot.com/bug?extid=217a976dc26ef2fa8711
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a585cdb91cda/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbeec5d7b296/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/000fd790e08a/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_write_file_get fs/fuse/file.c:1989 [inline]
WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_write_file_get fs/fuse/file.c:1986 [inline]
WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_writepages+0x497/0x5a0 fs/fuse/file.c:2368
Modules linked in:
CPU: 0 UID: 0 PID: 5296 Comm: kworker/u8:8 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-0:52)
RIP: 0010:fuse_write_file_get fs/fuse/file.c:1989 [inline]
RIP: 0010:fuse_write_file_get fs/fuse/file.c:1986 [inline]
RIP: 0010:fuse_writepages+0x497/0x5a0 fs/fuse/file.c:2368
Code: 00 00 00 44 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 79 b6 90 fe 48 8b 7c 24 08 e8 af 6f 27 08 e8 6a b6 90 fe 90 <0f> 0b 90 41 bf fb ff ff ff eb 8b e8 59 b6 90 fe 48 8b 7c 24 18 be
RSP: 0018:ffffc900044ff4a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc900044ff4f8 RCX: 0000000000000000
RDX: ffff88802d42da00 RSI: ffffffff82fcd286 RDI: 0000000000000001
RBP: ffff88805c994aa0 R08: 0000000000000000 R09: ffffed100b9329d7
R10: ffff88805c994ebb R11: 0000000000000003 R12: ffffc900044ff840
R13: ffff88805c994880 R14: ffff88805f330000 R15: ffff88805c994d50
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020055000 CR3: 000000005df4a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x166/0xfa0 fs/fs-writeback.c:1658
 writeback_sb_inodes+0x603/0xfa0 fs/fs-writeback.c:1954
 wb_writeback+0x199/0xb50 fs/fs-writeback.c:2134
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x294/0xbc0 fs/fs-writeback.c:2321
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

