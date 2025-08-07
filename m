Return-Path: <linux-fsdevel+bounces-57004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA63B1DA45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515941AA5342
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE87426A1CC;
	Thu,  7 Aug 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUze2eE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DC26A0B9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577823; cv=none; b=SLkTMbD5X3YlHDK5ZJXcjoOJAa3DBjDLx4vVn3Ef1pTGBB31GOvZmxgD+tGUBoh2rbCEmGEkKWBV5A2eKV2N1lIAkU5DmIyT8k7MHRDFzR02f0ft2NArTmlWEmCJ5eWAneIU3Sf26bKMwqevRG/7ClCos/qFi1vFxSB48OPe/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577823; c=relaxed/simple;
	bh=hlo2qM0quZT+t0id7T5qDOeDzgzIU6rP7CORaTWR/gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnV0NcRaLit+INEOq7TgfZW14heSu83XqkkAtRNAU1+Dx1oGQm9Ax0zb2QWiW3HVT0tGKg1liS57WE3T0qPTYfYVaeucBuHzg+Eyu/W81T86HpKImx7W5zNm1t9n8RokMR69ZfYGoTu6PrR61/HSrq7UhcAPE6OUQv45Hk4cjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUze2eE3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754577821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6S68yZ5CuJZZY2VXqHIY9kfsBhGeaBc+jIgknqToag=;
	b=GUze2eE3f5sl4mJqNeRYuVJ5Kqd0NhnHizOzHLxFkTu65UOXOeiSsFG1VXfdMQMjx7S8Bn
	6avjd4p7RwZjJf+MJaIsv1fQf+rptHyDXOhhQXwzVcG4VfPgLeEGfUNUbUHvmvMbxZ1A0Q
	ByrgKKsLvLY5Z8LmY6l7DLCj0JrPRZY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-gL0YVTPROaGlKXnCuVsBEg-1; Thu,
 07 Aug 2025 10:43:34 -0400
X-MC-Unique: gL0YVTPROaGlKXnCuVsBEg-1
X-Mimecast-MFC-AGG-ID: gL0YVTPROaGlKXnCuVsBEg_1754577812
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 672591954B23;
	Thu,  7 Aug 2025 14:43:32 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 362C11800297;
	Thu,  7 Aug 2025 14:43:31 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v4 6/7] iomap: remove old partial eof zeroing optimization
Date: Thu,  7 Aug 2025 10:47:09 -0400
Message-ID: <20250807144711.564137-7-bfoster@redhat.com>
In-Reply-To: <20250807144711.564137-1-bfoster@redhat.com>
References: <20250807144711.564137-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

iomap_zero_range() optimizes the partial eof block zeroing use case
by force zeroing if the mapping is dirty. This is to avoid frequent
flushing on file extending workloads, which hurts performance.

Now that the folio batch mechanism provides a more generic solution
and is used by the only real zero range user (XFS), this isolated
optimization is no longer needed. Remove the unnecessary code and
let callers use the folio batch or fall back to flushing by default.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a08a341c6f5b..73772d34f502 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1498,34 +1498,9 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		.private	= private,
 	};
 	struct address_space *mapping = inode->i_mapping;
-	unsigned int blocksize = i_blocksize(inode);
-	unsigned int off = pos & (blocksize - 1);
-	loff_t plen = min_t(loff_t, len, blocksize - off);
 	int ret;
 	bool range_dirty;
 
-	/*
-	 * Zero range can skip mappings that are zero on disk so long as
-	 * pagecache is clean. If pagecache was dirty prior to zero range, the
-	 * mapping converts on writeback completion and so must be zeroed.
-	 *
-	 * The simplest way to deal with this across a range is to flush
-	 * pagecache and process the updated mappings. To avoid excessive
-	 * flushing on partial eof zeroing, special case it to zero the
-	 * unaligned start portion if already dirty in pagecache.
-	 */
-	if (!iter.fbatch && off &&
-	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
-		iter.len = plen;
-		while ((ret = iomap_iter(&iter, ops)) > 0)
-			iter.status = iomap_zero_iter(&iter, did_zero,
-					write_ops);
-
-		iter.len = len - (iter.pos - pos);
-		if (ret || !iter.len)
-			return ret;
-	}
-
 	/*
 	 * To avoid an unconditional flush, check pagecache state and only flush
 	 * if dirty and the fs returns a mapping that might convert on
-- 
2.50.1


