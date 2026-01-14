Return-Path: <linux-fsdevel+bounces-73818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3BDD21595
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15FB3045F40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B12E352FB2;
	Wed, 14 Jan 2026 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzOa/227"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C033B6E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426401; cv=none; b=K22zWtkGFhe6dXD6+tLUI56vFZvbwjOYIniktI/R8qmngtijpYjlcEXz98rV9w35S3ZD4YV3N5hS+bnCI3H5eMqYl2jUkOLpgFGsJ5bwjv4Tl9FRbHlicR9inMknOVfThcWSj4vxOTtm7JLQ3zCnFd78D22Y9DZEcSYptRENSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426401; c=relaxed/simple;
	bh=Z7q2dDcOGE5HHI9QjGkZF0YF9uZw21LuZRZPZpdyNIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKmfLnyLuRL6MIGFakabQIEEdoLVULxsE2sgOnyhqLMfLttzFfzyr9oUqGS3r3wrNisq0Mg5js5sIzOUxyUCmz399YtLaxiXV9BDy1ZAtyJPYT4iO4DXsq2LD+AhtZciwD05zXQGebXq/ZI5DtUj2wVXx99fg9dTDFTBMsbiS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzOa/227; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cfcebf1725so176447a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426398; x=1769031198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSGuW77Tqa7tA2WLBhJJdwtXNnuVhxLeXVZSIZi6p4U=;
        b=JzOa/227Efe9oKpPOLLaSbebVvzfyc42E/v99KGVF+H1gXiLXkud0T8kigaTfa5uL5
         lhZwrQCXzDxKXbq0DtwO1HWwJPVRiVqmO1rF3np3bwcUBF8pLXEjBsZUTu8SO97D0c//
         nRhT+LJexsBR+IwpkV/GLsvkEx3G1EttdpDLjmSz2AHQ4pyUuS0D2JbTfDVBeJi6qB8V
         xo0QXlvy49aoVkqYFUOrO2eJLVq2Fh210DDhm59bglaf7vyb7L9bB4s5/tY9CvOjzjN/
         uzYDpUzIPPkqXazqzUXhJt5YN0klwjm+vxxghHp4w2yFB3vR0IXG09R7wE2WVU33sr0y
         w2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426398; x=1769031198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGuW77Tqa7tA2WLBhJJdwtXNnuVhxLeXVZSIZi6p4U=;
        b=Rj5/Cbku1SzU+DMKW1gkA/lG7D9Y79pz5LmlGhkzxmYTNCtS0nQAr/2T2LRFdaRN2T
         bmfu5APjdN2+odqGUnYSkXNH9RmRxnmcm51d2cteCM/1US2kCt1pvr6TWjYvFNqKsyMf
         oo8egwTZXT7/hcMFI7pUsWr4iTgxIZogPl62nnE93amS0BMAnIEa6L5nzqwpO14r354A
         RzvUH2LoNnRccSGUHniQpovEPsTQ9POHcoakgRky+9Dus1E7eCcENlF9OhwkdatoFd9F
         u6mGT+0/sVTxp5Mh4DoC8+SROisOFrujynCrSf9Wva8txDAtJf1P5Sbi5pjnKdMHsk9F
         3+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQoRxtGxK0M0ye23/T6AbnHRPSolU9EmUqvhgCimVgkKD6bKyEPRY/gTeJxqCXFwp7UIVzt79BmW28TidO@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjPUbNUVHBGeC9z/M0zVmgSQFhqISh2KxnmQaiIpri9l/ji0q
	W9i5eCOqIIjGWSQigMm0fpPAvcd2KU0xQef7ASO92ENGKLXtqw6EtWfX
X-Gm-Gg: AY/fxX7ZBHaKJnu9BTBr69CmLTQQTs99F9TnU15lGDDcIPVR8Y2eCnpQSeFMj4hWAPE
	eyeWwRFmLSOWx75vMgyN7J3ZbjXy8Ngn5tAXbKu7fc2ZTWcWL52trwlum2Duxa/eAHB8+3XzLUA
	cwXFAC8rtMaM9WK2VjpJFI7kn5DkEt8K9IEj4hAWIKvPXB8lncXWGT0EITA9wwsL9zWZlvfkNjj
	7jJk+qVaiRxjFVdZLGimDka7vOApJKAb4cFrrpwvNTVKlO2zJJsl6D4EAkSHJiUk7FJFmQDw+RZ
	yAu4TvQC6b3YWvTMxZnHYC8PWUjkWrVYiV3yb8BM5MtfROE76HZaubjp0wQW3JD9pxfEby1SE18
	WpB2MQdDwKeziDXibS3sSL0oHirOehWqmiN+rrCLQEnixaOYvwHaoD+Mf3lzhXOM2ow+eN+lZUq
	kNxZti6/35G72k0bHy4o3qHpOdfFN94XzkWiTj1OfmPuu7
