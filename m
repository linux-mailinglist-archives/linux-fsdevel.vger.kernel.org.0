Return-Path: <linux-fsdevel+bounces-23088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C4926DDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 05:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B161F264F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 03:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D821D1BC23;
	Thu,  4 Jul 2024 03:03:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909B19BA6;
	Thu,  4 Jul 2024 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062214; cv=none; b=rnM3qpElqBmKA8SZwzTZ15iKlqsJCK0cevA2wixwnK5Q96en0Txh7bNOv5wJjhgFTvPb7ZkUV9LzqwmRJGcPQdGTex2us5nhDRK6wogGNMOCs1AXDTgOphuoRvYj2LCDpBOI6esADEXJokc1+zOBLXRKeGpaGw8B1ZIRJ7yGkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062214; c=relaxed/simple;
	bh=esHgzINIwY5b48LkCq1djgQMtbZlFycJp6vzXsGR/6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeTk14hGRffp13lqZWqodSWesBvHuyDRfTBaUHQB9g0nBCIiY2ZbP1b0isbOirgf2zCqht8Get1CNoTrHGK94nX61xbLAoYTCiMW/oKaRI8DG3POYTZQmUrFx1obS6MJ0OJYhgvvGS93BcBQR0bgjZBQbubjiKljOA0J9xTW6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WF1b0689Vz1yv4x;
	Thu,  4 Jul 2024 10:59:40 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 503501402CD;
	Thu,  4 Jul 2024 11:03:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 11:03:29 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>
CC: <linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v2 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
Date: Thu, 4 Jul 2024 11:07:04 +0800
Message-ID: <20240704030704.2289667-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704030704.2289667-1-lihongbo22@huawei.com>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Here we use the hugetlbfs tracepoint to track the call stack. And
the output in trace is as follows:

```
touch-5250    [002] .....   123.557640: hugetlbfs_alloc_inode: dev = (0,49), ino = 29897, dir = 24079, mode = 0100644
touch-5250    [002] .....   123.557650: hugetlbfs_setattr: dev = (0,49), ino = 29897, name = test1, ia_valid = 131184, ia_mode = 036720, ia_uid = 2544251907, ia_gid = 65534, old_size = 0, ia_size = 4064
truncate-5251    [002] .....   142.939424: hugetlbfs_setattr: dev = (0,49), ino = 29897, name = test1, ia_valid = 8296, ia_mode = 00, ia_uid = 0, ia_gid = 0, old_size = 0, ia_size = 2097152
rm-5273    [002] .....   412.618383: hugetlbfs_evict_inode: dev = (0,49), ino = 29897, i_mode = 0100644, i_size = 2097152, i_nlink = 0, seals = 1, i_blocks = 0
<idle>-0       [002] ..s1.   412.634518: hugetlbfs_free_inode: dev = (0,49), ino = 29897, i_mode = 0100644, i_size = 2097152, i_nlink = 0, seals = 1, i_blocks = 0
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/hugetlbfs/inode.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 412f295acebe..2e826bbcb6ed 100644
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
 
@@ -934,6 +943,8 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 	if (error)
 		return error;
 
+	trace_hugetlbfs_setattr(inode, dentry, attr);
+
 	if (ia_valid & ATTR_SIZE) {
 		loff_t oldsize = inode->i_size;
 		loff_t newsize = attr->ia_size;
@@ -1032,6 +1043,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 			break;
 		}
 		lockdep_annotate_inode_mutex_key(inode);
+		trace_hugetlbfs_alloc_inode(inode, dir, mode);
 	} else {
 		if (resv_map)
 			kref_put(&resv_map->refs, resv_map_release);
@@ -1274,6 +1286,7 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 static void hugetlbfs_free_inode(struct inode *inode)
 {
+	trace_hugetlbfs_free_inode(inode);
 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
 }
 
-- 
2.34.1


