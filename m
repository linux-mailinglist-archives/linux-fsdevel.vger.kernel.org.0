Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C8101A34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 08:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfKSHOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 02:14:47 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35523 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfKSHOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:14:11 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191119071408epoutp0442b8a2d7a5e96dcf421db3a5569486c9~YfvIY6YkZ1848718487epoutp04M
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 07:14:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191119071408epoutp0442b8a2d7a5e96dcf421db3a5569486c9~YfvIY6YkZ1848718487epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574147648;
        bh=cMpYo+3xAlzGcb/z0sUvvooDr48c4npcG1qhTtMBMh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shQmnGNiHdzMV5R1wFVTOCeygNdl33PMPz8KUwdBNnP1H8EoRRITz4qORCNh63N9q
         eKDWZ0+tWkjHTYE84Cjd8LQvoAXncN8vc+5kWA8+v0R/266m/gkYKMMsKMk7ZxNywN
         Zg144TrxBK9qD1BZ7N4HnU0TlWHPXtsWtD3DElBQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191119071407epcas1p430f22ba9b297930eacfe7bad467a67cb~YfvH-HOR90775207752epcas1p4h;
        Tue, 19 Nov 2019 07:14:07 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47HHB6459CzMqYkW; Tue, 19 Nov
        2019 07:14:06 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.3F.04080.E3693DD5; Tue, 19 Nov 2019 16:14:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191119071406epcas1p34788f32abd876190f2b0a5c2ba39e4b1~YfvGvYVyz2635426354epcas1p3z;
        Tue, 19 Nov 2019 07:14:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119071406epsmtrp1572392cc270817e68b679085b6fa55b1~YfvGuvkJB3109131091epsmtrp1D;
        Tue, 19 Nov 2019 07:14:06 +0000 (GMT)
X-AuditID: b6c32a37-c29d39c000000ff0-43-5dd3963ee751
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.14.03654.E3693DD5; Tue, 19 Nov 2019 16:14:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191119071405epsmtip12cec80fb64360259dde18b8fdf31cca3~YfvGfbXOD1281112811epsmtip1d;
        Tue, 19 Nov 2019 07:14:05 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v2 08/13] exfat: add exfat cache
Date:   Tue, 19 Nov 2019 02:11:02 -0500
Message-Id: <20191119071107.1947-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119071107.1947-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmnq7dtMuxBhOuKFo0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBb/Zz1ntfgxvd5iy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wedx+to0lgD0qxyYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMH6DIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToGh
        QYFecWJucWleul5yfq6VoYGBkSlQZUJOxoP2j6wFbW4VexeeY2lgXG3RxcjBISFgInHjrE4X
        IxeHkMAORom9y1azQDifGCWaHs9lg3C+MUrcO3kbyOEE63hyaCo7RGIvo0TblslMcC1nPs5i
        AZnLJqAt8WeLKEiDiIC9xObZB8DGMgtsZpR4uGkpC0hCWMBA4vPsa2BTWQRUJS4uXcwOYvMK
        WEusvP2QEWKbvMTqDQeYQWxOARuJ/nnfwTZLCBxgk5jXPJkdoshF4uaWtcwQtrDEq+NboOJS
        Ei/729ghHq2W+LgfqqSDUeLFd1sI21ji5voNrCAlzAKaEut36UOEFSV2/p4LdgKzAJ/Eu689
        rBBTeCU62oQgSlQl+i4dZoKwpSW62j9ALfWQeLZ8MzTg+hkl5s65wzyBUW4WwoYFjIyrGMVS
        C4pz01OLDQuMkSNsEyM45WmZ72DccM7nEKMAB6MSD6+C+uVYIdbEsuLK3EOMEhzMSiK8fo8u
        xArxpiRWVqUW5ccXleakFh9iNAUG5ERmKdHkfGA6ziuJNzQ1MjY2tjAxMzczNVYS5+X4cTFW
        SCA9sSQ1OzW1ILUIpo+Jg1OqgbH/oXr+b1OO2pQZqiZ8aju2rd7EGmi4/KfP+b6C5Rek6wsq
        LkyJUHg2757KDNWU3AWPfu+eWPLL7xR3wYNlyXoq14JMHXtUOpj/T3tzV7Ihr4HlYuuxbRxR
        tVnnr7x/45slpPE5aDfv9OPvhU/9d68JPNBgJNGv2tTdL/mm6Jnyq81X9+lEqyqxFGckGmox
        FxUnAgBFwH0FjwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnK7dtMuxBu1/2SyaF69ns1i5+iiT
        xfW7t5gt9uw9yWJxedccNov/s56zWvyYXm+x5d8RVotL7z+wOHB67Jx1l91j/9w17B67bzaw
        efRtWcXo8XmTnMeh7W/YPG4/28YSwB7FZZOSmpNZllqkb5fAlfGg/SNrQZtbxd6F51gaGFdb
        dDFyckgImEg8OTSVvYuRi0NIYDejRGfLbVaIhLTEsRNnmLsYOYBsYYnDh4shaj4wSnRfmcoE
        EmcT0Jb4s0UUpFxEwFGid9dhFpAaZpA5W6b/YgRJCAsYSHyefY0NxGYRUJW4uHQxO4jNK2At
        sfL2Q0aIXfISqzccYAaxOQVsJPrnfQerEQKq2bxoCesERr4FjAyrGCVTC4pz03OLDQsM81LL
        9YoTc4tL89L1kvNzNzGCQ1NLcwfj5SXxhxgFOBiVeHhPqFyOFWJNLCuuzD3EKMHBrCTC6/fo
        QqwQb0piZVVqUX58UWlOavEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjMJvZ06Z
        raB2/e7cpqbs9baN620aRFfvF746X2PhvdO/7j8oaTxWurp9/X+Nnb3NzzM7MvmtfR6/+cu3
        6h7nubXn/tVOnsghu5N3plRLZudnK/FOxg9sDCVrDQ9yePRLM/zV3rRc5HrOSaup6TFH34Yf
        aCgTL3hdp+0bsP9GaPJ077Bpms8U/ymxFGckGmoxFxUnAgCluQGISQIAAA==
X-CMS-MailID: 20191119071406epcas1p34788f32abd876190f2b0a5c2ba39e4b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119071406epcas1p34788f32abd876190f2b0a5c2ba39e4b1
References: <20191119071107.1947-1-namjae.jeon@samsung.com>
        <CGME20191119071406epcas1p34788f32abd876190f2b0a5c2ba39e4b1@epcas1p3.samsung.com>
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

