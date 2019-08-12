Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E877989EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfHLMxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 08:53:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32962 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfHLMxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:53:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so49652920pfq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TrN9jj/LlObcVkYweCHjTmYpo2kmgBbwXOUgVfMBnrA=;
        b=06QChjBfyjnZqZAWFIQ17850PwYYqW530n5vk1JrsIJ21O67MYPidinxbWLqnZqn0e
         YkHQKI7TCVir8YgZa5hRV4o/DzBRgSaON9IXvXZvRknyYzEcIqJUm/BJR1mx1FTL41w3
         8XnVQ3KtPV+cgwOOwKKaIirz1wqD29x72/VBtabthC+sMwHR9hAs7tboFEkVuSrN0A06
         wKYY+aYov5u4UYq4O9JDWoyC4OuRqP5YXQau+cp0Xl+vywnZhuxxAs1IgMB1h/Spul3w
         3htc0u2EtXMex3jve3lwabtNt87k3FPj45raOSZfX2/Ny/22CkKHmlfAGT7eAeFXx4pl
         x9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TrN9jj/LlObcVkYweCHjTmYpo2kmgBbwXOUgVfMBnrA=;
        b=REJEMRrIiJ5GCfq9UqScnW9fcCkqRyxHr19FGNwaS73rgyT6/780K14QcQRY4BfcO+
         xAWvw+6qTzQwjjimOZgTz2G8nei9U42DYZ9JoCUWCF2+qv3OKentUppfB1eTHkMPPrBn
         MntCDztkHSrHcg11e6V1knQUvUl/6CmUFhVH2sQxeKXcgg4RCUrfupW9vMrB40cUjwG8
         IuV8xlh6+GjBEgfGJWLi3Zbkph/qgJRYgopjhtgYLQ1+ixi17AlCs8ZLzmJK8pyV0+A8
         NrzU7DgO41oNSXmKZa+VF9AAEZZ5NWH5Jx2nDKyx1LxxoScZrbQ9FG8Bp9yVPR1BiS5y
         n01Q==
X-Gm-Message-State: APjAAAVLQ/yJQf4sfaLZb57AdViC9nh1ipcpux6+GmKgzi9fNY1sm5u2
        bG11/ybmOI6TJpeNM45HeaTB
X-Google-Smtp-Source: APXvYqwbVoxqjogB9XVNxmMKgElmpt9BUDnNdn8vfgadbHTw7dtCMTNWZDJLZ5EGw2eeXFc6zJpQsg==
X-Received: by 2002:a17:90a:3be5:: with SMTP id e92mr3277710pjc.86.1565614412930;
        Mon, 12 Aug 2019 05:53:32 -0700 (PDT)
Received: from neo.home (n1-42-37-191.mas1.nsw.optusnet.com.au. [1.42.37.191])
        by smtp.gmail.com with ESMTPSA id j187sm12083108pfg.178.2019.08.12.05.53.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:53:32 -0700 (PDT)
Date:   Mon, 12 Aug 2019 22:53:26 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        riteshh@linux.ibm.com
Subject: [PATCH 4/5] ext4: introduce direct IO write code path using iomap
 infrastructure
Message-ID: <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
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

This patch introduces a new direct IO write code path implementation
that makes use of the iomap infrastructure.

All direct IO write operations are now passed from the ->write_iter() callback
to the new function ext4_dio_write_iter(). This function is responsible for
calling into iomap infrastructure via iomap_dio_rw(). Snippets of the direct
IO code from within ext4_file_write_iter(), such as checking whether the IO
request is unaligned asynchronous IO, or whether it will ber overwriting
allocated and initialized blocks has been moved out and into
ext4_dio_write_iter().

The block mapping flags that are passed to ext4_map_blocks() from within
ext4_dio_get_block() and friends have effectively been taken out and
introduced within the ext4_iomap_begin(). If ext4_map_blocks() happens to have
instantiated blocks beyond the i_size, then we attempt to place the inode onto
the orphan list. Despite being able to perform i_size extension checking
earlier on in the direct IO code path, it makes most sense to perform this bit
post successful block allocation.

The ->end_io() callback ext4_dio_write_end_io() is responsible for removing
the inode from the orphan list and determining if we should truncate a failed
write in the case of an error. We also convert a range of unwritten extents to
written if IOMAP_DIO_UNWRITTEN is set and perform the necessary
i_size/i_disksize extension if the iocb->ki_pos + dio->size > i_size_read(inode).

