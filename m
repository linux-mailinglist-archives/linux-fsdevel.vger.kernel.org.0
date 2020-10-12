Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D129428B9E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbgJLOEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 10:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403780AbgJLOD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602511435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsP7bJ5xE859gYh7hZQPmIA2QTkwd3outq7h66tL/c4=;
        b=iWkC6GmxLDM8DE89HTw+XUC3QjbCF3oqjsdpE8w4j+F4KjgpKu5KgF/K3uBOH6ATkzOReJ
        8OGdj4iGQTysan83zPnxd2csl6Ojx0dPRjaHp0By6KjqV8ZfmG9y1qeUUSmRpznyuT36th
        oLWkTQ/BsMNpMSV56CpbcLPcchwVivM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-F4G7htSwPtiZsJL8CfHXZw-1; Mon, 12 Oct 2020 10:03:53 -0400
X-MC-Unique: F4G7htSwPtiZsJL8CfHXZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C60910054FF;
        Mon, 12 Oct 2020 14:03:52 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B66F360C07;
        Mon, 12 Oct 2020 14:03:51 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH 2/2] iomap: zero cached pages over unwritten extents on zero range
Date:   Mon, 12 Oct 2020 10:03:50 -0400
Message-Id: <20201012140350.950064-3-bfoster@redhat.com>
In-Reply-To: <20201012140350.950064-1-bfoster@redhat.com>
References: <20201012140350.950064-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The iomap zero range mechanism currently skips unwritten mappings.
This is normally not a problem as most users synchronize in-core
state to the underlying block mapping by flushing pagecache prior to
calling into iomap. This is not always the case, however. For
example, XFS calls iomap_truncate_page() on truncate down before
flushing the new EOF page of the file. This means that if the new
EOF block is unwritten but covered by a dirty page (i.e. awaiting
unwritten conversion after writeback), iomap fails to zero that
page. The subsequent truncate_setsize() call does perform page
zeroing, but doesn't dirty the page. Therefore if the new EOF page
is written back after calling into iomap and before the pagecache
truncate, the post-EOF zeroing is lost on page reclaim. This exposes
stale post-EOF data on mapped reads.

To address this problem, update the iomap zero range mechanism to
explicitly zero ranges over unwritten extents where pagecache
happens to exist. This is similar to how iomap seek data works for
unwritten extents with cached data. In fact, we can reuse the same
mechanism to scan for pagecache over large unwritten mappings to
retain the same level of efficiency when zeroing large unwritten
(and non-dirty) ranges.

Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 39 +++++++++++++++++++++++++++++++++++++--
 fs/iomap/seek.c        |  2 +-
 include/linux/iomap.h  |  2 ++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..a07703d686da 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -944,6 +944,30 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
 }
 
+/*
+ * Seek data over an unwritten mapping and update the counters for the caller to
+ * perform zeroing, if necessary.
+ */
+static void
+iomap_zero_range_skip_uncached(struct inode *inode, loff_t *pos,
+		loff_t *count, loff_t *written)
+{
+	unsigned dirty_offset, bytes = 0;
+
+	dirty_offset = page_cache_seek_hole_data(inode, *pos, *count,
+				SEEK_DATA);
+	if (dirty_offset == -ENOENT)
+		bytes = *count;
+	else if (dirty_offset > *pos)
+		bytes = dirty_offset - *pos;
+
+	if (bytes) {
+		*pos += bytes;
+		*count -= bytes;
+		*written += bytes;
+	}
+}
+
 static loff_t
 iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
@@ -952,13 +976,24 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 	loff_t written = 0;
 	int status;
 
-	/* already zeroed?  we're done. */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	/* holes are already zeroed, we're done */
+	if (srcmap->type == IOMAP_HOLE)
 		return count;
 
 	do {
 		unsigned offset, bytes;
 
+		/*
+		 * Unwritten mappings are effectively zeroed on disk, but we
+		 * must zero any preexisting data pages over the range.
+		 */
+		if (srcmap->type == IOMAP_UNWRITTEN) {
+			iomap_zero_range_skip_uncached(inode, &pos, &count,
+				&written);
+			if (!count)
+				break;
+		}
+
 		offset = offset_in_page(pos);
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 981a74c8d60f..6804c1d5808e 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -71,7 +71,7 @@ page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
  *
  * Returns the resulting offset on successs, and -ENOENT otherwise.
  */
-static loff_t
+loff_t
 page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
 		int whence)
 {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..898c012f4f33 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -184,6 +184,8 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
 		const struct iomap_ops *ops);
 sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops);
+loff_t page_cache_seek_hole_data(struct inode *inode, loff_t offset,
+		loff_t length, int whence);
 
 /*
  * Structure for writeback I/O completions.
-- 
2.25.4

