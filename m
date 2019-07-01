Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D712D5C550
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGAV4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:56:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wUN3msfIBmk8ExcsmdUqiIIJacel8TRXGTWr925TWE0=; b=S+Jg1ly1bRCvDygJpTrJGAGrGp
        WjxehwcokNW02Vwgt2qJU22suCwA9s1bqCNSlaRMyDkDedXdkOWT2Xp0rq5PKtN6XlCAjW3BDQ1nn
        gw7iVWzUUzn9kvEItbuxrZqu0diq5iVJFAr8/Bntv6fw0b7GR0ZVmehSd6evM+HDwefB/U/5Hy+gL
        qz61AW4JwOCZGin6+E1jcKGDHwuHZMuDOKP4MVL4ry6uSmVFzp6QZKxkViDC4E+XuEfEIAiVwjmlw
        dbQD2nkJNLWIIpckyEgqryYdRA4QZQxc7I1gR5ORr4sKJhPTy1RkeU6a4l2Zc3O1HGDlxvsuykGuT
        8D3QFCHA==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4HE-0001r2-GW; Mon, 01 Jul 2019 21:55:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 09/15] gfs2: merge gfs2_writeback_aops and gfs2_ordered_aops
Date:   Mon,  1 Jul 2019 23:54:33 +0200
Message-Id: <20190701215439.19162-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
References: <20190701215439.19162-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only difference between the two is that gfs2_ordered_aops sets the
set_page_dirty method to __set_page_dirty_buffers, but given that
__set_page_dirty_buffers is the default if no method is set there is
no need to to do that.  Merge the two sets of operations into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/aops.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3c58b40c93eb..3b3043332e5a 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -847,7 +847,7 @@ int gfs2_releasepage(struct page *page, gfp_t gfp_mask)
 	return 0;
 }
 
-static const struct address_space_operations gfs2_writeback_aops = {
+static const struct address_space_operations gfs2_aops = {
 	.writepage = gfs2_writepage,
 	.writepages = gfs2_writepages,
 	.readpage = gfs2_readpage,
@@ -861,21 +861,6 @@ static const struct address_space_operations gfs2_writeback_aops = {
 	.error_remove_page = generic_error_remove_page,
 };
 
-static const struct address_space_operations gfs2_ordered_aops = {
-	.writepage = gfs2_writepage,
-	.writepages = gfs2_writepages,
-	.readpage = gfs2_readpage,
-	.readpages = gfs2_readpages,
-	.set_page_dirty = __set_page_dirty_buffers,
-	.bmap = gfs2_bmap,
-	.invalidatepage = gfs2_invalidatepage,
-	.releasepage = gfs2_releasepage,
-	.direct_IO = noop_direct_IO,
-	.migratepage = buffer_migrate_page,
-	.is_partially_uptodate = block_is_partially_uptodate,
-	.error_remove_page = generic_error_remove_page,
-};
-
 static const struct address_space_operations gfs2_jdata_aops = {
 	.writepage = gfs2_jdata_writepage,
 	.writepages = gfs2_jdata_writepages,
@@ -891,15 +876,8 @@ static const struct address_space_operations gfs2_jdata_aops = {
 
 void gfs2_set_aops(struct inode *inode)
 {
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
-
-	if (gfs2_is_jdata(ip))
+	if (gfs2_is_jdata(GFS2_I(inode)))
 		inode->i_mapping->a_ops = &gfs2_jdata_aops;
-	else if (gfs2_is_writeback(sdp))
-		inode->i_mapping->a_ops = &gfs2_writeback_aops;
-	else if (gfs2_is_ordered(sdp))
-		inode->i_mapping->a_ops = &gfs2_ordered_aops;
 	else
-		BUG();
+		inode->i_mapping->a_ops = &gfs2_aops;
 }
-- 
2.20.1

