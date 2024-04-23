Return-Path: <linux-fsdevel+bounces-17534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03CA8AF4F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17FD286AEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6111422A9;
	Tue, 23 Apr 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+e7/y35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091B1420D3;
	Tue, 23 Apr 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891864; cv=none; b=PzgYYLt7UVjvOQMYWsbse2QttJ7OvAYfDybwFea3OCrHyRkKlrfB+psE7l2ogoeMccJ3d3rlhi+Jipjl1FtEsHpRROuLev9O5wF8AH7n+/dKXRWOKgkxJmlmvy9m458bIOXsiQf6/enOPVgW6JS2CQskQQBgBLzAkTb2lHke2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891864; c=relaxed/simple;
	bh=vrFjOYePpawjbVdhBsK92t7A0slbtAyHi4xRIBD0oEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FreH0FxHvD6xIezcNNe0n782t0Gpi7k8VKz8nDnnI4cSQWzQ4A38fb1ZXR9IA8F7PmcYIfDJzKXQQUjKYGZfXsSUfM5VPjSi0KEbVYz4Oj2pck7Yxw7mBGBuvtrHHr0D4o+AWKXElnfmDaww3xPCW+1Rp/W2Qe+8xDhBf0AT8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+e7/y35; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c66b093b86so58577a12.0;
        Tue, 23 Apr 2024 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891862; x=1714496662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QrfJLtSyOHzdWNwAoeEt63qAvh/YvWPDSOmG3agvpH8=;
        b=T+e7/y356dJqp04AZTthvSTbcWdig5+ObIy/qPIZuxMGI4kvTksUULgtACoOEmm7nN
         trAEm0gmlPeylXYuGrCVFUKsxU07OCReZEKb668Y8ji3tc4mcWV3LMLwAcjOUNc8VXgc
         LXsn7zLpLORwZRJ8b78d550VkPjw4tdxuoyEolTdo/fkyVc3Kcei6qaZiitj3Qx3Q9z5
         drwbuTg4xFAh4biYjf2/8jr3EGyssWpMjeeh2oBCN2oG07kqBU4+/3dVb8xmS/Ez4veq
         7bEeKKmzudA3Di0SvPoso+S1YMBjN32xchbadOxtaqAKCcQur/h6DL1yVDVKFJ3dkVzo
         hbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891862; x=1714496662;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrfJLtSyOHzdWNwAoeEt63qAvh/YvWPDSOmG3agvpH8=;
        b=O9aKk+u1NtOspRqso9qzOcQF5ukhL0VKd2SHnAF7ymJQjf9JRYd8VDes0tyjGzdjND
         z6HOsnlUJRcBSqhEEKkcKnRd6mUvrZP83UlafYlfw1dIbivArWsVIheRkpufDzN3dpKy
         OwkIyE9OWaTQ9+X9P+lZnk/cfzYUCCWcvsGg1h07SWEp9KC1At437xjMHaRH8j8ooPG5
         a4cK8aV9l9IomnVhOSYMWF8eUvcFFT0dMzo/YgEEJ+JTZCuuCiRDcnLh6f8ZZIpt8bzV
         uFuSho+H6bi2JJFi43EWDY0Bt7WObMKNHvowDzP+dMl1YGb03C2R+DcXf76j80JinQEk
         cMWw==
X-Forwarded-Encrypted: i=1; AJvYcCWd8lSetGTNPNfx8XneCO5RdpxjiJAUaEXEHmeyVEzYSIlc+MTeiCW2l8E+4nAGlFkIBWFXXTtQafHSqsLyb+ZNWAxK5NC5hM8YiOX50UBY9gZiL75YryuxT7qunVNA6AIlLWeKS5ZDsRLJew==
X-Gm-Message-State: AOJu0YzC89kJTdxT3lxDu56YryYF4RfzGnMbhQ7B15URyhQlEu4w2LDX
	bf2F47AGyZqvRo0D6xY7Uj/ms0dEUOE/H1Fx66OttTkHzpww6gh3
X-Google-Smtp-Source: AGHT+IHl29mA2dJ+DAVqdOiUnUGnuaMZJ8DMUB92M2KECrfDvhzldwg40C7x44GzkGKAl0R+XjVRbg==
X-Received: by 2002:a17:90a:f40f:b0:2a5:506f:161c with SMTP id ch15-20020a17090af40f00b002a5506f161cmr104445pjb.4.1713891862010;
        Tue, 23 Apr 2024 10:04:22 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.04.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:04:21 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 7/8] mm: drop page_index/page_file_offset and convert swap helpers to use folio
