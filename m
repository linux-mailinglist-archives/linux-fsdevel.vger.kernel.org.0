Return-Path: <linux-fsdevel+bounces-59673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C7B3C5AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E291B27EE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D43148BB;
	Fri, 29 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyhZJiwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274BD276025
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510799; cv=none; b=ZyOzgdcIQCeq2SJNZmbebGRhiyYOHTMnR4DUkYE9BwAwQecblzTZtFNR/qyuQQiOAQUSWOJ/WBBKrcJkAgoNgAFC4cGMa95/Ta6XhAz1V0ZUgcgN836+QoIGCvP5ZnkdxXxwcRWHD4Ux5WHs6HuXsxXldfmLRpBw9pQgxN1blDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510799; c=relaxed/simple;
	bh=WV0Qj1oWF+fzX1Gwu1uLGei+aUzVB+lmn2FD5Qdrk7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHcTSdW53hH/3RwuqDxG3ACOs4S3XLyBlkIT30qzd7xr3nTacAY5+ycEcaN5cVEC5tM5QJTdHbCHvhlX4WihfGex6wCvg3W08J2Ef4S+zfVTylA12GF2nbErq8nfslMXI+EGORJgTkjIg3lQPv0OM+myb/ZD76J5IzNiGKNoGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyhZJiwr; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47175d02dcso2205733a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510797; x=1757115597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQukcjQRM/baglvoT2KPpefom5XTnGCNmGslo6r1GEQ=;
        b=hyhZJiwr/NdU2ed0YINdZk4dkRqo2WjqcaY8BLhxBP006OYTehAyboZBHLZfasgnBG
         HzbBrrXbVlOrJGZMeXacEDe6YnN8M75pqF/bPSfQ/KTp+dVXgXGN051obIzDjx5jnysa
         sN7+1HEzuwrXH7kzLc3lCLHB6KoR7Gf4PfMTAv379XVki/HoyiB2srGp57vax+osmmze
         v8blBR6T01ra7Rv+BlpPSdgC7l7UorSBew+ipN2Wd2MMRuNArFkHmEwnvmNbg+bkwrBT
         InQyS1tMEG5d7tlvMT0yKmDvPsJN7bRoUn4Omv4NOZ7c38JHn82U1b3qvKMVYTE2CDL/
         CnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510797; x=1757115597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQukcjQRM/baglvoT2KPpefom5XTnGCNmGslo6r1GEQ=;
        b=bi+2h+4dqJRKofGcggjVYTswELSeQMZ85lLpmFdtsnNfOCOhwQdr1hpP/ibPGZh6FN
         5mzlvCBaW9QQL2nuHVjLqu1TicqY0D/R0+hd2jQewo59x38P34T4zKIl6dn4F0+nZxUl
         Ie1Rd/4TKUdz8YUQFEs4WSW/QHXMrHI+rSkmDW/ka4G10Zt3T3KfOcUYlZOUTaNMdrLv
         ZPMtpQ3pd/9ms4CqUT+3kqoNwkXQMNgS94W6SNuSAWv9pSgTkKVE5dtDt+vgMmxbTPza
         BzFLIntwH0YI9rm6Aaa9V2FEILM/2dcZ+fQ+A2n0tlfMPgWAnVzBMwzr3y+Syc/l6f/g
         XRDg==
X-Forwarded-Encrypted: i=1; AJvYcCVR3JYTIyzqkq2yktY/gC9ItzWRJcxJ2F8ipBBNZamDL2IM/Xjdf1ZZwVIMXpXCb35aAE5cNndubgQlkFjA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+p/mNYjqFXpLXWagnxg/j5bMDDPVg6uCXQ/ah8YkX2fIEX1dl
	T0WEx6J0B/5x5h5WbtPjgRi6etGTb7XbAvHCsMgtEnkfL+IWh8/9uYj8
X-Gm-Gg: ASbGncse8g6mDR/7Pctn0S5okHU0YQQfatKRqeHCbHKygyMPFGwa58ArfU7YTfh6IK/
	w+QGOHKhGlICS9ETkgxJSZGviytmLx1Jj+jLpx1BxGiixOwoG/9ddoNyz2yNPil/slwDTRVKBFZ
	Gq698v1jy1YiW0J4XduDn0aCacy4D7VUrjf2B25tMbl7Sa4+wxE91eQ6dCRKo7sJHJBUZOc7PV0
	FXmBVb9xRjK1lRxmDlfH0HcBXPDjRg6JBOayzoTICgYq5+OCTvI7ngOSc5cwxs/oGx/X/+RVX3Q
	L+p5rNNNdYwRgk2++m34gnax31ZI0rNBu2vt80Piraxtd3R/QmqYILu/c8h7FfPU8VcKgIDs8Rm
	nipMoFeRkp6JTUNdkpTgSkKNdBok=
