Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F362FD87C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 07:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbfJPFLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 01:11:08 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55830 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730411AbfJPFLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:11:08 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 28579362207;
        Wed, 16 Oct 2019 16:11:02 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iKbaP-0003aq-Gc; Wed, 16 Oct 2019 16:11:01 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iKbaP-0003IH-Cq; Wed, 16 Oct 2019 16:11:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: iomap that extends beyond EOF should be marked dirty
Date:   Wed, 16 Oct 2019 16:11:01 +1100
Message-Id: <20191016051101.12620-1-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8 a=S-1eUNTvgfi6r5ippUoA:9
        a=-LxSyIH3IyFY79c0:21 a=rj11tZLffgg5wOKJ:21
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
when O_DSYNC writes are beingt used and the hardware supports FUA.

Hence when setting IOMAP_F_DIRTY, we need to also take into account
whether the iomap spans the current EOF. If it does, then we need to
mark it dirty so that IO completion will call generic_write_sync()
to flush the inode size update to stable storage correctly.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/ext4/inode.c       | 9 ++++++++-
 fs/xfs/xfs_iomap.c    | 8 ++++++++
 include/linux/iomap.h | 2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

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
index f780e223b118..38be06f19ea2 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -722,6 +722,14 @@ xfs_file_iomap_begin_delay(
 		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
 		shared = true;
 	}
+
+	/*
+	 * Writes that span EOF might trigger an IO size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC even if
+	 * there is no other metadata changes being made or are pending here.
+	 */
+	if (offset + count > i_size_read(inode))
+		iomap->flags |= IOMAP_F_DIRTY;
 	error = xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
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
2.23.0.rc1