Date: Wed, 24 Apr 2024 01:03:38 +0800
Message-ID: <20240423170339.54131-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423170339.54131-1-ryncsn@gmail.com>
References: <20240423170339.54131-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are four helpers for retrieving the page index within address
space, or offset within mapped file:

- page_index
- page_file_offset
- folio_index (equivalence of page_index)
- folio_file_pos (equivalence of page_file_offset)

And they are only needed for mixed usage of swap cache & page cache (eg.
migration, huge memory split). Else users can just use folio->index or
folio_pos.

This commit drops page_index and page_file_offset as we have eliminated
all users, and converts folio_index and folio_file_pos (they were simply
wrappers of page_index and page_file_offset, and implemented in a not
very clean way) to use folio internally.

After this commit, there will be only two helpers for users that may
encounter mixed usage of swap cache and page cache:

- folio_index (calls __folio_swap_cache_index for swap cache folio)
- folio_file_pos (calls __folio_swap_dev_pos for swap cache folio)

The index in swap cache and offset in swap device are still basically
the same thing, but will be different in following commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h      | 13 -------------
 include/linux/pagemap.h | 19 +++++++++----------
 mm/swapfile.c           | 13 +++++++++----
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..797480e76c9c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2245,19 +2245,6 @@ static inline void *folio_address(const struct folio *folio)
 	return page_address(&folio->page);
 }
 
-extern pgoff_t __page_file_index(struct page *page);
-
-/*
- * Return the pagecache index of the passed page.  Regular pagecache pages
- * use ->index whereas swapcache pages use swp_offset(->private)
- */
-static inline pgoff_t page_index(struct page *page)
-{
-	if (unlikely(PageSwapCache(page)))
-		return __page_file_index(page);
-	return page->index;
-}
-
 /*
  * Return true only if the page has been allocated with
  * ALLOC_NO_WATERMARKS and the low watermark was not
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..a7d025571ee6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -780,7 +780,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
-#define swapcache_index(folio)	__page_file_index(&(folio)->page)
+extern pgoff_t __folio_swap_cache_index(struct folio *folio);
 
 /**
  * folio_index - File index of a folio.
@@ -795,9 +795,9 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
  */
 static inline pgoff_t folio_index(struct folio *folio)
 {
-        if (unlikely(folio_test_swapcache(folio)))
-                return swapcache_index(folio);
-        return folio->index;
+	if (unlikely(folio_test_swapcache(folio)))
+		return __folio_swap_cache_index(folio);
+	return folio->index;
 }
 
 /**
@@ -920,11 +920,6 @@ static inline loff_t page_offset(struct page *page)
 	return ((loff_t)page->index) << PAGE_SHIFT;
 }
 
-static inline loff_t page_file_offset(struct page *page)
-{
-	return ((loff_t)page_index(page)) << PAGE_SHIFT;
-}
-
 /**
  * folio_pos - Returns the byte position of this folio in its file.
  * @folio: The folio.
@@ -934,6 +929,8 @@ static inline loff_t folio_pos(struct folio *folio)
 	return page_offset(&folio->page);
 }
 
+extern loff_t __folio_swap_dev_pos(struct folio *folio);
+
 /**
  * folio_file_pos - Returns the byte position of this folio in its file.
  * @folio: The folio.
@@ -943,7 +940,9 @@ static inline loff_t folio_pos(struct folio *folio)
  */
 static inline loff_t folio_file_pos(struct folio *folio)
 {
-	return page_file_offset(&folio->page);
+	if (unlikely(folio_test_swapcache(folio)))
+		return __folio_swap_dev_pos(folio);
+	return ((loff_t)folio->index << PAGE_SHIFT);
 }
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..2387f5e131d7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3419,12 +3419,17 @@ struct address_space *swapcache_mapping(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(swapcache_mapping);
 
-pgoff_t __page_file_index(struct page *page)
+pgoff_t __folio_swap_cache_index(struct folio *folio)
 {
-	swp_entry_t swap = page_swap_entry(page);
-	return swp_offset(swap);
+	return swp_offset(folio->swap);
 }
-EXPORT_SYMBOL_GPL(__page_file_index);
+EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
+
+loff_t __folio_swap_dev_pos(struct folio *folio)
+{
+	return swap_dev_pos(folio->swap);
+}
+EXPORT_SYMBOL_GPL(__folio_swap_dev_pos);
 
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
-- 
2.44.0


