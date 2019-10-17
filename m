Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E58DB511
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437630AbfJQR4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:56:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394803AbfJQR4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QzGPehL/LYwSmCTY32Q5ZOorcnSwSCBwuqtJOILTM+M=; b=dTyVYmoY5u9vzph8Xkfu+KfudI
        Fd3xKjuV3dylW/8NGdT138VCHTWV13ZhSnXSoy5yLz9p8f6TBCWGzMdKm0pi+avQXCP8+2cH8QoXL
        2fRRnjCpbQrPDX51yty99IiMWa0KmdZqfPUd2P7s2AwuLZPveNrSZbw670KOtMceW9L5+32jtxqTB
        qQTOnS3I93kPc1ODy3cIoxQqveMOJFNMjW2qQpZZ23tdo7RFFpaRMx8ln1SDqZPfPSHenbMDYeq5p
        4GMjZ+yhS4R2tlbuoIRI+Cplqdy/1YKAoh5dRjlMa0WB56QRzl8HNnka/Sl5C/LYcn7Rj9136CI5D
        SloKU/jA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA0j-0000gl-GW; Thu, 17 Oct 2019 17:56:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 01/14] iomap: iomap that extends beyond EOF should be marked dirty
Date:   Thu, 17 Oct 2019 19:56:11 +0200
Message-Id: <20191017175624.30305-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
References: <20191017175624.30305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

When doing a direct IO that spans the current EOF, and there are
written blocks beyond EOF that extend beyond the current write, the
only metadata update that needs to be done is a file size extension.

However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
there is IO completion metadata updates required, and hence we may
fail to correctly sync file size extensions made in IO completion
when O_DSYNC writes are being used and the hardware supports FUA.

Hence when setting IOMAP_F_DIRTY, we need to also take into account
whether the iomap spans the current EOF. If it does, then we need to
mark it dirty so that IO completion will call generic_write_sync()
to flush the inode size update to stable storage correctly.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/inode.c       | 9 ++++++++-
 fs/xfs/xfs_iomap.c    | 7 +++++++
 include/linux/iomap.h | 2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ced..e9dc52537e5b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3523,9 +3523,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			return ret;
 	}
 
+	/*
+	 * Writes that span EOF might trigger an IO size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC even if
+	 * there is no other metadata changes being made or are pending here.
+	 */
 	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode))
+	if (ext4_inode_datasync_dirty(inode) ||
+	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
+
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->dax_dev = sbi->s_daxdev;
 	iomap->offset = (u64)first_block << blkbits;
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f780e223b118..32993c2acbd9 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1049,6 +1049,13 @@ xfs_file_iomap_begin(
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
 
 out_finish:
+	/*
+	 * Writes that span EOF might trigger an IO size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC even if
+	 * there is no other metadata changes pending or have been made here.
+	 */
+	if ((flags & IOMAP_WRITE) && offset + length > i_size_read(inode))
+		iomap->flags |= IOMAP_F_DIRTY;
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
 
 out_found:
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 7aa5d6117936..24bd227d59f9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -32,6 +32,8 @@ struct vm_fault;
  *
  * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
  * written data and requires fdatasync to commit them to persistent storage.
+ * This needs to take into account metadata changes that *may* be made at IO
+ * completion, such as file size updates from direct IO.
  */
 #define IOMAP_F_NEW		0x01	/* blocks have been newly allocated */
 #define IOMAP_F_DIRTY		0x02	/* uncommitted metadata */
-- 
2.20.1

