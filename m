Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB513BAF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAOI2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:34 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:55797 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgAOI23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:29 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200115082825epoutp0238abbd0fb18ffe400b1313523fa48202~qAhROAyFR2048120481epoutp02z
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200115082825epoutp0238abbd0fb18ffe400b1313523fa48202~qAhROAyFR2048120481epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579076905;
        bh=CVUXmbB24BmLbWoNrk2fifv2H0w4HmCTgbCkeN4nerQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+rOR8DgwBfJ3X3KLVFDcXlb0nZ0EPWT9mGLVF/RLgAaBbEKSYFgWRHHxJQEZsNzR
         TIdImjBi9ZFNvnQIWwg1XLSHybSz6UBcXjO9KNChF48O4NVprERMydFIm/a7mUBS+r
         bJx0mkvkQUWaGGIoFrMoQAqMoJnjAiYFJTkcaivI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200115082825epcas1p3f00422c89cc571964a556a0d7bc4f443~qAhQ0Ywjq0348603486epcas1p3e;
        Wed, 15 Jan 2020 08:28:25 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47yL7X0nlDzMqYkk; Wed, 15 Jan
        2020 08:28:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.96.48019.72DCE1E5; Wed, 15 Jan 2020 17:28:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200115082823epcas1p27ec5ff6d384f148d826529f573173b04~qAhPU54s11766717667epcas1p2G;
        Wed, 15 Jan 2020 08:28:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200115082823epsmtrp14280b22c7e1dec6d88d7409e4d50056a~qAhPTu4bj0486204862epsmtrp1B;
        Wed, 15 Jan 2020 08:28:23 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-7e-5e1ecd278bce
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.4A.10238.72DCE1E5; Wed, 15 Jan 2020 17:28:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115082823epsmtip127d6ae275a468f076b9a422f7165eca8~qAhPFogxe0089400894epsmtip1j;
        Wed, 15 Jan 2020 08:28:23 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        arnd@arndb.de, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v10 08/14] exfat: add exfat cache
Date:   Wed, 15 Jan 2020 17:24:41 +0900
Message-Id: <20200115082447.19520-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115082447.19520-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmnq7GWbk4g3VLmCz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9qgcm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
        MwNDXUNLC3MlhbzE3FRbJRefAF23zByg85QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
        BSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZ+57pFnx1q5h0bxtrA+NUyy5GTg4JAROJ
        3ttz2UBsIYEdjBJP7pZD2J8YJX4+04awvzFK9C0wgKn/+WE5SxcjF1B8L6PE0btPWOAatp+X
        62Lk4GAT0Jb4s0UUJCwiYC+xefYBsHpmgYOMEm8uzGUHqREWMJT48EcTpIZFQFViy50lYDfw
        CthIbL7axQqxS15i9YYDzCA2p4CtxJEtl9kh4gfYJBb/dgMZIyHgIjHxKS9EWFji1fEtUCVS
        Ei/729ghSqolPu5nhgh3MEq8+G4LYRtL3Fy/gRWkhFlAU2L9Ln2IsKLEzt9zGUFsZgE+iXdf
        e1ghpvBKdLQJQZSoSvRdOswEYUtLdLV/gFrqIbFz+WN2SHBMYJSY+DdwAqPcLIQFCxgZVzGK
        pRYU56anFhsWmCBH1CZGcLLTstjBuOeczyFGAQ5GJR5ehTuycUKsiWXFlbmHGCU4mJVEeE/O
        AArxpiRWVqUW5ccXleakFh9iNAWG4kRmKdHkfGAiziuJNzQ1MjY2tjAxMzczNVYS53VdIBcn
        JJCeWJKanZpakFoE08fEwSnVwLi6u+2R57Og2X1Rl3u1y2SVsm8sdPpafvquNKN8aUbDgWKX
        bg3ebbNiI/4fPllReoiraI7tnLTcyyfnnFA+eOrRvSjXwN7VB/hfuouxXrGOq7JjO2HPZK0S
        1aK6cs6q5Zbhn68x/pGwf+C24mPnu/jghxMdFssuU/w6eeIlKY7v9wI5szh1U5VYijMSDbWY
        i4oTAb21k6WMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnK76Wbk4gy2zJSz+TjrGbtG8eD2b
        xcrVR5ksrt+9xWyxZ+9JFovLu+awWfyYXm8x8fRvJost/46wWlx6/4HFgcvj969JjB47Z91l
        99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA9igum5TUnMyy1CJ9uwSujH3PdAu+ulVMureN
        tYFxqmUXIyeHhICJxM8Py1lAbCGB3YwSTz5zQsSlJY6dOMPcxcgBZAtLHD5cDFHygVHi+u5U
        kDCbgLbEny2iIGERAUeJ3l2HgaZwcTALnGaU6N74kAmkRljAUOLDH02QGhYBVYktd5awgdi8
        AjYSm692sUJskpdYveEAM4jNKWArcWTLZXaIVTYS056cZJrAyLeAkWEVo2RqQXFuem6xYYFh
        Xmq5XnFibnFpXrpecn7uJkZwcGpp7mC8vCT+EKMAB6MSD6/CHdk4IdbEsuLK3EOMEhzMSiK8
        J2cAhXhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamDUeB38
        7Wf6/rRv7AtrRZacmXhQbv/NfV5zGH9MFr3W6X3MZOXBRWtq3swMbU5a3iFivZE/o9F32uX8
        1rhZnxY/cnG4fCu2vUHm4Na8VcKTjzrxuJ3V7HMyn3mkq49p2Ra2Gs/6/k+nrDOXT4qZ1FRh
        +iGQ+1lv+6u+V/X1041nTMlXmJT+yC5IiaU4I9FQi7moOBEAi0w6tUoCAAA=
