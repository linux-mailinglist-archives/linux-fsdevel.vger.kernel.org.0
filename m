Return-Path: <linux-fsdevel+bounces-44538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB812A6A3A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCA416F03C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B522424D;
	Thu, 20 Mar 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkSD8vcU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE6215783;
	Thu, 20 Mar 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466502; cv=none; b=G+mTZ9WMNEpB44iINEDDHkTtaDZdp1EmAjpsov4ZujEvC8jRSw7fzHKqCA3W51ydf7F83DQJ64yM0VCm6CiHJ8LFBLwF0meBbaPdopLUKKFDI3gAQiyZw0ydMU5GcA+ExQ9nlEhYq2yjyCvsNNP0vv1kROa8ELZH7HahposT/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466502; c=relaxed/simple;
	bh=Vdb13DtJiXnZxDAs4aDGQFXm6vfhoua21VF7YNCZ5CI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfw1Ya1PvfZrWG1pa2vm9zcmcIdCXNJRaszMTE4upz/exQywy5X4AB77TlR2mefvEJX9tLUwZRAsv200/siN0ph9K6GDc6/rppDfk8u+eiU3rCFwR8YZgp79/wW+VJ+ByVCSszDgbB9vJHV5fkqa4Vd543FMbtsaT7lej4k1kfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkSD8vcU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742466499; x=1774002499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vdb13DtJiXnZxDAs4aDGQFXm6vfhoua21VF7YNCZ5CI=;
  b=YkSD8vcUcFlFln4lcR47GmsOfI2Ql5fErdAyMmr4RSpI6EbIYmWu/yi1
   nhd1Rn6L/ahNfaHNZXKYsTmf9FN2GedqvKjhHwIaMOYwlBAqTyVZfQ58N
   C56zYe8/jfUmeGppHPIAC8U/FjN/7VjF5Ypg5+u+QML7wntiOObQw+NLo
   AmySEhMh1jGWZ0kgwtGVzNd/1kgBavXGzA6CpTOyT1Qwuac8z/x5xlQRa
   ExKASMvqxlfNpDFYRR/R+1Gwc28DgKWr0ZjO/Le2Z1zuw0m/MQ0CRfed+
   AiLiqDl0OpZ8AiaA9gKMXQNr8nvldnnKg18mCBMRyT8L4j7Z0RKlXKmcr
   w==;
X-CSE-ConnectionGUID: HbhJpT7fTP+yFKCBrOTWhw==
X-CSE-MsgGUID: gyzVUdg/Rw20E/dZijnosA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47465134"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="47465134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:28:18 -0700
X-CSE-ConnectionGUID: Dlzr80dPSyeHdt7kQLuJig==
X-CSE-MsgGUID: fwTtqrPESt+LDjzEQfj5pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="146256653"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 20 Mar 2025 03:28:14 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7E48233E91;
	Thu, 20 Mar 2025 10:28:12 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pierre Riteau <pierre@stackhpc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] xarray: make xa_alloc_cyclic() return 0 on all success cases
Date: Thu, 20 Mar 2025 11:22:19 +0100
Message-Id: <20250320102219.8101-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change xa_alloc_cyclic() to return 0 even on wrap-around.
Do the same for xa_alloc_cyclic_irq() and xa_alloc_cyclic_bh().

This will prevent any future bug of treating return of 1 as an error:
	int ret = xa_alloc_cyclic(...)
	if (ret) // currently mishandles ret==1
		goto failure;

If there will be someone interested in when wrap-around occurs,
there is still __xa_alloc_cyclic() that behaves as before.
For now there is no such user.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/netdev/Z9gUd-5t8b5NX2wE@casper.infradead.org
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Pierre Riteau <pierre@stackhpc.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-fsdevel@vger.kernel.org
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Thanks to Andy and Dave for internal review feedback
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Dave Hansen <dave.hansen@intel.com>
---
 include/linux/xarray.h | 24 +++++++++++++++---------
 lib/test_xarray.c      | 17 +++++++++++++++--
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..46eb751fd5df 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -965,10 +965,12 @@ static inline int __must_check xa_alloc_irq(struct xarray *xa, u32 *id,
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
+ * Note that callers interested in whether wrapping has occurred should
+ * use __xa_alloc_cyclic() instead.
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
- * Return: 0 if the allocation succeeded without wrapping.  1 if the
- * allocation succeeded after wrapping, -ENOMEM if memory could not be
+ * Return: 0 if the allocation succeeded, -ENOMEM if memory could not be
  * allocated or -EBUSY if there are no free entries in @limit.
  */
 static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
@@ -981,7 +983,7 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
 	err = __xa_alloc_cyclic(xa, id, entry, limit, next, gfp);
 	xa_unlock(xa);
 
-	return err;
+	return err < 0 ? err : 0;
 }
 
 /**
@@ -1002,10 +1004,12 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
+ * Note that callers interested in whether wrapping has occurred should
+ * use __xa_alloc_cyclic() instead.
+ *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.  May sleep if the @gfp flags permit.
- * Return: 0 if the allocation succeeded without wrapping.  1 if the
- * allocation succeeded after wrapping, -ENOMEM if memory could not be
+ * Return: 0 if the allocation succeeded, -ENOMEM if memory could not be
  * allocated or -EBUSY if there are no free entries in @limit.
  */
 static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