In the instance of a short write, we fallback to buffered IO and complete
whatever is left the 'iter'. Any blocks that may have been allocated in
preparation for direct IO will be reused by buffered IO, so there's no issue
with leaving allocated blocks beyond EOF.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 227 ++++++++++++++++++++++++++++++++++++++++----------------
 fs/ext4/inode.c |  42 +++++++++--
 2 files changed, 199 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7470800c63b7..d74576821676 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -29,6 +29,7 @@
 #include <linux/pagevec.h>
 #include <linux/uio.h>
 #include <linux/mman.h>
+#include <linux/backing-dev.h>
 #include "ext4.h"
 #include "ext4_jbd2.h"
 #include "xattr.h"
@@ -218,6 +219,14 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		return ret;
 
+	ret = file_remove_privs(iocb->ki_filp);
+	if (ret)
+		return 0;
+
+	ret = file_update_time(iocb->ki_filp);
+	if (ret)
+		return 0;
+
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
 
@@ -235,6 +244,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EOPNOTSUPP;
+		inode_lock(inode);
+	}
+
+	ret = ext4_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	current->backing_dev_info = inode_to_bdi(inode);
+	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
+	current->backing_dev_info = NULL;
+out:
+	inode_unlock(inode);
+	if (likely(ret > 0)) {
+		iocb->ki_pos += ret;
+		ret = generic_write_sync(iocb, ret);
+	}
+	return ret;
+}
+
 static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
 				       size_t count)
 {
@@ -284,6 +321,128 @@ static int ext4_handle_inode_extension(struct inode *inode, loff_t size,
 	return ret;
 }
 
+static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
+				 ssize_t error, unsigned int flags)
+{
+	int ret = 0;
+	handle_t *handle;
+	loff_t offset = iocb->ki_pos;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error) {
+		if (offset + size > i_size_read(inode))
+			ext4_truncate_failed_write(inode);
+
+		/*
+		 * The inode may have been placed onto the orphan list
+		 * as a result of an extension. However, an error may
+		 * have been encountered prior to being able to
+		 * complete the write operation. Perform any necessary
+		 * clean up in this case.
+		 */
+		if (!list_empty(&EXT4_I(inode)->i_orphan)) {
+			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+			if (IS_ERR(handle)) {
+				if (inode->i_nlink)
+					ext4_orphan_del(NULL, inode);
+				return PTR_ERR(handle);
+			}
+
+			if (inode->i_nlink)
+				ext4_orphan_del(handle, inode);
+			ext4_journal_stop(handle);
+		}
+		return error;
+	}
+
+	if (flags & IOMAP_DIO_UNWRITTEN) {
+		ret = ext4_convert_unwritten_extents(NULL, inode, offset, size);
+		if (ret)
+			return ret;
+	}
+
+	if (offset + size > i_size_read(inode)) {
+		ret = ext4_handle_inode_extension(inode, offset + size, 0);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t ret;
+	loff_t offset = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	bool extend = false, overwrite = false, unaligned_aio = false;
+
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock(inode);
+	}
+
+	if (!ext4_dio_checks(inode)) {
+		inode_unlock(inode);
+		/*
+		 * Fallback to buffered IO if the operation on the
+		 * inode is not supported by direct IO.
+		 */
+		return ext4_buffered_write_iter(iocb, from);
+	}
+
+	ret = ext4_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	/*
+	 * Unaligned direct AIO must be serialized among each other as
+	 * the zeroing of partial blocks of two competing unaligned
+	 * AIOs can result in data corruption.
+	 */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
+	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
+		unaligned_aio = true;
+		inode_dio_wait(inode);
+	}
+
+	/*
+	 * Determine whether the IO operation will overwrite allocated
+	 * and initialized blocks. If so, check to see whether it is
+	 * possible to take the dioread_nolock path.
+	 */
+	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
+	    ext4_should_dioread_nolock(inode)) {
+		overwrite = true;
+		downgrade_write(&inode->i_rwsem);
+	}
+
+	if (offset + count > i_size_read(inode) ||
+	    offset + count > EXT4_I(inode)->i_disksize) {
+		ext4_update_i_disksize(inode, inode->i_size);
+		extend = true;
+	}
+
+	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, ext4_dio_write_end_io);
+
+	/*
+	 * Unaligned direct AIO must be the only IO in flight or else
+	 * any overlapping aligned IO after unaligned IO might result
+	 * in data corruption.
+	 */
+	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
+		inode_dio_wait(inode);
+
+	if (ret >= 0 && iov_iter_count(from)) {
+		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
+		return ext4_buffered_write_iter(iocb, from);
+	}
+out:
+	overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -300,12 +459,6 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
-	ret = file_remove_privs(iocb->ki_filp);
-	if (ret)
-		goto out;
-	ret = file_update_time(iocb->ki_filp);
-	if (ret)
-		goto out;
 
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
@@ -327,10 +480,6 @@ static ssize_t
 ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	int o_direct = iocb->ki_flags & IOCB_DIRECT;
