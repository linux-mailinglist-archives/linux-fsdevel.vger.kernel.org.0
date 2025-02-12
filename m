Return-Path: <linux-fsdevel+bounces-41582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9822A32694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C63A7505
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51A20E02A;
	Wed, 12 Feb 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fCvBQK+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D9209F4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365690; cv=none; b=ApluV9JHNXuncAlH3qUWTJgFKfWePr8qSD7RnJ6VDbpScTBUJph6L/CUAbKs3v85CaMvVLAUANGvHlnbmw+gQTU/h1L/8Pe9D5JupCmDlza9i3umwjrQgfCdhZAexc0+YFWGdwlim7IddK1b60upFt3eOr/YLEBDNeBpohEB43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365690; c=relaxed/simple;
	bh=ue8PXiHMrRz2BDHBAIQn7/TFv65DQO+WGbaJF8FQNvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=D1V59uF9mC6/50UlryYm/3WnUgeB3B4WJ+PJkf6d+RL3WeWLUYI8Uc6WGqF/qrX7RW4P+f7wzWpm2/nCFHJbPk1btXPP5IEdHg8JUIWwfvFb1vUuD/HOf6Qxg3Jt82zk1+wBOcy0G4+UcpwbtBEcE+H0Co+/z+5FeMRJplZcX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fCvBQK+N; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250212130805epoutp03b909b9ce6bb70d9c7fad4f3139490b74~jd_AWFDt_1971119711epoutp03Q
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:08:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250212130805epoutp03b909b9ce6bb70d9c7fad4f3139490b74~jd_AWFDt_1971119711epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739365685;
	bh=8K3TN/B540mri7UU2SFlEatWSRHu5kabeFD596rAvr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCvBQK+NSyoypih0PZCFW31Q1YPbNRflQZLZx278byz1Mr/QEHtOBl4CYP56EkGqb
	 +W7AKNj687GMpCYKc+ZInf5w/z3Zt6/HB0VSvpKKcqTHZbOTh9YN2mwJfmwUKADDfT
	 q2uJcWHl2QoCyxfwNNN8gZlTcrD20pZSBxEkIPyM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250212130804epcas5p38c0c51963c084df2579e5f925e4dfcb9~jd9-XZXpY0413104131epcas5p3K;
	Wed, 12 Feb 2025 13:08:04 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YtJX30HN2z4x9Pt; Wed, 12 Feb
	2025 13:08:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.04.19710.23D9CA76; Wed, 12 Feb 2025 22:08:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250212104512epcas5p24d4d58763a4de7becf8eec2b95bdf250~jcBQcvliR3236932369epcas5p2t;
	Wed, 12 Feb 2025 10:45:12 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250212104512epsmtrp2b15bdb6e021df715215411ba93e383bb~jcBQb6vaC2690626906epsmtrp2S;
	Wed, 12 Feb 2025 10:45:12 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-62-67ac9d323de1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.2F.23488.8BB7CA76; Wed, 12 Feb 2025 19:45:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250212104510epsmtip29561f90b1e2668b4dfcb1db7eadcbaf4~jcBOBjBEs1728317283epsmtip2Y;
	Wed, 12 Feb 2025 10:45:10 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: david@fromorbit.com, mcgrof@kernel.org, jack@suse.cz, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	anuj20.g@samsung.com, axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com, vishak.g@samsung.com, amir73il@gmail.com,
	brauner@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [RFC 2/3] fs: modify writeback infra to work with wb_ctx
Date: Wed, 12 Feb 2025 16:06:33 +0530
Message-Id: <20250212103634.448437-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212103634.448437-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmhq7R3DXpBouPmVtcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLXX92sFvc
	mPCU0eL8rDnsFr9/zGFz4Pc4tUjCY+esu+wem1doeVw+W+qxaVUnm8fumw1sHucuVnj0bVnF
	6HFmwRF2j8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
	XHwCdN0yc4BeUFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevl
	pZZYGRoYGJkCFSZkZzz+PpOxoOErU8WjrsfMDYy/VjF1MXJySAiYSDy595y5i5GLQ0hgN6PE
	5R0rGSGcT4wS58/MY4NwvjFK7Fnxnx2mZcfZ26wQib2MElN2TGGCcD4zSjzf/Q6oioODTUBX
	4kdTKEiDiICLxKHlfWANzAKdTBLvt+5gA0kICzhK3H7TwAJiswioSmxZvZ0ZpJdXwE7i7Rkd
	iGXyEjMvfQdbzClgL7Hj7WQwm1dAUOLkzCdgrcxANc1bZ4P9ICFwgkOi6cpUVpA5EkCL9y+L
	hpgjLPHq+BaoB6QkPr/bywZhZ0scatwADYsSiZ1HGqBq7CVaT/WDncMsoCmxfpc+RFhWYuqp
	dUwQa/kken8/gWrlldgxD8ZWk5jzbioLhC0jsfDSDKi4h0TzvcvQoJ7EKHG24xTzBEaFWUje
	mYXknVkIqxcwMq9ilEwtKM5NT002LTDMSy2HR3Nyfu4mRnC61nLZwXhj/j+9Q4xMHIyHGCU4
	mJVEeCWmrUkX4k1JrKxKLcqPLyrNSS0+xGgKDO6JzFKiyfnAjJFXEm9oYmlgYmZmZmJpbGao
	JM7bvLMlXUggPbEkNTs1tSC1CKaPiYNTqoGp7q+QzcPeoB/vv16ey2YY+OHCh2olw4TCoMTv
	LDZ6gW9DwiKteoPly5WinI4olzpNXsndK2HQtnfy6XcvlzLFrt4TxXLp0ludV6f/bgm6HyB3
	7lLZjEOv2z99fKhV5bwp5vRFeR0lrwmPoqrXT1szTebw2rXecyvKDh3U4l11aPXS/y2HudW1
	t4rF7VN5xbrJaNXCQu07rj4pH1esZBXJ78zdnV56uuzP7Y2Oc/KFQ37Ns+nunigd/krC9ITH
	tRQBaTEnXZ6dqdUitQ/uW3BkbzO0eFX/O0Vk/d+3n1+1lsQIVDlXCJ4QTZdvcFvZ4SBt+1rz
	+4UClckrHp16JP9Qel1VYn/3lD0bj8W9XXFFiaU4I9FQi7moOBEA8g6piGAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXndH9Zp0g2dv1CwurFvNaNE04S+z
	xeq7/WwWrw9/YrTYcsneYsuxe4wWNw/sZLJYufook8Xs6c1MFlu/fGW12LP3JIvFrj872C1u
	THjKaHF+1hx2i98/5rA58HucWiThsXPWXXaPzSu0PC6fLfXYtKqTzWP3zQY2j3MXKzz6tqxi
	9Diz4Ai7x+dNcgFcUVw2Kak5mWWpRfp2CVwZj7/PZCxo+MpU8ajrMXMD469VTF2MnBwSAiYS
	O87eZu1i5OIQEtjNKLHqejdUQkZi992drBC2sMTKf8/ZIYo+Mkqsu/mDsYuRg4NNQFfiR1Mo
	SI2IgJfExU0fwGqYBaYzSUzZcp4dJCEs4Chx+00DC4jNIqAqsWX1dmaQXl4BO4m3Z3Qg5stL
	zLz0HaycU8BeYsfbyWC2EFDJn3d3wGxeAUGJkzOfgI1hBqpv3jqbeQKjwCwkqVlIUgsYmVYx
	SqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgRHlJbGDsZ335r0DzEycTAeYpTgYFYS4TVZ
	uCJdiDclsbIqtSg/vqg0J7X4EKM0B4uSOO9Kw4h0IYH0xJLU7NTUgtQimCwTB6dUA9O0kucp
	RV6npz0y2HNsy5XnU6SWC39Tv1rsnDn9hv2fmP5vEh+mhsyO5GybdODDnYSoH0uSl0R/jS1V
	ENzSyhh4UXfHvA0+qfl/t6f07mgLN2MTX9E46XXMum+RF84rsG7UvhWuWqKaml+26vCSwpDL
	tVIfRA+p9AgkcW9MKn51rXJGwaFDPuazMvdp1T1b8vKHXnT6l+ofS0Qiv3WYpj1lKdkV+PFp
	0O20idP6TQNKo3KPrtq7b8n5+4c27vbn+tAb9+bM/L3FacYfliZ/FJ+Xue9DjJ5aR1LVo6k/
	lj/5HBX69c7+dIdrUoJc+Q/Xv76/3mFS997zIl7m2yVS959psujplS3SbbujaVpieNtXiaU4
	I9FQi7moOBEAldAAoRcDAAA=
