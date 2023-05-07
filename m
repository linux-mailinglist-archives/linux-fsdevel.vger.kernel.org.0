Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1090F6F96B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 05:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjEGDaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 23:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjEGDa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 23:30:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F4518157;
        Sat,  6 May 2023 20:30:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QDVL24LQgz4f3wRH;
        Sun,  7 May 2023 11:30:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNHG1dkjIawIw--.21328S6;
        Sun, 07 May 2023 11:30:19 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Amir Goldstein <amir73il@gmail.com>, houtao1@huawei.com
Subject: [RFC PATCH bpf-next 2/4] bpf: Add three kfunc helpers for bpf fs inode iterator
Date:   Sun,  7 May 2023 12:01:05 +0800
Message-Id: <20230507040107.3755166-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230507040107.3755166-1-houtao@huaweicloud.com>
References: <20230507040107.3755166-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNHG1dkjIawIw--.21328S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF18Wr45Ww13XFy8KrW8Crg_yoWxuw4DpF
        WDWF1Fkrs7XFWxCrn3A3WDur1Sk3s7Ca15AFy7W3WY93W7tFyS9wnFgry5Ary5GrWkAFWI
        qF4ktryDuF4DXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2GYLDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add kfunc helpers for bpf fs inode iterator to inspect the details of
inode page cache:
1) bpf_filemap_cachestat. Basically copied from cachestat patchset by
   Nhat Pham [0]. It returns the number of cached page, dirty pages and
   writeback pages in the passed inode.
2) bpf_filemap_find_present & bpf_filemap_get_order. These two helpers
   are used to find the order of the present folios in page cache.

The following is the output from bpf selftest when trying to show the
cached status and folios order of a xfs inode:

  sb: bsize 4096 s_op xfs_super_operations s_type xfs_fs_type name xfs
  ino: inode nlink 1 inum 131 size 10485760, name inode.test
  cache: cached 2560 dirty 0 wb 0 evicted 0
  orders:
    page offset 0 order 2
    page offset 4 order 2
    page offset 8 order 2
    page offset 12 order 2
    page offset 16 order 4
    page offset 32 order 4
    page offset 48 order 4
    page offset 64 order 5
    page offset 96 order 4
    page offset 112 order 4
    ......

[0]: https://lore.kernel.org/linux-mm/20230503013608.2431726-1-nphamcs@gmail.com/T/#t

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/fs.h        |  4 ++
 include/uapi/linux/mman.h |  8 ++++
 kernel/bpf/helpers.c      | 26 +++++++++++++
 mm/filemap.c              | 77 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 67495ef79bb2..5ce17e87c4f6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -46,6 +46,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/mman.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -3191,4 +3192,7 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
+extern void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
+			      pgoff_t last_index, struct cachestat *cs);
+
 #endif /* _LINUX_FS_H */
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index f55bc680b5b0..6e9aa23aa124 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -4,6 +4,7 @@
 
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
+#include <linux/types.h>
 
 #define MREMAP_MAYMOVE		1
 #define MREMAP_FIXED		2
@@ -41,4 +42,11 @@
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
 
+struct cachestat {
+	__u64 nr_cache;
+	__u64 nr_dirty;
+	__u64 nr_writeback;
+	__u64 nr_evicted;
+};
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb6b4637ebf2..95174d1ef5bb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
+#include <uapi/linux/mman.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -2170,6 +2171,27 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
+__bpf_kfunc void bpf_filemap_cachestat(struct inode *inode, unsigned long from,
+				       unsigned long last, struct cachestat *cs)
+{
+	filemap_cachestat(inode->i_mapping, from, last, cs);
+}
+
+__bpf_kfunc long bpf_filemap_find_present(struct inode *inode, unsigned long from,
+					  unsigned long last)
+{
+	unsigned long index = from;
+
+	if (!xa_find(&inode->i_mapping->i_pages, &index, last, XA_PRESENT))
+		return ULONG_MAX;
+	return index;
+}
+
+__bpf_kfunc long bpf_filemap_get_order(struct inode *inode, unsigned long index)
+{
+	return xa_get_order(&inode->i_mapping->i_pages, index);
+}
+
 /**
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @ptr: The dynptr whose data slice to retrieve
@@ -2402,6 +2424,10 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
+/* TODO: KF_TRUSTED_ARGS is missing */
+BTF_ID_FLAGS(func, bpf_filemap_cachestat);
+BTF_ID_FLAGS(func, bpf_filemap_find_present);
+BTF_ID_FLAGS(func, bpf_filemap_get_order);
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/mm/filemap.c b/mm/filemap.c
index 2723104cc06a..fc63a02a9b0d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4122,3 +4122,80 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	return try_to_free_buffers(folio);
 }
 EXPORT_SYMBOL(filemap_release_folio);
+
+/**
+ * filemap_cachestat() - compute the page cache statistics of a mapping
+ * @mapping:	The mapping to compute the statistics for.
+ * @first_index:	The starting page cache index.
+ * @last_index:	The final page index (inclusive).
+ * @cs:	the cachestat struct to write the result to.
+ *
+ * This will query the page cache statistics of a mapping in the
+ * page range of [first_index, last_index] (inclusive). The statistics
+ * queried include: number of dirty pages, number of pages marked for
+ * writeback, and the number of (recently) evicted pages.
+ */
+void filemap_cachestat(struct address_space *mapping, pgoff_t first_index,
+		       pgoff_t last_index, struct cachestat *cs)
+{
+	XA_STATE(xas, &mapping->i_pages, first_index);
+	struct folio *folio;
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last_index) {
+		unsigned long nr_pages;
+		pgoff_t folio_first_index, folio_last_index;
+
+		if (xas_retry(&xas, folio))
+			continue;
+
+		if (xa_is_value(folio)) {
+			/* page is evicted */
+			void *shadow = (void *)folio;
+			bool workingset; /* not used */
+			int order = xa_get_order(xas.xa, xas.xa_index);
+
+			nr_pages = 1 << order;
+			/* rounds down to the nearest multiple of 2^order */
+			folio_first_index = xas.xa_index >> order << order;
+			folio_last_index = folio_first_index + nr_pages - 1;
+
+			/* Folios might straddle the range boundaries, only count covered pages */
+			if (folio_first_index < first_index)
+				nr_pages -= first_index - folio_first_index;
+
+			if (folio_last_index > last_index)
+				nr_pages -= folio_last_index - last_index;
+
+			cs->nr_evicted += nr_pages;
+			goto resched;
+		}
+
+		nr_pages = folio_nr_pages(folio);
+		folio_first_index = folio_pgoff(folio);
+		folio_last_index = folio_first_index + nr_pages - 1;
+
+		/* Folios might straddle the range boundaries, only count covered pages */
+		if (folio_first_index < first_index)
+			nr_pages -= first_index - folio_first_index;
+
+		if (folio_last_index > last_index)
+			nr_pages -= folio_last_index - last_index;
+
+		/* page is in cache */
+		cs->nr_cache += nr_pages;
+
+		if (folio_test_dirty(folio))
+			cs->nr_dirty += nr_pages;
+
+		if (folio_test_writeback(folio))
+			cs->nr_writeback += nr_pages;
+
+resched:
+		if (need_resched()) {
+			xas_pause(&xas);
+			cond_resched_rcu();
+		}
+	}
+	rcu_read_unlock();
+}
-- 
2.29.2

