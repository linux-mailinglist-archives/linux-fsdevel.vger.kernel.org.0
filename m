Return-Path: <linux-fsdevel+bounces-37320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021579F102A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A9283781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7331E25F9;
	Fri, 13 Dec 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF+otIVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF11E22E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102228; cv=none; b=A1YfCkmYunbfVTAPCmc8Fw41rnLKCD8Flj7hqyfOCrR1Uk8y7owSS0LdWtD5qPntBQt5hP2ppzE/p8uDiMYwGrLn5/jCQRMx+YeYzLvb/4qyQmtXNB7TY7P07F5GlZMO9qzmS+8yvUPHddBK+KZadzmuaLOJBYr1alR+8GZ8ols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102228; c=relaxed/simple;
	bh=XyOAmvfe21viuZJY78oI6BQo/3Z13/h8azFdPRy7YMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFJjB5nexZY4Uc32AS3P8ge0DvZweZFR4Z1dvk27Uhhn4zqrzGDRLD7eid/0JxLf80Jbkl0j7jk/AeXHHdySIQEYTnTL1LCSoVbCCqLYWqH6kVOSyu3pxIyaXrwQ/7k3fNaY0+d2rUq8dSt0tx4rS3fTooH0oNYf5wUSBsmwWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JF+otIVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9V+GpZZTi3GLiT0j5cISAdQq8//hsNV1rtZciA7bZI=;
	b=JF+otIVd2kZEx5XY2FORNXq3YHhuon1ZL160zEESQLhCO79B5AdCKeSxaJw6GK1MDwKauD
	1kTw9aMW75LQ2J+gf3qmGEO5FxAoXQyW1/7KAOb2JNSM5rn3c0n2mK6J5cjQhiABpQxvqY
	pm/7e6On8HPNgKl7el3wjPv9T01cvkE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-CIEjrz_SM6OuegUm98NSVw-1; Fri,
 13 Dec 2024 10:03:44 -0500
X-MC-Unique: CIEjrz_SM6OuegUm98NSVw-1
X-Mimecast-MFC-AGG-ID: CIEjrz_SM6OuegUm98NSVw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87B5519560B4;
	Fri, 13 Dec 2024 15:03:43 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3835195394B;
	Fri, 13 Dec 2024 15:03:42 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH RFCv2 2/4] iomap: optional zero range dirty folio processing
Date: Fri, 13 Dec 2024 10:05:26 -0500
Message-ID: <20241213150528.1003662-3-bfoster@redhat.com>
In-Reply-To: <20241213150528.1003662-1-bfoster@redhat.com>
References: <20241213150528.1003662-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The only way zero range can currently process unwritten mappings
with dirty pagecache is to check whether the range is dirty before
mapping lookup and then flush when at least one underlying mapping
is unwritten. This ordering is required to prevent iomap lookup from
racing with folio writeback and reclaim.

Since zero range can skip ranges of unwritten mappings that are
clean in cache, this operation can be improved by allowing the
filesystem to provide the set of folios backed by such mappings that
require zeroing up. In turn, rather than flush or iterate file
offsets, zero range can process each folio as normal and skip any
clean or uncached ranges in between.

As a first pass prototype solution, stuff a folio_batch in struct
iomap, provide a helper that the fs can use to populate the batch at
lookup time, and define a flag to indicate the mapping was checked.
Note that since the helper is intended for use under internal fs
locks, it trylocks folios in order to filter out clean folios. This
loosely follows the logic from filemap_range_has_writeback().

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 77 ++++++++++++++++++++++++++++++++++++++++--
 fs/iomap/iter.c        |  6 ++++
 include/linux/iomap.h  |  4 +++
 3 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7fdf593b58b1..5492dc7fe963 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -751,6 +751,15 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
+	if (iter->fbatch) {
+		struct folio *folio = folio_batch_next(iter->fbatch);
+		if (folio) {
+			folio_get(folio);
+			folio_lock(folio);
+		}
+		return folio;
+	}
+
 	if (folio_ops && folio_ops->get_folio)
 		return folio_ops->get_folio(iter, pos, len);
 	else