X-Google-Smtp-Source: AGHT+IHhvNxODvJgpQ4vTWKKwEcUrkdCrnvezfsKZ38SEm/r0ZcLOPNUukweP3ilslLK3BqmFJDj8w==
X-Received: by 2002:a17:902:d2c5:b0:248:7540:7bdf with SMTP id d9443c01a7336-249448dcc22mr5541335ad.15.1756510797368;
        Fri, 29 Aug 2025 16:39:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm36024195ad.59.2025.08.29.16.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:39:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 05/12] mm: add filemap_dirty_folio_pages() helper
Date: Fri, 29 Aug 2025 16:39:35 -0700
Message-ID: <20250829233942.3607248-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add filemap_dirty_folio_pages() which is equivalent to
filemap_dirty_folio() except it takes in the number of pages in the
folio to account for as dirty when it updates internal dirty stats
instead of accounting all pages in the folio as dirty. If the folio is
already dirty, calling this function will still update the stats. As
such, the caller is responsible for ensuring no overaccounting happens.

The same caller responsibilities apply here as for filemap_dirty_folio()
(eg, should ensure this doesn't race with truncation/writeback).

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/buffer.c               |  4 ++--
 include/linux/pagemap.h   |  2 +-
 include/linux/writeback.h |  2 ++
 mm/page-writeback.c       | 41 +++++++++++++++++++++++++++++++++++----
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 65c96c432800..558591254fdb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -752,7 +752,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
 
 	if (newly_dirty)
 		__folio_mark_dirty(folio, mapping, 1,
-				   folio_nr_pages(folio));
+				   folio_nr_pages(folio), true);
 
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -1205,7 +1205,7 @@ void mark_buffer_dirty(struct buffer_head *bh)
 			mapping = folio->mapping;
 			if (mapping)
 				__folio_mark_dirty(folio, mapping, 0,
-						   folio_nr_pages(folio));
+						   folio_nr_pages(folio), true);
 		}
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 48745f8f6dfe..510bc6e0f70b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1224,7 +1224,7 @@ void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_pages(struct folio *folio, long nr_pages);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn,
-		long nr_pages);
+		long nr_pages, bool newly_dirty);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
 void __folio_cancel_dirty(struct folio *folio);
 static inline void folio_cancel_dirty(struct folio *folio)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a2848d731a46..0df11d00cce2 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -372,6 +372,8 @@ void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
+bool filemap_dirty_folio_pages(struct address_space *mapping,
+			       struct folio *folio, long nr_pages);
 bool folio_redirty_for_writepage(struct writeback_control *, struct folio *);
 bool redirty_page_for_writepage(struct writeback_control *, struct page *);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e66eef2d1584..1f862ab3c68d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2730,7 +2730,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  * try_to_free_buffers() to fail.
  */
 void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
-			     int warn, long nr_pages)
+			     int warn, long nr_pages, bool newly_dirty)
 {
 	unsigned long flags;
 
@@ -2738,8 +2738,9 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
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
@@ -2769,7 +2770,7 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 		return false;
 
 	__folio_mark_dirty(folio, mapping, !folio_test_private(folio),
-			folio_nr_pages(folio));
+			folio_nr_pages(folio), true);
 
 	if (mapping->host) {
 		/* !PageAnon && !swapper_space */
@@ -2779,6 +2780,38 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 }
 EXPORT_SYMBOL(filemap_dirty_folio);
 
+/**
+ * filemap_dirty_folio_pages - Mark a folio dirty and update stats to account
+ * for dirtying @nr_pages within the folio.
+ * @mapping: Address space this folio belongs to.
+ * @folio: Folio to be marked as dirty.
+ * @nr_pages: Number of pages to dirty.
+ *
+ * This is equivalent to filemap_dirty_folio() except it takes in the number of
+ * pages in the folio to account for as dirty when it updates internal dirty
+ * stats instead of accounting all pages in the folio as dirty. If the folio is
+ * already dirty, calling this function will still update the stats. As such,
+ * the caller is responsible for ensuring no overaccounting happens.
+ *
+ * The same caller responsibilities apply here as for filemap_dirty_folio()
+ * (eg, should ensure this doesn't race with truncation/writeback).
+ */
+bool filemap_dirty_folio_pages(struct address_space *mapping,
+			struct folio *folio, long nr_pages)
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
  * folio_redirty_for_writepage - Decline to write a dirty folio.
  * @wbc: The writeback control.
-- 
2.47.3


