Return-Path: <linux-fsdevel+bounces-21491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B5904829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 03:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549161C21035
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803CD4A3F;
	Wed, 12 Jun 2024 01:10:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0CA21;
	Wed, 12 Jun 2024 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718154609; cv=none; b=A0nP1x0PgjqRmTQA2epvheORvL1wn6E9rKTbWZKg5jAacQQmGzg19Ih3Lqa3io+YYuM0jmtjW0X4jONHZDP0lREl8h59nBHQOf1Cy3fWTPYkuRiFdU0VWaCzP5lSayqEqCiKnr+03oReyYbbcydlfUFdXKdlfO9m+6x8Wv+pxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718154609; c=relaxed/simple;
	bh=m+CR5MWe+mNPqZhYL9ZiIzQcG51Ao1Xuqy9ZRZhLY1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yv6TFjx12U56V+p1uw6S0v27oxw1fjq8qNapG2ZTM3Vyr0nmCX39s0AByoF+y1SHa+2wfMoTLpqIYQfCjtVRa513hIG2YAcv46JbR88pBHk2/YM26EQiYc5v7SUUHmgk5XrAn/RNEJMgQjgbvLE9a7zZMEGsJqUWch/odfhuPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VzS6l1xWBzPqYx;
	Wed, 12 Jun 2024 09:06:39 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id DE854140257;
	Wed, 12 Jun 2024 09:10:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 09:10:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
Date: Wed, 12 Jun 2024 09:11:56 +0800
Message-ID: <20240612011156.2891254-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612011156.2891254-1-lihongbo22@huawei.com>
References: <20240612011156.2891254-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Here we use the hugetlbfs tracepoint to track the call stack. And
the output in trace is as follows:

```
touch-5307    [004] .....  1402.167607: hugetlbfs_alloc_inode: dev = (0,50), ino = 21380, dir = 16921, mode = 0100644
touch-5307    [004] .....  1402.167638: hugetlbfs_setattr: dev = (0,50), ino = 21380, name = testfile1, ia_valid = 131184, ia_mode = 0132434, ia_uid = 2863018275, ia_gid = 4294967295, old_size = 0, ia_size = 4064
truncate-5328    [003] .....  1436.031054: hugetlbfs_setattr: dev = (0,50), ino = 21380, name = testfile1, ia_valid = 8296, ia_mode = 0177777, ia_uid = 2862574544, ia_gid = 4294967295, old_size = 0, ia_size = 2097152
rm-5338    [004] .....  1484.426247: hugetlbfs_evict_inode: dev = (0,50), ino = 21380, i_mode = 0100644, i_size = 2097152, i_nlink = 0, seals = 1, i_blocks = 0
<idle>-0       [004] ..s1.  1484.446668: hugetlbfs_free_inode: dev = (0,50), ino = 21380, i_mode = 0100644, i_size = 2097152, i_nlink = 0, seals = 1, i_blocks = 0
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hugetlbfs/inode.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 412f295acebe..f3399c6a02ca 100644
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
@@ -686,6 +689,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
 {
 	struct resv_map *resv_map;
 
+	trace_hugetlbfs_evict_inode(inode);
 	remove_inode_hugepages(inode, 0, LLONG_MAX);
 
 	/*
@@ -813,8 +817,10 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
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
@@ -918,6 +924,9 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	inode_set_ctime_current(inode);
 out:
 	inode_unlock(inode);
+
+out_nolock:
+	trace_hugetlbfs_fallocate(inode, mode, offset, len, error);
 	return error;
 }
 
@@ -934,6 +943,12 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	trace_hugetlbfs_setattr(inode, dentry->d_name.len, dentry->d_name.name,
+			attr->ia_valid, attr->ia_mode,
+			from_kuid(&init_user_ns, attr->ia_uid),
+			from_kgid(&init_user_ns, attr->ia_gid),
+			inode->i_size, attr->ia_size);
+
 	if (ia_valid & ATTR_SIZE) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
@@ -1032,6 +1047,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 			break;
 		}
 		lockdep_annotate_inode_mutex_key(inode);
+		trace_hugetlbfs_alloc_inode(inode, dir, mode);
 	} else {
 		if (resv_map)
 			kref_put(&resv_map->refs, resv_map_release);
@@ -1274,6 +1290,7 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 static void hugetlbfs_free_inode(struct inode *inode)
 {
+	trace_hugetlbfs_free_inode(inode);
 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
 }
 
-- 
2.34.1