@@ -839,6 +848,15 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 		}
 	}
 
+	if (!folio) {
+		WARN_ON_ONCE(!iter->fbatch);
+		len = 0;
+		goto out;
+	} else if (folio_pos(folio) > iter->pos) {
+		BUG_ON(folio_pos(folio) - iter->pos >= iomap_length(iter));
+		iomap_iter_advance(iter, folio_pos(folio) - iter->pos);
+	}
+
 	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
 	if (srcmap != &iter->iomap)
@@ -854,6 +872,7 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	if (unlikely(status))
 		goto out_unlock;
 
+out:
 	*foliop = folio;
 	*plen = len;
 	return 0;
@@ -1374,6 +1393,11 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
+		if (!folio) {
+			iomap_iter_advance(iter, iomap_length(iter));
+			break;
+		}
+
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
 
@@ -1393,6 +1417,49 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	return 0;
 }
 
+loff_t
+iomap_fill_dirty_folios(
+	struct iomap_iter	*iter,
+	loff_t			offset,
+	loff_t			length)
+{
+	struct address_space	*mapping = iter->inode->i_mapping;
+	struct folio_batch	fbatch;
+	loff_t			end_pos = offset + length;
+	pgoff_t			start = offset >> PAGE_SHIFT;
+	pgoff_t			end = (end_pos - 1) >> PAGE_SHIFT;
+
+	folio_batch_init(&fbatch);
+	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
+	if (!iter->fbatch)
+		return end_pos;
+	folio_batch_init(iter->fbatch);
+
+	while (filemap_get_folios(mapping, &start, end, &fbatch) &&
+	       folio_batch_space(iter->fbatch)) {
+		struct folio *folio;
+		while ((folio = folio_batch_next(&fbatch))) {
+			if (folio_trylock(folio)) {
+				bool clean = !folio_test_dirty(folio) &&
+					     !folio_test_writeback(folio);
+				folio_unlock(folio);
+				if (clean)
+					continue;
+			}
+
+			folio_get(folio);
+			if (!folio_batch_add(iter->fbatch, folio)) {
+				end_pos = folio_pos(folio) + folio_size(folio);
+				break;
+			}
+		}
+		folio_batch_release(&fbatch);
+	}
+
+	return end_pos;
+}
+EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
+
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops)
@@ -1420,7 +1487,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	 * flushing on partial eof zeroing, special case it to zero the
 	 * unaligned start portion if already dirty in pagecache.
 	 */
-	if (off &&
+	if (!iter.fbatch && off &&
 	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
 		iter.len = plen;
 		while ((ret = iomap_iter(&iter, ops)) > 0)
@@ -1441,8 +1508,12 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
 
-		if (srcmap->type == IOMAP_HOLE ||
-		    srcmap->type == IOMAP_UNWRITTEN) {
+		if (WARN_ON_ONCE(iter.fbatch && srcmap->type != IOMAP_UNWRITTEN))
+			return -EIO;
+
+		if (!iter.fbatch &&
+		    (srcmap->type == IOMAP_HOLE ||
+		     srcmap->type == IOMAP_UNWRITTEN)) {
 			loff_t proc = iomap_length(&iter);
 
 			if (range_dirty) {
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 5fe0edb51fe5..911846d7386c 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -9,6 +9,12 @@
 
 static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 {
+	if (iter->fbatch) {
+		folio_batch_release(iter->fbatch);
+		kfree(iter->fbatch);
+		iter->fbatch = NULL;
+	}
+
 	iter->processed = 0;
 	memset(&iter->iomap, 0, sizeof(iter->iomap));
 	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 704ed98159f7..d01e5265de27 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/mm_types.h>
 #include <linux/blkdev.h>
+#include <linux/pagevec.h>
 
 struct address_space;
 struct fiemap_extent_info;
@@ -228,6 +229,7 @@ struct iomap_iter {
 	unsigned flags;
 	struct iomap iomap;
 	struct iomap srcmap;
+	struct folio_batch *fbatch;
 	void *private;
 };
 
@@ -315,6 +317,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
+loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
+		loff_t length);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-- 
2.47.0


