Return-Path: <linux-fsdevel+bounces-64119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7574BD9485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F441500847
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B22C0F79;
	Tue, 14 Oct 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KXVPMq6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8936310783
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443878; cv=none; b=DHctv/ZjnFIJRsQR4TBnOBE9qM26bWMnL+RsrEf8gn1sDLUdumF7fDHV0dSpCvfK+/RTuKEfMfKE90xUll/dH0WG1mWLNivb9V/R/oilVIlSpQrtHffGmpB6YsYQO5MvlpYcUnSCeu5KW/SVmqVbdzI84N8OTmMOMG8p6XqvAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443878; c=relaxed/simple;
	bh=bpZkfr4SnXVSOLxQDPBa9KgBnuoAWvwoPHhqI97UVzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bi6u7JXiweNT7ljaXjucVLURxMgzpApzhgkbvCJmHRMGEHJ0YmCfa5JzVw7jzvmNaVFarixdPiWLJDhaUgETGqf3W5XLEJFdJ26yOcWi9wIx7ZjgwNHVqSB9pq/1MBnPDO93rVU6ZIWWSq1/KYWJzO/t1kyZ7CQD3vAs8Dln9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KXVPMq6j; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251014121110epoutp0199973b20f63ed51381a0ad897c37f1ef~uWl9wT9io1141711417epoutp01X
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251014121110epoutp0199973b20f63ed51381a0ad897c37f1ef~uWl9wT9io1141711417epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443870;
	bh=C/LvlMlwmoGn4EEu6fl0YJvh1Z+uAYGGiSNYbvlUAoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXVPMq6jumEvwP9xqK7fm9mUMAbJiNK54aw0VeA0ye1OrdsNFmudi3+eNXjyAN9eg
	 knmPQEJ8BSMV8cbjaas8eY15dU0ZsO3N1/+Zw7B2LCsMCXMK1LOOJ0Raw+uq5Vh7fJ
	 Q9NCarmAfG2p6B70i8TY7JBDYb8+k/W2PwHFLh2c=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251014121109epcas5p1450a20b2fb1624046b50ace88f3a111f~uWl8-9sfY3122231222epcas5p1L;
	Tue, 14 Oct 2025 12:11:09 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cmCjm3nKMz6B9m6; Tue, 14 Oct
	2025 12:11:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121108epcas5p1d68e41bdb1d51ae137b9bb22a7d16fd1~uWl7o_jJZ1447514475epcas5p1s;
	Tue, 14 Oct 2025 12:11:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121102epsmtip1b866f23363f52d9d5531fb176e70bee4~uWl27p7SL1256112561epsmtip1F;
	Tue, 14 Oct 2025 12:11:02 +0000 (GMT)
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
Subject: [PATCH v2 10/16] fuse: add support for multiple writeback contexts
 in fuse
Date: Tue, 14 Oct 2025 17:38:39 +0530
Message-Id: <20251014120845.2361-11-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121108epcas5p1d68e41bdb1d51ae137b9bb22a7d16fd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121108epcas5p1d68e41bdb1d51ae137b9bb22a7d16fd1
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121108epcas5p1d68e41bdb1d51ae137b9bb22a7d16fd1@epcas5p1.samsung.com>

Made a helper to fetch writeback context to which an inode is affined.
Use it to perform writeback related operations.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fuse/file.c              |  7 +++----
 include/linux/backing-dev.h | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8c823a661139..9c7f0e4b741f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1823,7 +1823,6 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
 	for (i = 0; i < ap->num_folios; i++) {
@@ -1833,8 +1832,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * contention and noticeably improves performance.
 		 */
 		iomap_finish_folio_write(inode, ap->folios[i], 1);
-		dec_wb_stat(&bdi->wb_ctx[0]->wb, WB_WRITEBACK);
-		wb_writeout_inc(&bdi->wb_ctx[0]->wb);
+		bdi_wb_stat_mod(inode, -1);
+		bdi_wb_writeout_inc(inode);
 	}
 
 	wake_up(&fi->page_waitq);
@@ -2017,7 +2016,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->descs[folio_index].offset = offset;
 	ap->descs[folio_index].length = len;
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb_ctx[0]->wb, WB_WRITEBACK);
+	bdi_wb_stat_mod(inode, 1);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index bb35f8fa4973..fb042e593c16 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -46,6 +46,9 @@ extern struct list_head bdi_list;
 
 extern struct workqueue_struct *bdi_wq;
 
+static inline struct bdi_writeback_ctx *
+fetch_bdi_writeback_ctx(struct inode *inode);
+
 static inline bool wb_has_dirty_io(struct bdi_writeback *wb)
 {
 	return test_bit(WB_has_dirty_io, &wb->state);
@@ -103,6 +106,20 @@ static inline s64 wb_stat_sum(struct bdi_writeback *wb, enum wb_stat_item item)
 
 extern void wb_writeout_inc(struct bdi_writeback *wb);
 
+static inline void bdi_wb_stat_mod(struct inode *inode, s64 amount)
+{
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
+
+	wb_stat_mod(&bdi_wb_ctx->wb, WB_WRITEBACK, amount);
+}
+
+static inline void bdi_wb_writeout_inc(struct inode *inode)
+{
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
+
+	wb_writeout_inc(&bdi_wb_ctx->wb);
+}
+
 /*
  * maximal error of a stat counter.
  */
-- 
2.25.1


