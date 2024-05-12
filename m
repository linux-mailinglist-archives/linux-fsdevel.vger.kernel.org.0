Return-Path: <linux-fsdevel+bounces-19347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FCC8C371E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98470281457
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92544374;
	Sun, 12 May 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/w4m01x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940340BE3
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528195; cv=none; b=P3Um50Fj/cXAw4OAHop6UiTyRK0/kUvrRB3GL4pPi3cwE0q7j2wO7wWxp0hRqZP6GwrSWEts+XV6Tb716RKXZk3xgaQwwcqGH/cqAsxLbLncbLN/9TWhU7SJK/08IEcafZr6or7XNMVYMLI+x6egZemQMvroHac7vgmN1W1lAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528195; c=relaxed/simple;
	bh=UpBLsNtwkuXGVcD/TaGHbR2icCa517yQEVl4pgTWrf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqAE2m8aoU8WBv70ORnf5kxQdz+46+0kxX7q1KRmJEElkjyba+HyarRrjPcB08FGTWj4x8Qzo+t3lQtkN0oHOnFAO4je9MFEw4Q2sXT3sz8Z4qBveh98+3tU6qBBs5Gb/poppP7TWxqTKqgWi8I/6QBXauaZCtmwAcPTF3Cg8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/w4m01x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715528193; x=1747064193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UpBLsNtwkuXGVcD/TaGHbR2icCa517yQEVl4pgTWrf8=;
  b=J/w4m01x4FVA+MhFym54jYC3/gZATPi/ti33afaaVNguy2wFJ4Cgp60b
   4v/2Qbn/rYdPIWsTSJI7sHZWN9IHr6qSia1R7FMYHFG/Av3RIEBkF9J5u
   lnmK5ZaNuaoxlD5sj8r9RhDxgpP6LGielCMexCyLQrPkgPZgzU0nm+P5E
   ycELFFZ1vDbcTdn44J0E/d8H1XEhj3GzHtN6njw6Qb7ce4CvKYXTBn5yu
   HkSPWCVyJzTV7y8OFeSZvStAArTpqGGJg+RNw3p1vOekr4roKHu7PIu3L
   zjaVMCsJrDOG2u0jcu0VuIt2pnSdXCa7ZjnitEXKr3O5nL4X2AVthYYZz
   g==;
X-CSE-ConnectionGUID: LObg3j9IQJGUPgBi9NMt2Q==
X-CSE-MsgGUID: PRV86HxSTTqfg56+lyBUuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11403305"
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="11403305"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:33 -0700
X-CSE-ConnectionGUID: xRUy/3fVTKG3IzZ9/ieCOg==
X-CSE-MsgGUID: Xe/sFGcnRIubxVaa9acUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="34976572"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.25.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:29 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/4] iosys-map: add iosys_map_read_from() helper
Date: Sun, 12 May 2024 17:36:04 +0200
Message-Id: <20240512153606.1996-3-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240512153606.1996-1-michal.wajdeczko@intel.com>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It allows to copy data from iosys_map into the user memory,
regardless whether iosys_map points to memory or I/O memory.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: linux-fsdevel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/linux/iosys-map.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
index 4696abfd311c..eb79da976211 100644
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -7,6 +7,7 @@
 #define __IOSYS_MAP_H__
 
 #include <linux/compiler_types.h>
+#include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/string.h>
 
@@ -312,6 +313,29 @@ static inline void iosys_map_memcpy_from(void *dst, const struct iosys_map *src,
 		memcpy(dst, src->vaddr + src_offset, len);
 }
 
+/**
+ * iosys_map_read_from - Copy data from iosys_map into user memory
+ * @to: the user space buffer to read to
+ * @count: the maximum number of bytes to read
+ * @ppos: the current position in the buffer
+ * @map: the iosys_map structure to read from
+ * @available: the size of the data in iosys_map
+ *
+ * Copies up to @count bytes from a iosys_map @map at offset @ppos into the user
+ * space address starting at @to.
+ *
+ * Return: On success, the number of bytes read is returned and the offset
+ * @ppos is advanced by this number, or negative value is returned on error.
+ */
+static inline ssize_t iosys_map_read_from(void __user *to, size_t count, loff_t *ppos,
+					  const struct iosys_map *map, size_t available)
+{
+	if (map->is_iomem)
+		return simple_read_from_iomem(to, count, ppos, map->vaddr_iomem, available);
+	else
+		return simple_read_from_buffer(to, count, ppos, map->vaddr, available);
+}
+
 /**
  * iosys_map_incr - Increments the address stored in a iosys mapping
  * @map:	The iosys_map structure
-- 
2.43.0


