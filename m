Return-Path: <linux-fsdevel+bounces-38983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD8A0A833
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D87167303
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C941990DB;
	Sun, 12 Jan 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="eRvpiGiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5862556E;
	Sun, 12 Jan 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736677424; cv=none; b=gJccZPeGjXcYN+KdG3vpwYsUSzjxLoW1CtcgtYoZTVqt+3FMMBGT9V8njJDFWtdAgqHkPoO/GtyBqTesLKKa1keeBBkonmiDyCK8Cty8SykbaOQsOPxS6Ep/abCn54/XzApJIBv6RrLrLXN8MgcyzsZzpLnH2OQpZN3lUSmNTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736677424; c=relaxed/simple;
	bh=wYi35wzJiCz81xjhZ8GX5lGKRaz+VGB51aRPR4nOjmc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=dEqrOBYwvR3gb5iqJrdnn7/38eEw+TRj4Fy6l7dK1oRILeTanamvoehQwDPZoRsb2Ep/IAJcBHH5iEHYunMiuRd0Fbz4CHb4TM7EmpaPF38jRQTUdvGjEhm1uqrqpOP4abXYEG665mqhwtbXSITZDh9f2tFfjAZGLQfqlgognDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=eRvpiGiS; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736677388;
	bh=EerO6SsCA4lme9Y7Hgt6xPbS3SWoyGA1gEClowwZr34=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=eRvpiGiSmhwFMWqH6WCGfnKBkf+1NcTTTnXP7rJuMtSkgmBeTUGxf+Cprocsby2h4
	 hE8BUZHxAtMccg+GxX+LmVvfmyXEk/gJ+L14FEOBkQqpxEfxNokYbyTD6nusCsDM93
	 SezcZCeBDm/wnpduK+87J2846oYMxg63KPXSoCNQ=
X-QQ-mid: bizesmtpip4t1736677381teoqkax
X-QQ-Originating-IP: tXBrQ0CAGkB8SffGbE+GACDIqkNA1RW3PYrXbPWcJnQ=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 12 Jan 2025 18:23:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15213824778490648100
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
Subject: Bug: INFO_ task hung in bfs_lookup 
Message-Id: <5520441F-D311-45AB-8C05-4EB4B0FDF6B4@m.fudan.edu.cn>
Date: Sun, 12 Jan 2025 18:22:49 +0800
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
To: dmitri.vorobiev@gmail.com,
 tigran@veritas.com,
 akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk,
 jack@suse.cz
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MglA7JX7t2v3ikhwYnGyyVR6m69CdoAZH3svmPIU2XBdf567ayb8fwBO
	m03WyQlAuF/ED2HiLXEUzQkfZ657OUXZ/eoEqoMFXgGFq3oSR6amx5wzdheLmGZwn/s3z9z
	kYS1bAuhED1aDs3p1o5BoZ9vyweEjMOMf/yJFdc58SesQYZOQl6WT/knMyMDHgEW83qfXtn
	SWzWrSMoO085U39Km+sw7niQ76Nn11KmmgV8QmuXxbHLdSYzcndQW/pK66Yf04R28qhQEWb
	nkthRpaMycc+GrvGQ87EBFTIQGHQK+njgXTPEISgyLQj9AQ/q5jq1oziXTn+QrvbcTXrF5L
	HmTutssMoXgRxfTz/0nM2wGesLT75cp46nyh6xqEiq7mRfsCxvktFpeysoucjqOPri3tXTO
	9c76eTDkMCl243Tvbl8ZpU7eqdEYTchE4fUYaD/IkuK7wF4HVtPDyB813572aF13toOD0KN
	376z5OjsxBQx1d2sAcVIxaPT1zPHz61Q4VBFU2ZXsnif7z8/WrZcG4QDvEWUIAh5mtxrRM1
	Tz7Gu5suHCCpgK6vOj4cmqY7FlTBJoRg8VreSAdTF7cQCvI1dHbfXv6S4csQmfzxfDbDxkQ
	jRS06UDAIpUP6WPOqw+D3Dp8BJUIBQfw56vV3NoxUR7HIDhYK6K8QJ89dRKLpzmrb3Snr9j
	j8Or6C6HmLapua9/Hez+BQQW5gu/cKKx46J7P0JmKUg0S2lPuV8wE8Fur/fz+lRGU60pIKe
	ndIEx0cWatJ59iryJz8HjSY/UBvQlqLWicO+pqnQax3mPnxldiw/FJTNJ9hsTT6rFCkR/lX
	5+i6EbA51MZ3BYJOkOU3goADiogYg0oDcIMQgfElDRg5Hjcg31mPDPIfsY7zIj0Vxl/mA5u
	OIgPWxm6UxC9sct7IlnoR0jcEUxzPJooLABQPObBxt3az6apa4HSQ2B6zDr2d4wAhbtzfV0
	fVfMMAP9wXFVZJ0o6go9lo3k7ve2TLwyBIAEQlCqaIeVbDQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash (45s)
