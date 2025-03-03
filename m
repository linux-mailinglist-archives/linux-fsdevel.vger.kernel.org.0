Return-Path: <linux-fsdevel+bounces-42925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB556A4BBAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 11:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CA31892F58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC21F2B88;
	Mon,  3 Mar 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="WPkqK6DZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9391F237A
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996389; cv=none; b=TTEe5toNmeEtz+UhKlBfbSbS/Op8kcEWBBC2UiQsfsmwvk3SZY/Bhvp81M2TSRp9dTGvmNc0Tm0CdlO7ZV9Cj+HR8iT6a8Pb5ltySOH6SmkkN/SwxOWALgRhE6hdemLpg1Tz0SwCev5nHK5ZwUWgSa83ulbSvnZ53Xh7rCV+ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996389; c=relaxed/simple;
	bh=RTxBZ+NUAaUwIZLg/UYjKt+XNtfXUf6QorszPjtSIJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OuOXDG/Bou3QZdcf7cQwnBnI9m75AdO2NOdT3czlHG2GRPZOx2hbTHWn10gRG5HMbl8kB4GNpVPAUmXM/iATwRVJJt1EPGi155jFlRDOYaLoOdUNgoiUXG6PrbKhxp1ghKhS/YEmricPJhY9oeiECM5wyGdMxonWPyqgJv4Lusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=WPkqK6DZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2237cf6a45dso30081445ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 02:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1740996387; x=1741601187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/PqsQZYzh2gZL6Eu3byS2da5OGA46n+6o2RqtuMFMA=;
        b=WPkqK6DZbErw6K/HmytQaXlB4i0YDt2UoBlWXYHB8Y8a1itw0N5mGjvT3DDjBBlNJv
         KvdMdeR5VkTYiWjLnw4YLRYSA/jFS8/bnv/wwviGantQR1xJvxVzMgj+2kXLk7iOabCo
         mednLj5051+S4B57985B7az71fCdL9MsgiUs37fdqCHzuc0aSI8iwxQARvTKo10LxM8E
         A9asTgXr0oNTNIeqk+CxdDEEh9xTENBhN4NZwXo7d/rvG5XMNQJ3UvIxgcjHcHimbgTy
         Udmdy9PDSQvVpBtXFni/ti8dNnIVtx6fzaS3KRueiVcuR13nU1DWTkFTn3KDyenlVMC/
         8+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996387; x=1741601187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/PqsQZYzh2gZL6Eu3byS2da5OGA46n+6o2RqtuMFMA=;
        b=o5iJbJhY6DR0eGeBlliWEmiKjoHW1rlc2YViyiKr9cu8hzpshZf6MK6kWtCMVl+Sbj
         Hk/JeaDHguxNlzDgCsyvhlaKGOuUHHIFdlcHHa4QN2T5DwousqEeqvnda0OzLO0/yuH8
         M4WBnvDYm+Bi8m5ja6iKtijaGnWT4AJatigXRv9ltswndZm0kGY8D2sX72x0dPvmwLEf
         VywgPA70lF3zgw8OmCERY1ZkTmKAVCQFOmtJdnsUIyIyNjo1o0JznHIDNhwbDtVDq0qi
         BtKeItYlHR42aX+Ew0HBEMhmSL2KSMKMk7f8ieEoDzRl/k0a8khtNRkBbgB24AtejLDw
         XjbA==
X-Forwarded-Encrypted: i=1; AJvYcCUyfv4N5kK/cF2XvjjQLwhJ1RJEou7unHkcjrjTSFz0rHzcThoVtsu10mWQtC3aFEgFQk0VJTmEVvTSVDJ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrzCA2OqEIe0lirGdbmysGUZDWKOt0L3nKvPd/W0Bhmn577UP
	NBMngE/eNaAOKuCooGd2e2qz3NBHHnEVFNrgULp4jPOgiMWvMA2xnzx++9uFcuM=
X-Gm-Gg: ASbGncuhH1e/yP104d2idc+9aT776KRoNZ4aGvRYKweArlLJOlXGYjyE9hgSuV4GBKq
	PXiWbKFF33ATlS1lRGKx7p3+r2zpaYnFqmZ8Xu0x3c1sA8JP2Nl3Gk/EKv3k/i7WpzWHMJptKEX
	4wqIaMwdGRX+gjUjzhs/L4BCfgrd/z6be8n+UnIlHQZ3GfrDBrsGiK874XSNla0Nht1a/l4x2r6
	rh3iUVpe2VgohVwmtqsWwJnqTE9DOS0r3s9OWcABxYEyis96I0DF8GHRM45rD1V9f7oesowldqB
	nP0MmoY/eFKWdt7XDrz9V+s/CcKa4Q==
