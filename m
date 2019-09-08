Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE029AD125
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfIHXTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:19:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40383 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731201AbfIHXTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:19:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so7979946pfb.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 16:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NSL01mkUl8fEtBlCwOw2cj9yasSdvgdfrSqSeiKCTmQ=;
        b=Hc5ap/DFW2n2quEwo6i8ElkD/wvYVSJ8INTCfC7QW5Bf44rLm2V5h+dYg5hL4mGxGb
         Mi8nkEoY63QYWPZF6RXIKvcH+VzMRCj9yw7lEwFyecgDn783uehOx2sJpsbRsxAuHrLZ
         hq2h1gbcvQyrEPLXiBplmLGJFQv3Bw6OxmRaWdym4nXkz0E7DJO0EfWibAEJYKkyhHO+
         lR8Uysl1P0WxbiC5jRxHCZNNAqsdjlcPPsj2Zu/PIq/M/X2P4PlIyh/eVIK/KJfnrVXS
         XYuDfH9f4GZHfYydFN2oUORE+E+FHYqFqCK7LReN/XQ6UcU4zavtevFQmVkgUNs6ajuy
         nG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSL01mkUl8fEtBlCwOw2cj9yasSdvgdfrSqSeiKCTmQ=;
        b=JsC4R7TBBRc5ifziXz3kXzU/vaP5TVcfM98MktRzr/HuM7IRsQF4x8FpC+jyClyUe9
         PXgHxNkza13EXFbBoU8LoLadTsSFriZefAv9oW6yOb/NGRjnZiMk4epQNDalR/veTU1R
         AGz0wGtxyNv94wH1cauf2egMfCrqIsHWTJ/8g4iDFWBVYB9vuAh4J02v2fUeYekMm/+9
         JK/rAqnaB8ka0ivph7fD+wUklx8o9R7GB9Jq63zi688CZLLFv2ebJxZ7+saSuyAVOO9v
         pLTTyJwrPB2bWDtnU3wkwqE8dK/O53bnFb1HHCz53UMtiKOgfow+WofzsrBn3bbd6kmd
         EoxA==
X-Gm-Message-State: APjAAAXW7j4zW0sDSSL0l9wF5aOkR1vrA/yuG/+AGlSnipSXDHUBzJ8H
        PqYAwNiWaQ1WSzt6j13iA2gdTtIFwlNc
X-Google-Smtp-Source: APXvYqx+Wqr5mMuBQ66NOiGFoN5UlNdtQAbjv38+YJ/rfLZIyIz7GlmCQW9jjzaJL0D+zx0sFf3WpA==
X-Received: by 2002:a63:f907:: with SMTP id h7mr18832410pgi.418.1567984762022;
        Sun, 08 Sep 2019 16:19:22 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id u7sm10507007pgr.94.2019.09.08.16.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 16:19:21 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:19:15 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v2 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <c1e9b23ced988587dfec399021a5b62983745842.1567978633.git.mbobrowski@mbobrowski.org>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567978633.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing the iomap direct IO write path
modifications, the inode extension/truncate code needs to be moved out
from ext4_iomap_end(). For direct IO, if the current code remained
within ext4_iomap_end() it would behave incorrectly. If we update the
inode size prior to converting unwritten extents we run the risk of
allowing a racing direct IO read operation to find unwritten extents
before they are converted.

The inode extension/truncate code has been moved out into a new helper
ext4_handle_inode_extension(). This helper has been designed so that
it can be used by both DAX and direct IO paths in the instance that
the result of the write is extending the inode.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 48 +------------------------
 2 files changed, 93 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index e52e3928dc25..8e586198f6e6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -33,6 +33,7 @@
 #include "ext4_jbd2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "truncate.h"
 
 static bool ext4_dio_checks(struct inode *inode)
 {
@@ -233,12 +234,91 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
+				       ssize_t len, size_t count)
+{
+	handle_t *handle;
+	bool truncate = false;
+	ext4_lblk_t written_blk, end_blk;
+	int ret = 0, blkbits = inode->i_blkbits;
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto orphan_del;
+	}
+
+	if (ext4_update_inode_size(inode, offset + len))
+		ext4_mark_inode_dirty(handle, inode);
+
+	/*
+	 * We may need truncate allocated but not written blocks
+	 * beyond EOF.
+	 */
+	written_blk = ALIGN(offset + len, 1 << blkbits);
+	end_blk = ALIGN(offset + len + count, 1 << blkbits);
+	if (written_blk < end_blk && ext4_can_truncate(inode))
+		truncate = true;
+
+	/*
+	 * Remove the inode from the orphan list if it has been
+	 * extended and everything went OK.
+	 */
+	if (!truncate && inode->i_nlink)
+		ext4_orphan_del(handle, inode);
+	ext4_journal_stop(handle);
+
+	if (truncate) {
+		ext4_truncate_failed_write(inode);
+orphan_del:
+		/*
+		 * If the truncate operation failed early the inode
+		 * may still be on the orphan list. In that case, we
+		 * need try remove the inode from the linked list in
+		 * memory.
+		 */
+		if (inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+	}
+	return ret;
+}
+
+/*
+ * The inode may have been placed onto the orphan list or has had
+ * blocks allocated beyond EOF as a result of an extension. We need to
+ * ensure that any necessary cleanup routines are performed if the
+ * error path has been taken for a write.
+ */
+static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
+{
+	int ret = 0;
+	handle_t *handle;
+
+	if (size > i_size_read(inode))
+		ext4_truncate_failed_write(inode);
+
+	if (!list_empty(&EXT4_I(inode)->i_orphan)) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			if (inode->i_nlink)
+				ext4_orphan_del(NULL, inode);
+			return PTR_ERR(handle);
+		}
+		if (inode->i_nlink)
+			ext4_orphan_del(handle, inode);
+		ext4_journal_stop(handle);
+	}
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
+	int error = 0;
+	loff_t offset;
+	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -255,7 +335,18 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret)
 		goto out;
 
+	offset = iocb->ki_pos;
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+	if (ret > 0 && iocb->ki_pos > i_size_read(inode))
+		error = ext4_handle_inode_extension(inode, offset, ret,
+						    iov_iter_count(from));
+
+	if (ret < 0)
+		error = ext4_handle_failed_inode_extension(inode,
+							   iocb->ki_pos);
+
+	if (error)
+		ret = error;
 out:
 	inode_unlock(inode);
 	if (ret > 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..761ce6286b05 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3601,53 +3601,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

