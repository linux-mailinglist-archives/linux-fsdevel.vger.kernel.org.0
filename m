Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40DA6C9D6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfJCLeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:34:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35858 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfJCLeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:34:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so1391389plk.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M87IY+2KVSkzSC9nEbKGMnVlb0Np+3Hd+IxPBaWE+Zg=;
        b=sUMHGC5AT9lFKBhMdmRLRp7wEd3e4u+/zZBmXi2lFCshYiT0gisuTE8eqkUy6gcX/I
         jqA/UNRoqmREpUogZ18WisZ7bFnQGE1qFtxg7rn59xhjqgfb27cZTqDOwPxdRgv0jDqC
         At0YRNUbyOKuWsQ5/VH0WuHyS56xvqghqBg3WmwaAhOCS7LOuuFU5z94kBgys5BOtpko
         E51PLVTEe8ZN708Kyn4U3UK6gr9CcmturIr93KgkLIe7SfPLeDRmczYpTCxjjs76uuj6
         9yUQ1j5VGEIcQI3XxoWgTYEy6ZKEEJKCWH2+HkAo6HZmGwoyBuRLbPJLM7vNCGyG8bWP
         KoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M87IY+2KVSkzSC9nEbKGMnVlb0Np+3Hd+IxPBaWE+Zg=;
        b=rwo00a2LNE602wJcR1QhmONaC9+5fITa38k01L2wWgVDT1qTZ564+I+vgCQmYDh4P9
         Zu3C8isD1U3MOKRt87SBjloMRRFDIyy27mEGjW++FQsLFM6jfJYwuPbOJkoCPGvf4cBG
         RQPkHzb0tWahYdS4huAb3YFVWHK/0jaP/6ryfc4xlKTnIooW70CWGh/di30F3Siu8OgT
         15kRW4mp8lpl8HUlCrssPn7wPcZaewYJRll1lo13zIAhtWXvt+D5MtNAD66nvDu2OUe8
         bKe3TmmbgavriwkGjLJ9pm6y2F6vJG+9yefGzsehmtmxDw3gnoJTIDo1NKesuz0JjraI
         /fFQ==
X-Gm-Message-State: APjAAAVj1QFV0eUvqhv6kD84IjMeHC0EXSGVWyjRU+MuvlHeYAlHrWiI
        juXTtFa5icxOYDyPyHDhFpLF
X-Google-Smtp-Source: APXvYqx1zsMfZIWzud9Eq2w4T82QSZG8ZWV0cWl8HgHKmfvhN20VfB+cGpng4gaUyVHLC5zaXSs6gw==
X-Received: by 2002:a17:902:ac8a:: with SMTP id h10mr9106187plr.170.1570102447340;
        Thu, 03 Oct 2019 04:34:07 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id q14sm5855223pgf.74.2019.10.03.04.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:34:06 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:34:00 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 4/8] ext4: introduce direct I/O read path using iomap
 infrastructure
Message-ID: <df2b8a10641ec8a0509f137dcc2db1d3cc6087f1.1570100361.git.mbobrowski@mbobrowski.org>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new direct I/O read path that makes use of the
iomap infrastructure.

The new function ext4_dio_read_iter() is responsible for calling into
the iomap infrastructure via iomap_dio_rw(). If the read operation
being performed on the inode does not pass the preliminary checks
performed within ext4_dio_supported(), then we simply fallback to
buffered I/O in order to fulfil the request.

Existing direct I/O read buffer_head code has been removed as it's now
redundant.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 58 +++++++++++++++++++++++++++++++++++++++++++++----
 fs/ext4/inode.c | 32 +--------------------------
 2 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index ab75aee3e687..69ac042fb74b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -34,6 +34,53 @@
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
+	/*
+	 * Get exclusion from truncate and other inode operations.
+	 */
+	if (!inode_trylock_shared(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock_shared(inode);
+	}
+
+	if (!ext4_dio_supported(inode)) {
+		inode_unlock_shared(inode);
+		/*
+		 * Fallback to buffered I/O if the operation being
+		 * performed on the inode is not supported by direct
+		 * I/O. The IOCB_DIRECT flag needs to be cleared here
+		 * in order to ensure that the direct I/O path withiin
+		 * generic_file_read_iter() is not taken.
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		return generic_file_read_iter(iocb, to);
+	}
+
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL);
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -64,16 +111,19 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-#ifdef CONFIG_FS_DAX
-	if (IS_DAX(file_inode(iocb->ki_filp)))
+	if (IS_DAX(inode))
 		return ext4_dax_read_iter(iocb, to);
-#endif
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_read_iter(iocb, to);
 	return generic_file_read_iter(iocb, to);
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1dace576b8bd..159ffb92f82d 100644
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
 
@@ -3855,30 +3852,6 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
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
-	inode_lock_shared(inode);
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
@@ -3905,10 +3878,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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

