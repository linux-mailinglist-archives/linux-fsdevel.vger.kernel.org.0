Return-Path: <linux-fsdevel+bounces-32215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7349A2659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C2A283FDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582FD1DEFE1;
	Thu, 17 Oct 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qTGjjPNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F131DE4DF;
	Thu, 17 Oct 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178237; cv=none; b=hX+AEuZZ2ugtwyj2cjoFzgx/d7bwQCf9YyLHVyoIbWB4Mlg/Yl6Do+4cS03icJhiiDdBnP2TMAk/oKyRTHuPHsO46q1qY92omywIGt2oppuK0AEjpb1ldbrvTUclHui/5V/eYR29Le04+99Ji6KNaURCCBx0Qn+LwYhwpSfgtLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178237; c=relaxed/simple;
	bh=+inIYYTHCinhHWUkniRjXfv/ZjFYWploj+4M/z6VJB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8JNyBNRed+9Vj7fqmzNM52FewoPODF0Qm0+/7m7hez3W8xh3Mu4+m2cCzy9RFV9+of/mRKH+b4qT/6EGUh/fdR+hH2WAoDOooFMc/DOBO/sAAxo8GZB24kH/SmiGCXHinZvujDAARJotwogwNuuAE7K0wwrsOk1PXozSQCodqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qTGjjPNr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hbfyFWqCh2VWYf2n6aCxX1QX0AXK76icZVonkKpknhs=; b=qTGjjPNrmT0odM/Nlh5yy03hAp
	zcpF/McpBKqugyVVu85tbnNViAdbgfL3j6+b56/VFDX56H7BWHjFZEoX4egzyiRWvXN0CfsgkInDE
	igh0b/vbaErXv9eQ9Iw4qSDy3IDjac9Mj9kIj7y89yjp143LkogMvPL+82uTUWl1X0vUUIZHn/Yco
	sTNSJFNuYhXU8LGH0EHVPfnDVJOR3fa2HulJThlg/dp7+PhloH80RSmptwMKvlq5IPQAGZ07ALWoM
	EuVVkOfSf9OrB9UGbHIizKTDSYgq0KMxjedf+LydpGK/g0IgyMsVu/S53l5ekLkggI3OAfuyGfQar
	PP0UbkOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1SFT-0000000BNns-3USI;
	Thu, 17 Oct 2024 15:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/10] ecryptfs: Convert ecryptfs_write_lower_page_segment() to take a folio
Date: Thu, 17 Oct 2024 16:17:01 +0100
Message-ID: <20241017151709.2713048-7-willy@infradead.org>
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

Both callers now have a folio, so pass it in and use it throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/ecryptfs_kernel.h |  2 +-
 fs/ecryptfs/mmap.c            |  2 +-
 fs/ecryptfs/read_write.c      | 17 ++++++++---------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index f04aa24f6bcd..0cac8d3155ae 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -653,7 +653,7 @@ int ecryptfs_keyring_auth_tok_for_sig(struct key **auth_tok_key,
 int ecryptfs_write_lower(struct inode *ecryptfs_inode, char *data,
 			 loff_t offset, size_t size);
 int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
-				      struct page *page_for_lower,
+				      struct folio *folio_for_lower,
 				      size_t offset_in_page, size_t size);
 int ecryptfs_write(struct inode *inode, char *data, loff_t offset, size_t size);
 int ecryptfs_read_lower(char *data, loff_t offset, size_t size,
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index ad535bf9d2f9..acbef67d9c85 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -457,7 +457,7 @@ static int ecryptfs_write_end(struct file *file,
 			"(page w/ index = [0x%.16lx], to = [%d])\n", index, to);
 	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_write_lower_page_segment(ecryptfs_inode,
-				&folio->page, 0, to);
+				folio, 0, to);
 		if (!rc) {
 			rc = copied;
 			fsstack_copy_inode_size(ecryptfs_inode,
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index cddfdfced879..665bcd7d1c8e 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -41,30 +41,29 @@ int ecryptfs_write_lower(struct inode *ecryptfs_inode, char *data,
 /**
  * ecryptfs_write_lower_page_segment
  * @ecryptfs_inode: The eCryptfs inode
- * @page_for_lower: The page containing the data to be written to the
+ * @folio_for_lower: The folio containing the data to be written to the
  *                  lower file
- * @offset_in_page: The offset in the @page_for_lower from which to
+ * @offset_in_page: The offset in the @folio_for_lower from which to
  *                  start writing the data
- * @size: The amount of data from @page_for_lower to write to the
+ * @size: The amount of data from @folio_for_lower to write to the
  *        lower file
  *
  * Determines the byte offset in the file for the given page and
  * offset within the page, maps the page, and makes the call to write
- * the contents of @page_for_lower to the lower inode.
+ * the contents of @folio_for_lower to the lower inode.
  *
  * Returns zero on success; non-zero otherwise
  */
 int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
-				      struct page *page_for_lower,
+				      struct folio *folio_for_lower,
 				      size_t offset_in_page, size_t size)
 {
 	char *virt;
 	loff_t offset;
 	int rc;
 
-	offset = ((((loff_t)page_for_lower->index) << PAGE_SHIFT)
-		  + offset_in_page);
-	virt = kmap_local_page(page_for_lower);
+	offset = (loff_t)folio_for_lower->index * PAGE_SIZE + offset_in_page;
+	virt = kmap_local_folio(folio_for_lower, 0);
 	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
 	if (rc > 0)
 		rc = 0;
@@ -172,7 +171,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 			rc = ecryptfs_encrypt_page(&ecryptfs_folio->page);
 		else
 			rc = ecryptfs_write_lower_page_segment(ecryptfs_inode,
-						&ecryptfs_folio->page,
+						ecryptfs_folio,
 						start_offset_in_page,
 						data_offset);
 		folio_put(ecryptfs_folio);
-- 
2.43.0


