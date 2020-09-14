Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED9268CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgINN5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 09:57:42 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47608 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgINN5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:57:06 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Sep 2020 06:56:32 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Sep 2020 06:56:31 -0700
Received: from hydcbspbld03.qualcomm.com ([10.242.221.48])
  by ironmsg02-blr.qualcomm.com with ESMTP; 14 Sep 2020 19:26:20 +0530
Received: by hydcbspbld03.qualcomm.com (Postfix, from userid 2304101)
        id DE05F20E86; Mon, 14 Sep 2020 19:26:18 +0530 (IST)
From:   Pradeep P V K <ppvk@codeaurora.org>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, Pradeep P V K <ppvk@codeaurora.org>
Subject: [PATCH V1] fuse: Remove __GFP_FS flag to avoid allocator recursing
Date:   Mon, 14 Sep 2020 19:26:15 +0530
Message-Id: <1600091775-10639-1-git-send-email-ppvk@codeaurora.org>
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

So, remove __GFP_FS flag to avoid allocator recursing into the
filesystem that might already held locks.

Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36..2859024 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -708,7 +708,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
-			page = alloc_page(GFP_HIGHUSER);
+			page = alloc_page(GFP_NOFS | __GFP_HARDWALL | __GFP_HIGHMEM);
 			if (!page)
 				return -ENOMEM;
 
-- 
2.7.4

