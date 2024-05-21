Return-Path: <linux-fsdevel+bounces-19930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B66488CB342
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3191D1F225F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054314A622;
	Tue, 21 May 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtG25+cu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416B14A60D;
	Tue, 21 May 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314389; cv=none; b=pK+G8OxPngUdpSQB0gOmUfUI9ozxgb99Bzq6cXzEkpHaV0GVUFWus0UfpjiQl090G6VTW+NjMDxiRyZOIuxUwo7+tODdBBpuDhY/7IPeD57y2v6embGRdrk4JCikMuYg9z8JY9naVFBd/2Qx0VJu9KHf4xSBmjlxhDZyzjmbPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314389; c=relaxed/simple;
	bh=VD8sZfJ72lfQgdHFrG3SRqwVHzGV6YcqHHzkbEi6vO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFnH5+nl7lLozMHoyILc8MFIphUwv07PUrPchG1UOB+JDi48IPMLq5RNM0qRNAtszlEJ6iGhQRDI3XdfdgRFvT4kZ24zlX/D2+5p6rsH6wDscVjXJrm+vksWPpElbT7TeZfh1F9lZglSIZvVgDLxKK/frlW6uj3xeEn94cAzl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtG25+cu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e651a9f3ffso102551445ad.1;
        Tue, 21 May 2024 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314387; x=1716919187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7qQgvaLUE9M4rws6iEQt+/SaZKzeTop758mxKe3fzns=;
        b=QtG25+cu/KT5F0Mc/W69K8M3LMGfoT6jgaDm3/TI1tilHhHRV4/oMdJ3ygiwTcyWd0
         7SvRN3/yLglNqE0mkZZFxjJuEiITTC21QM0K/OZl9s/jA6XxsqyN0OxnEFkZSoHgsU6R
         vXFtF2+uxgks+sVgl/IRSWUkE0fSvkm4VJq+rnCPP7jxVnRhyyfluRlKGMhNpKzDSGoY
         etKZUDZByCBRInz8hj1vO8t/wTQPnBS51WlGZOsgPiK3Aw6/DJNe2rZI4h9PbU7YLc1b
         jNpfwqH/BeKcdQKnPLxubWAsPpGZ0rAePljQb3U65jQsNxB0ADkZsaAvg4Y/uaqC8Ep7
         1gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314387; x=1716919187;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qQgvaLUE9M4rws6iEQt+/SaZKzeTop758mxKe3fzns=;
        b=DYFMYF/0o4xvXMdyc2oQGRbVjp3ZAYZJ+eWZitOJ2Fza3GqtNh0q9Luyjj8QfaVGwp
         eFqYYw7Tro15kfSG99kUvow1Dr7wvZay8H37dUZYITTZ3A76UugyreEFFXKZdMHbu285
         6ur2lOlVbJ75IE4gWIgJtWalAdcBy/MNRxy078Ysb9VKFNjBPYa7N4EGdx+a5KFtws0z
         vEFT9UMc1AohGIgw2oa2q6BuEFAd7iO4wHhmcGDhtTeycjwr7P8CUn1Gsw9F50weBw1G
         GizE7htncnmcxE0M5K89cq9KwbSyv4piFCQDh46JT97PAniAkqmGBAootSsOqtI8gd56
         4brQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhvJQKMSq9UIs42k6jjjgGdxjR2EZe2+sQUQzdXcDedNiRUJx05VoRPjJmvECSCNZyJU8UT2vcW19FmioT7bhqJFvTdYb1Qe+urYT/1SdQO3rDAOuA1PW5/0IcEaYgwZZdykedHFmt7SrQRQ==
X-Gm-Message-State: AOJu0YxmjnTUXFVsjG81/CVSEqvWFiD4NrjqTa9VYi7e75wptRGjzKxJ
	yGeM/9b/4qOMbEoxuuWuohxK5aq/HMJeyUGcRl6Yi25akawz7tPX
X-Google-Smtp-Source: AGHT+IEZakWrbVxlRp22N1fNkpJSK0qMF00Dd6C/77G4znr2CuE4Uf3FXSSlP5KZRo8UMc08FAqQKQ==
X-Received: by 2002:a17:902:dac1:b0:1f3:3ab:a4fb with SMTP id d9443c01a7336-1f303aba649mr57889605ad.10.1716314387027;
        Tue, 21 May 2024 10:59:47 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:46 -0700 (PDT)
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
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v6 10/11] mm: drop page_index and simplify folio_index
Date: Wed, 22 May 2024 01:58:52 +0800
Message-ID: <20240521175854.96038-11-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
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
- folio_index

This commit drops page_index, as we have eliminated all users, and
converts folio_index's helper __page_file_index to use folio to avoid
the page conversion.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
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
index 010ce7340244..7fd67edc0bcf 100644
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
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f6ca215fb92f..0b0ae6e8c764 100644
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
2.45.0


