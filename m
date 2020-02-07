Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9D155C85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBGRE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:04:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgBGRE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:04:28 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A068214AF;
        Fri,  7 Feb 2020 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581095067;
        bh=5ewvDjdoVFBAOmgJ4nH0Kff/uRNjLLLtKAb1itTyf0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXDqhvv3ARFC8SLcZHiVMRkrKpBS+23UFcc9goYJ27x+AW160kD23kxLtMq7VhmRp
         aefD8IBvhkzbODN2qAcLw3QzQ4v+caTIpPqmiHY5lCte5eZIkzY+6nRtaXPqBkvlHG
         qJmi7cL7x0RoGF3ymBe7xBZ6qaVJ12lt+y37OLCA=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: [PATCH v3 1/3] vfs: track per-sb writeback errors and report them to syncfs
Date:   Fri,  7 Feb 2020 12:04:21 -0500
Message-Id: <20200207170423.377931-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207170423.377931-1-jlayton@kernel.org>
References: <20200207170423.377931-1-jlayton@kernel.org>
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

To report those errors, we also need to keep an errseq_t for in struct
file to act as a cursor, but growing struct file for this purpose is
undesirable. We could just reuse f_wb_err, but someone could mix calls
to fsync and syncfs and that would break things.

This patch implements an alternative suggested by Willy. When the file
is opened with O_PATH, then we repurpose the f_wb_err cursor to track
s_wb_err. Any file opened with O_PATH will not have an fsync
file_operation, and attempts to fsync such a fd will return -EBADF.

Note that calling syncfs on an O_PATH descriptor today will also return
-EBADF, so this scheme gives userland a way to tell whether this
mechanism will work at runtime.

Cc: Andres Freund <andres@anarazel.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/open.c               | 6 +++---
 fs/sync.c               | 9 ++++++++-
 include/linux/fs.h      | 3 +++
 include/linux/pagemap.h | 5 ++++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..de10a0bf7697 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -744,12 +744,10 @@ static int do_dentry_open(struct file *f,
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 
-	/* Ensure that we skip any errors that predate opening of the file */
-	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
-
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		f->f_op = &empty_fops;
+		f->f_wb_err = errseq_sample(&f->f_path.dentry->d_sb->s_wb_err);
 		return 0;
 	}
 
@@ -759,6 +757,8 @@ static int do_dentry_open(struct file *f,
 		goto cleanup_file;
 	}
 
+	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
+
 	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
 		error = get_write_access(inode);
 		if (unlikely(error))
diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..8373d0372767 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -159,7 +159,7 @@ void emergency_sync(void)
  */
 SYSCALL_DEFINE1(syncfs, int, fd)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	struct super_block *sb;
 	int ret;
 
@@ -171,6 +171,13 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
 
+	if (f.file->f_flags & O_PATH) {
+		int ret2 = errseq_check_and_advance(&sb->s_wb_err,
+						    &f.file->f_wb_err);
+		if (ret == 0)
+			ret = ret2;
+	}
+
 	fdput(f);
 	return ret;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6eae91c0668f..bdbb0cbad03a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1514,6 +1514,9 @@ struct super_block {
 	/* Being remounted read-only */
 	int s_readonly_remount;
 
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
 	/* AIO completions deferred from interrupt context */
 	struct workqueue_struct *s_dio_done_wq;
 	struct hlist_head s_pins;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ccb14b6a16b5..897439475315 100644
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
2.24.1

