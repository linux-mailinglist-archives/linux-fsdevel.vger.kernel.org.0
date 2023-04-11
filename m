Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC896DD18A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjDKFWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDKFW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB412E7C;
        Mon, 10 Apr 2023 22:22:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o2so6770268plg.4;
        Mon, 10 Apr 2023 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190544; x=1683782544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4OBWt4hb3QmpUracP6ynNMaAuSkevsozSlp144nbIc=;
        b=kNcLZRajbigy6tfAt4yehv1Cxpgig06KlG2I20OmD3tEC33irSBCv00Q9KStE9BuLb
         gayvX/jbJqzG/QIciG4JXcMj90rD8F0jaVVvp7BXwoeSdEcaxgB//v94i4Lxn8IRx7yF
         fMofSrZs+z0C0UFv+j52LBCWI1i9WkqSeW52j8X9oX0y6vFIj53ZW/EMg+lZ6fMVrv0K
         KdvNRZW23BwhXw4zUl7a56mXlCPxJWesm8v1L45YldZWwXhckLED3hsjNixsRXk+7f42
         AVaTk9LFPOHzrWz/zCM9HkDjmnfgOV/8xjFbsCfffd+qH27HC34oe1zPWK2tXPHnPOWL
         TF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190544; x=1683782544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4OBWt4hb3QmpUracP6ynNMaAuSkevsozSlp144nbIc=;
        b=GJ/yE8J6Tu9Gh3p2VBDLDUZHqb1dx9xvQG1Xv8uARzJrYxaJAtnDRSUd3qFvjVplDc
         FL9GUqNUkDitlDNbx9XNy1SuanwaQqZDwvJj8KGJ5AfeQd3RwPN5Nu/otRSDFYhUKvn5
         e2IrducpiyVYpgCCyC5/Fq889JqXvEXzKY7mdlAb/g62HlSR67IuPnPq1Sh65YOj7nI7
         AvaLEOZ9ZlIhukoNkNGJqxaDW8OTHFz+pbh6jyhyPN0WXKmdgHEjRbHsVV2z8MY4EYJp
         YSeJxfJl5Tbte8DDf03P3M/1Gc5G1VMVGblUDMikCqnU5P3AhjwZI5di4XhoFQ78Ac/x
         o4NA==
X-Gm-Message-State: AAQBX9eYXCIXYaW/T2KhDuYKxmW5iwA2iyHL/P9q9QE4zAkEFY48DBqM
        X76L4u4WQgfVnWF1u3s1Ohg6YZlxtAE=
X-Google-Smtp-Source: AKy350b0RWBd+hlK0o5bxZEzGSt7klyJ5SELhhXcVcvuWRv8inb5PMEnCNCKmUpnmfKtNPah6QFg6A==
X-Received: by 2002:a17:90b:1d04:b0:23d:3913:bc26 with SMTP id on4-20020a17090b1d0400b0023d3913bc26mr15854948pjb.2.1681190543963;
        Mon, 10 Apr 2023 22:22:23 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:23 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 5/8] ext2: Move direct-io to use iomap
Date:   Tue, 11 Apr 2023 10:51:53 +0530
Message-Id: <e51f9a43f976d1b70d163fed791d960b88f044e2.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch converts ext2 direct-io path to iomap interface.
- This also takes care of DIO_SKIP_HOLES part in which we return -ENOTBLK
  from ext2_iomap_begin(), in case if the write is done on a hole.
- This fallbacks to buffered-io in case of DIO_SKIP_HOLES or in case of
  a partial write or if any error is detected in ext2_iomap_end().
  We try to return -ENOTBLK in such cases.
- For any unaligned or extending DIO writes, we pass
  IOMAP_DIO_FORCE_WAIT flag to ensure synchronous writes.
- For extending writes we set IOMAP_F_DIRTY in ext2_iomap_begin because
  otherwise with dsync writes on devices that support FUA, generic_write_sync
  won't be called and we might miss inode metadata updates.