X-CMS-MailID: 20250212104512epcas5p24d4d58763a4de7becf8eec2b95bdf250
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250212104512epcas5p24d4d58763a4de7becf8eec2b95bdf250
References: <20250212103634.448437-1-kundan.kumar@samsung.com>
	<CGME20250212104512epcas5p24d4d58763a4de7becf8eec2b95bdf250@epcas5p2.samsung.com>

The current writeback handling uses bdi_writeback structure
(single worker thread). Modify it so that it starts using the wb_ctx
structure (parallel writeback thread). The writeback always gets
scheduled on the first wb_ctx.

Changes introduced in this patch:

- __mark_inode_dirty:
  This function is modified to add an inode to a particular writeback
  context (wb_ctx) and a corresponding work (pctx_dwork) is scheduled.

- wakeup functions:
  wb_wakeup now wakes up all contexts.
  wb_ctx_wakeup wakes up the specific wb_ctx work.
  wb_wakeup_delayed has been changed to wb_ctx_wakeup_delayed.

- When the writeback work starts, it fetches the inode from the
  b_dirty list and begins processing it. A sample base writeback
  flow is as follows:

  wb_workfn()
    wb_do_writeback()
      wb_writeback()
        queue_io()
          move_expired_inodes()
        writeback_sb_inodes()
        __writeback_single_inode()
        do_writepages()
          xfs_vm_writepages
            iomap_writepages()
              xfs_map_blocks()
            iomap_submit_ioend()
              submit_bio()

  These functions have been modified to accept a writeback context
  (wb_ctx) parameter, allowing them to work on inode (b*) lists in a
  particular writeback context.

- __wakeup_flusher_threads_bdi is modified to start flusher threads for
  each wb_ctx.

- wakeup_dirtytime_writeback is modifed to wake up threads for each wb_ctx

- These writeback flags are made per-context (wb_ctx) specific:
  WB_has_dirty_io
  WB_writeback_running
  WB_start_all

- write bandwidth and average write bandwidth are calculated per writeback
  context.

- FS sync call eventually reaches bdi_split_work_to_wbs, which is modified
  to start threads for all writeback contexts.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 fs/fs-writeback.c                | 489 ++++++++++++++++++++-----------
 include/linux/backing-dev-defs.h |   6 +-
 include/linux/backing-dev.h      |  34 ++-
 mm/backing-dev.c                 |  49 ++--
 mm/page-writeback.c              |  82 +++---
 5 files changed, 419 insertions(+), 241 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3cd99e2dc6ac..8f7dd5d10085 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -82,31 +82,39 @@ static inline struct inode *wb_inode(struct list_head *head)
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(wbc_writepage);
 
