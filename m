Return-Path: <linux-fsdevel+bounces-32320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0889A35D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D37C1C20441
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A289191F72;
	Fri, 18 Oct 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFkijxfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FA18A6B9;
	Fri, 18 Oct 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233673; cv=none; b=qoVrXoUm3Vr9URUXvWKwEEDg0wJGUskrC1RCFAjb6fVO8jleB/0c0pPb9vjQmhpgSDnkrPLAUDgL8DOfgbs5TPGyWRBqpk7W8ROSyi8I8dUKgpPzUQut0dYGJm8CR2n3Z920zFUK004pJkJ6dRpmv97y8uBpRCqmqRL3k8CwI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233673; c=relaxed/simple;
	bh=ehxQAVad+zYWKv7x3rvdIyaL5PCorY7OSY9LU2CsBiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rttw2gHx/pVOWjN57a78I2Z8odj8M3yjHEzPtOPtd43UYVax5IYQ/EXaFlamwuB7H4USDNh6oLl3TRCN7utOG9dVG8UmEdpaRK89oTA/5vo7+m1qi7T2GJ4gnkky74g2KDJNbxtS+2EL1yGkMpm2OHWrfNwhgH3d15DdchUuCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFkijxfs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233672; x=1760769672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehxQAVad+zYWKv7x3rvdIyaL5PCorY7OSY9LU2CsBiY=;
  b=LFkijxfsDNJ7QVBuOc7wv/iwjh0BDrdBjZvFPZcJXlwLZ7/WBppQbGgT
   /LbR+vrj1xA98ePcJ/HbBb+iHaRtetBk7iHJeFDqw8Vmqtpjz28kcq1oR
   d4yCzYe1CgmdscSQupLDyJHbZJOY+o9j48vk9kXPpjYcfVbT1QqyO8cua
   EM2Cxxdk9IlQlWa1S8Z1SH39uogNn1c31AjCcaTAbagSqPwoGYOWFGhmV
   gFWa4LJBiqv2cxChJeuYu+a3gVekVu/B+/ch8u5xVgW9f5bXRTySkTk/+
   s0L+pbhH6xs1QF0RXv1squtPbrnZeYl2pMqEoyBMTtXFU1SVkxhdVjfci
   Q==;
X-CSE-ConnectionGUID: aY8uToQ7QgSVq5IhXkXaUA==
X-CSE-MsgGUID: eqSbOCfpTvSXvfKBlupRLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884942"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884942"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:04 -0700
X-CSE-ConnectionGUID: PBvCfG+vRvKunH74mxz5gg==
X-CSE-MsgGUID: nJbh3AsKSIKgmJHgOz/6cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607534"
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
Subject: [RFC PATCH v1 11/13] mm: swap: Add IAA batch compression API swap_crypto_acomp_compress_batch().
Date: Thu, 17 Oct 2024 23:40:59 -0700
Message-Id: <20241018064101.336232-12-kanchana.p.sridhar@intel.com>
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

Added a new API swap_crypto_acomp_compress_batch() that does batch
compression. A system that has Intel IAA can avail of this API to submit a
batch of compress jobs for parallel compression in the hardware, to improve
performance. On a system without IAA, this API will process each compress
job sequentially.

The purpose of this API is to be invocable from any swap module that needs
to compress large folios, or a batch of pages in the general case. For
instance, zswap would batch compress up to SWAP_CRYPTO_SUB_BATCH_SIZE
(i.e. 8 if the system has IAA) pages in the large folio in parallel to
improve zswap_store() performance.

Towards this eventual goal:

1) The definition of "struct crypto_acomp_ctx" is moved to mm/swap.h
   so that mm modules like swap_state.c and zswap.c can reference it.
2) The swap_crypto_acomp_compress_batch() interface is implemented in
   swap_state.c.