-	int unaligned_aio = 0;
-	int overwrite = 0;
-	ssize_t ret;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
@@ -339,61 +488,9 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(inode))
 		return ext4_dax_write_iter(iocb, from);
 #endif
-	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
-		return -EOPNOTSUPP;
-
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			return -EAGAIN;
-		inode_lock(inode);
-	}
-
-	ret = ext4_write_checks(iocb, from);
-	if (ret <= 0)
-		goto out;
-
-	/*
-	 * Unaligned direct AIO must be serialized among each other as zeroing
-	 * of partial blocks of two competing unaligned AIOs can result in data
-	 * corruption.
-	 */
-	if (o_direct && ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
-	    !is_sync_kiocb(iocb) &&
-	    ext4_unaligned_aio(inode, from, iocb->ki_pos)) {
-		unaligned_aio = 1;
-		ext4_unwritten_wait(inode);
-	}
-
-	iocb->private = &overwrite;
-	/* Check whether we do a DIO overwrite or not */
-	if (o_direct && !unaligned_aio) {
-		if (ext4_overwrite_io(inode, iocb->ki_pos, iov_iter_count(from))) {
-			if (ext4_should_dioread_nolock(inode))
-				overwrite = 1;
-		} else if (iocb->ki_flags & IOCB_NOWAIT) {
-			ret = -EAGAIN;
-			goto out;
-		}
-	}
-
-	ret = __generic_file_write_iter(iocb, from);
-	/*
-	 * Unaligned direct AIO must be the only IO in flight. Otherwise
-	 * overlapping aligned IO after unaligned might result in data
-	 * corruption.
-	 */
-	if (ret == -EIOCBQUEUED && unaligned_aio)
-		ext4_unwritten_wait(inode);
-	inode_unlock(inode);
-
-	if (ret > 0)
-		ret = generic_write_sync(iocb, ret);
-
-	return ret;
-
-out:
-	inode_unlock(inode);
-	return ret;
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_write_iter(iocb, from);
+	return ext4_buffered_write_iter(iocb, from);
 }
 
 #ifdef CONFIG_FS_DAX
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 761ce6286b05..9155a8a6eb0b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3533,8 +3533,38 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		if (IS_ERR(handle))
 			return PTR_ERR(handle);
 
-		ret = ext4_map_blocks(handle, inode, &map,
-				      EXT4_GET_BLOCKS_CREATE_ZERO);
+		if (IS_DAX(inode)) {
+			ret = ext4_map_blocks(handle, inode, &map,
+					      EXT4_GET_BLOCKS_CREATE_ZERO);
+		} else {
+			/*
+			 * DAX and direct IO are the only two
+			 * operations currently supported with
+			 * IOMAP_WRITE.
+			 */
+			WARN_ON(!(flags & IOMAP_DIRECT));
+			if (round_down(offset, i_blocksize(inode)) >=
+			    i_size_read(inode)) {
+				ret = ext4_map_blocks(handle, inode, &map,
+						      EXT4_GET_BLOCKS_CREATE);
+			} else if (!ext4_test_inode_flag(inode,
+							 EXT4_INODE_EXTENTS)) {
+				/*
+				 * We cannot fill holes in indirect
+				 * tree based inodes as that could
+				 * expose stale data in the case of a
+				 * crash. Use magic error code to
+				 * fallback to buffered IO.
+				 */
+				ret = ext4_map_blocks(handle, inode, &map, 0);
+				if (ret == 0)
+					ret = -ENOTBLK;
+			} else {
+				ret = ext4_map_blocks(handle, inode, &map,
+						      EXT4_GET_BLOCKS_IO_CREATE_EXT);
+			}
+		}
+
 		if (ret < 0) {
 			ext4_journal_stop(handle);
 			if (ret == -ENOSPC &&
@@ -3581,10 +3611,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
-		if (map.m_flags & EXT4_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
-		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
+		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
 			iomap->type = IOMAP_UNWRITTEN;
+		} else if (map.m_flags & EXT4_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
 		} else {
 			WARN_ON_ONCE(1);
 			return -EIO;
@@ -3601,6 +3631,8 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
+	if (flags & IOMAP_DIRECT && written == 0)
+		return -ENOTBLK;
 	return 0;
 }
 
-- 
2.16.4


-- 
Matthew Bobrowski
