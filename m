Return-Path: <linux-fsdevel+bounces-68274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7698C57D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16774A3F35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD823BD1B;
	Thu, 13 Nov 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHm9OnlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592182264C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041779; cv=none; b=KwZpwDYgnD5lweB7oRPsl400Uhddiq4fJxg1hQ/uIyy/tbJ5eecfS8QGLkjZKAVTEeM/W7efhRG3LAFq1D//DB5filfbm5BmOoAyu7lxu+IMAQrQJyaOWUUwmPzunnOeWjx/uZCBhKBWYok8sRWUzskatGmyeuNXpDDiVAr91w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041779; c=relaxed/simple;
	bh=2tBJMdXl0kh5vuIB2iXCFdZNYDPkd/2yjg8Ysr4Tt4I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uztkkrK51KLZSQNRR3ZJcK1XY0BQwZjoRafqkSwn7Dq+gYPxoz53n/J6hmx9i+dQhOguj9TcSwKF4OKjdqJdY1Ff+G9CUyjeJfcfy7Ef6i0GwD5DOan9+YWkrjMC1DN8MgUaPTnqPdY9CQ0x47Uap8cEDsSh4P4L4M6+Qzfvk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHm9OnlA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763041776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GgcxqGOkPKL+u+JrA2McOJ6M6R3yj2NAENV2OrWShSw=;
	b=JHm9OnlAk+d3ELSOYVfWAOl3s06lobCWlAdAYpcyP5/8jW0SLPx3gpwMOVEspJNeAfDwxR
	5Zy5dgkVj+ZU3KCM2hXK15ZGLFM+5bS+v+AT38ImoYkP3WbO+j061JTHsu/Wf5uzdj5t9x
	FXUzUF8+q11hLl9QuxqhizmKosAkWnU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-SvbAzkYgMmm138W965Bt1g-1; Thu,
 13 Nov 2025 08:49:32 -0500
X-MC-Unique: SvbAzkYgMmm138W965Bt1g-1
X-Mimecast-MFC-AGG-ID: SvbAzkYgMmm138W965Bt1g_1763041772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E91B318AB42A;
	Thu, 13 Nov 2025 13:49:31 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B1E1180049F;
	Thu, 13 Nov 2025 13:49:31 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v2] iomap: replace folio_batch allocation with stack allocation
Date: Thu, 13 Nov 2025 08:54:04 -0500
Message-ID: <20251113135404.553339-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

While here, also clean up the fill helper signature to be more
consistent with the underlying filemap helper. Pass through the
return value of the filemap helper (folio count) and update the
lookup offset via an out param.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Acked-by: Dave Chinner <dchinner@redhat.com>
---

v2:
- Reworked fill function to return folio count and pass flags as param.
- Updated commit log to note function signature changes.
v1: https://lore.kernel.org/linux-fsdevel/20251111175047.321869-1-bfoster@redhat.com/

 fs/iomap/buffered-io.c | 50 +++++++++++++++++++++++++++++-------------
 fs/iomap/iter.c        |  6 ++---
 fs/xfs/xfs_iomap.c     | 11 +++++-----
 include/linux/iomap.h  |  8 +++++--
 4 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9b0b9cf7caa7..bc8b2ebb3330 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -772,7 +772,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (iter->fbatch) {
+	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
 		struct folio *folio = folio_batch_next(iter->fbatch);
 
 		if (!folio)
@@ -869,7 +869,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	 * process so return and let the caller iterate and refill the batch.
 	 */
 	if (!folio) {
-		WARN_ON_ONCE(!iter->fbatch);
+		WARN_ON_ONCE(!(iter->iomap.flags & IOMAP_F_FOLIO_BATCH));
 		return 0;
 	}
 
@@ -1483,23 +1483,39 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	return status;
 }
 
-loff_t
+/**
+ * iomap_fill_dirty_folios - fill a folio batch with dirty folios
+ * @iter: Iteration structure
+ * @start: Start offset of range. Updated based on lookup progress.
+ * @end: End offset of range
+ * @iomap_flags: Flags to set on the associated iomap to track the batch.
+ *
+ * Returns the folio count directly. Also returns the associated control flag if
+ * the the batch lookup is performed and the expected offset of a subsequent
+ * lookup via out params. The caller is responsible to set the flag on the
+ * associated iomap.
+ */
+unsigned int
 iomap_fill_dirty_folios(
 	struct iomap_iter	*iter,
-	loff_t			offset,
-	loff_t			length)
+	loff_t			*start,
+	loff_t			end,
+	unsigned int		*iomap_flags)
 {
 	struct address_space	*mapping = iter->inode->i_mapping;
-	pgoff_t			start = offset >> PAGE_SHIFT;
-	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
+	pgoff_t			pstart = *start >> PAGE_SHIFT;
+	pgoff_t			pend = (end - 1) >> PAGE_SHIFT;
+	unsigned int		count;
 
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
+	count = filemap_get_folios_dirty(mapping, &pstart, pend, iter->fbatch);
+	*start = (pstart << PAGE_SHIFT);
+	*iomap_flags |= IOMAP_F_FOLIO_BATCH;
+	return count;
 }
 EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
 
@@ -1508,17 +1524,21 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
@@ -1529,11 +1549,11 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
index 8692e5e41c6d..c04796f6e57f 100644
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
index 04f39ea15898..37a1b33e9045 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1831,7 +1831,6 @@ xfs_buffered_write_iomap_begin(
 	 */
 	if (flags & IOMAP_ZERO) {
 		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
-		u64 end;
 
 		if (isnullstartblock(imap.br_startblock) &&
 		    offset_fsb >= eof_fsb)
@@ -1851,12 +1850,14 @@ xfs_buffered_write_iomap_begin(
 		 */
 		if (imap.br_state == XFS_EXT_UNWRITTEN &&
 		    offset_fsb < eof_fsb) {
-			loff_t len = min(count,
-					 XFS_FSB_TO_B(mp, imap.br_blockcount));
+			loff_t foffset = offset, fend;
 
-			end = iomap_fill_dirty_folios(iter, offset, len);
+			fend = offset +
+			       min(count, XFS_FSB_TO_B(mp, imap.br_blockcount));
+			iomap_fill_dirty_folios(iter, &foffset, fend,
+						&iomap_flags);
 			end_fsb = min_t(xfs_fileoff_t, end_fsb,
-					XFS_B_TO_FSB(mp, end));
+					XFS_B_TO_FSB(mp, foffset));
 		}
 
 		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b1ac08c7474..ce2c9fbd8e16 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -88,6 +88,9 @@ struct vm_fault;
 /*
  * Flags set by the core iomap code during operations:
  *
+ * IOMAP_F_FOLIO_BATCH indicates that the folio batch mechanism is active
+ * for this operation, set by iomap_fill_dirty_folios().
+ *
  * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
  * has changed as the result of this write operation.
  *
@@ -95,6 +98,7 @@ struct vm_fault;
  * range it covers needs to be remapped by the high level before the operation
  * can proceed.
  */
+#define IOMAP_F_FOLIO_BATCH	(1U << 13)
 #define IOMAP_F_SIZE_CHANGED	(1U << 14)
 #define IOMAP_F_STALE		(1U << 15)
 
@@ -352,8 +356,8 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops);
-loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
-		loff_t length);
+unsigned int iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t *start,
+		loff_t end, unsigned int *iomap_flags);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-- 
2.51.1


