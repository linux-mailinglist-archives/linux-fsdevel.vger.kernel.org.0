Return-Path: <linux-fsdevel+bounces-30253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A398873A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DA9280E3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F671531D8;
	Fri, 27 Sep 2024 14:37:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F73101F2;
	Fri, 27 Sep 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447822; cv=none; b=mKVt7X/geGa/gcWgAhF9KW+b67vu36P0g0d21AXPVP2nyop20PvzzC3mJ6FPZFBTogou53UcVVQS6vD3hRGhenzU11VrHlB/NEP+sWl3P72vDrc9RtotQOt4xgP2HSXLuikbt5EWh6nL1ABYcBMbH2YVWS7VWhum2Z+ZaCnBR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447822; c=relaxed/simple;
	bh=4eh9ar949u2bCRSlNrO9WdmDOtUMw4mUbQ9nqWlwRhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN0Z+9BRUkfAFKP91o/GpbpfWWyXQtD6gPvJ47JVyQN6XheWgkLxVu0I+b/xQ3mZ/OsWWgoXp+6lXj9cxpAmgN66WWkjXtFmC23fnQ087M8ksrApOtsg4wYh9QJmTKqIPuT5sgdYMr72y5DD3s8J4yrF3vrX+FYIFMLkhwzOFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RAdYjc032580;
	Fri, 27 Sep 2024 14:36:46 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41um4xmu2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 27 Sep 2024 14:36:46 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 07:36:45 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 07:36:42 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <amir73il@gmail.com>
CC: <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V3] inotify: Fix possible deadlock in fsnotify_destroy_mark
Date: Fri, 27 Sep 2024 22:36:42 +0800
Message-ID: <20240927143642.2369508-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOQ4uxhrSSpPijzeuFWRZBrgZvEyk6aLK=q7fBz3rpiZcHZrvg@mail.gmail.com>
References: <CAOQ4uxhrSSpPijzeuFWRZBrgZvEyk6aLK=q7fBz3rpiZcHZrvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BGmCJNrjfJK-bQ1pkD7zzpeFcUK_rwXu
X-Authority-Analysis: v=2.4 cv=e+1USrp/ c=1 sm=1 tr=0 ts=66f6c2fe cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=qHX-XI4c9wpU7b2EyLMA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: BGmCJNrjfJK-bQ1pkD7zzpeFcUK_rwXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=826
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409270102

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

That any notification group needs to use NOFS allocations to be safe
against this race so we can just remove FSNOTIFY_GROUP_NOFS and
unconditionally do memalloc_nofs_save() in fsnotify_group_lock().

Reported-and-tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: remove FSNOTIFY_GROUP_NOFS in fsnotify_group_lock and unlock
V2 -> V3: remove nofs_marks_lock and FSNOTIFY_GROUP_NOFS

 fs/nfsd/filecache.c                |  2 +-
 fs/notify/dnotify/dnotify.c        |  3 +--
 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/group.c                  | 11 -----------
 include/linux/fsnotify_backend.h   | 10 +++-------
 5 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 24e8f1fbcebb..2bb8465474dc 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -764,7 +764,7 @@ nfsd_file_cache_init(void)
 	}
 
 	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
-							FSNOTIFY_GROUP_NOFS);
+							0);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 46440fbb8662..d5dbef7f5c95 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -406,8 +406,7 @@ static int __init dnotify_init(void)
 					  SLAB_PANIC|SLAB_ACCOUNT);
 	dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC|SLAB_ACCOUNT);
 
-	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops,
-					     FSNOTIFY_GROUP_NOFS);
+	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops, 0);
 	if (IS_ERR(dnotify_group))
 		panic("unable to allocate fsnotify group for dnotify\n");
 	dnotify_sysctl_init();
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 13454e5fd3fb..9644bc72e457 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1480,7 +1480,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	group = fsnotify_alloc_group(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER | FSNOTIFY_GROUP_NOFS);
+				     FSNOTIFY_GROUP_USER);
 	if (IS_ERR(group)) {
 		return PTR_ERR(group);
 	}
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 1de6631a3925..18446b7b0d49 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -115,7 +115,6 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 				const struct fsnotify_ops *ops,
 				int flags, gfp_t gfp)
 {
-	static struct lock_class_key nofs_marks_lock;
 	struct fsnotify_group *group;
 
 	group = kzalloc(sizeof(struct fsnotify_group), gfp);
@@ -136,16 +135,6 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 
 	group->ops = ops;
 	group->flags = flags;
-	/*
-	 * For most backends, eviction of inode with a mark is not expected,
-	 * because marks hold a refcount on the inode against eviction.
-	 *
-	 * Use a different lockdep class for groups that support evictable
-	 * inode marks, because with evictable marks, mark_mutex is NOT
-	 * fs-reclaim safe - the mutex is taken when evicting inodes.
-	 */
-	if (flags & FSNOTIFY_GROUP_NOFS)
-		lockdep_set_class(&group->mark_mutex, &nofs_marks_lock);
 
 	return group;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8be029bc50b1..3ecf7768e577 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -217,7 +217,6 @@ struct fsnotify_group {
 
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
-#define FSNOTIFY_GROUP_NOFS	0x04 /* group lock is not direct reclaim safe */
 	int flags;
 	unsigned int owner_flags;	/* stored flags of mark_mutex owner */
 
@@ -268,22 +267,19 @@ struct fsnotify_group {
 static inline void fsnotify_group_lock(struct fsnotify_group *group)
 {
 	mutex_lock(&group->mark_mutex);
-	if (group->flags & FSNOTIFY_GROUP_NOFS)
-		group->owner_flags = memalloc_nofs_save();
+	group->owner_flags = memalloc_nofs_save();
 }
 
 static inline void fsnotify_group_unlock(struct fsnotify_group *group)
 {
-	if (group->flags & FSNOTIFY_GROUP_NOFS)
-		memalloc_nofs_restore(group->owner_flags);
+	memalloc_nofs_restore(group->owner_flags);
 	mutex_unlock(&group->mark_mutex);
 }
 
 static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
 {
 	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
-	if (group->flags & FSNOTIFY_GROUP_NOFS)
-		WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
+	WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
 }
 
 /* When calling fsnotify tell it if the data is a path or inode */
-- 
2.43.0


