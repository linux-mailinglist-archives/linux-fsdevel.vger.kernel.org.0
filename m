Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA4DE7E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfJUJTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:19:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40798 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUJTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:19:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so2062576pgt.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXYpc0cro87/nHCVGIIXxRN2QS+A1cGiS5XEmeketsE=;
        b=c7eXMkvFt9cJGS/VZPyzzfS37zcto4Na6irqp8KOLRSU8JPxcXe6dhoqQnAqKpIECx
         rG+JhpJXQWE6posQrBuwX2yn5iIuG+2fLcyAXGtutlM/OI9SEo5XUAp0KlHhUF/QXt+B
         24ityH4TV2LgKSxzUNd0WEwZfdHBkq1ki2DvhHxK6ymQdssmsjYhvTgqfIJCdVSlTor/
         4pm38nnQurjNW+TkenNynatRjona9WGlLB68Jc+kGldPdhmpbzCYTrDE58ULBv2qO1rF
         cYMZUucydxw44//N5G3IXmduTQ2uLkGxWKk7CXvc8HbA86xQuUbtsktGI0o+X/T+jqSw
         2mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXYpc0cro87/nHCVGIIXxRN2QS+A1cGiS5XEmeketsE=;
        b=IoI1dkbkMCdkyRHil0RBe1LxjWxVfcA9N0wrf5ysP/5s8ZthYHRl39M53oAxNTNJGH
         KyhvrbZ7e0N1HrJm2RjLLlI/A7smxyoka3LtTLqPslHGqvfoLqOJrR7M36PZhfozqE3H
         TyKbzjypxWg/X3Q+NRVQNll2nC+EVqOquiMEILvJuVvdzGZIUSs86HhPmG/W+OSPRRY/
         YM6hBA4AFkzBUzjbub7ioT6GVJFlTRobmR4PDhYgJoI02jdHHjoS3fqdhid9UzVgHrEQ
         yepnmHLzIuRwiGqeJTxYP1TU+Tfmp8NrihqdYPY+EcG34oRhNPGDqJtjnsiSgIIsQ298
         VZIg==
X-Gm-Message-State: APjAAAWGQGm+0+H92iOCVdMbt6Pt6V6hic3c87/8cE69ghzf1gqhEp2z
        0DUMIXLNSDIBTTc1g3XLqi5u
X-Google-Smtp-Source: APXvYqxNf0HnjCdftBi5e+jmoxnsF85LK2vYcKkIsQ3SVOAznHmDMnz8aWIa6yAJlhfex7FoC28GMQ==
X-Received: by 2002:a63:5909:: with SMTP id n9mr25370806pgb.101.1571649542631;
        Mon, 21 Oct 2019 02:19:02 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id s97sm22529154pjc.4.2019.10.21.02.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:19:02 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:18:56 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 09/12] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <629e86cf14761cdb716bce57feec9997abdd6ff6.1571647179.git.mbobrowski@mbobrowski.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
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
---
 fs/ext4/file.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 48 +--------------------------------
 2 files changed, 71 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8420686b90f5..6ddf00265988 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -33,6 +33,7 @@
 #include "ext4_jbd2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "truncate.h"
 
 static bool ext4_dio_supported(struct inode *inode)
 {
@@ -233,12 +234,77 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static ssize_t ext4_handle_inode_extension(struct inode *inode, ssize_t written,
+					   loff_t offset, size_t count)
+{
+	handle_t *handle;
+	bool truncate = false;
+	u8 blkbits = inode->i_blkbits;
+	ext4_lblk_t written_blk, end_blk;
+
+	/*
+	 * Note that EXT4_I(inode)->i_disksize can get extended up to
+	 * inode->i_size while the I/O was running due to the writeback of
+	 * delalloc blocks. But, the code in ext4_iomap_alloc() is careful to
+	 * use zeroed/unwritten extents if this is possible and thus we won't
+	 * leave uninitialized blocks in a file even if we didn't succeed in
+	 * writing as much as we planned.
+	 */
+	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
+	if (offset + count <= EXT4_I(inode)->i_disksize)
+		return written;
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
@@ -255,7 +321,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret)
 		goto out;
 
+	offset = iocb->ki_pos;
+	count = iov_iter_count(from);
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+	ret = ext4_handle_inode_extension(inode, ret, offset, count);
 out:
 	inode_unlock(inode);
 	if (ret > 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03a9e2b85e46..f79d15e8d3c6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3531,53 +3531,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

--<M>--
