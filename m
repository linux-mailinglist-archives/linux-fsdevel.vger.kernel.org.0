Return-Path: <linux-fsdevel+bounces-42209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A386A3EC1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 06:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB3017C165
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 05:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F7E1F91E3;
	Fri, 21 Feb 2025 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SC2sv7j9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810B8F6E;
	Fri, 21 Feb 2025 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114626; cv=none; b=EXlXyEFfIo6ii/PxPeiKwFd3b9bg84YT+V+ECmcWMnxaGweE6Ix00rkAbRqjM9+xtw2AJGI6dDmG1NogZAjhswoDc6qTkxBg/SpER7Z94++Em+/EmH+J6izCUZlvdHTnLmEzu0R/v7BNlKEb49WiBVG4nKKms0vb5Fvpnsssp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114626; c=relaxed/simple;
	bh=Y+KEQSomeCuOnICaelCR3a2F1Xyz9i+ZqNRv4/h5tRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/uPiywq/sgRR1bEQmF8AHiyZDt3iYOG0v1+XevRBl74sJP/IqrFs0OowB0EJmgcnxCTyQyV0vd7ICcO3a+XdbUAd9GDQgJML2VqLi3eGd+KbdyLXAFdIxRlB2VQFZ5VddGzT3bEZQG/hj1xpkF9PJvYxw7IdPRBiGjqOx4OOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SC2sv7j9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2sT5Bwmq+loVho4uTYpFiQsHLv4jx9APh3hIPdunmaQ=; b=SC2sv7j9scDt6SWD9/wcfkJG+d
	eP4J/nZwDJuyJ06K4U8rh/pixRASbngHfebMaUJMBhgSvTQL+QSHuUX5JOXcj8Y+Y6k6VPNqQWeEU
	SjRiEDXzb3OqWCyvAmsqZLwMXTAGiqK2BMU+/cDw18CteoUhbEd3k2ebr6U6WNpeHWFhR/yDzzTnj
	XpQMLuBnZ+qZd5ytcx7n/mCnaXw0ZG/0ZpGX+1co6mtGI5nkl+7cHAh94I2NFJ7T/UnvvgS6+u8cs
	sYTAft4SorvuPISKGqvSqL+aSJ/bx0SE+x5kndOQqZCY5ptxWmyOaXQVx5GTC5LqIPRJvr94yfYAw
	iZ/zcCSg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlLIk-0000000CNtx-0Nwv;
	Fri, 21 Feb 2025 05:10:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fscrypt@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fscrypt: Change fscrypt_encrypt_pagecache_blocks() to take a folio
Date: Fri, 21 Feb 2025 05:10:01 +0000
Message-ID: <20250221051004.2951759-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4 and ceph already have a folio to pass; f2fs needs to be properly
converted but this will do for now.  This removes a reference
to page->index and page->mapping as well as removing a call to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c          |  4 ++--
 fs/crypto/crypto.c      | 21 +++++++++------------
 fs/ext4/page-io.c       |  2 +-
 fs/f2fs/data.c          |  2 +-
 include/linux/fscrypt.h | 12 ++++--------
 5 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f5224a566b69..9261cd690181 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -753,7 +753,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
