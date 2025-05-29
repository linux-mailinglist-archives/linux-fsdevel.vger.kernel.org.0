Return-Path: <linux-fsdevel+bounces-50060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D70AC7D39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F203A7163
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC3628F92F;
	Thu, 29 May 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="imU6mn/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE02918C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518452; cv=none; b=ULkXus4z8P8ZOFuQ3UZyveAdc1YHZqQOZ1bSrfMR5Cyn+us2BrRFUzpKmBczNtgXmcKEx2NTreYYZC/6HDDBKwruWzAGpShcChTECfpUqy7QJyWxZkkJQtWhdnnUKI4ukUJ4odUn5IhKJcT3AES7vPMRfMK6urQEmgd2w/etBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518452; c=relaxed/simple;
	bh=FrhXkryOLHJOOtakTzIIYTUlJJpByCS9vQ2QNxeX1MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=D2Y0JLyVoRVT/z8gntTPTiDWRZM24VxcZg+OJJzuF6QswrN8l1TjhHshKBbUF5nfEKvGrAoLkKKMg9SwnY77rxIF1PPkQJT+VVXc903yvpSEgHufIhceya6ZXJrntTeLp4P+wr0gCa8HEBsfKv1EXP9tG40RXCKBDQT4MnbofyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=imU6mn/7; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250529113408epoutp04abc56e0befd98096e3835b425bc53fa7~D-EPc9VGF2392223922epoutp04T
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250529113408epoutp04abc56e0befd98096e3835b425bc53fa7~D-EPc9VGF2392223922epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518448;
	bh=j0rSaiu/19cklqVxMZoAPnGW+CTIG7+XEZhZoJwBJiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imU6mn/70NPAXcgeXrkHnrSRN64XiVb2a2W6DMrVLWVcC9GkTKMOUppRGROmrOPer
	 52w6hMawLcw5AJgGU/49O8a+mb2SWLmDErqLyYbayV6CorEEULZDHfpiOoXFUbWKHp
	 NrXYV7Ra8vYv7Ss1fnPzQQhSOlyKMGZGRqr7dTuE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250529113407epcas5p47134835272260570599fa753058ae38c~D-EOt0Rm31596415964epcas5p4l;
	Thu, 29 May 2025 11:34:07 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.176]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b7PQk4gVHz3hhT4; Thu, 29 May
	2025 11:34:06 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529113253epcas5p1a28e77b2d9824d55f594ccb053725ece~D-DJoDX8B1317213172epcas5p1A;
	Thu, 29 May 2025 11:32:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113253epsmtrp2c84b79adce7e56020924868a08572e1b~D-DJmmPPi3187631876epsmtrp2d;
	Thu, 29 May 2025 11:32:53 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-4f-683845e5ce8f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.41.07818.5E548386; Thu, 29 May 2025 20:32:53 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113249epsmtip26a05e8089b2459b3caaa902a18f09a59~D-DFvdMM22452224522epsmtip2Q;
	Thu, 29 May 2025 11:32:49 +0000 (GMT)
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
Subject: [PATCH 09/13] f2fs: add support in f2fs to handle multiple
 writeback contexts
