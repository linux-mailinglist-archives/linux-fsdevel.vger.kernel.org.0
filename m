Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E80E7CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfD2Qcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 12:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbfD2Qcr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:32:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B32A5308FB9D;
        Mon, 29 Apr 2019 16:32:46 +0000 (UTC)
Received: from max.home.com (unknown [10.40.205.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFEC0190D7;
        Mon, 29 Apr 2019 16:32:41 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>
Cc:     Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 1/4] iomap: Clean up __generic_write_end calling
Date:   Mon, 29 Apr 2019 18:32:36 +0200
Message-Id: <20190429163239.4874-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 16:32:46 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Move the call to __generic_write_end into iomap_write_end instead of
duplicating it in each of the three branches.  This requires open coding
the generic_write_end for the buffer_head case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 97cb9d486a7d..2344c662e6fc 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -738,13 +738,11 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	 * uptodate page as a zero-length write, and force the caller to redo
 	 * the whole thing.
 	 */
-	if (unlikely(copied < len && !PageUptodate(page))) {
-		copied = 0;
-	} else {
-		iomap_set_range_uptodate(page, offset_in_page(pos), len);
-		iomap_set_page_dirty(page);
-	}
-	return __generic_write_end(inode, pos, copied, page);
+	if (unlikely(copied < len && !PageUptodate(page)))
+		return 0;
+	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_page_dirty(page);
+	return copied;
 }
 
 static int
@@ -761,7 +759,6 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	kunmap_atomic(addr);
 
 	mark_inode_dirty(inode);
-	__generic_write_end(inode, pos, copied, page);
 	return copied;
 }
 
@@ -774,12 +771,13 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	if (iomap->type == IOMAP_INLINE) {
 		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
 	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = generic_write_end(NULL, inode->i_mapping, pos, len,
-				copied, page, NULL);
+		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
+				page, NULL);
 	} else {
 		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
 	}
 
+	ret = __generic_write_end(inode, pos, ret, page);
 	if (iomap->page_done)
 		iomap->page_done(inode, pos, copied, page, iomap);
 
-- 
2.20.1

