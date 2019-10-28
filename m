Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD6E6FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbfJ1KxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:53:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41460 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbfJ1KxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:53:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id l3so6634918pgr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JkX2KfEo2naL2qEFuKSRLVvDmaAU8/3Bc6817L+E8Fo=;
        b=wFXLXDkXFkiuS932MoMWKKCgq/2NDq8WyHUBVjvYvBmh/I8nZAV+vL/zYrQ60XeJW0
         g6LLNOYUH5MrblB0/PPiFMDfsyFhp7VQylcyrSFP2ivsg5qchkNaB8+6AyFgJgimMJ+r
         YoUeRyTtSD8b82d5Diu44nctHZMf0fBGfrNyRgCw+Ckbm5GkFO9NKYsttxoQjUCLYpT5
         lpkx31CVZRBU96KDAnIaer6+wHvVi9cHsCKZkzcLkQZHge1MLFvRUh4fj+y+oIY256kT
         EnViTUewHYs2fsxZVdTq81tYM/B7my0u9mdcr+UF9NkhYdx9Kx8eYJ5BccBs8nuOvowg
         N8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JkX2KfEo2naL2qEFuKSRLVvDmaAU8/3Bc6817L+E8Fo=;
        b=DZgChz/CYsVx5Pxptb54RvLg3XCYaJpHA9BaO3u08oqSc9KJYTS7qwIL5QfmK3heUw
         e2eEUnIQO7qZywtT5zqDHTmJiz6G649uiWvg0XUx7PyPFiz+dPqYTKvbLHpL8TUkiesN
         fhdqBFfAidYJGGI5dqkQ38u4xTXnK4I0eG7SG0Cj4hPMg/CpoAd5TKrkZWUE6euxLgZn
         qCyrWJipphWiY0cNBcwT1i2L+PzdnOyDZ3l0ajK53lmhrYIfmaAjR83SO7Sx1pacErFH
         e2iVDib53jq4guQnX6RFNON+Sod98uxKouUSAqb0X+dquWbpQuSZBhxyUfTpLEfgmdi8
         xHIg==
X-Gm-Message-State: APjAAAUIgGAFoB7JMC95BmZMCR2lj1eiZPRr/KUEAGnRHa/7fyQ0N385
        5Z16maT490hm+MYzp2kJTbox
X-Google-Smtp-Source: APXvYqx3pcz9KXKPtdjyS7gWSqmEwZrdpCykub2i5VQPovbMRLjVCCn2vHT2Q+iigaGhr2g3zmqS5A==
X-Received: by 2002:a17:90a:77c7:: with SMTP id e7mr21576092pjs.133.1572259978377;
        Mon, 28 Oct 2019 03:52:58 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id q34sm4113953pjb.15.2019.10.28.03.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:52:57 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:52:51 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 08/11] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <c0068ac9822568e1af6383a2f16667d2265a1d14.1572255426.git.mbobrowski@mbobrowski.org>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing the iomap direct I/O modifications,
the inode extension/truncate code needs to be moved out from the
ext4_iomap_end() callback. For direct I/O, if the current code
remained, it would behave incorrrectly. Updating the inode size prior
to converting unwritten extents would potentially allow a racing
direct I/O read to find unwritten extents before being converted
correctly.

