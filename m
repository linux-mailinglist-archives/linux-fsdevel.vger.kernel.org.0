Return-Path: <linux-fsdevel+bounces-74987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H8mErPfcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:28:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB207630D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42BB06C272B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC23806BB;
	Thu, 22 Jan 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2KsvWC3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774034CFBB;
	Thu, 22 Jan 2026 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070175; cv=none; b=RpzE3BAC3KyCLfpXs6NcAxtA1FkFtxwah6i6eBs5e1U3BnzeGjicx+uBuc6aDaLLKsJIqbeLjoymtXHqqX6E5KvUggD+tdLxMETHWKJp7W/zZ88qKxtSRvmVeFPlVbeTY5oSrkur0YOxW/qKahgtL8xurq/PWcqLgHVYanCRbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070175; c=relaxed/simple;
	bh=+nbbVPttq5sh5F6OAj6t7wzb4AUwWW5DIZDdc6V5MNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3ErM1NZR4Oy88CDB4Dwon0h3ohAtVLYqraCnVq/COIJpKK3dujQZuCgd+C8LfIf+XjOhUrnBY3HFevcHLCl1SoUGGsAMP7vz0Yq8RHZzEPSGWRujJ1tjZaNcSG3Iruf9XKycoJojDzhwvF7/LoZt/eZWPK5QW8+FC5MO9XV5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2KsvWC3a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OM9wMzq/llzm5SLdpG00aP7cJ38lRMBcvo9i+eIotIc=; b=2KsvWC3axAJ7UqLz9e2U3lBXe8
	zz7z2hx/WYe8nQxqpZro/Eb6FwDlpoyrEBfbZDwEOKoZICKkSHANrLcD8cg3xqCwbXHPMRIFVHNJB
	B/3Xc1vcmxSz/W+hQgZyydP4JLAQGhLlkOrbQD24Rkcq6bi/Od1SH+Iu65zwNQK26qbfEkyetYeka
	aSoD+A3HvHOw4Na3YB45x39+YcJyIkNpACZQI+0hTqaZUJHEy0LqqEJanPfbLOz7w0wXiDVUOa1bv
	fc9CYYVOxcHNrYtu73zVaMbzDjhknHE7WYdCZ1c4j5L3RLONhJVopNNeVtbqx/C/uoV2ZWS0O1/xI
	4HWnrg9w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vipxq-00000006duK-1lJM;
	Thu, 22 Jan 2026 08:22:50 +0000
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 04/11] fsverity: start consolidating pagecache code
Date: Thu, 22 Jan 2026 09:22:00 +0100
Message-ID: <20260122082214.452153-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122082214.452153-1-hch@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-74987-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: CB207630D4
X-Rspamd-Action: no action

ext4 and f2fs are largely using the same code to read a page full
of Merkle tree blocks from the page cache, and the upcoming xfs
fsverity support would add another copy.

Move the ext4 code to fs/verity/ and use it in f2fs as well.  For f2fs
this removes the previous f2fs-specific error injection, but otherwise
the behavior remains unchanged.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/verity.c         | 17 +----------------
 fs/f2fs/verity.c         | 17 +----------------
 fs/verity/pagecache.c    | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/fsverity.h |  3 +++
 4 files changed, 43 insertions(+), 32 deletions(-)
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


