Return-Path: <linux-fsdevel+bounces-74988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNPJOMLfcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:28:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B46630E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB811508EEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695234CFBB;
	Thu, 22 Jan 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cn55+wN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3537F109;
	Thu, 22 Jan 2026 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070180; cv=none; b=QD01JXOhLr8LAPeVYEfcKOU/5+yOiarIuTtoX3n2VIQlArGF/HvxJcD67h9dFexBsfLZgolKLhn8t/wz/uAEpnW0cuVFGGuLroO/u2UWUheUDwm4TzdRyJFyUJFk349VIltk00QmbYOl0IEKIg91vsRFWXPpcbUqT26rK+DEOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070180; c=relaxed/simple;
	bh=jI6szVBJlQ0wVY3VAQzxFrfl/FolHe4OkOfK/8zKVIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXszhUtQjTX1a6zs+bl9Vl9hhfi5bNH72WgZC+X7VNgE+LLKnsHFOnWDy+tbBvCdOvX5UUnvCqr5WSPMXNQOu8Bp36wboJVmwqkn+mciiCT/VjJmZkyXhyBGQrPlEzxBhj8dX34E00e5kknPm8nWsAkB+62I1ZlPtG9J7bvefLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cn55+wN6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7y1qeEJI0aJnxWZDYyATlWt/iVJdWe2DHWH7Aes3QEw=; b=cn55+wN6cNT6oQmO6xCxJv9ay4
	PGllUKDh3C3/QK5Lms7uZ69M4pWZteUD9fkon0NyaZxGWIUHmWJQcsTGfqktOTHU7ejVH+y26b1IZ
	wWhd6HnN0q6o+9c/dJxhH07CuA94I74NDMPQ5Wrtu5Oro4NGOYnQYNJCP+eyb+3DUir1HxWZVQILQ
	BleaPPVyj5o9KsBkm18xUDwKPGQ+EPMcyXk+1SlwdcWq8PROuAD0/cC5wXfjqJr4sSDfaTpDd+qaf
	1TMzy0klZFX4WPlCfdLzO49W6SbO77lG0a7djC3Nwf4cxk6h5pA+XDZFHWKGqsfSRZOMpDlv/FRnD
	eWHuj6pQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vipxv-00000006dud-14xE;
	Thu, 22 Jan 2026 08:22:55 +0000
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
Subject: [PATCH 05/11] fsverity: kick off hash readahead at data I/O submission time
Date: Thu, 22 Jan 2026 09:22:01 +0100
Message-ID: <20260122082214.452153-6-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-74988-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim]
X-Rspamd-Queue-Id: 81B46630E2
X-Rspamd-Action: no action

Currently all reads of the fsverity hashes is kicked off from the data
I/O completion handler, leading to needlessly dependent I/O.  This is
worked around a bit by performing readahead on the level 0 nodes, but
still fairly ineffective.

Switch to a model where the ->read_folio and ->readahead methods instead
kick off explicit readahead of the fsverity hashed so they are usually
available at I/O completion time.

For 64k sequential reads on my test VM this improves read performance
from 2.4GB/s - 2.6GB/s to 3.5GB/s - 3.9GB/s.  The improvements for
random reads are likely to be even bigger.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/verity.c            |  4 +-
 fs/ext4/readpage.c           |  7 +++
 fs/ext4/verity.c             | 13 ++++--
 fs/f2fs/data.c               |  7 +++
 fs/f2fs/verity.c             | 13 ++++--
 fs/verity/Makefile           |  3 +-
 fs/verity/fsverity_private.h |  2 +
 fs/verity/pagecache.c        | 41 ++++++++++++------
 fs/verity/read_metadata.c    | 10 ++---
 fs/verity/verify.c           | 82 ++++++++++++++++++++++++------------
 include/linux/fsverity.h     | 29 +++++++++----
 11 files changed, 149 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index e7643c22a6bf..c152bef71e8b 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -697,7 +697,6 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  *
  * @inode:         inode to read a merkle tree page for
  * @index:         page index relative to the start of the merkle tree
- * @num_ra_pages:  number of pages to readahead. Optional, we ignore it
  *
  * The Merkle tree is stored in the filesystem btree, but its pages are cached
  * with a logical position past EOF in the inode's mapping.
@@ -705,8 +704,7 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  * Returns the page we read, or an ERR_PTR on error.
  */
 static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
