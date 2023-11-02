Return-Path: <linux-fsdevel+bounces-1843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C67DF68D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9B3281BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771BA1D523;
	Thu,  2 Nov 2023 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITRkqaup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48811CF94
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 15:35:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C422FB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698939328; x=1730475328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BedVO4IwcrAhnCiX1/s8G5+h6VIpdxQ37+nGVcylPSk=;
  b=ITRkqaupi26qlUx6qsoQP2PhrT2gpbui/lC1Zu1WMWrot4CT/+fHGCBv
   mtwgjdSpVh+hY1zy9P9XCRdfQN/C6NZIp3tcUKETtUBRGIHfpffNE7h2q
   cLav4xzvfN7GERnFdeECDu2XiwQ/SQOjZ05z9/M9yKb4R2AmWrlNDyL5m
   HqreergS2uzDPK7XrN5Np3XbpEaA/Bu7tYyIKolTurxNVWfL4YFRWdbWU
   d3wpsuH6nVz672+5yVNcKKwC44AgllBBJTPB2QQ9VMcCPWYUKPSNki7mu
   pVfqp5kFJ2n1laynXGnNusRmjKe1/Fx72tPjjB0ObKswUDBcV1NOSd6Va
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419848037"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="419848037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="9042486"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.131.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:35:27 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-fsdevel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/3] ida: Introduce ida_alloc_group_range()
Date: Thu,  2 Nov 2023 16:34:54 +0100
Message-Id: <20231102153455.1252-3-michal.wajdeczko@intel.com>
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

Some drivers may require allocations of contiguous ranges of IDs,
while current IDA implementation allows only single ID allocation.