X-Received: by 2002:a05:6830:44a4:b0:7c7:4bb:dc06 with SMTP id 46e09a7af769-7cfc8965df3mr3143110a34.0.1768426397962;
        Wed, 14 Jan 2026 13:33:17 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfd68b13fesm76200a34.3.2026.01.14.13.33.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:33:17 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 02/19] dax: Factor out dax_folio_reset_order() helper
Date: Wed, 14 Jan 2026 15:31:49 -0600
Message-ID: <20260114213209.29453-3-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

Both fs/dax.c:dax_folio_put() and drivers/dax/fsdev.c:
fsdev_clear_folio_state() (the latter coming in the next commit after this
one) contain nearly identical code to reset a compound DAX folio back to
order-0 pages. Factor this out into a shared helper function.

The new dax_folio_reset_order() function:
- Clears the folio's mapping and share count
- Resets compound folio state via folio_reset_order()
- Clears PageHead and compound_head for each sub-page
- Restores the pgmap pointer for each resulting order-0 folio
- Returns the original folio order (for callers that need to advance by
  that many pages)

This simplifies fsdev_clear_folio_state() from ~50 lines to ~15 lines while
maintaining the same functionality in both call sites.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: John Groves <john@groves.net>
---
 fs/dax.c | 60 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 289e6254aa30..7d7bbfb32c41 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -378,6 +378,45 @@ static void dax_folio_make_shared(struct folio *folio)
 	folio->share = 1;
 }
 
+/**
+ * dax_folio_reset_order - Reset a compound DAX folio to order-0 pages
+ * @folio: The folio to reset
+ *
+ * Splits a compound folio back into individual order-0 pages,
+ * clearing compound state and restoring pgmap pointers.
+ *
+ * Returns: the original folio order (0 if already order-0)
+ */
+int dax_folio_reset_order(struct folio *folio)
+{
+	struct dev_pagemap *pgmap = page_pgmap(&folio->page);
+	int order = folio_order(folio);
+	int i;
+
+	folio->mapping = NULL;
+	folio->share = 0;
+
+	if (!order) {
+		folio->pgmap = pgmap;
+		return 0;
+	}
+
+	folio_reset_order(folio);
+
+	for (i = 0; i < (1UL << order); i++) {
+		struct page *page = folio_page(folio, i);
+		struct folio *f = (struct folio *)page;
+
+		ClearPageHead(page);
+		clear_compound_head(page);
+		f->mapping = NULL;
+		f->share = 0;
+		f->pgmap = pgmap;
+	}
+
+	return order;
+}
+
 static inline unsigned long dax_folio_put(struct folio *folio)
 {
 	unsigned long ref;
@@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct folio *folio)
 	if (ref)
 		return ref;
 
-	folio->mapping = NULL;
-	order = folio_order(folio);
-	if (!order)
-		return 0;
-	folio_reset_order(folio);
+	order = dax_folio_reset_order(folio);
 
+	/* Debug check: verify refcounts are zero for all sub-folios */
 	for (i = 0; i < (1UL << order); i++) {
-		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
 		struct page *page = folio_page(folio, i);
-		struct folio *new_folio = (struct folio *)page;
 
-		ClearPageHead(page);
-		clear_compound_head(page);
-
-		new_folio->mapping = NULL;
-		/*
-		 * Reset pgmap which was over-written by
-		 * prep_compound_page().
-		 */
-		new_folio->pgmap = pgmap;
-		new_folio->share = 0;
-		WARN_ON_ONCE(folio_ref_count(new_folio));
+		WARN_ON_ONCE(folio_ref_count((struct folio *)page));
 	}
 
 	return ref;
-- 
2.52.0


