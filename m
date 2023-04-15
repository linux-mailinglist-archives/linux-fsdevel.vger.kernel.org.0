Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9126E2F89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDOHpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDOHoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:44:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7922486A8;
        Sat, 15 Apr 2023 00:44:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5180af0e886so1137529a12.2;
        Sat, 15 Apr 2023 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544692; x=1684136692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aUzNSib1xZc4N397XkhllM7kWsYiTGLSPxW8fTLrLg=;
        b=WVFn5pYvfKGrsqMwyiypVB7vkhJ5P2GUPONFvv48C4qek8FMe5fTf6mFH0EsKrhvCQ
         KIHV5ex11xDPOhHH5XBWcSlIX3BBni+JvM7xQecyGMR9BXgSUEe6W/1nJhreYPJeoEtR
         6SedOs4bg2OwGPNWaiySdSoAZqllK9ZD94eHBTTQQB570R1Wcb3TI//Qeziu9y+OVXd5
         YimEkStskKrdcNrOijumamMiR+nRxPxCSVFgTSvOV/i/nJfuDYqDVSFsmeIFr9WIN4zw
         XcMVxxK4Up6+1S3KO4dnltsErCtufLvYyWSEij5cJmb4S3Wnam099nGelO6/2fen0+pD
         X6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544692; x=1684136692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aUzNSib1xZc4N397XkhllM7kWsYiTGLSPxW8fTLrLg=;
        b=eioknrazavQVai581Ttg6huTs9kXahufK31rnYOejBurcuF44twM7rQa6C7Ya96m9R
         zx0d+A3eGQn/yvRGRLvQqkGmIyfIZRTFA1iuRr2cQ5EME+SsBPEE4acP0jh7DyOWjIKl
         IqqyVzLrPCgp9elecX94zZMY7DrsmepmiWP/tkcvq+rQLDZVbdQ8oJ/hlGjY0K4nvCQb
         akOZj0Y1PbKEDzJ5ymPg15xAdxoum6/3A16VVMHlJ3raezVYkT2W+/CIotHu598xspx1
         ++sTxUxypCF77pKE5qNoQzUKm+dpwreftZ4b7ngJFvvo1hKAjjmhHOB2g2+LWYYXuo9G
         14zQ==
X-Gm-Message-State: AAQBX9fy3GXzh+eDn2EQ5kLVBDOYcL7NVTsy3ILRZ3UMvwfhzKoeoVk4
        RQirDEBHARTF4LsSq2Q00EYTNEe0tPQ=
X-Google-Smtp-Source: AKy350YUv4pndk80/2asqlsQ5hSjyKR6oaJ1rz1MKbgBJCERTnTrz2RF5erXdlwkMYkF8lML4AYOFw==
X-Received: by 2002:a05:6a00:1a43:b0:634:657e:546e with SMTP id h3-20020a056a001a4300b00634657e546emr11785404pfv.5.1681544692428;
        Sat, 15 Apr 2023 00:44:52 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:44:52 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv4 5/9] ext2: Move direct-io to use iomap
Date:   Sat, 15 Apr 2023 13:14:26 +0530
Message-Id: <78fed3db1cd6889b2c26866b9ce3c2538c7a77f7.1681544352.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681544352.git.ritesh.list@gmail.com>
References: <cover.1681544352.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
- ext2_iomap_ops are now being shared by DIO, DAX & fiemap path

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/ext2.h  |   1 +
 fs/ext2/file.c  | 115 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/inode.c |  53 ++++++++++++++--------
 3 files changed, 150 insertions(+), 19 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index cb78d7dcfb95..00168447d48c 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -753,6 +753,7 @@ extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
 extern struct inode *ext2_iget (struct super_block *, unsigned long);
 extern int ext2_write_inode (struct inode *, struct writeback_control *);
 extern void ext2_evict_inode(struct inode *);
+void ext2_write_failed(struct address_space *mapping, loff_t to);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
 extern int ext2_getattr (struct mnt_idmap *, const struct path *,
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 7603427fb38f..704abe0a79cb 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -164,12 +164,124 @@ int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
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
+		goto out;
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
+out:
+	return error;
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
 
@@ -179,6 +291,9 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(iocb->ki_filp->f_mapping->host))
 		return ext2_dax_write_iter(iocb, from);
 #endif
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext2_dio_write_iter(iocb, from);
+
 	return generic_file_write_iter(iocb, from);
 }
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dc76147e7b07..75983215c7a1 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -56,7 +56,7 @@ static inline int ext2_inode_is_fast_symlink(struct inode *inode)
 
 static void ext2_truncate_blocks(struct inode *inode, loff_t offset);
 
-static void ext2_write_failed(struct address_space *mapping, loff_t to)
+void ext2_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;
 
@@ -809,9 +809,27 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
+	if ((flags & IOMAP_DIRECT) &&
+	    (first_block << blkbits) < i_size_read(inode))
+		create = 0;
+
+	/*
+	 * Writes that span EOF might trigger an IO size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC even if
+	 * there is no other metadata changes pending or have been made here.
+	 */
+	if ((flags & IOMAP_WRITE) && offset + length > i_size_read(inode))
+		iomap->flags |= IOMAP_F_DIRTY;
 
 	ret = ext2_get_blocks(inode, first_block, max_blocks,
-			&bno, &new, &boundary, flags & IOMAP_WRITE);
+			&bno, &new, &boundary, create);
 	if (ret < 0)
 		return ret;
 
@@ -823,6 +841,12 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
@@ -844,6 +868,13 @@ static int
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
@@ -908,22 +939,6 @@ static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
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
@@ -946,7 +961,7 @@ const struct address_space_operations ext2_aops = {
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