Extend implementation of ida_alloc_range() to allow allocation of
arbitrary number of contiguous IDs.  Allocated IDs can be released
individually with old ida_free() or can be released at once using
new ida_free_group() function.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/idr.h |   3 +
 lib/idr.c           | 215 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 172 insertions(+), 46 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index f477e35c9619..ecc403543d6a 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -253,7 +253,10 @@ struct ida {
 #define DEFINE_IDA(name)	struct ida name = IDA_INIT(name)
 
 int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
+int ida_alloc_group_range(struct ida *ida, unsigned int min, unsigned int max,
+			  unsigned int group, gfp_t gfp);
 void ida_free(struct ida *, unsigned int id);
+void ida_free_group(struct ida *ida, unsigned int id, unsigned int group);
 void ida_destroy(struct ida *ida);
 unsigned long ida_weight(struct ida *ida);
 
diff --git a/lib/idr.c b/lib/idr.c
index ed987a0fc25a..68ec837b67bc 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -362,34 +362,41 @@ EXPORT_SYMBOL(idr_replace);
  * bitmap, which is excessive.
  */
 
+static void __ida_free_group(struct ida *ida, unsigned int id, unsigned int group);
+
 /**
- * ida_alloc_range() - Allocate an unused ID.
+ * ida_alloc_group_range() - Allocate contiguous group of an unused IDs.
  * @ida: IDA handle.
  * @min: Lowest ID to allocate.
  * @max: Highest ID to allocate.
+ * @group: Number of extra IDs to allocate.
  * @gfp: Memory allocation flags.
  *
- * Allocate an ID between @min and @max, inclusive.  The allocated ID will
- * not exceed %INT_MAX, even if @max is larger.
+ * Allocate contiguous set of (1 + @group) IDs between @min and @max, inclusive.
+ * The allocated IDs will not exceed %INT_MAX, even if @max is larger.
  *
  * Context: Any context. It is safe to call this function without
  * locking in your code.
- * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
- * or %-ENOSPC if there are no free IDs.
+ * Return: The first allocated ID, or %-ENOMEM if memory could not be allocated,
+ * or %-ENOSPC if there are no free contiguous range of IDs.
  */
-int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
-			gfp_t gfp)
+int ida_alloc_group_range(struct ida *ida, unsigned int min, unsigned int max,
+			  unsigned int group, gfp_t gfp)
 {
 	XA_STATE(xas, &ida->xa, min / IDA_BITMAP_BITS);
 	unsigned bit = min % IDA_BITMAP_BITS;
 	unsigned long flags;
 	struct ida_bitmap *bitmap, *alloc = NULL;
+	unsigned int start, end, chunk, nbit;
+	unsigned int more = group;
 
 	if ((int)min < 0)
 		return -ENOSPC;
 
 	if ((int)max < 0)
 		max = INT_MAX;
+	end = max;
+	start = end + 1;
 
 retry:
 	xas_lock_irqsave(&xas, flags);
@@ -397,18 +404,21 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 	bitmap = xas_find_marked(&xas, max / IDA_BITMAP_BITS, XA_FREE_MARK);
 	if (xas.xa_index > min / IDA_BITMAP_BITS)
 		bit = 0;
-	if (xas.xa_index * IDA_BITMAP_BITS + bit > max)
+	if (xas.xa_index * IDA_BITMAP_BITS + bit + more > max)
 		goto nospc;
 
 	if (xa_is_value(bitmap)) {
 		unsigned long tmp = xa_to_value(bitmap);
 
-		if (bit < BITS_PER_XA_VALUE) {
+		if (bit + more < BITS_PER_XA_VALUE) {
 			bit = find_next_zero_bit(&tmp, BITS_PER_XA_VALUE, bit);
-			if (xas.xa_index * IDA_BITMAP_BITS + bit > max)
+			if (xas.xa_index * IDA_BITMAP_BITS + bit + more > max)
 				goto nospc;
-			if (bit < BITS_PER_XA_VALUE) {
-				tmp |= 1UL << bit;
+			if (more == group)
+				start = xas.xa_index * IDA_BITMAP_BITS + bit;
+			if (bit + more < BITS_PER_XA_VALUE &&
+			    bit + more < find_next_bit(&tmp, bit + more + 1, bit)) {
+				tmp |= GENMASK(bit + more, bit);
 				xas_store(&xas, xa_mk_value(tmp));
 				goto out;
 			}
@@ -424,27 +434,41 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 			bitmap->bitmap[0] = 0;
 			goto out;
 		}
+		alloc = NULL;
 	}
 
 	if (bitmap) {
 		bit = find_next_zero_bit(bitmap->bitmap, IDA_BITMAP_BITS, bit);
-		if (xas.xa_index * IDA_BITMAP_BITS + bit > max)
+		if (xas.xa_index * IDA_BITMAP_BITS + bit + more > max)
 			goto nospc;
 		if (bit == IDA_BITMAP_BITS)
 			goto next;
-
+		if (more == group)
+			start = xas.xa_index * IDA_BITMAP_BITS + bit;
+		if (more)
+			goto more;
 		__set_bit(bit, bitmap->bitmap);
 		if (bitmap_full(bitmap->bitmap, IDA_BITMAP_BITS))
 			xas_clear_mark(&xas, XA_FREE_MARK);
 	} else {
-		if (bit < BITS_PER_XA_VALUE) {
-			bitmap = xa_mk_value(1UL << bit);
+		if (more == group)
+			start = xas.xa_index * IDA_BITMAP_BITS + bit;
+
+		if (bit + more < BITS_PER_XA_VALUE) {
+			bitmap = xa_mk_value(GENMASK(bit + more, bit));
 		} else {
 			bitmap = alloc;
 			if (!bitmap)
 				bitmap = kzalloc(sizeof(*bitmap), GFP_NOWAIT);
 			if (!bitmap)
 				goto alloc;
+			if (more) {
+				xas_store(&xas, bitmap);
+				if (xas_error(&xas))
+					goto out;
+				alloc = NULL;
+				goto more;
+			}
 			__set_bit(bit, bitmap->bitmap);
 		}
 		xas_store(&xas, bitmap);
@@ -460,7 +484,7 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 		kfree(alloc);
 	if (xas_error(&xas))
 		return xas_error(&xas);
-	return xas.xa_index * IDA_BITMAP_BITS + bit;
+	return WARN_ON_ONCE(start > end) ? -ENOSPC : start;
 alloc:
 	xas_unlock_irqrestore(&xas, flags);
 	alloc = kzalloc(sizeof(*bitmap), gfp);
@@ -469,60 +493,159 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 	xas_set(&xas, min / IDA_BITMAP_BITS);
 	bit = min % IDA_BITMAP_BITS;
 	goto retry;
+restart:
+	max = end;
+	more = group;
+	start = end + 1;
+	goto next;
+more:
+	chunk = bit + more < IDA_BITMAP_BITS ?
+		1 + more : IDA_BITMAP_BITS - bit;
+	nbit = find_next_bit(bitmap->bitmap, bit + chunk, bit);
+	if (nbit < bit + chunk) {
+		min = xas.xa_index * IDA_BITMAP_BITS + nbit + 1;
+		bit = min % IDA_BITMAP_BITS;
+		xas_set(&xas, min / IDA_BITMAP_BITS);
+		if (group == more)
+			goto restart;
+		goto nospc;
+	}
+	bitmap_set(bitmap->bitmap, bit, chunk);
+	if (bitmap_full(bitmap->bitmap, IDA_BITMAP_BITS))
+		xas_clear_mark(&xas, XA_FREE_MARK);
+	if (chunk < 1 + more) {
+		more -= chunk;
+		min = (xas.xa_index + 1) * IDA_BITMAP_BITS;
+		max = min + more;
+		xas_set(&xas, min / IDA_BITMAP_BITS);
+		bit = 0;
+		goto next;
+	}
+	goto out;
 nospc:
+	if (more != group) {
+		__ida_free_group(ida, start, group - more - 1);
+		xas_reset(&xas);
+		goto restart;
+	}
 	xas_unlock_irqrestore(&xas, flags);
 	kfree(alloc);
 	return -ENOSPC;
 }
+EXPORT_SYMBOL(ida_alloc_group_range);
+
+/**
+ * ida_alloc_range() - Allocate an unused ID.
+ * @ida: IDA handle.
+ * @min: Lowest ID to allocate.
+ * @max: Highest ID to allocate.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocate an ID between @min and @max, inclusive.  The allocated ID will
+ * not exceed %INT_MAX, even if @max is larger.
+ *
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
+ * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
+ * or %-ENOSPC if there are no free IDs.
+ */
+int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
+		    gfp_t gfp)
+{
+	return ida_alloc_group_range(ida, min, max, 0, gfp);
+}
 EXPORT_SYMBOL(ida_alloc_range);
 
-/**
- * ida_free() - Release an allocated ID.
- * @ida: IDA handle.
- * @id: Previously allocated ID.
- *
- * Context: Any context. It is safe to call this function without
- * locking in your code.
- */
-void ida_free(struct ida *ida, unsigned int id)
+static void __ida_free_group(struct ida *ida, unsigned int id, unsigned int group)
 {
 	XA_STATE(xas, &ida->xa, id / IDA_BITMAP_BITS);
 	unsigned bit = id % IDA_BITMAP_BITS;
+	unsigned int chunk, more = group;
 	struct ida_bitmap *bitmap;
-	unsigned long flags;
+	bool set = true;
 
 	if ((int)id < 0)
 		return;
 
-	xas_lock_irqsave(&xas, flags);
+next:
 	bitmap = xas_load(&xas);
 
+	chunk = bit + more < IDA_BITMAP_BITS ?
+		1 + more : IDA_BITMAP_BITS - bit;
+
 	if (xa_is_value(bitmap)) {
 		unsigned long v = xa_to_value(bitmap);
-		if (bit >= BITS_PER_XA_VALUE)
-			goto err;
-		if (!(v & (1UL << bit)))
-			goto err;
-		v &= ~(1UL << bit);
-		if (!v)
-			goto delete;
-		xas_store(&xas, xa_mk_value(v));
-	} else {
-		if (!test_bit(bit, bitmap->bitmap))
-			goto err;
-		__clear_bit(bit, bitmap->bitmap);
+		unsigned long m;
+
+		if (bit + more >= BITS_PER_XA_VALUE) {
+			m = GENMASK(BITS_PER_XA_VALUE - 1, bit);
+			set = false;
+		} else {
+			m = GENMASK(bit + more, bit);
+			set = set && !((v & m) ^ m);
+		}
+		v &= ~m;
+		xas_store(&xas, v ? xa_mk_value(v) : NULL);
+	} else if (bitmap) {
+		unsigned int nbit;
+
+		nbit = find_next_zero_bit(bitmap->bitmap, bit + chunk, bit);
+		if (nbit < bit + chunk)
+			set = false;
+		bitmap_clear(bitmap->bitmap, bit, chunk);
 		xas_set_mark(&xas, XA_FREE_MARK);
 		if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
 			kfree(bitmap);
-delete:
 			xas_store(&xas, NULL);
 		}
+	} else {
+		set = false;
 	}
-	xas_unlock_irqrestore(&xas, flags);
-	return;
- err:
-	xas_unlock_irqrestore(&xas, flags);
-	WARN(1, "ida_free called for id=%d which is not allocated.\n", id);
+
+	if (chunk < 1 + more) {
+		more -= chunk;
+		xas_set(&xas, xas.xa_index + 1);
+		bit = 0;
+		goto next;
+	}
+
+	WARN(!set, "IDA: trying to free non contiguous IDs %u..%u!\n", id, id + group);
+}
+
+/**
+ * ida_free_group() - Release contiguous group of an allocated IDs.
+ * @ida: IDA handle.
+ * @id: First ID of the group.
+ * @group: Number of extra IDs in group.
+ *
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
+ */
+void ida_free_group(struct ida *ida, unsigned int id, unsigned int group)
+{
+	unsigned long flags;
+
+	xa_lock_irqsave(&ida->xa, flags);
+	__ida_free_group(ida, id, group);
+	xa_unlock_irqrestore(&ida->xa, flags);
+}
+EXPORT_SYMBOL(ida_free_group);
+
+/**
+ * ida_free() - Release an allocated ID.
+ * @ida: IDA handle.
+ * @id: Previously allocated ID.
+ *
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
+ */
+void ida_free(struct ida *ida, unsigned int id)
+{
+	unsigned long flags;
+
+	xa_lock_irqsave(&ida->xa, flags);
+	__ida_free_group(ida, id, 0);
+	xa_unlock_irqrestore(&ida->xa, flags);
 }
 EXPORT_SYMBOL(ida_free);
 
-- 
2.25.1