-static bool wb_io_lists_populated(struct bdi_writeback *wb)
+static bool wb_ctx_io_lists_populated(struct bdi_writeback *wb,
+				      struct wb_ctx *p_wb_ctx)
 {
-	if (wb_has_dirty_io(wb)) {
+	if (wb_ctx_has_dirty_io(p_wb_ctx)) {
 		return false;
 	} else {
-		set_bit(WB_has_dirty_io, &wb->state);
-		WARN_ON_ONCE(!wb->avg_write_bandwidth);
-		atomic_long_add(wb->avg_write_bandwidth,
+		set_bit(WB_has_dirty_io, &p_wb_ctx->state);
+		WARN_ON_ONCE(!p_wb_ctx->avg_write_bandwidth);
+		atomic_long_add(p_wb_ctx->avg_write_bandwidth,
 				&wb->bdi->tot_write_bandwidth);
 		return true;
 	}
 }
 
-static void wb_io_lists_depopulated(struct bdi_writeback *wb)
+static void wb_ctx_io_lists_depopulated(struct bdi_writeback *wb,
+					struct wb_ctx *p_wb_ctx)
 {
-	if (wb_has_dirty_io(wb) && list_empty(&wb->b_dirty) &&
-	    list_empty(&wb->b_io) && list_empty(&wb->b_more_io)) {
-		clear_bit(WB_has_dirty_io, &wb->state);
-		WARN_ON_ONCE(atomic_long_sub_return(wb->avg_write_bandwidth,
+	struct list_head *pctx_b_more_io, *pctx_b_io, *pctx_b_dirty;
+
+	pctx_b_io = &p_wb_ctx->pctx_b_io;
+	pctx_b_more_io = &p_wb_ctx->pctx_b_more_io;
+	pctx_b_dirty = &p_wb_ctx->pctx_b_dirty;
+
+	if (wb_ctx_has_dirty_io(p_wb_ctx) && list_empty(pctx_b_dirty) &&
+	    list_empty(pctx_b_io) && list_empty(pctx_b_more_io)) {
+		clear_bit(WB_has_dirty_io, &p_wb_ctx->state);
+		WARN_ON_ONCE(atomic_long_sub_return(p_wb_ctx->avg_write_bandwidth,
 					&wb->bdi->tot_write_bandwidth) < 0);
 	}
 }
 
 /**
- * inode_io_list_move_locked - move an inode onto a bdi_writeback IO list
+ * inode_io_list_move_locked_ctx - move an inode onto a wb_ctx IO list
  * @inode: inode to be moved
  * @wb: target bdi_writeback
  * @head: one of @wb->b_{dirty|io|more_io|dirty_time}
@@ -115,10 +123,14 @@ static void wb_io_lists_depopulated(struct bdi_writeback *wb)
  * Returns %true if @inode is the first occupant of the !dirty_time IO
  * lists; otherwise, %false.
  */
-static bool inode_io_list_move_locked(struct inode *inode,
-				      struct bdi_writeback *wb,
-				      struct list_head *head)
+static bool inode_io_list_move_locked_ctx(struct inode *inode,
+					  struct bdi_writeback *wb,
+					  struct list_head *head,
+					  struct wb_ctx *p_wb_ctx)
 {
+	struct list_head *pctx_b_dirty_time = &p_wb_ctx->pctx_b_dirty_time;
+
+
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
@@ -126,18 +138,31 @@ static bool inode_io_list_move_locked(struct inode *inode,
 	list_move(&inode->i_io_list, head);
 
 	/* dirty_time doesn't count as dirty_io until expiration */
-	if (head != &wb->b_dirty_time)
-		return wb_io_lists_populated(wb);
+	if (head != pctx_b_dirty_time)
+		return wb_ctx_io_lists_populated(wb, p_wb_ctx);
 
-	wb_io_lists_depopulated(wb);
+	wb_ctx_io_lists_depopulated(wb, p_wb_ctx);
 	return false;
 }
 
 static void wb_wakeup(struct bdi_writeback *wb)
+{
+	for (int i = 0; i < NR_WB_CTX; i++) {
+		struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+
+		spin_lock_irq(&wb->work_lock);
+		if (test_bit(WB_registered, &wb->state))
+			mod_delayed_work(bdi_wq, &p_wb_ctx->pctx_dwork, 0);
+		spin_unlock_irq(&wb->work_lock);
+	}
+}
+
+static void wb_ctx_wakeup(struct bdi_writeback *wb,
+			  struct wb_ctx *p_wb_ctx)
 {
 	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		mod_delayed_work(bdi_wq, &p_wb_ctx->pctx_dwork, 0);
 	spin_unlock_irq(&wb->work_lock);
 }
 
@@ -155,14 +180,15 @@ static void wb_wakeup(struct bdi_writeback *wb)
  * We have to be careful not to postpone flush work if it is scheduled for
  * earlier. Thus we use queue_delayed_work().
  */
-static void wb_wakeup_delayed(struct bdi_writeback *wb)
+static void wb_ctx_wakeup_delayed(struct bdi_writeback *wb,
+				  struct wb_ctx *p_wb_ctx)
 {
 	unsigned long timeout;
 
 	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
 	spin_lock_irq(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
-		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
+		queue_delayed_work(bdi_wq, &p_wb_ctx->pctx_dwork, timeout);
 	spin_unlock_irq(&wb->work_lock);
 }
 
@@ -181,9 +207,12 @@ static void finish_writeback_work(struct wb_writeback_work *work)
 	}
 }
 
-static void wb_queue_work(struct bdi_writeback *wb,
-			  struct wb_writeback_work *work)
+static void wb_ctx_queue_work(struct bdi_writeback *wb,
+			      struct wb_writeback_work *work,
+			      int ctx_id)
 {
+	struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, ctx_id);
+
 	trace_writeback_queue(wb, work);
 
 	if (work->done)
@@ -193,7 +222,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 
 	if (test_bit(WB_registered, &wb->state)) {
 		list_add_tail(&work->list, &wb->work_list);
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		mod_delayed_work(bdi_wq, &p_wb_ctx->pctx_dwork, 0);
 	} else
 		finish_writeback_work(work);
 
@@ -299,6 +328,22 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
  * Remove the inode from wb's io lists and if necessarily put onto b_attached
  * list.  Only inodes attached to cgwb's are kept on this list.
  */
+static void inode_cgwb_move_to_attached_ctx(struct inode *inode,
+					    struct bdi_writeback *wb,
+					    struct wb_ctx *p_wb_ctx)
+{
+	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
+	WARN_ON_ONCE(inode->i_state & I_FREEING);
+
+	inode->i_state &= ~I_SYNC_QUEUED;
+	if (wb != &wb->bdi->wb)
+		list_move(&inode->i_io_list, &wb->b_attached);
+	else
+		list_del_init(&inode->i_io_list);
+	wb_ctx_io_lists_depopulated(wb, p_wb_ctx);
+}
+
 static void inode_cgwb_move_to_attached(struct inode *inode,
 					struct bdi_writeback *wb)
 {
@@ -311,7 +356,12 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 		list_move(&inode->i_io_list, &wb->b_attached);
 	else
 		list_del_init(&inode->i_io_list);
-	wb_io_lists_depopulated(wb);
+
+	for (int i = 0; i < NR_WB_CTX; i++) {
+		struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+
+		wb_ctx_io_lists_depopulated(wb, p_wb_ctx);
+	}
 }
 
 /**
@@ -454,13 +504,21 @@ static bool inode_do_switch_wbs(struct inode *inode,
 
 		if (inode->i_state & I_DIRTY_ALL) {
 			struct inode *pos;
-
-			list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
-				if (time_after_eq(inode->dirtied_when,
-						  pos->dirtied_when))
-					break;
-			inode_io_list_move_locked(inode, new_wb,
-						  pos->i_io_list.prev);
+			for (int i = 0; i < NR_WB_CTX; i++) {
+				struct wb_ctx *p_wb_ctx = ctx_wb_struct(new_wb,
+									i);
+				struct list_head *pctx_b_dirty =
+						ctx_b_dirty_list(new_wb, i);
+
+				list_for_each_entry(pos, pctx_b_dirty,
+						    i_io_list)
+					if (time_after_eq(inode->dirtied_when,
+							  pos->dirtied_when))
+						break;
+				inode_io_list_move_locked_ctx(inode, new_wb,
+							      pos->i_io_list.prev,
+							      p_wb_ctx);
+			}
 		} else {
 			inode_cgwb_move_to_attached(inode, new_wb);
 		}
@@ -696,8 +754,11 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	 * accounted for.
 	 */
 	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
-	if (!restart)
-		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
+	/*
+	 * TODO : Modify it to work with parallel writeback
+	 * if (!restart)
+	 * restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
+	 */
 	spin_unlock(&wb->list_lock);
 
 	/* no attached inodes? bail out */
@@ -1010,53 +1071,59 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		struct wb_writeback_work *work;
 		long nr_pages;
 
-		if (last_wb) {
-			wb_put(last_wb);
-			last_wb = NULL;
-		}
+		for (int i = 0; i < NR_WB_CTX; i++) {
+			struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+			struct list_head *pctx_b_dirty_time =
+						ctx_b_dirty_time_list(wb, i);
 
-		/* SYNC_ALL writes out I_DIRTY_TIME too */
-		if (!wb_has_dirty_io(wb) &&
-		    (base_work->sync_mode == WB_SYNC_NONE ||
-		     list_empty(&wb->b_dirty_time)))
-			continue;
-		if (skip_if_busy && writeback_in_progress(wb))
-			continue;
+			if (last_wb) {
+				wb_put(last_wb);
+				last_wb = NULL;
+			}
 
-		nr_pages = wb_split_bdi_pages(wb, base_work->nr_pages);
+			/* SYNC_ALL writes out I_DIRTY_TIME too */
+			if (!wb_ctx_has_dirty_io(p_wb_ctx) &&
+			    (base_work->sync_mode == WB_SYNC_NONE ||
+			     list_empty(pctx_b_dirty_time)))
+				continue;
+			if (skip_if_busy && writeback_ctx_in_progress(p_wb_ctx))
+				continue;
 
-		work = kmalloc(sizeof(*work), GFP_ATOMIC);
-		if (work) {
-			*work = *base_work;
-			work->nr_pages = nr_pages;
-			work->auto_free = 1;
-			wb_queue_work(wb, work);
-			continue;
-		}
+			nr_pages = wb_split_bdi_pages(wb, base_work->nr_pages);
 
-		/*
-		 * If wb_tryget fails, the wb has been shutdown, skip it.
-		 *
-		 * Pin @wb so that it stays on @bdi->wb_list.  This allows
-		 * continuing iteration from @wb after dropping and
-		 * regrabbing rcu read lock.
-		 */
-		if (!wb_tryget(wb))
-			continue;
+			work = kmalloc(sizeof(*work), GFP_ATOMIC);
+			if (work) {
+				*work = *base_work;
+				work->nr_pages = nr_pages;
+				work->auto_free = 1;
+				wb_ctx_queue_work(wb, work, i);
+				continue;
+			}
 
-		/* alloc failed, execute synchronously using on-stack fallback */
-		work = &fallback_work;
-		*work = *base_work;
-		work->nr_pages = nr_pages;
-		work->auto_free = 0;
-		work->done = &fallback_work_done;
+			/*
+			 * If wb_tryget fails, the wb has been shutdown, skip it.
+			 *
+			 * Pin @wb so that it stays on @bdi->wb_list.  This allows
+			 * continuing iteration from @wb after dropping and
+			 * regrabbing rcu read lock.
+			 */
+			if (!wb_tryget(wb))
+				continue;
 
-		wb_queue_work(wb, work);
-		last_wb = wb;
+			/* alloc failed, execute synchronously using on-stack fallback */
+			work = &fallback_work;
+			*work = *base_work;
+			work->nr_pages = nr_pages;
+			work->auto_free = 0;
+			work->done = &fallback_work_done;
 
-		rcu_read_unlock();
-		wb_wait_for_completion(&fallback_work_done);
-		goto restart;
+			wb_ctx_queue_work(wb, work, i);
+			last_wb = wb;
+
+			rcu_read_unlock();
+			wb_wait_for_completion(&fallback_work_done);
+			goto restart;
+		}
 	}
 	rcu_read_unlock();
 
@@ -1131,7 +1198,8 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 		work->reason = reason;
 		work->done = done;
 		work->auto_free = 1;
-		wb_queue_work(wb, work);
+		/* Schedule on first wb_ctx */
+		wb_ctx_queue_work(wb, work, 0);
 		ret = 0;
 	} else {
 		ret = -ENOMEM;
@@ -1261,9 +1329,11 @@ static unsigned long get_nr_dirty_pages(void)
 		get_nr_dirty_inodes();
 }
 
-static void wb_start_writeback(struct bdi_writeback *wb, enum wb_reason reason)
+static void wb_ctx_start_writeback(struct bdi_writeback *wb,
+				   enum wb_reason reason,
+				   struct wb_ctx *p_wb_ctx)
 {
-	if (!wb_has_dirty_io(wb))
+	if (!wb_ctx_has_dirty_io(p_wb_ctx))
 		return;
 
 	/*
@@ -1274,12 +1344,12 @@ static void wb_start_writeback(struct bdi_writeback *wb, enum wb_reason reason)
 	 * that work. Ensure that we only allow one of them pending and
 	 * inflight at the time.
 	 */
-	if (test_bit(WB_start_all, &wb->state) ||
-	    test_and_set_bit(WB_start_all, &wb->state))
+	if (test_bit(WB_start_all, &p_wb_ctx->state) ||
+	    test_and_set_bit(WB_start_all, &p_wb_ctx->state))
 		return;
 
 	wb->start_all_reason = reason;
-	wb_wakeup(wb);
+	wb_ctx_wakeup(wb, p_wb_ctx);
 }
 
 /**
@@ -1308,13 +1378,19 @@ void wb_start_background_writeback(struct bdi_writeback *wb)
 void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
+	int i;
 
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	list_del_init(&inode->i_io_list);
-	wb_io_lists_depopulated(wb);
+
+	for (i = 0; i < NR_WB_CTX; i++) {
+		struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+
+		wb_ctx_io_lists_depopulated(wb, p_wb_ctx);
+	}
 
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&wb->list_lock);
@@ -1366,8 +1442,12 @@ void sb_clear_inode_writeback(struct inode *inode)
  * the case then the inode must have been redirtied while it was being written
  * out and we don't reset its dirtied_when.
  */
-static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
+static void redirty_tail_locked_ctx(struct inode *inode,
+				    struct bdi_writeback *wb,
+				    struct wb_ctx *p_wb_ctx)
 {
+	struct list_head *pctx_b_dirty = &p_wb_ctx->pctx_b_dirty;
+
 	assert_spin_locked(&inode->i_lock);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
@@ -1378,32 +1458,36 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 	 */
 	if (inode->i_state & I_FREEING) {
 		list_del_init(&inode->i_io_list);
-		wb_io_lists_depopulated(wb);
+		wb_ctx_io_lists_depopulated(wb, p_wb_ctx);
 		return;
 	}
-	if (!list_empty(&wb->b_dirty)) {
+	if (!list_empty(pctx_b_dirty)) {
 		struct inode *tail;
 
-		tail = wb_inode(wb->b_dirty.next);
+		tail = wb_inode(pctx_b_dirty->next);
 		if (time_before(inode->dirtied_when, tail->dirtied_when))
 			inode->dirtied_when = jiffies;
 	}
-	inode_io_list_move_locked(inode, wb, &wb->b_dirty);
+	inode_io_list_move_locked_ctx(inode, wb, pctx_b_dirty, p_wb_ctx);
 }
 
-static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
+static void redirty_tail_ctx(struct inode *inode, struct bdi_writeback *wb,
+			     struct wb_ctx *p_wb_ctx)
 {
 	spin_lock(&inode->i_lock);
-	redirty_tail_locked(inode, wb);
+	redirty_tail_locked_ctx(inode, wb, p_wb_ctx);
 	spin_unlock(&inode->i_lock);
 }
 
 /*
  * requeue inode for re-scanning after bdi->b_io list is exhausted.
  */
-static void requeue_io(struct inode *inode, struct bdi_writeback *wb)
+static void requeue_io_ctx(struct inode *inode, struct bdi_writeback *wb,
+			   struct wb_ctx *p_wb_ctx)
 {
-	inode_io_list_move_locked(inode, wb, &wb->b_more_io);
+	struct list_head *pctx_b_more_io = &p_wb_ctx->pctx_b_more_io;
+
+	inode_io_list_move_locked_ctx(inode, wb, pctx_b_more_io, p_wb_ctx);
 }
 
 static void inode_sync_complete(struct inode *inode)
@@ -1498,21 +1582,30 @@ static int move_expired_inodes(struct list_head *delaying_queue,
  *                                           |
  *                                           +--> dequeue for IO
  */
-static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work,
-		     unsigned long dirtied_before)
+static void queue_io_ctx(struct bdi_writeback *wb,
+			 struct wb_writeback_work *work,
+			 unsigned long dirtied_before,
+			 struct wb_ctx *p_wb_ctx)
 {
 	int moved;
 	unsigned long time_expire_jif = dirtied_before;
+	struct list_head *pctx_b_more_io, *pctx_b_io, *pctx_b_dirty,
+			 *pctx_b_dirty_time;
+
+	pctx_b_io = &p_wb_ctx->pctx_b_io;
+	pctx_b_more_io = &p_wb_ctx->pctx_b_more_io;
+	pctx_b_dirty = &p_wb_ctx->pctx_b_dirty;
+	pctx_b_dirty_time = &p_wb_ctx->pctx_b_dirty_time;
 
 	assert_spin_locked(&wb->list_lock);
-	list_splice_init(&wb->b_more_io, &wb->b_io);
-	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, dirtied_before);
+	list_splice_init(pctx_b_more_io, pctx_b_io);
+	moved = move_expired_inodes(pctx_b_dirty, pctx_b_io, dirtied_before);
 	if (!work->for_sync)
 		time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
-	moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
+	moved += move_expired_inodes(pctx_b_dirty_time, pctx_b_io,
 				     time_expire_jif);
 	if (moved)
-		wb_io_lists_populated(wb);
+		wb_ctx_io_lists_populated(wb, p_wb_ctx);
 	trace_writeback_queue_io(wb, work, dirtied_before, moved);
 }
 
@@ -1588,10 +1681,12 @@ static void inode_sleep_on_writeback(struct inode *inode)
  * processes all inodes in writeback lists and requeueing inodes behind flusher
  * thread's back can have unexpected consequences.
  */
-static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
-			  struct writeback_control *wbc,
-			  unsigned long dirtied_before)
+static void requeue_inode_ctx(struct inode *inode, struct bdi_writeback *wb,
+			      struct writeback_control *wbc,
+			      unsigned long dirtied_before,
+			      struct wb_ctx *p_wb_ctx)
 {
+	struct list_head *pctx_b_dirty_time = &p_wb_ctx->pctx_b_dirty_time;
 	if (inode->i_state & I_FREEING)
 		return;
 
@@ -1612,9 +1707,9 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * filesystems so handle that gracefully.
 		 */
 		if (inode->i_state & I_DIRTY_ALL)
-			redirty_tail_locked(inode, wb);
+			redirty_tail_locked_ctx(inode, wb, p_wb_ctx);
 		else
-			inode_cgwb_move_to_attached(inode, wb);
+			inode_cgwb_move_to_attached_ctx(inode, wb, p_wb_ctx);
 		return;
 	}
 
@@ -1626,7 +1721,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		if (wbc->nr_to_write <= 0 &&
 		    !inode_dirtied_after(inode, dirtied_before)) {
 			/* Slice used up. Queue for next turn. */
-			requeue_io(inode, wb);
+			requeue_io_ctx(inode, wb, p_wb_ctx);
 		} else {
 			/*
 			 * Writeback blocked by something other than
@@ -1635,7 +1730,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			 * retrying writeback of the dirty page/inode
 			 * that cannot be performed immediately.
 			 */
-			redirty_tail_locked(inode, wb);
+			redirty_tail_locked_ctx(inode, wb, p_wb_ctx);
 		}
 	} else if (inode->i_state & I_DIRTY) {
 		/*
@@ -1643,14 +1738,15 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * such as delayed allocation during submission or metadata
 		 * updates after data IO completion.
 		 */
-		redirty_tail_locked(inode, wb);
+		redirty_tail_locked_ctx(inode, wb, p_wb_ctx);
 	} else if (inode->i_state & I_DIRTY_TIME) {
 		inode->dirtied_when = jiffies;
-		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
+		inode_io_list_move_locked_ctx(inode, wb, pctx_b_dirty_time,
+					      p_wb_ctx);
 		inode->i_state &= ~I_SYNC_QUEUED;
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
-		inode_cgwb_move_to_attached(inode, wb);
+		inode_cgwb_move_to_attached_ctx(inode, wb, p_wb_ctx);
 	}
 }
 
