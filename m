Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFC6A264D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBYBRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBYBRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:01 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF66136F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:56 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bk32so763421oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CAG4G4BRMu49/oFfT/FlFFOh/aHIajciKpBDkhGpHc=;
        b=p85qd9YCQiD2mC0dIh1VXPfQCr3/BaYbIRJuhTP8DZjggGYxbKm70xts5fy4k7BnPB
         CeFV5xA2w72MzeydfYcLe66GB4fIgWslhySeRQLNxwTInN1NCLBTFdotoe/rVq0Lssgd
         TGwF+jIqKExB4aBLKeenT/ziJffOfdNm7Ie1n39vfeTeWiDk7oo6beR9J/3NwcVkhLMk
         8ZbcMBgeZ4Vfk3b6BEIEwD1Cdj+RyIolxfOjM68eh6miIY1FmkxEmyO/AQRRY28gfisr
         kOHOycsxyHqacaIad2SOnmePUDMaKNoUjhaV09o8TDUy5mE3nbawbB0GHsDsoY7OWjGa
         M5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CAG4G4BRMu49/oFfT/FlFFOh/aHIajciKpBDkhGpHc=;
        b=3mUwVAi5xBlxO0AyprfcV91qs1DpS9z0BvH/po0wy/XvqmNfq5FDhvxxfgcZOYQGmr
         09gvdE/Sn5yw+m7nVDphOCEwdsqtDXMysxLMNRNAUYRU3zAddrLLspDJfWMYqoIrSYTK
         a34Fsg/uR+KN2lTWLY+xBgsMkVAuWsHE2t08iBj+LH/GDQ+TknOzoNw84P3DJ1ueRVN2
         mzC1ATRfWgJEd0bLpASRU6TxiCjBo+ExKAWNVn41Fel/Z+D3d2TX20FsLycyKEqpltdD
         84EfYYaIpzUn6abNSKlUe+GngeA0h01b5TdnpV6ZlsnaaR0AJ9UPcu0D1lRYK2SHP/zB
         V8pA==
X-Gm-Message-State: AO0yUKWUaTJ35PkOa40oNGAbhiJQ3liLEJJimzXiJ27tEqfyatWnu+Mv
        EffTgsJwYNY9fY/IK/wddfKyeabqLEjbWx8w
X-Google-Smtp-Source: AK7set+ikzSkNDCVRFailsbktRT8BIz39AvZmx3QyiSv8NRInoC91FnBQXh22YxxyxJREtG14czXuw==
X-Received: by 2002:a05:6808:152b:b0:377:f784:3332 with SMTP id u43-20020a056808152b00b00377f7843332mr922328oiw.24.1677287815443;
        Fri, 24 Feb 2023 17:16:55 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:54 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 38/76] ssdfs: introduce PEB mapping table
Date:   Fri, 24 Feb 2023 17:08:49 -0800
Message-Id: <20230225010927.813929-39-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSDFS file system is based on the concept of logical segment
that is the aggregation of Logical Erase Blocks (LEB). Moreover,
initially, LEB hasn’t association with a particular "Physical"
Erase Block (PEB). It means that segment could have the association
not for all LEBs or, even, to have no association at all with any
PEB (for example, in the case of clean segment). Generally speaking,
SSDFS file system needs a special metadata structure (PEB mapping
table) that is capable of associating any LEB with any PEB. The PEB
mapping table is the crucial metadata structure that has several goals:
(1) mapping LEB to PEB, (2) implementation the logical extent concept,
(3) implementation the concept of PEB migration, (4) implementation of
the delayed erase operation by specialized thread.

PEB mapping table describes the state of all PEBs on a particular
SSDFS file system’s volume. These descriptors are split on several
fragments that are distributed amongst PEBs of specialized segments.
Every fragment of PEB mapping table represents the log’s payload in
a specialized segment. Generally speaking, the payload’s content is
split on: (1) LEB table, and (2) PEB table. The LEB table starts from
the header and it contains the array of records are ordered by LEB IDs.
It means that LEB ID plays the role of index in the array of records.
As a result, the responsibility of LEB table is to define an index inside
of PEB table. Moreover, every LEB table’s record defines two indexes.
The first index (physical index) associates the LEB ID with some PEB ID.
Additionally, the second index (relation index) is able to define a PEB ID
that plays the role of destination PEB during the migration process from
the exhausted PEB into a new one. It is possible to see that PEB table
starts from the header and it contains the array of PEB’s state records is
ordered by PEB ID. The most important fields of the PEB’s state record
are: (1) erase cycles, (2) PEB type, (3) PEB state.

PEB type describes possible types of data that PEB could contain:
(1) user data, (2) leaf b-tree node, (3) hybrid b-tree node,
(4) index b-tree node, (5) snapshot, (6) superblock, (7) segment bitmap,
(8) PEB mapping table. PEB state describes possible states of PEB during
the lifecycle: (1) clean state means that PEB contains only free NAND flash
pages are ready for write operations, (2) using state means that PEB could
contain valid, invalid, and free pages, (3) used state means that PEB
contains only valid pages, (4) pre-dirty state means that PEB contains
as valid as invalid pages only, (5) dirty state means that PEB contains
only invalid pages, (6) migrating state means that PEB is under migration,
(7) pre-erase state means that PEB is added into the queue of PEBs are
waiting the erase operation, (8) recovering state means that PEB will be
untouched during some amount of time with the goal to recover the ability
to fulfill the erase operation, (9) bad state means that PEB is unable
to be used for storing the data. Generally speaking, the responsibility of
PEB state is to track the passing of PEBs through various phases of their
lifetime with the goal to manage the PEBs’ pool of the file system’s
volume efficiently.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/peb_mapping_queue.c |  334 ++++++
 fs/ssdfs/peb_mapping_queue.h |   67 ++
 fs/ssdfs/peb_mapping_table.c | 1954 ++++++++++++++++++++++++++++++++++
 fs/ssdfs/peb_mapping_table.h |  699 ++++++++++++
 4 files changed, 3054 insertions(+)
 create mode 100644 fs/ssdfs/peb_mapping_queue.c
 create mode 100644 fs/ssdfs/peb_mapping_queue.h
 create mode 100644 fs/ssdfs/peb_mapping_table.c
 create mode 100644 fs/ssdfs/peb_mapping_table.h

