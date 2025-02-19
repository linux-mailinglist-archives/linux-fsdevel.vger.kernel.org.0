Return-Path: <linux-fsdevel+bounces-42101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA8A3C690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207193B8A46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA56B2144A7;
	Wed, 19 Feb 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qer0M32C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC72144D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987304; cv=none; b=W7rp+w80lz1lnfKxtA8z/10cJBQuhkhrdPSs6V3xf9gS1Z/jjPPER6zThibr6mZuLzagzObIhqj/79SJAIQebbhjFFi9lWsfDtP7l3EpBW8vSBP/1IikPJ2wXgp0qOGMvz/4iISQHaGn+pzUJJeG/O7NfsOJaNDkxAI0ppGwE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987304; c=relaxed/simple;
	bh=wk9+11gZB3YkO40mAE7uTwKVLrnhfLSTI2QgAq+EEC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4q2M5rfRBAjUhSu+4HcKiCduByGJaqtIWTOsB/ObPv8qcOvbD+0jqoCnZY+0fv8IFhFnW8ni0Vm03IZH0QiqSMxRQSMUcYNFaWIXTRlmIE+pPqHm1/HlVHyvRoUnbyABbg0Fz4mYzKvNypfci+hpqJE9i8IGeDqd0fCvzRldI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qer0M32C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8G0Ia23eSw835GBvCXZGEg5MIsVcAT5wSwQ2HscZDA=;
	b=Qer0M32C0qqEsaCky7Bu5vXeZtfDuQDkDm6WzGltqNSjwBrrN4w2KCe6bpKd0oBg+eqFi4
	4LTEIOhvbhEHopm385vEPjBD4+qX3IiqrIcz7smydU5TWwRhPb0fGq4tXl+bgR119IqGLH
	kQc4+agp5t5BRS/8OhrvOgF3SfahrwQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-NpZbHE3cMl2iYa0Cz5zRuA-1; Wed,
 19 Feb 2025 12:48:18 -0500
X-MC-Unique: NpZbHE3cMl2iYa0Cz5zRuA-1
X-Mimecast-MFC-AGG-ID: NpZbHE3cMl2iYa0Cz5zRuA_1739987297
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29F8018D9590;
	Wed, 19 Feb 2025 17:48:17 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E2891800359;
	Wed, 19 Feb 2025 17:48:16 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 03/12] iomap: convert misc simple ops to incremental advance
Date: Wed, 19 Feb 2025 12:50:41 -0500
Message-ID: <20250219175050.83986-4-bfoster@redhat.com>
In-Reply-To: <20250219175050.83986-1-bfoster@redhat.com>
References: <20250219175050.83986-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Update several of the remaining iomap operations to advance the iter
directly rather than via return value. This includes page faults,
fiemap, seek data/hole and swapfile activation.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c |  2 +-
 fs/iomap/fiemap.c      | 18 +++++++++---------
 fs/iomap/seek.c        | 12 ++++++------
 fs/iomap/swapfile.c    |  7 +++++--
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 215866ba264d..ddc82dab6bb5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1480,7 +1480,7 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 		folio_mark_dirty(folio);
 	}
 
-	return length;
+	return iomap_iter_advance(iter, &length);
 }
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 610ca6f1ec9b..8a0d8b034218 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -39,24 +39,24 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 			iomap->length, flags);
 }
 
-static loff_t iomap_fiemap_iter(const struct iomap_iter *iter,
+static loff_t iomap_fiemap_iter(struct iomap_iter *iter,
 		struct fiemap_extent_info *fi, struct iomap *prev)
 {
+	u64 length = iomap_length(iter);
 	int ret;
 
 	if (iter->iomap.type == IOMAP_HOLE)
-		return iomap_length(iter);
+		goto advance;
 
 	ret = iomap_to_fiemap(fi, prev, 0);
 	*prev = iter->iomap;
-	switch (ret) {
-	case 0:		/* success */
-		return iomap_length(iter);
-	case 1:		/* extent array full */
-		return 0;
-	default:	/* error */
+	if (ret < 0)
 		return ret;
-	}
+	if (ret == 1)	/* extent array full */
+		return 0;
+
+advance:
+	return iomap_iter_advance(iter, &length);
 }
 
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index a845c012b50c..83c687d6ccc0 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -10,7 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 
-static loff_t iomap_seek_hole_iter(const struct iomap_iter *iter,
+static loff_t iomap_seek_hole_iter(struct iomap_iter *iter,
 		loff_t *hole_pos)
 {
 	loff_t length = iomap_length(iter);
@@ -20,13 +20,13 @@ static loff_t iomap_seek_hole_iter(const struct iomap_iter *iter,
 		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
 				iter->pos, iter->pos + length, SEEK_HOLE);
 		if (*hole_pos == iter->pos + length)
-			return length;
+			return iomap_iter_advance(iter, &length);
 		return 0;
 	case IOMAP_HOLE:
 		*hole_pos = iter->pos;
 		return 0;
 	default:
-		return length;
+		return iomap_iter_advance(iter, &length);
 	}
 }
 
@@ -56,19 +56,19 @@ iomap_seek_hole(struct inode *inode, loff_t pos, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
-static loff_t iomap_seek_data_iter(const struct iomap_iter *iter,
+static loff_t iomap_seek_data_iter(struct iomap_iter *iter,
 		loff_t *hole_pos)
 {
 	loff_t length = iomap_length(iter);
 
 	switch (iter->iomap.type) {
 	case IOMAP_HOLE:
-		return length;
+		return iomap_iter_advance(iter, &length);
 	case IOMAP_UNWRITTEN:
 		*hole_pos = mapping_seek_hole_data(iter->inode->i_mapping,
 				iter->pos, iter->pos + length, SEEK_DATA);
 		if (*hole_pos < 0)
-			return length;
+			return iomap_iter_advance(iter, &length);
 		return 0;
 	default:
 		*hole_pos = iter->pos;
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index b90d0eda9e51..4395e46a4dc7 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -94,9 +94,11 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
  * swap only cares about contiguous page-aligned physical extents and makes no
  * distinction between written and unwritten extents.
  */
-static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
+static loff_t iomap_swapfile_iter(struct iomap_iter *iter,
 		struct iomap *iomap, struct iomap_swapfile_info *isi)
 {
+	u64 length = iomap_length(iter);
+
 	switch (iomap->type) {
 	case IOMAP_MAPPED:
 	case IOMAP_UNWRITTEN:
@@ -132,7 +134,8 @@ static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
 			return error;
 		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
 	}
-	return iomap_length(iter);
+
+	return iomap_iter_advance(iter, &length);
 }
 
 /*
-- 
2.48.1