@@ -1018,7 +1022,7 @@ static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
 	err = __xa_alloc_cyclic(xa, id, entry, limit, next, gfp);
 	xa_unlock_bh(xa);
 
-	return err;
+	return err < 0 ? err : 0;
 }
 
 /**
@@ -1039,10 +1043,12 @@ static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
+ * Note that callers interested in whether wrapping has occurred should
+ * use __xa_alloc_cyclic() instead.
+ *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.  May sleep if the @gfp flags permit.
- * Return: 0 if the allocation succeeded without wrapping.  1 if the
- * allocation succeeded after wrapping, -ENOMEM if memory could not be
+ * Return: 0 if the allocation succeeded, -ENOMEM if memory could not be
  * allocated or -EBUSY if there are no free entries in @limit.
  */
 static inline int xa_alloc_cyclic_irq(struct xarray *xa, u32 *id, void *entry,
@@ -1055,7 +1061,7 @@ static inline int xa_alloc_cyclic_irq(struct xarray *xa, u32 *id, void *entry,
 	err = __xa_alloc_cyclic(xa, id, entry, limit, next, gfp);
 	xa_unlock_irq(xa);
 
-	return err;
+	return err < 0 ? err : 0;
 }
 
 /**
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0e865bab4a10..393ffaaf090c 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1040,6 +1040,7 @@ static noinline void check_xa_alloc_3(struct xarray *xa, unsigned int base)
 	unsigned int i, id;
 	unsigned long index;
 	void *entry;
+	int ret;
 
 	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(1), limit,
 				&next, GFP_KERNEL) != 0);
@@ -1059,7 +1060,7 @@ static noinline void check_xa_alloc_3(struct xarray *xa, unsigned int base)
 		else
 			entry = xa_mk_index(i - 0x3fff);
 		XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, entry, limit,
-					&next, GFP_KERNEL) != (id == 1));
+					&next, GFP_KERNEL) != 0);
 		XA_BUG_ON(xa, xa_mk_index(id) != entry);
 	}
 
@@ -1072,15 +1073,27 @@ static noinline void check_xa_alloc_3(struct xarray *xa, unsigned int base)
 				xa_limit_32b, &next, GFP_KERNEL) != 0);
 	XA_BUG_ON(xa, id != UINT_MAX);
 	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(base),
-				xa_limit_32b, &next, GFP_KERNEL) != 1);
+				xa_limit_32b, &next, GFP_KERNEL) != 0);
 	XA_BUG_ON(xa, id != base);
 	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(base + 1),
 				xa_limit_32b, &next, GFP_KERNEL) != 0);
 	XA_BUG_ON(xa, id != base + 1);
 
 	xa_for_each(xa, index, entry)
 		xa_erase_index(xa, index);
+	XA_BUG_ON(xa, !xa_empty(xa));
 
+	/* check wrap-around return of __xa_alloc_cyclic() */
+	next = UINT_MAX;
+	XA_BUG_ON(xa, xa_alloc_cyclic(xa, &id, xa_mk_index(UINT_MAX),
+				      xa_limit_32b, &next, GFP_KERNEL) != 0);
+	xa_lock(xa);
+	ret = __xa_alloc_cyclic(xa, &id, xa_mk_index(base), xa_limit_32b,
+				&next, GFP_KERNEL);
+	xa_unlock(xa);
+	XA_BUG_ON(xa, ret != 1);
+	xa_for_each(xa, index, entry)
+		xa_erase_index(xa, index);
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
-- 
2.39.3