X-Google-Smtp-Source: AGHT+IFrTHdg6NNuF2FgYK7p70ifhC/X3+blinwEJuQgxKQLWCLBaBmRYMC0rSrt/DKnxA7VSNUMuQ==
X-Received: by 2002:a17:90a:e7cd:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-2febab2edbdmr18742630a91.1.1740996387540;
        Mon, 03 Mar 2025 02:06:27 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350537b47sm74397275ad.251.2025.03.03.02.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:06:26 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH RESEND 1/2] writeback: Let trace_balance_dirty_pages() take struct dtc as parameter
Date: Mon,  3 Mar 2025 18:06:16 +0800
Message-Id: <20250303100617.223677-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303100617.223677-1-yizhou.tang@shopee.com>
References: <20250303100617.223677-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Currently, trace_balance_dirty_pages() already has 12 parameters. In the
next patch, I initially attempted to introduce an additional parameter.
However, in include/linux/trace_events.h, bpf_trace_run12() only supports
up to 12 parameters and bpf_trace_run13() does not exist.

To reduce the number of parameters in trace_balance_dirty_pages(), we can
make it accept a pointer to struct dirty_throttle_control as a parameter.
To achieve this, we need to move the definition of struct
dirty_throttle_control from mm/page-writeback.c to
include/linux/writeback.h.

By the way, rename bdi_setpoint and bdi_dirty in the tracepoint to
wb_setpoint and wb_dirty, respectively. These changes were omitted by
Tejun in the cgroup writeback patchset.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/linux/writeback.h        | 23 +++++++++++++++++++++
 include/trace/events/writeback.h | 28 +++++++++++--------------
 mm/page-writeback.c              | 35 ++------------------------------
 3 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d11b903c2edb..32095928365c 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -313,6 +313,29 @@ static inline void cgroup_writeback_umount(struct super_block *sb)
 /*
  * mm/page-writeback.c
  */
