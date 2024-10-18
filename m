Return-Path: <linux-fsdevel+bounces-32319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6019A35D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1141C22E96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8021917C7;
	Fri, 18 Oct 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4HrQAdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45C18F2FB;
	Fri, 18 Oct 2024 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233672; cv=none; b=qm1iizqN2VIkSJJO3zhNz/NkCch5CYX5ywcolmXm9nfwmudQV4UtxErTNEWIIMjNZDMTF++VltB4hEJt71I5LwgkvfOtgyu7zzSrHeEkoolhhCgj9QKHzokYYbacGofLk6p8/bOn4EZZKmhGPiOcckYwLj1IAwBvkojLAh6Ijns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233672; c=relaxed/simple;
	bh=+Q7iJvK2+hp6eB2kPVjEewMUFUZIdF/DxKq670u2u9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocFCK8QfNOwKLviPGhJLrGg20n1iIWd/DIbmOjiuEWeYV0k8BW35yEoLbpmsJM+PJg53eDTs0SYOvk700bbPOFfigZTyW3cgCe07Cu+WdxD6N6DlFVHpcNVGqgzFsO5T+8lu2sUiIrskWacklSvz+sa/tJaE71uPzWcYqYrkB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4HrQAdh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233671; x=1760769671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Q7iJvK2+hp6eB2kPVjEewMUFUZIdF/DxKq670u2u9s=;
  b=c4HrQAdh8PHiBZc9vInMg2u/WoTGEwKNDLOr4fprJv5oYrLkncma2IIT
   YKHwN1NFYLBdBy/w7jiPTJLLB9aXRl7lNndqkY05E5fd9iUaHda0aXcRE
   m7qunqiPqKxXITO5ca9YOzFsiTZXUHloVtrDneIoWc+MdnQMrvMSgVYdK
   XNFNuU5kdNK1/X02hryCodUwizheUZKlZBzv6V1hWKZ8U4d/VmTDHb5A6
   N2bxzuUCv+AQ8MXWhqKhHk94DB1IwQmoMSKeYH8N4bVwrkM7PrNnvI63G
   eTU984AMSifOcgvBt0HKl9eia22Jk30/JNvqQDki3cZ7Dbh5r1zJcFQ8G
   g==;
X-CSE-ConnectionGUID: Yh0DMORlQ/aOhhB0HPkLBA==
X-CSE-MsgGUID: Zk6ZX3rwT/aHGUfLRCDZsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884925"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:04 -0700
X-CSE-ConnectionGUID: 8bTgRIQISyO43aali6d8vQ==
X-CSE-MsgGUID: bqFAXIkNSPSN+aHIWJjjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607529"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:04 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 10/13] mm: zswap: Create multiple reqs/buffers in crypto_acomp_ctx if platform has IAA.
Date: Thu, 17 Oct 2024 23:40:58 -0700
Message-Id: <20241018064101.336232-11-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel IAA hardware acceleration can be used effectively to improve the
zswap_store() performance of large folios by batching multiple pages in a
folio to be compressed in parallel by IAA. Hence, to build compress batching
of zswap large folio stores using IAA, we need to be able to submit a batch
of compress jobs from zswap to the hardware to compress in parallel if the
iaa_crypto "async" mode is used.

The IAA compress batching paradigm works as follows:

 1) Submit N crypto_acomp_compress() jobs using N requests.
 2) Use the iaa_crypto driver async poll() method to check for the jobs
    to complete.
 3) There are no ordering constraints implied by submission, hence we
    could loop through the requests and process any job that has
    completed.
 4) This would repeat until all jobs have completed with success/error
    status.

To facilitate this, we need to provide for multiple acomp_reqs in
"struct crypto_acomp_ctx", each representing a distinct compress
job. Likewise, there needs to be a distinct destination buffer
corresponding to each acomp_req.

If CONFIG_ZSWAP_STORE_BATCHING_ENABLED is enabled, this patch will set the
SWAP_CRYPTO_SUB_BATCH_SIZE constant to 8UL. This implies each per-cpu
crypto_acomp_ctx associated with the zswap_pool can submit up to 8
acomp_reqs at a time to accomplish parallel compressions.

