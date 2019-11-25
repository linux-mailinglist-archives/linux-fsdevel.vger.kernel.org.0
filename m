Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA81085D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 01:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKYAHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 19:07:10 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:49590 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfKYAGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:06:37 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191125000634epoutp0228de45f899f41b0ae90afb422ace8dc1~aPxiCPL4G1389313893epoutp021
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 00:06:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191125000634epoutp0228de45f899f41b0ae90afb422ace8dc1~aPxiCPL4G1389313893epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574640394;
        bh=KfGbXTFk2S+92ux8sJu+T23qMAykMWjoPWvAZ6jNIy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8wMh2uNTaNQ0Psk4HQ1Fd4Sa3pev+7t4FJDVeIzNVobhDBxYbm8ieaDSzbzMMTut
         REQvxitHZeJJ5TIjaEn/mA0s3tF7sG/XzAurdPMggdbC2BkNEDHyG55Fn1v+bl0um5
         MI5ipHgGAeD9K0DqU4QFRoKS9kXB65HvFBg2rplg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191125000633epcas1p1f4231806f3b0236523f38e500040c50e~aPxhheZL20109001090epcas1p1P;
        Mon, 25 Nov 2019 00:06:33 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47LnQ03yVKzMqYm1; Mon, 25 Nov
        2019 00:06:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.64.52419.80B1BDD5; Mon, 25 Nov 2019 09:06:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191125000632epcas1p3d57f4e255dcdeb79707332a5a3dfb2bc~aPxgJqyPC3108631086epcas1p3F;
        Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191125000632epsmtrp1965de004b4998d2983ea9475f00b9047~aPxgJAPFK2803828038epsmtrp1W;
        Mon, 25 Nov 2019 00:06:32 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-25-5ddb1b086e8e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.60.10238.80B1BDD5; Mon, 25 Nov 2019 09:06:32 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125000631epsmtip2f72013c5ba4bf242a4027c261632c912~aPxf6ivld2594225942epsmtip2I;
        Mon, 25 Nov 2019 00:06:31 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v5 08/13] exfat: add exfat cache
Date:   Sun, 24 Nov 2019 19:03:21 -0500
Message-Id: <20191125000326.24561-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125000326.24561-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObt3d3fa4jK1Dkq6bkWoqVtz8xaugkQuWGAYFNWaF3eb0l7s
        ztAMkh5Wy0ytNNbDIoxSS3NL05LZLHpRUFLmzKKXpobZW3rvenv99z2/8/me35ff+eGIfDcW
        iedZnazDyphJLARt6YpNSsCj+vTK0ZoYqut5pYTaeqIRo07XXxVRPf0BhLrUcQOlutsPY9RP
        96CYGq/eTP18vQ2lvD+uiKl7b8bQRaF0m7tfQvuONEjoi73FGF3mrQN0o/c+SntuFdHvm6Np
        f+trjO4baEEzpavMqbksY2QdCtaaYzPmWU06MiPLsNig0SpVCap5VAqpsDIWVkemLclMSM8z
        B8OSig2MOT9YymQ4jkxakOqw5TtZRa6Nc+pI1m4021VKeyLHWLh8qykxx2aZr1Iq52qCZLY5
        99TZHHtpesGWT25RMThHuYAUh0Qy3DdWhrhACC4nLgC4teO7SDi8A7CizYPxlJz4BOAeN+EC
        +ITDN1ooMB0Atm8fQf4aWnv3iHgII+LhN28E7w0nFkLPoU6UZxCiB8CBwEExfxFGKGH3+BuE
        1ygxCz441gl4r4xIhYPVaUK6GFjf1DmBSAkdvH6zBRHqfRis3TZD0Gnwy5fbqKDD4PA1r0TQ
        kXBob4lEyFwE3/p+W3cC+OqzTtBq2NvYJOYRhIiFje1JQnk6bPt6BPAaISbD0Y+lYuEVGdxZ
        IheQWbDsXpdI0FHQtWPsd1Mado68lAgDKQfweOkupBxEu/91OAZAHZjC2jmLieVUdvX/n9UM
        JhYxLuUCaLqzxA8IHJCTZE1nAnq5mNnAFVr8AOIIGS5Lv/1QL5cZmcKNrMNmcOSbWc4PNMEx
        ViCRETm24FpbnQaVZq5araaStSlajZqcKsPH7+rlhIlxsutZ1s46/vhEuDSyGGQ9Cljc36v6
        L9aYQmv6N3mVa57OHJzpK9CPiKPEaO8KRTbR8OzF8qXG1fHLxuLVnmlaz7Xt8xavPCydceDs
        B3LBFee6NUVVhpLNnDIBfxRTczlQUjsn6yD95Oj5x5xuPHkyE7I/o362L8K19ig9tAjL1g5X
        Brb4w+pPJr67ird/JFEul1HFIQ6O+QWMqkvingMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSvC6H9O1Yg76zzBaHH09it2hevJ7N
        YuXqo0wW1+/eYrbYs/cki8XlXXPYLP7Pes5q8WN6vcX/Ny0sFlv+HWG1uPT+A4sDt8fOWXfZ
        PfbPXcPusftmA5tH35ZVjB7rt1xl8dh8utrj8yY5j0Pb37B53H62jSWAM4rLJiU1J7MstUjf
        LoErY8W65IIet4qmb7OYGhg3WnQxcnBICJhI7H9X2cXIxSEksJtRYuW07+xdjJxAcWmJYyfO
        MEPUCEscPlwMUfOBUWL5sZ+sIHE2AW2JP1tEQcpFBBwlencdZgGpYRZ4zChx4vwTRpCEsICB
        xOUf75lBbBYBVYlrCw4wgvTyCthIPJ/uArFKXmL1hgNgJZwCthInTm0Ds4WAStoPHWWbwMi3
        gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcOhqae5gvLwk/hCjAAejEg/vhrW3
        YoVYE8uKK3MPMUpwMCuJ8LqdvRErxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU
        7NTUgtQimCwTB6dUA+PsdNnbwgxed9cc/lG4XDL44JtvM8WUPFc8vz57r5d3fmTJoXOO+SxO
        P7uPbL2x6q9LSO2mMhElq8ZLpneeVMyOPBMnb/m2f9ObnoSj/pLWdQV6dT+yG3MkX1joWn7L
        DtB4ljNt8uvwU79SE8+dKUky07XUcauaFeHoJ2T4cuejDbqPcqJV3yqxFGckGmoxFxUnAgCP
        dhlAWQIAAA==
X-CMS-MailID: 20191125000632epcas1p3d57f4e255dcdeb79707332a5a3dfb2bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191125000632epcas1p3d57f4e255dcdeb79707332a5a3dfb2bc
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
        <CGME20191125000632epcas1p3d57f4e255dcdeb79707332a5a3dfb2bc@epcas1p3.samsung.com>
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
index 000000000000..74f9a44471d5
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

