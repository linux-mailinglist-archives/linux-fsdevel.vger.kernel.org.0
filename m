Return-Path: <linux-fsdevel+bounces-9938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179428463C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A967E1F28A96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1541232;
	Thu,  1 Feb 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AuLYAqHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903804176C
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827575; cv=none; b=ekYVnt+u3fwtqKyS9TszMqky+xzrzZDwdVyCbczRGynP0lBTUJfFcf3V4E4AceXNN25sF0aA8fHO1aX1zdVB5kWxxaSY0MngLyHZRgXLQF4WNBoBZJH239XHDfVnXBweS4O21lqwhqi5+y/n9ybT/2oHw79jqXj4zRwaSZwNKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827575; c=relaxed/simple;
	bh=+6CnVkVPs4+OQiStkQMP9qnRiIsj0LqX8bNkXkpK6pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGF2I1MwQZgbdRa1goCbyNUfcGmAcR7pgUETma52MjYk6P3JdqJJbF3Sd2RQxEg1q55gh+f3GXFNnpUp/phrC7J+UfIhO1MPRR520+FpRRQT5fOm4VKiLFto+d1qi1ttbWEWUKMafjGg+ta/L3CSbkXyvhl1lIBl5L1wTKQNUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AuLYAqHH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OML5TsEvwXZSkzwoDqzVRJxgBN9HbIljp99tCJ6zNuY=; b=AuLYAqHHohrWlddGwzulHeIkod
	rsUSrMtsA05ay8ScxkHnSq6J3M0iZaVpsxLIFP3iPFmvyB0Eq/4z0rueqcT/UutG7pXgzLUokEnyG
	o8z0HvtALHO+pBLBIcurdJde0chmSYFjM8QGYhKltK7EV9lnxCA4T2fDBbSbj1ZR/nLwU1PwEmBRt
	kLy8g2htvrz0rZzkN4n4iMcvhbQiSS+XbVFhM6m/ADD7CNP5F5n9ZygupBkPSPO1Wohp758prmqa4
	teULjD0tYghDzR5BtcJOlmdqlb/7Ty2HoGvn6QMatOkCY9SViqnLsiM69qqJAaxVp270AYdBztr8+
	fmBIM3tA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfou-0000000H18u-0XJQ;
	Thu, 01 Feb 2024 22:46:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/13] jfs: Convert inc_io and mp_anchor to take a folio
Date: Thu,  1 Feb 2024 22:45:59 +0000
Message-ID: <20240201224605.4055895-11-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201224605.4055895-1-willy@infradead.org>
References: <20240201224605.4055895-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All their callers now have a folio, so pass it in.  No savings here,
just cleaning up some remnants.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 59729b9dd76f..bc62d4bb4712 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -78,7 +78,7 @@ struct meta_anchor {
 	atomic_t io_count;
 	struct metapage *mp[MPS_PER_PAGE];
 };
-#define mp_anchor(page) ((struct meta_anchor *)page_private(page))
+#define mp_anchor(folio) (folio->private)
 
 static inline struct metapage *folio_to_mp(struct folio *folio, int offset)
 {
@@ -116,7 +116,7 @@ static inline int insert_metapage(struct folio *folio, struct metapage *mp)
 
 static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 {
-	struct meta_anchor *a = mp_anchor(&folio->page);
+	struct meta_anchor *a = mp_anchor(folio);
 	int l2mp_blocks = L2PSIZE - folio->mapping->host->i_blkbits;
 	int index;
 
@@ -132,9 +132,9 @@ static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 	}
 }
 
-static inline void inc_io(struct page *page)
+static inline void inc_io(struct folio *folio)
 {
-	atomic_inc(&mp_anchor(page)->io_count);
+	atomic_inc(&mp_anchor(folio)->io_count);
 }
 
 static inline void dec_io(struct folio *folio, void (*handler) (struct folio *))
@@ -166,7 +166,7 @@ static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 	kunmap(&folio->page);
 }
 
-#define inc_io(page) do {} while(0)
+#define inc_io(folio) do {} while(0)
 #define dec_io(folio, handler) handler(folio)
 
 #endif
@@ -395,14 +395,14 @@ static int metapage_write_folio(struct folio *folio,
 			 * Increment counter before submitting i/o to keep
 			 * count from hitting zero before we're through
 			 */
-			inc_io(&folio->page);
+			inc_io(folio);
 			if (!bio->bi_iter.bi_size)
 				goto dump_bio;
 			submit_bio(bio);
 			nr_underway++;
 			bio = NULL;
 		} else
-			inc_io(&folio->page);
+			inc_io(folio);
 		xlen = (folio_size(folio) - offset) >> inode->i_blkbits;
 		pblock = metapage_get_blocks(inode, lblock, &xlen);
 		if (!pblock) {
@@ -496,7 +496,7 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 		if (pblock) {
 			if (!folio->private)
 				insert_metapage(folio, NULL);
-			inc_io(&folio->page);
+			inc_io(folio);
 			if (bio)
 				submit_bio(bio);
 
-- 
2.43.0


