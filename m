Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA20EC9D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfJCLe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:34:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40037 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbfJCLeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:34:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so1573695pfb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FMTKEFXhOlLeJnylK8hi8xn6It6tAu38pI2D5z++hlU=;
        b=WyLMPmme7XOtAGG1ICIPMp1uvwtWjHaB+sbrXi5CllLngXcQgYURyT/5hW1QHtqyS+
         UKfEH2v0SUngv7yD3GPzUMOjfvWQVq11H+EFrlwyEsF5h7m32hLiaELSX8RK1anP54Xz
         W6WTBhLOUZh7XFvRlH6EKPy8KixcvMYKDw6iY1W365r+Qh5hQ2xKbEOF9z9G1jXdqvcF
         cgcMqYeJCt32/678KsRslWjzWriUGVIbXpPGNXDIlZMw5KK8+hyC5oR27GLnFuIvkulK
         Xe4HFjQ5LSbow+AartyEj3/Ko3i17gMNOVUy+D2rD8mrWRzmMeVLqD6fFD/uQxq9kZ32
         KqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FMTKEFXhOlLeJnylK8hi8xn6It6tAu38pI2D5z++hlU=;
        b=VjHrsUC97yIV1ug9Fp3OEQRld7KE69XZcbqV5G4ZhIs1cFaywaXRjgdZ5VwXdDD40w
         n1v100VXQsGWdbPvD8xsImXnSt3HREAe5T7HTCSPRpzaE0DV4QScMAvGAUejmcoJ2IJW
         4qH11XPT4C9Hhmjw5fTiQ+DuNpeXJaqM4HuJpI1Azpg2kz2RehJU10P5DjAmS5TgDhn/
         VCPCaXnmHa9oH/yaho+cbHAoI7XT4DuRPIIDV+E1/a4grUHUVoQeTTteVwE/Kv8wugH3
         s6O3fGY7x79oj2CsyuA2EPUWpZujuMWK3+wGdjadfFqsGMmu0Q/7O6uxhN3zVY2bYe1p
         hd2A==
X-Gm-Message-State: APjAAAVuzqGmfBdhzRx4HNYdOhMi/OgkJqRl4dgVoaw2p23c8e20Cups
        ZGv+QEs321SgxG9Oj8IN0eaA
X-Google-Smtp-Source: APXvYqyZMUogI5sremMVmQGnPKwbBbGoWQLTx4PeVKb528PU2cU639o7yvUhVkl4+nYxCZ/+d0+KVg==
X-Received: by 2002:a63:3709:: with SMTP id e9mr9045248pga.53.1570102464964;
        Thu, 03 Oct 2019 04:34:24 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id g12sm3026061pfb.97.2019.10.03.04.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:34:24 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:34:18 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 5/8] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
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

In preparation for implementing the iomap direct I/O write path
modifications, the inode extension/truncate code needs to be moved out
from ext4_iomap_end(). For direct I/O, if the current code remained
within ext4_iomap_end() it would behave incorrectly. Updating the
inode size prior to converting unwritten extents to written extents
will potentially allow a racing direct I/O read operation to find
unwritten extents before they've been correctly converted.

The inode extension/truncate code has been moved out into a new helper
ext4_handle_inode_extension(). This function has been designed so that
it can be used by both DAX and direct I/O paths.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/inode.c | 48 +-----------------------------
 2 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 69ac042fb74b..2883711e8a33 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -33,6 +33,7 @@
 #include "ext4_jbd2.h"
 #include "xattr.h"
 #include "acl.h"
+#include "truncate.h"
 
 static bool ext4_dio_supported(struct inode *inode)
 {
@@ -233,12 +234,82 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
+static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
+				       ssize_t written, size_t count)
+{
+	int ret = 0;
+	handle_t *handle;
+	bool truncate = false;
+	u8 blkbits = inode->i_blkbits;
+	ext4_lblk_t written_blk, end_blk;
+
+	/*
+         * Note that EXT4_I(inode)->i_disksize can get extended up to
+         * inode->i_size while the IO was running due to writeback of
+         * delalloc blocks. But the code in ext4_iomap_alloc() is careful
+         * to use zeroed / unwritten extents if this is possible and thus
+         * we won't leave uninitialized blocks in a file even if we didn't
+         * succeed in writing as much as we planned.
+         */
+	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
+	if (offset + count <= EXT4_I(inode)->i_disksize)
+		return written < 0 ? written : 0;
+
+	if (written < 0) {
+		ret = written;
+		goto truncate;
+	}
+
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto truncate;
+	}
+
+	if (ext4_update_inode_size(inode, offset + written))
+		ext4_mark_inode_dirty(handle, inode);
+
+	/*
+	 * We may need to truncate allocated but not written blocks
+	 * beyond EOF.
+	 */
+	written_blk = ALIGN(offset + written, 1 << blkbits);
+	end_blk = ALIGN(offset + count, 1 << blkbits);
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
+truncate:
+		ext4_truncate_failed_write(inode);
+		/*
+		 * If the truncate operation failed early, then the
+		 * inode may still be on the orphan list. In that
+		 * case, we need to try remove the inode from the
+		 * in-memory linked list.
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
+	int error;
 	ssize_t ret;
+	size_t count;
+	loff_t offset;
+	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -255,7 +326,13 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret)
 		goto out;
 
+	offset = iocb->ki_pos;
+	count = iov_iter_count(from);
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+
+	error = ext4_handle_inode_extension(inode, offset, ret, count);
+	if (error)
+		ret = error;
 out:
 	inode_unlock(inode);
 	if (ret > 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 159ffb92f82d..d616062b603e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3592,53 +3592,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

