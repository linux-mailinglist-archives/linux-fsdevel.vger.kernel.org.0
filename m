Return-Path: <linux-fsdevel+bounces-33923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734499C0BC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378B0283DA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A78216459;
	Thu,  7 Nov 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sh+yWnAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7221219F;
	Thu,  7 Nov 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997309; cv=none; b=hwcXr/Q5otnX/jnIM4yFZVlgpgdHbavHO0nrnB1Sm2nHnmif7qkHv1CuLB5g+XnbDEKf7OLWkk7yGt+/RY6KSDxp11JSahBrpbybLdtbLqkzyV1WNEnzKzVe+F/ZL5s8o7uFspPzOXIj8uuj1uUH1Bien0qgEntGFem4sjXmlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997309; c=relaxed/simple;
	bh=dmPkADiBavZ9q8H4vqaymnrDdnCSO5K6p28HUKcBoQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM8O8nAGHlCE635twCXy+F/q6rdspZi24jaMIkC3OpCY9GMQslwq0/+XCMR5iDGc4Sjc+YWvsY/v9ofjwl5dR+nmWQkCu9vsS2fviv0fdUbhJ2LgElaOc1mTaGqTtsDsf3Tt3xKOdRatWVdwGuAEyUDF1GBc+buXERaUMCClsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sh+yWnAN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730997307; x=1762533307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dmPkADiBavZ9q8H4vqaymnrDdnCSO5K6p28HUKcBoQg=;
  b=Sh+yWnANUNSezt06L9VumPaRYbk016MexMjL5hWeFFYXcyfTcfIvjIUC
   MaZVSqoK7HchpO1eu6Da078DhLy3sNS/Hm4F0pSreCNcnO0pdTjVvOerj
   Z/40lJ61gAImWb/b4/KQhT9NIXGf0dNqNo59p1EkrVyipXNXIjItFDw/8
   zFuueRhJgQR93gTYzmWzsEK8Ac+ZBpvduZR5x5Ms9/mEqvI3voqGiqAKO
   iTv9+xy5Odye1lG21dFm2/OMWgfUn9kE7mTGkVK+5jeUAMXSBB2iSvcph
   SeOwXZksvQ2xbsyCC4Lafs6SIpCo9CJS5ugarXo63oYHSfW19FeXMyTUn
   Q==;
X-CSE-ConnectionGUID: rFJUb9b9SpCb0oxCi8MEhQ==
X-CSE-MsgGUID: yQGtWUbuT66C5hjUQZNuWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="18480131"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="18480131"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:35:07 -0800
X-CSE-ConnectionGUID: O6fhHQF1RVGaJWWucZdTJg==
X-CSE-MsgGUID: 5TIc9iALTBuLr09DPBb7KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="89797004"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.2.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:35:05 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] iov_iter: Provide copy_iomem_to|from_iter()
Date: Thu,  7 Nov 2024 17:34:45 +0100
Message-Id: <20241107163448.2123-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20241107163448.2123-1-michal.wajdeczko@intel.com>
References: <20241107163448.2123-1-michal.wajdeczko@intel.com>
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
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 include/linux/uio.h |  4 ++++
 lib/iov_iter.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 853f9de5aa05..6d2a24293bd1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -178,6 +178,10 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+size_t copy_iomem_to_iter(const void __iomem *from, size_t offset,
+			  size_t bytes, struct iov_iter *i);
+size_t copy_iomem_from_iter(void __iomem *to, size_t offset,
+			    size_t bytes, struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 908e75a28d90..e8c1f1c68716 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -435,6 +435,48 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
+size_t copy_iomem_to_iter(const void __iomem *from, size_t offset,
+			  size_t bytes, struct iov_iter *i)
+{
+	unsigned char buf[SMP_CACHE_BYTES];
+	size_t progress = 0, copied, len;
+
+	from += offset;
+	while (bytes) {
+		len = min(bytes, sizeof(buf));
+		memcpy_fromio(buf, from + progress, len);
+		copied = _copy_to_iter(buf, len, i);
+		if (!copied)
+			break;
+		bytes -= copied;
+		progress += copied;
+	}
+
+	return progress;
+}
+EXPORT_SYMBOL(copy_iomem_to_iter);
+
+size_t copy_iomem_from_iter(void __iomem *to, size_t offset,
+			    size_t bytes, struct iov_iter *i)
+{
+	unsigned char buf[SMP_CACHE_BYTES];
+	size_t progress = 0, copied, len;
+
+	to += offset;
+	while (bytes) {
+		len = min(bytes, sizeof(buf));
+		copied = _copy_from_iter(buf, len, i);
+		if (!copied)
+			break;
+		memcpy_toio(to + progress, buf, copied);
+		bytes -= copied;
+		progress += copied;
+	}
+
+	return progress;
+}
+EXPORT_SYMBOL(copy_iomem_from_iter);
+
 static __always_inline
 size_t zero_to_user_iter(void __user *iter_to, size_t progress,
 			 size_t len, void *priv, void *priv2)
-- 
2.43.0


