Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B01A9F82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368636AbgDOMNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 08:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898111AbgDOMNE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:13:04 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B550F2076C;
        Wed, 15 Apr 2020 12:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586952783;
        bh=LNWj9wDcXQ6iD/C2ADh+aNOYEGak6DBi/YB8YeGejXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eP8x2ynt2dsZpxEWWWVjAgU3NHPYAoWmR++xSWjZ0TkfxVCNESaywGjMP7DBjHwiq
         xYt8N4pDz7Z2nXsapZQsIv/StT03DCH4H+AbdyfH9CLegITcMhWeiK7g2KCY0p3W6D
         GelKbnRBjnNTIq97URqMkE3golCiE/0Y39x5hnM0=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, david@fromorbit.com
Subject: [PATCH v5 1/2] vfs: track per-sb writeback errors and report them to syncfs
Date:   Wed, 15 Apr 2020 08:12:59 -0400
Message-Id: <20200415121300.228017-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200415121300.228017-1-jlayton@kernel.org>
References: <20200415121300.228017-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Usually we suggest that applications call fsync when they want to
ensure that all data written to the file has made it to the backing
store, but that can be inefficient when there are a lot of open
files.

Calling syncfs on the filesystem can be more efficient in some
situations, but the error reporting doesn't currently work the way most
people expect. If a single inode on a filesystem reports a writeback
error, syncfs won't necessarily return an error. syncfs only returns an
error if __sync_blockdev fails, and on some filesystems that's a no-op.

It would be better if syncfs reported an error if there were any writeback
failures. Then applications could call syncfs to see if there are any
errors on any open files, and could then call fsync on all of the other
descriptors to figure out which one failed.

This patch adds a new errseq_t to struct super_block, and has
mapping_set_error also record writeback errors there.

To report those errors, we also need to keep an errseq_t in struct
file to act as a cursor. This patch adds a dedicated field for that
purpose, which slots nicely into 4 bytes of padding at the end of
struct file on x86_64.

An earlier version of this patch used an O_PATH file descriptor to cue
the kernel that the open file should track the superblock error and not
the inode's writeback error.

I think that API is just too weird though. This is simpler and should
make syncfs error reporting "just work" even if someone is multiplexing
fsync and syncfs on the same fds.

Cc: Andres Freund <andres@anarazel.de>
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/dax/device.c    |  1 +
 fs/file_table.c         |  1 +
 fs/open.c               |  3 +--
 fs/sync.c               |  6 ++++--
 include/linux/fs.h      | 16 ++++++++++++++++
 include/linux/pagemap.h |  5 ++++-
 6 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 1af823b2fe6b..4c0af2eb7e19 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -377,6 +377,7 @@ static int dax_open(struct inode *inode, struct file *filp)
 	inode->i_mapping->a_ops = &dev_dax_aops;
 	filp->f_mapping = inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
+	filp->f_sb_err = file_sample_sb_err(filp);
 	filp->private_data = dev_dax;
 	inode->i_flags = S_DAX;
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 30d55c9a1744..676e620948d2 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -198,6 +198,7 @@ static struct file *alloc_file(const struct path *path, int flags,
 	file->f_inode = path->dentry->d_inode;
 	file->f_mapping = path->dentry->d_inode->i_mapping;
 	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
+	file->f_sb_err = file_sample_sb_err(file);
 	if ((file->f_mode & FMODE_READ) &&
 	     likely(fop->read || fop->read_iter))
 		file->f_mode |= FMODE_CAN_READ;
diff --git a/fs/open.c b/fs/open.c
index 719b320ede52..d9467a8a7f6a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -743,9 +743,8 @@ static int do_dentry_open(struct file *f,
 	path_get(&f->f_path);
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
-
-	/* Ensure that we skip any errors that predate opening of the file */
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
+	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..c6f6f5be5682 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -161,7 +161,7 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 {
 	struct fd f = fdget(fd);
 	struct super_block *sb;
-	int ret;
+	int ret, ret2;
 
 	if (!f.file)
 		return -EBADF;
@@ -171,8 +171,10 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
 
+	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
+
 	fdput(f);
-	return ret;
+	return ret ? ret : ret2;
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..5ad13cd6441c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -976,6 +976,7 @@ struct file {
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
+	errseq_t		f_sb_err; /* for syncfs */
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
@@ -1520,6 +1521,9 @@ struct super_block {
 	/* Being remounted read-only */
 	int s_readonly_remount;
 
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
 	/* AIO completions deferred from interrupt context */
 	struct workqueue_struct *s_dio_done_wq;
 	struct hlist_head s_pins;
@@ -2827,6 +2831,18 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 	return errseq_sample(&mapping->wb_err);
 }
 
+/**
+ * file_sample_sb_err - sample the current errseq_t to test for later errors
+ * @mapping: mapping to be sampled
+ *
+ * Grab the most current superblock-level errseq_t value for the given
+ * struct file.
+ */
+static inline errseq_t file_sample_sb_err(struct file *file)
+{
+	return errseq_sample(&file->f_path.dentry->d_sb->s_wb_err);
+}
+
 static inline int filemap_nr_thps(struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a8f7bd8ea1c6..d4409b13747e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -51,7 +51,10 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
 		return;
 
 	/* Record in wb_err for checkers using errseq_t based tracking */
-	filemap_set_wb_err(mapping, error);
+	__filemap_set_wb_err(mapping, error);
+
+	/* Record it in superblock */
+	errseq_set(&mapping->host->i_sb->s_wb_err, error);
 
 	/* Record it in flags for now, for legacy callers */
 	if (error == -ENOSPC)
-- 
2.25.2

