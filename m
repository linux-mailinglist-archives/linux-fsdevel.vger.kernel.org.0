Return-Path: <linux-fsdevel+bounces-6768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB981C4A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 06:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7621C24E99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 05:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA0C127;
	Fri, 22 Dec 2023 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="bCaPW0vr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F167BE47;
	Fri, 22 Dec 2023 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM4p7bs023424;
	Fri, 22 Dec 2023 05:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=MkQLTwziMP5bs/YlFfIaESP6Dw0XXo1pi3l9YMGqiiI=; b=
	bCaPW0vr4zxLWj0PXbxM13gGF7rY77pL0JzT8qGGeTMmeqbxHZ9f7ttLI/xuFPJM
	38zNirachpIPzvDeSV4Es+vLFrS/foObBM5DSdDQmG92FznxDWF4Iu4PkeoU9WxZ
	rVRNYanU8UllGhygGco4+6FbJe0uHYlbaZUAH9o2IR6AZ6IeNNLtG70x/wm1HVbH
	Czky8v2Aq57BV+hMI00xzkAusu97Y4+Lp19avOxvjCFCqtZc/VC/K0jQnpgTiKG1
	OnKmjXBr8ZwY20eM+n8Ic1NkU72gUO9pFfy6Zozq7G5psJi3VFdz3vz/1fbpIJLP
	onDOpyeL7P84jiVry0GRsQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v12v5yeyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 22 Dec 2023 05:26:49 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 21:26:54 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 21:26:53 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+83693dbba860b4f2e549@syzkaller.appspotmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH arm64] reiserfs: fix deadlock in chmod_common
Date: Fri, 22 Dec 2023 13:26:45 +0800
Message-ID: <20231222052645.2884576-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000879f66060cfd35e6@google.com>
References: <000000000000879f66060cfd35e6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uHnhBU3fiiTwLcQ28yqoG8SWEm5rtPHE
X-Proofpoint-GUID: uHnhBU3fiiTwLcQ28yqoG8SWEm5rtPHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=748
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220035

[Syz report]
syz-executor240/6153 is trying to acquire lock:
ffff0000dc6a3e80 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
ffff0000dc6a3e80 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: chmod_common+0x17c/0x418 fs/open.c:637

but task is already holding lock:
ffff0000d5dda418 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:404

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#8){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1635 [inline]
       sb_start_write+0x60/0x2ec include/linux/fs.h:1710
       mnt_want_write_file+0x64/0x1e8 fs/namespace.c:448
       reiserfs_ioctl+0x188/0x42c fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #1
 (&sbi->lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x128/0x45c fs/reiserfs/namei.c:364
       __lookup_slow+0x250/0x374 fs/namei.c:1694
       lookup_one_len+0x178/0x28c fs/namei.c:2746
       reiserfs_lookup_privroot+0x8c/0x184 fs/reiserfs/xattr.c:977
       reiserfs_fill_super+0x15b4/0x2028 fs/reiserfs/super.c:2192
       mount_bdev+0x1e8/0x2b4 fs/super.c:1650
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
       vfs_get_tree+0x90/0x288 fs/super.c:1771
       do_new_mount+0x25c/0x8c8 fs/namespace.c:3337
       path_mount+0x590/0xe04 fs/namespace.c:3664
       do_mount fs/namespace.c:3677 [inline]
       __do_sys_mount fs/namespace.c:3886 [inline]
       __se_sys_mount fs/namespace.c:3863 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3863
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:802 [inline]
       chmod_common+0x17c/0x418 fs/open.c:637
       vfs_fchmod fs/open.c:659 [inline]
       __do_sys_fchmod fs/open.c:668 [inline]
       __se_sys_fchmod fs/open.c:662 [inline]
       __arm64_sys_fchmod+0xe0/0x150 fs/open.c:662
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#6 --> &sbi->lock --> sb_writers#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#8);
                               lock(&sbi->lock);
                               lock(sb_writers#8);
  lock(&type->i_mutex_dir_key#6);

 *** DEADLOCK ***

[Analysis]
The deadlock of this issue is caused by the following two paths:
1. reiserfs_ioctl()
   lock(&sbi->lock);
   lock(sb_writers#8);

2. chmod_common()
   rlock(sb_writers#8);
   lock(&type->i_mutex_dir_key#6);

[Fix]
Solution: Reorder lock holding order.

Reported-and-tested-by: syzbot+83693dbba860b4f2e549@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/reiserfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index dd33f8cc6eda..cf219a998a89 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -100,7 +100,9 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			err = -EPERM;
 			break;
 		}
+		reiserfs_write_unlock(inode->i_sb);
 		err = mnt_want_write_file(filp);
+		reiserfs_write_lock(inode->i_sb);
 		if (err)
 			break;
 		if (get_user(inode->i_generation, (int __user *)arg)) {
-- 
2.43.0


