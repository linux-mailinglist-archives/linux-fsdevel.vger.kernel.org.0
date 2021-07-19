Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40FA3CD2E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhGSKSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhGSKSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:18:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C1C061574;
        Mon, 19 Jul 2021 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L2dn47BW8cimA4OGCXzIvd0BRf0hak7es3Cdvb274Qs=; b=nHomzFZHdFHlfMS42qKgf9Udd/
        iBRpU4ViMMrrYu6MndRcg1H9xxzCxUZjNH6NVD1jBw1GzvGITB3lRolwAfaUkrmCaI6RmXSIo/Dko
        F/b0tKH3d6Pf+YxoZIqZ4EWuu/YzmCbrbDtaMowj5VLV9BmcMaAwgwXtoFpZ/FtoyfCAdaM1PVL0j
        3JfqIrwdne/VIpctpcGxGIrnLiEfHUhFWTs/cgplteOEgKQNnWCtPWy8I3zSYxJmGPFP1EqwOGIEc
        DEk9+NmCUULUId4XsWQfp8Y1WHOl6CaWtKRO6AI1ZqZ1rF/pRDbvxXlSTRaT5P3RR59Gw3MgzYaLx
        wmvwJzxQ==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Qwj-006m1S-EQ; Mon, 19 Jul 2021 10:56:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 18/27] iomap: switch iomap_seek_data to use iomap_iter
Date:   Mon, 19 Jul 2021 12:35:11 +0200
Message-Id: <20210719103520.495450-19-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite iomap_seek_data to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/seek.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 7d6ed9af925e96..0a758e3851fcb7 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -55,23 +55,21 @@ iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
-static loff_t
-iomap_seek_data_actor(struct inode *inode, loff_t start, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_seek_data_iter(const struct iomap_iter *iter, loff_t *pos)
 {
-	loff_t offset = start;
+	loff_t length = iomap_length(iter);
 
-	switch (iomap->type) {
+	switch (iter->iomap.type) {
 	case IOMAP_HOLE:
 		return length;
 	case IOMAP_UNWRITTEN:
-		offset = mapping_seek_hole_data(inode->i_mapping, start,
-				start + length, SEEK_DATA);
-		if (offset < 0)
+		*pos = mapping_seek_hole_data(iter->inode->i_mapping,
+				iter->pos, iter->pos + length, SEEK_DATA);
+		if (*pos < 0)
 			return length;
-		fallthrough;
+		return 0;
 	default:
-		*(loff_t *)data = offset;
+		*pos = iter->pos;
 		return 0;
 	}
 }
@@ -80,22 +78,24 @@ loff_t
 iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t ret;
+	struct iomap_iter iter = {
+		.inode	= inode,
+		.pos	= offset,
+		.flags	= IOMAP_REPORT,
+	};
+	int ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
-	while (offset < size) {
-		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
-				  ops, &offset, iomap_seek_data_actor);
-		if (ret < 0)
-			return ret;
-		if (ret == 0)
-			return offset;
-		offset += ret;
-	}
-
+	iter.len = size - offset;
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_seek_data_iter(&iter, &offset);
+	if (ret < 0)
+		return ret;
+	if (iter.len)
+		return offset;
 	/* We've reached the end of the file without finding data */
 	return -ENXIO;
 }
-- 
2.30.2

