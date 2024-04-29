Return-Path: <linux-fsdevel+bounces-18178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD58B61C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EBC1C217A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDB13AD2F;
	Mon, 29 Apr 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNEPks4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31113BC1C;
	Mon, 29 Apr 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418007; cv=none; b=YyPF+iqmFhUTbnN33AHLSXqi2jXd9WyvI7z2RXaDVdhKFgQt1O+dfd9OMXtm8W1psOS1cljzsw/k7Xl5vyDo2bkpaXlpSzH0b8WdRczlwHTfHI77jgip8tDlGabRDYKXvCepP2DwVp7RcT9ZRCBD+twqoKEMiz8RIDBvFfCCj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418007; c=relaxed/simple;
	bh=8EWzx+HGEvik1D+rKiMHX/VU9FNdzjA89r3P4lo5qBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0ARk4izV6mI+VSgWt1T7D+sEViI7ab8FdNPeR4aIyAEEzeaxwAJfQ4eosHy758CXF9N7w02FPCNGdaYcvxA+jFRkrpaP0jELJX1qLCp37lgz7O4LRIoqPygpc8Mf88fnB6hbD3ldNihyphrAcf6FNB/htkFLHr8KD+l80uoAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNEPks4p; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so4383696b3a.0;
        Mon, 29 Apr 2024 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714418005; x=1715022805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8QazdPBRgLGfXIr1HFTGvtxzzbA+7izgwNyqAiebQ+Y=;
        b=gNEPks4pvcEHemW+4klDqGfe6zwZZMt/+vPcXl1kghgck/W5mlgnNBQtbMdw51Cw0N
         7A3OhHOjOuOe26b9ZvWG9C9yKWyAVA5/Ug7aXWcYmBqFIENa6MWIHrL+srx03SFuT08E
         CtC0Wfm3UReGXuIGB720SbPtS7Bu9ghQfpDCWrx8wut1t0AW+uRTTKAyZKXbI8KkpOtX
         xY7tqkTRlpo06lPLc5/7qroc0kFTA58Kn/z1VwMaW9lqsLl2HC6sW+KjPwEPn7yrEu6L
         QFSJD33n7WGH4jVy7NBGsnFa8rVe9cS3I2bSYC3TzqzpKuV2LM+62h6Ufijfri9i3WPZ
         lpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714418005; x=1715022805;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QazdPBRgLGfXIr1HFTGvtxzzbA+7izgwNyqAiebQ+Y=;
        b=UxNHZ1md9Q56bWMtl+5aZ/vTFRIotLibFaj4cLqc8NxVEXSnp0gxj59ti0bCodhjM0
         DDMjmUvCaTh9ZikCKYTM8ZGFjR87vZkuf5e1VSNcZ0SXRYlZMS3oqQEwPiAlnfXZ5LxE
         ATHPLFLGBe7QCrQtE16hqzG7OgM5Eqw7pfqpMJrhMXeZ705YpCQhFW3MP9nzGu/T5fhQ
         JyH6X1LusLRWRrQVr6StYpzEhaA9dV+r8bkn3qqL8e0xE+WMp6Pz3fpoSk6X/bjB+RK4
         FrIzNygvoyXunzfzzJQ7oZw8xYzEOYQibfH2iVWJjLr8nWDTN5YiXSQlBqqcd1w4eoXL
         gcTA==
X-Forwarded-Encrypted: i=1; AJvYcCX11DOofUhHr8XaOBJOAGT8eDsLkIDf6iHMr60KnOlutKFIpXB7K8r1EpfrriepUCioYpTK2IZf15mWTYTzFDOO6iNti2z8VuHA+X6o2RbR5Ki4fn7HAqZxalD3pFO2H2K3jhVMo/0ZWuekOw==
X-Gm-Message-State: AOJu0YyfIhNII1wn1fmLKKkufrjRWPxf9B8F3TsOpiHWhKpaOFNvF2wd
	0xIdVfg3NK1lokVoatYtmupwZCxINiPplz3t/Mb786l2ei/NWvQP
X-Google-Smtp-Source: AGHT+IFPOFbp9pmt2653zFt0UEbOTrCGtp/cEwxyT9UheEYNDjImTX/zaDPWA1WmxxbAEpNdjTgHPw==
X-Received: by 2002:a05:6a00:21cc:b0:6e8:3d5b:f3b1 with SMTP id t12-20020a056a0021cc00b006e83d5bf3b1mr11062453pfj.22.1714418005131;
        Mon, 29 Apr 2024 12:13:25 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006ed38291aebsm20307988pfl.178.2024.04.29.12.13.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:13:24 -0700 (PDT)
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
Subject: [PATCH v3 11/12] mm: drop page_index and convert folio_index to use folio
Date: Tue, 30 Apr 2024 03:11:37 +0800
Message-ID: <20240429191138.34123-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are two helpers for retrieving the index within address space
for mixed usage of swap cache and page cache:

- page_index
- folio_index (wrapper of page_index)

This commit drops page_index, as we have eliminated all users, and
converts folio_index to use folio internally.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h      | 13 -------------
 include/linux/pagemap.h |  8 ++++----
 mm/swapfile.c           |  7 +++----
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..e2718cac0fda 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2290,19 +2290,6 @@ static inline void *folio_address(const struct folio *folio)
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
index 91474dcc6cce..47171bf20b53 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -777,7 +777,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
-#define swapcache_index(folio)	__page_file_index(&(folio)->page)
+extern pgoff_t __folio_swap_cache_index(struct folio *folio);
 
 /**
  * folio_index - File index of a folio.
@@ -792,9 +792,9 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
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
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 96606580ee09..6f028262898b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3474,12 +3474,11 @@ struct address_space *swapcache_mapping(struct folio *folio)
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
 
 /*
  * add_swap_count_continuation - called when a swap count is duplicated
-- 
2.44.0


