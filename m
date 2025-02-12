Return-Path: <linux-fsdevel+bounces-41583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312AEA3269B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C4C188C6D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830020E030;
	Wed, 12 Feb 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FIWedP/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5420B21F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365691; cv=none; b=Hfkyhcf87hOtr2F/iQF1VzPkGQ8b/sCe1Y9C13CjVcllv7x6cHWW61tGw4GNCbxtUQ9sJMydxR/XYHYAHPU3bqg06rWiMXeGjzCXpfUdv+A/0o7Rig1nv1yGz0SlpPDOsHPXnWXQJJbQzQ2mSsztaNq4IafKm/U8Jo+hkdFcbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365691; c=relaxed/simple;
	bh=suTYpc2mJVxEOVrvOP5KL2W08D1GEf9rat8rzTK6GT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=FTlvVXslGyv1ARXfFA1VmN33xnwL6exm0bYIUiGWu9C9ISyUMY7pvoSn9dx5AJeKn2H1Zxk4QDDkPY6gI/1IDd4zQE1HDNQgF+BslikRdzBuc5MD3ZK9d4Ms3p1h9JLimc2PJxfrKXqz1/lI7/a0I7O+TlNRrsckkJ3Q9NSL17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FIWedP/c; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250212130801epoutp04186869e7094758b365175611fa3d1244~jd98Wg7751748017480epoutp04H
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:08:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250212130801epoutp04186869e7094758b365175611fa3d1244~jd98Wg7751748017480epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739365681;
	bh=6Cl6Fnciyb5mkCmfqpo8glL2Yu+/3vo/FOV7HtDFILw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIWedP/cqL9uaRpLpkh+DaOvBPUw0O09K0LinX4gQk8enpTRms200QHbjsxftp+It
	 n+YTV3gAbdpWfVt3j/OkeQmk6qX8wpi0TqKZRFv0Tn8E7KiXIHhzGZuzSFoSQ0H+W4
	 XPkxHR0rt+xeGucxMpmjH6VQ6dIggkhCChBbLu08=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250212130800epcas5p4fab1a43db913989e95e1512e0bf5dfcb~jd975GI3A0055800558epcas5p4o;
	Wed, 12 Feb 2025 13:08:00 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YtJWz0xv5z4x9Pv; Wed, 12 Feb
	2025 13:07:59 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.8F.29212.E2D9CA76; Wed, 12 Feb 2025 22:07:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250212104510epcas5p25c2c77dfe9ba3922d61ba14acaf2ed80~jcBOC5RyX3015330153epcas5p25;
	Wed, 12 Feb 2025 10:45:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250212104510epsmtrp1beab7f99e83fa4f27ca27ee823846079~jcBN6lVvR0677306773epsmtrp1t;
	Wed, 12 Feb 2025 10:45:10 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-6e-67ac9d2e1752
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.8D.18729.5BB7CA76; Wed, 12 Feb 2025 19:45:09 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250212104507epsmtip2d58f1a032a3729ca5177de18f151f4c5~jcBLysmUZ1864418644epsmtip2D;
	Wed, 12 Feb 2025 10:45:07 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: david@fromorbit.com, mcgrof@kernel.org, jack@suse.cz, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	anuj20.g@samsung.com, axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com, vishak.g@samsung.com, amir73il@gmail.com,
	brauner@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [RFC 1/3] writeback: add parallel writeback infrastructure
