Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3876726BD62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 08:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIPGkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 02:40:03 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:1168 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIPGkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:40:00 -0400
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 15 Sep 2020 23:39:58 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 15 Sep 2020 23:39:57 -0700
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg02-blr.qualcomm.com with ESMTP; 16 Sep 2020 12:09:43 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id B78FE20EA9; Wed, 16 Sep 2020 12:09:42 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     miklos@szeredi.hu, willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V2] fuse: Remove __GFP_FS flag to avoid allocator recursing
Date:   Wed, 16 Sep 2020 12:09:40 +0530
Message-Id: <1600238380-33350-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Found a deadlock between kswapd, writeback thread and fuse process
Here are the sequence of events with callstacks on the deadlock.

process#1		process#2		process#3
__switch_to+0x150	__switch_to+0x150	try_to_free_pages
__schedule+0x984	__schedule+0x984
					memalloc_noreclaim_restore
schedule+0x70		schedule+0x70		__perform_reclaim
bit_wait+0x14		__fuse_request_send+0x154
					__alloc_pages_direct_reclaim
__wait_on_bit+0x70	fuse_simple_request+0x174
inode_wait_for_writeback+0xa0
						__alloc_pages_slowpath
			fuse_flush_times+0x10c
evict+0xa4		fuse_write_inode+0x5c	__alloc_pages_nodemask
iput+0x248		__writeback_single_inode+0x3d4
dentry_unlink_inode+0xd8			__alloc_pages_node
			writeback_sb_inodes+0x4a0
__dentry_kill+0x160	__writeback_inodes_wb+0xac
shrink_dentry_list+0x170			alloc_pages_node
			wb_writeback+0x26c	fuse_copy_fill
prune_dcache_sb+0x54	wb_workfn+0x2c0		fuse_copy_one
super_cache_scan+0x114	process_one_work+0x278	fuse_read_single_forget
do_shrink_slab+0x24c	worker_thread+0x26c	fuse_read_forget
shrink_slab+0xa8	kthread+0x118		fuse_dev_do_read
shrink_node+0x118				fuse_dev_splice_read
kswapd+0x92c					do_splice_to
						do_splice

Process#1(kswapd) held an inode lock and initaited a writeback to free
the pages, as the inode superblock is fuse, process#2 forms a fuse
request. Process#3 (Fuse daemon threads) while serving process#2 request,
it requires memory(pages) and as the system is already running in low
memory it ends up in calling try_to_ free_pages(), which might now call
kswapd again, which is already stuck with an inode lock held. Thus forms
a deadlock.

So, drop  __GFP_FS flag to avoid allocator recursing into the
filesystem that might already held locks by using memalloc_nofs_save()
and memalloc_nofs_restore() respectively.

Changes since V1:
- Used memalloc_nofs_save() in all allocation paths of fuse daemons
  to avoid use __GFP_FS flag as per Matthew comments.

 __GFP_FS flags very
Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 fs/fuse/dev.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36..9f790fd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
@@ -1314,6 +1315,8 @@ static int fuse_dev_open(struct inode *inode, struct file *file)
 
 static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	ssize_t size;
+	unsigned nofs_flag;
 	struct fuse_copy_state cs;
 	struct file *file = iocb->ki_filp;
 	struct fuse_dev *fud = fuse_get_dev(file);
@@ -1326,7 +1329,11 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, struct iov_iter *to)
 
 	fuse_copy_init(&cs, 1, to);
 
-	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
+	nofs_flag = memalloc_nofs_save();
+	size = fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
+	memalloc_nofs_restore(nofs_flag);
+
+	return size;
 }
 
 static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
@@ -1335,6 +1342,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 {
 	int total, ret;
 	int page_nr = 0;
+	unsigned nofs_flag;
 	struct pipe_buffer *bufs;
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud = fuse_get_dev(in);
@@ -1342,15 +1350,21 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (!fud)
 		return -EPERM;
 
+	nofs_flag = memalloc_nofs_save();
 	bufs = kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	if (!bufs)
 		return -ENOMEM;
 
 	fuse_copy_init(&cs, 1, NULL);
 	cs.pipebufs = bufs;
 	cs.pipe = pipe;
+
+	nofs_flag = memalloc_nofs_save();
 	ret = fuse_dev_do_read(fud, in, &cs, len);
+	memalloc_nofs_restore(nofs_flag);
+
 	if (ret < 0)
 		goto out;
 
@@ -1918,6 +1932,8 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 
 static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	ssize_t size;
+	unsigned nofs_flag;
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud = fuse_get_dev(iocb->ki_filp);
 
@@ -1929,7 +1945,11 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 
 	fuse_copy_init(&cs, 0, from);
 
-	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
+	nofs_flag = memalloc_nofs_save();
+	size = fuse_dev_do_write(fud, &cs, iov_iter_count(from));
+	memalloc_nofs_restore(nofs_flag);
+
+	return size;
 }
 
 static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
@@ -1938,7 +1958,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 {
 	unsigned int head, tail, mask, count;
 	unsigned nbuf;
-	unsigned idx;
+	unsigned idx, nofs_flag;
 	struct pipe_buffer *bufs;
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud;
@@ -1956,7 +1976,9 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	mask = pipe->ring_size - 1;
 	count = head - tail;
 
+	nofs_flag = memalloc_nofs_save();
 	bufs = kvmalloc_array(count, sizeof(struct pipe_buffer), GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	if (!bufs) {
 		pipe_unlock(pipe);
 		return -ENOMEM;
@@ -2010,7 +2032,9 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	if (flags & SPLICE_F_MOVE)
 		cs.move_pages = 1;
 
+	nofs_flag = memalloc_nofs_save();
 	ret = fuse_dev_do_write(fud, &cs, len);
+	memalloc_nofs_restore(nofs_flag);
 
 	pipe_lock(pipe);
 out_free:
-- 
2.7.4

