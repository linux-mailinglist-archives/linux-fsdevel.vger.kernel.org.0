Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40EEBEFCDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 13:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfKEMBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 07:01:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46195 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfKEMBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:01:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id f19so13965133pgn.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6LibSywqRXYWNf37STd+dCRG3O5Iq29JKhK3bKCXC1M=;
        b=CQTh26qnHLvJp4R7YJ7HUoMMH8QKakW5Bs+bEAqxTf+TrjmjvjW9wGx8vSaSMKPuRE
         eytfZ4TXZd6u6sCpAXNJobbqFbfb2TtQWdc6ZoeJhs8VgOAwC5IRbHaQtTy41UipWKEy
         z864eG35bZh2hyRIyas1BtKz9LPOuGmZS2nCPCDCa0yG9aEJE8hExpLU9OKmIniZMOdc
         yW9Xk9Ymvh2H1+40Kk+6hg44MIX3Z57ZNV8rUR0PJhW78s0F/5SGTpTjg5wswrzZDCtN
         JMwlwBd00RUztptucvamfBcpZmflHE4IO5l3vFmUmJip3rd5TO1DbmhNsMo3Od9FtchE
         f3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LibSywqRXYWNf37STd+dCRG3O5Iq29JKhK3bKCXC1M=;
        b=q55b6aDxCzEaxIVRniqku9jd7PhdjqGp+X/fUFKzj26q+rP5kXA//XkrW3zUSBt6Zh
         UjmtDxlLg8dCmh4F0BWDY4sKlLToRI6/YSrzSd3wzW6bGBVZUw7JopidNhigb3omwIRW
         xo9QL7c841oqXdFnt1i7naxiVNFEcqe3U9LM+VY4ZfDL+m6XQYHjurX189MuH3evPoPg
         IfTiQnr2HFPgv0lm2D7e9KR5fthvYocA3egJeFYsYzBWSgviw+kJJnddMc+SNAxX2sG2
         yukmu4ZkbN3xGUpLhL/DrnyXsPJ+W8XTH7RQsDxNJKaSOt7/4I6Uk0jRgHeOnjI0S27C
         Z+KA==
X-Gm-Message-State: APjAAAXdgskAtiiAvCn2yhL1vxwTfHitL0tEsbSzs5Yz0iFsYWeDZL8k
        wDsIJ+PMgMuxxbVw4oFm+f3b
X-Google-Smtp-Source: APXvYqxGgRwW6wQeS06JUD8OJFOjC9nZ0rdGXWb/h+t0ik9/XB+YjEWTAK65t+EWoZGOPI8KAINd1Q==
X-Received: by 2002:a17:90a:9741:: with SMTP id i1mr6282771pjw.2.1572955303619;
        Tue, 05 Nov 2019 04:01:43 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id f189sm28845329pgc.94.2019.11.05.04.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 04:01:42 -0800 (PST)
Date:   Tue, 5 Nov 2019 23:01:37 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 07/11] ext4: introduce direct I/O read using iomap
 infrastructure
Message-ID: <f98a6f73fadddbfbad0fc5ed04f712ca0b799f37.1572949325.git.mbobrowski@mbobrowski.org>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572949325.git.mbobrowski@mbobrowski.org>
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
index b5ba6767b276..9bd80df6b856 100644
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
 
@@ -3916,36 +3913,6 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -3972,10 +3939,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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

