Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6CC27509C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWGE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 02:04:27 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39555 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIWGE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:04:27 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 02:04:26 EDT
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Sep 2020 22:58:23 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Sep 2020 22:58:21 -0700
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 Sep 2020 11:28:08 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id 6868020F13; Wed, 23 Sep 2020 11:28:07 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     miklos@szeredi.hu, willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V3] fuse: Remove __GFP_FS flag to avoid allocator recursing 
Date:   Wed, 23 Sep 2020 11:27:55 +0530
Message-Id: <1600840675-43691-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 2.7.4
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

Changes since V2:
- updated memalloc_nofs_save() to allocation paths that potentially
  can cause deadlock.

Changes since V1:
- Used memalloc_nofs_save() in all allocation paths of fuse daemons
  to avoid use __GFP_FS flag as per Matthew comments.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 fs/fuse/dev.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5078a6c..e7a8718 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
@@ -683,6 +684,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 {
 	struct page *page;
 	int err;
+	unsigned nofs_flag;
 
 	err = unlock_request(cs->req);
 	if (err)
@@ -708,7 +710,9 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
+			nofs_flag = memalloc_nofs_save();
 			page = alloc_page(GFP_HIGHUSER);
+			memalloc_nofs_restore(nofs_flag);
 			if (!page)
 				return -ENOMEM;
 
@@ -781,6 +785,7 @@ static int fuse_check_page(struct page *page)
 static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 {
 	int err;
+	unsigned nofs_flag;
 	struct page *oldpage = *pagep;
 	struct page *newpage;
 	struct pipe_buffer *buf = cs->pipebufs;
@@ -831,7 +836,9 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(PageMlocked(oldpage)))
 		goto out_fallback_unlock;
 
+	nofs_flag = memalloc_nofs_save();
 	err = replace_page_cache_page(oldpage, newpage, GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	if (err) {
 		unlock_page(newpage);
 		goto out_put_old;
@@ -1177,6 +1184,7 @@ __releases(fiq->lock)
  * the pending list and copies request data to userspace buffer.  If
  * no reply is needed (FORGET) or request has been aborted or there
  * was an error during the copying then it's finished by calling
+ *
  * fuse_request_end().  Otherwise add it to the processing list, and set
  * the 'sent' flag.
  */
@@ -1346,12 +1354,15 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	struct pipe_buffer *bufs;
 	struct fuse_copy_state cs;
 	struct fuse_dev *fud = fuse_get_dev(in);
+	unsigned nofs_flag;
 
 	if (!fud)
 		return -EPERM;
 
+	nofs_flag = memalloc_nofs_save();
 	bufs = kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	if (!bufs)
 		return -ENOMEM;
 
@@ -1952,6 +1963,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	struct fuse_dev *fud;
 	size_t rem;
 	ssize_t ret;
+	unsigned nofs_flag;
 
 	fud = fuse_get_dev(out);
 	if (!fud)
@@ -1964,7 +1976,9 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	mask = pipe->ring_size - 1;
 	count = head - tail;
 
+	nofs_flag = memalloc_nofs_save();
 	bufs = kvmalloc_array(count, sizeof(struct pipe_buffer), GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	if (!bufs) {
 		pipe_unlock(pipe);
 		return -ENOMEM;
-- 
2.7.4

