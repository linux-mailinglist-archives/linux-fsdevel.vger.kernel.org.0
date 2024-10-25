Return-Path: <linux-fsdevel+bounces-32936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF459B0DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617521F24FFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD120F3D2;
	Fri, 25 Oct 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AJCIDfM1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550B20D50A;
	Fri, 25 Oct 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883307; cv=none; b=M2vTOqdgaCZCjycMAMBiZx6QbA0cweysFq1/kHslQb3og4EUJ67tVe/NH9hnSsY/U8QhFj08K3d/wH3edHwWmYG76SEFOjIBh61TM71s3LX4248KsT4hZ1mhNs0Bac7vT0AEi38VzxLa9TsytVrY4GD00Nw31gW2E5BjPwbn8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883307; c=relaxed/simple;
	bh=11GVfrGHVGUJ8rEw/ymHMCSa9wpYBo4NA4H0pP1QBbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKoBBJM8P9nFRRW6SRO7EmS9BPnm172ZzsOzg5TLGKszWOA7lIESxClQH2SS99K1A5FduDfVvGuyenuYntxYWrKsw7traYTYJ6qyfirYTnPt6Lw3Xrs/3fb6sBmwwucbEesGNLFIqHDmkndHH55RiVxxzT+2BPI1AD/htL3WeOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AJCIDfM1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=T8anEtHvOl0eVCeTvnZyGUr2OJt/aDQDu9u2v9ejoZQ=; b=AJCIDfM1Y4//I2IqWOQMuU+OU5
	wgJSfg9s47djG8h8IJlKb2kcK0P2rvHvA7OUMjuMPy0DOzrEBJkb6Za041WLXsEZSlk1UEeC1SaAM
	UTP5g2NngRJcFNHf9toiYadk/4Wo6uRN8spmHhjjpQQGM7E6Clzc8M1Bpb1+iY/tpWcPyGPH/DMRl
	UwlT6oyt+nfWYzVzPZ1TpB/7mhfk/Jd5RD3c2Sc4BGJuv14LterHziIjPNNNU0kp+4kWBWiK6huBN
	tcHwFtmMR5Q/fJ190F2V+2wPpE1hCdQzT9RhPxDN7Bw9XXLKDDLU7qAw5LoXDZe7AcSj8Eu5Vv+qK
	vF+MmBMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfc-00000005XBU-11Q3;
	Fri, 25 Oct 2024 19:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/10] ecryptfs: Convert ecryptfs_encrypt_page() to take a folio
Date: Fri, 25 Oct 2024 20:08:17 +0100
Message-ID: <20241025190822.1319162-8-willy@infradead.org>
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

All three callers have a folio, so pass it in and use it throughout.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/crypto.c          | 12 ++++++------
 fs/ecryptfs/ecryptfs_kernel.h |  2 +-
 fs/ecryptfs/mmap.c            |  4 ++--
 fs/ecryptfs/read_write.c      |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 827278525fd9..995ae3a97d52 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -392,7 +392,7 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 
 /**
  * ecryptfs_encrypt_page
- * @page: Page mapped from the eCryptfs inode for the file; contains
+ * @folio: Folio mapped from the eCryptfs inode for the file; contains
  *        decrypted content that needs to be encrypted (to a temporary
  *        page; not in place) and written out to the lower file
  *
@@ -406,7 +406,7 @@ static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
  *
  * Returns zero on success; negative on error
  */
-int ecryptfs_encrypt_page(struct page *page)
+int ecryptfs_encrypt_page(struct folio *folio)
 {
 	struct inode *ecryptfs_inode;
 	struct ecryptfs_crypt_stat *crypt_stat;
@@ -416,7 +416,7 @@ int ecryptfs_encrypt_page(struct page *page)
 	loff_t lower_offset;
 	int rc = 0;
 
-	ecryptfs_inode = page->mapping->host;
+	ecryptfs_inode = folio->mapping->host;
 	crypt_stat =
 		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
 	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
@@ -431,8 +431,8 @@ int ecryptfs_encrypt_page(struct page *page)
 	for (extent_offset = 0;
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
-		rc = crypt_extent(crypt_stat, enc_extent_page, page,
-				  extent_offset, ENCRYPT);
+		rc = crypt_extent(crypt_stat, enc_extent_page,
+				folio_page(folio, 0), extent_offset, ENCRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
@@ -440,7 +440,7 @@ int ecryptfs_encrypt_page(struct page *page)
 		}
 	}
 
-	lower_offset = lower_offset_for_page(crypt_stat, page);
+	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
 	enc_extent_virt = kmap_local_page(enc_extent_page);
 	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
 				  PAGE_SIZE);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 0cac8d3155ae..bffced0c1d8f 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -569,7 +569,7 @@ void ecryptfs_destroy_mount_crypt_stat(
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat);
 int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_write_inode_size_to_metadata(struct inode *ecryptfs_inode);
-int ecryptfs_encrypt_page(struct page *page);
+int ecryptfs_encrypt_page(struct folio *folio);
 int ecryptfs_decrypt_page(struct page *page);
 int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
 			    struct inode *ecryptfs_inode);
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 1c1eb9437505..b2c22f49ef6f 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -34,7 +34,7 @@ static int ecryptfs_writepages(struct address_space *mapping,
 	int error;
 
 	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
-		error = ecryptfs_encrypt_page(&folio->page);
+		error = ecryptfs_encrypt_page(folio);
 		if (error) {
 			ecryptfs_printk(KERN_WARNING,
 				"Error encrypting folio (index [0x%.16lx])\n",
@@ -476,7 +476,7 @@ static int ecryptfs_write_end(struct file *file,
 			"zeros in page with index = [0x%.16lx]\n", index);
 		goto out;
 	}
-	rc = ecryptfs_encrypt_page(&folio->page);
+	rc = ecryptfs_encrypt_page(folio);
 	if (rc) {
 		ecryptfs_printk(KERN_WARNING, "Error encrypting page (upper "
 				"index [0x%.16lx])\n", index);
diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
index 665bcd7d1c8e..b3b451c2b941 100644
--- a/fs/ecryptfs/read_write.c
+++ b/fs/ecryptfs/read_write.c
@@ -168,7 +168,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
 		folio_mark_uptodate(ecryptfs_folio);
 		folio_unlock(ecryptfs_folio);
 		if (crypt_stat->flags & ECRYPTFS_ENCRYPTED)
-			rc = ecryptfs_encrypt_page(&ecryptfs_folio->page);
+			rc = ecryptfs_encrypt_page(ecryptfs_folio);
 		else
 			rc = ecryptfs_write_lower_page_segment(ecryptfs_inode,
 						ecryptfs_folio,
-- 
2.43.0


