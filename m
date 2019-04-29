Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92DFEC8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfD2WJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfD2WJz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:09:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B936307EA86;
        Mon, 29 Apr 2019 22:09:55 +0000 (UTC)
Received: from max.home.com (unknown [10.40.205.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4C4891C;
        Mon, 29 Apr 2019 22:09:52 +0000 (UTC)
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
Subject: [PATCH v7 4/5] iomap: Add a page_prepare callback
Date:   Tue, 30 Apr 2019 00:09:33 +0200
Message-Id: <20190429220934.10415-5-agruenba@redhat.com>
In-Reply-To: <20190429220934.10415-1-agruenba@redhat.com>
References: <20190429220934.10415-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Apr 2019 22:09:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the page_done callback into a separate iomap_page_ops structure and
add a page_prepare calback to be called before the next page is written
to.  In gfs2, we'll want to start a transaction in page_prepare and end
it in page_done.  Other filesystems that implement data journaling will
require the same kind of mechanism.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/gfs2/bmap.c        | 15 ++++++++++-----
 fs/iomap.c            | 36 ++++++++++++++++++++++++++----------
 include/linux/iomap.h | 22 +++++++++++++++++-----
 3 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 5da4ca9041c0..aa014725f84a 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -991,15 +991,20 @@ static void gfs2_write_unlock(struct inode *inode)
 	gfs2_glock_dq_uninit(&ip->i_gh);
 }
 
-static void gfs2_iomap_journaled_page_done(struct inode *inode, loff_t pos,
-				unsigned copied, struct page *page,
-				struct iomap *iomap)
+static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
+				 unsigned copied, struct page *page,
+				 struct iomap *iomap)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 
-	gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
+	if (page)
+		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
 }
 
+static const struct iomap_page_ops gfs2_iomap_page_ops = {
+	.page_done = gfs2_iomap_page_done,
+};
+
 static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 				  loff_t length, unsigned flags,
 				  struct iomap *iomap,
@@ -1077,7 +1082,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 		}
 	}
 	if (!gfs2_is_stuffed(ip) && gfs2_is_jdata(ip))
-		iomap->page_done = gfs2_iomap_journaled_page_done;
+		iomap->page_ops = &gfs2_iomap_page_ops;
 	return 0;
 
 out_trans_end:
diff --git a/fs/iomap.c b/fs/iomap.c
index 62e3461704ce..a3ffc83134ee 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -665,6 +665,7 @@ static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap)
 {
+	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct page *page;
 	int status = 0;
@@ -674,9 +675,17 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	if (page_ops && page_ops->page_prepare) {
+		status = page_ops->page_prepare(inode, pos, len, iomap);
+		if (status)
+			return status;
+	}
+
 	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		status = -ENOMEM;
+		goto out_no_page;
+	}
 
 	if (iomap->type == IOMAP_INLINE)
 		iomap_read_inline_data(inode, page, iomap);
@@ -684,15 +693,21 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		status = __block_write_begin_int(page, pos, len, NULL, iomap);
 	else
 		status = __iomap_write_begin(inode, pos, len, page, iomap);
-	if (unlikely(status)) {
-		unlock_page(page);
-		put_page(page);
-		page = NULL;
 
-		iomap_write_failed(inode, pos, len);
-	}
+	if (unlikely(status))
+		goto out_unlock;
 
 	*pagep = page;
+	return 0;
+
+out_unlock:
+	unlock_page(page);
+	put_page(page);
+	iomap_write_failed(inode, pos, len);
+
+out_no_page:
+	if (page_ops && page_ops->page_done)
+		page_ops->page_done(inode, pos, 0, NULL, iomap);
 	return status;
 }
 
@@ -766,6 +781,7 @@ static int
 iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 		unsigned copied, struct page *page, struct iomap *iomap)
 {
+	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -778,8 +794,8 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	}
 
 	__generic_write_end(inode, pos, ret, page);
-	if (iomap->page_done)
-		iomap->page_done(inode, pos, copied, page, iomap);
+	if (page_ops && page_ops->page_done)
+		page_ops->page_done(inode, pos, copied, page, iomap);
 	put_page(page);
 
 	if (ret < len)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0fefb5455bda..2103b94cb1bf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -53,6 +53,8 @@ struct vm_fault;
  */
 #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
 
+struct iomap_page_ops;
+
 struct iomap {
 	u64			addr; /* disk offset of mapping, bytes */
 	loff_t			offset;	/* file offset of mapping, bytes */
@@ -63,12 +65,22 @@ struct iomap {
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
 	void			*private; /* filesystem private */
+	const struct iomap_page_ops *page_ops;
+};
 
-	/*
-	 * Called when finished processing a page in the mapping returned in
-	 * this iomap.  At least for now this is only supported in the buffered
-	 * write path.
-	 */
+/*
+ * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
+ * and page_done will be called for each page written to.  This only applies to
+ * buffered writes as unbuffered writes will not typically have pages
+ * associated with them.
+ *
+ * When page_prepare succeeds, page_done will always be called to do any
+ * cleanup work necessary.  In that page_done call, @page will be NULL if the
+ * associated page could not be obtained.
+ */
+struct iomap_page_ops {
+	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len,
+			struct iomap *iomap);
 	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
 			struct page *page, struct iomap *iomap);
 };
-- 
2.20.1

