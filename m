Return-Path: <linux-fsdevel+bounces-32218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCCB9A265D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40E9B26CAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F261DE4DF;
	Thu, 17 Oct 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V3RGVG3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E681DB34B;
	Thu, 17 Oct 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178238; cv=none; b=fXsgh1By9iQN0s1aM6ZxiZCgNKzNiI1nARRRTg8fHQGqBTXRS/P4x8nghgxyQnn/FjtSIYQGCwRtL41StjbcxXVrPDZ4G6qud5nNiKbiBUyiByucei1eOYIH4ZBCPdNxXu9xIe+Exc0sLYrq4414IT23CXnvWRn4PsYNKdzK+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178238; c=relaxed/simple;
	bh=5J6se2Wk/u3ANJ+0sjOE7omHJXFfyalcDj4VENz2P0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiOvMVb3RmL8LyM3aq8n6PCmf+57GUuUyN6skdi3ahSBb3PbHXCx6CbD0LHUHvhe0RYmgcZH/FIKnEIZfjtEJdrR0qav6SijskEkHysG13pxcnebaL1Xwg0BPZnt3MJjMKZXInCbLXc9LKnoPpV1dDYdpj7vawHMNH0Wt36XKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V3RGVG3y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QiZivunybxzP8kjGTH60sGPFjrRaIoLZx+rnZcsuhXY=; b=V3RGVG3ykl/8xBS8RFvq6+Gi65
	XPi1K8kdR/6g8XASUC1BXQN7Gdz2nehw0i6vfS3jec+GAGSKMIGrm+wAJ7SAHbNvNeLB6ea+THV3d
	Ol3ZOra0pn83czNOwH9wo5eLx4LyhPOLp6HA+lx+OPK2w9kQSbMLlWkn1GyN4nWZqZaIkzewn4WWL
	LxU+STT5vknXRw7FYRFOUcpwEev6N1fxgA1Y0u+OivriSBKYObBkyZHC7m43aTGFpLXwgJhjvomj6
	D6FbBMiZNC8+ygsLuxUc4iuEL43MhKQDp860zzgtisyn96ao8GWwfI8OnOfN3LhelHw1Ufh3FtGNx
	2HmkuM3A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFT-0000000BNnh-2q7j;
	Thu, 17 Oct 2024 15:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/10] ecryptfs: Convert ecryptfs_write() to use a folio
Date: Thu, 17 Oct 2024 16:17:00 +0100
Message-ID: <20241017151709.2713048-6-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017151709.2713048-1-willy@infradead.org>
References: <20241017151709.2713048-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove ecryptfs_get_locked_page() and call read_mapping_folio()
directly.  Use the folio throught this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/ecryptfs_kernel.h |  1 -
 fs/ecryptfs/mmap.c            | 16 ----------------
 fs/ecryptfs/read_write.c      | 25 +++++++++++++------------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 43f1b5ff987d..f04aa24f6bcd 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -662,7 +662,6 @@ int ecryptfs_read_lower_page_segment(struct folio *folio_for_ecryptfs,
 				     pgoff_t page_index,
 				     size_t offset_in_page, size_t size,
 				     struct inode *ecryptfs_inode);
-struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index);
 int ecryptfs_parse_packet_length(unsigned char *data, size_t *size,
 				 size_t *length_size);
 int ecryptfs_write_packet_length(char *dest, size_t size,
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index b7ef0bf563bd..ad535bf9d2f9 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -22,22 +22,6 @@
 #include <linux/unaligned.h>
 #include "ecryptfs_kernel.h"
 
-/*
- * ecryptfs_get_locked_page
- *
- * Get one page from cache or lower f/s, return error otherwise.
- *
- * Returns locked and up-to-date page (if ok), with increased
- * refcnt.
- */
-struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
-{
-	struct page *page = read_mapping_page(inode->i_mapping, index, NULL);
-	if (!IS_ERR(page))
-		lock_page(page);
-	return page;
-}
-
 /*
  * This is where we encrypt the data and pass the encrypted data to
  * the lower filesystem.  In OpenPGP-compatible mode, we operate on
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 251e9f6c6972..cddfdfced879 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -93,7 +93,6 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
 int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 		   size_t size)
 {
-	struct page *ecryptfs_page;
 	struct ecryptfs_crypt_stat *crypt_stat;
 	char *ecryptfs_page_virt;
 	loff_t ecryptfs_file_size = i_size_read(ecryptfs_inode);
@@ -111,6 +110,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 	else
 		pos = offset;
 	while (pos < (offset + size)) {
+		struct folio *ecryptfs_folio;
 		pgoff_t ecryptfs_page_idx = (pos >> PAGE_SHIFT);
 		size_t start_offset_in_page = (pos & ~PAGE_MASK);
 		size_t num_bytes = (PAGE_SIZE - start_offset_in_page);
@@ -130,17 +130,18 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 			if (num_bytes > total_remaining_zeros)
 				num_bytes = total_remaining_zeros;
 		}
-		ecryptfs_page = ecryptfs_get_locked_page(ecryptfs_inode,
-							 ecryptfs_page_idx);
-		if (IS_ERR(ecryptfs_page)) {
-			rc = PTR_ERR(ecryptfs_page);
+		ecryptfs_folio = read_mapping_folio(ecryptfs_inode->i_mapping,
+				ecryptfs_page_idx, NULL);
+		if (IS_ERR(ecryptfs_folio)) {
+			rc = PTR_ERR(ecryptfs_folio);
 			printk(KERN_ERR "%s: Error getting page at "
 			       "index [%ld] from eCryptfs inode "
 			       "mapping; rc = [%d]\n", __func__,
 			       ecryptfs_page_idx, rc);
 			goto out;
 		}
-		ecryptfs_page_virt = kmap_local_page(ecryptfs_page);
+		folio_lock(ecryptfs_folio);
+		ecryptfs_page_virt = kmap_local_folio(ecryptfs_folio, 0);
 
 		/*
 		 * pos: where we're now writing, offset: where the request was
@@ -164,17 +165,17 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 			data_offset += num_bytes;
 		}
 		kunmap_local(ecryptfs_page_virt);
-		flush_dcache_page(ecryptfs_page);
-		SetPageUptodate(ecryptfs_page);
-		unlock_page(ecryptfs_page);
+		flush_dcache_folio(ecryptfs_folio);
+		folio_mark_uptodate(ecryptfs_folio);
+		folio_unlock(ecryptfs_folio);
 		if (crypt_stat->flags & ECRYPTFS_ENCRYPTED)
-			rc = ecryptfs_encrypt_page(ecryptfs_page);
+			rc = ecryptfs_encrypt_page(&ecryptfs_folio->page);
 		else
 			rc = ecryptfs_write_lower_page_segment(ecryptfs_inode,
-						ecryptfs_page,
+						&ecryptfs_folio->page,
 						start_offset_in_page,
 						data_offset);
-		put_page(ecryptfs_page);
+		folio_put(ecryptfs_folio);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting "
 			       "page; rc = [%d]\n", __func__, rc);
-- 
2.43.0


