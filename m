Return-Path: <linux-fsdevel+bounces-64388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE9BE5235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 20:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848635881AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD6B1D5178;
	Thu, 16 Oct 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWyXI8Fa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC324469E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641132; cv=none; b=OSMSP7dGkAobawW742tmm4bAFo6kknqXu+WgQhmgfZE0nqtIgEKeTV+3uPz1S/UpWfGjpTvZeUEQnLTXRw8FPPyj4QWvJc4rnOYCTr3mI/IbMS7DhaJhYJ7Ar8Cs8oOAwjCNURXtG58zvS1P+c/xApRkZJArvmFJ9iUinL1vIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641132; c=relaxed/simple;
	bh=0Mwy6LMg5ewiUyidlNHppLk+BVWKK41lv07Oe87IyfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufT2bqsvkVNkJ3U6nKJgds16P9obL1yAnTXmopa9WIx81oxd7ojKdDzfZyERtrTECzKuPn1j74PgSHgQ4wEZGYal4s/n6PXKMP0FoEqdAgVaOQNfGGfrbBDrboi0uBu+JWNWN4FjBXSimjgTO4FenFpvegJFLOzdhjgPUcLLw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWyXI8Fa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760641129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy6tmhxaR9wjwXMR0S04ipHrreqKm9/Godd7oQDj0iw=;
	b=DWyXI8FakO70VG4mp4u4SE5z7Kd9KwdC1pRfEUk9e0nFYxeHYmAZwKOttgL5xYkU5An9FL
	AvQWqmzcunDDUWulaBBLbHzMIcomBAjqBx8cOqYoq2XRXiNolZwXzHMiMQ260JdooTVVz/
	mDL5wIM4GGH4VlWlgEHDgyHFW6JHxsk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-9ZOG_KT2OFaNHv-OpoBlmQ-1; Thu,
 16 Oct 2025 14:58:45 -0400
X-MC-Unique: 9ZOG_KT2OFaNHv-OpoBlmQ-1
X-Mimecast-MFC-AGG-ID: 9ZOG_KT2OFaNHv-OpoBlmQ_1760641124
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBC2219560A7;
	Thu, 16 Oct 2025 18:58:44 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E4DB1956056;
	Thu, 16 Oct 2025 18:58:44 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 1/6] iomap: replace folio_batch allocation with stack allocation
Date: Thu, 16 Oct 2025 15:02:58 -0400
Message-ID: <20251016190303.53881-2-bfoster@redhat.com>
In-Reply-To: <20251016190303.53881-1-bfoster@redhat.com>
References: <20251016190303.53881-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Zhang Yi points out that the dynamic folio_batch allocation in
iomap_fill_dirty_folios() is problematic for the ext4 on iomap work
that is under development because it doesn't sufficiently handle the
allocation failure case (by allowing a retry, for example).

The dynamic allocation was initially added for simplicity and to
help indicate whether the batch was used or not by the calling fs.
To address this issue, put the batch on the stack of
iomap_zero_range() and use a flag to control whether the batch
should be used in the iomap folio lookup path. This keeps things
simple and eliminates the concern for ext4 on iomap.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 45 ++++++++++++++++++++++++++++--------------
 fs/iomap/iter.c        |  6 +++---
 fs/xfs/xfs_iomap.c     | 11 ++++++-----
 include/linux/iomap.h  |  8 ++++++--
 4 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 51ecb6d48feb..05ff82c5432e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -761,7 +761,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (iter->fbatch) {
+	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
 		struct folio *folio = folio_batch_next(iter->fbatch);
 
 		if (!folio)
@@ -858,7 +858,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	 * process so return and let the caller iterate and refill the batch.
 	 */
 	if (!folio) {
-		WARN_ON_ONCE(!iter->fbatch);
+		WARN_ON_ONCE(!(iter->iomap.flags & IOMAP_F_FOLIO_BATCH));
 		return 0;
 	}
 
@@ -1473,23 +1473,34 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	return status;
 }
 
