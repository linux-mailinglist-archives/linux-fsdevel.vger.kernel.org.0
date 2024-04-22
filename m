Return-Path: <linux-fsdevel+bounces-17425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054398AD4E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F79281E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FC155381;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QgM9avXo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4FC155330;
	Mon, 22 Apr 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814330; cv=none; b=LIptU/ZXODrwC7RFco06gaiopKAETiAT1Y4Hzb0jvsLRIzl+uTwWbgao3ENTbmACW0Qm4PqiyZTtc90qFzUbM0NjUpVx8v8UUnv5uJNsNqDjW/C9G+WRWqHYl7oM7NLOHLzklHiuNSUWk5kAykaLxlmADPlb93atxltKbfpoiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814330; c=relaxed/simple;
	bh=oQ12gdJfFeqwUZ/ihD+J+e4bcDDrIM++qc3jNtA0m6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njpmkXzZ8Y1AcUtrPAfO6Ay4MOQoQM//SfleSH8tG7hx1nQR+Y06++dJB0mmpqHVEH6/GnY/Guo7lf3BVPXw3D5tL6hEWtrU50Ihw1f5+pTRcYpAAIajdNnMaTaLOJIVXBdbwnZ1y5fk0UWb6qCgSPv9OJjekqZzgbHvsN/NOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QgM9avXo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UYRue+vvEySVdrtF5i8vTZmBSEewgkNCyDkAuih1QGI=; b=QgM9avXo3MAYLNih2v3JbRiEdt
	tggBplf75O/YlJw7M7QaRmboec2GJ2FMkbs5xLHXqVGd+I+lE7VBstoPSWccIl5g3X1G0R184ES4J
	EczyTYMNMulVYUX4z9M7LfFNyA4mNIB8P7B5JHGEcmA4QP2i51SbsZabVTsBjBgZ1YU2fWxJb0744
	TUdiTH7ruzTao3SmbHeMNjsQ0HxtFckmW2qqwM41xNuKZutU0zM4otHi49XMqZIbwGsYaLeU0TShZ
	fxCF0ec3TA2k5pfNcK1rJaqpGdDeFg8GYukhSmExoWGPnpqlUeisDaqvksN6tF7KudSVUFK0sqJfy
	5JuoTq9A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpOL-1Iiq;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/11] ntfs3: Convert ntfs_write_end() to work on a folio
Date: Mon, 22 Apr 2024 20:31:54 +0100
Message-ID: <20240422193203.3534108-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the passed page back into a folio and use the folio APIs, saving
a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index b0299c7b59b4..e9c1cba44741 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -950,6 +950,7 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		   u32 len, u32 copied, struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 valid = ni->i_valid;
@@ -961,23 +962,23 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		err = attr_data_write_resident(ni, page);
 		ni_unlock(ni);
 		if (!err) {
+			struct buffer_head *head = folio_buffers(folio);
 			dirty = true;
-			/* Clear any buffers in page. */
-			if (page_has_buffers(page)) {
-				struct buffer_head *head, *bh;
+			/* Clear any buffers in folio. */
+			if (head) {
+				struct buffer_head *bh = head;
 
-				bh = head = page_buffers(page);
 				do {
 					clear_buffer_dirty(bh);
 					clear_buffer_mapped(bh);
 					set_buffer_uptodate(bh);
 				} while (head != (bh = bh->b_this_page));
 			}
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 			err = copied;
 		}
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	} else {
 		err = generic_write_end(file, mapping, pos, len, copied, page,
 					fsdata);
-- 
2.43.0


