Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE6CF34A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfJHHPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YfWwhWENJsPauXUqBHcMr/FGfj6Wya3g/y+7y4H6mSc=; b=VlEislf9CpzwQsfV4inAm6Y6MS
        ObmDYrnHLgxav7aCgJ3KDC+zbkQkOMAQ+oZKsXE/czCu/qmL4Z0i42Es90gVFh6HA9uDmnhftY5e9
        eVMjHUVfP9D+62ujlyu4gDQ9LziCFT9wjT6UakIFzyaLg6Cc2iDk0yeq0vW+JZNOjNXB7XanRnRYq
        cpHuNsn5u7muG8RmJtqYI+cKutaDx8LOKofFrE7ceDUqdrWzWoZrrxupXtW/3yqvHaMgtfMC4pvkp
        YqbF8/QMWt+QP4P3BIXYFroGs4CwliOdn/7pboVV84qBZnDxsMRK7yP+dGJ9Aqf58Pp/LdJtb3NXR
        SYKNtDjw==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjiX-0005SR-V3; Tue, 08 Oct 2019 07:15:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Allison Collins <allison.henderson@oracle.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 01/20] iomap: better document the IOMAP_F_* flags
Date:   Tue,  8 Oct 2019 09:15:08 +0200
Message-Id: <20191008071527.29304-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008071527.29304-1-hch@lst.de>
References: <20191008071527.29304-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The documentation for IOMAP_F_* is a bit disorganized, and doesn't
mention the fact that most flags are set by the file system and consumed
by the iomap core, while IOMAP_F_SIZE_CHANGED is set by the core and
consumed by the file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Allison Collins <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 include/linux/iomap.h | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 46ce730b1590..17cf63717681 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -30,21 +30,36 @@ struct vm_fault;
 #define IOMAP_INLINE	0x05	/* data inline in the inode */
 
 /*
- * Flags for all iomap mappings:
+ * Flags reported by the file system from iomap_begin:
+ *
+ * IOMAP_F_NEW indicates that the blocks have been newly allocated and need
+ * zeroing for areas that no data is copied to.
  *
  * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
  * written data and requires fdatasync to commit them to persistent storage.
+ *
+ * IOMAP_F_SHARED indicates that the blocks are shared, and will need to be
+ * unshared as part a write.
+ *
+ * IOMAP_F_MERGED indicates that the iomap contains the merge of multiple block
+ * mappings.
+ *
+ * IOMAP_F_BUFFER_HEAD indicates that the file system requires the use of
+ * buffer heads for this mapping.
  */
-#define IOMAP_F_NEW		0x01	/* blocks have been newly allocated */
-#define IOMAP_F_DIRTY		0x02	/* uncommitted metadata */
-#define IOMAP_F_BUFFER_HEAD	0x04	/* file system requires buffer heads */
-#define IOMAP_F_SIZE_CHANGED	0x08	/* file size has changed */
+#define IOMAP_F_NEW		0x01
+#define IOMAP_F_DIRTY		0x02
+#define IOMAP_F_SHARED		0x04
+#define IOMAP_F_MERGED		0x08
+#define IOMAP_F_BUFFER_HEAD	0x10
 
 /*
- * Flags that only need to be reported for IOMAP_REPORT requests:
+ * Flags set by the core iomap code during operations:
+ *
+ * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
+ * has changed as the result of this write operation.
  */
-#define IOMAP_F_MERGED		0x10	/* contains multiple blocks/extents */
-#define IOMAP_F_SHARED		0x20	/* block shared with another file */
+#define IOMAP_F_SIZE_CHANGED	0x100
 
 /*
  * Flags from 0x1000 up are for file system specific usage:
-- 
2.20.1

