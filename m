Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39C646760
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFNSRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:17:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfFNSRP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:17:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5D58DBDBD6E55B213C50;
        Sat, 15 Jun 2019 02:17:13 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 15 Jun
 2019 02:17:06 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <chao@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [RFC PATCH 3/8] staging: erofs: move per-CPU buffers implementation to utils.c
Date:   Sat, 15 Jun 2019 02:16:14 +0800
Message-ID: <20190614181619.64905-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614181619.64905-1-gaoxiang25@huawei.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch moves per-CPU buffers to utils.c in order for
the upcoming generic decompression framework to use it.

Note that I tried to use generic per-CPU buffer or
per-CPU page approaches to clean up further, but obvious
performanace regression (about 2% for sequential read) was
observed.

Therefore let's leave it as it is instead, just move
to utils.c and I'll try to dig into the root cause later.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h      | 26 ++++++++++++++++++++++
 drivers/staging/erofs/unzip_vle.c     |  5 ++---
 drivers/staging/erofs/unzip_vle.h     |  4 +---
 drivers/staging/erofs/unzip_vle_lz4.c | 31 ++++++++-------------------
 drivers/staging/erofs/utils.c         | 12 +++++++++++
 5 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index f3063b13c117..dcbe6f7f5dae 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -321,6 +321,16 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 
 /* page count of a compressed cluster */
 #define erofs_clusterpages(sbi)         ((1 << (sbi)->clusterbits) / PAGE_SIZE)
+#define Z_EROFS_NR_INLINE_PAGEVECS      3
+
+#if (Z_EROFS_CLUSTER_MAX_PAGES > Z_EROFS_NR_INLINE_PAGEVECS)
+#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
+#else
+#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_NR_INLINE_PAGEVECS
+#endif
+
+#else
+#define EROFS_PCPUBUF_NR_PAGES          0
 #endif
 
 typedef u64 erofs_off_t;
@@ -608,6 +618,22 @@ static inline void erofs_vunmap(const void *mem, unsigned int count)
 extern struct shrinker erofs_shrinker_info;
 
 struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
