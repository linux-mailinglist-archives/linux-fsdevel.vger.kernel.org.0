Return-Path: <linux-fsdevel+bounces-68427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF21C5BDC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04294350CD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E282F6578;
	Fri, 14 Nov 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw2a4slP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FD242D7B
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107036; cv=none; b=LHRC53HfDyRi1VqqFLhF7UiPFtdbp0/hZW2J5vW46/0zfRxqALKPPiGZ4Z+i+EF8A5YkFQePVcy2Zn1ahR37JpDNQJLKvEW34Z/1W3XS/IC/ki09WbCsIhDPjcvPh5Wgu/EOh9UkgHqO+5fgWShBZSv/5/ZT8caIjRNKQdIbNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107036; c=relaxed/simple;
	bh=FTWsBwk00zhtlx3ctc0oK4Y94Vh2NMH6iGOuExuyhxQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Llt3s4FkQ8w3h/vVxLU0ozpDakwGZ9z6Hfx9YZZL0ewsY8AlRqQtKCxzecKRPFcDhbUvdHK3rFIGgtMIfW9WrWuRYdIk853WP1zLoaeVtrW6IO4KuqerL4Fjf0dNUpFsBj2ClbWCc6hd1R8Xt0l+tC/IF/RLvmMuxO0ScKV+yQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw2a4slP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b736ffc531fso32559966b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 23:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763107032; x=1763711832; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIvA6yLPnKeWMVPtO7BOt8TNUDdATgcSH5aI0bTFcO0=;
        b=aw2a4slPL3s49UjnmlF7C1WobdIH+NXJCw/CyAP/iO/Zv9raErcswprG1Lq0kQNfRG
         S3PHhUzlSFdu64wNbTTW4IjcFBh0liMZFDJW9KKa/9ooHcv3tBSNyp5L6LMiOv/J/X9r
         tQBNyIx8RyOKPM2CAQqUwmKa3gjh8Hv754+U8v+Hx/5tGuJXLSXNsbRw6ZbvBm199y0+
         +WGVQjUTKctn8xa1jfL9J4v+uf5MhtXd/pYGJUAUAzxWCQXpZZvJ9T9syVXpYbD4hi/c
         8pLqLYqwmBvQY+NnmPeoY5+LZTa0+4F8pJoOibTTQwPdDilwRfGP3jEG/j0XWxIlsakm
         k4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763107032; x=1763711832;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIvA6yLPnKeWMVPtO7BOt8TNUDdATgcSH5aI0bTFcO0=;
        b=dHedZqGd3qHeehZcryNp/at8BmVJaNiTh+2Rxw+zKZTkmtUzD0Ssyqv+z6D2EZT72d
         Oh311j8rYXAThD0u1E0BbE9fjbUlMFhqIzkOaq20nf8oJ9L1sjrg7mUGBff4wbK3DEJk
         RcXfSzZ4omLerCaSMZZsilYvWTcnHIapsoiSGE9F7WiJchg7nSf9ws67kQ4AamNu8zHi
         p7NVdv6/fYhMsnmJhLZddYC4tLAo/xwKxvvxzZVdCV8xj6q1ad0Ok9jNPqfjqnuBd2ug
         wvzFZ6MkQjgpo7lsmbNI1P8EJKjs/Uz7ouFWi9WjPopjQIQbjsNvQ7YnBwvT7OdRGi3t
         mPMg==
X-Gm-Message-State: AOJu0YxRPR8pdlX0le38MIU8/zkDELdm6qk0TISgsl85WUeqcJoN85sm
	L/4mB1tFLXd06b6RPhTPl1hkcBTu/bVm2dBf4RFVMDd0Vlsx/+1sA10M
X-Gm-Gg: ASbGncuF/eBSwhCZLMNfs+J7GuWgGH+Tny/sNj4nyCU3e0sukvl0NkjLfsHgvWNxU3T
	RVt2neBwbXKWjWjgYf07o+fRGtgNqhSF0TEL8mNyL7ykJXEprUzypYLVfIbe0Y8pmrTxSqf0FEA
	rbHtlihtGtjmTMOMDu5u2qPbRq96lBD78okc8pq6XkSgHZGt1fF26gnzy2Hms44b/Uv9RX7iX5L
	xizjG7Y+o/KtToF7LLXvhmjeDOQgCD9kGNE/9MT4e4P9UT6TCZIRRzqakMakv29aS9oZnqJDjso
	r6ifUfqnXFMme6E7BgicGTUEJiS/NdG8gdbF9XK0OZDIx9M8CN0K/CwVWD9DhWAG4VHdccwQFIH
	lws55fpJDab5ERa1LxiY69nbirOt7hbqGirYZb7TCcPKU8AYuxkNtZ6OCiSp1bYk3LKPOW+0u25
	KpYsCcSNcImuhyptxXZLYIXxvG
