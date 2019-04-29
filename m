Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391E7EC89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfD2WJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:09:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbfD2WJq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:09:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00F4E307EA82;
        Mon, 29 Apr 2019 22:09:46 +0000 (UTC)
Received: from max.home.com (unknown [10.40.205.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E9BC57AA;
        Mon, 29 Apr 2019 22:09:43 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 1/5] iomap: Clean up __generic_write_end calling
Date:   Tue, 30 Apr 2019 00:09:30 +0200
Message-Id: <20190429220934.10415-2-agruenba@redhat.com>
In-Reply-To: <20190429220934.10415-1-agruenba@redhat.com>
References: <20190429220934.10415-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Apr 2019 22:09:46 +0000 (UTC)
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
Reviewed-by: Jan Kara <jack@suse.cz>
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

