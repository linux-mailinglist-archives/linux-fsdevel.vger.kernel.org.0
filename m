Return-Path: <linux-fsdevel+bounces-34981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1CC9CF564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 21:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA40C1F23B30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607AC1E25E1;
	Fri, 15 Nov 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vy64BnSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319641E22F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700834; cv=none; b=o3DyuUTe5BWZlHhjeqKxdN/o7er/mbatnpoQj/YaIvwsrlxSDEpiruFeA0TNnyZyIXSz3+d5qQVt9KYVGsVSdE34+3rwJgl9dqI+vmOPNJXqUO3SedB3rDk8y90tcNiemEV6S//1TsdZoshXu4KGI054SRhOhXMnJ2w0FVbz3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700834; c=relaxed/simple;
	bh=8129lvCoehHbVeWMqtCkLCo3szkRv9egHG1cvUW5eQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nowxu293k3ISvouSFKN4puFuZene2/67aOEj8l11NR74K+0ZzX4/bHRkGT3YK577bpe+ZbrPInG1fuFqfTgOugFjza+6EXOQz2Umk2eBFoXZFTa5tkefZHeS3OGkVLUjJy8eOlBqxy1v6qKWEbg3iTclQ6qHmjc3gAMTUMF2lLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vy64BnSj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731700831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4AtfWKt2DgYvqWiXDtkXrgtOeibviw4I8ze21URWtQ=;
	b=Vy64BnSjw8jYu6x6C12tvGaUJH1oY6MnKa0KagTzdCB/V1eNVlPhOj2mzxAKKaGvg7X1UY
	8/sEDNkszUR1lrUWwnbaWS6lkRAg4JtdYj7kjb9OKhLu4cxsVNHmufQP8LNTGtcdnMDRO1
	5NiY8tL8Mt8OblKlqtetERIFWxzzQXo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-zETjAVFYPquJz0GqyXsoDw-1; Fri,
 15 Nov 2024 15:00:28 -0500
X-MC-Unique: zETjAVFYPquJz0GqyXsoDw-1
X-Mimecast-MFC-AGG-ID: zETjAVFYPquJz0GqyXsoDw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECEC71954B02;
	Fri, 15 Nov 2024 20:00:26 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD55E1953880;
	Fri, 15 Nov 2024 20:00:25 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	hch@infradead.org,
	djwong@kernel.org
Subject: [PATCH v4 3/3] iomap: elide flush from partial eof zero range
Date: Fri, 15 Nov 2024 15:01:55 -0500
Message-ID: <20241115200155.593665-4-bfoster@redhat.com>
In-Reply-To: <20241115200155.593665-1-bfoster@redhat.com>
References: <20241115200155.593665-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9c1aa0355c71..af2f59817779 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1401,6 +1401,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		.len		= len,
 		.flags		= IOMAP_ZERO,
 	};
+	struct address_space *mapping = inode->i_mapping;
+	unsigned int blocksize = i_blocksize(inode);
+	unsigned int off = pos & (blocksize - 1);
+	loff_t plen = min_t(loff_t, len, blocksize - off);
 	int ret;
 	bool range_dirty;
 
@@ -1410,12 +1414,28 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	 * mapping converts on writeback completion and so must be zeroed.
 	 *
 	 * The simplest way to deal with this across a range is to flush
-	 * pagecache and process the updated mappings. To avoid an unconditional
-	 * flush, check pagecache state and only flush if dirty and the fs
-	 * returns a mapping that might convert on writeback.
+	 * pagecache and process the updated mappings. To avoid excessive
+	 * flushing on partial eof zeroing, special case it to zero the
+	 * unaligned start portion if already dirty in pagecache.
+	 */
+	if (off &&
+	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
+		iter.len = plen;
+		while ((ret = iomap_iter(&iter, ops)) > 0)
+			iter.processed = iomap_zero_iter(&iter, did_zero);
+
+		iter.len = len - (iter.pos - pos);
+		if (ret || !iter.len)
+			return ret;
+	}
+
+	/*
+	 * To avoid an unconditional flush, check pagecache state and only flush
+	 * if dirty and the fs returns a mapping that might convert on
+	 * writeback.
 	 */
 	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
-					pos, pos + len - 1);
+					iter.pos, iter.pos + iter.len - 1);
 	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
 
-- 
2.47.0


