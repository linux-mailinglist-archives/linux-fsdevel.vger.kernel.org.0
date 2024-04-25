Return-Path: <linux-fsdevel+bounces-17695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18788B1853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE17285F22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3711720;
	Thu, 25 Apr 2024 01:07:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4521097B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007254; cv=none; b=kxSigLWvwTtKKjq+YeK55KDyg5GO9bB5mQzwe9hAuotAo/U6q4fCxUCBbgpHw6cEPSUQnhG1fG3GRSKMejHkFsRMybukYckCimEf2roF+CHAqbFQHaxgQDZT4bogsShEyFf6TF1jNi2dziOn8aLYmpDF0GIoNGAOIJshYn1+Qj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007254; c=relaxed/simple;
	bh=oXD77TlEA+KoDVeVhKX9xrXf+Cy7+f6lUcx09x4ptI0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZU798ftJaSuTKjbTN+6nHJV3qxcKhSX3t+umEprUMLEM8bphGMq7LEZJwJX265XRisMFZh0Ojn5uKv2l6k0LufSncOuOWeas8hJjeBDm3o5LOeH6yhQmfa7e06K5wg+eLH8v3K0BSNlUo369rr1eP8xJZ41lbMEoP3LBx5LHUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so49335339f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 18:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007252; x=1714612052;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CN7foOohRk9vq2WfV4A1ZYhtMDIkqy+Gz3ButiULe+w=;
        b=Ng4qhR3D8hCNaocu02NMb7Eyo8ZLkUI3QMjQh+DAB0amB6S6aejelSkzDf/eeKWmzi
         Zi9preeqaUGHgOosY3h03dw7ghhaZSNSFTPSWgyvedI4ZcnuLbu42knytVqX/d//rTmA
         HQRwhid8S7/LUdETb3QC41p9o8ViUNpdQtLoqkuPIdKGLneu0roVL3O22cxUHLzn4w+N
         fzyGj2XoPYk9e+qD3yoeHH9cVeZiLkhjlFmEFFhosL8L7K1kfCJvD0av/hAwBhtAVxSm
         2hQ/gJCx5DxZY2ulSgWeN4COnet3uSvtdw2Sx5UCfeOD6uJq/ezFB2+vHkbEpVZPZaDv
         K+DA==
X-Forwarded-Encrypted: i=1; AJvYcCUbH4pJmxWQ8tu5ArwLkeTGcMezGLIDLZIuQ8y4sAArlsd1tRC1vkWSS+RiaCqB4H4c6fsYNH/OXJKe82duQ05aLYv8PskyrPQW+FKXYA==
X-Gm-Message-State: AOJu0Yz/500TyQzPqCaD+PT/eUvzVOyvC5M2QY0t64yWdd5pD47ilPko
	TBYBvOaC6fVFbZdNBBrMpHD6Hb/7WVbstGHTFhRN6DMLr83P8IPCD3oShOxPCl3j1CxT2B2bNK9
	rcEIywRIs/Pm8hni3ByvX6AGxKR4vm6sPElPSJclQbKjgrtotLeHZox4=
X-Google-Smtp-Source: AGHT+IE3a2tP38RQ+zKNUzmeTK0UIwp2l4ksdYXzw9xJQwy2OVsrBiLsWJ+Nuyem1mhBpOOsQXBG83GjM0e6TYwvz5SWMHufRCuN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc9:b0:7d5:d9ec:2ea1 with SMTP id
 l9-20020a0566022dc900b007d5d9ec2ea1mr185239iow.4.1714007252664; Wed, 24 Apr
 2024 18:07:32 -0700 (PDT)
Date: Wed, 24 Apr 2024 18:07:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007010c50616e169f4@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in find_lock_lowest_rq
From: syzbot <syzbot+9a3a26ce3bf119f0190b@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1455666f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=9a3a26ce3bf119f0190b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d69c27180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5920d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08d7b6e107aa/disk-977b1ef5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c5e543ffdcf/vmlinux-977b1ef5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04a6d79d2f69/bzImage-977b1ef5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a3a26ce3bf119f0190b@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 11 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 11 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 0 PID: 11 at kernel/locking/lockdep.c:232 __lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4773 [inline]
RIP: 0010:__lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Code: 00 00 83 3d ee 8f 36 0e 00 75 23 90 48 c7 c7 40 b7 ca 8b 48 c7 c6 e0 b9 ca 8b e8 f8 f6 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc900001070d0 EFLAGS: 00010046
RAX: 006b76d8e1927600 RBX: 0000000000001b80 RCX: ffff8880172abc00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000000001e R08: ffffffff81588072 R09: 1ffff1101728519a
R10: dffffc0000000000 R11: ffffed101728519b R12: 0000000000000001
R13: ffff8880172abc00 R14: 000000000000001e R15: ffff8880172ac7e8
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb8988bb8 CR3: 000000002e4fc000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 _double_lock_balance kernel/sched/sched.h:2714 [inline]
 double_lock_balance kernel/sched/sched.h:2759 [inline]
 find_lock_lowest_rq+0x1e1/0x670 kernel/sched/rt.c:1942
 push_rt_task+0x13f/0x7f0 kernel/sched/rt.c:2075
 push_rt_tasks kernel/sched/rt.c:2125 [inline]
 task_woken_rt+0x14c/0x220 kernel/sched/rt.c:2425
 ttwu_do_activate+0x338/0x7e0 kernel/sched/core.c:3805
 ttwu_queue kernel/sched/core.c:4057 [inline]
 try_to_wake_up+0x88b/0x1470 kernel/sched/core.c:4378
 autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x132/0x1e0 kernel/sched/wait.c:106
 sub_reserved_credits fs/jbd2/transaction.c:213 [inline]
 start_this_handle+0x1db0/0x22a0 fs/jbd2/transaction.c:442
 jbd2_journal_start_reserved+0xe8/0x300 fs/jbd2/transaction.c:624
 __ext4_journal_start_reserved+0x237/0x460 fs/ext4/ext4_jbd2.c:161
 ext4_convert_unwritten_io_end_vec+0x34/0x170 fs/ext4/extents.c:4877
 ext4_end_io_end fs/ext4/page-io.c:186 [inline]
 ext4_do_flush_completed_IO fs/ext4/page-io.c:259 [inline]
 ext4_end_io_rsv_work+0x36c/0x6f0 fs/ext4/page-io.c:273
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

