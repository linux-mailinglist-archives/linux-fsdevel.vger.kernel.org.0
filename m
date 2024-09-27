Return-Path: <linux-fsdevel+bounces-30235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432698811F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADDE1C224BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026E18A6B4;
	Fri, 27 Sep 2024 09:12:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1C157490;
	Fri, 27 Sep 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428373; cv=none; b=AzVVfIWzeb+xJEw/SVlOnLFSlUfeAlXhemGOCpMHuLkqtgp7koxIoI+szwxdNJ4AAWe4Rz3Ugu5TOUOfGQVlR+koIbS/U2jWtiyHKkZfqpIhpIC9JuWVnF8To9VmWteE8Z0dhnLWkxRx9g5bscjidtiJaTItiQEt/3aSkD/5i6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428373; c=relaxed/simple;
	bh=T6H/yeWzGi/gIx84mGsW1qk/tZdu30/9GsfI8bpEK3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jY8OsISK3qSoUd92oGPEAGwh72UpYueoy6VIM6ujFeTHo5RL+peZX/9f2+Wd8n5y6J5HK6wp+Yie7rR4nWTlZrqxprfpo+YlLpxSruBzBIRwHHmlY5uAGpcFI5PWNZeF3iKfcPMm1Ao+MeuCK3+shyP2728FV5jpFEQsNxEuzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5bHPg000550;
	Fri, 27 Sep 2024 02:12:35 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41umbvvgy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 27 Sep 2024 02:12:34 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 02:12:33 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 02:12:31 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
CC: <amir73il@gmail.com>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <phillip@squashfs.org.uk>,
        <squashfs-devel@lists.sourceforge.net>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] inotify: Fix possible deadlock in fsnotify_destroy_mark
Date: Fri, 27 Sep 2024 17:12:31 +0800
Message-ID: <20240927091231.360334-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ae63710620417f67@google.com>
References: <000000000000ae63710620417f67@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TKoXSEla c=1 sm=1 tr=0 ts=66f67702 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=hTKf5CPcikx21O5q8QUA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ZAcY3JOD7EgS7gK253xaOHb3FU99_dT1
X-Proofpoint-GUID: ZAcY3JOD7EgS7gK253xaOHb3FU99_dT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=908 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409270064

[Syzbot reported]
WARNING: possible circular locking dependency detected
6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0 Not tainted
------------------------------------------------------
kswapd0/78 is trying to acquire lock:
ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
ffff88801b8d8930 (&group->mark_mutex){+.+.}-{3:3}, at: fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578

but task is already holding lock:
ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
ffffffff8ea2fd60 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __fs_reclaim_acquire mm/page_alloc.c:3818 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3832
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3939 [inline]
       slab_alloc_node mm/slub.c:4017 [inline]
       kmem_cache_alloc_noprof+0x3d/0x2a0 mm/slub.c:4044
       inotify_new_watch fs/notify/inotify/inotify_user.c:599 [inline]
       inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
       __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inline]
       __se_sys_inotify_add_watch+0x72e/0x1070 fs/notify/inotify/inotify_user.c:729
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&group->mark_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       fsnotify_group_lock include/linux/fsnotify_backend.h:270 [inline]
       fsnotify_destroy_mark+0x38/0x3c0 fs/notify/mark.c:578
       fsnotify_destroy_marks+0x14a/0x660 fs/notify/mark.c:934
       fsnotify_inoderemove include/linux/fsnotify.h:264 [inline]
       dentry_unlink_inode+0x2e0/0x430 fs/dcache.c:403
       __dentry_kill+0x20d/0x630 fs/dcache.c:610
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1055
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1082
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1163
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4815
       shrink_many mm/vmscan.c:4876 [inline]
       lru_gen_shrink_node mm/vmscan.c:4954 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
       kswapd_shrink_node mm/vmscan.c:6762 [inline]
       balance_pgdat mm/vmscan.c:6954 [inline]
       kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&group->mark_mutex);
                               lock(fs_reclaim);
  lock(&group->mark_mutex);

 *** DEADLOCK ***

[Analysis] 
The inotify_new_watch() call passes through GFP_KERNEL, use memalloc_nofs_save/
memalloc_nofs_restore to make sure we don't end up with the fs reclaim dependency.

Reported-and-tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/notify/inotify/inotify_user.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index c7e451d5bd51..70b77b6186a6 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -643,8 +643,13 @@ static int inotify_update_watch(struct fsnotify_group *group, struct inode *inod
 	/* try to update and existing watch with the new arg */
 	ret = inotify_update_existing_watch(group, inode, arg);
 	/* no mark present, try to add a new one */
-	if (ret == -ENOENT)
+	if (ret == -ENOENT) {
+		unsigned int nofs_flag;
+
+		nofs_flag = memalloc_nofs_save();
 		ret = inotify_new_watch(group, inode, arg);
+		memalloc_nofs_restore(nofs_flag);
+	}
 	fsnotify_group_unlock(group);
 
 	return ret;
-- 
2.43.0