- Since ext2 already now uses _nolock vartiant of sync write. Hence
  there is no inode lock problem with iomap in this patch.
- ext2_iomap_ops are not being shared by DIO, DAX & fiemap path

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/ext2.h  |   1 +
 fs/ext2/file.c  | 115 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/inode.c |  52 ++++++++++++++--------
 3 files changed, 149 insertions(+), 19 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index cb78d7dcfb95..cb5e309fe040 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -753,6 +753,7 @@ extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
 extern struct inode *ext2_iget (struct super_block *, unsigned long);
 extern int ext2_write_inode (struct inode *, struct writeback_control *);
 extern void ext2_evict_inode(struct inode *);
+extern void ext2_write_failed(struct address_space *mapping, loff_t to);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
 extern int ext2_getattr (struct mnt_idmap *, const struct path *,
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 1d0bc3fc88bb..3511ef85379f 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -163,12 +163,124 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return ret;
 }
 
+static ssize_t ext2_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	ssize_t ret;
+
+	inode_lock_shared(inode);
+	ret = iomap_dio_rw(iocb, to, &ext2_iomap_ops, NULL, 0, NULL, 0);
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+
+static int ext2_dio_write_end_io(struct kiocb *iocb, ssize_t size,
+				 int error, unsigned int flags)
+{
+	loff_t pos = iocb->ki_pos;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error)
+		return error;
+
+	/*
+	 * If we are extending the file, we have to update i_size here before
+	 * page cache gets invalidated in iomap_dio_rw(). This prevents racing
+	 * buffered reads from zeroing out too much from page cache pages.
+	 * Note that all extending writes always happens synchronously with
+	 * inode lock held by ext2_dio_write_iter(). So it is safe to update
+	 * inode size here for extending file writes.
+	 */
+	pos += size;
+	if (pos > i_size_read(inode)) {
+		i_size_write(inode, pos);
+		mark_inode_dirty(inode);
+	}
+
+	return 0;
+}
+
+static const struct iomap_dio_ops ext2_dio_write_ops = {
+	.end_io = ext2_dio_write_end_io,
+};
+
+static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	ssize_t ret;
+	unsigned int flags = 0;
+	unsigned long blocksize = inode->i_sb->s_blocksize;
+	loff_t offset = iocb->ki_pos;
+	loff_t count = iov_iter_count(from);
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_unlock;
+
+	ret = kiocb_modified(iocb);
+	if (ret)
+		goto out_unlock;
+
+	/* use IOMAP_DIO_FORCE_WAIT for unaligned or extending writes */
+	if (iocb->ki_pos + iov_iter_count(from) > i_size_read(inode) ||
+	   (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(from), blocksize)))
+		flags |= IOMAP_DIO_FORCE_WAIT;
+
+	ret = iomap_dio_rw(iocb, from, &ext2_iomap_ops, &ext2_dio_write_ops,
+			   flags, NULL, 0);
+
+	/* ENOTBLK is magic return value for fallback to buffered-io */
+	if (ret == -ENOTBLK)
+		ret = 0;
+
+	if (ret < 0 && ret != -EIOCBQUEUED)
+		ext2_write_failed(inode->i_mapping, offset + count);
+
+	/* handle case for partial write and for fallback to buffered write */
+	if (ret >= 0 && iov_iter_count(from)) {
+		loff_t pos, endbyte;
+		ssize_t status;
+		int ret2;
+
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		pos = iocb->ki_pos;
+		status = generic_perform_write(iocb, from);
+		if (unlikely(status < 0)) {
+			ret = status;
+			goto out_unlock;
+		}
+
+		iocb->ki_pos += status;
+		ret += status;
+		endbyte = pos + status - 1;
+		ret2 = filemap_write_and_wait_range(inode->i_mapping, pos,
+						    endbyte);
+		if (!ret2)
+			invalidate_mapping_pages(inode->i_mapping,
+						 pos >> PAGE_SHIFT,
+						 endbyte >> PAGE_SHIFT);
+		if (ret > 0)
+			generic_write_sync(iocb, ret);
+	}
+
+out_unlock:
+	inode_unlock(inode);
+	return ret;
+}
+
 static ssize_t ext2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 #ifdef CONFIG_FS_DAX
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_read_iter(iocb, to);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext2_dio_read_iter(iocb, to);
+
 	return generic_file_read_iter(iocb, to);
 }
 
