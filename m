Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A43CD255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 12:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhGSJ6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 05:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhGSJ6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3383C061574;
        Mon, 19 Jul 2021 02:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pHhLlVwFNZ4txpTZOqYueFGqumSPPzDr4uKgCGsw47E=; b=ORPZeINWAyUG4qec80r6ZTQYxj
        WWV4mtuD4dvPMac5mQ+Wx+oZ67zO0GsxDGSYYkBLZ6nNuIsOBDyw93LsPg33FFBoZKoYtpsIe/E+t
        AWwcI/38X57rJb8W5GL7Z2VngBEk3l359uBEhItoTn36+cWO5EYnVVAb6RGmqPXiKuBF0+pBcoD5g
        BavdKij9vjtMcXw5jU/DOjOEQNCfXEeu2XLcpyjGFvJyaa55HAjn2U7HodXVtulFaI++LiW/o4GyF
        9qcpz1M7a9cKjovUnzu14iPDz6gauIm1R883AVvg5++wyB7Z6mUv158ohTs1K9kXNAt6t+aFh5/dO
        aqJSYB8A==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5QdN-006kUd-0F; Mon, 19 Jul 2021 10:36:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 02/27] iomap: remove the iomap arguments to ->page_{prepare,done}
Date:   Mon, 19 Jul 2021 12:34:55 +0200
Message-Id: <20210719103520.495450-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These aren't actually used by the only instance implementing the methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/bmap.c         | 5 ++---
 fs/iomap/buffered-io.c | 6 +++---
 include/linux/iomap.h  | 5 ++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ed8b67b2171817..5414c2c3358092 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1002,7 +1002,7 @@ static void gfs2_write_unlock(struct inode *inode)
 }
 
 static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
-				   unsigned len, struct iomap *iomap)
+				   unsigned len)
 {
 	unsigned int blockmask = i_blocksize(inode) - 1;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -1013,8 +1013,7 @@ static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
 }
 
 static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
-				 unsigned copied, struct page *page,
-				 struct iomap *iomap)
+				 unsigned copied, struct page *page)
 {
 	struct gfs2_trans *tr = current->journal_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438becd9..75310f6fcf8401 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -605,7 +605,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		return -EINTR;
 
 	if (page_ops && page_ops->page_prepare) {
-		status = page_ops->page_prepare(inode, pos, len, iomap);
+		status = page_ops->page_prepare(inode, pos, len);
 		if (status)
 			return status;
 	}
@@ -638,7 +638,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 
 out_no_page:
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, 0, NULL, iomap);
+		page_ops->page_done(inode, pos, 0, NULL);
 	return status;
 }
 
@@ -714,7 +714,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, ret, page, iomap);
+		page_ops->page_done(inode, pos, ret, page);
 	put_page(page);
 
 	if (ret < len)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 479c1da3e2211e..093519d91cc9cc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -108,10 +108,9 @@ iomap_sector(struct iomap *iomap, loff_t pos)
  * associated page could not be obtained.
  */
 struct iomap_page_ops {
-	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len,
-			struct iomap *iomap);
+	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len);
 	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
-			struct page *page, struct iomap *iomap);
+			struct page *page);
 };
 
 /*
-- 
2.30.2

