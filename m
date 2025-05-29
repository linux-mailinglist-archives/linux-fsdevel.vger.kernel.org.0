Return-Path: <linux-fsdevel+bounces-50057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A81AC7D33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131B64E64C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A365C28F51C;
	Thu, 29 May 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LdAMmPTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DA28ECE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518445; cv=none; b=tel7qNYC7QhKWQmMGineFdlBVvzrMgNUCV5ncXYRHoEUcsbJCJ6OvUnejj3s2FpQl/bnTK1/smNILWaPGmDo/6ZELq+N1RG06i7WNLY9GcWlObJ60mglkpqNc6PZSBHzK6QC2Eql+E2tn/CyypNK+Hy+hYbOehWrkcNkkSu+cuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518445; c=relaxed/simple;
	bh=wvu7TOe18s2zQIbl42QmuTciTId2SfoCg0/MSDFkhqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=T+PCEuaBArxXPoSVScZX7p/95+jN4l2YqAxY1ylUe8B528P2f9P9Vi+usdzYU0caEjBxQQ6m9T9P9Ljc4zfRjYQR59aUVbLgl93AIupHAs6USqqHFlTOvz9jUiND8S3yiaYz7jD0ftv1MC0J/If11eUv4Ztu/tg/XE65qoPAKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LdAMmPTf; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250529113401epoutp022f09bb32916df3554c59d19c3b845b1e~D-EIxVQ322189921899epoutp02O
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250529113401epoutp022f09bb32916df3554c59d19c3b845b1e~D-EIxVQ322189921899epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518441;
	bh=gxeKWeWu/ySnXS2r9kcCICk1CnqlIWodIB1MsF0xVi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdAMmPTf7G967tZgBxoVcxP6UjI1IhyvI0wuuwABkl0ZGdU7y571LYC82/qUU0oNa
	 jDJfeLsrlsQYbMvK0L+QCOmKQACmepewzUawNV3T48aUujY00TcQ4M29hMPu0JwmMR
	 +eh5JZp+YHGPYTkdaqTtyLGmA7xoP2WHuD4bAmWw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250529113359epcas5p39d7be00f8a656169b79d0370175eb687~D-EHRkHiq0522305223epcas5p3y;
	Thu, 29 May 2025 11:33:59 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.183]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b7PQZ5GZdz6B9m4; Thu, 29 May
	2025 11:33:58 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113240epcas5p295dcf9a016cc28e5c3e88d698808f645~D-C9tkRkG0469904699epcas5p2M;
	Thu, 29 May 2025 11:32:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250529113240epsmtrp1c4d25ba0721f6abf94540d54df86d1fb~D-C9sQSMO2113121131epsmtrp1N;
	Thu, 29 May 2025 11:32:40 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-3d-683845d8bfdf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	12.E0.08766.8D548386; Thu, 29 May 2025 20:32:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113236epsmtip2de2be54bb55648b69293e1f774bef02e~D-C527gT_2208622086epsmtip2t;
	Thu, 29 May 2025 11:32:36 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 06/13] writeback: invoke all writeback contexts for flusher
 and dirtytime writeback
Date: Thu, 29 May 2025 16:44:57 +0530
Message-Id: <20250529111504.89912-7-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCSvO4NV4sMg4bjxhbb1u1mt5izfg2b
	xYV1qxktWnf+Z7FomvCX2WL13X42i9eHPzFanJ56lsliyyV7i/eXtzFZrL65htFiy7F7jBaX
	n/BZ7J7+j9Xi5oGdTBYrVx9lspg9vZnJ4sn6WcwWW798ZbW4tMjdYs/ekywW99b8Z7W4cOA0
	q8WNCU8ZLZ7t3shs8XlpC7vFwVMd7Baf5gINOf/3OKvF7x9z2BzkPE4tkvDYOesuu8fmFVoe
	l8+Wemxa1cnmsenTJHaPEzN+s3i82DyT0WP3gs9MHrtvNrB5nLtY4fF+31U2j74tqxg9ps6u
	9ziz4Ai7x4ppF5kChKK4bFJSczLLUov07RK4Mrb0nWMt+M9b8b6tg6mB8Rl3FyMnh4SAicSC
	KeeZuxi5OIQEdjNK3Ov5ywKRkJHYfXcnK4QtLLHy33N2iKKPjBJrX10E6uDgYBPQlfjRFAoS
	FxG4ySxx7uwZsAZmgX+MErtf6YDYwgLJEv0f3rCD2CwCqhKTd91nAunlFbCV+NwVADFfXmLm
	pe9gJZwCdhKLlnxlBLGFgEqW3lwLdg+vgKDEyZlPWCDGy0s0b53NPIFRYBaS1CwkqQWMTKsY
	JVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJTg5bmDsbtqz7oHWJk4mA8xCjBwawkwttk
	b5YhxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgelYwAlV
	ptQDmneKbn13DF4kmn9x6a2DRhMjp04smNV0LzDrpmojZ6NcyuzgnKKXdYIXxeXtslz7tXq6
	tlx1dH+4vKw2svE9x92TLc2WJ6UuMjXJbt8gLJLS6zXH1qlvjXTHnBtvRC6vjFWIsUr1+B3J
	pDGt5ZuuiNss2VQjR/6X3XcPLWWQkyqsDnjGfOzTpGO5wSHGvgfXPK8xlfp99Pshm4LSE8u3
	CZs7sH5PZ9A9fPDXZddJ0pOLc7YtPjM1JOCulenDmbmdH3j2Sa7SUs3+rN48depC/jn3vx4N
	rbsl8W/Ko3+C57eyWC4Xfl4/2eu71+aw88tEZdLbc3rCXt14wH4t3W2r7QkLpX0VNUosxRmJ
	hlrMRcWJAMl6RFl8AwAA
X-CMS-MailID: 20250529113240epcas5p295dcf9a016cc28e5c3e88d698808f645
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113240epcas5p295dcf9a016cc28e5c3e88d698808f645
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113240epcas5p295dcf9a016cc28e5c3e88d698808f645@epcas5p2.samsung.com>

Modify flusher and dirtytime logic to iterate through all the writeback
contexts.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fs-writeback.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 72b73c3353fe..9b0940a6fe78 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2389,12 +2389,14 @@ static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 					 enum wb_reason reason)
 {
 	struct bdi_writeback *wb;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	if (!bdi_has_dirty_io(bdi))
 		return;
 
-	list_for_each_entry_rcu(wb, &bdi->wb_ctx_arr[0]->wb_list, bdi_node)
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
 
-		list_for_each_entry_rcu(wb, &bdi->wb_ctx_arr[0]->wb_list,
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