+
+#if (EROFS_PCPUBUF_NR_PAGES > 0)
+void *erofs_get_pcpubuf(unsigned int pagenr);
+#define erofs_put_pcpubuf(buf) do { \
+	(void)&(buf);	\
+	preempt_enable();	\
+} while (0)
+#else
+static inline void *erofs_get_pcpubuf(unsigned int pagenr)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+#define erofs_put_pcpubuf(buf) do {} while (0)
+#endif
+
 void erofs_register_super(struct super_block *sb);
 void erofs_unregister_super(struct super_block *sb);
 
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 8aea938172df..08f2d4302ecb 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -552,8 +552,7 @@ static int z_erofs_vle_work_iter_begin(struct z_erofs_vle_work_builder *builder,
 	if (IS_ERR(work))
 		return PTR_ERR(work);
 got_it:
-	z_erofs_pagevec_ctor_init(&builder->vector,
-				  Z_EROFS_VLE_INLINE_PAGEVECS,
+	z_erofs_pagevec_ctor_init(&builder->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  work->pagevec, work->vcnt);
 
 	if (builder->role >= Z_EROFS_VLE_WORK_PRIMARY) {
@@ -936,7 +935,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	for (i = 0; i < nr_pages; ++i)
 		pages[i] = NULL;
 
-	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_VLE_INLINE_PAGEVECS,
+	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
 				  work->pagevec, 0);
 
 	for (i = 0; i < work->vcnt; ++i) {
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 902e67d04029..9c53009700cf 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -44,8 +44,6 @@ static inline bool z_erofs_gather_if_stagingpage(struct list_head *page_pool,
  *
  */
 
-#define Z_EROFS_VLE_INLINE_PAGEVECS     3
-
 struct z_erofs_vle_work {
 	struct mutex lock;
 
@@ -58,7 +56,7 @@ struct z_erofs_vle_work {
 
 	union {
 		/* L: pagevec */
-		erofs_vtptr_t pagevec[Z_EROFS_VLE_INLINE_PAGEVECS];
+		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
 		struct rcu_head rcu;
 	};
 };
diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index 0daac9b984a8..399c3e3a3ff3 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -34,16 +34,6 @@ static int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen)
 	return -EIO;
 }
 
-#if Z_EROFS_CLUSTER_MAX_PAGES > Z_EROFS_VLE_INLINE_PAGEVECS
-#define EROFS_PERCPU_NR_PAGES   Z_EROFS_CLUSTER_MAX_PAGES
-#else
-#define EROFS_PERCPU_NR_PAGES   Z_EROFS_VLE_INLINE_PAGEVECS
-#endif
-
-static struct {
-	char data[PAGE_SIZE * EROFS_PERCPU_NR_PAGES];
-} erofs_pcpubuf[NR_CPUS];
-
 int z_erofs_vle_plain_copy(struct page **compressed_pages,
 			   unsigned int clusterpages,
 			   struct page **pages,
@@ -56,8 +46,7 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 	char *percpu_data;
 	bool mirrored[Z_EROFS_CLUSTER_MAX_PAGES] = { 0 };
 
-	preempt_disable();
-	percpu_data = erofs_pcpubuf[smp_processor_id()].data;
+	percpu_data = erofs_get_pcpubuf(0);
 
 	j = 0;
 	for (i = 0; i < nr_pages; j = i++) {
@@ -117,7 +106,7 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 	if (src && !mirrored[j])
 		kunmap_atomic(src);
 
-	preempt_enable();
+	erofs_put_pcpubuf(percpu_data);
 	return 0;
 }
 
@@ -131,7 +120,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	unsigned int nr_pages, i, j;
 	int ret;
 
-	if (outlen + pageofs > EROFS_PERCPU_NR_PAGES * PAGE_SIZE)
+	if (outlen + pageofs > EROFS_PCPUBUF_NR_PAGES * PAGE_SIZE)
 		return -ENOTSUPP;
 
 	nr_pages = DIV_ROUND_UP(outlen + pageofs, PAGE_SIZE);
@@ -144,8 +133,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 			return -ENOMEM;
 	}
 
-	preempt_disable();
-	vout = erofs_pcpubuf[smp_processor_id()].data;
+	vout = erofs_get_pcpubuf(0);
 
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
 				clusterpages * PAGE_SIZE, outlen);
@@ -174,7 +162,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	}
 
 out:
-	preempt_enable();
+	erofs_put_pcpubuf(vout);
 
 	if (clusterpages == 1)
 		kunmap_atomic(vin);
@@ -196,8 +184,7 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 	int ret;
 
 	if (overlapped) {
-		preempt_disable();
-		vin = erofs_pcpubuf[smp_processor_id()].data;
+		vin = erofs_get_pcpubuf(0);
 
 		for (i = 0; i < clusterpages; ++i) {
 			void *t = kmap_atomic(compressed_pages[i]);
@@ -216,13 +203,13 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 	if (ret > 0)
 		ret = 0;
 
-	if (!overlapped) {
+	if (overlapped) {
+		erofs_put_pcpubuf(vin);
+	} else {
 		if (clusterpages == 1)
 			kunmap_atomic(vin);
 		else
 			erofs_vunmap(vin, clusterpages);
-	} else {
-		preempt_enable();
 	}
 	return ret;
 }
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 3e7d30b6de1d..4bbd3bf34acd 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -27,6 +27,18 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 	return page;
 }
 
+#if (EROFS_PCPUBUF_NR_PAGES > 0)
+static struct {
+	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
+} ____cacheline_aligned_in_smp erofs_pcpubuf[NR_CPUS];
+
+void *erofs_get_pcpubuf(unsigned int pagenr)
+{
+	preempt_disable();
+	return &erofs_pcpubuf[smp_processor_id()].data[pagenr * PAGE_SIZE];
+}
+#endif
+
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
-- 
2.17.1

