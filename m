Return-Path: <linux-fsdevel+bounces-1842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6886D7DF68B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0D01C20F67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411FC1CFA7;
	Thu,  2 Nov 2023 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDImB6zY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310521CF8C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:35:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A93A13D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698939326; x=1730475326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QEsRf6BrdZleGwPMkzbeFE0Q+HK8lQ0s6tZed+vcjU8=;
  b=fDImB6zYFCHoFkJFuwv2S2UjFC0retVV7R/74B8LOdM2mdimHJADHv8J
   8BU6EB/go1KbvqYlkdj9XTjR94itbH9jYzW029t/te4wOMYcTgjAaHZz7
   wZiO0gfXq0kvcZFeaXORKI9bgvlwOT4SX9IcL6v58o1uwTC8YLD6ObAj+
   2Cpt85JnxnBwSZ92YnvB1lbAzUrnDslD5OAR4KLUn3c10wZyHbVKM4Ckj
   D3fPoTuzFz7XXbFjs6sPXGr/LGLd5mSApBfvHfQvTcPvPJYqicIDy5NGy
   NQSZzLx6z7TJn/x0e2G1rnCMi+vGVGgto10JETZzC9A44oygpCoOYOb6O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419848027"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="419848027"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="9042473"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:25 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-fsdevel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/3] ida: Introduce ida_weight()
Date: Thu,  2 Nov 2023 16:34:53 +0100
Message-Id: <20231102153455.1252-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231102153455.1252-1-michal.wajdeczko@intel.com>
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper function that will calculate number of allocated IDs
in the IDA.  This might be helpful both for drivers to estimate
saturation of used IDs and for testing the IDA implementation.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/idr.h |  1 +
 lib/idr.c           | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..f477e35c9619 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -255,6 +255,7 @@ struct ida {
 int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
 void ida_free(struct ida *, unsigned int id);
 void ida_destroy(struct ida *ida);
+unsigned long ida_weight(struct ida *ida);
 
 /**
  * ida_alloc() - Allocate an unused ID.
diff --git a/lib/idr.c b/lib/idr.c
index 13f2758c2377..ed987a0fc25a 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -554,6 +554,31 @@ void ida_destroy(struct ida *ida)
 }
 EXPORT_SYMBOL(ida_destroy);
 
+/**
+ * ida_weight() - Calculate number of allocated IDs.
+ * @ida: IDA handle.
+ *
+ * Return: Number of allocated IDs in this IDA.
+ */
+unsigned long ida_weight(struct ida *ida)
+{
+	XA_STATE(xas, &ida->xa, 0);
+	struct ida_bitmap *bitmap;
+	unsigned long weight = 0;
+	unsigned long flags;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_for_each(&xas, bitmap, ULONG_MAX) {
+		weight += xa_is_value(bitmap) ?
+			hweight_long(xa_to_value(bitmap)) :
+			bitmap_weight(bitmap->bitmap, IDA_BITMAP_BITS);
+	}
+	xas_unlock_irqrestore(&xas, flags);
+
+	return weight;
+}
+EXPORT_SYMBOL(ida_weight);
+
 #ifndef __KERNEL__
 extern void xa_dump_index(unsigned long index, unsigned int shift);
 #define IDA_CHUNK_SHIFT		ilog2(IDA_BITMAP_BITS)
-- 
2.25.1


