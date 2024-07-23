Return-Path: <linux-fsdevel+bounces-24107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD306939888
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 05:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3DC1C21296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC013BC0D;
	Tue, 23 Jul 2024 03:03:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1C132124;
	Tue, 23 Jul 2024 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703818; cv=none; b=cQzv3PnMGlbnbRUqDOa44+t/xmxzbG7RTatd33Aon0ocG7hiXnX76zFmk60Eq8bJV1T4GoW6ICcUx33cWaU1koMP/54RjHJ9g1deJoYbuRspCeDMgrGaig9X4klqaRAgs96YO1FGkpmhQZE3StI8X3m3ncmuqTKpL7dKG9ZMOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703818; c=relaxed/simple;
	bh=TZqnH3dzjQFLTJwoZm7ylZhpgV7pZnLxerHwutuXd2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHSVQSXAsG1Jbudb2aBSCipdVahfF5sSQ7KUp9/LFVbpYgdXAxKLaqYtuJ6Dv0nM0V0Ur9msbgquGZxDhjX/HoyOIEjHl/OEb5kG91geUg9mxxB5JP5PtuYIQJAk5c0uXV5JL8L9la+cElw3DvFnxE8xBAnUmToqkgxLA6vAi1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WShkg26Wvz20lWB;
	Tue, 23 Jul 2024 11:01:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B548318001B;
	Tue, 23 Jul 2024 11:03:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 23 Jul
 2024 11:03:28 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<david@fromorbit.com>
CC: <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH v3 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
Date: Tue, 23 Jul 2024 11:08:34 +0800
Message-ID: <20240723030834.213012-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723030834.213012-1-lihongbo22@huawei.com>
References: <20240723030834.213012-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Here we use the hugetlbfs tracepoint to track the call stack. And
the output in trace is as follows:

```
   touch-5265    [005] .....    43.246550: hugetlbfs_alloc_inode: dev 0,51 ino 24621 dir 21959 mode 0100644
   touch-5265    [005] .....    43.246638: hugetlbfs_setattr: dev 0,51 ino 24621 name testfile valid 0x20070 mode 0177777 old_size 0 size -51622648042749952
truncate-5266    [005] .....    45.590890: hugetlbfs_setattr: dev 0,51 ino 24621 name testfile valid 0x2068 mode 00 old_size 0 size 2097152
rm-5273    [007] .....   110.052783: hugetlbfs_evict_inode: dev 0,51 ino 24621 mode 0100644 size 2097152 nlink 0 seals 1 blocks 0
  <idle>-0       [007] ..s1.   110.059441: hugetlbfs_free_inode: dev 0,51 ino 24621 mode 0100644 size 2097152 nlink 0 seals 1 blocks 0
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hugetlbfs/inode.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..1689c01a11a0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -39,6 +39,9 @@
 #include <linux/uaccess.h>
 #include <linux/sched/mm.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/hugetlbfs.h>
+
 static const struct address_space_operations hugetlbfs_aops;
 static const struct file_operations hugetlbfs_file_operations;
 static const struct inode_operations hugetlbfs_dir_inode_operations;
@@ -687,6 +690,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
 {
 	struct resv_map *resv_map;
 
+	trace_hugetlbfs_evict_inode(inode);
 	remove_inode_hugepages(inode, 0, LLONG_MAX);
 
 	/*
@@ -814,8 +818,10 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
-		return hugetlbfs_punch_hole(inode, offset, len);
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		error = hugetlbfs_punch_hole(inode, offset, len);
+		goto out_nolock;
+	}
 
 	/*
 	 * Default preallocate case.
@@ -919,6 +925,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	inode_set_ctime_current(inode);
 out:
 	inode_unlock(inode);
+
+out_nolock:
+	trace_hugetlbfs_fallocate(inode, mode, offset, len, error);
 	return error;
 }
 
@@ -935,6 +944,8 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	trace_hugetlbfs_setattr(inode, dentry, attr);
+
 	if (ia_valid & ATTR_SIZE) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
@@ -1033,6 +1044,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 			break;
 		}
 		lockdep_annotate_inode_mutex_key(inode);
+		trace_hugetlbfs_alloc_inode(inode, dir, mode);
 	} else {
 		if (resv_map)
 			kref_put(&resv_map->refs, resv_map_release);
@@ -1272,6 +1284,7 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 static void hugetlbfs_free_inode(struct inode *inode)
 {
+	trace_hugetlbfs_free_inode(inode);
 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
 }
 
-- 
2.34.1