+/* consolidated parameters for balance_dirty_pages() and its subroutines */
+struct dirty_throttle_control {
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct wb_domain	*dom;
+	struct dirty_throttle_control *gdtc;	/* only set in memcg dtc's */
+#endif
+	struct bdi_writeback	*wb;
+	struct fprop_local_percpu *wb_completions;
+
+	unsigned long		avail;		/* dirtyable */
+	unsigned long		dirty;		/* file_dirty + write + nfs */
+	unsigned long		thresh;		/* dirty threshold */
+	unsigned long		bg_thresh;	/* dirty background threshold */
+
+	unsigned long		wb_dirty;	/* per-wb counterparts */
+	unsigned long		wb_thresh;
+	unsigned long		wb_bg_thresh;
+
+	unsigned long		pos_ratio;
+	bool			freerun;
+	bool			dirty_exceeded;
+};
+
 void laptop_io_completion(struct backing_dev_info *info);
 void laptop_sync_completion(void);
 void laptop_mode_timer_fn(struct timer_list *t);
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index a261e86e61fa..3046ca6b08ea 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -629,11 +629,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 TRACE_EVENT(balance_dirty_pages,
 
 	TP_PROTO(struct bdi_writeback *wb,
-		 unsigned long thresh,
-		 unsigned long bg_thresh,
-		 unsigned long dirty,
-		 unsigned long bdi_thresh,
-		 unsigned long bdi_dirty,
+		 struct dirty_throttle_control *dtc,
 		 unsigned long dirty_ratelimit,
 		 unsigned long task_ratelimit,
 		 unsigned long dirtied,
@@ -641,7 +637,7 @@ TRACE_EVENT(balance_dirty_pages,
 		 long pause,
 		 unsigned long start_time),
 
-	TP_ARGS(wb, thresh, bg_thresh, dirty, bdi_thresh, bdi_dirty,
+	TP_ARGS(wb, dtc,
 		dirty_ratelimit, task_ratelimit,
 		dirtied, period, pause, start_time),
 
@@ -650,8 +646,8 @@ TRACE_EVENT(balance_dirty_pages,
 		__field(unsigned long,	limit)
 		__field(unsigned long,	setpoint)
 		__field(unsigned long,	dirty)
-		__field(unsigned long,	bdi_setpoint)
-		__field(unsigned long,	bdi_dirty)
+		__field(unsigned long,	wb_setpoint)
+		__field(unsigned long,	wb_dirty)
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
 		__field(unsigned int,	dirtied)
@@ -664,16 +660,16 @@ TRACE_EVENT(balance_dirty_pages,
 	),
 
 	TP_fast_assign(
-		unsigned long freerun = (thresh + bg_thresh) / 2;
+		unsigned long freerun = (dtc->thresh + dtc->bg_thresh) / 2;
 		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
 
 		__entry->limit		= global_wb_domain.dirty_limit;
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
 						freerun) / 2;
-		__entry->dirty		= dirty;
-		__entry->bdi_setpoint	= __entry->setpoint *
-						bdi_thresh / (thresh + 1);
-		__entry->bdi_dirty	= bdi_dirty;
+		__entry->dirty		= dtc->dirty;
+		__entry->wb_setpoint	= __entry->setpoint *
+						dtc->wb_thresh / (dtc->thresh + 1);
+		__entry->wb_dirty	= dtc->wb_dirty;
 		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
 		__entry->task_ratelimit	= KBps(task_ratelimit);
 		__entry->dirtied	= dirtied;
@@ -689,7 +685,7 @@ TRACE_EVENT(balance_dirty_pages,
 
 	TP_printk("bdi %s: "
 		  "limit=%lu setpoint=%lu dirty=%lu "
-		  "bdi_setpoint=%lu bdi_dirty=%lu "
+		  "wb_setpoint=%lu wb_dirty=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
 		  "dirtied=%u dirtied_pause=%u "
 		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
@@ -697,8 +693,8 @@ TRACE_EVENT(balance_dirty_pages,
 		  __entry->limit,
 		  __entry->setpoint,
 		  __entry->dirty,
-		  __entry->bdi_setpoint,
-		  __entry->bdi_dirty,
+		  __entry->wb_setpoint,
+		  __entry->wb_dirty,
 		  __entry->dirty_ratelimit,
 		  __entry->task_ratelimit,
 		  __entry->dirtied,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb55ece39c56..e980b2aec352 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -120,29 +120,6 @@ EXPORT_SYMBOL(laptop_mode);
 
 struct wb_domain global_wb_domain;
 
-/* consolidated parameters for balance_dirty_pages() and its subroutines */
-struct dirty_throttle_control {
-#ifdef CONFIG_CGROUP_WRITEBACK
-	struct wb_domain	*dom;
-	struct dirty_throttle_control *gdtc;	/* only set in memcg dtc's */
-#endif
-	struct bdi_writeback	*wb;
-	struct fprop_local_percpu *wb_completions;
-
-	unsigned long		avail;		/* dirtyable */
-	unsigned long		dirty;		/* file_dirty + write + nfs */
-	unsigned long		thresh;		/* dirty threshold */
-	unsigned long		bg_thresh;	/* dirty background threshold */
-
-	unsigned long		wb_dirty;	/* per-wb counterparts */
-	unsigned long		wb_thresh;
-	unsigned long		wb_bg_thresh;
-
-	unsigned long		pos_ratio;
-	bool			freerun;
-	bool			dirty_exceeded;
-};
-
 /*
  * Length of period for aging writeout fractions of bdis. This is an
  * arbitrarily chosen number. The longer the period, the slower fractions will
@@ -1962,11 +1939,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 		 */
 		if (pause < min_pause) {
 			trace_balance_dirty_pages(wb,
-						  sdtc->thresh,
-						  sdtc->bg_thresh,
-						  sdtc->dirty,
-						  sdtc->wb_thresh,
-						  sdtc->wb_dirty,
+						  sdtc,
 						  dirty_ratelimit,
 						  task_ratelimit,
 						  pages_dirtied,
@@ -1991,11 +1964,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
 
 pause:
 		trace_balance_dirty_pages(wb,
-					  sdtc->thresh,
-					  sdtc->bg_thresh,
-					  sdtc->dirty,
-					  sdtc->wb_thresh,
-					  sdtc->wb_dirty,
+					  sdtc,
 					  dirty_ratelimit,
 					  task_ratelimit,
 					  pages_dirtied,
-- 
2.25.1