-loff_t
+/**
+ * iomap_fill_dirty_folios - fill a folio batch with dirty folios
+ * @iter: Iteration structure
+ * @start: Start offset of range. Updated based on lookup progress.
+ * @end: End offset of range
+ *
+ * Returns the associated control flag if the folio batch is available and the
+ * lookup performed. The caller is responsible to set the flag on the associated
+ * iomap.
+ */
+unsigned int
 iomap_fill_dirty_folios(
 	struct iomap_iter	*iter,
-	loff_t			offset,
-	loff_t			length)
+	loff_t			*start,
+	loff_t			end)
 {
 	struct address_space	*mapping = iter->inode->i_mapping;
-	pgoff_t			start = offset >> PAGE_SHIFT;
-	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
+	pgoff_t			pstart = *start >> PAGE_SHIFT;
+	pgoff_t			pend = (end - 1) >> PAGE_SHIFT;
 
-	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
-	if (!iter->fbatch)
-		return offset + length;
-	folio_batch_init(iter->fbatch);
+	if (!iter->fbatch) {
+		*start = end;
+		return 0;
+	}
 
-	filemap_get_folios_dirty(mapping, &start, end, iter->fbatch);
-	return (start << PAGE_SHIFT);
+	filemap_get_folios_dirty(mapping, &pstart, pend, iter->fbatch);
+	*start = (pstart << PAGE_SHIFT);
+	return IOMAP_F_FOLIO_BATCH;
 }
 EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
 
@@ -1498,17 +1509,21 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private)
 {
+	struct folio_batch fbatch;
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
 		.len		= len,
 		.flags		= IOMAP_ZERO,
 		.private	= private,
+		.fbatch		= &fbatch,
 	};
 	struct address_space *mapping = inode->i_mapping;
 	int ret;
 	bool range_dirty;
 
+	folio_batch_init(&fbatch);
+
 	/*
 	 * To avoid an unconditional flush, check pagecache state and only flush
 	 * if dirty and the fs returns a mapping that might convert on
@@ -1519,11 +1534,11 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
 
-		if (WARN_ON_ONCE(iter.fbatch &&
+		if (WARN_ON_ONCE((iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
 				 srcmap->type != IOMAP_UNWRITTEN))
 			return -EIO;
 
-		if (!iter.fbatch &&
+		if (!(iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
 		    (srcmap->type == IOMAP_HOLE ||
 		     srcmap->type == IOMAP_UNWRITTEN)) {
 			s64 status;
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 66ca12aac57d..026d85823c76 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -8,10 +8,10 @@
 
 static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 {
-	if (iter->fbatch) {
+	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
 		folio_batch_release(iter->fbatch);
-		kfree(iter->fbatch);
-		iter->fbatch = NULL;
+		folio_batch_reinit(iter->fbatch);
+		iter->iomap.flags &= ~IOMAP_F_FOLIO_BATCH;
 	}
 
 	iter->status = 0;
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 535bf3b8705d..01833aca37ac 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1775,7 +1775,6 @@ xfs_buffered_write_iomap_begin(
 	 */
 	if (flags & IOMAP_ZERO) {
 		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
-		u64 end;
 
 		if (isnullstartblock(imap.br_startblock) &&
 		    offset_fsb >= eof_fsb)
@@ -1795,12 +1794,14 @@ xfs_buffered_write_iomap_begin(
 		 */
 		if (imap.br_state == XFS_EXT_UNWRITTEN &&
 		    offset_fsb < eof_fsb) {
-			loff_t len = min(count,
-					 XFS_FSB_TO_B(mp, imap.br_blockcount));
+			loff_t foffset = offset, fend;
 
-			end = iomap_fill_dirty_folios(iter, offset, len);
+			fend = offset +
+			       min(count, XFS_FSB_TO_B(mp, imap.br_blockcount));
+			iomap_flags |= iomap_fill_dirty_folios(iter, &foffset,
+							       fend);
 			end_fsb = min_t(xfs_fileoff_t, end_fsb,
-					XFS_B_TO_FSB(mp, end));
+					XFS_B_TO_FSB(mp, foffset));
 		}
 
 		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index cd0f573156d6..79da917ff45e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -87,6 +87,9 @@ struct vm_fault;
 /*
  * Flags set by the core iomap code during operations:
  *
+ * IOMAP_F_FOLIO_BATCH indicates that the folio batch mechanism is active
+ * for this operation, set by iomap_fill_dirty_folios().
+ *
  * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
  * has changed as the result of this write operation.
  *
@@ -94,6 +97,7 @@ struct vm_fault;
  * range it covers needs to be remapped by the high level before the operation
  * can proceed.
  */
+#define IOMAP_F_FOLIO_BATCH	(1U << 13)
 #define IOMAP_F_SIZE_CHANGED	(1U << 14)
 #define IOMAP_F_STALE		(1U << 15)
 
@@ -351,8 +355,8 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops);
-loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
-		loff_t length);
+unsigned int iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t *start,
+		loff_t end);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-- 
2.51.0