-		bounce_page = fscrypt_encrypt_pagecache_blocks(page,
+		bounce_page = fscrypt_encrypt_pagecache_blocks(folio,
 						    CEPH_FSCRYPT_BLOCK_SIZE, 0,
 						    GFP_NOFS);
 		if (IS_ERR(bounce_page)) {
@@ -1186,7 +1186,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			if (IS_ENCRYPTED(inode)) {
 				pages[locked_pages] =
-					fscrypt_encrypt_pagecache_blocks(page,
+					fscrypt_encrypt_pagecache_blocks(folio,
 						PAGE_SIZE, 0,
 						locked_pages ? GFP_NOWAIT : GFP_NOFS);
 				if (IS_ERR(pages[locked_pages])) {
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 328470d40dec..1fbf523632fb 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -153,8 +153,8 @@ int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 }
 
 /**
- * fscrypt_encrypt_pagecache_blocks() - Encrypt data from a pagecache page
- * @page: the locked pagecache page containing the data to encrypt
+ * fscrypt_encrypt_pagecache_blocks() - Encrypt data from a pagecache folio
+ * @folio: the locked pagecache folio containing the data to encrypt
  * @len: size of the data to encrypt, in bytes
  * @offs: offset within @page of the data to encrypt, in bytes
  * @gfp_flags: memory allocation flags; see details below
@@ -177,23 +177,20 @@ int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
  *
  * Return: the new encrypted bounce page on success; an ERR_PTR() on failure
  */
-struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
-					      unsigned int len,
-					      unsigned int offs,
-					      gfp_t gfp_flags)
-
+struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
+		size_t len, size_t offs, gfp_t gfp_flags)
 {
-	const struct inode *inode = page->mapping->host;
+	const struct inode *inode = folio->mapping->host;
 	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
 	const unsigned int du_bits = ci->ci_data_unit_bits;
 	const unsigned int du_size = 1U << du_bits;
 	struct page *ciphertext_page;
-	u64 index = ((u64)page->index << (PAGE_SHIFT - du_bits)) +
+	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
 		    (offs >> du_bits);
 	unsigned int i;
 	int err;
 
-	if (WARN_ON_ONCE(!PageLocked(page)))
+	if (WARN_ON_ONCE(!folio_test_locked(folio)))
 		return ERR_PTR(-EINVAL);
 
 	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, du_size)))
@@ -205,7 +202,7 @@ struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
 
 	for (i = offs; i < offs + len; i += du_size, index++) {
 		err = fscrypt_crypt_data_unit(ci, FS_ENCRYPT, index,
-					      page, ciphertext_page,
+					      &folio->page, ciphertext_page,
 					      du_size, i, gfp_flags);
 		if (err) {
 			fscrypt_free_bounce_page(ciphertext_page);
@@ -213,7 +210,7 @@ struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
 		}
 	}
 	SetPagePrivate(ciphertext_page);
-	set_page_private(ciphertext_page, (unsigned long)page);
+	set_page_private(ciphertext_page, (unsigned long)folio);
 	return ciphertext_page;
 }
 EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 69b8a7221a2b..37abee5016c3 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -522,7 +522,7 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 		if (io->io_bio)
 			gfp_flags = GFP_NOWAIT | __GFP_NOWARN;
 	retry_encrypt:
-		bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page,
+		bounce_page = fscrypt_encrypt_pagecache_blocks(folio,
 					enc_bytes, 0, gfp_flags);
 		if (IS_ERR(bounce_page)) {
 			ret = PTR_ERR(bounce_page);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 24c5cb1f5ada..b6857b4a9787 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2504,7 +2504,7 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 		return 0;
 
 retry_encrypt:
-	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(page,
+	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(page_folio(page),
 					PAGE_SIZE, 0, gfp_flags);
 	if (IS_ERR(fio->encrypted_page)) {
 		/* flush pending IOs and wait for a while in the ENOMEM case */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 18855cb44b1c..56fad33043d5 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -310,10 +310,8 @@ static inline void fscrypt_prepare_dentry(struct dentry *dentry,
 /* crypto.c */
 void fscrypt_enqueue_decrypt_work(struct work_struct *);
 
-struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
-					      unsigned int len,
-					      unsigned int offs,
-					      gfp_t gfp_flags);
+struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
+		size_t len, size_t offs, gfp_t gfp_flags);
 int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num, gfp_t gfp_flags);
@@ -480,10 +478,8 @@ static inline void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 {
 }
 
-static inline struct page *fscrypt_encrypt_pagecache_blocks(struct page *page,
-							    unsigned int len,
-							    unsigned int offs,
-							    gfp_t gfp_flags)
+static inline struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
+		size_t len, size_t offs, gfp_t gfp_flags)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.47.2


