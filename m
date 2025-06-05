Return-Path: <linux-fsdevel+bounces-50769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED32AACF56A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F3E1894D86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67937277815;
	Thu,  5 Jun 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFxEiyXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6D2797BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144642; cv=none; b=dyun7v1etH9FiIzpPWOFQWVISQyvk54a85pvtMEtHPwntnWGz6E6viOEIxMFmf7wiG7b9PJ1ZR2gD2jUrI5JbDHq4+52/pc4eNvEAyUoGuAOZs/KCD59y2aHtcARXaFFix9f+q5CLaEhtBsZbstzh4k/R1Pnvpo4QOGog2NmT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144642; c=relaxed/simple;
	bh=oUVRg9+hQIpuyLPm5cbHWgJ0qTHn0NGWiCzElTCjyzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiKzjbVaP9aB351c3XxcA+dVmXMHfln8H8lstmXB17udJiZg0OEYf8T2/m1Nr/xqpkbA+vb+uIhjP0sJ+xGOqbiWRGL+q6Mhi7vjZ3ACZnarKaC5HPTicixoRH86pCkzeTMiwlbxsuv9bsuHw6HOhQtyjWx75Ckx1diCpJAQ/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFxEiyXs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYOthLuNgac4RW4o21rqMbEJL8YFxEWElKsq4syPZ7w=;
	b=SFxEiyXsbYBOkYYUDdf9rnyQ53wh1x6JMt2EXEGUFhyDhcLe9ltO0NvVke6w5dHUnPCiGf
	2YzhCiIYouhfBk1RjJyAI0d1OzZYNbmzoyVQiNRNBkNPkA8evdIbz4sHbwurxdW7baqJK1
	zxiyz+6kGN5C+JW2BvfKb/hPGY8EUO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-7znD5oX6PBCeGIvFNUNTrA-1; Thu,
 05 Jun 2025 13:30:35 -0400
X-MC-Unique: 7znD5oX6PBCeGIvFNUNTrA-1
X-Mimecast-MFC-AGG-ID: 7znD5oX6PBCeGIvFNUNTrA_1749144634
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55DCD1956048;
	Thu,  5 Jun 2025 17:30:34 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B42A30002C0;
	Thu,  5 Jun 2025 17:30:33 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] iomap: remove old partial eof zeroing optimization
Date: Thu,  5 Jun 2025 13:33:56 -0400
Message-ID: <20250605173357.579720-7-bfoster@redhat.com>
In-Reply-To: <20250605173357.579720-1-bfoster@redhat.com>
References: <20250605173357.579720-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

iomap_zero_range() optimizes the partial eof block zeroing use case
by force zeroing if the mapping is dirty. This is to avoid frequent
flushing on file extending workloads, which hurts performance.

Now that the folio batch mechanism provides a more generic solution
and is used by the only real zero range user (XFS), this isolated
optimization is no longer needed. Remove the unnecessary code and
let callers use the folio batch or fall back to flushing by default.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cf2f4f869920..ec58f5dae71c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1471,33 +1471,9 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
-			iter.status = iomap_zero_iter(&iter, did_zero);
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
2.49.0


