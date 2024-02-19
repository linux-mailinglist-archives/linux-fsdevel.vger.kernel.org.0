Return-Path: <linux-fsdevel+bounces-11991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521185A173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321D7B22172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AB28E0F;
	Mon, 19 Feb 2024 10:54:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB828DCB
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340059; cv=none; b=nnHOX9yTCKzKJVnEXWOyd0Nc/zKgqLb1S+dI90IKXIRUaxEajbb65RQCW8f5XNGWEP5ZA/OMST/pV0aZbu0a2ZSU+hAZI3oaSMUZT2zbeFn852Q6rDxf27cjF/YHFUlaGkM7Wxlx8xFbfveaqM4gZLGH3b8WkJfxaDRXW9vFwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340059; c=relaxed/simple;
	bh=vcmWLpsbR5n9RKGU2WnaOKPU7Yuwl2Bb2ZNlUPIMcCI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u34TJjnVhCdrsE1MnXHTk9Qblg0WNPFEiCWeRfN61X//nN633UX/99XcGkikfoAdgSGd9xIufjCsLFMhQP5KM7AEZZNZ0FHSvFocYrL8HQzVMhgrWEyf+DUkkmGcH5LM9HL7rfyW0c+GtnIXlibU3/Gtfu1nU9IebuiwwqOqEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c064b035acso319225239f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 02:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708340056; x=1708944856;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jk5EspbERIA8uUIF9TL7Tb+L6jCRUl5vlESHpidcuZc=;
        b=LLoNd1Uirisjc6r3SBQ0IDQz582hVv4a05OjEkYemOOW58y0wQYNvu68VeM0SkCIeW
         Psc3tkA7XOveGGBAnkdYuMjCdwkEvq/FYpZBW89nG9Y0/rGrJAnx6GmAjPnmjClNayvP
         CcmJ029uR+756ExkKlEQGC7OwjWA9pHHKj7i7/fubB9NIwJ7SLh426sYL8uuroPdQS9T
         mS8B3koc+7ZGkR+kREm7kvcAGFn+o2bisRDgBN8YYIsY2oKpbSVLHrsHFDeUKmeNKvzs
         iJz4GhehCWcEDtbR+Jn04xeNtyTqLxbX11RbUmZsSTl86i42/gh/SDtiqnex9MpL+eO5
         5Jrg==
X-Forwarded-Encrypted: i=1; AJvYcCWgqe4AA9flpuR0WhWh8Bvq40/RyJAyu4Y5Gu/zg22FOHnRhu7vw424fhlJs2ZddnXzBR/1Q/JIVRj3Ldzdx6jwkEhCB2uZyjEvof38dA==
X-Gm-Message-State: AOJu0Yxedpq+edi9y5h1a+kVrwifb5aYu8gnppvPKVku9Ddb22b8YyXV
	MJclyHV7HlzOJTqxfHeH8cvzlM46zvK0x7ME1Wjd0OnBkiJxPcC0xiu++/xDd+vkKA0Szy03LGr
	xQ+Q81Ox/HHiofLScwb302CepPgTY8ODWJzbXZKDtQ9qx71RQI0e6GZ4=
X-Google-Smtp-Source: AGHT+IHhBF6fp0Jnn7wYY17cmd8VUoh94pZXEYHyQl4ojI/qWuxyam31nMsi1y3qV4CIjdv6lbez3Oc8cN5vk76QJp82TsVGcCzQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0f:b0:365:26e3:6e60 with SMTP id
 i15-20020a056e021b0f00b0036526e36e60mr398541ilv.0.1708340056777; Mon, 19 Feb
 2024 02:54:16 -0800 (PST)
Date: Mon, 19 Feb 2024 02:54:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d6c9d0611b9ea2d@google.com>
Subject: [syzbot] [nilfs?] INFO: task hung in nilfs_segctor_thread (2)
From: syzbot <syzbot+c8166c541d3971bf6c87@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f735966ee23c Merge branches 'for-next/reorg-va-space' and ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12dbb3dc180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d47605a39da2cf06
dashboard link: https://syzkaller.appspot.com/bug?extid=c8166c541d3971bf6c87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bdea2316c4db/disk-f735966e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75ba7806a91c/vmlinux-f735966e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/208f119d45ed/Image-f735966e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c8166c541d3971bf6c87@syzkaller.appspotmail.com

INFO: task segctord:26558 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc3-syzkaller-gf735966ee23c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:segctord        state:D stack:0     pid:26558 tgid:26558 ppid:2      flags:0x00000008
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6874
 rwsem_down_write_slowpath+0xcfc/0x1aa0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0xb4/0xc0 kernel/locking/rwsem.c:1580
 nilfs_transaction_lock+0x178/0x33c fs/nilfs2/segment.c:357
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2523 [inline]
 nilfs_segctor_thread+0x3cc/0xd78 fs/nilfs2/segment.c:2608
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffff80008ee43fc0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:297
2 locks held by getty/5931:
 #0: ffff0000d82710a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800093fe72f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2201
1 lock held by syz-executor.0/6205:
 #0: ffff0000d6d12c68 (&pipe->mutex/1){+.+.}-{3:3}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:297
2 locks held by kworker/u4:26/13298:
6 locks held by syz-executor.2/26553:
1 lock held by segctord/26558:
 #0: ffff00011fc2d2a0
 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x178/0x33c fs/nilfs2/segment.c:357
1 lock held by syz-executor.3/11586:
 #0: ffff0000c346f8b8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid+0x3c/0xd4 net/netfilter/nf_tables_api.c:10624
1 lock held by syz-executor.1/11588:
1 lock held by syz-executor.2/11593:
 #0: ffff0001485282b8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid+0x3c/0xd4 net/netfilter/nf_tables_api.c:10624
1 lock held by syz-executor.4/11594:
 #0: ffff0000d343fcb8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid+0x3c/0xd4 net/netfilter/nf_tables_api.c:10624
4 locks held by syz-executor.0/11595:
 #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:559 [inline]
 #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
 #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1699 [inline]
 #0: ffff0001b400ef58 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x2e0/0x24b4 kernel/sched/core.c:6643
 #1: ffff0001b3ffac88 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3c0/0x618 kernel/sched/psi.c:988
 #2: ffff0001b401cc88 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x100/0x234 kernel/sched/psi.c:912
 #3: ffff0001b401cc88 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_change+0x100/0x234 kernel/sched/psi.c:912

=============================================



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