X-CMS-MailID: 20200115082823epcas1p27ec5ff6d384f148d826529f573173b04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200115082823epcas1p27ec5ff6d384f148d826529f573173b04
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
        <CGME20200115082823epcas1p27ec5ff6d384f148d826529f573173b04@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of exfat cache.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/cache.c | 325 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100644 fs/exfat/cache.c

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
new file mode 100644
index 000000000000..03d0824fc368
--- /dev/null
+++ b/fs/exfat/cache.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  linux/fs/fat/cache.c
+ *
+ *  Written 1992,1993 by Werner Almesberger
+ *
+ *  Mar 1999. AV. Changed cache, so that it uses the starting cluster instead
+ *	of inode number.
+ *  May 1999. AV. Fixed the bogosity with FAT32 (read "FAT28"). Fscking lusers.
+ *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+#include <linux/buffer_head.h>
+
+#include "exfat_raw.h"
+#include "exfat_fs.h"
+
+#define EXFAT_CACHE_VALID	0
+#define EXFAT_MAX_CACHE		16
+
+struct exfat_cache {
+	struct list_head cache_list;
+	unsigned int nr_contig;	/* number of contiguous clusters */
+	unsigned int fcluster;	/* cluster number in the file. */
+	unsigned int dcluster;	/* cluster number on disk. */
+};
+
+struct exfat_cache_id {
+	unsigned int id;
+	unsigned int nr_contig;
+	unsigned int fcluster;
+	unsigned int dcluster;
+};
+
+static struct kmem_cache *exfat_cachep;
+
+static void exfat_cache_init_once(void *c)
+{
+	struct exfat_cache *cache = (struct exfat_cache *)c;
+
+	INIT_LIST_HEAD(&cache->cache_list);
+}
+
+int exfat_cache_init(void)
+{
+	exfat_cachep = kmem_cache_create("exfat_cache",
+				sizeof(struct exfat_cache),
+				0, SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+				exfat_cache_init_once);
+	if (!exfat_cachep)
+		return -ENOMEM;
+	return 0;
+}
+
+void exfat_cache_shutdown(void)
+{
+	if (!exfat_cachep)
+		return;
+	kmem_cache_destroy(exfat_cachep);
+}
+
+void exfat_cache_init_inode(struct inode *inode)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
+	spin_lock_init(&ei->cache_lru_lock);
+	ei->nr_caches = 0;
+	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
+	INIT_LIST_HEAD(&ei->cache_lru);
+}
+
+static inline struct exfat_cache *exfat_cache_alloc(void)
+{
+	return kmem_cache_alloc(exfat_cachep, GFP_NOFS);
+}
+
+static inline void exfat_cache_free(struct exfat_cache *cache)
+{
+	WARN_ON(!list_empty(&cache->cache_list));
+	kmem_cache_free(exfat_cachep, cache);
+}
+
+static inline void exfat_cache_update_lru(struct inode *inode,
+		struct exfat_cache *cache)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
+	if (ei->cache_lru.next != &cache->cache_list)
+		list_move(&cache->cache_list, &ei->cache_lru);
+}
+
+static unsigned int exfat_cache_lookup(struct inode *inode,
+		unsigned int fclus, struct exfat_cache_id *cid,
+		unsigned int *cached_fclus, unsigned int *cached_dclus)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	static struct exfat_cache nohit = { .fcluster = 0, };
+	struct exfat_cache *hit = &nohit, *p;
+	unsigned int offset = EXFAT_EOF_CLUSTER;
+
+	spin_lock(&ei->cache_lru_lock);
+	list_for_each_entry(p, &ei->cache_lru, cache_list) {
+		/* Find the cache of "fclus" or nearest cache. */
+		if (p->fcluster <= fclus && hit->fcluster < p->fcluster) {
+			hit = p;
+			if (hit->fcluster + hit->nr_contig < fclus) {
+				offset = hit->nr_contig;
+			} else {
+				offset = fclus - hit->fcluster;
+				break;
+			}
+		}
+	}
+	if (hit != &nohit) {
+		exfat_cache_update_lru(inode, hit);
+
+		cid->id = ei->cache_valid_id;
+		cid->nr_contig = hit->nr_contig;
+		cid->fcluster = hit->fcluster;
+		cid->dcluster = hit->dcluster;
+		*cached_fclus = cid->fcluster + offset;
+		*cached_dclus = cid->dcluster + offset;
+	}
+	spin_unlock(&ei->cache_lru_lock);
+
+	return offset;
+}
+
+static struct exfat_cache *exfat_cache_merge(struct inode *inode,
+		struct exfat_cache_id *new)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_cache *p;
+
+	list_for_each_entry(p, &ei->cache_lru, cache_list) {
+		/* Find the same part as "new" in cluster-chain. */
+		if (p->fcluster == new->fcluster) {
+			if (new->nr_contig > p->nr_contig)
+				p->nr_contig = new->nr_contig;
+			return p;
+		}
+	}
+	return NULL;
+}
+
+static void exfat_cache_add(struct inode *inode,
+		struct exfat_cache_id *new)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_cache *cache, *tmp;
+
+	if (new->fcluster == EXFAT_EOF_CLUSTER) /* dummy cache */
+		return;
+
+	spin_lock(&ei->cache_lru_lock);
+	if (new->id != EXFAT_CACHE_VALID &&
+	    new->id != ei->cache_valid_id)
+		goto unlock;	/* this cache was invalidated */
+
+	cache = exfat_cache_merge(inode, new);
+	if (cache == NULL) {
+		if (ei->nr_caches < EXFAT_MAX_CACHE) {
+			ei->nr_caches++;
+			spin_unlock(&ei->cache_lru_lock);
+
+			tmp = exfat_cache_alloc();
+			if (!tmp) {
+				spin_lock(&ei->cache_lru_lock);
+				ei->nr_caches--;
+				spin_unlock(&ei->cache_lru_lock);
+				return;
+			}
+
+			spin_lock(&ei->cache_lru_lock);
+			cache = exfat_cache_merge(inode, new);
+			if (cache != NULL) {
+				ei->nr_caches--;
+				exfat_cache_free(tmp);
+				goto out_update_lru;
+			}
+			cache = tmp;
+		} else {
+			struct list_head *p = ei->cache_lru.prev;
+
+			cache = list_entry(p,
+					struct exfat_cache, cache_list);
+		}
+		cache->fcluster = new->fcluster;
+		cache->dcluster = new->dcluster;
+		cache->nr_contig = new->nr_contig;
+	}
+out_update_lru:
+	exfat_cache_update_lru(inode, cache);
+unlock:
+	spin_unlock(&ei->cache_lru_lock);
+}
+
+/*
+ * Cache invalidation occurs rarely, thus the LRU chain is not updated. It
+ * fixes itself after a while.
+ */
+static void __exfat_cache_inval_inode(struct inode *inode)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_cache *cache;
+
+	while (!list_empty(&ei->cache_lru)) {
+		cache = list_entry(ei->cache_lru.next,
+				   struct exfat_cache, cache_list);
+		list_del_init(&cache->cache_list);
+		ei->nr_caches--;
+		exfat_cache_free(cache);
+	}
+	/* Update. The copy of caches before this id is discarded. */
+	ei->cache_valid_id++;
+	if (ei->cache_valid_id == EXFAT_CACHE_VALID)
+		ei->cache_valid_id++;
+}
+
+void exfat_cache_inval_inode(struct inode *inode)
+{
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
+	spin_lock(&ei->cache_lru_lock);
+	__exfat_cache_inval_inode(inode);
+	spin_unlock(&ei->cache_lru_lock);
+}
+
+static inline int cache_contiguous(struct exfat_cache_id *cid,
+		unsigned int dclus)
+{
+	cid->nr_contig++;
+	return cid->dcluster + cid->nr_contig == dclus;
+}
+
+static inline void cache_init(struct exfat_cache_id *cid,
+		unsigned int fclus, unsigned int dclus)
+{
+	cid->id = EXFAT_CACHE_VALID;
+	cid->fcluster = fclus;
+	cid->dcluster = dclus;
+	cid->nr_contig = 0;
+}
+
+int exfat_get_cluster(struct inode *inode, unsigned int cluster,
+		unsigned int *fclus, unsigned int *dclus,
+		unsigned int *last_dclus, int allow_eof)
+{
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int limit = sbi->num_clusters;
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct exfat_cache_id cid;
+	unsigned int content;
+
+	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
+		exfat_fs_error(sb,
+			"invalid access to exfat cache (entry 0x%08x)",
+			ei->start_clu);
+		return -EIO;
+	}
+
+	*fclus = 0;
+	*dclus = ei->start_clu;
+	*last_dclus = *dclus;
+
+	/*
+	 * Don`t use exfat_cache if zero offset or non-cluster allocation
+	 */
+	if (cluster == 0 || *dclus == EXFAT_EOF_CLUSTER)
+		return 0;
+
+	cache_init(&cid, EXFAT_EOF_CLUSTER, EXFAT_EOF_CLUSTER);
+
+	if (exfat_cache_lookup(inode, cluster, &cid, fclus, dclus) ==
+			EXFAT_EOF_CLUSTER) {
+		/*
+		 * dummy, always not contiguous
+		 * This is reinitialized by cache_init(), later.
+		 */
+		WARN_ON(cid.id != EXFAT_CACHE_VALID ||
+			cid.fcluster != EXFAT_EOF_CLUSTER ||
+			cid.dcluster != EXFAT_EOF_CLUSTER ||
+			cid.nr_contig != 0);
+	}
+
+	if (*fclus == cluster)
+		return 0;
+
+	while (*fclus < cluster) {
+		/* prevent the infinite loop of cluster chain */
+		if (*fclus > limit) {
+			exfat_fs_error(sb,
+				"detected the cluster chain loop (i_pos %u)",
+				(*fclus));
+			return -EIO;
+		}
+
+		if (exfat_ent_get(sb, *dclus, &content))
+			return -EIO;
+
+		*last_dclus = *dclus;
+		*dclus = content;
+		(*fclus)++;
+
+		if (content == EXFAT_EOF_CLUSTER) {
+			if (!allow_eof) {
+				exfat_fs_error(sb,
+				       "invalid cluster chain (i_pos %u, last_clus 0x%08x is EOF)",
+				       *fclus, (*last_dclus));
+				return -EIO;
+			}
+
+			break;
+		}
+
+		if (!cache_contiguous(&cid, *dclus))
+			cache_init(&cid, *fclus, *dclus);
+	}
+
+	exfat_cache_add(inode, &cid);
+	return 0;
+}
-- 
2.17.1