Date: Wed, 12 Feb 2025 16:06:32 +0530
Message-Id: <20250212103634.448437-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212103634.448437-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmhq7+3DXpBrv3M1lcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLXX92sFvc
	mPCU0eL8rDnsFr9/zGFz4Pc4tUjCY+esu+wem1doeVw+W+qxaVUnm8fumw1sHucuVnj0bVnF
	6HFmwRF2j8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
	XHwCdN0yc4BeUFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevl
	pZZYGRoYGJkCFSZkZ3y49Z+x4KR2xbHtd5kaGP8pdzFyckgImEisOf6MtYuRi0NIYA+jxO83
	i9khnE+MEtdaLjJBON8YJR6f/swG07Js3xZmiMReRomVT9eyQTifGSW+TN4M5HBwsAnoSvxo
	CgVpEBFwkTi0vA9sB7NAJ5PE+607wCYJCzhLHF61ixXEZhFQlXh9YAOYzStgJzHp0hEmiG3y
	EjMvfWcHsTkF7CV2vJ3MDlEjKHFy5hMWEJsZqKZ562ywiyQEjnBI7NkHMUgCaHPH9K1QtrDE
	q+Nb2CFsKYmX/W1QdrbEocYNUMtKJHYeaYCK20u0nupnBnmGWUBTYv0ufYiwrMTUU+uYIPby
	SfT+fgLVyiuxYx6MrSYx591UFghbRmLhpRlQcQ+JRc8uQgNrEqPEpualjBMYFWYh+WcWkn9m
	IaxewMi8ilEqtaA4Nz012bTAUDcvtRwez8n5uZsYwQlbK2AH4+oNf/UOMTJxMB5ilOBgVhLh
	lZi2Jl2INyWxsiq1KD++qDQntfgQoykwxCcyS4km5wNzRl5JvKGJpYGJmZmZiaWxmaGSOG/z
	zpZ0IYH0xJLU7NTUgtQimD4mDk6pBqbtb4T4nrrym+jU6u+ee/FI8wvBJEeNl3zm6c11KX/n
	ycyJ+W0zz63WmP2URWPk1NOXAwTzVTYUfxW+EV3w686DyXLZZrfn6aYElPhmml++suV5FEci
	U7DN5u/Sx16FdbzzsjJeELyi+cUHEY3bU//MSgywS3Xz2p8sUCeio8pXXXXMOvFtho/qQ75Z
	b3LmNm59G3JBfvmcOz//LbRu+mn87Pm64LncBmtD2Vj5rbrmW0usDDzqIhnByeGRHG52aGbq
	TeW856uqGt5M7qgykTj7vorloTPPKn7zSxu+7JtQ+c7/notEIUtY96/VQd5dv6YdPLBp2maJ
	/eff5pXeq9BXfjVZ/cjvXf+8Jx//La7EUpyRaKjFXFScCAAFRbRtYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXndr9Zp0g7fbrC0urFvNaNE04S+z
	xeq7/WwWrw9/YrTYcsneYsuxe4wWNw/sZLJYufook8Xs6c1MFlu/fGW12LP3JIvFrj872C1u
	THjKaHF+1hx2i98/5rA58HucWiThsXPWXXaPzSu0PC6fLfXYtKqTzWP3zQY2j3MXKzz6tqxi
	9Diz4Ai7x+dNcgFcUVw2Kak5mWWpRfp2CVwZH279Zyw4qV1xbPtdpgbGf8pdjJwcEgImEsv2
	bWHuYuTiEBLYzSix/NpsJoiEjMTuuztZIWxhiZX/nrNDFH1klNh3ZBFLFyMHB5uArsSPplCQ
	GhEBL4mLmz6A1TALTGeSmLLlPDtIQljAWeLwql1gg1gEVCVeH9gAZvMK2ElMunQEapm8xMxL
	38HqOQXsJXa8nQxmCwHV/Hl3hx2iXlDi5MwnLCA2M1B989bZzBMYBWYhSc1CklrAyLSKUTK1
	oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4nrQ0dzBuX/VB7xAjEwfjIUYJDmYlEV6ThSvS
	hXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTAdOjxjruzz
	gle+1zKXb6m91rDVrezGb6nvHwqlBdN5T13armDl8PrNc+3SkjtfU/91bpzzLbChuTB41bkz
	O4JZZvw/5Rtw3LzcaccHzi4RU+Z2+cmbp3zpy4pqNfWdefyFrJCP3SLmT1ZvdPe/SljwMiTR
	Tkt05Qy77KKsZ+b3ooIf7r/ut5bJpHj+k5rqL3vOrZl/9+OjzD+TN7/34V12eY3SKr/J5S9O
	dZ4M2aFX92xHedfm5df/xHtf0tJpsZxSZeSq6u5+YROHlS37xXP1gl9X+82QWnfAufLO6qsB
	F+3MjyRFnpC+FhO2tVF7xf6av2xax9yKP0hqM/msXm/LzvDlzdpZy7Y9UtSpqGZ6rMRSnJFo
	qMVcVJwIAEpRfWcWAwAA
X-CMS-MailID: 20250212104510epcas5p25c2c77dfe9ba3922d61ba14acaf2ed80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250212104510epcas5p25c2c77dfe9ba3922d61ba14acaf2ed80
References: <20250212103634.448437-1-kundan.kumar@samsung.com>
	<CGME20250212104510epcas5p25c2c77dfe9ba3922d61ba14acaf2ed80@epcas5p2.samsung.com>

This patch introduces infrastructure for parallel writeback.

- Writeback context list and index:
  wb_ctx_list: An array that represents the NR_WB_CTX writeback
  contexts.
  wb_idx: An index in wb_ctx_list used to manage the assignment of
  writeback contexts to file-systems.

- Inode lists:
  Each writeback context has its own separate inode lists
  corresponding to b_*.

  b_dirty -> pctx_b_dirty
  b_io -> pctx_b_io
  b_dirty_time -> pctx_b_dirty_time
  b_more_io -> pctx_b_more_io

- Per-writeback context work:
  pctx_dwork to handle multiple worker threads for per-writeback
  context operations concurrently.

- Helper functions:
  A set of helper functions, ctx_b_*_list(), are introduced to
  retrieve the list associated with a specific writeback context.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/backing-dev-defs.h | 61 ++++++++++++++++++++++++++++++++
 mm/backing-dev.c                 | 21 ++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..df627783e879 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -37,6 +37,7 @@ enum wb_stat_item {
 };
 
 #define WB_STAT_BATCH (8*(1+ilog2(nr_cpu_ids)))
