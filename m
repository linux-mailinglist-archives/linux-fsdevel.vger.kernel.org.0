Return-Path: <linux-fsdevel+bounces-32312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8F9A35BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304431C216AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8A18E03F;
	Fri, 18 Oct 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWuGYRYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923411885B8;
	Fri, 18 Oct 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233667; cv=none; b=kzXaYxD0uEIjB+QwteKDuLyUzlBp/wqUSjZKPkg+OjRjemrYvyRRZnGzXpaOOOr9hxgC8oFy3HRKvPMzd1EB6pG39FgTKWlx7azCTblOF/UWr5el6Mr3lKdYG2suGAL+VU0GfbActosbZOJbxoTOElUpXBPVbJn0ssJXRv3EGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233667; c=relaxed/simple;
	bh=+wwI3G60HC02QVcBH/92bWn6u+fpHdMtlQxgJjc/fNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYxLngm/bfG4RZtCs6terrtrPvNGJEqp1UpBdV9PuxnDSbgLL0MQhiX8/B8iTYubcEpRWGr7RpMJKyeByMkLFF70WGj5oO8w5/U+WWQkZxeBFF+duAEYndy1zjj8Wg4O4OwuEci5jIW1c44U2WuE8cM4+WPOeUvDsgX5KdLXRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWuGYRYc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233666; x=1760769666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+wwI3G60HC02QVcBH/92bWn6u+fpHdMtlQxgJjc/fNE=;
  b=cWuGYRYczGZMRpiW1ug5L4UFgqNP69gsjarBTLkPCJzmXiL2L27oV6rP
   OWAsmU/3quRohIoEg+K6GRhPo/tQ7WpyMNPsz/WqAXhJYmoGrpSyd52V1
   fF1eVWyvieRBBm+fFyN1MVqf6maCq54WZRAtRJAsX67MK9yy0X01ED2Gd
   Qg51AvTMl2t+827/leCdSk9dBGN0izDp+KssF+3Zt8Qddke1ribYCY0ai
   /2UTjjRkbza3r15ad2w1hbBsLLLD6lA9WG53LxfIhI4LFEctZFvkk0Wml
   s7LrSCrXf2wcwv9Ez3v5MZswJEjTn95JhmosCVa9A8KcVpLNyOmYLO25v
   Q==;
X-CSE-ConnectionGUID: aCNhzx+OQZy13ZaO6cQE6Q==
X-CSE-MsgGUID: NpZmt4NIRCmvFKrorfRauQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884807"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:02 -0700
X-CSE-ConnectionGUID: bd2/xxwGQ2WQ6ujF1GVEZA==
X-CSE-MsgGUID: luRQ3pv+QyWsohgkCEdd8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607497"
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
Subject: [RFC PATCH v1 03/13] crypto: testmgr - Add crypto testmgr acomp poll support.
Date: Thu, 17 Oct 2024 23:40:51 -0700
Message-Id: <20241018064101.336232-4-kanchana.p.sridhar@intel.com>
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

This patch enables the newly added acomp poll API to be exercised in the
crypto test_acomp() calls to compress/decompress, if the acomp registers
a poll method.

Signed-off-by: Glover, Andre <andre.glover@intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 crypto/testmgr.c | 70 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index ee8da628e9da..54f6f59ae501 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -3482,7 +3482,19 @@ static int test_acomp(struct crypto_acomp *tfm,
 		acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 					   crypto_req_done, &wait);
 
-		ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
+		if (tfm->poll) {
+			ret = crypto_acomp_compress(req);
+			if (ret == -EINPROGRESS) {
+				do {
+					ret = crypto_acomp_poll(req);
+					if (ret && ret != -EAGAIN)
+						break;
+				} while (ret);
+			}
+		} else {
+			ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
+		}
+
 		if (ret) {
 			pr_err("alg: acomp: compression failed on test %d for %s: ret=%d\n",
 			       i + 1, algo, -ret);
@@ -3498,7 +3510,19 @@ static int test_acomp(struct crypto_acomp *tfm,
 		crypto_init_wait(&wait);
 		acomp_request_set_params(req, &src, &dst, ilen, dlen);
 
-		ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+		if (tfm->poll) {
+			ret = crypto_acomp_decompress(req);
+			if (ret == -EINPROGRESS) {
+				do {
+					ret = crypto_acomp_poll(req);
+					if (ret && ret != -EAGAIN)
+						break;
+				} while (ret);
+			}
+		} else {
+			ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+		}
+
 		if (ret) {
 			pr_err("alg: acomp: compression failed on test %d for %s: ret=%d\n",
 			       i + 1, algo, -ret);
@@ -3531,7 +3555,19 @@ static int test_acomp(struct crypto_acomp *tfm,
 		sg_init_one(&src, input_vec, ilen);
 		acomp_request_set_params(req, &src, NULL, ilen, 0);
 
-		ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
+		if (tfm->poll) {
+			ret = crypto_acomp_compress(req);
+			if (ret == -EINPROGRESS) {
+				do {
+					ret = crypto_acomp_poll(req);
+					if (ret && ret != -EAGAIN)
+						break;
+				} while (ret);
+			}
+		} else {
+			ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
+		}
+
 		if (ret) {
 			pr_err("alg: acomp: compression failed on NULL dst buffer test %d for %s: ret=%d\n",
 			       i + 1, algo, -ret);
@@ -3574,7 +3610,19 @@ static int test_acomp(struct crypto_acomp *tfm,
 		acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 					   crypto_req_done, &wait);
 
-		ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+		if (tfm->poll) {
+			ret = crypto_acomp_decompress(req);
+			if (ret == -EINPROGRESS) {
+				do {
+					ret = crypto_acomp_poll(req);
+					if (ret && ret != -EAGAIN)
+						break;
+				} while (ret);
+			}
+		} else {
+			ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+		}
+
 		if (ret) {
 			pr_err("alg: acomp: decompression failed on test %d for %s: ret=%d\n",
 			       i + 1, algo, -ret);
@@ -3606,7 +3654,19 @@ static int test_acomp(struct crypto_acomp *tfm,
 		crypto_init_wait(&wait);
 		acomp_request_set_params(req, &src, NULL, ilen, 0);
 
-		ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+		if (tfm->poll) {
+			ret = crypto_acomp_decompress(req);
+			if (ret == -EINPROGRESS) {
+				do {
+					ret = crypto_acomp_poll(req);
+					if (ret && ret != -EAGAIN)
+						break;
+				} while (ret);
+			}
+		} else {
+			ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+		}
+
 		if (ret) {
 			pr_err("alg: acomp: decompression failed on NULL dst buffer test %d for %s: ret=%d\n",
 			       i + 1, algo, -ret);
-- 
2.27.0


