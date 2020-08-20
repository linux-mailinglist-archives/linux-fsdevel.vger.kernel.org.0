Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2124C3CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgHTQ4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 12:56:16 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:7416 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgHTQ4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:56:14 -0400
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 20 Aug 2020 09:56:12 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 20 Aug 2020 09:56:11 -0700
Received: from c-ppvk-linux.qualcomm.com ([10.206.24.34])
  by ironmsg01-blr.qualcomm.com with ESMTP; 20 Aug 2020 22:26:01 +0530
Received: by c-ppvk-linux.qualcomm.com (Postfix, from userid 2304101)
        id 0A35A51FB; Thu, 20 Aug 2020 22:25:58 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     stummala@codeaurora.org, sayalil@codeaurora.org,
        Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V1] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero ref count page
Date:   Thu, 20 Aug 2020 22:25:55 +0530
Message-Id: <1597942555-904-1-git-send-email-ppvk@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a potential race between fuse_abort_conn() and
fuse_copy_page() as shown below, due to which VM_BUG_ON_PAGE
crash is observed.

context#1:			context#2:
fuse_dev_do_read()		fuse_abort_conn()
->fuse_copy_args()		 ->end_requests()
 ->fuse_copy_pages()		  ->request_end()
  ->fuse_copy_page()		   ->fuse_writepage_end)
   ->fuse_ref_page()		    ->fuse_writepage_free()
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
0x620042(GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL), pid 261, ts 174390946312 ns
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

Fix this by protecting fuse_copy_pages() with fc->lock.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 fs/fuse/dev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36..ca4f63c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -948,22 +948,26 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 			   int zeroing)
 {
 	unsigned i;
+	int err = 0;
 	struct fuse_req *req = cs->req;
 	struct fuse_args_pages *ap = container_of(req->args, typeof(*ap), args);
 
-
+	if (req->ff)
+		spin_lock(&req->ff->fc->lock);
 	for (i = 0; i < ap->num_pages && (nbytes || zeroing); i++) {
-		int err;
 		unsigned int offset = ap->descs[i].offset;
 		unsigned int count = min(nbytes, ap->descs[i].length);
 
 		err = fuse_copy_page(cs, &ap->pages[i], offset, count, zeroing);
 		if (err)
-			return err;
+			goto err;
 
 		nbytes -= count;
 	}
-	return 0;
+err:
+	if (req->ff)
+		spin_unlock(&req->ff->fc->lock);
+	return err;
 }
 
 /* Copy a single argument in the request to/from userspace buffer */
-- 
1.9.1

