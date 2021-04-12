Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105A335C3CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhDLKYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 06:24:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237798AbhDLKX5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0716DB134;
        Mon, 12 Apr 2021 10:23:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A70A81E3551; Mon, 12 Apr 2021 12:23:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Whitney <enwlinux@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] iomap: Pass original DIO size to completion handler
Date:   Mon, 12 Apr 2021 12:23:31 +0200
Message-Id: <20210412102333.2676-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412102333.2676-1-jack@suse.cz>
References: <20210412102333.2676-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When extending a file with direct IO write, ext4 needs to know whether IO
has succeeded for the whole range that was prepared for it (the common fast
path). In that case we can piggy back the orphan list update with the
inode size update. In case write was actually shorter than originally
intended, we must leave inode on the orphan list until we cleanup blocks
beyond i_size. So provide the original IO size to the direct IO ->end_io
handler.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c        | 3 ++-
 fs/iomap/direct-io.c  | 5 ++++-
 fs/xfs/xfs_file.c     | 1 +
 fs/zonefs/super.c     | 3 ++-
 include/linux/iomap.h | 4 ++--
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 194f5d00fa32..2505313d96b0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -369,7 +369,8 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
 }
 
 static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
-				 int error, unsigned int flags)
+				 ssize_t orig_size, int error,
+				 unsigned int flags)
 {
 	loff_t offset = iocb->ki_pos;
 	struct inode *inode = file_inode(iocb->ki_filp);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bdd0d89bbf0a..a4bbf22f69bc 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -28,6 +28,7 @@ struct iomap_dio {
 	const struct iomap_dio_ops *dops;
 	loff_t			i_size;
 	loff_t			size;
+	loff_t			orig_size;
 	atomic_t		ref;
 	unsigned		flags;
 	int			error;
@@ -85,7 +86,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	ssize_t ret = dio->error;
 
 	if (dops && dops->end_io)
-		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
+		ret = dops->end_io(iocb, dio->size, dio->orig_size, ret,
+				   dio->flags);
 
 	if (likely(!ret)) {
 		ret = dio->size;
@@ -473,6 +475,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->iocb = iocb;
 	atomic_set(&dio->ref, 1);
 	dio->size = 0;
+	dio->orig_size = count;
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a007ca0711d9..ed23ed56e345 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -442,6 +442,7 @@ static int
 xfs_dio_write_end_io(
 	struct kiocb		*iocb,
 	ssize_t			size,
+	ssize_t			orig_size,
 	int			error,
 	unsigned		flags)
 {
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 049e36c69ed7..e3e0ee4b8c6e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -652,7 +652,8 @@ static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int whence)
 }
 
 static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
-					int error, unsigned int flags)
+					ssize_t orig_size, int error,
+					unsigned int flags)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d202fd2d0f91..b175641e9540 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -252,8 +252,8 @@ int iomap_writepages(struct address_space *mapping,
 #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
 
 struct iomap_dio_ops {
-	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
-		      unsigned flags);
+	int (*end_io)(struct kiocb *iocb, ssize_t size, ssize_t orig_size,
+		      int error, unsigned flags);
 	blk_qc_t (*submit_io)(struct inode *inode, struct iomap *iomap,
 			struct bio *bio, loff_t file_offset);
 };
-- 
2.26.2

