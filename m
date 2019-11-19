Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D01020F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 10:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKSJk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 04:40:57 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:40701 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfKSJkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:40:31 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191119094027epoutp0287ff90a6252b790069af705bbec7070c~Yhu4c_k650391103911epoutp02J
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191119094027epoutp0287ff90a6252b790069af705bbec7070c~Yhu4c_k650391103911epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574156427;
        bh=cMpYo+3xAlzGcb/z0sUvvooDr48c4npcG1qhTtMBMh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXEbTwz+cpPwKvuT3+nbSMwPK/TzL1+0Hu6eN8UwTmgwMHN/eQGCnqq07cb+GNb1U
         PjgEBNZYzZFzEjyKDU/Q1CPE6SIrWxqKwPv9DdxGxShxBmflx/BwBSHGNGOEm8KfmX
         q05WnyKD4x2Y+19ef/vJxOKuzre0WIjxnMHnqxyc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191119094026epcas1p346b1d6ce9120519ffb2a53f933c9899d~Yhu4CM4kz1135011350epcas1p3e;
        Tue, 19 Nov 2019 09:40:26 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47HLQx4nKmzMqYkZ; Tue, 19 Nov
        2019 09:40:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.07.04080.988B3DD5; Tue, 19 Nov 2019 18:40:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191119094024epcas1p1be385d521ef64ae0e62da3f6f9bf3401~Yhu2f5N9e1202912029epcas1p1g;
        Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191119094024epsmtrp1899114b5308c95db1f0a069dd5f8cc50~Yhu2fPgYq0080100801epsmtrp1p;
        Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
X-AuditID: b6c32a37-7cdff70000000ff0-b9-5dd3b889c4f2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.12.03654.888B3DD5; Tue, 19 Nov 2019 18:40:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191119094024epsmtip2c47c766629c77fc1487f5b0a56cec03f~Yhu2QuNXT0708907089epsmtip2F;
        Tue, 19 Nov 2019 09:40:24 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        linkinjeon@gmail.com, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v3 08/13] exfat: add exfat cache
Date:   Tue, 19 Nov 2019 04:37:13 -0500
Message-Id: <20191119093718.3501-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119093718.3501-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXa3e+/MxWVaPVjYuhClMd2a05u5DJS6lYVQX3pZdtPLJu2t
        3S0yP2iZL4lpRSFolpFLdJqWw5kmivZKKKlQqQi9QGqGaVoapbXtzurb7znnf87/cJ6DI9Jc
        NARPN9lYq4kxkGiAsLk7TCG/0DKgVdy6Kqa6P1zBqJzbDShV43wsoF6PDCHUw/bnQmqg9TpK
        /S4bFVHzpVmUa/GRiOr/MiXcHkA/KBvB6I6KOoxuG8xG6WJXLaCbXmTSM/dD6S73Z5Qe/tgs
        TMYPGeL0LJPGWmWsKdWclm7Sacg9+1MSUtTRCqVcuYWKIWUmxshqyMSkZPmOdINnRFJ2ijHY
        PaFkhuPIyG1xVrPdxsr0Zs6mIVlLmsGiVFgiOMbI2U26iFSzMVapUGxWe5THDPq3+dMiS96O
        0+23eoXZwEkVAjEOiShYPVYq8LKUaAFwok9XCAI8/BXAkeHrAv7xHcDKiz3oUkVF80WET7QD
        WFU8Lvxb4rzS5sngOEpsgr9cK7wFwUQ8bCrv9GkQ4hGAY7OXMG8iiFDAzsfDPm8hsR4uujt8
        DhJiKzybe9nvthY6GzsRL4uJOPiu/A7wNoLEMxTWj834RYkwv86J8BwEPz11YTyHwPGSPMw7
        ECQy4XSHX1LgGWJOw7MKDjY0irwShAiDDa2RfHgdfPCzAngZIZbDyW9FIr6LBBbkSXnJeljc
        3y3geTUszJ/ym9LQfXMC5VdSAuAbxzXsEggt++dQCUAtWMlaOKOO5ZQW1f8fdh/4TjA8pgU0
        9iZ1AQIHZKBEtmFAKxUxp7gMYxeAOEIGS/a9f6mVStKYjDOs1ZxitRtYrguoPYu8jISsSDV7
        DtpkS1GqN6tUKioqOiZarSJXSfD5Pq2U0DE29gTLWljrUp0AF4dkg+CNbw4yx3sLb4Qye+fh
        vcOOkiPlYmvH+2UOMrZgQB7RIw2cvJ1T/Kq1YfTJlODkwhMytUUTX5rwhdYsuM5jy23Td7Eg
        y5rBIkltTslk5RA2uyvzrSOrZ+cBu+1DkLmp+lx9Dng3xzCJM3NPJxLjPjtq3Eevlckjwnd3
        66t+bCOFnJ5RhiNWjvkDgjobe5gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvG7HjsuxBrP+6FkcfjyJ3aJ58Xo2
        i5WrjzJZXL97i9liz96TLBaXd81hs/g/6zmrxY/p9RZb/h1htbj0/gOLA5fHzll32T32z13D
        7rH7ZgObR9+WVYwem09Xe3zeJOdxaPsbNo/bz7axBHBEcdmkpOZklqUW6dslcGU8aP/IWtDm
        VrF34TmWBsbVFl2MnBwSAiYSc7f1MncxcnEICexmlLhx9icjREJa4tiJM0AJDiBbWOLw4WKI
        mg+MEs8vPGQHibMJaEv82SIKUi4i4CjRu+swC0gNs8A5Romdz5aBzREWMJA4cPQ2E4jNIqAq
        8W/7fjYQm1fAWqKxdSIbxC55idUbDjCD2JwCNhIPZ0P0CoHUPGpmn8DIt4CRYRWjZGpBcW56
        brFhgWFearlecWJucWleul5yfu4mRnCwamnuYLy8JP4QowAHoxIP7wmVy7FCrIllxZW5hxgl
        OJiVRHj9Hl2IFeJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNT
        qoExQaYiyl1YwqY6q0S6S/j/xokLr5ad0zzcska1P7HwSa69ct8v9sVLXltPbrqg9nfL28hZ
        nH3H4tpt7VV3h54LePNTd7ZNu+FCq7sTJnb92b1SZe8r/Q1rZ5j4ht5Rby6R3Lx7zsbHNiwt
        +Sd+3MypPriwIWxT3indxU8fzJJz76zeckTVbluxEktxRqKhFnNRcSIA3dBl3FICAAA=
X-CMS-MailID: 20191119094024epcas1p1be385d521ef64ae0e62da3f6f9bf3401
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119094024epcas1p1be385d521ef64ae0e62da3f6f9bf3401
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
        <CGME20191119094024epcas1p1be385d521ef64ae0e62da3f6f9bf3401@epcas1p1.samsung.com>
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

