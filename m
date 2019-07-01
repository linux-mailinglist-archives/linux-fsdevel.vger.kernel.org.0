Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9A5C560
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGAV4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:56:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAV4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MaH24b8xJDTj3Al9vqh9CsCx+cmy0ROZOe+AR4Iw4xw=; b=KLAOwSXvaZ3Tem/14IqmkfbGCw
        5PMDrMuNOcC+JnHpXlaUoJFTlr8FEHG3xXmDFjX90g59a7QUZ6lXV0WEtlFv2hFqJv6w6z1b6/jlk
        gs8TaAoj6rr7Q2CMOUCJNF6R7KVeiWD7AHRIE6zLV5CfFLfOb5wXDm3k/R/cSY0tHL0fiGZwUZg7Y
        ihAvMqReoiPnUnu9e/D8UvKLN2COuD9L+KBXL+w7I+A20/wH1nUWwBMzGufC27R7fdjQXd2vs7lR2
        xVORzyt/k1FikKYEN6T5t1oP6DEM397xO0fAHIPbkBEexVgi+UMKLKVpAszQpy26CMKfwsqQ93s5u
        9YooNc6Q==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4Hn-0001wQ-TN; Mon, 01 Jul 2019 21:56:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 14/15] gfs2: don't use buffer_heads in gfs2_allocate_page_backing
Date:   Mon,  1 Jul 2019 23:54:38 +0200
Message-Id: <20190701215439.19162-15-hch@lst.de>
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

Rewrite gfs2_allocate_page_backing to call gfs2_iomap_get_alloc and
operate on struct iomap directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/file.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 282a4aaab900..8c72e4cecd89 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -379,31 +379,30 @@ static void gfs2_size_hint(struct file *filep, loff_t offset, size_t size)
 }
 
 /**
- * gfs2_allocate_page_backing - Use bmap to allocate blocks
+ * gfs2_allocate_page_backing - Allocate blocks for a write fault
  * @page: The (locked) page to allocate backing for
  *
- * We try to allocate all the blocks required for the page in
- * one go. This might fail for various reasons, so we keep
- * trying until all the blocks to back this page are allocated.
- * If some of the blocks are already allocated, thats ok too.
+ * We try to allocate all the blocks required for the page in one go.  This
+ * might fail for various reasons, so we keep trying until all the blocks to
+ * back this page are allocated.  If some of the blocks are already allocated,
+ * that is ok too.
  */
-
 static int gfs2_allocate_page_backing(struct page *page)
 {
-	struct inode *inode = page->mapping->host;
-	struct buffer_head bh;
-	unsigned long size = PAGE_SIZE;
-	u64 lblock = page->index << (PAGE_SHIFT - inode->i_blkbits);
+	u64 pos = page_offset(page);
+	u64 size = PAGE_SIZE;
 
 	do {
-		bh.b_state = 0;
-		bh.b_size = size;
-		gfs2_block_map(inode, lblock, &bh, 1);
-		if (!buffer_mapped(&bh))
+		struct iomap iomap = { };
+
+		if (gfs2_iomap_get_alloc(page->mapping->host, pos, 1, &iomap))
 			return -EIO;
-		size -= bh.b_size;
-		lblock += (bh.b_size >> inode->i_blkbits);
-	} while(size > 0);
+
+		iomap.length = min(iomap.length, size);
+		size -= iomap.length;
+		pos += iomap.length;
+	} while (size > 0);
+
 	return 0;
 }
 
-- 
2.20.1

