Return-Path: <linux-fsdevel+bounces-64112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48CFBD941E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF77B3A796A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBD2DCBFB;
	Tue, 14 Oct 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ThcGvJtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326631282E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443837; cv=none; b=e3ekmBqmsxUP8p6QsNZ6YPZV4taM7aSkJptHg2Z+pnnIhMdgwQqFOIBHfdoup/0FIcd0bUS6b5iGpbhGjn0W7XhWrET9B1OlKxXTloo7R+tPET6+4ZYEx/rSpu8xMJ+oqVORjpepj1GYKO5EPZ4CRN48dYRzzvnwsf0pYNq9v8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443837; c=relaxed/simple;
	bh=4ORzJnEQGYKZ9ZxMzHBMT5zCM8yCtm2WkXJN2Nefab8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=FV+dYoyCMCXMy0wNqpozQ4xzcnVyylGAdTHlG3piTTkYArfb4eG27aFoTqovbXXq0MjpwcxDVEnvYubVfX1zB/pbU9myZIqkAhk+ebnanwF6VByTFIe81udR2jVxfaGEE7L7P+nqC3EaY0qhC+GqxL0tWCnd8m/M7at0nzNvWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ThcGvJtD; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251014121028epoutp04aa32c2fb78af5efbd2b29980d0f33339~uWlW8aHtr0942109421epoutp04C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251014121028epoutp04aa32c2fb78af5efbd2b29980d0f33339~uWlW8aHtr0942109421epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443828;
	bh=7Fpri/DmmIz0lhNfmDYWM4M9dqrldIQivF7NvztYdbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThcGvJtDjMZOIP5h5Rwuk+Tgmz1tWjYMn1kCPySidm5U6ktLxw/wJlnGFhn2OKj5q
	 T5/A2RWR+c5cI7n2Uq954TnJU6r3k5/eX3HkXfraM4fdC59SCj3Cqr1Vqgf/KUrjnq
	 jsUwUrc9gm7BZvfZ4zO8CA3lHIscLOzTXdt3kHPg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251014121027epcas5p2be9b795d75fcf8516e4e7d26e5044fca~uWlWT01iz1631916319epcas5p2m;
	Tue, 14 Oct 2025 12:10:27 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cmChy70jsz6B9m6; Tue, 14 Oct
	2025 12:10:26 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121026epcas5p1aecefead887a6b4b6745cca0519d1092~uWlU6QPmR0760907609epcas5p18;
	Tue, 14 Oct 2025 12:10:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121021epsmtip1a54fa06a954b7223466d190130d994e5~uWlP9AoTA1188911889epsmtip1i;
	Tue, 14 Oct 2025 12:10:20 +0000 (GMT)
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
Subject: [PATCH v2 03/16] writeback: link bdi_writeback to its corresponding
 bdi_writeback_ctx
Date: Tue, 14 Oct 2025 17:38:32 +0530
Message-Id: <20251014120845.2361-4-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121026epcas5p1aecefead887a6b4b6745cca0519d1092
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121026epcas5p1aecefead887a6b4b6745cca0519d1092
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121026epcas5p1aecefead887a6b4b6745cca0519d1092@epcas5p1.samsung.com>

Introduce a bdi_writeback_ctx field in bdi_writeback. This helps in
fetching the writeback context from the bdi_writeback.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 mm/backing-dev.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 47196d326e16..754f2f6c6d7c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -513,15 +513,16 @@ static void wb_update_bandwidth_workfn(struct work_struct *work)
  */
 #define INIT_BW		(100 << (20 - PAGE_SHIFT))
 
-static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
-		   gfp_t gfp)
+static int wb_init(struct bdi_writeback *wb,
+		   struct bdi_writeback_ctx *bdi_wb_ctx,
+		   struct backing_dev_info *bdi, gfp_t gfp)
 {
 	int err;
 
 	memset(wb, 0, sizeof(*wb));
 
 	wb->bdi = bdi;
-	wb->bdi_wb_ctx = bdi->wb_ctx[0];
+	wb->bdi_wb_ctx = bdi_wb_ctx;
 	wb->last_old_flush = jiffies;
 	INIT_LIST_HEAD(&wb->b_dirty);
 	INIT_LIST_HEAD(&wb->b_io);
@@ -698,7 +699,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
 		goto out_put;
 	}
 
-	ret = wb_init(wb, bdi, gfp);
+	ret = wb_init(wb, bdi_wb_ctx, bdi, gfp);
 	if (ret)
 		goto err_free;
 
@@ -843,7 +844,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 		mutex_init(&bdi->cgwb_release_mutex);
 		init_rwsem(&bdi_wb_ctx->wb_switch_rwsem);
 
-		ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+		ret = wb_init(&bdi_wb_ctx->wb, bdi_wb_ctx, bdi, GFP_KERNEL);
 		if (!ret) {
 			bdi_wb_ctx->wb.memcg_css = &root_mem_cgroup->css;
 			bdi_wb_ctx->wb.blkcg_css = blkcg_root_css;
@@ -1000,7 +1001,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
 		int ret;
 
-		ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+		ret = wb_init(&bdi_wb_ctx->wb, bdi_wb_ctx, bdi, GFP_KERNEL);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1


