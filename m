Return-Path: <linux-fsdevel+bounces-33353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08099B7C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0472282661
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B519EED7;
	Thu, 31 Oct 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvo5Qzch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98814901B
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383410; cv=none; b=acOzVaKFjb12ifXqJ9/asoPRga0bUwV1zealtbGPum4ss/RODy0u3LbfHYJ2f+HVz9r9qzOu0ycOBLDVyeFxP0asAmBXS8hXiPCgCpU17mUlDwtlmg+yRnI6NlaqJzWQ5zBAc1QBtt0ciBR3nLPSw4U9w+sCR8Pa/cbtMW+BGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383410; c=relaxed/simple;
	bh=XJe+CGiBHRIuGVNFbigGHHh5eJcML6b8yT4nMRwOYts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vmw7M2OjqvckfmriVWZZOKpId43HCA5hPpsdewK+UVFtPKUFHmYrNNitFhvSu7pZzhRBinJZNFAvFwVjESQ9xRdhtkaTc98XTQ9EHNbMt9ujtn7bjZEyY+qqyo6FLR6xmW6XHUatVMZGW3AsKlMs/U8Ots4h+5M8r1BR62FQc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvo5Qzch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730383405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g50u9l8W1XhZI84OkSvTYxsRF4U+ETN5mo6LAPBCa1I=;
	b=dvo5QzchPNFSMGPUtNtH6mRyoTDNbF43MWK8kWwPyoTHt/AiQd0t7wBAWg4TU+C/Uxx/cA
	3wg0GV7wWx9AWe617Jv6zLISoGenvFBwyqu7RhQ6RCfq5MtJXCyjq08XVI20QTzBtkglWp
	mkVguvgSpVckt23/JLSzYkFynVFrlMM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-CLkLQGGlO-eUWOCKCuVjMQ-1; Thu,
 31 Oct 2024 10:03:23 -0400
X-MC-Unique: CLkLQGGlO-eUWOCKCuVjMQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A48BC1955EB2
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:22 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 334DB19560A2
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:22 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] iomap: elide flush from partial eof zero range
Date: Thu, 31 Oct 2024 10:04:48 -0400
Message-ID: <20241031140449.439576-3-bfoster@redhat.com>
In-Reply-To: <20241031140449.439576-1-bfoster@redhat.com>
References: <20241031140449.439576-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

iomap zero range flushes pagecache in certain situations to
determine which parts of the range might require zeroing if dirty
data is present in pagecache. The kernel robot recently reported a
regression associated with this flushing in the following stress-ng
workload on XFS:

stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64

This workload involves repeated small, strided, extending writes. On
XFS, this produces a pattern of post-eof speculative preallocation,
conversion of preallocation from delalloc to unwritten, dirtying
pagecache over newly unwritten blocks, and then rinse and repeat
from the new EOF. This leads to repetitive flushing of the EOF folio
via the zero range call XFS uses for writes that start beyond
current EOF.

To mitigate this problem, special case EOF block zeroing to prefer
zeroing the folio over a flush when the EOF folio is already dirty.
To do this, split out and open code handling of an unaligned start
offset. This brings most of the performance back by avoiding flushes
on zero range calls via write and truncate extension operations. The
flush doesn't occur in these situations because the entire range is
post-eof and therefore the folio that overlaps EOF is the only one
in the range.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 60386cb7b9ef..343a2fa29bec 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -227,6 +227,18 @@ static void ifs_free(struct folio *folio)
 	kfree(ifs);
 }
 
+/* helper to reset an iter for reuse */
+static inline void
+iomap_iter_init(struct iomap_iter *iter, struct inode *inode, loff_t pos,
+		loff_t len, unsigned flags)
+{
+	memset(iter, 0, sizeof(*iter));
+	iter->inode = inode;
+	iter->pos = pos;
+	iter->len = len;
+	iter->flags = flags;
+}
+
 /*
  * Calculate the range inside the folio that we actually need to read.
  */
@@ -1416,6 +1428,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		.len		= len,
 		.flags		= IOMAP_ZERO,
 	};
+	struct address_space *mapping = inode->i_mapping;
+	unsigned int blocksize = i_blocksize(inode);
+	unsigned int off = pos & (blocksize - 1);
+	loff_t plen = min_t(loff_t, len, blocksize - off);
 	int ret;
 	bool range_dirty;
 
@@ -1425,12 +1441,30 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	 * mapping converts on writeback completion and must be zeroed.
 	 *
 	 * The simplest way to deal with this is to flush pagecache and process
-	 * the updated mappings. To avoid an unconditional flush, check dirty
-	 * state and defer the flush until a combination of dirty pagecache and
-	 * at least one mapping that might convert on writeback is seen.
+	 * the updated mappings. First, special case the partial eof zeroing
+	 * use case since it is more performance sensitive. Zero the start of
+	 * the range if unaligned and already dirty in pagecache.
+	 */
+	if (off &&
+	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
+		iter.len = plen;
+		while ((ret = iomap_iter(&iter, ops)) > 0)
+			iter.processed = iomap_zero_iter(&iter, did_zero);
+
+		/* reset iterator for the rest of the range */
+		iomap_iter_init(&iter, inode, iter.pos,
+			len - (iter.pos - pos), IOMAP_ZERO);
+		if (ret || !iter.len)
+			return ret;
+	}
+
+	/*
+	 * To avoid an unconditional flush, check dirty state and defer the
+	 * flush until a combination of dirty pagecache and at least one
+	 * mapping that might convert on writeback is seen.
 	 */
 	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
-					pos, pos + len - 1);
+					iter.pos, iter.pos + iter.len - 1);
 	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		const struct iomap *s = iomap_iter_srcmap(&iter);
 		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
-- 
2.46.2


