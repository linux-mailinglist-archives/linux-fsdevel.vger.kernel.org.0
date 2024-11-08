Return-Path: <linux-fsdevel+bounces-34014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5179C1D2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 13:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE701F2344B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101921E9062;
	Fri,  8 Nov 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqyadNvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD441E9078
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069679; cv=none; b=Fhyct5Hlh4SWVEUzs1oUTN4D1sr4L6ICY6gtlxpGUhni2hQBfkUwyuxnAquhBXSPaIaelob3fe97uzu30Ar7qAPgxb2pxQWdYRlAWBowpdPFEFIP9NJndloai1sBlbgGlz1O0nu1QfeqiOXDLlcxQG7BiHDjxvS1rSKgCkUxD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069679; c=relaxed/simple;
	bh=IBR/F7lQZCKJRDpari86IncDFoz0s0yDN6QG/Q/vfbs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTQqsApEzUPTP3L53Q0iDIll/Jpi796NV8FiuX51S5T58db5AWXHHpem9ec+JLL7AqtckY6iZHCyY3cuOeyEnwEt3drxSNpGd5SSly5VvKYoYczW6Um7Ty3bamP0dWtWF7FVP6gjO5L1iR3iUGy8ujPIOZu4u3Lzsl+bx+W+Muo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqyadNvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731069676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWnPGAhYPeZR2u3ZeDz6tmm1g+TWVBBMmghBGbo0Gmc=;
	b=LqyadNvu9RKHHQPHXpRolKPPAcrCQXv2Hkb7xBjYhuP60poWwSyF8zliIc6Qbrly2bVn0o
	Z3lKg0IkKa7ZO6cAxWirMydzVTeKt2nWajTGJ6+Tfcfg11RJoSS9a1DwGYwdbWOn383wkJ
	uEqTtgbkBxj81ejjuTjysvQe0ghWRTY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-1gGciMJLO5ma8w0Q6vIqLQ-1; Fri,
 08 Nov 2024 07:41:15 -0500
X-MC-Unique: 1gGciMJLO5ma8w0Q6vIqLQ-1
X-Mimecast-MFC-AGG-ID: 1gGciMJLO5ma8w0Q6vIqLQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BDFD1955EE7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:14 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 255BF1956054
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:14 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/4] iomap: elide flush from partial eof zero range
Date: Fri,  8 Nov 2024 07:42:45 -0500
Message-ID: <20241108124246.198489-4-bfoster@redhat.com>
In-Reply-To: <20241108124246.198489-1-bfoster@redhat.com>
References: <20241108124246.198489-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a78b5b9b3df3..7f40234a301e 100644
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
 		const struct iomap *s = iomap_iter_srcmap(&iter);
 
-- 
2.47.0


