Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6810CFAC01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 09:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKMIX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 03:23:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21125 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfKMIW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:22:26 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191113082224epoutp021be8a7101d09b55496fcf3eb443ac85c~WqzBwGTbQ0087600876epoutp02w
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191113082224epoutp021be8a7101d09b55496fcf3eb443ac85c~WqzBwGTbQ0087600876epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573633344;
        bh=cMpYo+3xAlzGcb/z0sUvvooDr48c4npcG1qhTtMBMh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrX/2amBuqcqYgKGpFCNWbPwShxvD5Qk9hTDYpHYzx+2YvV8isk3MJQSU/7SwD9Ak
         Yekq51QazZAPOuedlfJjfYOp8PBMRXEcNQZpQyse9pbz7LbF45hUSGfIBziv0Hjp7i
         vZfa4jDRjHNCehzLi6bGNk69/u7sJLOKcKosUrIE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191113082224epcas1p4ec108471bfa6b3d4b55df67d46506fb6~WqzBexhjI3012230122epcas1p4j;
        Wed, 13 Nov 2019 08:22:24 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Cczg08LNzMqYkl; Wed, 13 Nov
        2019 08:22:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.8B.04085.E3DBBCD5; Wed, 13 Nov 2019 17:22:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191113082221epcas1p3ed36f46c328a3b595f401c0d4d1f1265~Wqy-UMp5P1452214522epcas1p3C;
        Wed, 13 Nov 2019 08:22:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113082221epsmtrp117538f83ba6f35dade9d6b56d7f5f6ae~Wqy-TZWNH2822528225epsmtrp1D;
        Wed, 13 Nov 2019 08:22:21 +0000 (GMT)
X-AuditID: b6c32a37-e31ff70000000ff5-87-5dcbbd3e7d85
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.C1.25663.D3DBBCD5; Wed, 13 Nov 2019 17:22:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113082221epsmtip18cfede83d543e38782fba1a82e777de6~Wqy-LBgfQ2313923139epsmtip1g;
        Wed, 13 Nov 2019 08:22:21 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH 08/13] exfat: add exfat cache
Date:   Wed, 13 Nov 2019 03:17:55 -0500
Message-Id: <20191113081800.7672-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113081800.7672-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmvq7d3tOxBq8Pslo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2qBybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6
        yfm5VoYGBkamQJUJORkP2j+yFrS5VexdeI6lgXG1RRcjJ4eEgInEnvaVTF2MXBxCAjsYJZpe
        3GQHSQgJfGKUWH9JDyLxjVHi6L1TzDAdW35PZoRI7GWUWNA5D8oB6th+fBpLFyMHB5uAtsSf
        LaIgDSIC9hKbZx9gAalhFpjDKLGjdxYjSEJYQFdi0t4NrCA2i4CqROu+9WCreQWsJY5s74fa
        Ji+xesMBZpCZnAI2EtfW2oLMkRDYwCZxdck+qBoXifvHWxkhbGGJV8e3sEPYUhIv+9vYQXol
        BKolPu6HKu9glHjx3RbCNpa4uR7kBA6g2zQl1u/ShwgrSuz8PRdsIrMAn8S7rz2sEFN4JTra
        hCBKVCX6Lh1mgrClJbraP0At9ZB49eQ/NED7gb7ddIplAqPcLIQNCxgZVzGKpRYU56anFhsW
        GCPH1yZGcHLTMt/BuOGczyFGAQ5GJR5eiYWnYoVYE8uKK3MPMUpwMCuJ8O6oOBErxJuSWFmV
        WpQfX1Sak1p8iNEUGI4TmaVEk/OBiTevJN7Q1MjY2NjCxMzczNRYSZzXcfnSWCGB9MSS1OzU
        1ILUIpg+Jg5OqQZG9s2/O3ekfs3QzlHfr2T2VuiO7ey/tqXdrCE/jHUYYtXfHQznZtj6Y8ML
        BfsLy3qaNq1/uf16VcuCZ5d5nzm/rvy8QTloHb/MAjNtzvs7Guy/Sv+eMKczU/Ls1PzQovmn
        Kp0bll7mzhVoDfO6e9+7oCklW+Jt6OXb145fSN0R3O57r/XeLLUeJZbijERDLeai4kQAIsyE
        nIQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnK7t3tOxBq+Pa1g0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbbPl3hNXi0vsPLA4cHjtn3WX32D93DbvH7psNbB59W1Yx
        enzeJOdxaPsbtgC2KC6blNSczLLUIn27BK6MB+0fWQva3Cr2LjzH0sC42qKLkZNDQsBEYsvv
        yYxdjFwcQgK7GSWuLZ/KBpGQljh24gxzFyMHkC0scfhwMUTNB0aJh/0/wOJsAtoSf7aIgpSL
        CDhK9O46zAJSwyywiFHi3cfJrCAJYQFdiUl7N4DZLAKqEq371rOD2LwC1hJHtvczQ+ySl1i9
        4QDYTE4BG4lra21BwkJAJV/fHmCewMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+
        7iZGcBBqae1gPHEi/hCjAAejEg/vgXmnYoVYE8uKK3MPMUpwMCuJ8O6oOBErxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgVHXqD7g0PwPN1lOWFScMS1X
        uP5yBWdHK3N8CXvEgot8i+0e9uxMVJFwuSJlFsiStu5yDc8V15CnhxO+9qzYears3AnJK5US
        WecNft4JfHFw1X/nP1+ttT+fOu8rMoNV/3Pa9Yn/Xwl8rJ/y5G1Ta8LKzeISgrpc81Nftt01
        Ddi49LBmTdhVMz0lluKMREMt5qLiRADO5IY1PgIAAA==
X-CMS-MailID: 20191113082221epcas1p3ed36f46c328a3b595f401c0d4d1f1265
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113082221epcas1p3ed36f46c328a3b595f401c0d4d1f1265
References: <20191113081800.7672-1-namjae.jeon@samsung.com>
        <CGME20191113082221epcas1p3ed36f46c328a3b595f401c0d4d1f1265@epcas1p3.samsung.com>
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
index 000000000000..b87438360103
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
+	unsigned int offset = EOF_CLUSTER;
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
+	if (new->fcluster == EOF_CLUSTER) /* dummy cache */
+		return;
+
+	spin_lock(&ei->cache_lru_lock);
+	if (new->id != EXFAT_CACHE_VALID &&
+	    new->id != ei->cache_valid_id)
+		goto out;	/* this cache was invalidated */
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
+out:
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
+	if (ei->start_clu == FREE_CLUSTER) {
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
+	if (cluster == 0 || *dclus == EOF_CLUSTER)
+		return 0;
+
+	cache_init(&cid, EOF_CLUSTER, EOF_CLUSTER);
+
+	if (exfat_cache_lookup(inode, cluster, &cid, fclus, dclus) ==
+			EOF_CLUSTER) {
+		/*
+		 * dummy, always not contiguous
+		 * This is reinitialized by cache_init(), later.
+		 */
+		WARN_ON(cid.id != EXFAT_CACHE_VALID ||
+			cid.fcluster != EOF_CLUSTER ||
+			cid.dcluster != EOF_CLUSTER ||
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
+		if (content == EOF_CLUSTER) {
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

