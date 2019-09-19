Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7030CB7BC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfISOLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 10:11:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:43212 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732153AbfISOLf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:11:35 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iAx9f-0007QU-GB; Thu, 19 Sep 2019 17:11:31 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH RFC] fuse: optimize writepages search
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Message-ID: <b762fcc4-1ddf-70c2-3189-544779186d3d@virtuozzo.com>
Date:   Thu, 19 Sep 2019 17:11:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Miklos,

This patch was originally developed for RHEL7-based 
Virtuozzo kernels and widely used few years
but seems it was not submitted upstream.
I've rebased it to v5.3, compiled but was not tested,
just to get feedback and then update it.

Author: Maxim Patlasov <mpatlasov@virtuozzo.com>

The patch re-works fi->writepages replacing list with rb-tree.
This improves performance because kernel fuse iterates through
fi->writepages for each writeback page and typical number of
entries is about 800 (for 100MB of fuse writeback).

Before patch:

10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 41.3473 s, 260 MB/s

 2  1      0 57445400  40416 6323676    0    0    33 374743 8633 19210  1  8 88  3  0

  29.86%  [kernel]               [k] _raw_spin_lock
  26.62%  [fuse]                 [k] fuse_page_is_writeback

After patch:

10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 21.4954 s, 500 MB/s

 2  9      0 53676040  31744 10265984    0    0    64 854790 10956 48387  1  6 88  6  0

  23.55%  [kernel]             [k] copy_user_enhanced_fast_string
   9.87%  [kernel]             [k] __memcpy
   3.10%  [kernel]             [k] _raw_spin_lock

Signed-off-by: Maxim Patlasov <mpatlasov@virtuozzo.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c   | 60 ++++++++++++++++++++++++++++++++++++++----------
 fs/fuse/fuse_i.h |  4 ++--
 2 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 91c99724dee0..ef7feb897ada 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -338,17 +338,23 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id)
 static struct fuse_req *fuse_find_writeback(struct fuse_inode *fi,
 					    pgoff_t idx_from, pgoff_t idx_to)
 {
-	struct fuse_req *req;
+	struct rb_node *n;
+
+	n = fi->writepages.rb_node;
 
-	list_for_each_entry(req, &fi->writepages, writepages_entry) {
+	while (n) {
+		struct fuse_req *req;
 		pgoff_t curr_index;
 
+		req = rb_entry(n, struct fuse_req, writepages_entry);
 		WARN_ON(get_fuse_inode(req->inode) != fi);
 		curr_index = req->misc.write.in.offset >> PAGE_SHIFT;
-		if (idx_from < curr_index + req->num_pages &&
-		    curr_index <= idx_to) {
+		if (idx_from >= curr_index + req->num_pages)
+			n = n->rb_right;
+		else if (idx_to < curr_index)
+			n = n->rb_left;
+		else
 			return req;
-		}
 	}
 	return NULL;
 }
@@ -1527,7 +1533,7 @@ static void fuse_writepage_finish(struct fuse_conn *fc, struct fuse_req *req)
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
-	list_del(&req->writepages_entry);
+	rb_erase(&req->writepages_entry, &fi->writepages);
 	for (i = 0; i < req->num_pages; i++) {
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
 		dec_node_page_state(req->pages[i], NR_WRITEBACK_TEMP);
@@ -1605,6 +1611,36 @@ __acquires(fi->lock)
 	}
 }
 
+static int tree_insert(struct rb_root *root, struct fuse_req *ins_req)
+{
+	pgoff_t idx_from = ins_req->misc.write.in.offset >> PAGE_SHIFT;
+	pgoff_t idx_to   = idx_from + (ins_req->num_pages ?
+				ins_req->num_pages - 1 : 0);
+	struct rb_node **p = &root->rb_node;
+	struct rb_node  *parent = NULL;
+
+	while (*p) {
+		struct fuse_req *req;
+		pgoff_t curr_index;
+
+		parent = *p;
+		req = rb_entry(parent, struct fuse_req, writepages_entry);
+		BUG_ON(req->inode != ins_req->inode);
+		curr_index = req->misc.write.in.offset >> PAGE_SHIFT;
+
+		if (idx_from >= curr_index + req->num_pages)
+			p = &(*p)->rb_right;
+		else if (idx_to < curr_index)
+			p = &(*p)->rb_left;
+		else
+			BUG();
+	}
+
+	rb_link_node(&ins_req->writepages_entry, parent, p);
+	rb_insert_color(&ins_req->writepages_entry, root);
+	return 0;
+}
+
 static void fuse_writepage_end(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct inode *inode = req->inode;
@@ -1619,7 +1655,7 @@ static void fuse_writepage_end(struct fuse_conn *fc, struct fuse_req *req)
 		req->misc.write.next = next->misc.write.next;
 		next->misc.write.next = NULL;
 		next->ff = fuse_file_get(req->ff);
-		list_add(&next->writepages_entry, &fi->writepages);
+		tree_insert(&fi->writepages, next);
 
 		/*
 		 * Skip fuse_flush_writepages() to make it easy to crop requests
@@ -1735,7 +1771,7 @@ static int fuse_writepage_locked(struct page *page)
 	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
 
 	spin_lock(&fi->lock);
-	list_add(&req->writepages_entry, &fi->writepages);
+	tree_insert(&fi->writepages, req);
 	list_add_tail(&req->list, &fi->queued_writes);
 	fuse_flush_writepages(inode);
 	spin_unlock(&fi->lock);
@@ -1820,10 +1856,10 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
 	WARN_ON(new_req->num_pages != 0);
 
 	spin_lock(&fi->lock);
-	list_del(&new_req->writepages_entry);
+	rb_erase(&new_req->writepages_entry, &fi->writepages);
 	old_req = fuse_find_writeback(fi, page->index, page->index);
 	if (!old_req) {
-		list_add(&new_req->writepages_entry, &fi->writepages);
+		tree_insert(&fi->writepages, new_req);
 		spin_unlock(&fi->lock);
 		return false;
 	}
@@ -1940,7 +1976,7 @@ static int fuse_writepages_fill(struct page *page,
 		req->inode = inode;
 
 		spin_lock(&fi->lock);
-		list_add(&req->writepages_entry, &fi->writepages);
+		tree_insert(&fi->writepages, req);
 		spin_unlock(&fi->lock);
 
 		data->req = req;
@@ -3262,5 +3298,5 @@ void fuse_init_file_inode(struct inode *inode)
 	INIT_LIST_HEAD(&fi->queued_writes);
 	fi->writectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
-	INIT_LIST_HEAD(&fi->writepages);
+	fi->writepages = RB_ROOT;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24dbca777775..bbb3ca395892 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -114,7 +114,7 @@ struct fuse_inode {
 			wait_queue_head_t page_waitq;
 
 			/* List of writepage requestst (pending or sent) */
-			struct list_head writepages;
+			struct rb_root writepages;
 		};
 
 		/* readdir cache (directory only) */
@@ -437,7 +437,7 @@ struct fuse_req {
 	struct fuse_io_priv *io;
 
 	/** Link on fi->writepages */
-	struct list_head writepages_entry;
+	struct rb_node writepages_entry;
 
 	/** Request completion callback */
 	void (*end)(struct fuse_conn *, struct fuse_req *);
-- 
2.17.1

