Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C125260D50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgIHIRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 04:17:30 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23468 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgIHIR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1599553049; x=1631089049;
  h=from:to:cc:subject:date:message-id;
  bh=xIRQt1L/pM5fqdZ29EkLFflPmprmn3DgRyBbxUjROY4=;
  b=tomEmLhjwkVkVZvcO0C8hI9FHgmZR8XR1zb+u1ljXabGzaFG6wJ3EMpf
   E+wgFWH8Iq4Y+1Ve2G2PIVo+svlFasUrz58JsbHn1XrcxLxm3JNuxZtef
   R2QV/XGA9IejjJxb/BS5VHQI1K1d7K6wiDyRCBnBrTuOiP1i5ZKfiZgaE
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 08 Sep 2020 01:17:29 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Sep 2020 01:17:27 -0700
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg01-blr.qualcomm.com with ESMTP; 08 Sep 2020 13:47:13 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id 59CE65390; Tue,  8 Sep 2020 13:47:12 +0530 (IST)
From:   Pradeep P V K <pragalla@qti.qualcomm.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Cc:     stummala@codeaurora.org, sayalil@codeaurora.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero ref count page
Date:   Tue,  8 Sep 2020 13:47:06 +0530
Message-Id: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pradeep P V K <ppvk@codeaurora.org>

There is a potential race between fuse_abort_conn() and
fuse_copy_page() as shown below, due to which VM_BUG_ON_PAGE
crash is observed for accessing a free page.

context#1:                      context#2:
fuse_dev_do_read()              fuse_abort_conn()
->fuse_copy_args()               ->end_requests()
 ->fuse_copy_pages()              ->request_end()
    ->fuse_copy_page()               ->fuse_writepage_end)
      ->fuse_ref_page()                ->fuse_writepage_free()
                                          ->__free_page()
					    ->put_page_testzero()

      ->get_page()
      ->VM_BUG_ON_PAGE()

This results in below crash as when ->put_page_testzero() in context#2
decrease the page reference and get_page() in context#1 accessed it
with zero page reference count.

[  174.391095]  (1)[10406:Thread-6]page dumped because:
VM_BUG_ON_PAGE(((unsigned int) page_ref_count(page) + 127u <= 127u))
[  174.391113]  (1)[10406:Thread-6]page allocated via order 0,
migratetype Unmovable, gfp_mask
0x620042(GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL), pid 261, ts
174390946312 ns

[  174.391135]  (1)[10406:Thread-6] prep_new_page+0x13c/0x210
[  174.391148]  (1)[10406:Thread-6] get_page_from_freelist+0x21ac/0x2370
[  174.391161]  (1)[10406:Thread-6] __alloc_pages_nodemask+0x244/0x14a8
[  174.391176]  (1)[10406:Thread-6] fuse_writepages_fill+0x150/0x708
[  174.391190]  (1)[10406:Thread-6] write_cache_pages+0x3d8/0x550
[  174.391202]  (1)[10406:Thread-6] fuse_writepages+0x94/0x130
[  174.391214]  (1)[10406:Thread-6] do_writepages+0x74/0x140
[  174.391228]  (1)[10406:Thread-6] __writeback_single_inode+0x168/0x788
[  174.391239]  (1)[10406:Thread-6] writeback_sb_inodes+0x56c/0xab8
[  174.391251]  (1)[10406:Thread-6] __writeback_inodes_wb+0x94/0x180
[  174.391262]  (1)[10406:Thread-6] wb_writeback+0x318/0x618
[  174.391274]  (1)[10406:Thread-6] wb_workfn+0x468/0x828
[  174.391290]  (1)[10406:Thread-6] process_one_work+0x3d0/0x720
[  174.391302]  (1)[10406:Thread-6] worker_thread+0x234/0x4c0
[  174.391314]  (1)[10406:Thread-6] kthread+0x144/0x158
[  174.391327]  (1)[10406:Thread-6] ret_from_fork+0x10/0x1c
[  174.391363]  (1)[10406:Thread-6]------------[ cut here ]------------
[  174.391371]  (1)[10406:Thread-6]kernel BUG at include/linux/mm.h:980!
[  174.391381]  (1)[10406:Thread-6]Internal error: Oops - BUG: 0 [#1]
...
[  174.486928]  (1)[10406:Thread-6]pc : fuse_copy_page+0x750/0x790
[  174.493029]  (1)[10406:Thread-6]lr : fuse_copy_page+0x750/0x790
[  174.718831]  (1)[10406:Thread-6] fuse_copy_page+0x750/0x790
[  174.718838]  (1)[10406:Thread-6] fuse_copy_args+0xb4/0x1e8
[  174.718843]  (1)[10406:Thread-6] fuse_dev_do_read+0x424/0x888
[  174.718848]  (1)[10406:Thread-6] fuse_dev_splice_read+0x94/0x200
[  174.718856]  (1)[10406:Thread-6] __arm64_sys_splice+0x874/0xb20
[  174.718864]  (1)[10406:Thread-6] el0_svc_common+0xc8/0x240
[  174.718869]  (1)[10406:Thread-6] el0_svc_handler+0x6c/0x88
[  174.718875]  (1)[10406:Thread-6] el0_svc+0x8/0xc
[  174.778853]  (1)[10406:Thread-6]Kernel panic - not syncing: Fatal

Fix this by protecting fuse_ref_page() with the same fc->lock as in
fuse_abort_conn().

Changes since V3:
- Fix smatch warnings.

Changes since V2:
- Moved the spin lock from fuse_copy_pages() to fuse_ref_page().

Changes since V1:
- Modified the logic as per kernel v5.9-rc1.
- Added Reported by tag.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 fs/fuse/dev.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36..25f2086 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -875,7 +875,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 }
 
 static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