X-Google-Smtp-Source: AGHT+IE0vQE/VL4qK0iqmlw9B7Sjp4IFmBy++J8hyg4y18WBO4JJirL38dV5FBI1kNbDqbxwV7fIpg==
X-Received: by 2002:a17:907:6d22:b0:b04:32ff:5d3a with SMTP id a640c23a62f3a-b73674d2391mr193760566b.0.1763107032366;
        Thu, 13 Nov 2025 23:57:12 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa80afbsm328466866b.11.2025.11.13.23.57.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Nov 2025 23:57:11 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm/huge_memory: consolidate order-related checks into folio_split_supported()
Date: Fri, 14 Nov 2025 07:57:03 +0000
Message-Id: <20251114075703.10434-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The primary goal of the folio_split_supported() function is to validate
whether a folio is suitable for splitting and to bail out early if it is
not.

Currently, some order-related checks are scattered throughout the
calling code rather than being centralized in folio_split_supported().

This commit moves all remaining order-related validation logic into
folio_split_supported(). This consolidation ensures that the function
serves its intended purpose as a single point of failure and improves
the clarity and maintainability of the surrounding code.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/pagemap.h |  6 +++
 mm/huge_memory.c        | 88 +++++++++++++++++++++--------------------
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..d8c8df629b90 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -516,6 +516,12 @@ static inline bool mapping_large_folio_support(const struct address_space *mappi
 	return mapping_max_folio_order(mapping) > 0;
 }
 
+static inline bool
+mapping_folio_order_supported(const struct address_space *mapping, unsigned int order)
+{
+	return (order >= mapping_min_folio_order(mapping) && order <= mapping_max_folio_order(mapping));
+}
+
 /* Return the maximum folio size for this pagecache mapping, in bytes. */
 static inline size_t mapping_max_folio_size(const struct address_space *mapping)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0184cd915f44..68faac843527 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3690,34 +3690,58 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 bool folio_split_supported(struct folio *folio, unsigned int new_order,
 		enum split_type split_type, bool warns)
 {
+	const int old_order = folio_order(folio);
+
+	if (new_order >= old_order)
+		return -EINVAL;
+
 	if (folio_test_anon(folio)) {
 		/* order-1 is not supported for anonymous THP. */
 		VM_WARN_ONCE(warns && new_order == 1,
 				"Cannot split to order-1 folio");
 		if (new_order == 1)
 			return false;
-	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-		    !mapping_large_folio_support(folio->mapping)) {
-			/*
-			 * We can always split a folio down to a single page
-			 * (new_order == 0) uniformly.
-			 *
-			 * For any other scenario
-			 *   a) uniform split targeting a large folio
-			 *      (new_order > 0)
-			 *   b) any non-uniform split
-			 * we must confirm that the file system supports large
-			 * folios.
-			 *
-			 * Note that we might still have THPs in such
-			 * mappings, which is created from khugepaged when
-			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
-			 * case, the mapping does not actually support large
-			 * folios properly.
-			 */
+	} else {
+		const struct address_space *mapping = NULL;
+
+		mapping = folio->mapping;
+
+		/* Truncated ? */
+		/*
+		 * TODO: add support for large shmem folio in swap cache.
+		 * When shmem is in swap cache, mapping is NULL and
+		 * folio_test_swapcache() is true.
+		 */
+		if (!mapping)
+			return false;
+
+		/*
+		 * We have two types of split:
+		 *
+		 *   a) uniform split: split folio directly to new_order.
+		 *   b) non-uniform split: create after-split folios with
+		 *      orders from (old_order - 1) to new_order.
+		 *
+		 * For file system, we encodes it supported folio order in
+		 * mapping->flags, which could be checked by
+		 * mapping_folio_order_supported().
+		 *
+		 * With these knowledge, we can know whether folio support
+		 * split to new_order by:
+		 *
+		 *   1. check new_order is supported first
+		 *   2. check (old_order - 1) is supported if
+		 *      SPLIT_TYPE_NON_UNIFORM
+		 */
+		if (!mapping_folio_order_supported(mapping, new_order)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split file folio to unsupported order: %d", new_order);
+			return false;
+		}
+		if (split_type == SPLIT_TYPE_NON_UNIFORM
+		    && !mapping_folio_order_supported(mapping, old_order - 1)) {
 			VM_WARN_ONCE(warns,
-				"Cannot split file folio to non-0 order");
+				"Cannot split file folio to unsupported order: %d", old_order - 1);
 			return false;
 		}
 	}
@@ -3785,9 +3809,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
 		return -EINVAL;
 
-	if (new_order >= old_order)
-		return -EINVAL;
-
 	if (!folio_split_supported(folio, new_order, split_type, /* warn = */ true))
 		return -EINVAL;
 
@@ -3819,28 +3840,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		}
 		mapping = NULL;
 	} else {
-		unsigned int min_order;
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-
-		/* Truncated ? */
-		/*
-		 * TODO: add support for large shmem folio in swap cache.
-		 * When shmem is in swap cache, mapping is NULL and
-		 * folio_test_swapcache() is true.
-		 */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
-		min_order = mapping_min_folio_order(folio->mapping);
-		if (new_order < min_order) {
-			ret = -EINVAL;
-			goto out;
-		}
-
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
-- 
2.34.1


