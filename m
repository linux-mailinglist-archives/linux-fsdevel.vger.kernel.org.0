Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F585286E06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 07:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgJHFTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 01:19:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgJHFTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:19:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id BD1EC2920FC
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Anatol Pomazau <anatol@google.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] buffer: Add tracepoints to buffer write path
Date:   Thu,  8 Oct 2020 01:19:02 -0400
Message-Id: <20201008051902.2900651-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Anatol Pomazau <anatol@google.com>

Hi Viro,

I'm not sure if you accept tracepoint inclusions on your tree, if so,
please take these into consideration.

-- >8 --

Google has been carrying these tracepoints for a while, as they have
proven particularly useful when investigating internal issues with
direct vs. buffered IO on Google workloads.

Co-developed-by: Khazhismel Kumykov <khazhy@google.com>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Signed-off-by: Anatol Pomazau <anatol@google.com>
Co-developed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/buffer.c               | 10 +++++
 include/trace/events/fs.h | 82 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 include/trace/events/fs.h

diff --git a/fs/buffer.c b/fs/buffer.c
index 50bbc99e3d96..f5430c721e14 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -49,6 +49,9 @@
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fs.h>
+
 #include "internal.h"
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
@@ -119,7 +122,9 @@ EXPORT_SYMBOL(buffer_check_dirty_writeback);
  */
 void __wait_on_buffer(struct buffer_head * bh)
 {
+	trace_fs_buffer_wait_start(bh);
 	wait_on_bit_io(&bh->b_state, BH_Lock, TASK_UNINTERRUPTIBLE);
+	trace_fs_buffer_wait_end(bh);
 }
 EXPORT_SYMBOL(__wait_on_buffer);
 
@@ -1741,6 +1746,8 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	block = (sector_t)page->index << (PAGE_SHIFT - bbits);
 	last_block = (i_size_read(inode) - 1) >> bbits;
 
+	trace_block_write_full_page(inode, block, last_block);
+
 	/*
 	 * Get all the dirty buffers mapped to disk addresses and
 	 * handle any aliases from the underlying blockdev's mapping.
@@ -1830,6 +1837,9 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 		 * here on.
 		 */
 	}
+
+	trace_block_write_full_page_done(inode, nr_underway, err);
+
 	return err;
 
 recover:
diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
new file mode 100644
index 000000000000..33ca57c91dc5
--- /dev/null
+++ b/include/trace/events/fs.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fs
+
+#if !defined(_TRACE_FS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FS_H
+
+#include <linux/tracepoint.h>
+#include <linux/buffer_head.h>
+
+DECLARE_EVENT_CLASS(fs_buffer_wait,
+	TP_PROTO(struct buffer_head *bh),
+	TP_ARGS(bh),
+	TP_STRUCT__entry(__field(void *, bh)),
+	TP_fast_assign(__entry->bh = bh;),
+	TP_printk("bh: %p", __entry->bh)
+);
+
+DEFINE_EVENT(fs_buffer_wait, fs_buffer_wait_start,
+	TP_PROTO(struct buffer_head *bh),
+	TP_ARGS(bh)
+);
+
+DEFINE_EVENT(fs_buffer_wait, fs_buffer_wait_end,
+	TP_PROTO(struct buffer_head *bh),
+	TP_ARGS(bh)
+);
+
+TRACE_EVENT(block_write_full_page,
+
+	TP_PROTO(struct inode *inode, sector_t block, sector_t last_block),
+
+	TP_ARGS(inode, block, last_block),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(sector_t, block)
+		__field(sector_t, last_block)
+	),
+
+	TP_fast_assign(
+		__entry->dev            = inode->i_sb->s_dev;
+		__entry->ino            = inode->i_ino;
+		__entry->block          = block;
+		__entry->last_block     = last_block;
+	),
+
+	TP_printk("dev %d,%d ino %lu block %llu last block %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->block, __entry->last_block)
+);
+
+TRACE_EVENT(block_write_full_page_done,
+
+	TP_PROTO(struct inode *inode, int nr_underway, int err),
+
+	TP_ARGS(inode, nr_underway, err),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, ino)
+		__field(int, nr_underway)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->dev            = inode->i_sb->s_dev;
+		__entry->ino            = inode->i_ino;
+		__entry->nr_underway    = nr_underway;
+		__entry->err            = err;
+	),
+
+	TP_printk("dev %d,%d ino %lu nr_underway %d err %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, __entry->nr_underway, __entry->err)
+);
+
+#endif /* _TRACE_FS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.28.0

