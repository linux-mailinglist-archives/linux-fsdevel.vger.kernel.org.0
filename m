Return-Path: <linux-fsdevel+bounces-38981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D873CA0A808
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 10:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B490B16668A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0CE197A8F;
	Sun, 12 Jan 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="jwqVT0Xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248B38B;
	Sun, 12 Jan 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736675226; cv=none; b=Tcqr15p+UYC0ww9bCu96urhQ4fVzx3p6pGIdEerl2zs2EYTzKBSfYIaYpsCLLerCEtg0S71C+X7RWgSCnbQnd2yFf+fKwfLqjKcQpSyDNpxry6osl+Z2Eq/V7ZtjrYuaG8MXen3sRv1sN0iNx4HSSlEuySzB1IzWHy4qcqkrUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736675226; c=relaxed/simple;
	bh=+iidB7RohV01V0lNSvlTcjCktnUw4XK5p45geKT/xrE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=IY5p63saYK3wlNcn51r78BMH3jJ79zS10JGLRgBw9z3bsbCZioAJIdQAV/ZRoYYm72djEd/ePH29YFx8A7rl/eDKjxWwUPW2c+AIKpg9wJJIijQ+2hFb/djDmtLVp+MIdcJyrAMJaRvAltA8ZmBBfykiNNF+MDp8+XZORQv7HS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=jwqVT0Xg; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736675202;
	bh=JM366TKZ7CAJchwENdR3/2iYBiftuvdH1DCznKqlVh0=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=jwqVT0XgjuybIQ9uCApeZHruZOLY9vQqLWQWakdYdwpx7uV2KKSjajwITg+5qYWs5
	 AOG7LC8Z5aLSd4tMEksqqtUT7azrdbJXjcuYjRSvz9dYFnsiJtedZVfOKlwH6x9LFq
	 hOO0AhHSpCLfaEflwBZDvoCjPxpMShoTahio0G8o=
X-QQ-mid: bizesmtpip3t1736675197tmhf59i
X-QQ-Originating-IP: uIzOalZPFLpc2OdOniv5uYoRod5u/ybCzFe3qNJLYg0=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 12 Jan 2025 17:46:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8430759591893253231
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Bug: task hung in shmem_swapin_folio 
Message-Id: <F5B70018-2D83-4EA8-9321-D260C62BF5E3@m.fudan.edu.cn>
Date: Sun, 12 Jan 2025 17:46:24 +0800
Cc: linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
To: willy@infradead.org,
 hch@lst.de,
 jlayton@kernel.org,
 kirill.shutemov@linux.intel.com,
 vbabka@suse.cz,
 william.kucharski@oracle.com,
 rppt@linux.ibm.com,
 dhowells@redhat.com,
 akpm@linux-foundation.org,
 hughd@google.com
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M7n9VusxZAlP+rberjUcYEuG2USXVvw3+w+gQbyKSp4O3Yo3OZFwcaUZ
	myn3fSJWGf/M8Gilir/lfBOHSwLDaK0sq0iQsbVpQLrvjw+Gv6DKggaDl3qjpLnlDK14LFi
	BvJ2vCs1clx86fTRjDhFVorJHkF+dK8q/7dTifuX8Pgi3e1avFUAKeFUjC37ZypjhgORl9x
	pVWeQjH1bBh+ZZ86PjPQsVQxauXVV+fIiiNqUajdpv4lGHg7UmnkuYAAyRlBnHhZIxIn8jx
	3KTu/WgqAda8db84aZ/SzjDOFLWQhmUwloh4CJGKqfxxDR/QDPOtq/QM4Mf8iWxzRv1tIiQ
	CC0PH59m59gxOu6l1otxuBi+QBcNYOOViyMuELhKNEELpZSp6dZ1ijpADDPtf8J/vcje/LP
	DYIsKHzYvG8FbSVsxGrhW2m/R6YBA/+zekKC3DRxDV0GX5xpyynjoHTmlDWb9clapudhdyl
	GJBGojU0qqbQ5mYWQ9R9EmlrHJROqpZYbm3qlegjHRNwYi9fYZiS6nqMC4X9oGCLgaRcE2I
	/I0LVMn3vHADIKJzcAGz4seT/GF6jSrb5qaSwlKTxEmcDve1jsNrs2GtUw2ZuQEaXIBtiMt
	Yhk40/rDKJVi/6pwjj/gdwmSK6i3n/XyD9B6XQSjV9FcBZQXhDukYYOD0oBALKbmFH5B8+U
	MPixlz5wd9KyxTNhniNTydPHAcgSKepU6qkpNmC76ViXhkA3iB0FnIQhJNj3D95HwajitcJ
	Iwvb/oHtouQ52sm4rgdTFatLRNz3tjaZiktw41fpiC0jietbAm2aQeZBI0WbrAaDTZYbLIj
	GbJ9yD27a5Me/VecPTL8Y7Qsq29C444+gX6OWcxYAYUBxZj999xSudRhM87m6A3WIwPKEMa
	8t86roX0EkmpGU34B+tsKABjBD2WPmTKEtZSrYW/BTkkXpF+lqEIbtksz3jf0RWzOUj2Acy
	RJW39bjpCSpH74loQluRvm36g
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash (42s)
was triggered.

HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
git tree: upstream
Console output: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/42-INFO_%20tas=
k%20hung%20in%20shmem_swapin_folio/log0
Kernel config: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/config.txt
C reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/42-INFO_%20tas=
k%20hung%20in%20shmem_swapin_folio/11_repro.c
Syzlang reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/42-INFO_%20tas=
k%20hung%20in%20shmem_swapin_folio/11_repro.txt

We first found the issue without a stable C and Syzlang reproducers, but =
later I tried multiple rounds of replication on v6.13-rc6 and got the C =
and Syzlang reproducers.

I suspect the issue may arise from resource contention or =
synchronization delays, as suggested by the involvement of =
folio_wait_writeback, shmem_get_folio_gfp, and related memory management =
functions. It might also be related to lock contention (mm->mmap_lock, =
sb_pagefaults) or prolonged I/O operations affecting shared memory or =
paging (e.g., shmem_fault, __handle_mm_fault). There could also be =
inconsistencies in file system state handling, possibly within Btrfs or =
related subsystems.=20

Could you kindly help review these areas to narrow down the root cause? =
Your expertise would be greatly appreciated.

If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>


INFO: task syz.8.1221:10662 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc5 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
task:syz.8.1221      state:D stack:25728 pid:10662 tgid:10660 ppid:2827  =
 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe60/0x4120 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xd4/0x210 kernel/sched/core.c:6848
 io_schedule+0x1a/0x70 kernel/sched/core.c:7681
 folio_wait_bit_common+0x3cc/0x970 mm/filemap.c:1308
 folio_wait_writeback+0x3d/0x2a0 mm/page-writeback.c:3194
 shmem_swapin_folio.isra.0+0xac9/0x1d20 mm/shmem.c:2200
 shmem_get_folio_gfp mm/shmem.c:2290 [inline]
 shmem_get_folio_gfp.isra.0+0x848/0x13d0 mm/shmem.c:2257
 shmem_fault+0x1f9/0xb10 mm/shmem.c:2558
 __do_fault+0x10b/0x490 mm/memory.c:4907
 do_read_fault mm/memory.c:5322 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault+0x1640/0x3130 mm/memory.c:5944
 handle_mm_fault+0x2aa/0x660 mm/memory.c:6112
 do_user_addr_fault+0x953/0x18b0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x9c/0x1a0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:do_strncpy_from_user lib/strncpy_from_user.c:41 [inline]
RIP: 0010:strncpy_from_user+0x151/0x2f0 lib/strncpy_from_user.c:130
Code: 74 1d 00 48 83 ed 08 bf 07 00 00 00 48 83 c3 08 48 89 ee e8 31 c3 =
17 fd 48 83 fd 07 0f 86 54 01 00 00 e8 c2 c0 17 fd 45 31 ff <49> 8b 04 =
1c 31 ff 44 89 fe 49 89 c6 e8 de c2 17 fd 45 85 ff 0f 84
RSP: 0018:ffa0000003867d28 EFLAGS: 00050246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffa051ded6
RDX: 0000000000000fe0 RSI: ff1100002ad22340 RDI: 0000000000000002
RBP: 0000000000000fe0 R08: 0000000000000000 R09: ff1100002ad22d78
R10: fffffbfff5337aba R11: ffffffffa99bd5d7 R12: 0000000020000080
R13: ff1100001e6dc420 R14: ffffffffa748b880 R15: 0000000000000000
 getname_flags fs/namei.c:150 [inline]
 getname_flags+0x113/0x610 fs/namei.c:129
 do_sys_openat2+0x46a/0x6e0 fs/open.c:1396
 do_sys_open+0xc7/0x150 fs/open.c:1417
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd691f9871d
RSP: 002b:00007fd690bcaba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd69215b058 RCX: 00007fd691f9871d
RDX: 0000000000105042 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007fd69200d425 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001ff R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd69215b064 R14: 00007fd69215b0f0 R15: 00007fd690bcad40
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/45:
 #0: ffffffffa7b1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire =
include/linux/rcupdate.h:337 [inline]
 #0: ffffffffa7b1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
 #0: ffffffffa7b1aea0 (rcu_read_lock){....}-{1:3}, at: =
debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6744
3 locks held by systemd-journal/222:
 #0: ff110000028be9b8 (&vma->vm_lock->lock){++++}-{4:4}, at: =
vma_start_read include/linux/mm.h:717 [inline]
 #0: ff110000028be9b8 (&vma->vm_lock->lock){++++}-{4:4}, at: =
lock_vma_under_rcu+0x141/0x800 mm/memory.c:6278
 #1: ff1100000a35e518 (sb_pagefaults){.+.+}-{0:0}, at: =
do_page_mkwrite+0x180/0x390 mm/memory.c:3176
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
1 lock held by journal-offline/12011:
 #0: ff1100000a360b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: =
do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
4 locks held by kworker/u20:2/233:
 #0: ff11000002258148 ((wq_completion)writeback){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3204 [inline]
 #0: ff11000002258148 ((wq_completion)writeback){+.+.}-{0:0}, at: =
process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3310
 #1: ffa0000003657d98 =
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffa0000003657d98 =
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: =
process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3310
 #2: ff1100000a35e0e0 (&type->s_umount_key#52){++++}-{4:4}, at: =
super_trylock_shared+0x21/0x100 fs/super.c:562
 #3: ff1100000a360b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: =
do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
2 locks held by in:imklog/328:
4 locks held by rs:main Q:Reg/329:
 #0: ff1100000b78bb38 (&f->f_pos_lock){+.+.}-{4:4}, at: =
fdget_pos+0x27d/0x390 fs/file.c:1191
 #1: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
ksys_write+0x122/0x240 fs/read_write.c:731
 #2: ff11000010ed2168 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: =
inode_lock include/linux/fs.h:818 [inline]
 #2: ff11000010ed2168 (&sb->s_type->i_mutex_key#7){++++}-{4:4}, at: =
ext4_buffered_write_iter+0xae/0x3c0 fs/ext4/file.c:294
 #3: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
2 locks held by agetty/374:
 #0: ff110000084b10a0 (&tty->ldisc_sem){++++}-{0:0}, at: =
tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffa00000035cb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: =
n_tty_read+0x44e/0x14c0 drivers/tty/n_tty.c:2211
3 locks held by syz-executor/408:
 #0: ff110000093d2b68 (&vma->vm_lock->lock){++++}-{4:4}, at: =
vma_start_read include/linux/mm.h:717 [inline]
 #0: ff110000093d2b68 (&vma->vm_lock->lock){++++}-{4:4}, at: =
lock_vma_under_rcu+0x141/0x800 mm/memory.c:6278
 #1: ff1100000a35e518 (sb_pagefaults){.+.+}-{0:0}, at: =
do_page_mkwrite+0x180/0x390 mm/memory.c:3176
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
7 locks held by kworker/2:5/1300:
 #0: ff11000001070948 ((wq_completion)events){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3204 [inline]
 #0: ff11000001070948 ((wq_completion)events){+.+.}-{0:0}, at: =
process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3310
 #1: ffa000001495fd98 =