It would be preferable for "struct crypto_acomp_ctx" to be defined in,
and for swap_crypto_acomp_compress_batch() to be exported via
include/linux/swap.h so that modules outside mm (for e.g. zram) can
potentially use the API for batch compressions with IAA. I would
appreciate RFC comments on this.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/swap.h       |  45 +++++++++++++++++++
 mm/swap_state.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/zswap.c      |   9 ----
 3 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 566616c971d4..4dcb67e2cc33 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -7,6 +7,7 @@ struct mempolicy;
 #ifdef CONFIG_SWAP
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
+#include <linux/crypto.h>
 
 /*
  * For IAA compression batching:
@@ -19,6 +20,39 @@ struct mempolicy;
 #define SWAP_CRYPTO_SUB_BATCH_SIZE 1UL
 #endif
 
+/* linux/mm/swap_state.c, zswap.c */
+struct crypto_acomp_ctx {
+	struct crypto_acomp *acomp;
+	struct acomp_req *req[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	u8 *buffer[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct crypto_wait wait;
+	struct mutex mutex;
+	bool is_sleepable;
+};
+
+/**
+ * This API provides IAA compress batching functionality for use by swap
+ * modules.
+ * The acomp_ctx mutex should be locked/unlocked before/after calling this
+ * procedure.
+ *
+ * @pages: Pages to be compressed.
+ * @dsts: Pre-allocated destination buffers to store results of IAA compression.
+ * @dlens: Will contain the compressed lengths.
+ * @errors: Will contain a 0 if the page was successfully compressed, or a
+ *          non-0 error value to be processed by the calling function.
+ * @nr_pages: The number of pages, up to SWAP_CRYPTO_SUB_BATCH_SIZE,
+ *            to be compressed.
+ * @acomp_ctx: The acomp context for iaa_crypto/other compressor.
+ */
+void swap_crypto_acomp_compress_batch(
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_pages,
+	struct crypto_acomp_ctx *acomp_ctx);
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
@@ -119,6 +153,17 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 
 #else /* CONFIG_SWAP */
 struct swap_iocb;
+struct crypto_acomp_ctx {};
+static inline void swap_crypto_acomp_compress_batch(
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_pages,
+	struct crypto_acomp_ctx *acomp_ctx)
+{
+}
+
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 4669f29cf555..117c3caa5679 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -23,6 +23,8 @@
 #include <linux/swap_slots.h>
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
+#include <linux/scatterlist.h>
+#include <crypto/acompress.h>
 #include "internal.h"
 #include "swap.h"
 
@@ -742,6 +744,119 @@ void exit_swap_address_space(unsigned int type)
 	swapper_spaces[type] = NULL;
 }
 
+#ifdef CONFIG_SWAP
+
+/**
+ * This API provides IAA compress batching functionality for use by swap
+ * modules.
+ * The acomp_ctx mutex should be locked/unlocked before/after calling this
+ * procedure.
+ *
+ * @pages: Pages to be compressed.
+ * @dsts: Pre-allocated destination buffers to store results of IAA compression.
+ * @dlens: Will contain the compressed lengths.
+ * @errors: Will contain a 0 if the page was successfully compressed, or a
+ *          non-0 error value to be processed by the calling function.
+ * @nr_pages: The number of pages, up to SWAP_CRYPTO_SUB_BATCH_SIZE,
+ *            to be compressed.
+ * @acomp_ctx: The acomp context for iaa_crypto/other compressor.
+ */
+void swap_crypto_acomp_compress_batch(
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_pages,
+	struct crypto_acomp_ctx *acomp_ctx)
+{
+	struct scatterlist inputs[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct scatterlist outputs[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	bool compressions_done = false;
+	int i, j;
+
+	BUG_ON(nr_pages > SWAP_CRYPTO_SUB_BATCH_SIZE);
+
+	/*
+	 * Prepare and submit acomp_reqs to IAA.
+	 * IAA will process these compress jobs in parallel in async mode.
+	 * If the compressor does not support a poll() method, or if IAA is
+	 * used in sync mode, the jobs will be processed sequentially using
+	 * acomp_ctx->req[0] and acomp_ctx->wait.
+	 */
+	for (i = 0; i < nr_pages; ++i) {
+		j = acomp_ctx->acomp->poll ? i : 0;
+		sg_init_table(&inputs[i], 1);
+		sg_set_page(&inputs[i], pages[i], PAGE_SIZE, 0);
+
+		/*
+		 * Each acomp_ctx->buffer[] is of size (PAGE_SIZE * 2).
+		 * Reflect same in sg_list.
+		 */
+		sg_init_one(&outputs[i], dsts[i], PAGE_SIZE * 2);
+		acomp_request_set_params(acomp_ctx->req[j], &inputs[i],
+					 &outputs[i], PAGE_SIZE, dlens[i]);
+
+		/*
+		 * If the crypto_acomp provides an asynchronous poll()
+		 * interface, submit the request to the driver now, and poll for
+		 * a completion status later, after all descriptors have been
+		 * submitted. If the crypto_acomp does not provide a poll()
+		 * interface, submit the request and wait for it to complete,
+		 * i.e., synchronously, before moving on to the next request.
+		 */
+		if (acomp_ctx->acomp->poll) {
+			errors[i] = crypto_acomp_compress(acomp_ctx->req[j]);
+
+			if (errors[i] != -EINPROGRESS)
+				errors[i] = -EINVAL;
+			else
+				errors[i] = -EAGAIN;
+		} else {
+			errors[i] = crypto_wait_req(
+					      crypto_acomp_compress(acomp_ctx->req[j]),
+					      &acomp_ctx->wait);
+			if (!errors[i])
+				dlens[i] = acomp_ctx->req[j]->dlen;
+		}
+	}
+
+	/*
+	 * If not doing async compressions, the batch has been processed at
+	 * this point and we can return.
+	 */
+	if (!acomp_ctx->acomp->poll)
+		return;
+
+	/*
+	 * Poll for and process IAA compress job completions
+	 * in out-of-order manner.
+	 */
+	while (!compressions_done) {
+		compressions_done = true;
+
+		for (i = 0; i < nr_pages; ++i) {
+			/*
+			 * Skip, if the compression has already completed
+			 * successfully or with an error.
+			 */
+			if (errors[i] != -EAGAIN)
+				continue;
+
+			errors[i] = crypto_acomp_poll(acomp_ctx->req[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					compressions_done = false;
+			} else {
+				dlens[i] = acomp_ctx->req[i]->dlen;
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(swap_crypto_acomp_compress_batch);
+
+#endif /* CONFIG_SWAP */
+
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
 			   unsigned long *end)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index 579869d1bdf6..cab3114321f9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -150,15 +150,6 @@ bool zswap_never_enabled(void)
 * data structures
 **********************************/
 
-struct crypto_acomp_ctx {
-	struct crypto_acomp *acomp;
-	struct acomp_req *req[SWAP_CRYPTO_SUB_BATCH_SIZE];
-	u8 *buffer[SWAP_CRYPTO_SUB_BATCH_SIZE];
-	struct crypto_wait wait;
-	struct mutex mutex;
-	bool is_sleepable;
-};
-
 /*
  * The lock ordering is zswap_tree.lock -> zswap_pool.lru_lock.
  * The only case where lru_lock is not acquired while holding tree.lock is
-- 
2.27.0


