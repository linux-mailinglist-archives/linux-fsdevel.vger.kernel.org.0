Return-Path: <linux-fsdevel+bounces-54845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB777B03F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C564A0C92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAC255E4E;
	Mon, 14 Jul 2025 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3ivvTum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91A255222
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499054; cv=none; b=B4a7L/XX3oqXNGmUkVz7TskbTRvtBL+9O0EJxTHDXhSmwqViFRb64dIelGnnixBm0571kRH5j3zypGam8+MWRIVJtXFuNrAqX5tJcJwyINmIEsS7ukDDED3PEhfqhdp4eOf7DCM/he1sP3dzZrW211voFx3bCJRwBZu+ltTokp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499054; c=relaxed/simple;
	bh=7ExjyS1rst3OhkmJxETpxj6nsTXqfiUefjr84av0J/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l75G3QE/iO06O7o4zgig0SO4zyVeDIHoPccJpXBubNpp3HSCKd8mtTkqHUqcsKTiWHaFTiiYzkKC4kzLl53gsc3sm9EOjsjCerlqa8rb9P3evzvwwfYpVJQ4+MgifpDvu3fQDqax3oYQVsyMneJ9ugfXQy07rclsOhloUm37zPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3ivvTum; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hooFAAb2LyfYsY6syiVx3vKXoJCft1FIzUwOLKeoBCA=;
	b=P3ivvTumoi/GiPic2WoZfqUHpYRvIBPfO3VMxPAPpMEEdB7ZLkQm9mZaxdHYb5m/3uM4BC
	In3N04XKe4ePE1jJLzUDIgb78xrfo21rMlPyu8vDTg7gEPLtiFX6GpuK2dPr1gYBtitdrm
	R9ZJCGlMkBqAjOCe29xBSgyq3NewIJU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-E94ZUlsXMVO-bf8rHj4F9Q-1; Mon,
 14 Jul 2025 09:17:28 -0400
X-MC-Unique: E94ZUlsXMVO-bf8rHj4F9Q-1
X-Mimecast-MFC-AGG-ID: E94ZUlsXMVO-bf8rHj4F9Q_1752499047
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBD89180028A;
	Mon, 14 Jul 2025 13:17:26 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 967B2180045B;
	Mon, 14 Jul 2025 13:17:25 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v2 6/7] iomap: remove old partial eof zeroing optimization
Date: Mon, 14 Jul 2025 09:20:58 -0400
Message-ID: <20250714132059.288129-7-bfoster@redhat.com>
In-Reply-To: <20250714132059.288129-1-bfoster@redhat.com>
References: <20250714132059.288129-1-bfoster@redhat.com>
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
---
 fs/iomap/buffered-io.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 194e3cc0857f..d2bbed692c06 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1484,33 +1484,9 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
2.50.0


