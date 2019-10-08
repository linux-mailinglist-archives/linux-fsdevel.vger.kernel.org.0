Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9984CF357
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfJHHPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfJHHPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bua0Urkf6H1bE/NzRSTojDe6/DYKq/IAO1Ngf0dzEw0=; b=A6Q/Msf06fHpidwmvgP3q8QIWn
        d6U1J3y2ZI3he91FDvNVuM4mc0JfE5c9c6BXWuw/+dcUCI6UGyLGRXnCKz4Cw9ine3qSIXPMPcU/n
        V02t5e9d/EH1Z+59OJykmwFpPapfOxVbvh923JptQWVURXe1pdm4wBoBkdCTKsjz8mDQMp99BG5bb
        33C5+2nvK2L2yYWEZFixRO0h8j8iH5c+HwwNMrjLNTGyhpickAHPe8n8z5IKSLF2IDez4xBKXdZ0u
        L9TsF5J5wSNM+PedVwBgeOOLug6CVuzrycRPtNbuceIf6Ug8tJ++z9LcjObjoiV3C4ke/CntZsgGQ
        aU6xGNsw==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjin-00063d-EF; Tue, 08 Oct 2019 07:15:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 07/20] iomap: renumber IOMAP_HOLE to 0
Date:   Tue,  8 Oct 2019 09:15:14 +0200
Message-Id: <20191008071527.29304-8-hch@lst.de>
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

Instead of keeping a separate unnamed state for uninitialized iomaps,
renumber IOMAP_HOLE to zero so that an uninitialized iomap is treated
as a hole.

Suggested-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/iomap.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 220f6b17a1a7..24c784e44274 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -23,11 +23,11 @@ struct vm_fault;
 /*
  * Types of block ranges for iomap mappings:
  */
-#define IOMAP_HOLE	0x01	/* no blocks allocated, need allocation */
-#define IOMAP_DELALLOC	0x02	/* delayed allocation blocks */
-#define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
-#define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
-#define IOMAP_INLINE	0x05	/* data inline in the inode */
+#define IOMAP_HOLE	0	/* no blocks allocated, need allocation */
+#define IOMAP_DELALLOC	1	/* delayed allocation blocks */
+#define IOMAP_MAPPED	2	/* blocks allocated at @addr */
+#define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
+#define IOMAP_INLINE	4	/* data inline in the inode */
 
 /*
  * Flags reported by the file system from iomap_begin:
-- 
2.20.1