@@ -1817,13 +1913,19 @@ static int writeback_single_inode(struct inode *inode,
 		if (!(inode->i_state & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
 		else if (!(inode->i_state & I_SYNC_QUEUED)) {
+			/* Move to first wb_ctx */
+			struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, 0);
+			struct list_head *pctx_b_dirty_time =
+					ctx_b_dirty_time_list(wb, 0);
+
 			if ((inode->i_state & I_DIRTY))
-				redirty_tail_locked(inode, wb);
+				redirty_tail_locked_ctx(inode, wb, p_wb_ctx);
 			else if (inode->i_state & I_DIRTY_TIME) {
 				inode->dirtied_when = jiffies;
-				inode_io_list_move_locked(inode,
-							  wb,
-							  &wb->b_dirty_time);
+				inode_io_list_move_locked_ctx(inode,
+							      wb,
+							      pctx_b_dirty_time,
+							      p_wb_ctx);
 			}
 		}
 	}
@@ -1836,7 +1938,8 @@ static int writeback_single_inode(struct inode *inode,
 }
 
 static long writeback_chunk_size(struct bdi_writeback *wb,
-				 struct wb_writeback_work *work)
+				 struct wb_writeback_work *work,
+				 struct wb_ctx *p_wb_ctx)
 {
 	long pages;
 
@@ -1856,7 +1959,7 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
 	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
 		pages = LONG_MAX;
 	else {
-		pages = min(wb->avg_write_bandwidth / 2,
+		pages = min(p_wb_ctx->avg_write_bandwidth / 2,
 			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
 		pages = min(pages, work->nr_pages);
 		pages = round_down(pages + MIN_WRITEBACK_PAGES,
@@ -1875,9 +1978,10 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
  * unlock and relock that for each inode it ends up doing
  * IO for.
  */
-static long writeback_sb_inodes(struct super_block *sb,
-				struct bdi_writeback *wb,
-				struct wb_writeback_work *work)
+static long writeback_sb_inodes_ctx(struct super_block *sb,
+				    struct bdi_writeback *wb,
+				    struct wb_writeback_work *work,
+				    struct wb_ctx *p_wb_ctx)
 {
 	struct writeback_control wbc = {
 		.sync_mode		= work->sync_mode,
@@ -1893,13 +1997,14 @@ static long writeback_sb_inodes(struct super_block *sb,
 	long write_chunk;
 	long total_wrote = 0;  /* count both pages and inodes */
 	unsigned long dirtied_before = jiffies;
+	struct list_head *pctx_b_io = &p_wb_ctx->pctx_b_io;
 
 	if (work->for_kupdate)
 		dirtied_before = jiffies -
 			msecs_to_jiffies(dirty_expire_interval * 10);
 
-	while (!list_empty(&wb->b_io)) {
-		struct inode *inode = wb_inode(wb->b_io.prev);
+	while (!list_empty(pctx_b_io)) {
+		struct inode *inode = wb_inode(pctx_b_io->prev);
 		struct bdi_writeback *tmp_wb;
 		long wrote;
 
@@ -1910,7 +2015,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 				 * superblock, move all inodes not belonging
 				 * to it back onto the dirty list.
 				 */
-				redirty_tail(inode, wb);
+				redirty_tail_ctx(inode, wb, p_wb_ctx);
 				continue;
 			}
 
@@ -1929,7 +2034,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 */
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
-			redirty_tail_locked(inode, wb);
+			redirty_tail_locked_ctx(inode, wb, p_wb_ctx);
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1943,7 +2048,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 			 * We'll have another go at writing back this inode
 			 * when we completed a full scan of b_io.
 			 */
-			requeue_io(inode, wb);
+			requeue_io_ctx(inode, wb, p_wb_ctx);
 			spin_unlock(&inode->i_lock);
 			trace_writeback_sb_inodes_requeue(inode);
 			continue;
@@ -1965,7 +2070,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		inode->i_state |= I_SYNC;
 		wbc_attach_and_unlock_inode(&wbc, inode);
 
-		write_chunk = writeback_chunk_size(wb, work);
+		write_chunk = writeback_chunk_size(wb, work, p_wb_ctx);
 		wbc.nr_to_write = write_chunk;
 		wbc.pages_skipped = 0;
 
@@ -2002,7 +2107,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		spin_lock(&inode->i_lock);
 		if (!(inode->i_state & I_DIRTY_ALL))
 			total_wrote++;
-		requeue_inode(inode, tmp_wb, &wbc, dirtied_before);
+		requeue_inode_ctx(inode, tmp_wb, &wbc, dirtied_before, p_wb_ctx);
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
 
@@ -2025,14 +2130,16 @@ static long writeback_sb_inodes(struct super_block *sb,
 	return total_wrote;
 }
 
-static long __writeback_inodes_wb(struct bdi_writeback *wb,
-				  struct wb_writeback_work *work)
+static long __writeback_inodes_wb_ctx(struct bdi_writeback *wb,
+				      struct wb_writeback_work *work,
+				      struct wb_ctx *p_wb_ctx)
 {
 	unsigned long start_time = jiffies;
 	long wrote = 0;
+	struct list_head *pctx_b_io = &p_wb_ctx->pctx_b_io;
 
-	while (!list_empty(&wb->b_io)) {
-		struct inode *inode = wb_inode(wb->b_io.prev);
+	while (!list_empty(pctx_b_io)) {
+		struct inode *inode = wb_inode(pctx_b_io->prev);
 		struct super_block *sb = inode->i_sb;
 
 		if (!super_trylock_shared(sb)) {
@@ -2041,10 +2148,10 @@ static long __writeback_inodes_wb(struct bdi_writeback *wb,
 			 * s_umount being grabbed by someone else. Don't use
 			 * requeue_io() to avoid busy retrying the inode/sb.
 			 */
-			redirty_tail(inode, wb);
+			redirty_tail_ctx(inode, wb, p_wb_ctx);
 			continue;
 		}
-		wrote += writeback_sb_inodes(sb, wb, work);
+		wrote += writeback_sb_inodes_ctx(sb, wb, work, p_wb_ctx);
 		up_read(&sb->s_umount);
 
 		/* refer to the same tests at the end of writeback_sb_inodes */
@@ -2059,8 +2166,8 @@ static long __writeback_inodes_wb(struct bdi_writeback *wb,
 	return wrote;
 }
 
-static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
-				enum wb_reason reason)
+static long writeback_inodes_wb_ctx(struct bdi_writeback *wb, long nr_pages,
+				enum wb_reason reason, struct wb_ctx *p_wb_ctx)
 {
 	struct wb_writeback_work work = {
 		.nr_pages	= nr_pages,
@@ -2069,12 +2176,13 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
 		.reason		= reason,
 	};
 	struct blk_plug plug;
+	struct list_head *pctx_b_io = &p_wb_ctx->pctx_b_io;
 
 	blk_start_plug(&plug);
 	spin_lock(&wb->list_lock);
-	if (list_empty(&wb->b_io))
-		queue_io(wb, &work, jiffies);
-	__writeback_inodes_wb(wb, &work);
+	if (list_empty(pctx_b_io))
+		queue_io_ctx(wb, &work, jiffies, p_wb_ctx);
+	__writeback_inodes_wb_ctx(wb, &work, p_wb_ctx);
 	spin_unlock(&wb->list_lock);
 	blk_finish_plug(&plug);
 
@@ -2096,8 +2204,9 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
  * dirtied_before takes precedence over nr_to_write.  So we'll only write back
  * all dirty pages if they are all attached to "old" mappings.
  */
-static long wb_writeback(struct bdi_writeback *wb,
-			 struct wb_writeback_work *work)
+static long wb_ctx_writeback(struct bdi_writeback *wb,
+			     struct wb_writeback_work *work,
+			     struct wb_ctx *p_wb_ctx)
 {
 	long nr_pages = work->nr_pages;
 	unsigned long dirtied_before = jiffies;
@@ -2105,6 +2214,10 @@ static long wb_writeback(struct bdi_writeback *wb,
 	long progress;
 	struct blk_plug plug;
 	bool queued = false;
+	struct list_head *pctx_b_io, *pctx_b_more_io;
+
+	pctx_b_io = &p_wb_ctx->pctx_b_io;
+	pctx_b_more_io = &p_wb_ctx->pctx_b_more_io;
 
 	blk_start_plug(&plug);
 	for (;;) {
@@ -2135,7 +2248,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		spin_lock(&wb->list_lock);
 
 		trace_writeback_start(wb, work);
-		if (list_empty(&wb->b_io)) {
+		if (list_empty(pctx_b_io)) {
 			/*
 			 * Kupdate and background works are special and we want
 			 * to include all inodes that need writing. Livelock
@@ -2149,13 +2262,13 @@ static long wb_writeback(struct bdi_writeback *wb,
 			} else if (work->for_background)
 				dirtied_before = jiffies;
 
-			queue_io(wb, work, dirtied_before);
+			queue_io_ctx(wb, work, dirtied_before, p_wb_ctx);
 			queued = true;
 		}
 		if (work->sb)
-			progress = writeback_sb_inodes(work->sb, wb, work);
+			progress = writeback_sb_inodes_ctx(work->sb, wb, work, p_wb_ctx);
 		else
-			progress = __writeback_inodes_wb(wb, work);
+			progress = __writeback_inodes_wb_ctx(wb, work, p_wb_ctx);
 		trace_writeback_written(wb, work);
 
 		/*
@@ -2174,7 +2287,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		/*
 		 * No more inodes for IO, bail
 		 */
-		if (list_empty(&wb->b_more_io)) {
+		if (list_empty(pctx_b_more_io)) {
 			spin_unlock(&wb->list_lock);
 			break;
 		}
@@ -2185,7 +2298,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * we'll just busyloop.
 		 */
 		trace_writeback_wait(wb, work);
-		inode = wb_inode(wb->b_more_io.prev);
+		inode = wb_inode(pctx_b_more_io->prev);
 		spin_lock(&inode->i_lock);
 		spin_unlock(&wb->list_lock);
 		/* This function drops i_lock... */
@@ -2213,7 +2326,8 @@ static struct wb_writeback_work *get_next_work_item(struct bdi_writeback *wb)
 	return work;
 }
 
-static long wb_check_background_flush(struct bdi_writeback *wb)
+static long wb_ctx_check_background_flush(struct bdi_writeback *wb,
+					  struct wb_ctx *p_wb_ctx)
 {
 	if (wb_over_bg_thresh(wb)) {
 
@@ -2225,13 +2339,14 @@ static long wb_check_background_flush(struct bdi_writeback *wb)
 			.reason		= WB_REASON_BACKGROUND,
 		};
 
-		return wb_writeback(wb, &work);
+		return wb_ctx_writeback(wb, &work, p_wb_ctx);
 	}
 
 	return 0;
 }
 
-static long wb_check_old_data_flush(struct bdi_writeback *wb)
+static long wb_ctx_check_old_data_flush(struct bdi_writeback *wb,
+					struct wb_ctx *p_wb_ctx)
 {
 	unsigned long expired;
 	long nr_pages;
@@ -2242,12 +2357,12 @@ static long wb_check_old_data_flush(struct bdi_writeback *wb)
 	if (!dirty_writeback_interval)
 		return 0;
 
-	expired = wb->last_old_flush +
+	expired = p_wb_ctx->last_old_flush +
 			msecs_to_jiffies(dirty_writeback_interval * 10);
 	if (time_before(jiffies, expired))
 		return 0;
 
-	wb->last_old_flush = jiffies;
+	p_wb_ctx->last_old_flush = jiffies;
 	nr_pages = get_nr_dirty_pages();
 
 	if (nr_pages) {
@@ -2259,17 +2374,18 @@ static long wb_check_old_data_flush(struct bdi_writeback *wb)
 			.reason		= WB_REASON_PERIODIC,
 		};
 
-		return wb_writeback(wb, &work);
+		return wb_ctx_writeback(wb, &work, p_wb_ctx);
 	}
 
 	return 0;
 }
 
-static long wb_check_start_all(struct bdi_writeback *wb)
+static long wb_ctx_check_start_all(struct bdi_writeback *wb,
+				   struct wb_ctx *p_wb_ctx)
 {
 	long nr_pages;
 
-	if (!test_bit(WB_start_all, &wb->state))
+	if (!test_bit(WB_start_all, &p_wb_ctx->state))
 		return 0;
 
 	nr_pages = get_nr_dirty_pages();
@@ -2281,40 +2397,40 @@ static long wb_check_start_all(struct bdi_writeback *wb)
 			.reason		= wb->start_all_reason,
 		};
 
-		nr_pages = wb_writeback(wb, &work);
+		nr_pages = wb_ctx_writeback(wb, &work, p_wb_ctx);
 	}
 
-	clear_bit(WB_start_all, &wb->state);
+	clear_bit(WB_start_all, &p_wb_ctx->state);
 	return nr_pages;
 }
 
-
 /*
  * Retrieve work items and do the writeback they describe
  */
-static long wb_do_writeback(struct bdi_writeback *wb)
+static long wb_ctx_do_writeback(struct bdi_writeback *wb,
+				struct wb_ctx *p_wb_ctx)
 {
 	struct wb_writeback_work *work;
 	long wrote = 0;
 
-	set_bit(WB_writeback_running, &wb->state);
+	set_bit(WB_writeback_running, &p_wb_ctx->state);
 	while ((work = get_next_work_item(wb)) != NULL) {
 		trace_writeback_exec(wb, work);
-		wrote += wb_writeback(wb, work);
+		wrote += wb_ctx_writeback(wb, work, p_wb_ctx);
 		finish_writeback_work(work);
 	}
 
 	/*
 	 * Check for a flush-everything request
 	 */
-	wrote += wb_check_start_all(wb);
+	wrote += wb_ctx_check_start_all(wb, p_wb_ctx);
 
 	/*
 	 * Check for periodic writeback, kupdated() style
 	 */
-	wrote += wb_check_old_data_flush(wb);
-	wrote += wb_check_background_flush(wb);
-	clear_bit(WB_writeback_running, &wb->state);
+	wrote += wb_ctx_check_old_data_flush(wb, p_wb_ctx);
+	wrote += wb_ctx_check_background_flush(wb, p_wb_ctx);
+	clear_bit(WB_writeback_running, &p_wb_ctx->state);
 
 	return wrote;
 }
@@ -2323,10 +2439,11 @@ static long wb_do_writeback(struct bdi_writeback *wb)
  * Handle writeback of dirty data for the device backed by this bdi. Also
  * reschedules periodically and does kupdated style flushing.
  */
-void wb_workfn(struct work_struct *work)
+void wb_ctx_workfn(struct work_struct *work)
 {
-	struct bdi_writeback *wb = container_of(to_delayed_work(work),
-						struct bdi_writeback, dwork);
+	struct wb_ctx *p_wb_ctx = container_of(to_delayed_work(work),
+					struct wb_ctx, pctx_dwork);
+	struct bdi_writeback *wb = p_wb_ctx->b_wb;
 	long pages_written;
 
 	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
@@ -2340,7 +2457,7 @@ void wb_workfn(struct work_struct *work)
 		 * rescuer as work_list needs to be drained.
 		 */
 		do {
-			pages_written = wb_do_writeback(wb);
+			pages_written = wb_ctx_do_writeback(wb, p_wb_ctx);
 			trace_writeback_pages_written(pages_written);
 		} while (!list_empty(&wb->work_list));
 	} else {
@@ -2349,15 +2466,16 @@ void wb_workfn(struct work_struct *work)
 		 * the emergency worker.  Don't hog it.  Hopefully, 1024 is
 		 * enough for efficient IO.
 		 */
-		pages_written = writeback_inodes_wb(wb, 1024,
-						    WB_REASON_FORKER_THREAD);
+		pages_written = writeback_inodes_wb_ctx(wb, 1024,
+						WB_REASON_FORKER_THREAD,
+						p_wb_ctx);
 		trace_writeback_pages_written(pages_written);
 	}
 
 	if (!list_empty(&wb->work_list))
-		wb_wakeup(wb);
-	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
-		wb_wakeup_delayed(wb);
+		wb_ctx_wakeup(wb, p_wb_ctx);
+	else if (wb_ctx_has_dirty_io(p_wb_ctx) && dirty_writeback_interval)
+		wb_ctx_wakeup_delayed(wb, p_wb_ctx);
 }
 
 /*
@@ -2371,8 +2489,13 @@ static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 	if (!bdi_has_dirty_io(bdi))
 		return;
 
-	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
-		wb_start_writeback(wb, reason);
+	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+		for (int i = 0; i < NR_WB_CTX; i++) {
+			struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+
+			wb_ctx_start_writeback(wb, reason, p_wb_ctx);
+		}
+	}
 }
 
 void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
@@ -2427,9 +2550,16 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list) {
 		struct bdi_writeback *wb;
 
-		list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
-			if (!list_empty(&wb->b_dirty_time))
-				wb_wakeup(wb);
+		list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+			for (int i = 0; i < NR_WB_CTX; i++) {
+				struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+				struct list_head *pcpu_dirty_time_list =
+						ctx_b_dirty_time_list(wb, i);
+
+				if (!list_empty(pcpu_dirty_time_list))
+					wb_ctx_wakeup(wb, p_wb_ctx);
+			}
+		}
 	}
 	rcu_read_unlock();
 	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
@@ -2581,6 +2711,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * reposition it (that would break b_dirty time-ordering).
 		 */
 		if (!was_dirty) {
+			/* Schedule writeback on first wb_ctx */
+			struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, 0);
 			struct list_head *dirty_list;
 			bool wakeup_bdi = false;
 
@@ -2588,13 +2720,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
 
+
 			if (inode->i_state & I_DIRTY)
-				dirty_list = &wb->b_dirty;
+				dirty_list = ctx_b_dirty_list(wb, 0);
 			else
-				dirty_list = &wb->b_dirty_time;
+				dirty_list = ctx_b_dirty_time_list(wb,
+								   0);
 
-			wakeup_bdi = inode_io_list_move_locked(inode, wb,
-							       dirty_list);
+			wakeup_bdi = inode_io_list_move_locked_ctx(inode, wb,
+								   dirty_list,
+								   p_wb_ctx);
 
 			spin_unlock(&wb->list_lock);
 			spin_unlock(&inode->i_lock);
@@ -2608,7 +2743,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			 */
 			if (wakeup_bdi &&
 			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
-				wb_wakeup_delayed(wb);
+				wb_ctx_wakeup_delayed(wb, p_wb_ctx);
 			return;
 		}
 	}
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index df627783e879..d7e9df5562f4 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -134,15 +134,12 @@ struct bdi_writeback {
 	unsigned long state;		/* Always use atomic bitops on this */
 	unsigned long last_old_flush;	/* last old data flush */
 
-	struct list_head b_dirty;	/* dirty inodes */
-	struct list_head b_io;		/* parked for writeback */
-	struct list_head b_more_io;	/* parked for more writeback */
-	struct list_head b_dirty_time;	/* time stamps are dirty */
 	spinlock_t list_lock;		/* protects the b_* lists */
 
 	atomic_t writeback_inodes;	/* number of inodes under writeback */
 	struct percpu_counter stat[NR_WB_STAT_ITEMS];
 
+	/* TODO : Remove these duplicated fields */
 	unsigned long bw_time_stamp;	/* last time write bw is updated */
 	unsigned long dirtied_stamp;
 	unsigned long written_stamp;	/* pages written at bw_time_stamp */
@@ -164,7 +161,6 @@ struct bdi_writeback {
 
 	spinlock_t work_lock;		/* protects work_list & dwork scheduling */
 	struct list_head work_list;
-	struct delayed_work dwork;	/* work item used for writeback */
 	struct delayed_work bw_dwork;	/* work item used for bandwidth estimate */
 
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..c2c2fa5dbb44 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -37,7 +37,7 @@ void bdi_unregister(struct backing_dev_info *bdi);
 struct backing_dev_info *bdi_alloc(int node_id);
 
 void wb_start_background_writeback(struct bdi_writeback *wb);
-void wb_workfn(struct work_struct *work);
+void wb_ctx_workfn(struct work_struct *work);
 
 void wb_wait_for_completion(struct wb_completion *done);
 
@@ -48,7 +48,21 @@ extern struct workqueue_struct *bdi_wq;
 
 static inline bool wb_has_dirty_io(struct bdi_writeback *wb)
 {
-	return test_bit(WB_has_dirty_io, &wb->state);
+	bool state;
+	struct wb_ctx *p_wb_ctx;
+
+	for (int i = 0; i < NR_WB_CTX; i++) {
+		p_wb_ctx = ctx_wb_struct(wb, i);
+		state =  test_bit(WB_has_dirty_io, &p_wb_ctx->state);
+		if (state)
+			return state;
+	}
+	return false;
+}
+
+static inline bool wb_ctx_has_dirty_io(struct wb_ctx *p_wb_ctx)
+{
+	return test_bit(WB_has_dirty_io, &p_wb_ctx->state);
 }
 
 static inline bool bdi_has_dirty_io(struct backing_dev_info *bdi)
@@ -138,7 +152,21 @@ int bdi_init(struct backing_dev_info *bdi);
  */
 static inline bool writeback_in_progress(struct bdi_writeback *wb)
 {
-	return test_bit(WB_writeback_running, &wb->state);
+	bool state;
+	struct wb_ctx *p_wb_ctx;
+
+	for (int i = 0; i < NR_WB_CTX; i++) {
+		p_wb_ctx = ctx_wb_struct(wb, i);
+		state =  test_bit(WB_writeback_running, &p_wb_ctx->state);
+		if (state)
+			return state;
+	}
+	return false;
+}
+
+static inline bool writeback_ctx_in_progress(struct wb_ctx *p_wb_ctx)
+{
+	return test_bit(WB_writeback_running, &p_wb_ctx->state);
 }
 
 struct backing_dev_info *inode_to_bdi(struct inode *inode);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index fc072e9fe42c..1711759f4879 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -65,15 +65,24 @@ static void collect_wb_stats(struct wb_stats *stats,
 	struct inode *inode;
 
 	spin_lock(&wb->list_lock);
-	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
-		stats->nr_dirty++;
-	list_for_each_entry(inode, &wb->b_io, i_io_list)
-		stats->nr_io++;
-	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
-		stats->nr_more_io++;
-	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
-		if (inode->i_state & I_DIRTY_TIME)
-			stats->nr_dirty_time++;
+
+	for (int i = 0; i < NR_WB_CTX; i++) {
+		struct list_head *pctx_b_dirty = ctx_b_dirty_list(wb, i);
+		struct list_head *pctx_b_io = ctx_b_io_list(wb, i);
+		struct list_head *pctx_b_more_io = ctx_b_more_io_list(wb, i);
+		struct list_head *pctx_b_dirty_time =
+					ctx_b_dirty_time_list(wb, i);
+
+		list_for_each_entry(inode, pctx_b_dirty, i_io_list)
+			stats->nr_dirty++;
+		list_for_each_entry(inode, pctx_b_io, i_io_list)
+			stats->nr_io++;
+		list_for_each_entry(inode, pctx_b_more_io, i_io_list)
+			stats->nr_more_io++;
+		list_for_each_entry(inode, pctx_b_dirty_time, i_io_list)
+			if (inode->i_state & I_DIRTY_TIME)
+				stats->nr_dirty_time++;
+	}
 	spin_unlock(&wb->list_lock);
 
 	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
@@ -522,10 +531,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 	wb->bdi = bdi;
 	wb->last_old_flush = jiffies;
-	INIT_LIST_HEAD(&wb->b_dirty);
-	INIT_LIST_HEAD(&wb->b_io);
-	INIT_LIST_HEAD(&wb->b_more_io);
-	INIT_LIST_HEAD(&wb->b_dirty_time);
 	spin_lock_init(&wb->list_lock);
 
 	atomic_set(&wb->writeback_inodes, 0);
@@ -538,7 +543,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 	spin_lock_init(&wb->work_lock);
 	INIT_LIST_HEAD(&wb->work_list);
-	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
 	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
 
 	for (i = 0; i < NR_WB_CTX; i++) {
@@ -556,8 +560,9 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 		INIT_LIST_HEAD(ctx_b_io_list(wb, i));
 		INIT_LIST_HEAD(ctx_b_more_io_list(wb, i));
 
-		INIT_DELAYED_WORK(&p_wb_ctx->pctx_dwork, wb_workfn);
+		INIT_DELAYED_WORK(&p_wb_ctx->pctx_dwork, wb_ctx_workfn);
 	}
+
 	err = fprop_local_init_percpu(&wb->completions, gfp);
 	if (err)
 		return err;
@@ -590,15 +595,23 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
 	 * be drained no matter what.
 	 */
-	mod_delayed_work(bdi_wq, &wb->dwork, 0);
-	flush_delayed_work(&wb->dwork);
+	for (int i = 0; i < NR_WB_CTX; i++) {
+		struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+
+		mod_delayed_work(bdi_wq, &p_wb_ctx->pctx_dwork, 0);
+		flush_delayed_work(&p_wb_ctx->pctx_dwork);
+	}
 	WARN_ON(!list_empty(&wb->work_list));
 	flush_delayed_work(&wb->bw_dwork);
 }
 
 static void wb_exit(struct bdi_writeback *wb)
 {
-	WARN_ON(delayed_work_pending(&wb->dwork));
+	for (int i = 0; i < NR_WB_CTX; i++) {
+		struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
+
+		WARN_ON(delayed_work_pending(&p_wb_ctx->pctx_dwork));
+	}
 	percpu_counter_destroy_many(wb->stat, NR_WB_STAT_ITEMS);
 	fprop_local_destroy_percpu(&wb->completions);
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb55ece39c56..fa68facaa651 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1255,54 +1255,60 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
 	dtc->pos_ratio = pos_ratio;
 }
 
-static void wb_update_write_bandwidth(struct bdi_writeback *wb,
+static void wb_pctx_update_write_bandwidth(struct bdi_writeback *wb,
 				      unsigned long elapsed,
 				      unsigned long written)
 {
 	const unsigned long period = roundup_pow_of_two(3 * HZ);
-	unsigned long avg = wb->avg_write_bandwidth;
-	unsigned long old = wb->write_bandwidth;
 	u64 bw;
+	int i;
 
-	/*
-	 * bw = written * HZ / elapsed
-	 *
-	 *                   bw * elapsed + write_bandwidth * (period - elapsed)
-	 * write_bandwidth = ---------------------------------------------------
-	 *                                          period
-	 *
-	 * @written may have decreased due to folio_redirty_for_writepage().
-	 * Avoid underflowing @bw calculation.
-	 */
-	bw = written - min(written, wb->written_stamp);
-	bw *= HZ;
-	if (unlikely(elapsed > period)) {
-		bw = div64_ul(bw, elapsed);
-		avg = bw;
-		goto out;
-	}
-	bw += (u64)wb->write_bandwidth * (period - elapsed);
-	bw >>= ilog2(period);
+	for (i = 0; i < NR_WB_CTX; i++) {
+		unsigned long avg, old;
+		struct wb_ctx *p_wb_ctx = ctx_wb_struct(wb, i);
 
-	/*
-	 * one more level of smoothing, for filtering out sudden spikes
-	 */
-	if (avg > old && old >= (unsigned long)bw)
-		avg -= (avg - old) >> 3;
+		avg = p_wb_ctx->avg_write_bandwidth;
+		old = p_wb_ctx->write_bandwidth;
+		/*
+		 * bw = written * HZ / elapsed
+		 *
+		 *                   bw * elapsed + write_bandwidth * (period - elapsed)
+		 * write_bandwidth = ---------------------------------------------------
+		 *                                          period
+		 *
+		 * @written may have decreased due to folio_redirty_for_writepage().
+		 * Avoid underflowing @bw calculation.
+		 */
+		bw = written - min(written, wb->written_stamp);
+		bw *= HZ;
+		if (unlikely(elapsed > period)) {
+			bw = div64_ul(bw, elapsed);
+			avg = bw;
+			goto out;
+		}
+		bw += (u64)p_wb_ctx->write_bandwidth * (period - elapsed);
+		bw >>= ilog2(period);
 
-	if (avg < old && old <= (unsigned long)bw)
-		avg += (old - avg) >> 3;
+		/*
+		 * one more level of smoothing, for filtering out sudden spikes
+		 */
+		if (avg > old && old >= (unsigned long)bw)
+			avg -= (avg - old) >> 3;
 
+		if (avg < old && old <= (unsigned long)bw)
+			avg += (old - avg) >> 3;
 out:
-	/* keep avg > 0 to guarantee that tot > 0 if there are dirty wbs */
-	avg = max(avg, 1LU);
-	if (wb_has_dirty_io(wb)) {
-		long delta = avg - wb->avg_write_bandwidth;
-		WARN_ON_ONCE(atomic_long_add_return(delta,
-					&wb->bdi->tot_write_bandwidth) <= 0);
+		/* keep avg > 0 to guarantee that tot > 0 if there are dirty wbs */
+		avg = max(avg, 1LU);
+		if (wb_ctx_has_dirty_io(p_wb_ctx)) {
+			long delta = avg - p_wb_ctx->avg_write_bandwidth;
+
+			WARN_ON_ONCE(atomic_long_add_return(delta,
+						&wb->bdi->tot_write_bandwidth) <= 0);
+		}
+		p_wb_ctx->write_bandwidth = bw;
+		WRITE_ONCE(p_wb_ctx->avg_write_bandwidth, avg);
 	}
-	wb->write_bandwidth = bw;
-	WRITE_ONCE(wb->avg_write_bandwidth, avg);
 }
 
 static void update_dirty_limit(struct dirty_throttle_control *dtc)
@@ -1545,7 +1551,7 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 			wb_update_dirty_ratelimit(mdtc, dirtied, elapsed);
 		}
 	}
-	wb_update_write_bandwidth(wb, elapsed, written);
+	wb_pctx_update_write_bandwidth(wb, elapsed, written);
 
 	wb->dirtied_stamp = dirtied;
 	wb->written_stamp = written;
-- 
2.25.1


