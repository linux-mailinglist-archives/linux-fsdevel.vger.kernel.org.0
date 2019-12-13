Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70711DE0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 06:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfLMFxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 00:53:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:16924 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbfLMFxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:53:46 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191213055344epoutp01fa5e8123e2d4950e2da3aa43261da24d~f2Hyecldz0557205572epoutp015
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 05:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191213055344epoutp01fa5e8123e2d4950e2da3aa43261da24d~f2Hyecldz0557205572epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576216424;
        bh=n/rDBhxWckXTuf5F7VnL+Givw9EJ/999mKdt8sYl/aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQHi5QErhy4+T9Em/66ndLUoK4NhOAADlAasPc5JpCtDuQaYFulIf/Z75evwB36oc
         TNrmzO2tw37lSnDXWDQzU6DcgTKJEB3SZ4e1SWqnOfW7Cx3wIWLtUGjVN3wC8HJwEW
         KCWmZiEFrp/V/J2IA0u8vFyZqSCsuj4bPffLu1tw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191213055343epcas1p19d19fd87c94fe788d323bdf979118245~f2HyEXdw60207402074epcas1p11;
        Fri, 13 Dec 2019 05:53:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47Z0GG5bMBzMqYlm; Fri, 13 Dec
        2019 05:53:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.BA.57028.66723FD5; Fri, 13 Dec 2019 14:53:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055342epcas1p2e9f2971a4a7d392173e885b446b3e2c3~f2HwqPtJ62013320133epcas1p2m;
        Fri, 13 Dec 2019 05:53:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191213055342epsmtrp2dfd7a548ae8f4b198179ae7663082a06~f2Hwpik8o0142901429epsmtrp2D;
        Fri, 13 Dec 2019 05:53:42 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-12-5df327667d88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.92.06569.66723FD5; Fri, 13 Dec 2019 14:53:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213055342epsmtip2caa212c913027a98d529476e9ccb0286~f2HwfTiP61079710797epsmtip2K;
        Fri, 13 Dec 2019 05:53:42 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v7 08/13] exfat: add exfat cache
Date:   Fri, 13 Dec 2019 00:50:23 -0500
Message-Id: <20191213055028.5574-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213055028.5574-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmgW6a+udYg84rmhbNi9ezWaxcfZTJ
        Ys/ekywWl3fNYbP4Mb3eYsu/I6wWl95/YHFg99g/dw27x+6bDWwefVtWMXp83iTncWj7G7YA
        1qgcm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCV
        CTkZV85dZiw44Vbxa2pCA+Nbiy5GTg4JAROJpc83MYLYQgI7GCXWTTaGsD8xStx/HtLFyAVk
        f2OUuLlqNStMw4s1Z1ghEnsZJSZ9WcMC4QB1nFr2iqmLkYODTUBb4s8WUZAGEQF7ic2zD4DV
        MAu0MEosOP2DGSQhLGAg8f7DSVaQehYBVYmlPxNAwrwC1hLvj31jhFgmL7F6wwGwck4BG4l5
        kz+wg8yREFjAJvHt9H82iCIXiWlNT6FsYYlXx7ewQ9hSEp/f7WUDmS8hUC3xcT8zRLiDUeLF
        d1sI21ji5voNYCcwC2hKrN+lDxFWlNj5ey7YCcwCfBLvvvawQkzhlehoE4IoUZXou3SYCcKW
        luhq/wC11ENi2dqn0PDsB4bbhKwJjHKzEBYsYGRcxSiWWlCcm55abFhgiBxZmxjBKUzLdAfj
        lHM+hxgFOBiVeHhXJH6KFWJNLCuuzD3EKMHBrCTCa18DFOJNSaysSi3Kjy8qzUktPsRoCgzG
        icxSosn5wPSaVxJvaGpkbGxsYWJmbmZqrCTOy/HjYqyQQHpiSWp2ampBahFMHxMHp1QDo4fm
        tTLtsxq3F+Zxr+/eeW7W235F7fmdBho8fkL7OLbm56Scfe7/tj+0e3Vo/s8i02fe82bcvSLv
        6NInImxq5rLl69Kwp03zd3H/K1mzU+LI7ebagPvnV3/wWid6VPDzf54m5gfvAu7YqimWXrC/
        x3yG+WjYYpEOp0WLl5aU6JxpS22eKK7UqMRSnJFoqMVcVJwIABPhhZZ3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSvG6a+udYgw1vhSyaF69ns1i5+iiT
        xZ69J1ksLu+aw2bxY3q9xZZ/R1gtLr3/wOLA7rF/7hp2j903G9g8+rasYvT4vEnO49D2N2wB
        rFFcNimpOZllqUX6dglcGVfOXWYsOOFW8WtqQgPjW4suRk4OCQETiRdrzrB2MXJxCAnsZpRY
        t3gaC0RCWuLYiTPMXYwcQLawxOHDxRA1HxglHk7/yg4SZxPQlvizRRSkXETAUaJ312EWkBpm
        gS5GiUdN35hBEsICBhLvP5xkBalnEVCVWPozASTMK2At8f7YN0aIVfISqzccACvnFLCRmDf5
        AzuILQRUc/ftK7YJjHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEh5uW1g7G
        EyfiDzEKcDAq8fCuSPwUK8SaWFZcmXuIUYKDWUmE174GKMSbklhZlVqUH19UmpNafIhRmoNF
        SZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoGRo3DHtylzbDmDFcSkVx1R+LB0Ude0aU1K5Yyc
        91ouh4dcEn379yuPl325xoozy55KS7CcYL3sZXyeP1j5P2+LpqLFhoftwZcFDx0o0dRR3mN4
        OFV1WYr+7inBCet4mp/8CP+Ttq1FPddCafmle7f0yld9mvGYS/JI1MN0W/kPbJPqj3hMOJ6u
        xFKckWioxVxUnAgA0jFd4jMCAAA=
X-CMS-MailID: 20191213055342epcas1p2e9f2971a4a7d392173e885b446b3e2c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191213055342epcas1p2e9f2971a4a7d392173e885b446b3e2c3
References: <20191213055028.5574-1-namjae.jeon@samsung.com>
        <CGME20191213055342epcas1p2e9f2971a4a7d392173e885b446b3e2c3@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the implementation of exfat cache.

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