If IAA is not present and/or CONFIG_ZSWAP_STORE_BATCHING_ENABLED is not
set, SWAP_CRYPTO_SUB_BATCH_SIZE will be set to 1UL.

On an Intel Sapphire Rapids server, each socket has 4 IAA, each of which
has 2 compress engines and 8 decompress engines. Experiments modeling a
contended system with say 72 processes running under a cgroup with a fixed
memory-limit, have shown that there is a significant performance
improvement with dispatching compress jobs from all cores to all the
IAA devices on the socket. Hence, SWAP_CRYPTO_SUB_BATCH_SIZE is set to
8 to maximize compression throughput if IAA is available.

The definition of "struct crypto_acomp_ctx" is modified to make the
req/buffer be arrays of size SWAP_CRYPTO_SUB_BATCH_SIZE. Thus, the
added memory footprint cost of this per-cpu structure for batching is
incurred only for platforms that have Intel IAA.

Suggested-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/swap.h  |  11 ++++++
 mm/zswap.c | 104 ++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index ad2f121de970..566616c971d4 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -8,6 +8,17 @@ struct mempolicy;
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
+/*
+ * For IAA compression batching:
+ * Maximum number of IAA acomp compress requests that will be processed
+ * in a sub-batch.
+ */
+#if defined(CONFIG_ZSWAP_STORE_BATCHING_ENABLED)
+#define SWAP_CRYPTO_SUB_BATCH_SIZE 8UL
+#else
+#define SWAP_CRYPTO_SUB_BATCH_SIZE 1UL
+#endif
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
diff --git a/mm/zswap.c b/mm/zswap.c
index 4893302d8c34..579869d1bdf6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -152,9 +152,9 @@ bool zswap_never_enabled(void)
 
 struct crypto_acomp_ctx {
 	struct crypto_acomp *acomp;
-	struct acomp_req *req;
+	struct acomp_req *req[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	u8 *buffer[SWAP_CRYPTO_SUB_BATCH_SIZE];
 	struct crypto_wait wait;
-	u8 *buffer;
 	struct mutex mutex;
 	bool is_sleepable;
 };
@@ -832,49 +832,64 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 	struct crypto_acomp *acomp;
-	struct acomp_req *req;
 	int ret;
+	int i, j;
 
 	mutex_init(&acomp_ctx->mutex);
 
-	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!acomp_ctx->buffer)
-		return -ENOMEM;
-
 	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
 	if (IS_ERR(acomp)) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
-		ret = PTR_ERR(acomp);
-		goto acomp_fail;
+		return PTR_ERR(acomp);
 	}
 	acomp_ctx->acomp = acomp;
 	acomp_ctx->is_sleepable = acomp_is_async(acomp);
 