The inode extension/truncate code now resides within a new helper
ext4_handle_inode_extension(). This function has been designed so that
it can accommodate for both DAX and direct I/O extension/truncate
operations.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c  | 89 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 48 +-------------------------
 2 files changed, 89 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 440f4c6ba4ee..ec54fec96a81 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -33,6 +33,7 @@
 #include "ext4_jbd2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "truncate.h"
 
 static bool ext4_dio_supported(struct inode *inode)
 {
@@ -234,12 +235,95 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
+					   ssize_t written, size_t count)
+{
+	handle_t *handle;
+	bool truncate = false;
+	u8 blkbits = inode->i_blkbits;
+	ext4_lblk_t written_blk, end_blk;
+
+	/*
+	 * Note that EXT4_I(inode)->i_disksize can get extended up to
+	 * inode->i_size while the I/O was running due to writeback of delalloc
+	 * blocks. But, the code in ext4_iomap_alloc() is careful to use
+	 * zeroed/unwritten extents if this is possible; thus we won't leave
+	 * uninitialized blocks in a file even if we didn't succeed in writing
+	 * as much as we intended.
+	 */
+	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
+	if (offset + count <= EXT4_I(inode)->i_disksize) {
+		/*
+		 * We need to ensure that the inode is removed from the orphan
+		 * list if it has been added prematurely, due to writeback of
+		 * delalloc blocks.
+		 */
+		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
+			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+
+			if (IS_ERR(handle)) {
+				ext4_orphan_del(NULL, inode);
+				return PTR_ERR(handle);
+			}
+
+			ext4_orphan_del(handle, inode);
+			ext4_journal_stop(handle);
+		}
+
+		return written;
+	}
+
+	if (written < 0)
+		goto truncate;
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle)) {
+		written = PTR_ERR(handle);
+		goto truncate;
+	}
+
+	if (ext4_update_inode_size(inode, offset + written))
+		ext4_mark_inode_dirty(handle, inode);
+
+	/*
+	 * We may need to truncate allocated but not written blocks beyond EOF.
+	 */
+	written_blk = ALIGN(offset + written, 1 << blkbits);
+	end_blk = ALIGN(offset + count, 1 << blkbits);
+	if (written_blk < end_blk && ext4_can_truncate(inode))
+		truncate = true;
+
+	/*
+	 * Remove the inode from the orphan list if it has been extended and
+	 * everything went OK.
+	 */
+	if (!truncate && inode->i_nlink)
+		ext4_orphan_del(handle, inode);
+	ext4_journal_stop(handle);
+
+	if (truncate) {
+truncate:
+		ext4_truncate_failed_write(inode);
+		/*
+		 * If the truncate operation failed early, then the inode may
+		 * still be on the orphan list. In that case, we need to try
+		 * remove the inode from the in-memory linked list.
+		 */
+		if (inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+	}
+
+	return written;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
+	size_t count;
+	loff_t offset;
+	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -256,7 +340,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret)
 		goto out;
 
+	offset = iocb->ki_pos;
+	count = iov_iter_count(from);
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+	ret = ext4_handle_inode_extension(inode, offset, ret, count);
 out:
 	inode_unlock(inode);
 	if (ret > 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e44b3b1dbbc4..7c21028760ee 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3543,53 +3543,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
-	int ret = 0;
-	handle_t *handle;
-	int blkbits = inode->i_blkbits;
-	bool truncate = false;
-
-	if (!(flags & IOMAP_WRITE) || (flags & IOMAP_FAULT))
-		return 0;
-
-	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-	if (IS_ERR(handle)) {
-		ret = PTR_ERR(handle);
-		goto orphan_del;
-	}
-	if (ext4_update_inode_size(inode, offset + written))
-		ext4_mark_inode_dirty(handle, inode);
-	/*
-	 * We may need to truncate allocated but not written blocks beyond EOF.
-	 */
-	if (iomap->offset + iomap->length > 
-	    ALIGN(inode->i_size, 1 << blkbits)) {
-		ext4_lblk_t written_blk, end_blk;
-
-		written_blk = (offset + written) >> blkbits;
-		end_blk = (offset + length) >> blkbits;
-		if (written_blk < end_blk && ext4_can_truncate(inode))
-			truncate = true;
-	}
-	/*
-	 * Remove inode from orphan list if we were extending a inode and
-	 * everything went fine.
-	 */
-	if (!truncate && inode->i_nlink &&
-	    !list_empty(&EXT4_I(inode)->i_orphan))
-		ext4_orphan_del(handle, inode);
-	ext4_journal_stop(handle);
-	if (truncate) {
-		ext4_truncate_failed_write(inode);
-orphan_del:
-		/*
-		 * If truncate failed early the inode might still be on the
-		 * orphan list; we need to make sure the inode is removed from
-		 * the orphan list in that case.
-		 */
-		if (inode->i_nlink)
-			ext4_orphan_del(NULL, inode);
-	}
-	return ret;
+	return 0;
 }
 
 const struct iomap_ops ext4_iomap_ops = {
-- 
2.20.1

