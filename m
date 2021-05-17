Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608A7383B10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 19:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbhEQRSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 13:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236048AbhEQRSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 13:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621271847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3ChrpyqINd5LjVbSV1AZtzCKgi3r6GzKuhNpH//Q24=;
        b=HocPClYHhMNxOiegtgEbZOg18bMPfbCQxu/9/rfMFyIvjOM2tRdXtF2YN1Sclc/oyodIo2
        yzbEmmOxl8UYg6wJrkxczolhNgS3r7Eq5mKQ6gcC/ljFBtSmsvI6GH6tYmyetbUUniDwOc
        +mGkl5lPiweChLwBLiYThHXErQThrlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-2SJ8_9WlNpm9iZfgErNcKA-1; Mon, 17 May 2021 13:17:26 -0400
X-MC-Unique: 2SJ8_9WlNpm9iZfgErNcKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49CCF6D582;
        Mon, 17 May 2021 17:17:25 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E67735D9F2;
        Mon, 17 May 2021 17:17:24 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Date:   Mon, 17 May 2021 13:17:22 -0400
Message-Id: <20210517171722.1266878-4-bfoster@redhat.com>
In-Reply-To: <20210517171722.1266878-1-bfoster@redhat.com>
References: <20210517171722.1266878-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap writeback infrastructure is currently able to construct
extremely large bio chains (tens of GBs) associated with a single
ioend. This consolidation provides no significant value as bio
chains increase beyond a reasonable minimum size. On the other hand,
this does hold significant numbers of pages in the writeback
state across an unnecessarily large number of bios because the ioend
is not processed for completion until the final bio in the chain
completes. Cap an individual ioend to a reasonable size of 4096
pages (16MB with 4k pages) to avoid this condition.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c |  6 ++++--
 include/linux/iomap.h  | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 642422775e4e..f2890ee434d0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1269,7 +1269,7 @@ iomap_chain_bio(struct bio *prev)
 
 static bool
 iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
-		sector_t sector)
+		unsigned len, sector_t sector)
 {
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
@@ -1280,6 +1280,8 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 		return false;
 	if (sector != bio_end_sector(wpc->ioend->io_bio))
 		return false;
+	if (wpc->ioend->io_size + len > IOEND_MAX_IOSIZE)
+		return false;
 	return true;
 }
 
@@ -1297,7 +1299,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 	unsigned poff = offset & (PAGE_SIZE - 1);
 	bool merged, same_page = false;
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, len, sector)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
 		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 07f3f4e69084..89b15cc236d5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -203,6 +203,32 @@ struct iomap_ioend {
 	struct bio		io_inline_bio;	/* MUST BE LAST! */
 };
 
+/*
+ * Maximum ioend IO size is used to prevent ioends from becoming unbound in
+ * size. bios can reach 4GB in size if pages are contiguous, and bio chains are
+ * effectively unbound in length. Hence the only limits on the size of the bio
+ * chain is the contiguity of the extent on disk and the length of the run of
+ * sequential dirty pages in the page cache. This can be tens of GBs of physical
+ * extents and if memory is large enough, tens of millions of dirty pages.
+ * Locking them all under writeback until the final bio in the chain is
+ * submitted and completed locks all those pages for the legnth of time it takes
+ * to write those many, many GBs of data to storage.
+ *
+ * Background writeback caps any single writepages call to half the device
+ * bandwidth to ensure fairness and prevent any one dirty inode causing
+ * writeback starvation. fsync() and other WB_SYNC_ALL writebacks have no such
+ * cap on wbc->nr_pages, and that's where the above massive bio chain lengths
+ * come from. We want large IOs to reach the storage, but we need to limit
+ * completion latencies, hence we need to control the maximum IO size we
+ * dispatch to the storage stack.
+ *
+ * We don't really have to care about the extra IO completion overhead here
+ * because iomap has contiguous IO completion merging. If the device can sustain
+ * high throughput and large bios, the ioends are merged on completion and
+ * processed in large, efficient chunks with no additional IO latency.
+ */
+#define IOEND_MAX_IOSIZE	(4096ULL << PAGE_SHIFT)
+
 struct iomap_writeback_ops {
 	/*
 	 * Required, maps the blocks so that writeback can be performed on
-- 
2.26.3