Date: Thu, 29 May 2025 16:45:00 +0530
Message-Id: <20250529111504.89912-10-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiG955zes6hGeZYXHxhAknnzNIIpZG5dwH5iDO+MdOoiQ43HTZ4
	KA20di0obCZWkIXVr+oohQIZNGDkQ4gVcHhwAYQhlA8pEC1a9kNQonEGqsNYKQrNEv9dua/7
	eZ4/D0tKnlJhrFqbzeu1yiwpLababksjo2a2oYyYjpvrUVuTwKCK5kYa3W1qAKiwfYlC+eZF
	EjV4LtDo2e15gJyWIQK1uBLRi7E2AjW4GwFq+XsKoLHpVUiw+kXI3dlOoLqGXgKVWwsINN1s
	I1Hry1ci5LJvRx23+ik01bgkQnc7nSJ03zwD0GPhGom8tacZ1DVQxKD5yvdLRhb7RMj3uoJO
	isADdojbbR4GX78iw2NDOdhR/xuNHfOXGHyn1Efh2etlAAtVXgILbiONh0dz8Yu/Jmh8vqUe
	YEv5STxY1cPgKyWjxG7J9+L4I3yW+hivlyccFme0ucqBrnR1bquxjjKCS6tMIIiFXCwUBhyk
	CYhZCScAWDrZSQTEOih42kUBDoF1/idMoDQHYEX3LGUCLEtzUfB1/r7lfA3nJuHw0ODKAMn5
	ARSeblzmEG4/vDxRSS4zxX0Oz/R4VziYS4Cnay4wgQORsMy1sMJB73N7zSuwzBJuC6x1X6UC
	/dWwv2yaCuyPhAWt5aQZcLYPlO0DVQWIehDK6wwalSZNoVNo+ePRBqXGkKNVRacd1TjAyjvI
	vvgT/PtfvrwbECzoBpAlpWuC8xM3Z0iCjyjzfub1R1P1OVm8oRt8ylLStcF1ihSVhFMps/lM
	ntfx+v8twQaFGQm1pmb36LW4r9KjFsd/iC6KudOz3pamTkiQVM9q1Tdt6Ydj5cWc75/Lfk/h
	1IbWmZHzHZNeMbnL9PBAZkV4HqB0IaYHtUnh3vFkPEJlvkm37lXtvHHu42RBKnKmHEipfnaj
	xB033PXL3iffnoKWe3KZtTfso1P0j6mqHY8K/fZRJ7713Jzr1+wkZI9y/ayz+mpXh+Wz7IuK
	4rmlrcICcXDjd/EYpk6+/P3EoYiY+8LgMBcZW22XJxerS6yetLW6PU2xxRcdzSN5v246u3XP
	W3N8XukmtW+LK+JhpU489uUfA/449YPQhUzn3ONQpugTo9nly9r/Tf8xS5/up6/dRVLKkKFU
	yEi9QfkOq42ST30DAAA=
X-CMS-MailID: 20250529113253epcas5p1a28e77b2d9824d55f594ccb053725ece
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113253epcas5p1a28e77b2d9824d55f594ccb053725ece
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113253epcas5p1a28e77b2d9824d55f594ccb053725ece@epcas5p1.samsung.com>

Add support to handle multiple writeback contexts and check for
dirty_exceeded across all the writeback contexts.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/f2fs/node.c    | 11 +++++++----
 fs/f2fs/segment.h |  7 +++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4b6568cd5bef..19f208d6c6d3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -50,6 +50,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 	unsigned long avail_ram;
 	unsigned long mem_size = 0;
 	bool res = false;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	if (!nm_i)
 		return true;
@@ -73,8 +74,9 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		if (excess_cached_nats(sbi))
 			res = false;
 	} else if (type == DIRTY_DENTS) {
-		if (sbi->sb->s_bdi->wb_ctx_arr[0]->wb.dirty_exceeded)
-			return false;
+		for_each_bdi_wb_ctx(sbi->sb->s_bdi, bdi_wb_ctx)
+			if (bdi_wb_ctx->wb.dirty_exceeded)
+				return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else if (type == INO_ENTRIES) {
@@ -114,8 +116,9 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = false;
 #endif
 	} else {
-		if (!sbi->sb->s_bdi->wb_ctx_arr[0]->wb.dirty_exceeded)
-			return true;
+		for_each_bdi_wb_ctx(sbi->sb->s_bdi, bdi_wb_ctx)
+			if (bdi_wb_ctx->wb.dirty_exceeded)
+				return false;
 	}
 	return res;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index a525ccd4cfc8..2eea08549d73 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -936,8 +936,11 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->sb->s_bdi->wb_ctx_arr[0]->wb.dirty_exceeded)
-		return 0;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
+	for_each_bdi_wb_ctx(sbi->sb->s_bdi, bdi_wb_ctx)
+		if (bdi_wb_ctx->wb.dirty_exceeded)
+			return 0;
 
 	if (type == DATA)
 		return BLKS_PER_SEG(sbi);
-- 
2.25.1