-	req = acomp_request_alloc(acomp_ctx->acomp);
-	if (!req) {
-		pr_err("could not alloc crypto acomp_request %s\n",
-		       pool->tfm_name);
-		ret = -ENOMEM;
-		goto req_fail;
+	for (i = 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i) {
+		acomp_ctx->buffer[i] = kmalloc_node(PAGE_SIZE * 2,
+						GFP_KERNEL, cpu_to_node(cpu));
+		if (!acomp_ctx->buffer[i]) {
+			for (j = 0; j < i; ++j)
+				kfree(acomp_ctx->buffer[j]);
+			ret = -ENOMEM;
+			goto buf_fail;
+		}
+	}
+
+	for (i = 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i) {
+		acomp_ctx->req[i] = acomp_request_alloc(acomp_ctx->acomp);
+		if (!acomp_ctx->req[i]) {
+			pr_err("could not alloc crypto acomp_request req[%d] %s\n",
+			       i, pool->tfm_name);
+			for (j = 0; j < i; ++j)
+				acomp_request_free(acomp_ctx->req[j]);
+			ret = -ENOMEM;
+			goto req_fail;
+		}
 	}
-	acomp_ctx->req = req;
 
+	/*
+	 * The crypto_wait is used only in fully synchronous, i.e., with scomp
+	 * or non-poll mode of acomp, hence there is only one "wait" per
+	 * acomp_ctx, with callback set to req[0].
+	 */
 	crypto_init_wait(&acomp_ctx->wait);
 	/*
 	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
 	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
 	 * won't be called, crypto_wait_req() will return without blocking.
 	 */
-	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+	acomp_request_set_callback(acomp_ctx->req[0], CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
 	return 0;
 
 req_fail:
+	for (i = 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i)
+		kfree(acomp_ctx->buffer[i]);
+buf_fail:
 	crypto_free_acomp(acomp_ctx->acomp);
-acomp_fail:
-	kfree(acomp_ctx->buffer);
 	return ret;
 }
 
@@ -884,11 +899,17 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 
 	if (!IS_ERR_OR_NULL(acomp_ctx)) {
-		if (!IS_ERR_OR_NULL(acomp_ctx->req))
-			acomp_request_free(acomp_ctx->req);
+		int i;
+
+		for (i = 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i)
+			if (!IS_ERR_OR_NULL(acomp_ctx->req[i]))
+				acomp_request_free(acomp_ctx->req[i]);
+
+		for (i = 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i)
+			kfree(acomp_ctx->buffer[i]);
+
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
 			crypto_free_acomp(acomp_ctx->acomp);
-		kfree(acomp_ctx->buffer);
 	}
 
 	return 0;
@@ -911,7 +932,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 
 	mutex_lock(&acomp_ctx->mutex);
 
-	dst = acomp_ctx->buffer;
+	dst = acomp_ctx->buffer[0];
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
 
@@ -921,7 +942,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * giving the dst buffer with enough length to avoid buffer overflow.
 	 */
 	sg_init_one(&output, dst, PAGE_SIZE * 2);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
+	acomp_request_set_params(acomp_ctx->req[0], &input, &output, PAGE_SIZE, dlen);
 
 	/*
 	 * If the crypto_acomp provides an asynchronous poll() interface,
@@ -940,19 +961,20 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * parallel.
 	 */
 	if (acomp_ctx->acomp->poll) {
-		comp_ret = crypto_acomp_compress(acomp_ctx->req);
+		comp_ret = crypto_acomp_compress(acomp_ctx->req[0]);
 		if (comp_ret == -EINPROGRESS) {
 			do {
-				comp_ret = crypto_acomp_poll(acomp_ctx->req);
+				comp_ret = crypto_acomp_poll(acomp_ctx->req[0]);
 				if (comp_ret && comp_ret != -EAGAIN)
 					break;
 			} while (comp_ret);
 		}
 	} else {
-		comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+		comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req[0]),
+					   &acomp_ctx->wait);
 	}
 
-	dlen = acomp_ctx->req->dlen;
+	dlen = acomp_ctx->req[0]->dlen;
 	if (comp_ret)
 		goto unlock;
 
@@ -1006,31 +1028,39 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	 */
 	if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) ||
 	    !virt_addr_valid(src)) {
-		memcpy(acomp_ctx->buffer, src, entry->length);
-		src = acomp_ctx->buffer;
+		memcpy(acomp_ctx->buffer[0], src, entry->length);
+		src = acomp_ctx->buffer[0];
 		zpool_unmap_handle(zpool, entry->handle);
 	}
 
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
+	acomp_request_set_params(acomp_ctx->req[0], &input, &output,
+				 entry->length, PAGE_SIZE);
 	if (acomp_ctx->acomp->poll) {
-		ret = crypto_acomp_decompress(acomp_ctx->req);
+		ret = crypto_acomp_decompress(acomp_ctx->req[0]);
 		if (ret == -EINPROGRESS) {
 			do {
-				ret = crypto_acomp_poll(acomp_ctx->req);
+				ret = crypto_acomp_poll(acomp_ctx->req[0]);
 				BUG_ON(ret && ret != -EAGAIN);
 			} while (ret);
 		}
 	} else {
-		BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
+		BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req[0]),
+				       &acomp_ctx->wait));
 	}
-	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(&acomp_ctx->mutex);
+	BUG_ON(acomp_ctx->req[0]->dlen != PAGE_SIZE);
 
-	if (src != acomp_ctx->buffer)
+	if (src != acomp_ctx->buffer[0])
 		zpool_unmap_handle(zpool, entry->handle);
+
+	/*
+	 * It is safer to unlock the mutex after the check for
+	 * "src != acomp_ctx->buffer[0]" so that the value of "src"
+	 * does not change.
+	 */
+	mutex_unlock(&acomp_ctx->mutex);
 }
 
 /*********************************
-- 
2.27.0