+#define NR_WB_CTX 8
 
 /*
  * why some writeback work was initiated
@@ -80,6 +81,31 @@ struct wb_completion {
 #define DEFINE_WB_COMPLETION(cmpl, bdi)	\
 	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi)
 
+struct wb_ctx {
+	struct delayed_work pctx_dwork;
+	struct list_head pctx_b_dirty;
+	struct list_head pctx_b_io;
+	struct list_head pctx_b_more_io;
+	struct list_head pctx_b_dirty_time;
+	struct bdi_writeback *b_wb;
+	unsigned long last_old_flush;	/* last old data flush */
+	unsigned long state;
+	unsigned long bw_time_stamp;	/* last time write bw is updated */
+	unsigned long dirtied_stamp;
+	unsigned long written_stamp;	/* pages written at bw_time_stamp */
+	unsigned long write_bandwidth;	/* the estimated write bandwidth */
+	unsigned long avg_write_bandwidth; /* further smoothed write bw, > 0 */
+
+	/*
+	 * The base dirty throttle rate, re-calculated on every 200ms.
+	 * All the bdi tasks' dirty rate will be curbed under it.
+	 * @dirty_ratelimit tracks the estimated @balanced_dirty_ratelimit
+	 * in small steps and is much more smooth/stable than the latter.
+	 */
+	unsigned long dirty_ratelimit;
+	unsigned long balanced_dirty_ratelimit;
+};
+
 /*
  * Each wb (bdi_writeback) can perform writeback operations, is measured
  * and throttled, independently.  Without cgroup writeback, each bdi
@@ -143,6 +169,8 @@ struct bdi_writeback {
 
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
 
+	int wb_idx;
+	struct wb_ctx wb_ctx_list[NR_WB_CTX];
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct percpu_ref refcnt;	/* used only for !root wb's */
 	struct fprop_local_percpu memcg_completions;
@@ -208,6 +236,39 @@ struct wb_lock_cookie {
 	unsigned long flags;
 };
 
+static struct wb_ctx *ctx_wb_struct(struct bdi_writeback *wb, int ctx_id)
+{
+	return &wb->wb_ctx_list[ctx_id];
+}
+
+static inline struct list_head *ctx_b_dirty_list(struct bdi_writeback *wb, int ctx_id)
+{
+	struct wb_ctx *p_wb = ctx_wb_struct(wb, ctx_id);
+
+	return &p_wb->pctx_b_dirty;
+}
+
+static inline struct list_head *ctx_b_dirty_time_list(struct bdi_writeback *wb, int ctx_id)
+{
+	struct wb_ctx *p_wb = ctx_wb_struct(wb, ctx_id);
+
+	return &p_wb->pctx_b_dirty_time;
+}
+
+static inline struct list_head *ctx_b_io_list(struct bdi_writeback *wb, int ctx_id)
+{
+	struct wb_ctx *p_wb = ctx_wb_struct(wb, ctx_id);
+
+	return &p_wb->pctx_b_io;
+}
+
+static inline struct list_head *ctx_b_more_io_list(struct bdi_writeback *wb, int ctx_id)
+{
+	struct wb_ctx *p_wb = ctx_wb_struct(wb, ctx_id);
+
+	return &p_wb->pctx_b_more_io;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 /**
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e61bbb1bd622..fc072e9fe42c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -515,7 +515,8 @@ static void wb_update_bandwidth_workfn(struct work_struct *work)
 static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 		   gfp_t gfp)
 {
-	int err;
+	int i, err;
+	struct wb_ctx *p_wb_ctx;
 
 	memset(wb, 0, sizeof(*wb));
 
@@ -533,12 +534,30 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	wb->dirty_ratelimit = INIT_BW;
 	wb->write_bandwidth = INIT_BW;
 	wb->avg_write_bandwidth = INIT_BW;
+	wb->wb_idx = 0;
 
 	spin_lock_init(&wb->work_lock);
 	INIT_LIST_HEAD(&wb->work_list);
 	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
 	INIT_DELAYED_WORK(&wb->bw_dwork, wb_update_bandwidth_workfn);
 
+	for (i = 0; i < NR_WB_CTX; i++) {
+		p_wb_ctx = &wb->wb_ctx_list[i];
+		p_wb_ctx->b_wb = wb;
+		p_wb_ctx->last_old_flush = jiffies;
+		p_wb_ctx->bw_time_stamp = jiffies;
+		p_wb_ctx->balanced_dirty_ratelimit = INIT_BW;
+		p_wb_ctx->dirty_ratelimit = INIT_BW;
+		p_wb_ctx->write_bandwidth = INIT_BW;
+		p_wb_ctx->avg_write_bandwidth = INIT_BW;
+
+		INIT_LIST_HEAD(ctx_b_dirty_list(wb, i));
+		INIT_LIST_HEAD(ctx_b_dirty_time_list(wb, i));
+		INIT_LIST_HEAD(ctx_b_io_list(wb, i));
+		INIT_LIST_HEAD(ctx_b_more_io_list(wb, i));
+
+		INIT_DELAYED_WORK(&p_wb_ctx->pctx_dwork, wb_workfn);
+	}
 	err = fprop_local_init_percpu(&wb->completions, gfp);
 	if (err)
 		return err;
-- 
2.25.1


