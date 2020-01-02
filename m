Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6198612E3D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 09:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgABIYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 03:24:45 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:56191 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgABIYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:24:10 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200102082407epoutp01920b453d5f074c38363d5f1a61fc0296~mBEzge55z1618216182epoutp01i
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2020 08:24:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200102082407epoutp01920b453d5f074c38363d5f1a61fc0296~mBEzge55z1618216182epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577953447;
        bh=n/rDBhxWckXTuf5F7VnL+Givw9EJ/999mKdt8sYl/aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ap21ma46lqeRP58oJwmOcMuXYY1Xjsitxj8THOBbLEcq6RS6vr7l4bnQRgp96h4hI
         BfWoVoNlIZwIO8QMfI/JydZigdbiV30vDvdZY15aHo/igGcGh3Uyv9UpVBjGnXsWa5
         2ijPCkX7ymq+AiuL7cQZ6ImPFGa6tfzC0n4Fiyec=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200102082407epcas1p2cb4c344a5cba3326f4a76ba3c7421f2e~mBEzDOvT_1717417174epcas1p2x;
        Thu,  2 Jan 2020 08:24:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47pLfZ1NdjzMqYll; Thu,  2 Jan
        2020 08:24:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.BD.48498.6A8AD0E5; Thu,  2 Jan 2020 17:24:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200102082405epcas1p160f24165fc8ae8f51080e75bb585e0c7~mBEx1vHfW3218732187epcas1p1d;
        Thu,  2 Jan 2020 08:24:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200102082405epsmtrp22998d2a8d410797a60be07c1a230a9dc~mBEx1Dpbm2039720397epsmtrp2W;
        Thu,  2 Jan 2020 08:24:05 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-f5-5e0da8a6ccd7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.88.06569.5A8AD0E5; Thu,  2 Jan 2020 17:24:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200102082405epsmtip286b1077dbe608759b4f02c9ec050cd00~mBExogb932557925579epsmtip29;
        Thu,  2 Jan 2020 08:24:05 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, pali.rohar@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH v9 08/13] exfat: add exfat cache
Date:   Thu,  2 Jan 2020 16:20:31 +0800
Message-Id: <20200102082036.29643-9-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102082036.29643-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29mOZ+LiMLU+Fuk6JZGlbs7pSZxFmS40MIKQwstBv5y0Gzub
        ZUVpN8UuaBSalxTNSi0UnXdNm0lGIKSFGijRDat5qdAkRdp2FvXveZ/3eb738r0EJl4SSIgs
        vRmZ9IyWwj357YPbZUH3H4pSZKWLBH2xtgmn6xuHePT41FuM7u17wafHuitwernkPF38coVH
        W9eeCejR+QX+HqG6q2zKQ91f+chD3TOZi6tvWBuA+meLn9rWYccT8aPaKA1iMpBJivTphows
        faaKij+cui9VGS6TB8l30RGUVM/okIqKSUgMis3SOpqipNmM1uKgEhmWpUKio0wGixlJNQbW
        rKKQMUNrlMuMwSyjYy36zOB0gy5SLpOFKh3KNK3m9cgYMA7Hnvp9Oy0XzNKFQEhAMgxe+ljK
        KwSehJjsBLC+p96DC34AWFRW5w6WALTbnwoKAeGyDLce4/g+h8NW9M+RV3KT5xTh5A64avV1
        lvAhd8PW8gG+U4ORLQD2Vi0KnAlvUgZnhmpdmE8GwJGJKRcWkVFw+uI3D64/f9jYPIA5sZBU
        wTvzl3HnQ5DsxGHnbK1bFAM/5C/hHPaGX59b3bwE/pzrw7muz8Dv/RhHFwA480vFYQWcbGp2
        DYaR22FTdwhHb4ZdK5XAiTFyHZxbvOaeXQQLrog5SQC8MTrI4/BGWJi/4C6qhhUd+QJuJUUA
        fpm9BIqAX9m/CtUANID1yMjqMhErN4b+/18twHVzgeGdoGYkwQZIAlBeoom7XiliAZPN5uhs
        ABIY5SM6eUiUIhZlMDmnkcmQarJoEWsDSsciizGJb7rBccF6c6pcGapQKOiw8IhwpYLaICKW
        XyWLyUzGjE4gZESmvz4eIZTkAknL+PVYlb7tvYGctD5MrstbK2v+bPJfWV24Vzz9yVJPxffd
        CTuLbSldPFIwWF3nfX/X4X0RSfFS4Tv2gK78QtsDTY7kzVp2eWLNcSZ4r/etqhHicfREe3CX
        XScOSIo7GHMuK8ywsyk/4bem0fPstk1X6cjR/SjyCaK6t9rjlGMUn9Uw8kDMxDJ/ACYHbbWJ
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvO7SFbxxBttvGVg0L17PZrFy9VEm
        i+t3bzFb7Nl7ksXi8q45bBY/ptdbTDz9m8liy78jrBaX3n9gceD02DnrLrvH/rlr2D1232xg
        8+jbsorR4/MmOY9D29+wBbBFcdmkpOZklqUW6dslcGVcOXeZseCEW8WvqQkNjG8tuhg5OCQE
        TCRObI7uYuTkEBLYzSixpJsfxJYQkJY4duIMM0SJsMThw8VdjFxAJR8YJdb9W8kKEmcT0Jb4
        s0UUpFxEwFGid9dhFpAaZoFdjBInTp9mBEkICxhIvDi6mBXEZhFQlTh34y6YzStgI3Gv+TU7
        xC55idUbDjCD2JwCthIz37eyQdxjI/Hq32O2CYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YW
        l+al6yXn525iBIeiltYOxhMn4g8xCnAwKvHw3pjHEyfEmlhWXJl7iFGCg1lJhLc8kDdOiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dUA6Obr7b9rNDZTydn
        b5+x1dxVsDuWXb7lxp01RdcPFJjw8P5gPvFAvGTGzp3W6oYqMhOvMOrcbF7N68soMsdI4czn
        f88KgmYci3U4tUZ7dXHgCcnXcdG2ErpT4x5W3f5U3r17ycY0E5abE2bNUX576MO6ttW/tAR7
        vE6Lms5qeK9vetPz8hKd9NVKLMUZiYZazEXFiQA4QEc8QQIAAA==
X-CMS-MailID: 20200102082405epcas1p160f24165fc8ae8f51080e75bb585e0c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200102082405epcas1p160f24165fc8ae8f51080e75bb585e0c7
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082405epcas1p160f24165fc8ae8f51080e75bb585e0c7@epcas1p1.samsung.com>
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

