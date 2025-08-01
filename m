Return-Path: <linux-fsdevel+bounces-56490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E99B17A99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53A3546795
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA32D2FF;
	Fri,  1 Aug 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTjbLXL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BA8836
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008068; cv=none; b=JkWoOYMf962hKL5pwkl+iGsZGAGlFqc9Wf6iau++e7wHf5CCqfvvd0jVwb4UM3oP0L1WAuet0bcJylzSl4IzCRvZ/EojUWOUekRltf1BzKgBMB5tjZLzmUo2fUAMMJx2rKjIQ7VBEy9fyNbKLdwRm5ag4XJ/55oU9ouGwHX7ly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008068; c=relaxed/simple;
	bh=tA8hKhcBc7ilT0SVTAIHTJGox/69vbRUKIdT+oMLRLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8yjsnVQWEZty7jsJ3p+SWQwHKq0/Njn2Cs0aW1W+FnRGVAKxfpJp3BdP9JmiWSRPgE20zmH+B//DWr2hHxFHhyrv3SmRGDQn5Kt9K5iX6+CTk9VZCZ3547NwrC2WgxJAMBZaS3waqNh6z1PT2wX37n2JaAFxs3GdzdWpFNxDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTjbLXL5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167afeso2476925ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008066; x=1754612866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A47stI8ETeILZJCr6fItHz57HSMt8dzaF9eLmbnpFw=;
        b=ZTjbLXL5M3hyQ/QttANH/uO7jVkv5B3NYufPmddflwK55knEavc0gwMYpiF1GMNkhC
         8zS8aNcz325LAqbohUWYe1GGYXvUS77n596obWc0S2s9sLxpFm2QnFgif1hfY1nxCA+y
         pV5f1BoCcZzO5eDS1jBQpT2a8KQW0h2wFB9akq5hPSVittv86wjLkMNiSTFRl/8Gs0oe
         48TFCGuue7dE4pog9kmTMxh6DGCg3cg4kHkK7OhG1GMGNYpayuHekPWN0WbPW2hxLnjk
         r82nA6epB81gvcsd31uMiWAy/7TNRXn91X6GbITKhDcemnAXcJUdPVjzz6okuvpQLFBc
         pWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008066; x=1754612866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A47stI8ETeILZJCr6fItHz57HSMt8dzaF9eLmbnpFw=;
        b=c1cZ0uDIG8ZnnIcwSv+cog5TFnNZgKi9d2CJGUy6qq9rWvHrpiPcQIC0E6t35iyc8I
         9c2bSf0zIDMFGnOkps65JbujFlt7PcNXi4SPPQ/oimWSbpiiTHYUoPSHIqoKZMJ1Omby
         zo0arfJK+Gmk8ioAzjuBR/annq934Z7cQtZymQ4ztbezZ50LkERDXtmpUSH1sevNCHml
         pIz3DWLWAUe15TJ4ZeyhPkU+UBsP2rzUs21UqY0iQqNJ1o6gnCDnS7GQXYs6Ysofs/xN
         hHcYdxyfxNVs1NGw47vSOIzX3bolOHMgc1AOju2zu6cxo+38lnEAzXIA4zXsYP2lP7CY
         EY6A==
X-Forwarded-Encrypted: i=1; AJvYcCXLeWWc4/2ZMU61/90itRnIj/b4BviuoNQRyX/CAVNn92iSzzx4PDoTrVgyWxC0t5BFpPm/DaiZnOqqloEd@vger.kernel.org
X-Gm-Message-State: AOJu0YwW45XWUSdb6Otl+WR25c4qcRx0iSqGfXChONwezTcj+ipTRqmM
	HADIv3tMTeP4CK27p36rzUkafPeq3zqoJXlK8ZcLuP1PML19bdS2howgCLE0ZA==
X-Gm-Gg: ASbGncuSKPFfugN2Oukhuy9TbBD7lLCqovgGWdNfPBO32WTG8ERzgL5rYoeb1hS5QwJ
	XgGBX+Zv/DU/gMMTzf4n+OZoRxV7cGPZQuYV7+a6dqDMU4e89W98RHVzth95JfJS8jY25xmZKH2
	XxusVTw30BLopaMTsYXHMsFJ3bzgbNTs8seKxMbgG4HSuRLd6BWNfx558pht0QYvZmeAkcyjtpT
	A0UqojT132r4Tu1TyJtZwkRIjslz7USJ4u6OdRBwhiYH6EtPgIBJAZ1mx02H3FpHxYk5+S+n8Pe
	o3BPNEGqkNvwTquc6O5d3a1dhUhB5J6HBwAbhwVD9/VMRC+bidvAgo9Uvk+Z/uur2WmhshT7Ukn
	f8hL+VWCKdaNDy1lefg==
