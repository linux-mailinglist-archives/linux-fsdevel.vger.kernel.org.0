Return-Path: <linux-fsdevel+bounces-50063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76EFAC7D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DBA3ADA82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4828F957;
	Thu, 29 May 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a2n8UTrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3728F538
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518459; cv=none; b=VtSoCJdxsnpYZ7DL7lTQj/Vq5HT7bl1fKsDFEMEPrLgoWtA36jIG59LZ9cuzyjHVC1vTedIK/ba8y2G6YZ2HR2rP2KeugJz2/aZugNJJ24AzpH8bXPqlVeaxlI0C9jnf0pBpfNXfMpe24blY/z1hwMlmiNzg5Foeow2tVp0VIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518459; c=relaxed/simple;
	bh=dfaTiw8nLDRjFxCFnO02BCVy3d+c+Vl05L0PLyr4qcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kU2v60bF5xeMLZD7xpYkuwrs8gC+MolthOtI1OFYG2mTIRhvB6tAqvb36EYEp9AB9x40i+UYYME7D2yasZ8x4M8WNgLWR//66+5J8Brlx9USofYvul1zC7W0eNyia7yslJRJQ12YFuavIEs1IXz/Vmq9eUwpJJWKmf7wLBC2aHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a2n8UTrO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250529113416epoutp022a41a882f6efeaaeebe8dfa41e0c12a3~D-EWQcaTz2407724077epoutp02U
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250529113416epoutp022a41a882f6efeaaeebe8dfa41e0c12a3~D-EWQcaTz2407724077epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518456;
	bh=cE4aGrMWfdfKbV5mbcWv7IOIJ9zK97xR7MCGDQSOGKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2n8UTrOM8mPmjG1GkMf88KfKidjyEHvKIwzrMlx/hgazwXWF/RQruVtbORT+aKhP
	 uo4kUlfRMf3JRNFX4TLvxRcDSM+/boX9VMF1IEjCb3f7dZOFrynqPvneCM0bQb5DwX
	 Q4vuckXTuFOWlWIHlUGObdxUZKjUZV4KFoF37dso=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250529113415epcas5p13c210c73fcbcff52dcc7bb93f4f01f1b~D-EVoaqUQ0281002810epcas5p1n;
	Thu, 29 May 2025 11:34:15 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.176]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b7PQs6NQsz3hhT4; Thu, 29 May
	2025 11:34:13 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250529113306epcas5p3d10606ae4ea7c3491e93bde9ae408c9f~D-DVj9Ciy0439204392epcas5p3B;
	Thu, 29 May 2025 11:33:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113306epsmtrp271b91974fef11311e14c484c1a067438~D-DVZrJFM3201832018epsmtrp2_;
	Thu, 29 May 2025 11:33:06 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-ae-683845f23ae6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.F0.08766.2F548386; Thu, 29 May 2025 20:33:06 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113302epsmtip2ad463f8678ba29c64da9a5eb397e2892~D-DRiEkXT2424224242epsmtip2B;
	Thu, 29 May 2025 11:33:02 +0000 (GMT)
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
Subject: [PATCH 12/13] nfs: add support in nfs to handle multiple writeback
 contexts
Date: Thu, 29 May 2025 16:45:03 +0530
Message-Id: <20250529111504.89912-13-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCSvO4nV4sMg7b1whbb1u1mt5izfg2b
	xYV1qxktWnf+Z7FomvCX2WL13X42i9eHPzFanJ56lsliyyV7i/eXtzFZrL65htFiy7F7jBaX
	n/BZ7J7+j9Xi5oGdTBYrVx9lspg9vZnJ4sn6WcwWW798ZbW4tMjdYs/ekywW99b8Z7W4cOA0
	q8WNCU8ZLZ7t3shs8XlpC7vFwVMd7Baf5gINOf/3OKvF7x9z2BzkPE4tkvDYOesuu8fmFVoe
	l8+Wemxa1cnmsenTJHaPEzN+s3i82DyT0WP3gs9MHrtvNrB5nLtY4fF+31U2j74tqxg9ps6u
	9ziz4Ai7x4ppF5kChKK4bFJSczLLUov07RK4MrYdfcBc8IS34sRS3gbGldxdjJwcEgImEgt+
	zGfqYuTiEBLYzShxc+FuRoiEjMTuuztZIWxhiZX/nrNDFH1klJh9+wdzFyMHB5uArsSPplCQ
	uIjATWaJc2fPgDUwC/xjlNj9SgfEFhYIkTj9fxkbiM0ioCqx5FUDmM0rYCexafIFqGXyEjMv
	fWcHsTmB4ouWfAWLCwnYSiy9uZYFol5Q4uTMJywQ8+UlmrfOZp7AKDALSWoWktQCRqZVjJKp
	BcW56bnFhgWGeanlesWJucWleel6yfm5mxjBqUFLcwfj9lUf9A4xMnEwHmKU4GBWEuFtsjfL
	EOJNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cAU633n10k1
	d2v/ThdDY8P5q4xkpB0yZ4idC1tVcftNR67buyu3WPe5RzNtWH2tvmW1jP/cy7fellk7b/zm
	N/PiFW2WLV/d/jVWRe4rFSwrvVsSF6MT/tpXL1qAKXT36vS0SR/Sph6U1Q9aaBNepmItNj9w
	6e1Dx9Prvadc7fhve3ZZWWnT1o8BO17x7O/elK9vFn3z2rXtPI27ew3m+1dt/JJjdkezcc+K
	V3dLdiXe3PnJe4GK6bHOvHsTw82TSrzf9ajsyw1l/NUr8UMq6OvUNPmYKWqqe5luNOxVXCIg
	tJTpRvyN0xztR2w07daISReu/a90uuxXSdWltcdV7aSWn5ybzObi/t72y8071RuUWIozEg21
	mIuKEwHp2L7efAMAAA==
X-CMS-MailID: 20250529113306epcas5p3d10606ae4ea7c3491e93bde9ae408c9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113306epcas5p3d10606ae4ea7c3491e93bde9ae408c9f
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113306epcas5p3d10606ae4ea7c3491e93bde9ae408c9f@epcas5p3.samsung.com>

Fetch writeback context to which an inode is affined. Use it to perform
writeback related operations.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/nfs/internal.h | 5 +++--
 fs/nfs/write.c    | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fd513bf9e875..a7cacaf484c9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -838,14 +838,15 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 {
 	if (folio && !cinfo->dreq) {
 		struct inode *inode = folio->mapping->host;
+		struct bdi_writeback_ctx *bdi_wb_ctx =
+						fetch_bdi_writeback_ctx(inode);
 		long nr = folio_nr_pages(folio);
 
 		/* This page is really still in write-back - just that the
 		 * writeback is happening on the server now.
 		 */
 		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
-		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx_arr[0]->wb,
-			    WB_WRITEBACK, nr);
+		wb_stat_mod(&bdi_wb_ctx->wb, WB_WRITEBACK, nr);
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	}
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ec48ec8c2db8..ca0823debce7 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -932,11 +932,11 @@ static void nfs_folio_clear_commit(struct folio *folio)
 {
 	if (folio) {
 		long nr = folio_nr_pages(folio);
-		struct inode *inode = folio->mapping->host;
+		struct bdi_writeback_ctx *bdi_wb_ctx =
+				fetch_bdi_writeback_ctx(folio->mapping->host);
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx_arr[0]->wb,
-			    WB_WRITEBACK, -nr);
+		wb_stat_mod(&bdi_wb_ctx->wb, WB_WRITEBACK, -nr);
 	}
 }
 
-- 
2.25.1


