Return-Path: <linux-fsdevel+bounces-64115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F382BD9451
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D16404FF92C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0B3128A0;
	Tue, 14 Oct 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B0TNqDFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD86274B48
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443856; cv=none; b=QkKYrEey7RjY2hA6VDi1HGYbsV/hj9j3hIFHFymOexrNcqOc7+eQIRn1wKNmAZ2+KjhqIQZFOdIpzbX+bYsCdt5EfJXmIH/ntBCH9+s+Nv1kdu8d9mXGihApYjNo975Wh+X6As7lXVqf3jAu3s8ECJ8Z2VCcHnilN01eKax1Zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443856; c=relaxed/simple;
	bh=wWwu+8uoJ6DhpcazV4fI/GxlhLwa1nE+0p8LTPlcgec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=E498mYS0X2n5ey7HOLfIEwm4TTQODu0PJFYb49m0G9GgwV77YkDM8JPa80wxTM4JGdAfuPBLZ3BqB/GvCQ3CXH76PxHOjNV8+E0xYrDIuj+fXNK/ZRzLEBRazNvQTDqxnN7YfdJ8dDeUdiCktZK4u208hFPnhMXi10eSo+Q/fJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B0TNqDFo; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251014121044epoutp041fb92a5525d1e086a4dd19e93aaa6c9f~uWll5coj31210712107epoutp04H
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251014121044epoutp041fb92a5525d1e086a4dd19e93aaa6c9f~uWll5coj31210712107epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443844;
	bh=dioO0YDP7mzhZqCWconGW6ike9OX4ckBo46ONrqcrR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0TNqDFoyqdsRahkcmFej3wpmKZnuHdX78pZTjij1NDXzZRcoesm5o+KDGOZcvjnw
	 1PpV/Vt3iRjOFLDSMJUARarfYJK/q/4FDpMIWV1kDbLWEfBMzrQgdIu9IfuoWgo8Io
	 YXUfAsH8n69hTOFMEGQu19qQlRYtQqe4NpgWbk1k=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251014121044epcas5p2f380d81531fc3d4fad2cbcf760ac1c1f~uWllTAZGM1888018880epcas5p2q;
	Tue, 14 Oct 2025 12:10:44 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cmCjH05ybz2SSKY; Tue, 14 Oct
	2025 12:10:43 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121042epcas5p16a955879f8aaca4d0a4fd50bc5344f55~uWljkHFol1447514475epcas5p1o;
	Tue, 14 Oct 2025 12:10:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121037epsmtip1cb43407e8777ba7eb89d4bf5e248dc43~uWle9F8wv1239712397epsmtip1O;
	Tue, 14 Oct 2025 12:10:37 +0000 (GMT)
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
Subject: [PATCH v2 06/16] writeback: invoke all writeback contexts for
 flusher and dirtytime writeback
Date: Tue, 14 Oct 2025 17:38:35 +0530
Message-Id: <20251014120845.2361-7-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121042epcas5p16a955879f8aaca4d0a4fd50bc5344f55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121042epcas5p16a955879f8aaca4d0a4fd50bc5344f55
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121042epcas5p16a955879f8aaca4d0a4fd50bc5344f55@epcas5p1.samsung.com>

Modify flusher and dirtytime logic to iterate through all the writeback
contexts.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 93f8ea340247..432f392c8256 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2389,12 +2389,14 @@ static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 					 enum wb_reason reason)
 {
 	struct bdi_writeback *wb;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	if (!bdi_has_dirty_io(bdi))
 		return;
 
-	list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list, bdi_node)
-		wb_start_writeback(wb, reason);
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx)
+		list_for_each_entry_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node)
+			wb_start_writeback(wb, reason);
 }
 
 void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
@@ -2444,15 +2446,17 @@ static DECLARE_DELAYED_WORK(dirtytime_work, wakeup_dirtytime_writeback);
 static void wakeup_dirtytime_writeback(struct work_struct *w)
 {
 	struct backing_dev_info *bdi;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list) {
 		struct bdi_writeback *wb;
 
-		list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list,
-					bdi_node)
-			if (!list_empty(&wb->b_dirty_time))
-				wb_wakeup(wb);
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx)
+			list_for_each_entry_rcu(wb, &bdi_wb_ctx->wb_list,
+						bdi_node)
+				if (!list_empty(&wb->b_dirty_time))
+					wb_wakeup(wb);
 	}
 	rcu_read_unlock();
 	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
-- 
2.25.1