X-Google-Smtp-Source: AGHT+IGmb+EpPLIv0vDv4kkZxncE7spBotqBRBZJFRIwQ13RBpUluKB87/mBy1H71J8Pn+xd/C16Kw==
X-Received: by 2002:a17:903:acc:b0:240:3e40:43b0 with SMTP id d9443c01a7336-24096be1970mr132216125ad.43.1754008066072;
        Thu, 31 Jul 2025 17:27:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e7d8sm28305685ad.42.2025.07.31.17.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 05/10] mm: add filemap_dirty_folio_pages() helper
Date: Thu, 31 Jul 2025 17:21:26 -0700
Message-ID: <20250801002131.255068-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add filemap_dirty_folio_pages() which takes in the number of pages to dirty.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/buffer.c               |  4 ++--
 include/linux/pagemap.h   |  2 +-
 include/linux/writeback.h |  2 ++
 mm/page-writeback.c       | 25 +++++++++++++++++++++----
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 327bae3f724d..7c05f6205d39 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -752,7 +752,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 
 	if (newly_dirty)
 		__folio_mark_dirty(folio, mapping, 1,
-				   folio_nr_pages(folio));
+				   folio_nr_pages(folio), true);
 
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -1211,7 +1211,7 @@ void mark_buffer_dirty(struct buffer_head *bh)
 			mapping = folio->mapping;
 			if (mapping)
 				__folio_mark_dirty(folio, mapping, 0,
-						   folio_nr_pages(folio));
+						   folio_nr_pages(folio), true);
 		}
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0ae2c1e93ca5..64f17aec9141 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1205,7 +1205,7 @@ void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_pages(struct folio *folio, long nr_pages);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn,
-		long nr_pages);
+		long nr_pages, bool newly_dirty);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
 void __folio_cancel_dirty(struct folio *folio);
 static inline void folio_cancel_dirty(struct folio *folio)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index eda4b62511f7..34afa6912a1c 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -383,6 +383,8 @@ void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
+bool filemap_dirty_folio_pages(struct address_space *mapping,
+			       struct folio *folio, long nr_pages);
 bool folio_redirty_for_writepage(struct writeback_control *, struct folio *);
 bool redirty_page_for_writepage(struct writeback_control *, struct page *);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b0ae10a6687d..a3805988f3ad 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2732,7 +2732,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  * try_to_free_buffers() to fail.
  */
 void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
-			     int warn, long nr_pages)
+			     int warn, long nr_pages, bool newly_dirty)
 {
 	unsigned long flags;
 
@@ -2740,12 +2740,29 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 	if (folio->mapping) {	/* Race with truncate? */
 		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
 		folio_account_dirtied(folio, mapping, nr_pages);
-		__xa_set_mark(&mapping->i_pages, folio_index(folio),
-				PAGECACHE_TAG_DIRTY);
+		if (newly_dirty)
+			__xa_set_mark(&mapping->i_pages, folio_index(folio),
+					PAGECACHE_TAG_DIRTY);
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
 
+bool filemap_dirty_folio_pages(struct address_space *mapping, struct folio *folio,
+			long nr_pages)
+{
+	bool newly_dirty = !folio_test_set_dirty(folio);
+
+	__folio_mark_dirty(folio, mapping, !folio_test_private(folio),
+			nr_pages, newly_dirty);
+
+	if (newly_dirty && mapping->host) {
+		/* !PageAnon && !swapper_space */
+		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
+	}
+
+	return newly_dirty;
+}
+
 /**
  * filemap_dirty_folio - Mark a folio dirty for filesystems which do not use buffer_heads.
  * @mapping: Address space this folio belongs to.
@@ -2771,7 +2788,7 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 		return false;
 
 	__folio_mark_dirty(folio, mapping, !folio_test_private(folio),
-			folio_nr_pages(folio));
+			folio_nr_pages(folio), true);
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
-- 
2.47.3