-						pgoff_t index,
-						unsigned long num_ra_pages)
+						pgoff_t index)
 {
 	struct folio *folio;
 	u64 off = (u64)index << PAGE_SHIFT;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index e7f2350c725b..574584123b8a 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -226,6 +226,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
 	unsigned int nr_pages, folio_pages;
+	bool first_folio = true;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -241,6 +242,12 @@ int ext4_mpage_readpages(struct inode *inode,
 		if (rac)
 			folio = readahead_folio(rac);
 
+		if (first_folio) {
+			if (ext4_need_verity(inode, folio->index))
+				fsverity_readahead(folio, nr_pages);
+			first_folio = false;
+		}
+
 		folio_pages = folio_nr_pages(folio);
 		prefetchw(&folio->flags);
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index a071860ad36a..54ae4d4a176c 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -358,11 +358,17 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 }
 
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       pgoff_t index)
 {
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
-	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
+	return generic_read_merkle_tree_page(inode, index);
+}
+
+static void ext4_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
+{
+	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
+	generic_readahead_merkle_tree(inode, index, nr_pages);
 }
 
 static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
@@ -380,5 +386,6 @@ const struct fsverity_operations ext4_verityops = {
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,
 	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
+	.readahead_merkle_tree	= ext4_readahead_merkle_tree,
 	.write_merkle_tree_block = ext4_write_merkle_tree_block,
 };
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c30e69392a62..49bdc7e771f2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2359,6 +2359,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
+	bool first_folio = true;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
@@ -2383,6 +2384,12 @@ static int f2fs_mpage_readpages(struct inode *inode,
 			prefetchw(&folio->flags);
 		}
 
+		if (first_folio) {
+			if (f2fs_need_verity(inode, folio->index))
+				fsverity_readahead(folio, nr_pages);
+			first_folio = false;
+		}
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		index = folio->index;
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index d37e584423af..628e8eafa96a 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -256,11 +256,17 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 }
 
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       pgoff_t index)
 {
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
-	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
+	return generic_read_merkle_tree_page(inode, index);
+}
+
+static void f2fs_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
+{
+	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
+	generic_readahead_merkle_tree(inode, index, nr_pages);
 }
 
 static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
@@ -278,5 +284,6 @@ const struct fsverity_operations f2fs_verityops = {
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,
 	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
+	.readahead_merkle_tree	= f2fs_readahead_merkle_tree,
 	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
 };
diff --git a/fs/verity/Makefile b/fs/verity/Makefile
index 435559a4fa9e..2475d72ff861 100644
--- a/fs/verity/Makefile
+++ b/fs/verity/Makefile
@@ -5,7 +5,8 @@ obj-$(CONFIG_FS_VERITY) += enable.o \
 			   init.o \
 			   measure.o \
 			   open.o \
+			   pagecache.o \
 			   read_metadata.o \
-			   verify.o
+			   verify.o \
 
 obj-$(CONFIG_FS_VERITY_BUILTIN_SIGNATURES) += signature.o
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index dd20b138d452..9018b71b3b23 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -159,6 +159,8 @@ static inline void fsverity_init_signature(void)
 
 /* verify.c */
 
+void __fsverity_readahead(struct inode *inode, const struct fsverity_info *vi,
+		loff_t data_start_pos, unsigned long nr_pages);
 void __init fsverity_init_workqueue(void);
 
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 1efcdde20b73..53cbf27f9fed 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -10,29 +10,44 @@
  * generic_read_merkle_tree_page - generic ->read_merkle_tree_page helper
  * @inode:	inode containing the Merkle tree
  * @index:	0-based index of the page in the inode
- * @num_ra_pages: The number of Merkle tree pages that should be prefetched.
  *
  * The caller needs to adjust @index from the Merkle-tree relative index passed
  * to ->read_merkle_tree_page to the actual index where the Merkle tree is
  * stored in the page cache for @inode.
  */
-struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
-		unsigned long num_ra_pages)
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index)
+{
+	struct folio *folio;
+
+	folio = read_mapping_folio(inode->i_mapping, index, NULL);
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
+	return folio_file_page(folio, index);
+}
+EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
+
+/**
+ * generic_readahead_merkle_tree() - generic ->readahead_merkle_tree helper
+ * @inode:	inode containing the Merkle tree
+ * @index:	0-based index of the first page to read ahead in the inode
+ * @nr_pages:	number of data pages to read ahead
+ *
+ * The caller needs to adjust @index from the Merkle-tree relative index passed
+ * to ->read_merkle_tree_page to the actual index where the Merkle tree is
+ * stored in the page cache for @inode.
+ */
+void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
 {
 	struct folio *folio;
 
 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+	if (PTR_ERR(folio) == -ENOENT || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
+		page_cache_ra_unbounded(&ractl, nr_pages, 0);
 	}
-	return folio_file_page(folio, index);
+	if (!IS_ERR(folio))
+		folio_put(folio);
 }
-EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
+EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index cba5d6af4e04..430306abc4c6 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -28,24 +28,24 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 	if (offset >= end_offset)
 		return 0;
 	offs_in_page = offset_in_page(offset);
+	index = offset >> PAGE_SHIFT;
 	last_index = (end_offset - 1) >> PAGE_SHIFT;
 
+	__fsverity_readahead(inode, vi, offset, last_index - index + 1);
+
 	/*
 	 * Iterate through each Merkle tree page in the requested range and copy
 	 * the requested portion to userspace.  Note that the Merkle tree block
 	 * size isn't important here, as we are returning a byte stream; i.e.,
 	 * we can just work with pages even if the tree block size != PAGE_SIZE.
 	 */
-	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
-		unsigned long num_ra_pages =
-			min_t(unsigned long, last_index - index + 1,
-			      inode->i_sb->s_bdi->io_pages);
+	for (; index <= last_index; index++) {
 		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
 						   PAGE_SIZE - offs_in_page);
 		struct page *page;
 		const void *virt;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
+		page = vops->read_merkle_tree_page(inode, index);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 86067c8b40cf..7ccd906e2b28 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -9,6 +9,7 @@
 
 #include <linux/bio.h>
 #include <linux/export.h>
+#include <linux/pagemap.h>
 
 #define FS_VERITY_MAX_PENDING_BLOCKS 2
 
@@ -21,7 +22,6 @@ struct fsverity_pending_block {
 struct fsverity_verification_context {
 	struct inode *inode;
 	struct fsverity_info *vi;
-	unsigned long max_ra_pages;
 
 	/*
 	 * This is the queue of data blocks that are pending verification.  When
@@ -37,6 +37,55 @@ struct fsverity_verification_context {
 
 static struct workqueue_struct *fsverity_read_workqueue;
 
+void __fsverity_readahead(struct inode *inode, const struct fsverity_info *vi,
+		loff_t data_start_pos, unsigned long nr_pages)
+{
+	const struct merkle_tree_params *params = &vi->tree_params;
+	u64 start_hidx = data_start_pos >> params->log_blocksize;
+	u64 end_hidx = (data_start_pos + ((nr_pages - 1) << PAGE_SHIFT)) >>
+			params->log_blocksize;
+	int level;
+
+	if (!inode->i_sb->s_vop->readahead_merkle_tree)
+		return;
+	if (unlikely(data_start_pos >= inode->i_size))
+		return;
+
+	for (level = 0; level < params->num_levels; level++) {
+		unsigned long level_start = params->level_start[level];
+		unsigned long next_start_hidx = start_hidx >> params->log_arity;
+		unsigned long next_end_hidx = end_hidx >> params->log_arity;
+		unsigned long start_idx = (level_start + next_start_hidx) >>
+				params->log_blocks_per_page;
+		unsigned long end_idx = (level_start + next_end_hidx) >>
+				params->log_blocks_per_page;
+
+		inode->i_sb->s_vop->readahead_merkle_tree(inode, start_idx,
+				end_idx - start_idx + 1);
+
+		start_hidx = next_start_hidx;
+		end_hidx = next_end_hidx;
+	}
+}
+EXPORT_SYMBOL_GPL(fsverity_readahead);
+
+/**
+ * fsverity_readahead() - kick off readahead on fsverity hashes
+ * @folio:		first folio that is being read
+ * @nr_pages:		number of data pages to read
+ *
+ * Start readahead on fsverity hashes.  To be called from the file systems
+ * ->read_folio and ->readahead methods to ensure that the hashes are
+ * already cached on completion of the file data read if possible.
+ */
+void fsverity_readahead(struct folio *folio, unsigned long nr_pages)
+{
+	struct inode *inode = folio->mapping->host;
+
+	return __fsverity_readahead(inode, *fsverity_info_addr(inode),
+			folio_pos(folio), nr_pages);
+}
+
 /*
  * Returns true if the hash block with index @hblock_idx in the tree, located in
  * @hpage, has already been verified.
@@ -114,8 +163,7 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
  * Return: %true if the data block is valid, else %false.
  */
 static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
-			      const struct fsverity_pending_block *dblock,
-			      unsigned long max_ra_pages)
+			      const struct fsverity_pending_block *dblock)
 {
 	const u64 data_pos = dblock->pos;
 	const struct merkle_tree_params *params = &vi->tree_params;
@@ -200,8 +248,7 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			  (params->block_size - 1);
 
 		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
-				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
+				hpage_idx);
 		if (IS_ERR(hpage)) {
 			fsverity_err(inode,
 				     "Error %ld reading Merkle tree page %lu",
@@ -272,14 +319,12 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 
 static void
 fsverity_init_verification_context(struct fsverity_verification_context *ctx,
-				   struct inode *inode,
-				   unsigned long max_ra_pages)
+				   struct inode *inode)
 {
 	struct fsverity_info *vi = *fsverity_info_addr(inode);
 
 	ctx->inode = inode;
 	ctx->vi = vi;
-	ctx->max_ra_pages = max_ra_pages;
 	ctx->num_pending = 0;
 	if (vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
 	    sha256_finup_2x_is_optimized())
@@ -322,8 +367,7 @@ fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
 	}
 
 	for (i = 0; i < ctx->num_pending; i++) {
-		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i],
-				       ctx->max_ra_pages))
+		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i]))
 			return false;
 	}
 	fsverity_clear_pending_blocks(ctx);