((work_completion)(&(&ap->scsi_rescan_task)->work)){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffa000001495fd98 =
((work_completion)(&(&ap->scsi_rescan_task)->work)){+.+.}-{0:0}, at: =
process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3310
 #2: ff11000007d5c348 (&ap->scsi_scan_mutex){+.+.}-{4:4}, at: =
ata_scsi_dev_rescan+0x3c/0x430 drivers/ata/libata-scsi.c:4874
 #3: ff11000007ec6378 (&dev->mutex){....}-{4:4}, at: device_lock =
include/linux/device.h:1014 [inline]
 #3: ff11000007ec6378 (&dev->mutex){....}-{4:4}, at: =
scsi_rescan_device+0x27/0x340 drivers/scsi/scsi_scan.c:1691
 #4: ff11000007b4d468 (&q->limits_lock){+.+.}-{4:4}, at: =
queue_limits_start_update include/linux/blkdev.h:947 [inline]
 #4: ff11000007b4d468 (&q->limits_lock){+.+.}-{4:4}, at: =
sd_revalidate_disk+0x65f/0xab30 drivers/scsi/sd.c:3727
 #5: ff11000007b4ce28 (&q->q_usage_counter(io)){++++}-{0:0}, at: =
blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:213
 #6: ff11000007b4ce60 (&q->q_usage_counter(queue)){++++}-{0:0}, at: =
blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:213
3 locks held by syz.8.1221/10661:
1 lock held by syz.8.1221/10662:
 #0: ff11000006adb160 (&mm->mmap_lock){++++}-{4:4}, at: =
mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ff11000006adb160 (&mm->mmap_lock){++++}-{4:4}, at: =
get_mmap_lock_carefully mm/memory.c:6149 [inline]
 #0: ff11000006adb160 (&mm->mmap_lock){++++}-{4:4}, at: =
lock_mm_and_find_vma+0x35/0x720 mm/memory.c:6209
3 locks held by syz-executor/11583:
 #0: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
filename_create+0xf5/0x4b0 fs/namei.c:4073
 #1: ff11000037cec8a8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff11000037cec8a8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
filename_create+0x1ae/0x4b0 fs/namei.c:4080
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
3 locks held by syz-executor/11733:
 #0: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
filename_create+0xf5/0x4b0 fs/namei.c:4073
 #1: ff11000037cfb508 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff11000037cfb508 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
filename_create+0x1ae/0x4b0 fs/namei.c:4080
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
3 locks held by syz-executor/11746:
 #0: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
filename_create+0xf5/0x4b0 fs/namei.c:4073
 #1: ff110000296883f8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff110000296883f8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
filename_create+0x1ae/0x4b0 fs/namei.c:4080
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
3 locks held by syz-executor/11756:
 #0: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
filename_create+0xf5/0x4b0 fs/namei.c:4073
 #1: ff11000037cedc48 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff11000037cedc48 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
filename_create+0x1ae/0x4b0 fs/namei.c:4080
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
3 locks held by syz-executor/11936:
 #0: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
filename_create+0xf5/0x4b0 fs/namei.c:4073
 #1: ff11000037ced278 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff11000037ced278 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
filename_create+0x1ae/0x4b0 fs/namei.c:4080
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
3 locks held by syz-executor/11993:
 #0: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
filename_create+0xf5/0x4b0 fs/namei.c:4073
 #1: ff11000037ceefe8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff11000037ceefe8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
filename_create+0x1ae/0x4b0 fs/namei.c:4080
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
3 locks held by syz.3.1296/12021:
 #0: ff1100000a730148 (&vma->vm_lock->lock){++++}-{4:4}, at: =
vma_start_read include/linux/mm.h:717 [inline]
 #0: ff1100000a730148 (&vma->vm_lock->lock){++++}-{4:4}, at: =
lock_vma_under_rcu+0x141/0x800 mm/memory.c:6278
 #1: ff1100000a35e518 (sb_pagefaults){.+.+}-{0:0}, at: =
do_page_mkwrite+0x180/0x390 mm/memory.c:3176
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448
3 locks held by syz-executor/12025:
 #0: ff1100000a35e420 (sb_writers#3){.+.+}-{0:0}, at: =
filename_create+0xf5/0x4b0 fs/namei.c:4073
 #1: ff110000083a03f8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff110000083a03f8 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: =
filename_create+0x1ae/0x4b0 fs/namei.c:4080
 #2: ff1100000a362958 (jbd2_handle){++++}-{0:0}, at: =
start_this_handle+0xe3d/0x12e0 fs/jbd2/transaction.c:448

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

---------------
thanks,
Kun Hu=

