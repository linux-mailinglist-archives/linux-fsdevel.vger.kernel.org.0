Return-Path: <linux-fsdevel+bounces-34792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73A9C8CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DF9B327B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28491632C5;
	Thu, 14 Nov 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTW9Em2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FA126C18;
	Thu, 14 Nov 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593601; cv=none; b=scDHTLSe5hxATH4w7X2YWMQBVUVsBMSj8rfoHW8W7mcVJ646wMCLqZ5EN+cN+49eewewgMKHEHTpQaYUyGrZekz3eeVaybi1uMXTFBFHKyCgrTn25clA3j4TkyHauS8YaON2A1wFKWqyInCQhToevnuhA96YDcYljerTGs6W3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593601; c=relaxed/simple;
	bh=073qr4pZH7Uu+/vIzBLAJkc8KYxFDYk8nK1jWNQTF+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6Ia+3KTKWO3AxIXEGd0qgJlZdjdlw4+RpA3k45oZbKVpxtec+f2ii/OeVvspZTuzD+QuLdZs2mhzER1ccDSSMbS98rhRj+GVRcqyDyX37Zt76iNfdTb+dV/3R6O/D+rlD1fY83qUaySI856C2Yu/bozhmG780LgNFkkQdFuTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTW9Em2J; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731593600; x=1763129600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=073qr4pZH7Uu+/vIzBLAJkc8KYxFDYk8nK1jWNQTF+Y=;
  b=gTW9Em2Jv5MxdMB6xomJeoYfeHGYsVQ1sB0JK0VYBWO93KR6H/aXmIjC
   b9TRF8MjB4N4uiUjiURkM345em/lmEupMQoSX+bq3IldkqJKFU25ZcnEh
   lJbBFfY7C3YkqRPNtXfKGtCcEGMAdZOFR67KIxdjBQNHlPAIDpDAbWCO9
   VFeEasnUl+ucCtd2cXbY+8yLxgpfk+HHtqKrAgln8BaucLKss/OVDoQrU
   +dl4x/CUoe3f9U44FRvDdpTgDUGd3jVWcP4y9sTYeWG5tQe7cTP4LBMQF
   ejZGU8COMY/npxjELMX/VJSYO+enT28DzeJ5l2/BTs8wirvAmb6GpwDfT
   Q==;
X-CSE-ConnectionGUID: 9sEMSLWOR0+EcIipG3UaWg==
X-CSE-MsgGUID: RFEQ1qclSe2cOGVRHm7a+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="19144980"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="19144980"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:13:19 -0800
X-CSE-ConnectionGUID: N455L5+cREO7g5FjP26qYg==
X-CSE-MsgGUID: zOujwtS7QtaHGignXf2m5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="88635314"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.98.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:13:16 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/4] iov_iter: Provide copy_iomem_to|from_iter()
Date: Thu, 14 Nov 2024 15:12:38 +0100
Message-Id: <20241114141238.2255-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20241112200454.2211-2-michal.wajdeczko@intel.com>
References: <20241112200454.2211-2-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define simple copy helpers that work on I/O memory. This will
allow reuse of existing framework functions in new use cases.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
v2: use iterate_and_advance to treat user_iter separately (Matthew)
v3: add explicit casts to make sparse happy (kernel test robot)
---
 include/linux/uio.h |  3 +++
 lib/iov_iter.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 853f9de5aa05..354a6b2d1e94 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -183,6 +183,9 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
 
+size_t copy_iomem_to_iter(const void __iomem *from, size_t bytes, struct iov_iter *i);
+size_t copy_iomem_from_iter(void __iomem *to, size_t bytes, struct iov_iter *i);
+
 static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 908e75a28d90..a6eae4063366 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -323,6 +323,72 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 #endif
 
+static __always_inline
+size_t memcpy_iomem_to_iter(void *iter_to, size_t progress, size_t len,
+			    void *from, void *priv2)
+{
+	memcpy_fromio(iter_to, (const void __iomem *)from + progress, len);
+	return 0;
+}
+
+static __always_inline
+size_t memcpy_iomem_from_iter(void *iter_from, size_t progress, size_t len,
+			      void *to, void *priv2)
+{
+	memcpy_toio((void __iomem *)to + progress, iter_from, len);
+	return 0;
+}
+
+static __always_inline
+size_t copy_iomem_to_user_iter(void __user *iter_to, size_t progress,
+			       size_t len, void *from, void *priv2)
+{
+	unsigned char buf[SMP_CACHE_BYTES];
+	size_t chunk = min(len, sizeof(buf));
+
+	memcpy_fromio(buf, (const void __iomem *)from + progress, chunk);
+	chunk -= copy_to_user_iter(iter_to, progress, chunk, buf, priv2);
+	return len - chunk;
+}
+
+static __always_inline
+size_t copy_iomem_from_user_iter(void __user *iter_from, size_t progress,
+				 size_t len, void *to, void *priv2)
+{
+	unsigned char buf[SMP_CACHE_BYTES];
+	size_t chunk = min(len, sizeof(buf));
+
+	chunk -= copy_from_user_iter(iter_from, progress, chunk, buf, priv2);
+	memcpy_toio((void __iomem *)to, buf, chunk);
+	return len - chunk;
+}
+
+size_t copy_iomem_to_iter(const void __iomem *from, size_t bytes, struct iov_iter *i)
+{
+	if (WARN_ON_ONCE(i->data_source))
+		return 0;
+	if (user_backed_iter(i))
+		might_fault();
+
+	return iterate_and_advance(i, bytes, (void __force *)from,
+				   copy_iomem_to_user_iter,
+				   memcpy_iomem_to_iter);
+}
+EXPORT_SYMBOL(copy_iomem_to_iter);
+
+size_t copy_iomem_from_iter(void __iomem *to, size_t bytes, struct iov_iter *i)
+{
+	if (WARN_ON_ONCE(!i->data_source))
+		return 0;
+	if (user_backed_iter(i))
+		might_fault();
+
+	return iterate_and_advance(i, bytes, (void __force *)to,
+				   copy_iomem_from_user_iter,
+				   memcpy_iomem_from_iter);
+}
+EXPORT_SYMBOL(copy_iomem_from_iter);
+
 static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 {
 	struct page *head;
-- 
2.43.0