@@ -373,7 +417,7 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
 {
 	struct fsverity_verification_context ctx;
 
-	fsverity_init_verification_context(&ctx, folio->mapping->host, 0);
+	fsverity_init_verification_context(&ctx, folio->mapping->host);
 
 	if (fsverity_add_data_blocks(&ctx, folio, len, offset) &&
 	    fsverity_verify_pending_blocks(&ctx))
@@ -403,22 +447,8 @@ void fsverity_verify_bio(struct bio *bio)
 	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
-	unsigned long max_ra_pages = 0;
-
-	if (bio->bi_opf & REQ_RAHEAD) {
-		/*
-		 * If this bio is for data readahead, then we also do readahead
-		 * of the first (largest) level of the Merkle tree.  Namely,
-		 * when a Merkle tree page is read, we also try to piggy-back on
-		 * some additional pages -- up to 1/4 the number of data pages.
-		 *
-		 * This improves sequential read performance, as it greatly
-		 * reduces the number of I/O requests made to the Merkle tree.
-		 */
-		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
-	}
 
-	fsverity_init_verification_context(&ctx, inode, max_ra_pages);
+	fsverity_init_verification_context(&ctx, inode);
 
 	bio_for_each_folio_all(fi, bio) {
 		if (!fsverity_add_data_blocks(&ctx, fi.folio, fi.length,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 121703625cc8..862fea8a2eb1 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -97,10 +97,6 @@ struct fsverity_operations {
 	 *
 	 * @inode: the inode
 	 * @index: 0-based index of the page within the Merkle tree
-	 * @num_ra_pages: The number of Merkle tree pages that should be
-	 *		  prefetched starting at @index if the page at @index
-	 *		  isn't already cached.  Implementations may ignore this
-	 *		  argument; it's only a performance optimization.
 	 *
 	 * This can be called at any time on an open verity file.  It may be
 	 * called by multiple processes concurrently, even with the same page.
@@ -110,8 +106,23 @@ struct fsverity_operations {
 	 * Return: the page on success, ERR_PTR() on failure
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
-					      pgoff_t index,
-					      unsigned long num_ra_pages);
+					      pgoff_t index);
+
+	/**
+	 * Perform readahad of a Merkle tree for the given inode.
+	 *
+	 * @inode: the inode
+	 * @index: 0-based index of the first page within the Merkle tree
+	 * @nr_pages: number of pages to be read ahead.
+	 *
+	 * This can be called at any time on an open verity file.  It may be
+	 * called by multiple processes concurrently, even with the same range.
+	 *
+	 * Optional method so that ->read_merkle_tree_page preferably finds
+	 * cached data instead of issuing dependent I/O.
+	 */
+	void (*readahead_merkle_tree)(struct inode *inode, pgoff_t index,
+			unsigned long nr_pages);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
@@ -308,8 +319,10 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 }
 
 void fsverity_cleanup_inode(struct inode *inode);
+void fsverity_readahead(struct folio *folio, unsigned long nr_pages);
 
-struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
-		unsigned long num_ra_pages);
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index);
+void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages);
 
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3


