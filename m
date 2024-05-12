Return-Path: <linux-fsdevel+bounces-19348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7798C3721
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 17:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790A828151F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930A46557;
	Sun, 12 May 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRQ+NXX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC73FB8B
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528196; cv=none; b=lJEXNgvZVe1d6WCgTyZ00Y/mHkbobzGGQ+SILgkidI/xWesD/Be+KnL/6fV74IEyc3LqbArr1cmLjVDR9uE45LzH2yP55ARhUVv1I+aGY50UBbtoVXuFlmc4n5KKHhJ2etwXmYPNDZrjx4pOp2/lVMLP7+0Qma3q5Vea5S/xReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528196; c=relaxed/simple;
	bh=Zv3dENl+B07Af4W2wswlYvH7KrFD7s2CNxHPDgLv2v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUNQjkFN0WA4fW6NUYe0DHVrewGqDGssBoyDv+sXlSqllbEWVkcB+M4wNluA58mEGvcST8PubDRF94a1XyzDYc/JiKAHgnlIuqS2x4cXq60YncoF+59l7UYKoxXhvDyb6st7DNyWgCALGiHNobL0C2u5wBKRClqd8ZfxTUjFSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRQ+NXX/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715528195; x=1747064195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zv3dENl+B07Af4W2wswlYvH7KrFD7s2CNxHPDgLv2v4=;
  b=DRQ+NXX/Y+HERE2kXCtfoIhZ7t5GihEP1Xg9wjle5Zayg3+RcAKFUAgE
   Z8ECiAZF4i9mJV37UvCkmQZgZi14nbpXuA1KeTrDxiGUt3PvimMyvYcpp
   Yluz8wGncOFAY3B7Lzl+diKHVbltJv0Vup69ti5vo9aIocTQiLCWfUBbn
   p4LUiYGNwWpCZzU5zX6KnTQhIGdHavZDquZo4fi/LCDFXAqeZOrGkQqrD
   0HxbZABwY+4bA6TqBPmqyk7mL9kEtqziYNTbepuyxJmk5qPiEsBIGl6Ph
   Ha95+QVLhGh34444XWkQLiU0gcBI68iBAVEWDjUm4nrkCGpMuq22IgyQr
   w==;
X-CSE-ConnectionGUID: hmXstghGTl+4NXA2WObvXQ==
X-CSE-MsgGUID: 5hm8LUfCQxm/AmMfQ357RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11403310"
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="11403310"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:35 -0700
X-CSE-ConnectionGUID: +MHMnX9jRyuzFWgXe65Z6w==
X-CSE-MsgGUID: wC86a7wLSWqmGz0G1nk7Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="34976581"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.25.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:32 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] drm/xe: Add wrapper for iosys_map_read_from
Date: Sun, 12 May 2024 17:36:05 +0200
Message-Id: <20240512153606.1996-4-michal.wajdeczko@intel.com>
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

It is preferable to use the xe_map layer instead of directly
accessing iosys_map, so add a wrapper for the recently added
iosys_map_read_from() function.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
Cc: linux-fsdevel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/xe/xe_map.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_map.h b/drivers/gpu/drm/xe/xe_map.h
index f62e0c8b67ab..1db1d23c4f69 100644
--- a/drivers/gpu/drm/xe/xe_map.h
+++ b/drivers/gpu/drm/xe/xe_map.h
@@ -44,6 +44,15 @@ static inline void xe_map_memset(struct xe_device *xe,
 	iosys_map_memset(dst, offset, value, len);
 }
 
+static inline ssize_t xe_map_read_from(struct xe_device *xe, void __user *to,
+				       size_t count, loff_t *ppos,
+				       const struct iosys_map *map,
+				       size_t available)
+{
+	xe_device_assert_mem_access(xe);
+	return iosys_map_read_from(to, count, ppos, map, available);
+}
+
 /* FIXME: We likely should kill these two functions sooner or later */
 static inline u32 xe_map_read32(struct xe_device *xe, struct iosys_map *map)
 {
-- 
2.43.0


