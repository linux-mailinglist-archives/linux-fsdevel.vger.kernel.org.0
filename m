Return-Path: <linux-fsdevel+bounces-29771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB5197D8C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA1F1F24776
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDBE17E005;
	Fri, 20 Sep 2024 17:00:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8085EEB5
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851635; cv=none; b=PG7JBOYfm4qa9Kd0MrXPZzcHg8Sml+puZKWKW/ocD7wqLZqaeRxI8sB0L35OP62OCegcOuLMIA2haFSz2eTyw8axWpUYxMZnLWk5Kfzqtbm3w9w6v0OW/PRgLl2llbUJMEkLDUY72VWiP8605y+Ham8OSS614C7Y9PuMerL88RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851635; c=relaxed/simple;
	bh=4j+fUHE3+805kbYfg1lYbt761J4oZtOOvdmszfKJ8RQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M+/8ustbbdWjzb/Bf+VCOZsMhAnvflLIIuIXHIbMqzSty7cGmWrcXlvcvhuEFcTaDAi0pgMdOsTlrSPeAk6UocdSTWzNHVCtopKR49bk6nTCNunn/bZl9nrTwtl9eM3AqCsyMBn/kzSqFpgDrduhRpQC8zETr/pqnrGUH6XBXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cea2c4e35so317296339f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 10:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851633; x=1727456433;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfDdPHt9GI0mh8ly82kMMRpzmCBeMx53wohZf9EjjOU=;
        b=oJypIOLypl/1BRBAnT+3Yip15Bp0XyX7xrEADq52VqfFpZtvWnHwPKN46U5IDnHXcn
         LkAtxZ4sZDAUSHani8FNUZsW9XTRQ8e859Wbt3tBD6PnlqhF9DbpJ7xJFJuJhK8txbM+
         eEjUyQbQQF5ci7OjLSuyKptiDKF76mp+FCrFOusLRydIJTGfiPVvtyIG0cAE8390739u
         9dynch7QkPkK0UWgbfY+TJsAc0x49O67xLTEpMqRPvNj2C2RiBq/ThlKl9q+6aM0b3Pa
         n/AROw6jxdUWLyZTblDh62L6a+GfQy+mvOM7AqmKy9aNbmtjLzJ7XyWArnRFDOtL/Ygm
         kK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVOhc3PC1Jc+/7xx88A/xGLstEBLNbSHpPwuPr7wGPCbNDxv7fHtsU5S0XSp+zoSVZVVDWY31a/DWumL54G@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LeF2/Lj6x1qFI9LgcZ4Ztti/dVNFm8dnX52Ikubdx89Ot+1/
	zkp9kkY8tbFevunQfwf132DSkhPJqoukGv/NOJwbF2yTXtqKz8Eh7dEjytf7xfIGqA1cxhB3/t1
	CV1Do5ANWLqOhOgRn8HrAI6RbzcEu4WQ//4MovE5idoPuj8kKg9JcyZ0=
X-Google-Smtp-Source: AGHT+IGHQLJzZ3Fwb8rhyPaE93K4zYCduyO6cmykcNi4QNNVdsnzFUnAgaEPQ+1hPSwt7ObLXPFgHEAlZ0B43MJ/HEgM61DDf8E8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:3a0:b1ea:816 with SMTP id
 e9e14a558f8ab-3a0c9db0144mr31192415ab.25.1726851632712; Fri, 20 Sep 2024
 10:00:32 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:00:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edaa30.050a0220.25340c.0006.GAE@google.com>
Subject: [syzbot] [netfs?] KMSAN: uninit-value in netfs_clear_buffer
From: syzbot <syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f27fce67173 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10da7500580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d864366be695947
dashboard link: https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdbfc7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17acc69f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c167a07d047b/disk-2f27fce6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a68ac6093374/vmlinux-2f27fce6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72a53f77d2bc/bzImage-2f27fce6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in netfs_clear_buffer+0x216/0x4e0 fs/netfs/misc.c:75
 netfs_clear_buffer+0x216/0x4e0 fs/netfs/misc.c:75
 netfs_free_request+0x51f/0x890 fs/netfs/objects.c:146
 netfs_put_request+0x161/0x360 fs/netfs/objects.c:170
 netfs_write_collection_worker+0x7337/0x7c20
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3393
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 __kmalloc_cache_noprof+0x4f0/0xb00 mm/slub.c:4185
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x2cf/0x8b0 fs/netfs/misc.c:25
 netfs_write_folio+0x1120/0x3050 fs/netfs/write_issue.c:421
 netfs_writepages+0xe60/0x1670 fs/netfs/write_issue.c:541
 do_writepages+0x427/0xc30 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 __filemap_fdatawrite mm/filemap.c:436 [inline]
 filemap_fdatawrite+0xbf/0xf0 mm/filemap.c:441
 v9fs_dir_release+0x1f2/0x810 fs/9p/vfs_dir.c:219
 __fput+0x32c/0x1120 fs/file_table.c:431
 ____fput+0x25/0x30 fs/file_table.c:459
 task_work_run+0x268/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xd88/0x4050 kernel/exit.c:882
 do_group_exit+0x2fe/0x390 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3c/0x50 kernel/exit.c:1040
 x64_sys_call+0x3b9a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 2945 Comm: kworker/u8:9 Not tainted 6.11.0-syzkaller-04557-g2f27fce67173 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events_unbound netfs_write_collection_worker
=====================================================


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

