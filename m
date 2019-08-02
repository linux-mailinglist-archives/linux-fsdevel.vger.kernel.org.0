Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5660080273
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 00:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437139AbfHBWBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 18:01:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:38062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437124AbfHBWBI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:01:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62A5FB11B;
        Fri,  2 Aug 2019 22:01:07 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        ruansy.fnst@cn.fujitsu.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 07/13] btrfs: basic direct read operation
Date:   Fri,  2 Aug 2019 17:00:42 -0500
Message-Id: <20190802220048.16142-8-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190802220048.16142-1-rgoldwyn@suse.de>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Add btrfs_dio_iomap_ops for iomap.begin() function. In order to
accomodate dio reads, add a new function btrfs_file_read_iter()
which would call btrfs_dio_iomap_read() for DIO reads and
fallback to generic_file_read_iter otherwise.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/file.c  | 10 +++++++++-
 fs/btrfs/iomap.c | 20 ++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7a4ff524dc77..9eca2d576dd1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3247,7 +3247,9 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
 loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
 			      struct file *file_out, loff_t pos_out,
 			      loff_t len, unsigned int remap_flags);
+/* iomap.c */
 size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from);
+ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to);
 
 /* tree-defrag.c */
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f7087e28ac08..997eb152a35a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2839,9 +2839,17 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return btrfs_dio_iomap_read(iocb, to);
+
+	return generic_file_read_iter(iocb, to);
+}
+
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
-	.read_iter      = generic_file_read_iter,
+	.read_iter      = btrfs_file_read_iter,
 	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.mmap		= btrfs_file_mmap,
diff --git a/fs/btrfs/iomap.c b/fs/btrfs/iomap.c
index 879038e2f1a0..36df606fc028 100644
--- a/fs/btrfs/iomap.c
+++ b/fs/btrfs/iomap.c
@@ -420,3 +420,23 @@ size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
+static int btrfs_dio_iomap_begin(struct inode *inode, loff_t pos,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	return get_iomap(inode, pos, length, iomap);
+}
+
+static const struct iomap_ops btrfs_dio_iomap_ops = {
+	.iomap_begin            = btrfs_dio_iomap_begin,
+};
+
+ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+	inode_lock_shared(inode);
+	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, NULL);
+	inode_unlock_shared(inode);
+	return ret;
+}
-- 
2.16.4

