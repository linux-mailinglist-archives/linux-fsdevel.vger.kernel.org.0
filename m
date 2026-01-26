Return-Path: <linux-fsdevel+bounces-75410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ez7MjTzdmkzZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:53:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0CE83FA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6527B3009B19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802E30E0EE;
	Mon, 26 Jan 2026 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXbuSRAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6F30AAD4;
	Mon, 26 Jan 2026 04:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403180; cv=none; b=nYBSJdu2jbhcm6CpyqRkbP2k9zbcFzanG5illGH74Jmvy/n4EDLl66X7Opqs1asy65FpYEdrnBOiYv7Evpei1leWee4kIg9n1dDHfOGz61jrW9sqVjXc+RGnqyEbt5F9HCq8szB1YJ9sn1dVP6aF19ti9NudDlvzUNXcoWZ38RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403180; c=relaxed/simple;
	bh=nz47f+eG2mOWGsqLj0Lbs7Ssa0WMvARWcfYUKbqXEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orladZ/F2mGSplJZYY6gdTvlDHSOZW0ZnerQtd/+crE/LNHANfwHnhWUKR8GsG9W021qf7oZ7yaH+jY4eONa6Cb/lL/+TjPWuX/V+Y+21pGiC8F3V0MsaFqM+/wQ4+J81SqIxlSV+EQosh9XO/QSA4W2plhxAKw2LeitUvrAfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZXbuSRAM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EhBe7oamcMMVXug9LQco1l9vpQaggvXhJCwow1JM8vs=; b=ZXbuSRAMcpiGfEu5tc3u8ieFbJ
	J/c55KCKB2EfFKTy8X9jp320OObs+gsLtjZ9pQnzKPIIiHdUsiEfhRczWNOofJo8KDY+vMgU7q19G
	7IuAJ6HrU1YVrxy9HqURHYC7X/TFpsyiFQoGzB+rNxVZwhr9mSCZoto83Q15Wg8x3hvlXeUxFHt+U
	oD9Hro2RUp3VI/wBar9RFrr7WT8KrjBU+uDzDJPd9WVNQE16Az4SDL+01i1xVSazY3K/CbLLLFqDi
	CNaQ5HWCeTlb3wwuJBwxBWAbD516zh/N+5CyQYNKEvVLKJu9VGAN+0TYIkU+CJVYzG4xHTLL40DAN
	o30jrKVw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEat-0000000BuRD-09Gs;
	Mon, 26 Jan 2026 04:52:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 06/16] fsverity: start consolidating pagecache code
Date: Mon, 26 Jan 2026 05:50:52 +0100
Message-ID: <20260126045212.1381843-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126045212.1381843-1-hch@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75410-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 8A0CE83FA7
X-Rspamd-Action: no action

ext4 and f2fs are largely using the same code to read a page full
of Merkle tree blocks from the page cache, and the upcoming xfs
fsverity support would add another copy.

Move the ext4 code to fs/verity/ and use it in f2fs as well.  For f2fs
this removes the previous f2fs-specific error injection, but otherwise
the behavior remains unchanged.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/verity.c         | 17 +----------------
 fs/f2fs/verity.c         | 17 +----------------
 fs/verity/Makefile       |  1 +
 fs/verity/pagecache.c    | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/fsverity.h |  3 +++
 5 files changed, 44 insertions(+), 32 deletions(-)
 create mode 100644 fs/verity/pagecache.c

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 2ce4cf8a1e31..a071860ad36a 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -361,23 +361,8 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	struct folio *folio;
-
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
-
-	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
-		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
-
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
-	}
-	return folio_file_page(folio, index);
+	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
 }
 
 static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index c1c4d8044681..d37e584423af 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -259,23 +259,8 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	struct folio *folio;
-
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
-
-	folio = f2fs_filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
-		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
-
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
-	}
-	return folio_file_page(folio, index);
+	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
 }
 
 static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
diff --git a/fs/verity/Makefile b/fs/verity/Makefile
index 435559a4fa9e..ddb4a88a0d60 100644
--- a/fs/verity/Makefile
+++ b/fs/verity/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_FS_VERITY) += enable.o \
 			   init.o \
 			   measure.o \
 			   open.o \
+			   pagecache.o \
 			   read_metadata.o \
 			   verify.o
 
diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
new file mode 100644
index 000000000000..1efcdde20b73
--- /dev/null
+++ b/fs/verity/pagecache.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/fsverity.h>
+#include <linux/pagemap.h>
+
+/**
+ * generic_read_merkle_tree_page - generic ->read_merkle_tree_page helper
+ * @inode:	inode containing the Merkle tree
+ * @index:	0-based index of the page in the inode
+ * @num_ra_pages: The number of Merkle tree pages that should be prefetched.
+ *
+ * The caller needs to adjust @index from the Merkle-tree relative index passed
+ * to ->read_merkle_tree_page to the actual index where the Merkle tree is
+ * stored in the page cache for @inode.
+ */
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
+		unsigned long num_ra_pages)
+{
+	struct folio *folio;
+
+	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
+
+		if (!IS_ERR(folio))
+			folio_put(folio);
+		else if (num_ra_pages > 1)
+			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
+		folio = read_mapping_folio(inode->i_mapping, index, NULL);
+		if (IS_ERR(folio))
+			return ERR_CAST(folio);
+	}
+	return folio_file_page(folio, index);
+}
+EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index e22cf84fe83a..121703625cc8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -309,4 +309,7 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 
 void fsverity_cleanup_inode(struct inode *inode);
 
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
+		unsigned long num_ra_pages);
+
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3


