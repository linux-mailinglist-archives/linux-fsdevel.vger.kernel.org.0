Return-Path: <linux-fsdevel+bounces-32939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE09B0DF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688FE283EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BA20F3DC;
	Fri, 25 Oct 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfAGQyV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5A20D51B;
	Fri, 25 Oct 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883308; cv=none; b=iCn/AnzFvp3lWc0WkTF1JtaBf8E+7MXcRnOB7DT/cIhGU6/psJIPVZ+MD2nzGy71AaEDC88fTaQ4rUDP+Lq3bXrts0b4kviGcRhxt9vrMeP12mnjPgvsyUh/D6sr92EcpluTjNX7RRr61xhRXKqdSFyHVp4CNp61m/WZ1MOukiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883308; c=relaxed/simple;
	bh=zCtwuMGfmVQ+CLZLLhLQfjj/Ev/qC8lmWla36qaB6U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eq56lzgR0S+QhUcCWqkeDLrHmjABiNjjHnlSOBx0JE+Rsm6dYebLiSunTT2eTrinXPTAsfPrCAw25OE/OcslRagqXByLQBW5cvV0sTOA4YGW3caFiDWW6LvkCEW91ObueZ2/b5tOnvPXcWCqz6VP9Cq+N/CFcytVljyUpT/8R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UfAGQyV1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YGh8Qx+cNNRKdyZI9uSuxmcBFtJTd/xUnCbR88szoos=; b=UfAGQyV1ePC6yT2TRgOYsU2JJd
	7wIVlkN56X0NPqHb0V87alZzeRFSegPgGRMDkXmcBuMObDHa8v4hkBrfmExNVBLd9Zv/x78ANw5V3
	2nBGcVzhX1IHOUmORmCHD6/ck5sDmskvdSSZE9xzbVgCUqKjK37yg0fb50QnvFWinsmg2owYWo05y
	GeuHs5fC3BwmO/uzL9+BYbL6hCxDXMC1ocDhw8aiOJuY1h2hYpZny/9QEa12ZdYzff1mA3Zn7Hzof
	fDiPsM3n6BIMKH7ZaHpmahpmoeokzypU5CzvRVX1kePzYcpY4Xr0Ydz3W73pUoCQ6rpkVwmHn4a9v
	6tPMWmJw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfc-00000005XBb-1eTu;
	Fri, 25 Oct 2024 19:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/10] ecryptfs: Convert ecryptfs_decrypt_page() to take a folio
Date: Fri, 25 Oct 2024 20:08:18 +0100
Message-ID: <20241025190822.1319162-9-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241025190822.1319162-1-willy@infradead.org>
References: <20241025190822.1319162-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both callers have a folio, so pass it in and use it throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/crypto.c          | 11 ++++++-----
 fs/ecryptfs/ecryptfs_kernel.h |  2 +-
 fs/ecryptfs/mmap.c            |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 995ae3a97d52..90d38da20f5c 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -461,7 +461,7 @@ int ecryptfs_encrypt_page(struct folio *folio)
 
 /**
  * ecryptfs_decrypt_page
- * @page: Page mapped from the eCryptfs inode for the file; data read
+ * @folio: Folio mapped from the eCryptfs inode for the file; data read
  *        and decrypted from the lower file will be written into this
  *        page
  *
@@ -475,7 +475,7 @@ int ecryptfs_encrypt_page(struct folio *folio)
  *
  * Returns zero on success; negative on error
  */
-int ecryptfs_decrypt_page(struct page *page)
+int ecryptfs_decrypt_page(struct folio *folio)
 {
 	struct inode *ecryptfs_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
@@ -484,13 +484,13 @@ int ecryptfs_decrypt_page(struct page *page)
 	loff_t lower_offset;
 	int rc = 0;
 
-	ecryptfs_inode = page->mapping->host;
+	ecryptfs_inode = folio->mapping->host;
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
 
-	lower_offset = lower_offset_for_page(crypt_stat, page);
-	page_virt = kmap_local_page(page);
+	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
+	page_virt = kmap_local_folio(folio, 0);
 	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
 				 ecryptfs_inode);
 	kunmap_local(page_virt);
@@ -504,6 +504,7 @@ int ecryptfs_decrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
+		struct page *page = folio_page(folio, 0);
 		rc = crypt_extent(crypt_stat, page, page,
 				  extent_offset, DECRYPT);
 		if (rc) {
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index bffced0c1d8f..1f562e75d0e4 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -570,7 +570,7 @@ void ecryptfs_destroy_mount_crypt_stat(
 int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_write_inode_size_to_metadata(struct inode *ecryptfs_inode);
 int ecryptfs_encrypt_page(struct folio *folio);
-int ecryptfs_decrypt_page(struct page *page);
+int ecryptfs_decrypt_page(struct folio *folio);
 int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 			    struct inode *ecryptfs_inode);
 int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry);
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index b2c22f49ef6f..60f0ac8744b5 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -194,7 +194,7 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
 			}
 		}
 	} else {
-		err = ecryptfs_decrypt_page(&folio->page);
+		err = ecryptfs_decrypt_page(folio);
 		if (err) {
 			ecryptfs_printk(KERN_ERR, "Error decrypting page; "
 					"err = [%d]\n", err);
@@ -305,7 +305,7 @@ static int ecryptfs_write_begin(struct file *file,
 				folio_zero_range(folio, 0, PAGE_SIZE);
 				folio_mark_uptodate(folio);
 			} else if (len < PAGE_SIZE) {
-				rc = ecryptfs_decrypt_page(&folio->page);
+				rc = ecryptfs_decrypt_page(folio);
 				if (rc) {
 					printk(KERN_ERR "%s: Error decrypting "
 					       "page at index [%ld]; "
-- 
2.43.0


