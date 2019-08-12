Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3A89ED0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfHLMxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 08:53:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46860 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHLMxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:53:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so12228476pgt.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Vbipj4+eihZzxo51YzihOO2X9LoXzHYbmGEO9001us=;
        b=rFxMmO6eC+fP4wjWTHQketd/xkPKXq1uc+nQ8DUJgDkjhP6PxeXmag/oPIBhGjiThJ
         dZzP8p1v4WeCH94/exiYpP46m7438HMIyzOy3uHbqpNw44qWhilsIkMuvcf6G5Hhx/TH
         Ssh6JmsdliWyyldWGc3OUK2L8z+95BAWeEgvb0E1Im1c9LODnoUVtOV2TxkkbGStiCgb
         pokQCw6cGvsgqNx2CQJVxEGwDIKa9NzRBF61NL3YRvqr2WbqrDjwz51VuBcfehinqS47
         gLhskkd7aLDvmNtKMxFXyAx0iauburpUSHmC2HwewmeEO+wg0//RqlpsxXFwiDRrUR+/
         sM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Vbipj4+eihZzxo51YzihOO2X9LoXzHYbmGEO9001us=;
        b=OeCzos0VFUvY/q37jbF5mq3FVjYoYHubtfnMtvFE7dkXTNxrIDkEjoV3xfU1eCMlYA
         zvr6ulMcrv+LuhyLm324BTg06aMMt4RhP1pPa6dfXth2p3ezSB/NWjN+QaF1IJbczWFZ
         kf1B/3n3ZOc2lm63LCOBIOb76Th4nwS7KdPGWllRTMO5bgeS9vENMrVJduZWG9esQGj9
         +rrv9y+IlOli9kHxSQedrkoLhGdP/WX3NQqvw+dDPuGh90BilV9jxUtxX5rOikIoVQta
         Z0jTfotIXR5Z//nOr6oH6cVuS5GAxEFOQRn6FqGmEIk9LIsmKKsI0crRpn55lcZgRSO/
         BmFw==
X-Gm-Message-State: APjAAAXRVEEQKCWtBCUHDPZpRvNnycOz1MwpRezrQp2x47S9gBNaQkxO
        /T6id61G70WW+2OfOO6WpF7j
X-Google-Smtp-Source: APXvYqx/1eBGbNoWg41wtmz6KfzQ4pR3b2gKl9EaOa5czUeWiPE2PrMR7rS1DJX+Z+bvrlKESkKixw==
X-Received: by 2002:a17:90a:b30f:: with SMTP id d15mr15647565pjr.19.1565614379605;
        Mon, 12 Aug 2019 05:52:59 -0700 (PDT)
Received: from neo.home (n1-42-37-191.mas1.nsw.optusnet.com.au. [1.42.37.191])
        by smtp.gmail.com with ESMTPSA id a12sm31391367pgv.48.2019.08.12.05.52.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:52:59 -0700 (PDT)
Date:   Mon, 12 Aug 2019 22:52:53 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        riteshh@linux.ibm.com
Subject: [PATCH 2/5] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <774754e9b2afc541df619921f7743d98c5c6a358.1565609891.git.mbobrowski@mbobrowski.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing the direct IO write code path modifications
that make us of iomap infrastructure we need to move out the inode
extension/truncate code from ext4_iomap_end() callback. For direct IO, if the
current code remained it would behave incorrectly. If we update the inode size
prior to converting unwritten extents we run the risk of allowing a racing
direct IO read operation to find unwritten extents before they are converted.

The inode extension/truncate has been moved out into a new function
ext4_handle_inode_extension(). This will be used by both direct IO and DAX
code paths if the write results with the inode being extended.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 48 +--------------------------------------------
 2 files changed, 60 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 360eff7b6aa2..7470800c63b7 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -33,6 +33,7 @@
 #include "ext4_jbd2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "truncate.h"
 
 static bool ext4_dio_checks(struct inode *inode)
 {
@@ -234,12 +235,62 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
+				       size_t count)
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
+	if (ext4_update_inode_size(inode, size))
+		ext4_mark_inode_dirty(handle, inode);
+
+	/*
+	 * We may need truncate allocated but not written blocks
+	 * beyond EOF.
+	 */
+	written_blk = ALIGN(size, 1 << blkbits);
+	end_blk = ALIGN(size + count, 1 << blkbits);
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
 #ifdef CONFIG_FS_DAX
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
+	int err;
 	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -257,6 +308,13 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+
+	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
+		err = ext4_handle_inode_extension(inode, iocb->ki_pos,
+						  iov_iter_count(from));
+		if (err)
+			ret = err;
+	}
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
2.16.4


-- 
Matthew Bobrowski