-			 unsigned offset, unsigned count)
+			 unsigned offset, unsigned count, struct fuse_conn *fc)
 {
 	struct pipe_buffer *buf;
 	int err;
@@ -883,15 +883,18 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
 	if (cs->nr_segs >= cs->pipe->max_usage)
 		return -EIO;
 
+	spin_lock(&fc->lock);
 	err = unlock_request(cs->req);
-	if (err)
+	if (err) {
+		spin_unlock(&fc->lock);
 		return err;
-
+	}
 	fuse_copy_finish(cs);
 
 	buf = cs->pipebufs;
 	get_page(page);
 	buf->page = page;
+	spin_unlock(&fc->lock);
 	buf->offset = offset;
 	buf->len = count;
 
@@ -907,7 +910,7 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
  * done atomically
  */
 static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
-			  unsigned offset, unsigned count, int zeroing)
+			  unsigned offset, unsigned count, int zeroing, struct fuse_conn *fc)
 {
 	int err;
 	struct page *page = *pagep;
@@ -917,7 +920,7 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
 
 	while (count) {
 		if (cs->write && cs->pipebufs && page) {
-			return fuse_ref_page(cs, page, offset, count);
+			return fuse_ref_page(cs, page, offset, count, fc);
 		} else if (!cs->len) {
 			if (cs->move_pages && page &&
 			    offset == 0 && count == PAGE_SIZE) {
@@ -945,7 +948,7 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
 
 /* Copy pages in the request to/from userspace buffer */
 static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
-			   int zeroing)
+			   int zeroing, struct fuse_conn *fc)
 {
 	unsigned i;
 	struct fuse_req *req = cs->req;
@@ -957,7 +960,7 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 		unsigned int offset = ap->descs[i].offset;
 		unsigned int count = min(nbytes, ap->descs[i].length);
 
-		err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
+		err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing, fc);
 		if (err)
 			return err;
 
@@ -983,7 +986,7 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing)
+			  int zeroing, struct fuse_conn *fc)
 {
 	int err = 0;
 	unsigned i;
@@ -991,7 +994,7 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 	for (i = 0; !err && i < numargs; i++)  {
 		struct fuse_arg *arg = &args[i];
 		if (i == numargs - 1 && argpages)
-			err = fuse_copy_pages(cs, arg->size, zeroing);
+			err = fuse_copy_pages(cs, arg->size, zeroing, fc);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1260,7 +1263,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	err = fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
 	if (!err)
 		err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
-				     (struct fuse_arg *) args->in_args, 0);
+				     (struct fuse_arg *) args->in_args, 0, fc);
 	fuse_copy_finish(cs);
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
@@ -1590,7 +1593,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 			goto out_iput;
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		err = fuse_copy_page(cs, &page, offset, this_num, 0, fc);
 		if (!err && offset == 0 &&
 		    (this_num == PAGE_SIZE || file_size == end))
 			SetPageUptodate(page);
@@ -1792,7 +1795,7 @@ static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
 }
 
 static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
-			 unsigned nbytes)
+			 unsigned nbytes, struct fuse_conn *fc)
 {
 	unsigned reqsize = sizeof(struct fuse_out_header);
 
@@ -1809,7 +1812,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		lastarg->size -= diffsize;
 	}
 	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
-			      args->out_args, args->page_zeroing);
+			      args->out_args, args->page_zeroing, fc);
 }
 
 /*
@@ -1894,7 +1897,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
 	else
-		err = copy_out_args(cs, req->args, nbytes);
+		err = copy_out_args(cs, req->args, nbytes, fc);
 	fuse_copy_finish(cs);
 
 	spin_lock(&fpq->lock);
-- 
1.9.1