@@ -178,6 +290,9 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_write_iter(iocb, from);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext2_dio_write_iter(iocb, from);
+
 	return generic_file_write_iter(iocb, from);
 }
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dc76147e7b07..e8e66156fc5e 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -56,7 +56,7 @@ static inline int ext2_inode_is_fast_symlink(struct inode *inode)
 
 static void ext2_truncate_blocks(struct inode *inode, loff_t offset);
 
-static void ext2_write_failed(struct address_space *mapping, loff_t to)
+void ext2_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;
 
@@ -809,9 +809,26 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	bool new = false, boundary = false;
 	u32 bno;
 	int ret;
+	bool create = flags & IOMAP_WRITE;
+
+	/*
+	 * For writes that could fill holes inside i_size on a
+	 * DIO_SKIP_HOLES filesystem we forbid block creations: only
+	 * overwrites are permitted.
+	 */
+	if ((flags & IOMAP_DIRECT) && (first_block << blkbits < i_size_read(inode)))
+		create = 0;
+
+	/*
+	 * Writes that span EOF might trigger an IO size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC even if
+	 * there is no other metadata changes pending or have been made here.
+	 */
+	if ((flags & IOMAP_WRITE) && (offset + length > i_size_read(inode)))
+		iomap->flags |= IOMAP_F_DIRTY;
 
 	ret = ext2_get_blocks(inode, first_block, max_blocks,
-			&bno, &new, &boundary, flags & IOMAP_WRITE);
+			&bno, &new, &boundary, create);
 	if (ret < 0)
 		return ret;
 
@@ -823,6 +840,12 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->bdev = inode->i_sb->s_bdev;
 
 	if (ret == 0) {
+		/*
+		 * Switch to buffered-io for writing to holes in a non-extent
+		 * based filesystem to avoid stale data exposure problem.
+		 */
+		if (!create && (flags & IOMAP_WRITE) && (flags & IOMAP_DIRECT))
+			return -ENOTBLK;
 		iomap->type = IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
 		iomap->length = 1 << blkbits;
@@ -844,6 +867,13 @@ static int
 ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 		ssize_t written, unsigned flags, struct iomap *iomap)
 {
+	/*
+	 * Switch to buffered-io in case of any error.
+	 * Blocks allocated can be used by the buffered-io path.
+	 */
+	if ((flags & IOMAP_DIRECT) && (flags & IOMAP_WRITE) && written == 0)
+		return -ENOTBLK;
+
 	if (iomap->type == IOMAP_MAPPED &&
 	    written < length &&
 	    (flags & IOMAP_WRITE))
@@ -908,22 +938,6 @@ static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
 
-static ssize_t
-ext2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	size_t count = iov_iter_count(iter);
-	loff_t offset = iocb->ki_pos;
-	ssize_t ret;
-
-	ret = blockdev_direct_IO(iocb, inode, iter, ext2_get_block);
-	if (ret < 0 && iov_iter_rw(iter) == WRITE)
-		ext2_write_failed(mapping, offset + count);
-	return ret;
-}
-
 static int
 ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
@@ -946,7 +960,7 @@ const struct address_space_operations ext2_aops = {
 	.write_begin		= ext2_write_begin,
 	.write_end		= ext2_write_end,
 	.bmap			= ext2_bmap,
-	.direct_IO		= ext2_direct_IO,
+	.direct_IO		= noop_direct_IO,
 	.writepages		= ext2_writepages,
 	.migrate_folio		= buffer_migrate_folio,
 	.is_partially_uptodate	= block_is_partially_uptodate,
-- 
2.39.2

