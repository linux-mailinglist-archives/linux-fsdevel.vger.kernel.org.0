Return-Path: <linux-fsdevel+bounces-9248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E74483F87D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D671C21A50
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6772D61A;
	Sun, 28 Jan 2024 17:15:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFC28E34
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706462136; cv=none; b=dLMQGjR3+QKhqfDJUo70BxPGwzspA/Yhlvyn+dyqsrfotqV0eYHhxCMadTnWLxjzQU8Gz/WKepM1DxCffb37mgxtcvVgOO5tQx4DaFuEpXEmDxvk4F6hrPvwbrt4JWt8OwWkT53KkBQuL3N+zTM5vRLen7dv6lbJ85XTlfpw07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706462136; c=relaxed/simple;
	bh=+zrBjFindhrESH6cAboGHlXNnse2qCiGYhqwEb++LfE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ORGyzO8AOna/M7aIUZJ/u4oEurxe1jbh9tJMreZuLgb69BjmhYZp05WVE1VCxEhzHyaD7QrS1kI8m5KZxBOAa5Pu1s9TU9BDMxiGrRIq/al0ud3VU/igXVCAztEFnXRDRecenPGZTUq61iuvTwHHFKwuyuQx7+cNqtkfQ8698Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bff2d672a5so9730839f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 09:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706462133; x=1707066933;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+H37VIGcLKynHUks8NE6DOEj+DkzkDkIEx9kZaSeIE=;
        b=p2oYyDX7KIspSV/lDriDulN3xPvx3NwBqe/tbjlHuU54iYDyV58rKtsATjYAWONNYN
         w4IIXozSdpkQk7MNSH9V4VIQm3WIhWJOW1zvkwGnHQdjQmqcDyr69R/HuKHBBfv8Eu8B
         PmWbjlKBN7k0oeLolTEQrVMp3czN13POktSUWBgjZfTIlJkYCja5HwhWrNASRbxz0db/
         OYPYal6gIfHo5IFG5mMzDTsNY2pw180uDJKcmaw3n+4UohOY/ZrCcQl5aX0Ok0bqNn52
         D01SyNFUCb1QPJZOvkiZUSNB50fs2oxIm+IP5/uuqGAXrnRrkaBiJazHFPgXxNmP6s5h
         nweg==
X-Gm-Message-State: AOJu0Yz/OclG3AjmbVR3zFw2ZIaBGIwu+oq4/grtgaF52U4aDAwgXtRY
	Y7TYrlP93gvA8ih2i9devofJwqLemOXXTn754ym1whNBlP7BaXd6DMFRXU7a5LG7mGQ3jukrHou
	GS1fsMw9RqmxBmG9+L33gnINGS9t/IkqH9yXjcJRvDzfSlPGTCQVN1UU=
X-Google-Smtp-Source: AGHT+IEBFkHGM+HzFZBmrXopcOpu4jtcg689Mg+VSwWrRJcAYgfksgEGx9R6qLV1QGK9HFhUyWSD+0YGycrAellb0IOWv81DibwO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b45:b0:362:b1a9:4aef with SMTP id
 f5-20020a056e020b4500b00362b1a94aefmr418263ilu.5.1706462133341; Sun, 28 Jan
 2024 09:15:33 -0800 (PST)
Date: Sun, 28 Jan 2024 09:15:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047d819061004ad6c@google.com>
Subject: [syzbot] [ext4?] [nilfs?] INFO: task hung in migrate_pages_batch
From: syzbot <syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	konishi.ryusuke@gmail.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0802e17d9aca Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10832107e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9616b7e180577ba
dashboard link: https://syzkaller.appspot.com/bug?extid=ee2ae68da3b22d04cd8d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163043bfe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1306c1e3e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84e45f27a78/disk-0802e17d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8b16d2fc3b1/vmlinux-0802e17d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c7ac36b3de1/Image-0802e17d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e31cee0eb927/mount_10.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com

