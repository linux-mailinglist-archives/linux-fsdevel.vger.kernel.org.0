Return-Path: <linux-fsdevel+bounces-75734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBSNJgwremmi3gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:28:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5206FA3CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E9A1301297C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5702C36C0AF;
	Wed, 28 Jan 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FQXZqcmD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E436C0DF;
	Wed, 28 Jan 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614052; cv=none; b=C4efGk1ei4KGMYyYKdjBhciH71q8rc1psNDa+5/D1AIHgIsnYetvWz4vFfl1f/rXg0K7U+3SneNL907Hz3PX/7v2GHQ/Vh3MhkTXPAY8umP08+FZGfX+PLhD1RQzX2rHTBsE6CGxpYFo3G9/QdvjuxOuzpdpqIX/3mbF4QMOLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614052; c=relaxed/simple;
	bh=JEMPr/TQiOUlwmUg4oMtD0YMHww2RjcIiNef9y0Y3SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AL7N6JvTmAUNwul28mJXFa3eVd8V1lyCsuXR6Mx9B4kSEpjaMoMX5RDnrZvB8diVTrkbP0fCzr6kjIs+4SL1KOIleKiEmHjX74bg17KaWly/S7e4sV1vV3on0G0DQMsmrlOn6EzeIkXt7I9VUkibU3qiLw+qDKZFoakydrJdrUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FQXZqcmD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hUAqEc59OqndWFQYZRxKv7dVUe5Vgp361WDh/DQTsVE=; b=FQXZqcmDLkw4PxhiZ4rX8hq5s0
	X4YQJyGhSEz2Zmv4nwlN9OaV+Sd0zSDuR90vWcnaWbUP2DwnCtPT/lCk+EB29c+ul5zUlWaFNB4np
	PPz34IWwEjNr+JE9YlQ5ZW6rzXN/rPBJq68mPF6hHTgH7YxRO57bM4CXXLAuTRmhyyOuBhENM5axX
	Diim7PpbZW73Cxpudf/58gHedTNLRFAYfXtrZmYvXCfF4UNGEjLvZviHO5FH2BRIB2/faWO7xpzCc
	O+FwKwV7FMmHPm/NHwaaOLMMoP1KbHu9KmBmvwX07LhvyY5ZMznwJOEu/iIZP2FyJtEKcvhayG3Pa
	g36Ox2Bw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl7S1-0000000GHQh-1Rje;
	Wed, 28 Jan 2026 15:27:25 +0000
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
Subject: [PATCH 06/15] fsverity: start consolidating pagecache code
Date: Wed, 28 Jan 2026 16:26:18 +0100
Message-ID: <20260128152630.627409-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-75734-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5206FA3CE2
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
index 000000000000..f67248e9e768
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
+ * @index:	0-based index of the Merkle tree page in the inode
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


