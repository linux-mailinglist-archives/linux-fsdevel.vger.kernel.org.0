Return-Path: <linux-fsdevel+bounces-64125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49884BD9466
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3C189C497
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82603128A6;
	Tue, 14 Oct 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IZEVWzpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771E3126BE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443904; cv=none; b=ap0KBZqoa0F/LIwa2h2tPQtekqUxrTq0J940MFS1KcqyoyBgX8gtbHpjSMjMqwRen2NqpZq19gbwDbxnAuWDYMnD4WdFNyBbkNNi315hFSQrDI6XiGLi9YbM9W02Bwg9gr+L5lEFRMNwXLZ8MPrhG5I2/BIu7wuUYxyCFk7kYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443904; c=relaxed/simple;
	bh=mwJ7fVo6wH6GnrrZ6oCciTIhPSom8JD+XnpoNvDsnxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=IFDsZr+K6LmmBRycD3BeLX5EtLaFIUCdCY+iu+JshSSZxTg9nyhxqDfC8efeDTHMAv0bQGZiBZpysLbTRSheB4qeQQlWQmCPd6T+22ezpJc4FudKizl2fq1Bs/RHynX3s8hOjvdJpACtLXWBw8oaACZIDLrLVqtXUH2zgoq3HZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IZEVWzpU; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251014121138epoutp04f8f82a785af5756c9046994aefb17f47~uWmYQumY-1160811608epoutp04r
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251014121138epoutp04f8f82a785af5756c9046994aefb17f47~uWmYQumY-1160811608epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443898;
	bh=P26ywqsMnB1wfPCMRtpUS0xgTfcL9X0rkalZt4nakI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZEVWzpUM/VeejCxB/jGms73fEuWMwgHnd43yIQgt1GWnuFDZiPddMvQlfgmuselr
	 P8CMZVovdo1GkWEFNVldpJQ8snOLCctSBP9XD24zoZGz9iz9Hp6oLEr1bJQ1M6v5Rr
	 O61UQsByvXzJ7XsFA5175gAii6scO4d7O9zrDXY4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251014121137epcas5p252ab21a6f213e2a3de40624cc4a06c89~uWmXXMLo33235432354epcas5p2t;
	Tue, 14 Oct 2025 12:11:37 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cmCkJ5szQz2SSKY; Tue, 14 Oct
	2025 12:11:36 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20251014121135epcas5p2aa801677c0561db10291c51d669873e2~uWmVjz9X22441424414epcas5p2q;
	Tue, 14 Oct 2025 12:11:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121131epsmtip1ababe9c4e8295da908008c77b52ba39e~uWmROln091256112561epsmtip1N;
	Tue, 14 Oct 2025 12:11:31 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 16/16] writeback: added XFS support for matching
 writeback count to allocation group count
Date: Tue, 14 Oct 2025 17:38:45 +0530
Message-Id: <20251014120845.2361-17-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121135epcas5p2aa801677c0561db10291c51d669873e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121135epcas5p2aa801677c0561db10291c51d669873e2
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121135epcas5p2aa801677c0561db10291c51d669873e2@epcas5p2.samsung.com>

Implemented bdi_inc_writeback() to increase the writeback context
count and called this function at XFS mount time to set the desired
count.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_super.c          |  2 ++
 include/linux/backing-dev.h |  1 +
 mm/backing-dev.c            | 58 +++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b3ec9141d902..aa97b59f53c6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1783,6 +1783,8 @@ xfs_fs_fill_super(
 	if (error)
 		goto out_free_sb;
 
+	bdi_inc_writeback(sb->s_bdi, mp->m_sb.sb_agcount);
+
 	/*
 	 * V4 support is undergoing deprecation.
 	 *
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 14f53183b8d1..89a465e1964f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -40,6 +40,7 @@ void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
 
 void wb_wait_for_completion(struct wb_completion *done);
+int bdi_inc_writeback(struct backing_dev_info *bdi, int nwriteback);
 
 extern spinlock_t bdi_lock;
 extern struct list_head bdi_list;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 5bfb9bf3ce52..e450b3a9b952 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1219,6 +1219,64 @@ struct backing_dev_info *bdi_alloc(int node_id)
 }
 EXPORT_SYMBOL(bdi_alloc);
 
+int bdi_inc_writeback(struct backing_dev_info *bdi, int nwritebacks)
+{
+	struct bdi_writeback_ctx **wb_ctx;
+	int ret = 0;
+
+	if (nwritebacks <= bdi->nr_wb_ctx)
+		return ret;
+
+	wb_ctx = kcalloc(nwritebacks, sizeof(struct bdi_writeback_ctx *),
+			 GFP_KERNEL);
+	if (!wb_ctx)
+		return -ENOMEM;
+
+	for (int i = 0; i < bdi->nr_wb_ctx; i++)
+		wb_ctx[i] = bdi->wb_ctx[i];
+
+	for (int i = bdi->nr_wb_ctx; i < nwritebacks; i++) {
+		wb_ctx[i] = (struct bdi_writeback_ctx *)
+			kzalloc(sizeof(struct bdi_writeback_ctx), GFP_KERNEL);
+		if (!wb_ctx[i]) {
+			pr_err("Failed to allocate %d", i);
+			while (--i >= bdi->nr_wb_ctx)
+				kfree(wb_ctx[i]);
+			kfree(wb_ctx);
+			return -ENOMEM;
+		}
+		INIT_LIST_HEAD(&wb_ctx[i]->wb_list);
+		init_waitqueue_head(&wb_ctx[i]->wb_waitq);
+
+#ifdef CONFIG_CGROUP_WRITEBACK
+		INIT_RADIX_TREE(&wb_ctx[i]->cgwb_tree, GFP_ATOMIC);
+		init_rwsem(&wb_ctx[i]->wb_switch_rwsem);
+#endif
+		ret = wb_init(&wb_ctx[i]->wb, wb_ctx[i], bdi, GFP_KERNEL);
+		if (!ret) {
+#ifdef CONFIG_CGROUP_WRITEBACK
+			wb_ctx[i]->wb.memcg_css = &root_mem_cgroup->css;
+			wb_ctx[i]->wb.blkcg_css = blkcg_root_css;
+#endif
+		} else {
+			while (--i >= bdi->nr_wb_ctx)
+				kfree(wb_ctx[i]);
+			kfree(wb_ctx);
+			return ret;
+		}
+		cgwb_bdi_register(bdi, wb_ctx[i]);
+		set_bit(WB_registered, &wb_ctx[i]->wb.state);
+	}
+
+	spin_lock_bh(&bdi_lock);
+	kfree(bdi->wb_ctx);
+	bdi->wb_ctx = wb_ctx;
+	bdi->nr_wb_ctx = nwritebacks;
+	spin_unlock_bh(&bdi_lock);
+	return 0;
+}
+EXPORT_SYMBOL(bdi_inc_writeback);
+
 static struct rb_node **bdi_lookup_rb_node(u64 id, struct rb_node **parentp)
 {
 	struct rb_node **p = &bdi_tree.rb_node;
-- 
2.25.1