diff --git a/fs/ssdfs/peb_mapping_queue.c b/fs/ssdfs/peb_mapping_queue.c
new file mode 100644
index 000000000000..7d00060da941
--- /dev/null
+++ b/fs/ssdfs/peb_mapping_queue.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_mapping_queue.c - PEB mappings queue implementation.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_map_queue_page_leaks;
+atomic64_t ssdfs_map_queue_memory_leaks;
+atomic64_t ssdfs_map_queue_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_map_queue_cache_leaks_increment(void *kaddr)
+ * void ssdfs_map_queue_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_map_queue_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_map_queue_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_map_queue_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_map_queue_kfree(void *kaddr)
+ * struct page *ssdfs_map_queue_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_map_queue_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_map_queue_free_page(struct page *page)
+ * void ssdfs_map_queue_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(map_queue)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(map_queue)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_map_queue_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_map_queue_page_leaks, 0);
+	atomic64_set(&ssdfs_map_queue_memory_leaks, 0);
+	atomic64_set(&ssdfs_map_queue_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_map_queue_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_map_queue_page_leaks) != 0) {
+		SSDFS_ERR("MAPPING QUEUE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_map_queue_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_map_queue_memory_leaks) != 0) {
+		SSDFS_ERR("MAPPING QUEUE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_map_queue_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_map_queue_cache_leaks) != 0) {
+		SSDFS_ERR("MAPPING QUEUE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_map_queue_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static struct kmem_cache *ssdfs_peb_mapping_info_cachep;
+
+void ssdfs_zero_peb_mapping_info_cache_ptr(void)
+{
+	ssdfs_peb_mapping_info_cachep = NULL;
+}
+
+static
+void ssdfs_init_peb_mapping_info_once(void *obj)
+{
+	struct ssdfs_peb_mapping_info *pmi_obj = obj;
+
+	memset(pmi_obj, 0, sizeof(struct ssdfs_peb_mapping_info));
+}
+
+void ssdfs_shrink_peb_mapping_info_cache(void)
+{
+	if (ssdfs_peb_mapping_info_cachep)
+		kmem_cache_shrink(ssdfs_peb_mapping_info_cachep);
+}
+
+void ssdfs_destroy_peb_mapping_info_cache(void)
+{
+	if (ssdfs_peb_mapping_info_cachep)
+		kmem_cache_destroy(ssdfs_peb_mapping_info_cachep);
+}
+
+int ssdfs_init_peb_mapping_info_cache(void)
+{
+	ssdfs_peb_mapping_info_cachep =
+		kmem_cache_create("ssdfs_peb_mapping_info_cache",
+				  sizeof(struct ssdfs_peb_mapping_info), 0,
+				  SLAB_RECLAIM_ACCOUNT |
+				  SLAB_MEM_SPREAD |
+				  SLAB_ACCOUNT,
+				  ssdfs_init_peb_mapping_info_once);
+	if (!ssdfs_peb_mapping_info_cachep) {
+		SSDFS_ERR("unable to create PEB mapping info objects cache\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_peb_mapping_queue_init() - initialize PEB mappings queue
+ * @pmq: initialized PEB mappings queue
+ */
+void ssdfs_peb_mapping_queue_init(struct ssdfs_peb_mapping_queue *pmq)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pmq);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock_init(&pmq->lock);
+	INIT_LIST_HEAD(&pmq->list);
+}
+
+/*
+ * is_ssdfs_peb_mapping_queue_empty() - check that PEB mappings queue is empty
+ * @pmq: PEB mappings queue
+ */
+bool is_ssdfs_peb_mapping_queue_empty(struct ssdfs_peb_mapping_queue *pmq)
+{
+	bool is_empty;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pmq);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&pmq->lock);
+	is_empty = list_empty_careful(&pmq->list);
+	spin_unlock(&pmq->lock);
+
+	return is_empty;
+}
+
+/*
+ * ssdfs_peb_mapping_queue_add_head() - add PEB mapping at the head of queue
+ * @pmq: PEB mappings queue
+ * @pmi: PEB mapping info
+ */
+void ssdfs_peb_mapping_queue_add_head(struct ssdfs_peb_mapping_queue *pmq,
+				      struct ssdfs_peb_mapping_info *pmi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pmq || !pmi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&pmq->lock);
+	list_add(&pmi->list, &pmq->list);
+	spin_unlock(&pmq->lock);
+}
+
+/*
+ * ssdfs_peb_mapping_queue_add_tail() - add PEB mapping at the tail of queue
+ * @pmq: PEB mappings queue
+ * @pmi: PEB mapping info
+ */
+void ssdfs_peb_mapping_queue_add_tail(struct ssdfs_peb_mapping_queue *pmq,
+				      struct ssdfs_peb_mapping_info *pmi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pmq || !pmi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&pmq->lock);
+	list_add_tail(&pmi->list, &pmq->list);
+	spin_unlock(&pmq->lock);
+}
+
+/*
+ * ssdfs_peb_mapping_queue_remove_first() - get mapping and remove from queue
+ * @pmq: PEB mappings queue
+ * @pmi: first PEB mapping [out]
+ *
+ * This function get first PEB mapping in @pmq, remove it from queue
+ * and return as @pmi.
+ *
+ * RETURN:
+ * [success] - @pmi contains pointer on PEB mapping.
+ * [failure] - error code:
+ *
+ * %-ENODATA     - queue is empty.
+ * %-ENOENT      - first entry is NULL.
+ */
+int ssdfs_peb_mapping_queue_remove_first(struct ssdfs_peb_mapping_queue *pmq,
+					 struct ssdfs_peb_mapping_info **pmi)
+{
+	bool is_empty;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pmq || !pmi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&pmq->lock);
+	is_empty = list_empty_careful(&pmq->list);
+	if (!is_empty) {
+		*pmi = list_first_entry_or_null(&pmq->list,
+						struct ssdfs_peb_mapping_info,
+						list);
+		if (!*pmi) {
+			SSDFS_WARN("first entry is NULL\n");
+			err = -ENOENT;
+		} else
+			list_del(&(*pmi)->list);
+	}
+	spin_unlock(&pmq->lock);
+
+	if (is_empty) {
+		SSDFS_WARN("PEB mappings queue is empty\n");
+		err = -ENODATA;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_peb_mapping_queue_remove_all() - remove all PEB mappings from queue
+ * @pmq: PEB mappings queue
+ *
+ * This function removes all PEB mappings from the queue.
+ */
+void ssdfs_peb_mapping_queue_remove_all(struct ssdfs_peb_mapping_queue *pmq)
+{
+	bool is_empty;
+	LIST_HEAD(tmp_list);
+	struct list_head *this, *next;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pmq);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&pmq->lock);
+	is_empty = list_empty_careful(&pmq->list);
+	if (!is_empty)
+		list_replace_init(&pmq->list, &tmp_list);
+	spin_unlock(&pmq->lock);
+
+	if (is_empty)
+		return;
+
+	list_for_each_safe(this, next, &tmp_list) {
+		struct ssdfs_peb_mapping_info *pmi;
+
+		pmi = list_entry(this, struct ssdfs_peb_mapping_info, list);
+		list_del(&pmi->list);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("delete PEB mapping: "
+			  "leb_id %llu, peb_id %llu, consistency %d\n",
+			  pmi->leb_id, pmi->peb_id, pmi->consistency);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_peb_mapping_info_free(pmi);
+	}
+}
+
+/*
+ * ssdfs_peb_mapping_info_alloc() - allocate memory for PEB mapping info object
+ */
+struct ssdfs_peb_mapping_info *ssdfs_peb_mapping_info_alloc(void)
+{
+	struct ssdfs_peb_mapping_info *ptr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_peb_mapping_info_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = kmem_cache_alloc(ssdfs_peb_mapping_info_cachep, GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate memory for PEB mapping\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_map_queue_cache_leaks_increment(ptr);
+
+	return ptr;
+}
+
+/*
+ * ssdfs_peb_mapping_info_free() - free memory for PEB mapping info object
+ */
+void ssdfs_peb_mapping_info_free(struct ssdfs_peb_mapping_info *pmi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ssdfs_peb_mapping_info_cachep);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!pmi)
+		return;
+
+	ssdfs_map_queue_cache_leaks_decrement(pmi);
+	kmem_cache_free(ssdfs_peb_mapping_info_cachep, pmi);
+}
+
+/*
+ * ssdfs_peb_mapping_info_init() - PEB mapping info initialization
+ * @leb_id: LEB ID
+ * @peb_id: PEB ID
+ * @consistency: consistency state in PEB mapping table cache
+ * @pmi: PEB mapping info [out]
+ */
+void ssdfs_peb_mapping_info_init(u64 leb_id, u64 peb_id, int consistency,
+				 struct ssdfs_peb_mapping_info *pmi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pmi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(pmi, 0, sizeof(struct ssdfs_peb_mapping_info));
+
+	INIT_LIST_HEAD(&pmi->list);
+	pmi->leb_id = leb_id;
+	pmi->peb_id = peb_id;
+	pmi->consistency = consistency;
+}
diff --git a/fs/ssdfs/peb_mapping_queue.h b/fs/ssdfs/peb_mapping_queue.h
new file mode 100644
index 000000000000..0d9c7305c318
--- /dev/null
+++ b/fs/ssdfs/peb_mapping_queue.h
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_mapping_queue.h - PEB mappings queue declarations.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_PEB_MAPPING_QUEUE_H
+#define _SSDFS_PEB_MAPPING_QUEUE_H
+
+/*
+ * struct ssdfs_peb_mapping_queue - PEB mappings queue descriptor
+ * @lock: extents queue's lock
+ * @list: extents queue's list
+ */
+struct ssdfs_peb_mapping_queue {
+	spinlock_t lock;
+	struct list_head list;
+};
+
+/*
+ * struct ssdfs_peb_mapping_info - peb mapping info
+ * @list: extents queue list
+ * @leb_id: LEB ID
+ * @peb_id: PEB ID
+ * @consistency: consistency state in the mapping table cache
+ */
+struct ssdfs_peb_mapping_info {
+	struct list_head list;
+	u64 leb_id;
+	u64 peb_id;
+	int consistency;
+};
+
+/*
+ * PEB mappings queue API
+ */
+void ssdfs_peb_mapping_queue_init(struct ssdfs_peb_mapping_queue *pmq);
+bool is_ssdfs_peb_mapping_queue_empty(struct ssdfs_peb_mapping_queue *pmq);
+void ssdfs_peb_mapping_queue_add_tail(struct ssdfs_peb_mapping_queue *pmq,
+				      struct ssdfs_peb_mapping_info *pmi);
+void ssdfs_peb_mapping_queue_add_head(struct ssdfs_peb_mapping_queue *pmq,
+				      struct ssdfs_peb_mapping_info *pmi);
+int ssdfs_peb_mapping_queue_remove_first(struct ssdfs_peb_mapping_queue *pmq,
+					 struct ssdfs_peb_mapping_info **pmi);
+void ssdfs_peb_mapping_queue_remove_all(struct ssdfs_peb_mapping_queue *pmq);
+
+/*
+ * PEB mapping info's API
+ */
+void ssdfs_zero_peb_mapping_info_cache_ptr(void);
+int ssdfs_init_peb_mapping_info_cache(void);
+void ssdfs_shrink_peb_mapping_info_cache(void);
+void ssdfs_destroy_peb_mapping_info_cache(void);
+
+struct ssdfs_peb_mapping_info *ssdfs_peb_mapping_info_alloc(void);
+void ssdfs_peb_mapping_info_free(struct ssdfs_peb_mapping_info *pmi);
+void ssdfs_peb_mapping_info_init(u64 leb_id, u64 peb_id, int consistency,
+				 struct ssdfs_peb_mapping_info *pmi);
+
+#endif /* _SSDFS_PEB_MAPPING_QUEUE_H */
diff --git a/fs/ssdfs/peb_mapping_table.c b/fs/ssdfs/peb_mapping_table.c
new file mode 100644
index 000000000000..cd5835eb96a2
--- /dev/null
+++ b/fs/ssdfs/peb_mapping_table.c
@@ -0,0 +1,1954 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_mapping_table.c - PEB mapping table implementation.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ *                  Cong Wang
+ */
+
+#include <linux/kernel.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+#include <linux/delay.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "segment_bitmap.h"
+#include "offset_translation_table.h"
+#include "page_array.h"
+#include "page_vector.h"
+#include "peb.h"
+#include "peb_container.h"
+#include "segment.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "extents_tree.h"
+#include "extents_queue.h"
+#include "shared_extents_tree.h"
+#include "snapshots_tree.h"
+#include "peb_mapping_table.h"
+
+#include <trace/events/ssdfs.h>
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_map_tbl_page_leaks;
+atomic64_t ssdfs_map_tbl_memory_leaks;
+atomic64_t ssdfs_map_tbl_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_map_tbl_cache_leaks_increment(void *kaddr)
+ * void ssdfs_map_tbl_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_map_tbl_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_map_tbl_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_map_tbl_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_map_tbl_kfree(void *kaddr)
+ * struct page *ssdfs_map_tbl_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_map_tbl_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_map_tbl_free_page(struct page *page)
+ * void ssdfs_map_tbl_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(map_tbl)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(map_tbl)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_map_tbl_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_map_tbl_page_leaks, 0);
+	atomic64_set(&ssdfs_map_tbl_memory_leaks, 0);
+	atomic64_set(&ssdfs_map_tbl_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_map_tbl_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_map_tbl_page_leaks) != 0) {
+		SSDFS_ERR("MAPPING TABLE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_map_tbl_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_map_tbl_memory_leaks) != 0) {
+		SSDFS_ERR("MAPPING TABLE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_map_tbl_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_map_tbl_cache_leaks) != 0) {
+		SSDFS_ERR("MAPPING TABLE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_map_tbl_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+/*
+ * ssdfs_unused_lebs_in_fragment() - calculate unused LEBs in fragment
+ * @fdesc: fragment descriptor
+ */
+static inline
+u32 ssdfs_unused_lebs_in_fragment(struct ssdfs_maptbl_fragment_desc *fdesc)
+{
+	u32 unused_lebs;
+	u32 reserved_pool;
+
+	reserved_pool = fdesc->reserved_pebs + fdesc->pre_erase_pebs;
+
+	unused_lebs = fdesc->lebs_count;
+	unused_lebs -= fdesc->mapped_lebs + fdesc->migrating_lebs;
+	unused_lebs -= reserved_pool;
+
+	return unused_lebs;
+}
+
+static inline
+u32 ssdfs_lebs_reservation_threshold(struct ssdfs_maptbl_fragment_desc *fdesc)
+{
+	u32 expected2migrate = 0;
+	u32 reserved_pool = 0;
+	u32 migration_NOT_guaranted = 0;
+	u32 threshold;
+
+	expected2migrate = fdesc->mapped_lebs - fdesc->migrating_lebs;
+	reserved_pool = fdesc->reserved_pebs + fdesc->pre_erase_pebs;
+
+	if (expected2migrate > reserved_pool)
+		migration_NOT_guaranted = expected2migrate - reserved_pool;
+	else
+		migration_NOT_guaranted = 0;
+
+	threshold = migration_NOT_guaranted / 10;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lebs_count %u, mapped_lebs %u, "
+		  "migrating_lebs %u, reserved_pebs %u, "
+		  "pre_erase_pebs %u, expected2migrate %u, "
+		  "reserved_pool %u, migration_NOT_guaranted %u, "
+		  "threshold %u\n",
+		  fdesc->lebs_count, fdesc->mapped_lebs,
+		  fdesc->migrating_lebs, fdesc->reserved_pebs,
+		  fdesc->pre_erase_pebs, expected2migrate,
+		  reserved_pool, migration_NOT_guaranted,
+		  threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return threshold;
+}
+
+int ssdfs_maptbl_define_fragment_info(struct ssdfs_fs_info *fsi,
+				      u64 leb_id,
+				      u16 *pebs_per_fragment,
+				      u16 *pebs_per_stripe,
+				      u16 *stripes_per_fragment)
+{
+	struct ssdfs_peb_mapping_table *tbl;
+	u32 fragments_count;
+	u64 lebs_count;
+	u16 pebs_per_fragment_default;
+	u16 pebs_per_stripe_default;
+	u16 stripes_per_fragment_default;
+	u64 fragment_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->maptbl);
+
+	SSDFS_DBG("leb_id %llu\n", leb_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tbl = fsi->maptbl;
+
+	*pebs_per_fragment = U16_MAX;
+	*pebs_per_stripe = U16_MAX;
+	*stripes_per_fragment = U16_MAX;
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_ERROR) {
+		ssdfs_fs_error(tbl->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"maptbl has corrupted state\n");
+		return -EFAULT;
+	}
+
+	down_read(&tbl->tbl_lock);
+	fragments_count = tbl->fragments_count;
+	lebs_count = tbl->lebs_count;
+	pebs_per_fragment_default = tbl->pebs_per_fragment;
+	pebs_per_stripe_default = tbl->pebs_per_stripe;
+	stripes_per_fragment_default = tbl->stripes_per_fragment;
+	up_read(&tbl->tbl_lock);
+
+	if (leb_id >= lebs_count) {
+		SSDFS_ERR("invalid request: "
+			  "leb_id %llu, lebs_count %llu\n",
+			  leb_id, lebs_count);
+		return -EINVAL;
+	}
+
+	fragment_index = div_u64(leb_id, (u32)pebs_per_fragment_default);
+
+	if ((fragment_index + 1) < fragments_count) {
+		*pebs_per_fragment = pebs_per_fragment_default;
+		*pebs_per_stripe = pebs_per_stripe_default;
+		*stripes_per_fragment = stripes_per_fragment_default;
+	} else {
+		u64 rest_pebs;
+
+		rest_pebs = (u64)fragment_index * pebs_per_fragment_default;
+		rest_pebs = lebs_count - rest_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(rest_pebs >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		*pebs_per_fragment = (u16)rest_pebs;
+		*stripes_per_fragment = stripes_per_fragment_default;
+
+		*pebs_per_stripe = *pebs_per_fragment / *stripes_per_fragment;
+		if (*pebs_per_fragment % *stripes_per_fragment)
+			*pebs_per_stripe += 1;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("leb_id %llu, pebs_per_fragment %u, "
+		  "pebs_per_stripe %u, stripes_per_fragment %u\n",
+		  leb_id, *pebs_per_fragment,
+		  *pebs_per_stripe, *stripes_per_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_check_maptbl_sb_header() - check mapping table's sb_header
+ * @fsi: file system info object
+ *
+ * This method checks mapping table description in volume header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO     - maptbl_sb_header is corrupted.
+ * %-EROFS   - mapping table has corrupted state.
+ */
+static
+int ssdfs_check_maptbl_sb_header(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_peb_mapping_table *ptr;
+	u64 calculated;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->maptbl);
+
+	SSDFS_DBG("fsi %p, maptbl %p\n", fsi, fsi->maptbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = fsi->maptbl;
+
+	if (atomic_read(&ptr->flags) & ~SSDFS_MAPTBL_FLAGS_MASK) {
+		SSDFS_CRIT("maptbl header corrupted: "
+			   "unknown flags %#x\n",
+			   atomic_read(&ptr->flags));
+		return -EIO;
+	}
+
+	if (atomic_read(&ptr->flags) & SSDFS_MAPTBL_ERROR) {
+		SSDFS_NOTICE("mapping table has corrupted state: "
+			     "Please, run fsck utility\n");
+		return -EROFS;
+	}
+
+	calculated = (u64)ptr->fragments_per_seg * ptr->fragment_bytes;
+	if (calculated > fsi->segsize) {
+		SSDFS_CRIT("mapping table has corrupted state: "
+			   "fragments_per_seg %u, fragment_bytes %u, "
+			   "segsize %u\n",
+			   ptr->fragments_per_seg,
+			   ptr->fragment_bytes,
+			   fsi->segsize);
+		return -EIO;
+	}
+
+	calculated = (u64)ptr->fragments_per_peb * ptr->fragment_bytes;
+	if (calculated > fsi->erasesize) {
+		SSDFS_CRIT("mapping table has corrupted state: "
+			   "fragments_per_peb %u, fragment_bytes %u, "
+			   "erasesize %u\n",
+			   ptr->fragments_per_peb,
+			   ptr->fragment_bytes,
+			   fsi->erasesize);
+		return -EIO;
+	}
+
+	calculated = (u64)ptr->fragments_per_peb * fsi->pebs_per_seg;
+	if (calculated != ptr->fragments_per_seg) {
+		SSDFS_CRIT("mapping table has corrupted state: "
+			   "fragments_per_peb %u, fragments_per_seg %u, "
+			   "pebs_per_seg %u\n",
+			   ptr->fragments_per_peb,
+			   ptr->fragments_per_seg,
+			   fsi->pebs_per_seg);
+		return -EIO;
+	}
+
+	calculated = fsi->nsegs * fsi->pebs_per_seg;
+	if (ptr->lebs_count != calculated || ptr->pebs_count != calculated) {
+		SSDFS_CRIT("mapping table has corrupted state: "
+			   "lebs_count %llu, pebs_count %llu, "
+			   "nsegs %llu, pebs_per_seg %u\n",
+			   ptr->lebs_count, ptr->pebs_count,
+			   fsi->nsegs, fsi->pebs_per_seg);
+		return -EIO;
+	}
+
+	calculated = (u64)ptr->fragments_count * ptr->lebs_per_fragment;
+	if (ptr->lebs_count > calculated ||
+	    calculated > (ptr->lebs_count + (2 * ptr->lebs_per_fragment))) {
+		SSDFS_CRIT("mapping table has corrupted state: "
+			   "lebs_per_fragment %u, fragments_count %u, "
+			   "lebs_per_fragment %u\n",
+			   ptr->lebs_per_fragment,
+			   ptr->fragments_count,
+			   ptr->lebs_per_fragment);
+		return -EIO;
+	}
+
+	calculated = (u64)ptr->fragments_count * ptr->pebs_per_fragment;
+	if (ptr->pebs_count > calculated ||
+	    calculated > (ptr->pebs_count + (2 * ptr->pebs_per_fragment))) {
+		SSDFS_CRIT("mapping table has corrupted state: "
+			   "pebs_per_fragment %u, fragments_count %u, "
+			   "pebs_per_fragment %u\n",
+			   ptr->pebs_per_fragment,
+			   ptr->fragments_count,
+			   ptr->pebs_per_fragment);
+		return -EIO;
+	}
+
+	calculated = (u64)ptr->pebs_per_stripe * ptr->stripes_per_fragment;
+	if (ptr->pebs_per_fragment != calculated) {
+		SSDFS_CRIT("mapping table has corrupted state: "
+			   "pebs_per_stripe %u, stripes_per_fragment %u, "
+			   "pebs_per_fragment %u\n",
+			   ptr->pebs_per_stripe,
+			   ptr->stripes_per_fragment,
+			   ptr->pebs_per_fragment);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_create_fragment() - initial fragment preparation.
+ * @fsi: file system info object
+ * @index: fragment index
+ */
+static
+int ssdfs_maptbl_create_fragment(struct ssdfs_fs_info *fsi, u32 index)
+{
+	struct ssdfs_maptbl_fragment_desc *ptr;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->maptbl || !fsi->maptbl->desc_array);
+	BUG_ON(index >= fsi->maptbl->fragments_count);
+
+	SSDFS_DBG("fsi %p, index %u\n", fsi, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = &fsi->maptbl->desc_array[index];
+
+	init_rwsem(&ptr->lock);
+	ptr->fragment_id = index;
+	ptr->fragment_pages = fsi->maptbl->fragment_pages;
+	ptr->start_leb = U64_MAX;
+	ptr->lebs_count = U32_MAX;
+	ptr->lebs_per_page = U16_MAX;
+	ptr->lebtbl_pages = U16_MAX;
+	ptr->pebs_per_page = U16_MAX;
+	ptr->stripe_pages = U16_MAX;
+	ptr->mapped_lebs = 0;
+	ptr->migrating_lebs = 0;
+	ptr->reserved_pebs = 0;
+	ptr->pre_erase_pebs = 0;
+	ptr->recovering_pebs = 0;
+
+	err = ssdfs_create_page_array(ptr->fragment_pages, &ptr->array);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create page array: "
+			  "capacity %u, err %d\n",
+			  ptr->fragment_pages, err);
+		return err;
+	}
+
+	init_completion(&ptr->init_end);
+
+	ptr->flush_req1 = NULL;
+	ptr->flush_req2 = NULL;
+	ptr->flush_req_count = 0;
+
+	ptr->flush_seq_size = min_t(u32, ptr->fragment_pages, PAGEVEC_SIZE);
+	ptr->flush_req1 = ssdfs_map_tbl_kcalloc(ptr->flush_seq_size,
+					sizeof(struct ssdfs_segment_request),
+					GFP_KERNEL);
+	if (!ptr->flush_req1) {
+		ssdfs_destroy_page_array(&ptr->array);
+		SSDFS_ERR("fail to allocate flush requests array: "
+			  "array_size %u\n",
+			  ptr->flush_seq_size);
+		return -ENODATA;
+	}
+
+	ptr->flush_req2 = ssdfs_map_tbl_kcalloc(ptr->flush_seq_size,
+					sizeof(struct ssdfs_segment_request),
+					GFP_KERNEL);
+	if (!ptr->flush_req2) {
+		ssdfs_destroy_page_array(&ptr->array);
+		ssdfs_map_tbl_kfree(ptr->flush_req1);
+		ptr->flush_req1 = NULL;
+		SSDFS_ERR("fail to allocate flush requests array: "
+			  "array_size %u\n",
+			  ptr->flush_seq_size);
+		return -ENODATA;
+	}
+
+	atomic_set(&ptr->state, SSDFS_MAPTBL_FRAG_CREATED);
+
+	return 0;
+}
+
+/*
+ * CHECK_META_EXTENT_TYPE() - check type of metadata area's extent
+ */
+static
+int CHECK_META_EXTENT_TYPE(struct ssdfs_meta_area_extent *extent)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (le16_to_cpu(extent->type)) {
+	case SSDFS_EMPTY_EXTENT_TYPE:
+		return -ENODATA;
+
+	case SSDFS_SEG_EXTENT_TYPE:
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/*
+ * ssdfs_maptbl_define_segment_counts() - define total maptbl's segments count
+ * @tbl: mapping table object
+ *
+ * This method determines total count of segments that are allocated
+ * for mapping table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EIO     - extents are corrupted.
+ */
+static
+int ssdfs_maptbl_define_segment_counts(struct ssdfs_peb_mapping_table *tbl)
+{
+	u32 segs_count1 = 0, segs_count2 = 0;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+
+	SSDFS_DBG("tbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < SSDFS_MAPTBL_RESERVED_EXTENTS; i++) {
+		struct ssdfs_meta_area_extent *extent;
+		u32 len1 = 0, len2 = 0;
+
+		extent = &tbl->extents[i][SSDFS_MAIN_MAPTBL_SEG];
+
+		err = CHECK_META_EXTENT_TYPE(extent);
+		if (err == -ENODATA) {
+			/* do nothing */
+			break;
+		} else if (unlikely(err)) {
+			SSDFS_WARN("invalid meta area extent: "
+				   "index %d, err %d\n",
+				   i, err);
+			return err;
+		}
+
+		len1 = le32_to_cpu(extent->len);
+
+		if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY) {
+			extent = &tbl->extents[i][SSDFS_COPY_MAPTBL_SEG];
+
+			err = CHECK_META_EXTENT_TYPE(extent);
+			if (err == -ENODATA) {
+				SSDFS_ERR("empty copy meta area extent: "
+					  "index %d\n", i);
+				return -EIO;
+			} else if (unlikely(err)) {
+				SSDFS_WARN("invalid meta area extent: "
+					   "index %d, err %d\n",
+					   i, err);
+				return err;
+			}
+
+			len2 = le32_to_cpu(extent->len);
+
+			if (len1 != len2) {
+				SSDFS_ERR("different main and copy extents: "
+					  "index %d, len1 %u, len2 %u\n",
+					  i, len1, len2);
+				return -EIO;
+			}
+		}
+
+		segs_count1 += len1;
+		segs_count2 += len2;
+	}
+
+	if (segs_count1 == 0) {
+		SSDFS_CRIT("empty maptbl extents\n");
+		return -EIO;
+	} else if (segs_count1 >= U16_MAX) {
+		SSDFS_CRIT("invalid segment count %u\n",
+			   segs_count1);
+		return -EIO;
+	}
+
+	if (atomic_read(&tbl->flags) & SSDFS_MAPTBL_HAS_COPY &&
+	    segs_count1 != segs_count2) {
+		SSDFS_ERR("segs_count1 %u != segs_count2 %u\n",
+			  segs_count1, segs_count2);
+		return -EIO;
+	}
+
+	tbl->segs_count = (u16)segs_count1;
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_create_segments() - create mapping table's segment objects
+ * @fsi: file system info object
+ * @array_type: main/backup segments chain
+ * @tbl: mapping table object
+ *
+ * This method tries to create mapping table's segment objects.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_maptbl_create_segments(struct ssdfs_fs_info *fsi,
+				 int array_type,
+				 struct ssdfs_peb_mapping_table *tbl)
+{
+	u64 seg;
+	int seg_type = SSDFS_MAPTBL_SEG_TYPE;
+	int seg_state = SSDFS_SEG_LEAF_NODE_USING;
+	u16 log_pages;
+	u8 create_threads;
+	struct ssdfs_segment_info **kaddr = NULL;
+	int i, j;
+	u32 created_segs = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !tbl);
+	BUG_ON(array_type >= SSDFS_MAPTBL_SEG_COPY_MAX);
+	BUG_ON(!rwsem_is_locked(&fsi->volume_sem));
+
+	SSDFS_DBG("fsi %p, array_type %#x, tbl %p, segs_count %u\n",
+		  fsi, array_type, tbl, tbl->segs_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	log_pages = le16_to_cpu(fsi->vh->maptbl_log_pages);
+	create_threads = fsi->create_threads_per_seg;
+
+	tbl->segs[array_type] = ssdfs_map_tbl_kcalloc(tbl->segs_count,
+					sizeof(struct ssdfs_segment_info *),
+					GFP_KERNEL);
+	if (!tbl->segs[array_type]) {
+		SSDFS_ERR("fail to allocate segment array\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < SSDFS_MAPTBL_RESERVED_EXTENTS; i++) {
+		struct ssdfs_meta_area_extent *extent;
+		u64 start_seg;
+		u32 len;
+
+		extent = &tbl->extents[i][array_type];
+
+		err = CHECK_META_EXTENT_TYPE(extent);
+		if (err == -ENODATA) {
+			/* do nothing */
+			break;
+		} else if (unlikely(err)) {
+			SSDFS_WARN("invalid meta area extent: "
+				   "index %d, err %d\n",
+				   i, err);
+			return err;
+		}
+
+		start_seg = le64_to_cpu(extent->start_id);
+		len = le32_to_cpu(extent->len);
+
+		for (j = 0; j < len; j++) {
+			if (created_segs >= tbl->segs_count) {
+				SSDFS_ERR("created_segs %u >= segs_count %u\n",
+					  created_segs, tbl->segs_count);
+				return -ERANGE;
+			}
+
+			seg = start_seg + j;
+			BUG_ON(!tbl->segs[array_type]);
+			kaddr = &tbl->segs[array_type][created_segs];
+			BUG_ON(*kaddr != NULL);
+
+			*kaddr = ssdfs_segment_allocate_object(seg);
+			if (IS_ERR_OR_NULL(*kaddr)) {
+				err = !*kaddr ? -ENOMEM : PTR_ERR(*kaddr);
+				*kaddr = NULL;
+				SSDFS_ERR("fail to allocate segment object: "
+					  "seg %llu, err %d\n",
+					  seg, err);
+				return err;
+			}
+
+			err = ssdfs_segment_create_object(fsi, seg, seg_state,
+							  seg_type, log_pages,
+							  create_threads,
+							  *kaddr);
+			if (err == -EINTR) {
+				/*
+				 * Ignore this error.
+				 */
+				return err;
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to create segment: "
+					  "seg %llu, err %d\n",
+					  seg, err);
+				return err;
+			}
+
+			ssdfs_segment_get_object(*kaddr);
+			created_segs++;
+		}
+	}
+
+	if (created_segs != tbl->segs_count) {
+		SSDFS_ERR("created_segs %u != tbl->segs_count %u\n",
+			  created_segs, tbl->segs_count);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_destroy_segments() - destroy mapping table's segment objects
+ * @tbl: mapping table object
+ */
+static
+void ssdfs_maptbl_destroy_segments(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_segment_info *si;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < tbl->segs_count; i++) {
+		for (j = 0; j < SSDFS_MAPTBL_SEG_COPY_MAX; j++) {
+			if (tbl->segs[j] == NULL)
+				continue;
+
+			si = tbl->segs[j][i];
+
+			ssdfs_segment_put_object(si);
+			err = ssdfs_segment_destroy_object(si);
+			if (unlikely(err == -EBUSY))
+				BUG();
+			else if (unlikely(err)) {
+				SSDFS_WARN("issue during segment destroy: "
+					   "err %d\n",
+					   err);
+			}
+		}
+	}
+
+	for (i = 0; i < SSDFS_MAPTBL_SEG_COPY_MAX; i++) {
+		ssdfs_map_tbl_kfree(tbl->segs[i]);
+		tbl->segs[i] = NULL;
+	}
+}
+
+/*
+ * ssdfs_maptbl_destroy_fragment() - destroy mapping table's fragment
+ * @fsi: file system info object
+ * @index: fragment index
+ */
+inline
+void ssdfs_maptbl_destroy_fragment(struct ssdfs_fs_info *fsi, u32 index)
+{
+	struct ssdfs_maptbl_fragment_desc *ptr;
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !fsi->maptbl || !fsi->maptbl->desc_array);
+	BUG_ON(index >= fsi->maptbl->fragments_count);
+
+	SSDFS_DBG("fsi %p, index %u\n", fsi, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ptr = &fsi->maptbl->desc_array[index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(rwsem_is_locked(&ptr->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&ptr->state);
+
+	if (state == SSDFS_MAPTBL_FRAG_DIRTY)
+		SSDFS_WARN("fragment %u is dirty\n", index);
+	else if (state == SSDFS_MAPTBL_FRAG_INIT_FAILED) {
+		SSDFS_DBG("fragment %u init was failed\n", index);
+		return;
+	} else if (state >= SSDFS_MAPTBL_FRAG_STATE_MAX)
+		BUG();
+
+	if (ptr->flush_req1) {
+		ssdfs_map_tbl_kfree(ptr->flush_req1);
+		ptr->flush_req1 = NULL;
+	}
+
+	if (ptr->flush_req2) {
+		ssdfs_map_tbl_kfree(ptr->flush_req2);
+		ptr->flush_req2 = NULL;
+	}
+
+	ssdfs_destroy_page_array(&ptr->array);
+	complete_all(&ptr->init_end);
+}
+
+/*
+ * ssdfs_maptbl_segment_init() - initiate mapping table's segment init
+ * @tbl: mapping table object
+ * @si: segment object
+ * @seg_index: index of segment in the sequence
+ */
+static
+int ssdfs_maptbl_segment_init(struct ssdfs_peb_mapping_table *tbl,
+			      struct ssdfs_segment_info *si,
+			      int seg_index)
+{
+	u32 page_size;
+	u64 logical_offset;
+	u64 logical_blk;
+	u32 blks_count;
+	u32 fragment_bytes = tbl->fragment_bytes;
+	u64 bytes_per_peb = (u64)tbl->fragments_per_peb * fragment_bytes;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+
+	SSDFS_DBG("si %p, seg %llu, seg_index %d\n",
+		  si, si->seg_id, seg_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_size = si->fsi->pagesize;
+	logical_offset = bytes_per_peb * si->pebs_count * seg_index;
+
+	for (i = 0; i < si->pebs_count; i++) {
+		struct ssdfs_peb_container *pebc = &si->peb_array[i];
+		struct ssdfs_segment_request *req;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (is_peb_container_empty(pebc)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("PEB container empty: "
+				  "seg %llu, peb_index %d\n",
+				  si->seg_id, i);
+#endif /* CONFIG_SSDFS_DEBUG */
+			continue;
+		}
+
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			req = NULL;
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		logical_offset += bytes_per_peb * i;
+
+		ssdfs_request_prepare_logical_extent(SSDFS_MAPTBL_INO,
+						     logical_offset,
+						     fragment_bytes,
+						     0, 0, req);
+		ssdfs_request_define_segment(si->seg_id, req);
+
+		logical_blk = (u64)i * fragment_bytes;
+		logical_blk = div64_u64(logical_blk, si->fsi->pagesize);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(logical_blk >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		blks_count = (fragment_bytes + page_size - 1) / page_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(blks_count >= U16_MAX);
+
+		SSDFS_DBG("seg %llu, peb_index %d, "
+			  "logical_blk %llu, blks_count %u, "
+			  "fragment_bytes %u, page_size %u, "
+			  "logical_offset %llu\n",
+			  si->seg_id, i,
+			  logical_blk, blks_count,
+			  fragment_bytes, page_size,
+			  logical_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_request_define_volume_extent((u16)logical_blk,
+						   (u16) blks_count,
+						   req);
+
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+						    SSDFS_READ_INIT_MAPTBL,
+						    SSDFS_REQ_ASYNC,
+						    req);
+		ssdfs_peb_read_request_cno(pebc);
+		ssdfs_requests_queue_add_tail(&pebc->read_rq, req);
+	}
+
+	wake_up_all(&si->wait_queue[SSDFS_PEB_READ_THREAD]);
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_init() - initiate mapping table's initialization procedure
+ * @tbl: mapping table object
+ */
+static
+int ssdfs_maptbl_init(struct ssdfs_peb_mapping_table *tbl)
+{
+	struct ssdfs_segment_info *si;
+	int i, j;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl);
+
+	SSDFS_DBG("maptbl %p\n", tbl);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < tbl->segs_count; i++) {
+		for (j = 0; j < SSDFS_MAPTBL_SEG_COPY_MAX; j++) {
+			if (tbl->segs[j] == NULL)
+				continue;
+
+			si = tbl->segs[j][i];
+
+			if (!si)
+				continue;
+
+			err = ssdfs_maptbl_segment_init(tbl, si, i);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to init segment: "
+					  "seg %llu, err %d\n",
+					  si->seg_id, err);
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_maptbl_create() - create mapping table object
+ * @fsi: file system info object
+ */
+int ssdfs_maptbl_create(struct ssdfs_fs_info *fsi)
+{
+	struct ssdfs_peb_mapping_table *ptr;
+	size_t maptbl_obj_size = sizeof(struct ssdfs_peb_mapping_table);
+	size_t frag_desc_size = sizeof(struct ssdfs_maptbl_fragment_desc);
+	void *kaddr;
+	size_t bytes_count;
+	size_t bmap_bytes;
+	int array_type;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, segs_count %llu\n", fsi, fsi->nsegs);
+#else
+	SSDFS_DBG("fsi %p, segs_count %llu\n", fsi, fsi->nsegs);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	kaddr = ssdfs_map_tbl_kzalloc(maptbl_obj_size, GFP_KERNEL);
+	if (!kaddr) {
+		SSDFS_ERR("fail to allocate mapping table object\n");
+		return -ENOMEM;
+	}
+
+	fsi->maptbl = ptr = (struct ssdfs_peb_mapping_table *)kaddr;
+
+	ptr->fsi = fsi;
+
+	init_rwsem(&ptr->tbl_lock);
+
+	atomic_set(&ptr->flags, le16_to_cpu(fsi->vh->maptbl.flags));
+	ptr->fragments_count = le32_to_cpu(fsi->vh->maptbl.fragments_count);
+	ptr->fragment_bytes = le32_to_cpu(fsi->vh->maptbl.fragment_bytes);
+	ptr->fragment_pages = (ptr->fragment_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+	ptr->fragments_per_seg = le16_to_cpu(fsi->vh->maptbl.fragments_per_seg);
+	ptr->fragments_per_peb = le16_to_cpu(fsi->vh->maptbl.fragments_per_peb);
+	ptr->lebs_count = le64_to_cpu(fsi->vh->maptbl.lebs_count);
+	ptr->pebs_count = le64_to_cpu(fsi->vh->maptbl.pebs_count);
+	ptr->lebs_per_fragment = le16_to_cpu(fsi->vh->maptbl.lebs_per_fragment);
+	ptr->pebs_per_fragment = le16_to_cpu(fsi->vh->maptbl.pebs_per_fragment);
+	ptr->pebs_per_stripe = le16_to_cpu(fsi->vh->maptbl.pebs_per_stripe);
+	ptr->stripes_per_fragment =
+		le16_to_cpu(fsi->vh->maptbl.stripes_per_fragment);
+
+	atomic_set(&ptr->erase_op_state, SSDFS_MAPTBL_NO_ERASE);
+	atomic_set(&ptr->pre_erase_pebs,
+		   le16_to_cpu(fsi->vh->maptbl.pre_erase_pebs));
+	/*
+	 * TODO: the max_erase_ops field should be used by GC or
+	 *       special management thread for determination of
+	 *       upper bound of erase operations for one iteration
+	 *       with the goal to orchestrate I/O load with
+	 *       erasing load. But if it will be used TRIM command
+	 *       for erasing then maybe the erasing load will be
+	 *       no so sensitive.
+	 */
+	atomic_set(&ptr->max_erase_ops, ptr->pebs_count);
+
+	init_waitqueue_head(&ptr->erase_ops_end_wq);
+
+	atomic64_set(&ptr->last_peb_recover_cno,
+		     le64_to_cpu(fsi->vh->maptbl.last_peb_recover_cno));
+
+	bytes_count = sizeof(struct ssdfs_meta_area_extent);
+	bytes_count *= SSDFS_MAPTBL_RESERVED_EXTENTS;
+	bytes_count *= SSDFS_MAPTBL_SEG_COPY_MAX;
+	ssdfs_memcpy(ptr->extents, 0, bytes_count,
+		     fsi->vh->maptbl.extents, 0, bytes_count,
+		     bytes_count);
+
+	mutex_init(&ptr->bmap_lock);
+	bmap_bytes = ptr->fragments_count + BITS_PER_LONG - 1;
+	bmap_bytes /= BITS_PER_BYTE;
+	ptr->dirty_bmap = ssdfs_map_tbl_kzalloc(bmap_bytes, GFP_KERNEL);
+	if (!ptr->dirty_bmap) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate dirty_bmap\n");
+		goto free_maptbl_object;
+	}
+
+	init_waitqueue_head(&ptr->wait_queue);
+
+	err = ssdfs_check_maptbl_sb_header(fsi);
+	if (unlikely(err)) {
+		SSDFS_ERR("mapping table is corrupted: err %d\n", err);
+		goto free_dirty_bmap;
+	}
+
+	kaddr = ssdfs_map_tbl_kcalloc(ptr->fragments_count,
+					frag_desc_size, GFP_KERNEL);
+	if (!kaddr) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate fragment descriptors array\n");
+		goto free_dirty_bmap;
+	}
+
+	ptr->desc_array = (struct ssdfs_maptbl_fragment_desc *)kaddr;
+
+	for (i = 0; i < ptr->fragments_count; i++) {
+		err = ssdfs_maptbl_create_fragment(fsi, i);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to create fragment: "
+				  "index %d, err %d\n",
+				  i, err);
+
+			for (--i; i >= 0; i--) {
+				/* Destroy created fragments */
+				ssdfs_maptbl_destroy_fragment(fsi, i);
+			}
+
+			goto free_fragment_descriptors;
+		}
+	}
+
+	err = ssdfs_maptbl_define_segment_counts(ptr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define segments count: err %d\n", err);
+		goto free_fragment_descriptors;
+	}
+
+	array_type = SSDFS_MAIN_MAPTBL_SEG;
+	err = ssdfs_maptbl_create_segments(fsi, array_type, ptr);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto destroy_seg_objects;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to create maptbl's segment objects: "
+			  "err %d\n", err);
+		goto destroy_seg_objects;
+	}
+
+	if (atomic_read(&ptr->flags) & SSDFS_MAPTBL_HAS_COPY) {
+		array_type = SSDFS_COPY_MAPTBL_SEG;
+		err = ssdfs_maptbl_create_segments(fsi, array_type, ptr);
+		if (err == -EINTR) {
+			/*
+			 * Ignore this error.
+			 */
+			goto destroy_seg_objects;
+		} if (unlikely(err)) {
+			SSDFS_ERR("fail to create segbmap's segment objects: "
+				  "err %d\n", err);
+			goto destroy_seg_objects;
+		}
+	}
+
+	err = ssdfs_maptbl_init(ptr);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to init mapping table: err %d\n",
+			  err);
+		goto destroy_seg_objects;
+	}
+
+	err = ssdfs_maptbl_start_thread(ptr);
+	if (err == -EINTR) {
+		/*
+		 * Ignore this error.
+		 */
+		goto destroy_seg_objects;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to start mapping table's thread: "
+			  "err %d\n", err);
+		goto destroy_seg_objects;
+	}
+
+	atomic_set(&ptr->state, SSDFS_MAPTBL_CREATED);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("DONE: create mapping table\n");
+#else
+	SSDFS_DBG("DONE: create mapping table\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+
+destroy_seg_objects:
+	ssdfs_maptbl_destroy_segments(ptr);
+
+free_fragment_descriptors:
+	ssdfs_map_tbl_kfree(ptr->desc_array);
+
+free_dirty_bmap:
+	ssdfs_map_tbl_kfree(fsi->maptbl->dirty_bmap);
+	fsi->maptbl->dirty_bmap = NULL;
+
+free_maptbl_object:
+	ssdfs_map_tbl_kfree(fsi->maptbl);
+	fsi->maptbl = NULL;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(err == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_destroy() - destroy mapping table object
+ * @fsi: file system info object
+ */
+void ssdfs_maptbl_destroy(struct ssdfs_fs_info *fsi)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("maptbl %p\n", fsi->maptbl);
+#else
+	SSDFS_DBG("maptbl %p\n", fsi->maptbl);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!fsi->maptbl)
+		return;
+
+	ssdfs_maptbl_destroy_segments(fsi->maptbl);
+
+	for (i = 0; i < fsi->maptbl->fragments_count; i++)
+		ssdfs_maptbl_destroy_fragment(fsi, i);
+
+	ssdfs_map_tbl_kfree(fsi->maptbl->desc_array);
+	ssdfs_map_tbl_kfree(fsi->maptbl->dirty_bmap);
+	fsi->maptbl->dirty_bmap = NULL;
+	ssdfs_map_tbl_kfree(fsi->maptbl);
+	fsi->maptbl = NULL;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_maptbl_fragment_desc_init() - prepare fragment descriptor
+ * @tbl: mapping table object
+ * @area: mapping table's area descriptor
+ * @fdesc: mapping table's fragment descriptor
+ */
+static
+void ssdfs_maptbl_fragment_desc_init(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_area *area,
+				     struct ssdfs_maptbl_fragment_desc *fdesc)
+{
+	u32 aligned_lebs_count;
+	u16 lebs_per_page;
+	u32 pebs_count;
+	u32 aligned_pebs_count, aligned_stripe_pebs;
+	u16 pebs_per_page;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tbl || !area || !fdesc);
+	BUG_ON(!rwsem_is_locked(&tbl->tbl_lock));
+	BUG_ON(!rwsem_is_locked(&fdesc->lock));
+
+	SSDFS_DBG("portion_id %u, tbl %p, "
+		  "area %p, fdesc %p\n",
+		  area->portion_id, tbl, area, fdesc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fdesc->start_leb = (u64)area->portion_id * tbl->lebs_per_fragment;
+	fdesc->lebs_count = (u32)min_t(u64, (u64)tbl->lebs_per_fragment,
+					tbl->lebs_count - fdesc->start_leb);
+
+	lebs_per_page = SSDFS_LEB_DESC_PER_FRAGMENT(PAGE_SIZE);
+	aligned_lebs_count = fdesc->lebs_count + lebs_per_page - 1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON((aligned_lebs_count / lebs_per_page) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	fdesc->lebtbl_pages = (u16)(aligned_lebs_count / lebs_per_page);
+
+	fdesc->lebs_per_page = lebs_per_page;
+
+	pebs_count = fdesc->lebs_count;
+	pebs_per_page = SSDFS_PEB_DESC_PER_FRAGMENT(PAGE_SIZE);
+
+	aligned_pebs_count = pebs_count +
+				(pebs_count % tbl->stripes_per_fragment);
+	aligned_stripe_pebs = aligned_pebs_count / tbl->stripes_per_fragment;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(((aligned_stripe_pebs + pebs_per_page - 1) /
+		pebs_per_page) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	fdesc->stripe_pages = (aligned_stripe_pebs + pebs_per_page - 1) /
+				pebs_per_page;
+
+	fdesc->pebs_per_page = pebs_per_page;
+}
+
+/*
+ * ssdfs_maptbl_check_lebtbl_page() - check LEB table's page
+ * @page: memory page with LEB table's fragment
+ * @portion_id: portion identification number
+ * @fragment_id: portion's fragment identification number
+ * @fdesc: mapping table's fragment descriptor
+ * @page_index: index of page inside of LEB table
+ * @lebs_per_fragment: pointer on counter of LEBs in fragment [in|out]
+ *
+ * This method checks LEB table's page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - fragment's LEB table is corrupted.
+ */
+static
+int ssdfs_maptbl_check_lebtbl_page(struct page *page,
+				   u16 portion_id, u16 fragment_id,
+				   struct ssdfs_maptbl_fragment_desc *fdesc,
+				   int page_index,
+				   u16 *lebs_per_fragment)
+{
+	void *kaddr;
+	struct ssdfs_leb_table_fragment_header *hdr;
+	u32 bytes_count;
+	__le32 csum;
+	u64 start_leb;
+	u16 lebs_count, mapped_lebs, migrating_lebs;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!page || !fdesc || !lebs_per_fragment);
+	BUG_ON(*lebs_per_fragment == U16_MAX);
+
+	if (page_index >= fdesc->lebtbl_pages) {
+		SSDFS_ERR("page_index %d >= fdesc->lebtbl_pages %u\n",
+			  page_index, fdesc->lebtbl_pages);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("page %p, portion_id %u, fragment_id %u, "
+		  "fdesc %p, page_index %d, "
+		  "lebs_per_fragment %u\n",
+		  page, portion_id, fragment_id,
+		  fdesc, page_index,
+		  *lebs_per_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+	hdr = (struct ssdfs_leb_table_fragment_header *)kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PAGE DUMP: page_index %u\n",
+		  page_index);
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr,
+			     PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (le16_to_cpu(hdr->magic) != SSDFS_LEB_TABLE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid LEB table's magic signature: "
+			  "page_index %d\n",
+			  page_index);
+		goto finish_lebtbl_check;
+	}
+
+	bytes_count = le32_to_cpu(hdr->bytes_count);
+	if (bytes_count > PAGE_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("invalid bytes_count %u\n",
+			  bytes_count);
+		goto finish_lebtbl_check;
+	}
+
+	csum = hdr->checksum;
+	hdr->checksum = 0;
+	hdr->checksum = ssdfs_crc32_le(kaddr, bytes_count);
+	if (hdr->checksum != csum) {
+		err = -EIO;
+		SSDFS_ERR("hdr->checksum %u != csum %u\n",
+			  le32_to_cpu(hdr->checksum),
+			  le32_to_cpu(csum));
+		hdr->checksum = csum;
+		goto finish_lebtbl_check;
+	}
+
+	if (le16_to_cpu(hdr->portion_id) != portion_id ||
+	    le16_to_cpu(hdr->fragment_id) != fragment_id) {
+		err = -EIO;
+		SSDFS_ERR("hdr->portion_id %u != portion_id %u OR "
+			  "hdr->fragment_id %u != fragment_id %u\n",
+			  le16_to_cpu(hdr->portion_id),
+			  portion_id,
+			  le16_to_cpu(hdr->fragment_id),
+			  fragment_id);
+		goto finish_lebtbl_check;
+	}
+
+	if (hdr->flags != 0) {
+		err = -EIO;
+		SSDFS_ERR("unsupported flags %#x\n",
+			  le16_to_cpu(hdr->flags));
+		goto finish_lebtbl_check;
+	}
+
+	start_leb = fdesc->start_leb + ((u64)fdesc->lebs_per_page * page_index);
+	if (start_leb != le64_to_cpu(hdr->start_leb)) {
+		err = -EIO;
+		SSDFS_ERR("hdr->start_leb %llu != start_leb %llu\n",
+			  le64_to_cpu(hdr->start_leb),
+			  start_leb);
+		goto finish_lebtbl_check;
+	}
+
+	lebs_count = le16_to_cpu(hdr->lebs_count);
+	mapped_lebs = le16_to_cpu(hdr->mapped_lebs);
+	migrating_lebs = le16_to_cpu(hdr->migrating_lebs);
+
+	if (lebs_count > fdesc->lebs_per_page) {
+		err = -EIO;
+		SSDFS_ERR("lebs_count %u > fdesc->lebs_per_page %u\n",
+			  lebs_count, fdesc->lebs_per_page);
+		goto finish_lebtbl_check;
+	}
+
+	if (lebs_count < (mapped_lebs + migrating_lebs)) {
+		err = -EIO;
+		SSDFS_ERR("lebs_count %u, mapped_lebs %u, migrating_lebs %u\n",
+			  lebs_count, mapped_lebs, migrating_lebs);
+		goto finish_lebtbl_check;
+	}
+
+	fdesc->mapped_lebs += mapped_lebs;
+	fdesc->migrating_lebs += migrating_lebs;
+
+	*lebs_per_fragment += lebs_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mapped_lebs %u, migrating_lebs %u\n",
+		  fdesc->mapped_lebs, fdesc->migrating_lebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_lebtbl_check:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_check_pebtbl_page() - check page in stripe of PEB table
+ * @pebc: pointer on PEB container
+ * @page: memory page with PEB table's fragment
+ * @portion_id: portion identification number
+ * @fragment_id: portion's fragment identification number
+ * @fdesc: mapping table's fragment descriptor
+ * @stripe_id: PEB table's stripe identification number
+ * @page_index: index of page inside of PEB table's stripe
+ * @pebs_per_fragment: pointer on counter of PEBs in fragment [in|out]
+ *
+ * This method checks PEB table's page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EIO        - fragment's PEB table is corrupted.
+ */
+static
+int ssdfs_maptbl_check_pebtbl_page(struct ssdfs_peb_container *pebc,
+				   struct page *page,
+				   u16 portion_id, u16 fragment_id,
+				   struct ssdfs_maptbl_fragment_desc *fdesc,
+				   int stripe_id,
+				   int page_index,
+				   u16 *pebs_per_fragment)
+{
+	struct ssdfs_fs_info *fsi;
+	void *kaddr;
+	struct ssdfs_peb_table_fragment_header *hdr;
+	u32 bytes_count;
+	__le32 csum;
+	u16 pebs_count;
+	u16 reserved_pebs;
+	u16 used_pebs;
+	u16 unused_pebs = 0;
+	unsigned long *bmap;
+	int pre_erase_pebs, recovering_pebs;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !page || !fdesc || !pebs_per_fragment);
+	BUG_ON(*pebs_per_fragment == U16_MAX);
+
+	if (page_index >= fdesc->stripe_pages) {
+		SSDFS_ERR("page_index %d >= fdesc->stripe_pages %u\n",
+			  page_index, fdesc->stripe_pages);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("seg %llu, peb_index %u\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index);
+	SSDFS_DBG("page %p, portion_id %u, fragment_id %u, "
+		  "fdesc %p, stripe_id %d, page_index %d, "
+		  "pebs_per_fragment %u\n",
+		  page, portion_id, fragment_id,
+		  fdesc, stripe_id, page_index,
+		  *pebs_per_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = pebc->parent_si->fsi;
+
+	ssdfs_lock_page(page);
+	kaddr = kmap_local_page(page);
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("PAGE DUMP: page_index %u\n",
+		  page_index);
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     kaddr,
+			     PAGE_SIZE);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (le16_to_cpu(hdr->magic) != SSDFS_PEB_TABLE_MAGIC) {
+		err = -EIO;
+		SSDFS_ERR("invalid PEB table's magic signature: "
+			  "stripe_id %d, page_index %d\n",
+			  stripe_id, page_index);
+		goto finish_pebtbl_check;
+	}
+
+	bytes_count = le32_to_cpu(hdr->bytes_count);
+	if (bytes_count > PAGE_SIZE) {
+		err = -EIO;
+		SSDFS_ERR("invalid bytes_count %u\n",
+			  bytes_count);
+		goto finish_pebtbl_check;
+	}
+
+	csum = hdr->checksum;
+	hdr->checksum = 0;
+	hdr->checksum = ssdfs_crc32_le(kaddr, bytes_count);
+	if (hdr->checksum != csum) {
+		err = -EIO;
+		SSDFS_ERR("hdr->checksum %u != csum %u\n",
+			  le32_to_cpu(hdr->checksum),
+			  le32_to_cpu(csum));
+		hdr->checksum = csum;
+		goto finish_pebtbl_check;
+	}
+
+	if (le16_to_cpu(hdr->portion_id) != portion_id ||
+	    le16_to_cpu(hdr->fragment_id) != fragment_id) {
+		err = -EIO;
+		SSDFS_ERR("hdr->portion_id %u != portion_id %u OR "
+			  "hdr->fragment_id %u != fragment_id %u\n",
+			  le16_to_cpu(hdr->portion_id),
+			  portion_id,
+			  le16_to_cpu(hdr->fragment_id),
+			  fragment_id);
+		goto finish_pebtbl_check;
+	}
+
+	if (hdr->flags != 0) {
+		err = -EIO;
+		SSDFS_ERR("unsupported flags %#x\n",
+			  hdr->flags);
+		goto finish_pebtbl_check;
+	}
+
+	if (le16_to_cpu(hdr->stripe_id) != stripe_id) {
+		err = -EIO;
+		SSDFS_ERR("hdr->stripe_id %u != stripe_id %d\n",
+			  le16_to_cpu(hdr->stripe_id),
+			  stripe_id);
+		goto finish_pebtbl_check;
+	}
+
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+	reserved_pebs = le16_to_cpu(hdr->reserved_pebs);
+	fdesc->reserved_pebs += reserved_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hdr->start_peb %llu, hdr->pebs_count %u\n",
+		  le64_to_cpu(hdr->start_peb), pebs_count);
+	SSDFS_DBG("hdr->reserved_pebs %u\n", reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pebs_count > fdesc->pebs_per_page) {
+		err = -EIO;
+		SSDFS_ERR("pebs_count %u > fdesc->pebs_per_page %u\n",
+			  pebs_count, fdesc->pebs_per_page);
+		goto finish_pebtbl_check;
+	}
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_USED_BMAP][0];
+	used_pebs = bitmap_weight(bmap, pebs_count);
+
+	if (used_pebs > pebs_count) {
+		err = -EIO;
+		SSDFS_ERR("used_pebs %u > pebs_count %u\n",
+			  used_pebs, pebs_count);
+		goto finish_pebtbl_check;
+	}
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_DIRTY_BMAP][0];
+	pre_erase_pebs = bitmap_weight(bmap, pebs_count);
+	fdesc->pre_erase_pebs += pre_erase_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("fragment_id %u, stripe_id %u, pre_erase_pebs %u\n",
+		  fragment_id, stripe_id, fdesc->pre_erase_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap = (unsigned long *)&hdr->bmaps[SSDFS_PEBTBL_RECOVER_BMAP][0];
+	recovering_pebs = bitmap_weight(bmap, pebs_count);
+	fdesc->recovering_pebs += recovering_pebs;
+
+	*pebs_per_fragment += pebs_count;
+
+	unused_pebs = pebs_count - used_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebs_count %u, used_pebs %u, "
+		  "unused_pebs %u, reserved_pebs %u\n",
+		  pebs_count, used_pebs,
+		  unused_pebs, reserved_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unused_pebs < reserved_pebs) {
+		err = -EIO;
+		SSDFS_ERR("unused_pebs %u < reserved_pebs %u\n",
+			  unused_pebs, reserved_pebs);
+		goto finish_pebtbl_check;
+	}
+
+	unused_pebs -= reserved_pebs;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pebs_count %u, used_pebs %u, "
+		  "reserved_pebs %u, unused_pebs %u\n",
+		  pebs_count, used_pebs,
+		  reserved_pebs, unused_pebs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_pebtbl_check:
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+
+	if (!err) {
+		u32 unused_lebs;
+		u64 free_pages;
+		u64 unused_pages = 0;
+		u32 threshold;
+
+		unused_lebs = ssdfs_unused_lebs_in_fragment(fdesc);
+		threshold = ssdfs_lebs_reservation_threshold(fdesc);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unused_pebs %u, unused_lebs %u, threshold %u\n",
+			  unused_pebs, unused_lebs, threshold);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (unused_lebs > threshold) {
+			unused_pages = (u64)unused_pebs * fsi->pages_per_peb;
+
+			spin_lock(&fsi->volume_state_lock);
+			fsi->free_pages += unused_pages;
+			free_pages = fsi->free_pages;
+			spin_unlock(&fsi->volume_state_lock);
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			spin_lock(&fsi->volume_state_lock);
+			free_pages = fsi->free_pages;
+			spin_unlock(&fsi->volume_state_lock);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("seg %llu, peb_index %u, "
+			  "free_pages %llu, unused_pages %llu\n",
+			  pebc->parent_si->seg_id,
+			  pebc->peb_index, free_pages, unused_pages);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_maptbl_move_fragment_pages() - move fragment's pages
+ * @req: segment request
+ * @area: fragment's pages
+ * @pages_count: pages count in area
+ */
+void ssdfs_maptbl_move_fragment_pages(struct ssdfs_segment_request *req,
+				      struct ssdfs_maptbl_area *area,
+				      u16 pages_count)
+{
+	struct page *page;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!req || !area);
+
+	SSDFS_DBG("req %p, area %p\n",
+		  req, area);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < pages_count; i++) {
+		page = req->result.pvec.pages[i];
+		area->pages[area->pages_count] = page;
+		area->pages_count++;
+		ssdfs_map_tbl_account_page(page);
+		ssdfs_request_unlock_and_remove_page(req, i);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	for (i = 0; i < pagevec_count(&req->result.pvec); i++) {
+		page = req->result.pvec.pages[i];
+
+		if (page) {
+			SSDFS_ERR("page %d is valid\n", i);
+			BUG_ON(page);
+		}
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	pagevec_reinit(&req->result.pvec);
+}
+
+/*
+ * ssdfs_maptbl_fragment_init() - init mapping table's fragment
+ * @pebc: pointer on PEB container
+ * @area: mapping table's area descriptor
+ *
+ * This method tries to initialize mapping table's fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EIO        - fragment is corrupted.
+ */
+int ssdfs_maptbl_fragment_init(struct ssdfs_peb_container *pebc,
+				struct ssdfs_maptbl_area *area)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_peb_mapping_table *tbl;
+	struct ssdfs_maptbl_fragment_desc *fdesc;
+	int state;
+	u16 lebs_per_fragment = 0, pebs_per_fragment = 0;
+	u32 calculated;
+	int page_index;
+	int fragment_id;
+	int i, j;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc || !pebc->parent_si || !pebc->parent_si->fsi);
+	BUG_ON(!pebc->parent_si->fsi->maptbl || !area);
+	BUG_ON(!rwsem_is_locked(&pebc->parent_si->fsi->maptbl->tbl_lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("seg %llu, peb_index %u, portion_id %u, "
+		  "pages_count %zu, pages_capacity %zu\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, area->portion_id,
+		  area->pages_count, area->pages_capacity);
+#else
+	SSDFS_DBG("seg %llu, peb_index %u, portion_id %u, "
+		  "pages_count %zu, pages_capacity %zu\n",
+		  pebc->parent_si->seg_id,
+		  pebc->peb_index, area->portion_id,
+		  area->pages_count, area->pages_capacity);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = pebc->parent_si->fsi;
+	tbl = fsi->maptbl;
+
+	if (area->pages_count > area->pages_capacity) {
+		SSDFS_ERR("area->pages_count %zu > area->pages_capacity %zu\n",
+			  area->pages_count,
+			  area->pages_capacity);
+		return -EINVAL;
+	}
+
+	if (area->pages_count > tbl->fragment_pages) {
+		SSDFS_ERR("area->pages_count %zu > tbl->fragment_pages %u\n",
+			  area->pages_count,
+			  tbl->fragment_pages);
+		return -EINVAL;
+	}
+
+	if (area->portion_id >= tbl->fragments_count) {
+		SSDFS_ERR("invalid index: "
+			  "portion_id %u, fragment_count %u\n",
+			  area->portion_id,
+			  tbl->fragments_count);
+		return -EINVAL;
+	}
+
+	fdesc = &tbl->desc_array[area->portion_id];
+
+	state = atomic_read(&fdesc->state);
+	if (state != SSDFS_MAPTBL_FRAG_CREATED) {
+		SSDFS_ERR("invalid fragment state %#x\n", state);
+		return -ERANGE;
+	}
+
+	down_write(&fdesc->lock);
+
+	ssdfs_maptbl_fragment_desc_init(tbl, area, fdesc);
+
+	calculated = fdesc->lebtbl_pages;
+	calculated += fdesc->stripe_pages * tbl->stripes_per_fragment;
+	if (calculated != area->pages_count) {
+		err = -EIO;
+		SSDFS_ERR("calculated %u != area->pages_count %zu\n",
+			  calculated, area->pages_count);
+		goto finish_fragment_init;
+	}
+
+	page_index = 0;
+
+	for (i = 0; i < fdesc->lebtbl_pages; i++) {
+		struct page *page;
+
+		if (page_index >= area->pages_count) {
+			err = -ERANGE;
+			SSDFS_ERR("page_index %d >= pages_count %zu\n",
+				  page_index, area->pages_count);
+			goto finish_fragment_init;
+		}
+
+		page = area->pages[page_index];
+		if (!page) {
+			err = -ERANGE;
+			SSDFS_ERR("page %d is absent\n", i);
+			goto finish_fragment_init;
+		}
+
+		err = ssdfs_maptbl_check_lebtbl_page(page,
+						     area->portion_id, i,
+						     fdesc, i,
+						     &lebs_per_fragment);
+		if (unlikely(err)) {
+			SSDFS_ERR("maptbl's page %d is corrupted: "
+				  "err %d\n",
+				  page_index, err);
+			goto finish_fragment_init;
+		}
+
+		page_index++;
+	}
+
+	if (fdesc->lebs_count < (fdesc->mapped_lebs + fdesc->migrating_lebs)) {
+		err = -EIO;
+		SSDFS_ERR("lebs_count %u, mapped_lebs %u, migratind_lebs %u\n",
+			  fdesc->lebs_count,
+			  fdesc->mapped_lebs,
+			  fdesc->migrating_lebs);
+		goto finish_fragment_init;
+	}
+
+	if (fdesc->lebs_count < fdesc->pre_erase_pebs) {
+		err = -EIO;
+		SSDFS_ERR("lebs_count %u, pre_erase_pebs %u\n",
+			  fdesc->lebs_count,
+			  fdesc->pre_erase_pebs);
+		goto finish_fragment_init;
+	}
+
+	for (i = 0, fragment_id = 0; i < tbl->stripes_per_fragment; i++) {
+		for (j = 0; j < fdesc->stripe_pages; j++) {
+			struct page *page;
+
+			if (page_index >= area->pages_count) {
+				err = -ERANGE;
+				SSDFS_ERR("page_index %d >= pages_count %zu\n",
+					  page_index, area->pages_count);
+				goto finish_fragment_init;
+			}
+
+			page = area->pages[page_index];
+			if (!page) {
+				err = -ERANGE;
+				SSDFS_ERR("page %d is absent\n", i);
+				goto finish_fragment_init;
+			}
+
+			err = ssdfs_maptbl_check_pebtbl_page(pebc, page,
+							    area->portion_id,
+							    fragment_id,
+							    fdesc, i, j,
+							    &pebs_per_fragment);
+			if (unlikely(err)) {
+				SSDFS_ERR("maptbl's page %d is corrupted: "
+					  "err %d\n",
+					  page_index, err);
+				goto finish_fragment_init;
+			}
+
+			page_index++;
+			fragment_id++;
+		}
+	}
+
+	if (lebs_per_fragment > pebs_per_fragment) {
+		err = -EIO;
+		SSDFS_ERR("lebs_per_fragment %u > pebs_per_fragment %u\n",
+			  lebs_per_fragment, pebs_per_fragment);
+		goto finish_fragment_init;
+	} else if (lebs_per_fragment < pebs_per_fragment) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("lebs_per_fragment %u < pebs_per_fragment %u\n",
+			  lebs_per_fragment, pebs_per_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	if (lebs_per_fragment > tbl->lebs_per_fragment ||
+	    lebs_per_fragment != fdesc->lebs_count) {
+		err = -EIO;
+		SSDFS_ERR("lebs_per_fragment %u, tbl->lebs_per_fragment %u, "
+			  "fdesc->lebs_count %u\n",
+			  lebs_per_fragment,
+			  tbl->lebs_per_fragment,
+			  fdesc->lebs_count);
+		goto finish_fragment_init;
+	}
+
+	if (pebs_per_fragment > tbl->pebs_per_fragment ||
+	    fdesc->lebs_count > pebs_per_fragment) {
+		err = -EIO;
+		SSDFS_ERR("pebs_per_fragment %u, tbl->pebs_per_fragment %u, "
+			  "fdesc->lebs_count %u\n",
+			  pebs_per_fragment,
+			  tbl->pebs_per_fragment,
+			  fdesc->lebs_count);
+		goto finish_fragment_init;
+	}
+
+	for (i = 0; i < area->pages_count; i++) {
+		struct page *page;
+
+		if (i >= area->pages_count) {
+			err = -ERANGE;
+			SSDFS_ERR("page_index %d >= pages_count %zu\n",
+				  i, area->pages_count);
+			goto finish_fragment_init;
+		}
+
+		page = area->pages[i];
+		if (!page) {
+			err = -ERANGE;
+			SSDFS_ERR("page %d is absent\n", i);
+			goto finish_fragment_init;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index %d, page %p\n",
+			  i, page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		ssdfs_set_page_private(page, 0);
+		SetPageUptodate(page);
+		err = ssdfs_page_array_add_page(&fdesc->array,
+						page, i);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page %d: err %d\n",
+				  i, err);
+			goto finish_fragment_init;
+		}
+
+		ssdfs_map_tbl_forget_page(page);
+		area->pages[i] = NULL;
+	}
+
+finish_fragment_init:
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment init failed: portion_id %u\n",
+			  area->portion_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		state = atomic_cmpxchg(&fdesc->state,
+					SSDFS_MAPTBL_FRAG_CREATED,
+					SSDFS_MAPTBL_FRAG_INIT_FAILED);
+		if (state != SSDFS_MAPTBL_FRAG_CREATED) {
+			/* don't change error code */
+			SSDFS_WARN("invalid fragment state %#x\n", state);
+		}
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment init finished; portion_id %u\n",
+			  area->portion_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		state = atomic_cmpxchg(&fdesc->state,
+					SSDFS_MAPTBL_FRAG_CREATED,
+					SSDFS_MAPTBL_FRAG_INITIALIZED);
+		if (state != SSDFS_MAPTBL_FRAG_CREATED) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid fragment state %#x\n", state);
+		}
+	}
+
+	up_write(&fdesc->lock);
+
+	complete_all(&fdesc->init_end);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
diff --git a/fs/ssdfs/peb_mapping_table.h b/fs/ssdfs/peb_mapping_table.h
new file mode 100644
index 000000000000..89f9fcefc6fb
--- /dev/null
+++ b/fs/ssdfs/peb_mapping_table.h
@@ -0,0 +1,699 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_mapping_table.h - PEB mapping table declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_PEB_MAPPING_TABLE_H
+#define _SSDFS_PEB_MAPPING_TABLE_H
+
+#define SSDFS_MAPTBL_FIRST_PROTECTED_INDEX	0
+#define SSDFS_MAPTBL_PROTECTION_STEP		50
+#define SSDFS_MAPTBL_PROTECTION_RANGE		3
+
+#define SSDFS_PRE_ERASE_PEB_THRESHOLD_PCT	(3)
+#define SSDFS_UNUSED_LEB_THRESHOLD_PCT		(1)
+
+/*
+ * struct ssdfs_maptbl_fragment_desc - fragment descriptor
+ * @lock: fragment lock
+ * @state: fragment state
+ * @fragment_id: fragment's ID in the whole sequence
+ * @fragment_pages: count of memory pages in fragment
+ * @start_leb: start LEB of fragment
+ * @lebs_count: count of LEB descriptors in the whole fragment
+ * @lebs_per_page: count of LEB descriptors in memory page
+ * @lebtbl_pages: count of memory pages are used for LEBs description
+ * @pebs_per_page: count of PEB descriptors in memory page
+ * @stripe_pages: count of memory pages in one stripe
+ * @mapped_lebs: mapped LEBs count in the fragment
+ * @migrating_lebs: migrating LEBs count in the fragment
+ * @reserved_pebs: count of reserved PEBs in fragment
+ * @pre_erase_pebs: count of PEBs in pre-erase state per fragment
+ * @recovering_pebs: count of recovering PEBs per fragment
+ * @array: fragment's memory pages
+ * @init_end: wait of init ending
+ * @flush_req1: main flush requests array
+ * @flush_req2: backup flush requests array
+ * @flush_req_count: number of flush requests in the array
+ * @flush_seq_size: flush requests' array capacity
+ */
+struct ssdfs_maptbl_fragment_desc {
+	struct rw_semaphore lock;
+	atomic_t state;
+
+	u32 fragment_id;
+	u32 fragment_pages;
+
+	u64 start_leb;
+	u32 lebs_count;
+
+	u16 lebs_per_page;
+	u16 lebtbl_pages;
+
+	u16 pebs_per_page;
+	u16 stripe_pages;
+
+	u32 mapped_lebs;
+	u32 migrating_lebs;
+	u32 reserved_pebs;
+	u32 pre_erase_pebs;
+	u32 recovering_pebs;
+
+	struct ssdfs_page_array array;
+	struct completion init_end;
+
+	struct ssdfs_segment_request *flush_req1;
+	struct ssdfs_segment_request *flush_req2;
+	u32 flush_req_count;
+	u32 flush_seq_size;
+};
+
+/* Fragment's state */
+enum {
+	SSDFS_MAPTBL_FRAG_CREATED	= 0,
+	SSDFS_MAPTBL_FRAG_INIT_FAILED	= 1,
+	SSDFS_MAPTBL_FRAG_INITIALIZED	= 2,
+	SSDFS_MAPTBL_FRAG_DIRTY		= 3,
+	SSDFS_MAPTBL_FRAG_TOWRITE	= 4,
+	SSDFS_MAPTBL_FRAG_STATE_MAX	= 5,
+};
+
+/*
+ * struct ssdfs_maptbl_area - mapping table area
+ * @portion_id: sequential ID of mapping table fragment
+ * @pages: array of memory page pointers
+ * @pages_capacity: capacity of array
+ * @pages_count: count of pages in array
+ */
+struct ssdfs_maptbl_area {
+	u16 portion_id;
+	struct page **pages;
+	size_t pages_capacity;
+	size_t pages_count;
+};
+
+/*
+ * struct ssdfs_peb_mapping_table - mapping table object
+ * @tbl_lock: mapping table lock
+ * @fragments_count: count of fragments
+ * @fragments_per_seg: count of fragments in segment
+ * @fragments_per_peb: count of fragments in PEB
+ * @fragment_bytes: count of bytes in one fragment
+ * @fragment_pages: count of memory pages in one fragment
+ * @flags: mapping table flags
+ * @lebs_count: count of LEBs are described by mapping table
+ * @pebs_count: count of PEBs are described by mapping table
+ * @lebs_per_fragment: count of LEB descriptors in fragment
+ * @pebs_per_fragment: count of PEB descriptors in fragment
+ * @pebs_per_stripe: count of PEB descriptors in stripe
+ * @stripes_per_fragment: count of stripes in fragment
+ * @extents: metadata extents that describe mapping table location
+ * @segs: array of pointers on segment objects
+ * @segs_count: count of segment objects are used for mapping table
+ * @state: mapping table's state
+ * @erase_op_state: state of erase operation
+ * @pre_erase_pebs: count of PEBs in pre-erase state
+ * @max_erase_ops: upper bound of erase operations for one iteration
+ * @erase_ops_end_wq: wait queue of threads are waiting end of erase operation
+ * @bmap_lock: dirty bitmap's lock
+ * @dirty_bmap: bitmap of dirty fragments
+ * @desc_array: array of fragment descriptors
+ * @wait_queue: wait queue of mapping table's thread
+ * @thread: descriptor of mapping table's thread
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_peb_mapping_table {
+	struct rw_semaphore tbl_lock;
+	u32 fragments_count;
+	u16 fragments_per_seg;
+	u16 fragments_per_peb;
+	u32 fragment_bytes;
+	u32 fragment_pages;
+	atomic_t flags;
+	u64 lebs_count;
+	u64 pebs_count;
+	u16 lebs_per_fragment;
+	u16 pebs_per_fragment;
+	u16 pebs_per_stripe;
+	u16 stripes_per_fragment;
+	struct ssdfs_meta_area_extent extents[MAPTBL_LIMIT1][MAPTBL_LIMIT2];
+	struct ssdfs_segment_info **segs[SSDFS_MAPTBL_SEG_COPY_MAX];
+	u16 segs_count;
+
+	atomic_t state;
+
+	atomic_t erase_op_state;
+	atomic_t pre_erase_pebs;
+	atomic_t max_erase_ops;
+	wait_queue_head_t erase_ops_end_wq;
+
+	atomic64_t last_peb_recover_cno;
+
+	struct mutex bmap_lock;
+	unsigned long *dirty_bmap;
+	struct ssdfs_maptbl_fragment_desc *desc_array;
+
+	wait_queue_head_t wait_queue;
+	struct ssdfs_thread_info thread;
+	struct ssdfs_fs_info *fsi;
+};
+
+/* PEB mapping table's state */
+enum {
+	SSDFS_MAPTBL_CREATED			= 0,
+	SSDFS_MAPTBL_GOING_TO_BE_DESTROY	= 1,
+	SSDFS_MAPTBL_STATE_MAX			= 2,
+};
+
+/*
+ * struct ssdfs_maptbl_peb_descriptor - PEB descriptor
+ * @peb_id: PEB identification number
+ * @shared_peb_index: index of external shared destination PEB
+ * @erase_cycles: P/E cycles
+ * @type: PEB type
+ * @state: PEB state
+ * @flags: PEB flags
+ * @consistency: PEB state consistency type
+ */
+struct ssdfs_maptbl_peb_descriptor {
+	u64 peb_id;
+	u8 shared_peb_index;
+	u32 erase_cycles;
+	u8 type;
+	u8 state;
+	u8 flags;
+	u8 consistency;
+};
+
+/*
+ * struct ssdfs_maptbl_peb_relation - PEBs association
+ * @pebs: array of PEB descriptors
+ */
+struct ssdfs_maptbl_peb_relation {
+	struct ssdfs_maptbl_peb_descriptor pebs[SSDFS_MAPTBL_RELATION_MAX];
+};
+
+/*
+ * Erase operation state
+ */
+enum {
+	SSDFS_MAPTBL_NO_ERASE,
+	SSDFS_MAPTBL_ERASE_IN_PROGRESS
+};
+
+/* Stage of recovering try */
+enum {
+	SSDFS_CHECK_RECOVERABILITY,
+	SSDFS_MAKE_RECOVERING,
+	SSDFS_RECOVER_STAGE_MAX
+};
+
+/* Possible states of erase operation */
+enum {
+	SSDFS_ERASE_RESULT_UNKNOWN,
+	SSDFS_ERASE_DONE,
+	SSDFS_ERASE_SB_PEB_DONE,
+	SSDFS_IGNORE_ERASE,
+	SSDFS_ERASE_FAILURE,
+	SSDFS_BAD_BLOCK_DETECTED,
+	SSDFS_ERASE_RESULT_MAX
+};
+
+/*
+ * struct ssdfs_erase_result - PEB's erase operation result
+ * @fragment_index: index of mapping table's fragment
+ * @peb_index: PEB's index in fragment
+ * @peb_id: PEB ID number
+ * @state: state of erase operation
+ */
+struct ssdfs_erase_result {
+	u32 fragment_index;
+	u16 peb_index;
+	u64 peb_id;
+	int state;
+};
+
+/*
+ * struct ssdfs_erase_result_array - array of erase operation results
+ * @ptr: pointer on memory buffer
+ * @capacity: maximal number of erase operation results in array
+ * @size: count of erase operation results in array
+ */
+struct ssdfs_erase_result_array {
+	struct ssdfs_erase_result *ptr;
+	u32 capacity;
+	u32 size;
+};
+
+#define SSDFS_ERASE_RESULTS_PER_FRAGMENT	(10)
+
+/*
+ * Inline functions
+ */
+
+/*
+ * SSDFS_ERASE_RESULT_INIT() - init erase result
+ * @fragment_index: index of mapping table's fragment
+ * @peb_index: PEB's index in fragment
+ * @peb_id: PEB ID number
+ * @state: state of erase operation
+ * @result: erase operation result [out]
+ *
+ * This method initializes the erase operation result.
+ */
+static inline
+void SSDFS_ERASE_RESULT_INIT(u32 fragment_index, u16 peb_index,
+			     u64 peb_id, int state,
+			     struct ssdfs_erase_result *result)
+{
+	result->fragment_index = fragment_index;
+	result->peb_index = peb_index;
+	result->peb_id = peb_id;
+	result->state = state;
+}
+
+/*
+ * DEFINE_PEB_INDEX_IN_FRAGMENT() - define PEB index in the whole fragment
+ * @fdesc: fragment descriptor
+ * @page_index: page index in the fragment
+ * @item_index: item index in the memory page
+ */
+static inline
+u16 DEFINE_PEB_INDEX_IN_FRAGMENT(struct ssdfs_maptbl_fragment_desc *fdesc,
+				 pgoff_t page_index,
+				 u16 item_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+	BUG_ON(page_index < fdesc->lebtbl_pages);
+
+	SSDFS_DBG("fdesc %p, page_index %lu, item_index %u\n",
+		  fdesc, page_index, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index -= fdesc->lebtbl_pages;
+	page_index *= fdesc->pebs_per_page;
+	page_index += item_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u16)page_index;
+}
+
+/*
+ * GET_PEB_ID() - define PEB ID for the index
+ * @kaddr: pointer on memory page's content
+ * @item_index: item index inside of the page
+ *
+ * This method tries to convert @item_index into
+ * PEB ID value.
+ *
+ * RETURN:
+ * [success] - PEB ID
+ * [failure] - U64_MAX
+ */
+static inline
+u64 GET_PEB_ID(void *kaddr, u16 item_index)
+{
+	struct ssdfs_peb_table_fragment_header *hdr;
+	u64 start_peb;
+	u16 pebs_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, item_index %u\n",
+		  kaddr, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+	if (le16_to_cpu(hdr->magic) != SSDFS_PEB_TABLE_MAGIC) {
+		SSDFS_ERR("corrupted page\n");
+		return U64_MAX;
+	}
+
+	start_peb = le64_to_cpu(hdr->start_peb);
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+
+	if (item_index >= pebs_count) {
+		SSDFS_ERR("item_index %u >= pebs_count %u\n",
+			  item_index, pebs_count);
+		return U64_MAX;
+	}
+
+	return start_peb + item_index;
+}
+
+/*
+ * PEBTBL_PAGE_INDEX() - define PEB table page index
+ * @fdesc: fragment descriptor
+ * @peb_index: index of PEB in the fragment
+ */
+static inline
+pgoff_t PEBTBL_PAGE_INDEX(struct ssdfs_maptbl_fragment_desc *fdesc,
+			  u16 peb_index)
+{
+	pgoff_t page_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fdesc);
+
+	SSDFS_DBG("fdesc %p, peb_index %u\n",
+		  fdesc, peb_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	page_index = fdesc->lebtbl_pages;
+	page_index += peb_index / fdesc->pebs_per_page;
+	return page_index;
+}
+
+/*
+ * GET_PEB_DESCRIPTOR() - retrieve PEB descriptor
+ * @kaddr: pointer on memory page's content
+ * @item_index: item index inside of the page
+ *
+ * This method tries to return the pointer on
+ * PEB descriptor for @item_index.
+ *
+ * RETURN:
+ * [success] - pointer on PEB descriptor
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+struct ssdfs_peb_descriptor *GET_PEB_DESCRIPTOR(void *kaddr, u16 item_index)
+{
+	struct ssdfs_peb_table_fragment_header *hdr;
+	u16 pebs_count;
+	u32 peb_desc_off;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+
+	SSDFS_DBG("kaddr %p, item_index %u\n",
+		  kaddr, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr = (struct ssdfs_peb_table_fragment_header *)kaddr;
+
+	if (le16_to_cpu(hdr->magic) != SSDFS_PEB_TABLE_MAGIC) {
+		SSDFS_ERR("corrupted page\n");
+		return ERR_PTR(-ERANGE);
+	}
+
+	pebs_count = le16_to_cpu(hdr->pebs_count);
+
+	if (item_index >= pebs_count) {
+		SSDFS_ERR("item_index %u >= pebs_count %u\n",
+			  item_index, pebs_count);
+		return ERR_PTR(-ERANGE);
+	}
+
+	peb_desc_off = SSDFS_PEBTBL_FRAGMENT_HDR_SIZE;
+	peb_desc_off += item_index * sizeof(struct ssdfs_peb_descriptor);
+
+	if (peb_desc_off >= PAGE_SIZE) {
+		SSDFS_ERR("invalid offset %u\n", peb_desc_off);
+		return ERR_PTR(-ERANGE);
+	}
+
+	return (struct ssdfs_peb_descriptor *)((u8 *)kaddr + peb_desc_off);
+}
+
+/*
+ * SEG2PEB_TYPE() - convert segment into PEB type
+ */
+static inline
+int SEG2PEB_TYPE(int seg_type)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("seg_type %d\n", seg_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (seg_type) {
+	case SSDFS_USER_DATA_SEG_TYPE:
+		return SSDFS_MAPTBL_DATA_PEB_TYPE;
+
+	case SSDFS_LEAF_NODE_SEG_TYPE:
+		return SSDFS_MAPTBL_LNODE_PEB_TYPE;
+
+	case SSDFS_HYBRID_NODE_SEG_TYPE:
+		return SSDFS_MAPTBL_HNODE_PEB_TYPE;
+
+	case SSDFS_INDEX_NODE_SEG_TYPE:
+		return SSDFS_MAPTBL_IDXNODE_PEB_TYPE;
+
+	case SSDFS_INITIAL_SNAPSHOT_SEG_TYPE:
+		return SSDFS_MAPTBL_INIT_SNAP_PEB_TYPE;
+
+	case SSDFS_SB_SEG_TYPE:
+		return SSDFS_MAPTBL_SBSEG_PEB_TYPE;
+
+	case SSDFS_SEGBMAP_SEG_TYPE:
+		return SSDFS_MAPTBL_SEGBMAP_PEB_TYPE;
+
+	case SSDFS_MAPTBL_SEG_TYPE:
+		return SSDFS_MAPTBL_MAPTBL_PEB_TYPE;
+	}
+
+	return SSDFS_MAPTBL_PEB_TYPE_MAX;
+}
+
+/*
+ * PEB2SEG_TYPE() - convert PEB into segment type
+ */
+static inline
+int PEB2SEG_TYPE(int peb_type)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("peb_type %d\n", peb_type);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (peb_type) {
+	case SSDFS_MAPTBL_DATA_PEB_TYPE:
+		return SSDFS_USER_DATA_SEG_TYPE;
+
+	case SSDFS_MAPTBL_LNODE_PEB_TYPE:
+		return SSDFS_LEAF_NODE_SEG_TYPE;
+
+	case SSDFS_MAPTBL_HNODE_PEB_TYPE:
+		return SSDFS_HYBRID_NODE_SEG_TYPE;
+
+	case SSDFS_MAPTBL_IDXNODE_PEB_TYPE:
+		return SSDFS_INDEX_NODE_SEG_TYPE;
+
+	case SSDFS_MAPTBL_INIT_SNAP_PEB_TYPE:
+		return SSDFS_INITIAL_SNAPSHOT_SEG_TYPE;
+
+	case SSDFS_MAPTBL_SBSEG_PEB_TYPE:
+		return SSDFS_SB_SEG_TYPE;
+
+	case SSDFS_MAPTBL_SEGBMAP_PEB_TYPE:
+		return SSDFS_SEGBMAP_SEG_TYPE;
+
+	case SSDFS_MAPTBL_MAPTBL_PEB_TYPE:
+		return SSDFS_MAPTBL_SEG_TYPE;
+	}
+
+	return SSDFS_UNKNOWN_SEG_TYPE;
+}
+
+static inline
+bool is_ssdfs_maptbl_under_flush(struct ssdfs_fs_info *fsi)
+{
+	return atomic_read(&fsi->maptbl->flags) & SSDFS_MAPTBL_UNDER_FLUSH;
+}
+
+/*
+ * is_peb_protected() - check that PEB is protected
+ * @found_item: PEB index in the fragment
+ */
+static inline
+bool is_peb_protected(unsigned long found_item)
+{
+	unsigned long remainder;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found_item %lu\n", found_item);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	remainder = found_item % SSDFS_MAPTBL_PROTECTION_STEP;
+	return remainder == 0;
+}
+
+static inline
+bool is_ssdfs_maptbl_going_to_be_destroyed(struct ssdfs_peb_mapping_table *tbl)
+{
+	return atomic_read(&tbl->state) == SSDFS_MAPTBL_GOING_TO_BE_DESTROY;
+}
+
+static inline
+void set_maptbl_going_to_be_destroyed(struct ssdfs_fs_info *fsi)
+{
+	atomic_set(&fsi->maptbl->state, SSDFS_MAPTBL_GOING_TO_BE_DESTROY);
+}
+
+static inline
+void ssdfs_account_updated_user_data_pages(struct ssdfs_fs_info *fsi,
+					   u32 count)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	u64 updated = 0;
+
+	BUG_ON(!fsi);
+
+	SSDFS_DBG("fsi %p, count %u\n",
+		  fsi, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&fsi->volume_state_lock);
+	fsi->updated_user_data_pages += count;
+#ifdef CONFIG_SSDFS_DEBUG
+	updated = fsi->updated_user_data_pages;
+#endif /* CONFIG_SSDFS_DEBUG */
+	spin_unlock(&fsi->volume_state_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("updated %llu\n", updated);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * PEB mapping table's API
+ */
+int ssdfs_maptbl_create(struct ssdfs_fs_info *fsi);
+void ssdfs_maptbl_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_maptbl_fragment_init(struct ssdfs_peb_container *pebc,
+				struct ssdfs_maptbl_area *area);
+int ssdfs_maptbl_flush(struct ssdfs_peb_mapping_table *tbl);
+int ssdfs_maptbl_resize(struct ssdfs_peb_mapping_table *tbl,
+			u64 new_pebs_count);
+
+int ssdfs_maptbl_convert_leb2peb(struct ssdfs_fs_info *fsi,
+				 u64 leb_id, u8 peb_type,
+				 struct ssdfs_maptbl_peb_relation *pebr,
+				 struct completion **end);
+int ssdfs_maptbl_map_leb2peb(struct ssdfs_fs_info *fsi,
+			     u64 leb_id, u8 peb_type,
+			     struct ssdfs_maptbl_peb_relation *pebr,
+			     struct completion **end);
+int ssdfs_maptbl_recommend_search_range(struct ssdfs_fs_info *fsi,
+					u64 *start_leb,
+					u64 *end_leb,
+					struct completion **end);
+int ssdfs_maptbl_change_peb_state(struct ssdfs_fs_info *fsi,
+				  u64 leb_id, u8 peb_type,
+				  int peb_state,
+				  struct completion **end);
+int ssdfs_maptbl_prepare_pre_erase_state(struct ssdfs_fs_info *fsi,
+					 u64 leb_id, u8 peb_type,
+					 struct completion **end);
+int ssdfs_maptbl_set_pre_erased_snapshot_peb(struct ssdfs_fs_info *fsi,
+					     u64 peb_id,
+					     struct completion **end);
+int ssdfs_maptbl_add_migration_peb(struct ssdfs_fs_info *fsi,
+				   u64 leb_id, u8 peb_type,
+				   struct ssdfs_maptbl_peb_relation *pebr,
+				   struct completion **end);
+int ssdfs_maptbl_exclude_migration_peb(struct ssdfs_fs_info *fsi,
+					u64 leb_id, u8 peb_type,
+					u64 peb_create_time,
+					u64 last_log_time,
+					struct completion **end);
+int ssdfs_maptbl_set_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					u64 leb_id, u8 peb_type,
+					u64 dst_leb_id, u16 dst_peb_index,
+					struct completion **end);
+int ssdfs_maptbl_break_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					 u64 leb_id, u8 peb_type,
+					 u64 dst_leb_id, int dst_peb_refs,
+					 struct completion **end);
+int ssdfs_maptbl_set_zns_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					   u64 leb_id, u8 peb_type,
+					   struct completion **end);
+int ssdfs_maptbl_break_zns_indirect_relation(struct ssdfs_peb_mapping_table *tbl,
+					     u64 leb_id, u8 peb_type,
+					     struct completion **end);
+
+int ssdfs_reserve_free_pages(struct ssdfs_fs_info *fsi,
+			     u32 count, int type);
+
+/*
+ * It makes sense to have special thread for the whole mapping table.
+ * The goal of the thread will be clearing of dirty PEBs,
+ * tracking P/E cycles, excluding bad PEBs and recovering PEBs
+ * in the background. Knowledge about PEBs will be hidden by
+ * mapping table. All other subsystems will operate by LEBs.
+ */
+
+/*
+ * PEB mapping table's internal API
+ */
+int ssdfs_maptbl_start_thread(struct ssdfs_peb_mapping_table *tbl);
+int ssdfs_maptbl_stop_thread(struct ssdfs_peb_mapping_table *tbl);
+
+int ssdfs_maptbl_define_fragment_info(struct ssdfs_fs_info *fsi,
+				      u64 leb_id,
+				      u16 *pebs_per_fragment,
+				      u16 *pebs_per_stripe,
+				      u16 *stripes_per_fragment);
+struct ssdfs_maptbl_fragment_desc *
+ssdfs_maptbl_get_fragment_descriptor(struct ssdfs_peb_mapping_table *tbl,
+				     u64 leb_id);
+void ssdfs_maptbl_set_fragment_dirty(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u64 leb_id);
+int ssdfs_maptbl_solve_inconsistency(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u64 leb_id,
+				     struct ssdfs_maptbl_peb_relation *pebr);
+int ssdfs_maptbl_solve_pre_deleted_state(struct ssdfs_peb_mapping_table *tbl,
+				     struct ssdfs_maptbl_fragment_desc *fdesc,
+				     u64 leb_id,
+				     struct ssdfs_maptbl_peb_relation *pebr);
+void ssdfs_maptbl_move_fragment_pages(struct ssdfs_segment_request *req,
+				      struct ssdfs_maptbl_area *area,
+				      u16 pages_count);
+int ssdfs_maptbl_erase_peb(struct ssdfs_fs_info *fsi,
+			   struct ssdfs_erase_result *result);
+int ssdfs_maptbl_correct_dirty_peb(struct ssdfs_peb_mapping_table *tbl,
+				   struct ssdfs_maptbl_fragment_desc *fdesc,
+				   struct ssdfs_erase_result *result);
+int ssdfs_maptbl_erase_reserved_peb_now(struct ssdfs_fs_info *fsi,
+					u64 leb_id, u8 peb_type,
+					struct completion **end);
+
+#ifdef CONFIG_SSDFS_TESTING
+int ssdfs_maptbl_erase_dirty_pebs_now(struct ssdfs_peb_mapping_table *tbl);
+#else
+static inline
+int ssdfs_maptbl_erase_dirty_pebs_now(struct ssdfs_peb_mapping_table *tbl)
+{
+	SSDFS_ERR("function is not supported\n");
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_SSDFS_TESTING */
+
+void ssdfs_debug_maptbl_object(struct ssdfs_peb_mapping_table *tbl);
+
+#endif /* _SSDFS_PEB_MAPPING_TABLE_H */
-- 
2.34.1

