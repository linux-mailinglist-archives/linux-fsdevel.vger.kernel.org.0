Return-Path: <linux-fsdevel+bounces-32313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F09A35BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769B11C2399D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3A18E34A;
	Fri, 18 Oct 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liLzqMSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02788188917;
	Fri, 18 Oct 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233667; cv=none; b=AqVt+3zCufOoYYU+lsUoP/YuEJH7Gu5ii3Zy+0q5H2NU1t9qVpCrNHcaZnWgz8XdDDt8Qidq6DcjaWOnjG79/m5lZ6kH5fEGW0Ims+VTOywLg+edBwK9cPhNFykXXG5nNDt/762Ia9ZP4zcNeE8KHI1ZU5QeE86m7Yr4rlWTk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233667; c=relaxed/simple;
	bh=gtInCloZyEBkd8uVBGAQIApykz7xeQMHHy5TXu53KaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvpuXJN1yyJS13mEVk+YOGnVKQa4PkKX2TRRmi0Ltp70EeXKuzuqF0+zww9bVTOtko5WhnIoPnVbFkwc4+RPfuFu2RVp99tecGMIGkoyKsiIysbHBE4f/2Phyud9ZbcvfI5KpLC4z1LaV6Uk8TniUcMSCcurzBF7w9NaWxWnHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liLzqMSO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233666; x=1760769666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gtInCloZyEBkd8uVBGAQIApykz7xeQMHHy5TXu53KaI=;
  b=liLzqMSOCC1RMSD4oAIjy0k9BxOlvJSR9BvcdqJF8SlwZEekJYz6uJfl
   anr6CyJEfLgmdaxbXtw8Iaxz3viJl/XsYuHuNUJEwfTdRhyjZvOGthM53
   ZHull+yRnZiLhkAOOQ+mQPXx5pjKw+kKInNiS2VGnRNVEAVF8chUwGWMq
   x9WtyJHXsxLOchS70C9h1A7vN5RMxbpspSz4IgQ7mlRzJKNukq5fSG9Tn
   20H8IHOEhXQMG3YLCy+v8K/VBv+HMKl1RZFIJVF/IT7Iq46hWitDxScIT
   MCdzdHIfwVuxVcNKE5uJdQDmTyhhrq3AAucQsNK4z6zKtWHCxJP13msau
   Q==;
X-CSE-ConnectionGUID: sgpdQsPeTdSd5AQQsr5BMQ==
X-CSE-MsgGUID: vudRWV45S32K92de4AOPcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884822"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884822"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:02 -0700
X-CSE-ConnectionGUID: S5P7Z3aMRMezS5ESvvkKGg==
X-CSE-MsgGUID: 95MDyyYsR9OFLjtcK6GVSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607500"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:02 -0700
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
Subject: [RFC PATCH v1 04/13] mm: zswap: zswap_compress()/decompress() can submit, then poll an acomp_req.
Date: Thu, 17 Oct 2024 23:40:52 -0700
Message-Id: <20241018064101.336232-5-kanchana.p.sridhar@intel.com>
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

If the crypto_acomp has a poll interface registered, zswap_compress()
and zswap_decompress() will submit the acomp_req, and then poll() for a
successful completion/error status in a busy-wait loop. This allows an
asynchronous way to manage (potentially multiple) acomp_reqs without
the use of interrupts, which is supported in the iaa_crypto driver.

This enables us to implement batch submission of multiple
compression/decompression jobs to the Intel IAA hardware accelerator,
which will process them in parallel; followed by polling the batch's
acomp_reqs for completion status.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb23..948c9745ee57 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -910,18 +910,34 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
 
 	/*
-	 * it maybe looks a little bit silly that we send an asynchronous request,
-	 * then wait for its completion synchronously. This makes the process look
-	 * synchronous in fact.
-	 * Theoretically, acomp supports users send multiple acomp requests in one
-	 * acomp instance, then get those requests done simultaneously. but in this
-	 * case, zswap actually does store and load page by page, there is no
-	 * existing method to send the second page before the first page is done
-	 * in one thread doing zwap.
-	 * but in different threads running on different cpu, we have different
-	 * acomp instance, so multiple threads can do (de)compression in parallel.
+	 * If the crypto_acomp provides an asynchronous poll() interface,
+	 * submit the descriptor and poll for a completion status.
+	 *
+	 * It maybe looks a little bit silly that we send an asynchronous
+	 * request, then wait for its completion in a busy-wait poll loop, or,
+	 * synchronously. This makes the process look synchronous in fact.
+	 * Theoretically, acomp supports users send multiple acomp requests in
+	 * one acomp instance, then get those requests done simultaneously.
+	 * But in this case, zswap actually does store and load page by page,
+	 * there is no existing method to send the second page before the
+	 * first page is done in one thread doing zswap.
+	 * But in different threads running on different cpu, we have different
+	 * acomp instance, so multiple threads can do (de)compression in
+	 * parallel.
 	 */
-	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	if (acomp_ctx->acomp->poll) {
+		comp_ret = crypto_acomp_compress(acomp_ctx->req);
+		if (comp_ret == -EINPROGRESS) {
+			do {
+				comp_ret = crypto_acomp_poll(acomp_ctx->req);
+				if (comp_ret && comp_ret != -EAGAIN)
+					break;
+			} while (comp_ret);
+		}
+	} else {
+		comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	}
+
 	dlen = acomp_ctx->req->dlen;
 	if (comp_ret)
 		goto unlock;
@@ -959,6 +975,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
+	int ret;
 
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
@@ -984,7 +1001,17 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
+	if (acomp_ctx->acomp->poll) {
+		ret = crypto_acomp_decompress(acomp_ctx->req);
+		if (ret == -EINPROGRESS) {
+			do {
+				ret = crypto_acomp_poll(acomp_ctx->req);
+				BUG_ON(ret && ret != -EAGAIN);
+			} while (ret);
+		}
+	} else {
+		BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
+	}
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-- 
2.27.0