INFO: task syz-executor439:7446 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor439 state:D stack:0     pid:7446  tgid:7429  ppid:6155   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 io_schedule+0x8c/0x12c kernel/sched/core.c:8998
 folio_wait_bit_common+0x65c/0xb90 mm/filemap.c:1273
 folio_wait_bit+0x30/0x40 mm/filemap.c:1412
 folio_wait_writeback+0x14c/0x3bc mm/page-writeback.c:3065
 migrate_folio_unmap mm/migrate.c:1191 [inline]
 migrate_pages_batch+0xc1c/0x25b0 mm/migrate.c:1680
 migrate_pages_sync mm/migrate.c:1873 [inline]
 migrate_pages+0x1bf8/0x3114 mm/migrate.c:1955
 do_mbind mm/mempolicy.c:1344 [inline]
 kernel_mbind mm/mempolicy.c:1486 [inline]
 __do_sys_mbind mm/mempolicy.c:1560 [inline]
 __se_sys_mbind mm/mempolicy.c:1556 [inline]
 __arm64_sys_mbind+0x1410/0x18e8 mm/mempolicy.c:1556
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task segctord:7440 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:segctord        state:D stack:0     pid:7440  tgid:7440  ppid:2      flags:0x00000008
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 io_schedule+0x8c/0x12c kernel/sched/core.c:8998
 folio_wait_bit_common+0x65c/0xb90 mm/filemap.c:1273
 __folio_lock+0x2c/0x3c mm/filemap.c:1611
 folio_lock include/linux/pagemap.h:1031 [inline]
 nilfs_lookup_dirty_data_buffers+0x2b0/0x7e8 fs/nilfs2/segment.c:727
 nilfs_segctor_scan_file+0x1e4/0xcdc fs/nilfs2/segment.c:1084
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1206 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1533 [inline]
 nilfs_segctor_do_construct+0x16ec/0x6560 fs/nilfs2/segment.c:2081
 nilfs_segctor_construct+0x110/0x768 fs/nilfs2/segment.c:2415
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2523 [inline]
 nilfs_segctor_thread+0x3d4/0xd74 fs/nilfs2/segment.c:2606
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
INFO: task syz-executor439:7442 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor439 state:D stack:0     pid:7442  tgid:7441  ppid:6156   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 wb_wait_for_completion+0x154/0x29c fs/fs-writeback.c:192
 sync_inodes_sb+0x220/0x944 fs/fs-writeback.c:2758
 sync_inodes_one_sb+0x58/0x70 fs/sync.c:77
 iterate_supers+0xd4/0x188 fs/super.c:971
 ksys_sync+0xb4/0x1cc fs/sync.c:102
 __arm64_sys_sync+0x14/0x24 fs/sync.c:113
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor439:7445 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor439 state:D stack:0     pid:7445  tgid:7444  ppid:6160   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6835
 rwsem_down_write_slowpath+0xcfc/0x1aa0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0xb4/0xc0 kernel/locking/rwsem.c:1580
 bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
 sync_inodes_one_sb+0x58/0x70 fs/sync.c:77
 iterate_supers+0xd4/0x188 fs/super.c:971
 ksys_sync+0xb4/0x1cc fs/sync.c:102
 __arm64_sys_sync+0x14/0x24 fs/sync.c:113
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor439:7450 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor439 state:D stack:0     pid:7450  tgid:7448  ppid:6153   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6835
 rwsem_down_write_slowpath+0xcfc/0x1aa0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0xb4/0xc0 kernel/locking/rwsem.c:1580
 bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
 sync_inodes_one_sb+0x58/0x70 fs/sync.c:77
 iterate_supers+0xd4/0x188 fs/super.c:971
 ksys_sync+0xb4/0x1cc fs/sync.c:102
 __arm64_sys_sync+0x14/0x24 fs/sync.c:113
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor439:7451 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor439 state:D stack:0     pid:7451  tgid:7449  ppid:6154   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6835
 rwsem_down_write_slowpath+0xcfc/0x1aa0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0xb4/0xc0 kernel/locking/rwsem.c:1580
 bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
 sync_inodes_one_sb+0x58/0x70 fs/sync.c:77
 iterate_supers+0xd4/0x188 fs/super.c:971
 ksys_sync+0xb4/0x1cc fs/sync.c:102
 __arm64_sys_sync+0x14/0x24 fs/sync.c:113
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
INFO: task syz-executor439:7460 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor439 state:D stack:0     pid:7460  tgid:7456  ppid:6161   flags:0x0000000d
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1354/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6835
 rwsem_down_write_slowpath+0xcfc/0x1aa0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0xb4/0xc0 kernel/locking/rwsem.c:1580
 bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
 sync_inodes_one_sb+0x58/0x70 fs/sync.c:77
 iterate_supers+0xd4/0x188 fs/super.c:971
 ksys_sync+0xb4/0x1cc fs/sync.c:102
 __arm64_sys_sync+0x14/0x24 fs/sync.c:113
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffff80008e6c48c0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:300
2 locks held by kworker/u4:3/41:
 #0: ffff0000c1c3a138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x560/0x1204 kernel/workqueue.c:2600
 #1: ffff8000943f7c20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x5a0/0x1204 kernel/workqueue.c:2602
2 locks held by getty/5863:
 #0: ffff0000d255f0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800094e702f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2201
1 lock held by segctord/7440:
 #0: ffff0000c7ade2a0 (&nilfs->ns_segctor_sem){++++}-{3:3}, at: nilfs_transaction_lock+0x178/0x33c fs/nilfs2/segment.c:357
2 locks held by syz-executor439/7442:
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
2 locks held by syz-executor439/7445:
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
2 locks held by syz-executor439/7450:
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
2 locks held by syz-executor439/7451:
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756
2 locks held by syz-executor439/7460:
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff0000c5e920e0 (&type->s_umount_key#64){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: bdi_down_write_wb_switch_rwsem fs/fs-writeback.c:364 [inline]
 #1: ffff0000c9d147d0 (&bdi->wb_switch_rwsem){+.+.}-{3:3}, at: sync_inodes_sb+0x208/0x944 fs/fs-writeback.c:2756

=============================================



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

