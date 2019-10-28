Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398DCE6FF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfJ1Kwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:52:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41885 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfJ1Kwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:52:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so5402091plr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0i4Q8lN5RfQHFAjF7mAEg7OwHhBhoJgtUkCfBexPhbI=;
        b=KGl2mnsqc3Dbgubqw/0YGsRP4gLcH1PBGTTzD1Ep1NHWIsrZR9xDqQIvYnr66fmESG
         fl8xcT2P2mRn/65SpHD4wCXoX9Zep6zqZwVizVOzsGoT7ViVo8qjvV3b1V619DftOX3v
         utd97ogd9IWCvcjjDJS2VyY7Ar4DmABnGVCoDIJ4oM+g7sy1GnFylmwpA9EZUToyjEV4
         p7Fn0VBsooii8KMOkTrSy32GzMEY9QctwKN+CTKVNM0mXkyWAlyTJIQsOnW3HvThXbck
         B3Sj/d9W9MlmniWYOeSCcqSJtqKkcGIRrzoaWhVNtUcYVeOIgcCDufGrD+fCunhMfr0x
         5DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0i4Q8lN5RfQHFAjF7mAEg7OwHhBhoJgtUkCfBexPhbI=;
        b=I/Fv1X6jGeddo6yP2dczeF28pIgnOZi34rhdTlteBa0Cd3kEacdpyJTK8Wo7XvWE3v
         8zUnZblJ9MWs4eHGeEgIuUW4CQ1QjeFBfbD+gmBZ8jySrwQVo8Ac6FlRIdhQzIBxrkjF
         p1f39rBMi5vCnIGmwaQUAW8tvSKhFqZZF/UTiADzid+si7QR/zMA75kuQayTabX722Q2
         0dFgP8PxnAdsCGYaahqlU+zyZWQ3NEeHtH2PAmiIkkLTwl9yiiLbsYWDJ0CR46Ojp+30
         LRn35CRInrFNeOPj/LVMOXyah7YUf70F8yotkdtdymYw2jQ1ZPsVINgwNVV04bFL8HmA
         gTPg==
X-Gm-Message-State: APjAAAW4Rk+4ErD22wRqYANAXFSgxh5tSYpVJsmZG5LhbBeBsiEJX0RC
        Gg3hS01I6qvsA1vg8z4VGYrS
X-Google-Smtp-Source: APXvYqz7TEe3ZK9d2rB1EifxOHSMlNyvoo/BxtoRGPtgQP54h6byaD36eca6DwXuFEwc0n/MJadlZg==
X-Received: by 2002:a17:902:848e:: with SMTP id c14mr17050134plo.77.1572259963862;
        Mon, 28 Oct 2019 03:52:43 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id x190sm11771535pfc.89.2019.10.28.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:52:43 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:52:37 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 07/11] ext4: introduce direct I/O read using iomap
 infrastructure
Message-ID: <eda85c07b12e1be305157e726a87fb0bde7190bc.1572255425.git.mbobrowski@mbobrowski.org>
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

This patch introduces a new direct I/O read path which makes use of
the iomap infrastructure.

The new function ext4_do_read_iter() is responsible for calling into
the iomap infrastructure via iomap_dio_rw(). If the read operation
performed on the inode is not supported, which is checked via
ext4_dio_supported(), then we simply fallback and complete the I/O
using buffered I/O.

Existing direct I/O read code path has been removed, as it is now
redundant.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/inode.c | 38 +---------------------------------
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index ab75aee3e687..440f4c6ba4ee 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -34,6 +34,52 @@
 #include "xattr.h"
 #include "acl.h"
 
+static bool ext4_dio_supported(struct inode *inode)
+{
+	if (IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode))
+		return false;
+	if (fsverity_active(inode))
+		return false;
+	if (ext4_should_journal_data(inode))
+		return false;
+	if (ext4_has_inline_data(inode))
+		return false;
+	return true;
+}
+
+static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
+	if (!ext4_dio_supported(inode)) {
+		inode_unlock_shared(inode);
+		/*
+		 * Fallback to buffered I/O if the operation being performed on
+		 * the inode is not supported by direct I/O. The IOCB_DIRECT
+		 * flag needs to be cleared here in order to ensure that the
+		 * direct I/O path within generic_file_read_iter() is not
+		 * taken.
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		return generic_file_read_iter(iocb, to);
+	}
+
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
+			   is_sync_kiocb(iocb));
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -64,16 +110,21 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
 #ifdef CONFIG_FS_DAX
-	if (IS_DAX(file_inode(iocb->ki_filp)))
+	if (IS_DAX(inode))
 		return ext4_dax_read_iter(iocb, to);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_read_iter(iocb, to);
+
 	return generic_file_read_iter(iocb, to);
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 50b4835cd927..e44b3b1dbbc4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -863,9 +863,6 @@ int ext4_dio_get_block(struct inode *inode, sector_t iblock,
 {
 	/* We don't expect handle for direct IO */
 	WARN_ON_ONCE(ext4_journal_current_handle());
-
-	if (!create)
-		return _ext4_get_block(inode, iblock, bh, 0);
 	return ext4_get_block_trans(inode, iblock, bh, EXT4_GET_BLOCKS_CREATE);
 }
 
@@ -3874,36 +3871,6 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	size_t count = iov_iter_count(iter);
-	ssize_t ret;
-
-	/*
-	 * Shared inode_lock is enough for us - it protects against concurrent
-	 * writes & truncates and since we take care of writing back page cache,
-	 * we are protected against page writeback as well.
-	 */
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!inode_trylock_shared(inode))
-			return -EAGAIN;
-	} else {
-		inode_lock_shared(inode);
-	}
-
-	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
-					   iocb->ki_pos + count - 1);
-	if (ret)
-		goto out_unlock;
-	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
-				   iter, ext4_dio_get_block, NULL, NULL, 0);
-out_unlock:
-	inode_unlock_shared(inode);
-	return ret;
-}
-
 static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -3930,10 +3897,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		return 0;
 
 	trace_ext4_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
-	if (iov_iter_rw(iter) == READ)
-		ret = ext4_direct_IO_read(iocb, iter);
-	else
-		ret = ext4_direct_IO_write(iocb, iter);
+	ret = ext4_direct_IO_write(iocb, iter);
 	trace_ext4_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), ret);
 	return ret;
 }
-- 
2.20.1

