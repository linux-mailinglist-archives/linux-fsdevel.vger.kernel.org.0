Return-Path: <linux-fsdevel+bounces-64118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E03BD9481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B4EF50071E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11E3126AC;
	Tue, 14 Oct 2025 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VWzGZvfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F5312819
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443878; cv=none; b=DRYo/aznCv/vuZSnWFAaoA5rg9CHsPsMSWTL12oatkwoi9QWvX41cgmObOp+p55y2AXZmdENjBsBeu3rul/sZeqMe5JE8d/eq9E6pxb+QBR/n66hf+GP+xvSgr09qo5Udgb38zEDq7os/kNHHU6/NrjZmPdUbE+v+OstsS77xfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443878; c=relaxed/simple;
	bh=zA89fVUoELPBJXQjoI+yLiAmmWb8MSEhVq5gZN+1ieA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=lQVigPn0+2HmAQW39qTfqIxRlnz660u18WRH+1cpvcEVzAM9PtJDJKzNhc5wtnOW/knYxkY9D+MYT2ksWFfWABq7RyWwS/JW1BzfWitIUJK7hMvcWnyg+MiTl/lL+lbjhXtBjDFs5/ghI1etJsN/yFfcZA9iPP4CSi681R1OCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VWzGZvfi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251014121104epoutp0236d95eb7bad4380898d3af59c5246731~uWl4qb6LT2425824258epoutp02Q
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251014121104epoutp0236d95eb7bad4380898d3af59c5246731~uWl4qb6LT2425824258epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443864;
	bh=9L9Dd+P57Nr9ie5r9Dy2BGUr0ErT9/3lAp5Du2+fgsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWzGZvfiHiU5Yz8K8MUBF/sznhrM9+sNgjg53fdyEgQwvRJICwiS7dfGfPgYSvCSE
	 Tymm6YJMjuSzD80p3C5TV0qzpTpD3b/5G+fop71hg8uZbZo2J6z2RBVvyYgoY6Eq7V
	 8qbcsIs6NS+JZaKd8csOvwhgE2lkkHX724BTgY2o=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251014121104epcas5p2bc15fe91af3f477ce59f23de07a762e7~uWl4GCzCQ2441424414epcas5p2z;
	Tue, 14 Oct 2025 12:11:04 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cmCjg1c1Qz3hhT7; Tue, 14 Oct
	2025 12:11:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251014121102epcas5p3280cd3e6bf16a2fb6a7fe483751f07a7~uWl2mt8mp0753907539epcas5p3l;
	Tue, 14 Oct 2025 12:11:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121056epsmtip121363f1d7a311e444423e431a609c5f4~uWlxNY78_1239712397epsmtip1d;
	Tue, 14 Oct 2025 12:10:56 +0000 (GMT)
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
Subject: [PATCH v2 09/16] f2fs: add support in f2fs to handle multiple
 writeback contexts
Date: Tue, 14 Oct 2025 17:38:38 +0530
Message-Id: <20251014120845.2361-10-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121102epcas5p3280cd3e6bf16a2fb6a7fe483751f07a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121102epcas5p3280cd3e6bf16a2fb6a7fe483751f07a7
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121102epcas5p3280cd3e6bf16a2fb6a7fe483751f07a7@epcas5p3.samsung.com>

Add support to handle multiple writeback contexts and check for
dirty_exceeded across all the writeback contexts.

Made a new helper for same.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/f2fs/node.c              |  4 ++--
 fs/f2fs/segment.h           |  2 +-
 include/linux/backing-dev.h | 18 +++++++++++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1693da9417f9..cd75aa98a1ca 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -73,7 +73,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		if (excess_cached_nats(sbi))
 			res = false;
 	} else if (type == DIRTY_DENTS) {
-		if (sbi->sb->s_bdi->wb_ctx[0]->wb.dirty_exceeded)
+		if (bdi_wb_dirty_limit_exceeded(sbi->sb->s_bdi))
 			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
@@ -114,7 +114,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = false;
 #endif
 	} else {
-		if (!sbi->sb->s_bdi->wb_ctx[0]->wb.dirty_exceeded)
+		if (!bdi_wb_dirty_limit_exceeded(sbi->sb->s_bdi))
 			return true;
 	}
 	return res;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7e5b7b1a5d2b..8487bd5d4394 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -993,7 +993,7 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->sb->s_bdi->wb_ctx[0]->wb.dirty_exceeded)
+	if (bdi_wb_dirty_limit_exceeded(sbi->sb->s_bdi))
 		return 0;
 
 	if (type == DATA)
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 59bbb69d300c..bb35f8fa4973 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -51,6 +51,21 @@ static inline bool wb_has_dirty_io(struct bdi_writeback *wb)
 	return test_bit(WB_has_dirty_io, &wb->state);
 }
 
+#define for_each_bdi_wb_ctx(bdi, wbctx) \
+	for (int __i = 0; __i < (bdi)->nr_wb_ctx \
+		&& ((wbctx) = (bdi)->wb_ctx[__i]) != NULL; __i++)
+
+static inline bool bdi_wb_dirty_limit_exceeded(struct backing_dev_info *bdi)
+{
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
+	for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+		if (bdi_wb_ctx->wb.dirty_exceeded)
+			return true;
+	}
+	return false;
+}
+
 static inline bool bdi_has_dirty_io(struct backing_dev_info *bdi)
 {
 	/*
@@ -149,9 +164,6 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
 }
 
 #define DEFAULT_WB_CTX 0
-#define for_each_bdi_wb_ctx(bdi, wbctx) \
-	for (int __i = 0; __i < (bdi)->nr_wb_ctx \
-		&& ((wbctx) = (bdi)->wb_ctx[__i]) != NULL; __i++)
 
 static inline struct bdi_writeback_ctx *
 fetch_bdi_writeback_ctx(struct inode *inode)
-- 
2.25.1


