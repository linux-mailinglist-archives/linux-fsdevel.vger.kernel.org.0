Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3AADED1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfIIS1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GVOTA/WB6JYIQ/b88BWzh6dan/N2HqjQ7uCHYY5lQOs=; b=WLi2y2bvv0Ja/X6rGUxbL33BT
        uCCL4AbKO8ibQmysXs6fcC9sGGPvfV/hQLEvzh7fip0wCI578ih1rm28gK61W2Fxi0hrTQXB4rdMb
        AH+B6qb0mTE6idmcXT8kmCkdjYj+SCk52USp5XRrODI1Kdq2eGwVxjNRlvIX4xGJdhkJgZB1uJ7A/
        CKl3+t4Shi0HzaRQ5k1z1p4D9BupNfPD5x5njImKfIYt+UqZ4oYpKAkFZEA4QfbuVVY6vRakZylDk
        qAXrIcm/I+FvtXPWM/fbDe9YmkaFs71jV2dp7khEV2oMTCUaDWFYSlDaB0m48UHtprzSnbdk4gxyC
        vc2jApowg==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ONu-0001tq-Ep; Mon, 09 Sep 2019 18:27:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/19] iomap: better document the IOMAP_F_* flags
Date:   Mon,  9 Sep 2019 20:27:04 +0200
Message-Id: <20190909182722.16783-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
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
---
 include/linux/iomap.h | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e79af6b28410..8adcc8dd4498 100644
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

