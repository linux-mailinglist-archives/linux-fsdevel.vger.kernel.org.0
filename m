Return-Path: <linux-fsdevel+bounces-38982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BCA0A825
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00803A29D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538F192B84;
	Sun, 12 Jan 2025 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="D1o7u2/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0938B
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736676211; cv=none; b=dLlNnaYk2BvFVAas1pCkQYhA32CfbInEUId6NZ/y7Yut0xhWQ0m78LO0uUC9d6yMsmZz6pYBwBqZmmNXvYdEj0/wM0ecENaLyVI/XgWVXgSeT0FN5c+T8XHFS0S27aP9Dj78v27P+zhZfkHeBWuPbjG/toN0vu9BUm62HkjVJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736676211; c=relaxed/simple;
	bh=IqlQ4VmWCCHFsnBmCnhZRSbyUW9uWBRtOsu5Y95d3v0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=chwbCEP47TV9SU46SET7ZWonSdkdUCf/Kf4qbFg2RmzWoMcEPzDWx1/JgBu0iJUqi4ErW66v2jiB/uTycuf9HzB7BRaRlCi96vxnLMbMqaQVVwgeg0tol3evhLwuIwBNK9ZNAbZIqKQlqbSFUzaz7yz6uGUwlcHB3HD+asLrcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=D1o7u2/F; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736676045;
	bh=ODgUaz1vQWxIgCmObOJnDfjJn7oGv/c8D+9QwcR4A+M=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=D1o7u2/FL4DMcvaszIO5izTacjUGUbwqT0A39uz4k1AW9bTXLNnggOEZiEbrqAd03
	 Yavf4tw+qkWEo7Wdd0zQoI679fQpPXdL79lZeRB8SuHIsCdS0diBGfB+t1TbEct4cG
	 7nVLTINwZ7Gm6TCnundp2QYQ5BzVoPpzbwnS2C3o=
X-QQ-mid: bizesmtpip4t1736676036ticr75y
X-QQ-Originating-IP: Lgb0qzoXsj+PBdNxDoVuxy9/Y77FyzqWB8JAPK4nkZI=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 12 Jan 2025 18:00:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3028724103274193008
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
Subject: Bug: INFO_ task hung in lock_two_nondirectories
Message-Id: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
Date: Sun, 12 Jan 2025 18:00:24 +0800
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jack@suse.cz,
 brauner@kernel.org,
 viro@zeniv.linux.org.uk
To: jlayton@redhat.com,
 tytso@mit.edu,
 adilger.kernel@dilger.ca,
 david@fromorbit.com,
 bfields@redhat.com,
 viro@zeniv.linux.org.uk,
 christian.brauner@ubuntu.com,
 hch@lst.de
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OYRFB0RV71LzDFrCVB0eGyDr4ZNCzTVHEWLW4hrKtrDsUJJ4FoLrYabL
	MLoENmUMAxY4UAXGKorZHvcWSV7QOj/RVRDZ1t2G8+UDhudYpgxRHr7ZdiFvJTR/9IbJuTs
	b4f+BW1dZ1sRCTd03RVkCiV6TXKhHzJ01dCoaUIauDfi4dyecKajZ/J3y2DCtuhPl9XfQjG
	Lvbrl+W0OFdEtf8f/FmkB6A5HdtobQ95g3oNW4doHJhZxrOrQL1dZq7AUXKDYiHafYTRbBA
	Oe2VFZkJLu6mZ1E0FIR4F0gEpDnTOCPZecwKS1zOVWWxw06H74yAdq1cxzM/OQoa6tZoPcX
	dIwF2nSwjs6gDgDovzCx+VlPySV/5tjktc90DalKCC8dDI0nriE2QPeYqgEm7I2TudhFm9K
	dPHKMOhwgV9iKHDOdxxTzjzJS/SikrWB+CbnnZ2QQ+Tx0OTSYKD2EJuhb/Mw3pxuwAj1z+R
	CeKuAix+2rsSq1FjO531RpHqkLoLRhiljqdCxS86LEBaLh11zZ4T7ZjTmyLhnTP62IvuKkn
	j70ztMwuTTdnNMpm3QxdvFm0oUS73Lt6Zs49KtJC3t4MKsn602WJE3CQNhxVPC7XLRsHiWz
	RpRsQ/nvZdTtkAC6g8cHZVHabpxCghxLJpkBjY1nbXAYYnZI+3key6dAfJLegiJve+u9YfS
	uf4wPM2AdnPcUMhw45mkxAU+xE7/+SEF1yLp6rtoSpRZEYyj0/26e0UujYxv9w4n3/Otb+j
	40oF2+ATrOrrLzpaEViYxoNy4WGgzZ8Ms5uINjVIqBOOIUh4G0xryCqPUxK7BW2eD97WePM
	IENyJmM6fyP48KFhtk8hYhM5CDS/cO6TocQvwgwtnxMs1/KsK89i0wbckEmSh23KCJRrjIh
	wYAcXGxxs2a4XYVYewkbgD6y/vwUQv3fYbCYU2bRkhDXRHe4mlfCNZETA6TlepKhSXCSClY
	TNlb55Tt976mHH/5FD0aMD0Xc
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash (43s)
was triggered.

HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
git tree: upstream
Console output: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20tas=
k%20hung%20in%20lock_two_nondirectories/log0
Kernel config: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/config.txt
C reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20tas=
k%20hung%20in%20lock_two_nondirectories/12generated_program.c
Syzlang reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20tas=
k%20hung%20in%20lock_two_nondirectories/12_repro.txt

We first found the issue without a stable C and Syzlang reproducers, but =
later I tried multiple rounds of replication and got the C and Syzlang =
reproducers.

I suspect the issue may stem from resource contention or synchronization =
delays, as indicated by functions like lock_two_nondirectories and =
vfs_rename. There could also be potential deadlocks or inconsistencies =
in file system state management (e.g., sb_writers or inode locks) within =
the bcachefs subsystem. Additionally, interactions between lock_rename =
and concurrent rename operations might be contributing factors.

Could you kindly help review these areas to narrow down the root cause? =
Your expertise would be greatly appreciated.

If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>

INFO: task syz.0.12:1823 blocked for more than 143 seconds.
      Tainted: G        W          6.13.0-rc6 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
task:syz.0.12        state:D stack:25728 pid:1823  tgid:1714  ppid:442   =
 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe60/0x4120 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xd4/0x210 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0x551/0x1660 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1db/0x210 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:853 [inline]
 lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
 vfs_rename+0x14c7/0x2a20 fs/namei.c:5038
 do_renameat2+0xb81/0xc90 fs/namei.c:5224
 __do_sys_renameat2 fs/namei.c:5258 [inline]
 __se_sys_renameat2 fs/namei.c:5255 [inline]
 __x64_sys_renameat2+0xe4/0x120 fs/namei.c:5255
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fca967c071d
RSP: 002b:00007fca953f2ba8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007fca96983058 RCX: 00007fca967c071d
RDX: ffffffffffffff9c RSI: 0000000020000580 RDI: ffffffffffffff9c
RBP: 00007fca96835425 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200005c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fca96983064 R14: 00007fca969830f0 R15: 00007fca953f2d40
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/45:
 #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire =
include/linux/rcupdate.h:337 [inline]
 #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
 #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: =
debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6744
1 lock held by in:imklog/329:
5 locks held by syz.0.12/1715:
 #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: do_open =
fs/namei.c:3821 [inline]
 #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: =
path_openat+0x1577/0x2970 fs/namei.c:3987
 #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: =
inode_lock include/linux/fs.h:818 [inline]
 #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: =
do_truncate+0x131/0x200 fs/open.c:63
 #2: ff11000047780a38 (&c->snapshot_create_lock){.+.+}-{4:4}, at: =
bch2_truncate+0x145/0x260 fs/bcachefs/io_misc.c:292
 #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: =
srcu_lock_acquire include/linux/srcu.h:158 [inline]
 #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: =
srcu_read_lock include/linux/srcu.h:249 [inline]
 #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: =
__bch2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
 #4: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: =
bch2_btree_update_start+0xb18/0x2010 =
fs/bcachefs/btree_update_interior.c:1197
3 locks held by syz.0.12/1823:
 #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: =
do_renameat2+0x3ea/0xc90 fs/namei.c:5154
 #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: =
lock_rename fs/namei.c:3215 [inline]
 #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: =
lock_rename+0xa5/0xc0 fs/namei.c:3212
 #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at: =
inode_lock_nested include/linux/fs.h:853 [inline]
 #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at: =
lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
4 locks held by bch-reclaim/loo/1811:
 #0: ff110000477cb0a8 (&j->reclaim_lock){+.+.}-{4:4}, at: =
bch2_journal_reclaim_thread+0x101/0x560 =
fs/bcachefs/journal_reclaim.c:739
 #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: =
srcu_lock_acquire include/linux/srcu.h:158 [inline]
 #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: =
srcu_read_lock include/linux/srcu.h:249 [inline]
 #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: =
__bch2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
 #2: ff11000047784740 (&wb->flushing.lock){+.+.}-{4:4}, at: =
btree_write_buffer_flush_seq+0x69f/0xa40 =
fs/bcachefs/btree_write_buffer.c:516
 #3: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: =
bch2_btree_update_start+0xb18/0x2010 =
fs/bcachefs/btree_update_interior.c:1197
1 lock held by syz-executor/5484:
2 locks held by syz.1.1333/8755:
1 lock held by syz.7.1104/8876:
 #0: ffffffff9fb27ef8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: =
exp_funnel_lock+0x29f/0x3d0 kernel/rcu/tree_exp.h:297
2 locks held by syz.8.1367/8889:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

---------------
thanks,
Kun Hu=

