Return-Path: <linux-fsdevel+bounces-34539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B889C621C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A392831CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762F6219E3B;
	Tue, 12 Nov 2024 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9MltX4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F4219CAE;
	Tue, 12 Nov 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441932; cv=none; b=Q+NvDm4dv1IuiH4cCrHYl//T1is2pz5ugrJRXjunJ1OtUa6vbf2snGJ9oHzGVEN7p+Ch0eXNL6W6reRMI+zwfoRqxBs828cD+/rrW3/xrCVXRXh4rZOUETwuD8Tel4fpxu3VmvtRzUYCPcldmiZPZv80vwJFePJgCTIqk56lbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441932; c=relaxed/simple;
	bh=0lG15kvrwthhBgUnnIY8645WTCslO9IzgIe86UWIETQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwj3gCsI0iZcb6pnQ+I1xGgUOQwAtN0sU2iqpGO18PWpEQ4KudtTf6Oi+qgzqljGca5uv+so0X+KTHIYotpP4oWcOzNy98kSJTtqRl/BP7ESOZyU8eISWpzZ0Ak8NHNIBSdG23IQ8yrtjKu6FuGxOtOdHoGVuIHBm2PBhn25YGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9MltX4L; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731441931; x=1762977931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0lG15kvrwthhBgUnnIY8645WTCslO9IzgIe86UWIETQ=;
  b=M9MltX4LVo2UuZEksnw6XvIq93qhWWcKzLeDsOptokwvsiSmi4+qQPV4
   g3BBZzTeB9PPzCy37sDm9CyrI89A122/jo4FuyRxV0SyHHDyzo0UD4iES
   He11o7gw291YWjavH0hSlhUeFtzrLxxxYpq9/g+ZzXW0tIr9omu5hOet0
   t3O65vMVPVkRSgCMtch1rDf6DbGYk1x0X90LvDUIKUWX/47HBPH4/UKD4
   oPLaBghIXnruOUcbQpJMRP8jrzx5/w5ckK84qk61eNu/sEyI0FMyyiTiX
   KbGraZys7HtwysebFcfJVNep6pg8gJVa1gC9imi4rImR/jZhrMU8inNqU
   g==;
X-CSE-ConnectionGUID: nukfab22Rs2jdGPNrljm1w==
X-CSE-MsgGUID: o+hYxEQlQP6SUBLV74YSBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31394355"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="31394355"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:05:31 -0800
X-CSE-ConnectionGUID: nPyVFpwyRWm4tRsipLTDgw==
X-CSE-MsgGUID: QgKPdQDJRvunV8YY/sA4Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="92710354"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.85.128])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 12:05:28 -0800
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
Subject: [PATCH v2 1/4] iov_iter: Provide copy_iomem_to|from_iter()
Date: Tue, 12 Nov 2024 21:04:51 +0100
Message-Id: <20241112200454.2211-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20241112200454.2211-1-michal.wajdeczko@intel.com>
References: <20241112200454.2211-1-michal.wajdeczko@intel.com>
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
index 908e75a28d90..80feff9c8875 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -323,6 +323,72 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 #endif
 
+static __always_inline
+size_t memcpy_iomem_to_iter(void *iter_to, size_t progress, size_t len,
+			    void *from, void *priv2)
+{
+	memcpy_fromio(iter_to, from + progress, len);
+	return 0;
+}
+
+static __always_inline
+size_t memcpy_iomem_from_iter(void *iter_from, size_t progress, size_t len,
+			      void *to, void *priv2)
+{
+	memcpy_toio(to + progress, iter_from, len);
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
+	memcpy_fromio(buf, from + progress, chunk);
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
+	memcpy_toio(to, buf, chunk);
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
+	return iterate_and_advance(i, bytes, (void *)from,
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
+	return iterate_and_advance(i, bytes, (void *)to,
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


