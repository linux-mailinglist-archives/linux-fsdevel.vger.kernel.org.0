Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2EDE7DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJUJSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:18:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43909 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfJUJSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:18:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id l24so2480796pgh.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YrxpxReaT8CWp/KDbWeefXhO3dId6q5bBsNyhpQkn08=;
        b=HAlLj2b3vRgFsoJpIJv68i7YdwcBVDiz3GUP/teFiSEbPyIMH3S+1NaRe7pOX2Fytc
         9OUunkmyZ/q/2Z+VNrOPRy7UTOD4m8NTjdS638UgMr34J0uP6vhrg388wvI0Ks+90UIh
         4+aSjx1pi6SP97m1G7D7UKNSuKyqzm05V5NwpZmXIo6bSRGJkD1SKC4mZgH7GbQiQaTR
         9zTcgRzyX0vg3P1FWaA0Zg4EF37PIsMEqGDsOVpeQLZqXdApQlIrP9bNiYIey/9LlEWA
         26vtq0U64E4YPkIzkaE8cZmFydiA+vXy28DtWBgWjEugOPw0linEKXoeS8Lt38BEL2Ik
         IajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YrxpxReaT8CWp/KDbWeefXhO3dId6q5bBsNyhpQkn08=;
        b=gbMvC1IcQJeiAvNPJ7oCyTBfCZzodlLCVyUvb95JvpBvVO5T1sSBQ3XUqFSfOVKBPo
         5bVvprXYCxMXE5votl4Y75L9mwYNcjgpKGjA05zszvIxLjKjfOQMYJCTDhKrKxGEBljG
         INUjkJPYFwsfk13/QfFbGppif80+P3lcyujE5EhZOtJbZvmfYfSUSXYOG1SEnh+Q0cDg
         UTuI7qUC91Ff6CaACWIHJh4gbcHT/vj03JFl3XpjNamTm5re+ZDo/b9JFSlr1VzuJqrM
         LhGERSgqErn+2pNgqWTUl/oC8qQdD/Ik7Fs+RW8+Lymx+Q2llSYIgfu6hi58zMl8fCuh
         1xcg==
X-Gm-Message-State: APjAAAW3mTqmNKmmvG1lfvTjJe9QR3ueF1O/DZXxe3jRnn0z0r8vJ1dp
        y91WQn1cLNm0aMsM5FRRXmc+
X-Google-Smtp-Source: APXvYqz84j67g0GOVsL7u0Hb7lqOtAmxt7GOF+O6YCYcN/rKWhxAaGIT4bQcDkPYgRZGcyNtwwIP/w==
X-Received: by 2002:a17:90a:356a:: with SMTP id q97mr27561000pjb.50.1571649523832;
        Mon, 21 Oct 2019 02:18:43 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id s97sm22525437pjc.4.2019.10.21.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:18:43 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:18:37 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 07/12] ext4: introduce direct I/O read using iomap
 infrastructure
Message-ID: <280de880787dc7c064c309efb685f95d4ff732a9.1571647179.git.mbobrowski@mbobrowski.org>
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

This patch introduces a new direct I/O read path which makes use of
the iomap infrastructure.

The new function ext4_do_read_iter() is responsible for calling into
the iomap infrastructure via iomap_dio_rw(). If the read operation
performed on the inode is not supported, which is checked via
ext4_dio_supported(), then we simply fallback and complete the I/O
using buffered I/O.

Existing direct I/O read code path has been removed, as it is no
longer required.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 32 +-------------------------------
 2 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index ab75aee3e687..6ea7e00e0204 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -34,6 +34,46 @@
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
+static int ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	inode_lock_shared(inode);
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
@@ -64,7 +104,9 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
 	if (!iov_iter_count(to))
@@ -74,6 +116,8 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (IS_DAX(file_inode(iocb->ki_filp)))
 		return ext4_dax_read_iter(iocb, to);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_read_iter(iocb, to);
 	return generic_file_read_iter(iocb, to);
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ebeedbf3900f..03a9e2b85e46 100644
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
 
@@ -3865,30 +3862,6 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
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
@@ -3915,10 +3888,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
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

--<M>--