was triggered.

HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
git tree: upstream
Console output: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/45-INFO_%20tas=
k%20hung%20in%20bfs_lookup/log0
Kernel config: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/config.txt
C reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/45-INFO_%20tas=
k%20hung%20in%20bfs_lookup/14generated_program.c
Syzlang reproducer: =
https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/45-INFO_%20tas=
k%20hung%20in%20bfs_lookup/14_repro.txt

We first found the issue without a stable C and Syzlang reproducers, but =
later I tried multiple rounds of replication and got the C and Syzlang =
reproducers.

I suspect the issue may stem from resource contention or synchronization =
delays, as indicated by functions like __mutex_lock and schedule. There =
could also be potential locking challenges in directory lookup =
operations (bfs_lookup and lookup_slow) or issues arising from inode =
lock contention (inode_lock_shared). These may be contributing to the =
task being blocked.=20

Could you kindly help review these areas to narrow down the root cause? =
Your expertise would be greatly appreciated.

If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>


=3D=3D=3D=3D=3D=3D=3D
INFO: task syz.3.982:6564 blocked for more than 143 seconds.
      Tainted: G        W          6.13.0-rc6 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
task:syz.3.982       state:D stack:28336 pid:6564  tgid:6553  ppid:425   =
 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0xe60/0x4120 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0xd4/0x210 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0xf74/0x1eb0 kernel/locking/mutex.c:735
 bfs_lookup+0x151/0x2b0 fs/bfs/dir.c:136
 __lookup_slow+0x25b/0x490 fs/namei.c:1791
 lookup_slow fs/namei.c:1808 [inline]
 walk_component+0x345/0x5b0 fs/namei.c:2112
 lookup_last fs/namei.c:2610 [inline]
 path_lookupat.isra.0+0x180/0x560 fs/namei.c:2634
 do_o_path fs/namei.c:3958 [inline]
 path_openat+0x1a97/0x2970 fs/namei.c:3980
 do_filp_open+0x1fa/0x2f0 fs/namei.c:4014
 do_sys_openat2+0x641/0x6e0 fs/open.c:1402
 do_sys_open+0xc7/0x150 fs/open.c:1417
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f854ed7f71d
RSP: 002b:00007f854d9b1ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f854ef42058 RCX: 00007f854ed7f71d
RDX: 0000000000200000 RSI: 0000000020000300 RDI: ffffffffffffff9c
RBP: 00007f854edf4425 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f854ef42064 R14: 00007f854ef420f0 R15: 00007f854d9b1d40
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/45:
 #0: ffffffffb3b1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire =
include/linux/rcupdate.h:337 [inline]
 #0: ffffffffb3b1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
 #0: ffffffffb3b1aea0 (rcu_read_lock){....}-{1:3}, at: =
debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6744
1 lock held by kswapd0/82:
4 locks held by kworker/2:1H/115:
1 lock held by systemd-journal/223:
1 lock held by in:imklog/329:
4 locks held by syz.3.982/6554:
2 locks held by syz.3.982/6564:
 #0: ff11000010ed0668 (&type->i_mutex_dir_key#10){++++}-{4:4}, at: =
inode_lock_shared include/linux/fs.h:828 [inline]
 #0: ff11000010ed0668 (&type->i_mutex_dir_key#10){++++}-{4:4}, at: =
lookup_slow fs/namei.c:1807 [inline]
 #0: ff11000010ed0668 (&type->i_mutex_dir_key#10){++++}-{4:4}, at: =
walk_component+0x338/0x5b0 fs/namei.c:2112
 #1: ff11000008c158d8 (&info->bfs_lock){+.+.}-{4:4}, at: =
bfs_lookup+0x151/0x2b0 fs/bfs/dir.c:136

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

---------------
thanks,
Kun Hu=

