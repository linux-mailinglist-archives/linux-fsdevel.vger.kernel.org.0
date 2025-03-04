Return-Path: <linux-fsdevel+bounces-43079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99BA4DBC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767E53B4C71
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10701FF5EF;
	Tue,  4 Mar 2025 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="NCYpASAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B51FE469
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086213; cv=none; b=u/AS7O3kKfq7A+BE0u9XCcGPo7Ghg/IzwZtgwvUzZcjLnRlYPUJhTRydlw+gx4hCu79MauNguGQmlByp9BKbKiyvB6YK+6TBKTtCsUxNHug6F6d4C3ewrElJUVC7dLXRvODIkct2p4RVupfGH+D1SPPvY52hlJQ4HZbOkwv0gQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086213; c=relaxed/simple;
	bh=WMWcERJJfbqiD3z8oE5+hnpSPeiC/ts2lZLJl0kJDgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piiowy32An31GrRR5tbbQUQp4N7Vb2JfAQn6lze5x9HvSWT0qNA8LnmKe0lgR/duWBfE/zguqnDZcVPvRKzAr6oUJRRSlqR5IjKPWFWZINoSzZ3umk5DsAuqwqrWCG5Jhoj40wyHqEpejWDLMcofVmSOeeJPMTugfKIjPumCK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=NCYpASAD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22355618fd9so92953615ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086209; x=1741691009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YawdmYDPWdB9hnNHcTCzRAEqbfP7zzuyOxM1DZL9r8=;
        b=NCYpASADNuvRESIPIYSAyNqu/x2P/gpnp5pgmgeYpTdbzy4ZOANSsFd5jGuG++WrXI
         ocg67nmijefF4haDICHjBOlUNjiq9uVzHBPOXgAYS/cYtrRA2c+K5EcG50ZSOZPx2xFa
         0qZ5gY514tjrfYNeVNKHYxAXnAjYdOY3Ar5jLWCIhEcsEehb+0LGYi6lNLtvHv4F9h7N
         W9QSQvNXTkmFRjv9jY8+rWAxk01qUQJ+gTaT1fSXPo2HBY290bhwb5VboFzidvAnuHKe
         5hB4GV7svePRMG4iN6gMuKNagf+qwglnV8JCISrFWavzEto5DXfTUpOwZjH1fPAHK8SR
         Kpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086209; x=1741691009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YawdmYDPWdB9hnNHcTCzRAEqbfP7zzuyOxM1DZL9r8=;
        b=YkCaZ+ccK8hmjFnODuYPlEkM4ccslj5J+0xLw0d0m4slqaWDog4WgZx9I9Q4gLZDlG
         qCtvCh2YSjW6E9F+StoQvnf1BgPOwA6U+C5yJxTOLOzdxRAiSuGLkdWE9G5dAbRviNU9
         NHZgDL935rBVw4S66TFZzYh/B6MBYDhZz8s57naKvpcbX5ZjiDVJIZA00nnT7OJZAPrE
         WoIlLyKzcacFS5yLcdJDpxARQPMvy7ZLA07Kdfl1B2Uip7nU4daUptO2DHgJl7IfFg8T
         If4WKgyT5QFjcy/F+YPkBEWa1CrnKik2M2dSQCkUYlAFAzp13/xEnO2s7h3Hcm55v5y2
         le1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIv5dp24Vk4TO9iXD/4fdoYl6gPlwmOKJMqEz9u5pcFZ7qoXcXJARmsE/rOw/MH3Bd8vMp0ZEUoqDSmTTC@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/bu/I97I+XHLgW4RBrIomf2z2QQ5Hu+GsMvtLy1h/RET7XMC
	ZkgdV3egvVY2O3KMRwnddyOy1OB2URce5B0dhVWtLXyBKw2IaK3w4PhTCjHeN+s=
X-Gm-Gg: ASbGncsLsTN4+QAsocXGQwQvlziUAE0Q7SXavzQWwQR/KguPsCx28DLsY4QN/5UQ/N7
	syCNZ1bbWegF9R2dnUXvassgYy4C8XX1N1WogTFNNlwwSoBDsUKaQaI4Nhq5chOpFNhnJbTs51A
	8tFAhBamNWLVc0daG8z0FnPt4wqHrR/L0gSRNJpll4XbXsQ4qoj1bUxJAlNy4RRRZ+7rspr7nsS
	te5hkdLO6goNBpFBT3E8N4w7RcKSGIDiZz4prUIs+EmW9J1LS5OWT+TcZcLdQsazukgSg3wLKFT
	kdt2HvLL56FiWmVaQWjN2PratPeRCg==
X-Google-Smtp-Source: AGHT+IHcP3j8xP5tujxFcnjNnFi/BdlYDT5lDMwXz1AMbsqmlg8tbp0AtTG0gER04iSD5VopiJ2d7g==
X-Received: by 2002:a17:902:d4cb:b0:21f:b6f:3f34 with SMTP id d9443c01a7336-22368f9d88fmr239812185ad.15.1741086209642;
        Tue, 04 Mar 2025 03:03:29 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:28 -0800 (PST)
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
Subject: [PATCH v2 1/3] writeback: Let trace_balance_dirty_pages() take struct dtc as parameter
Date: Tue,  4 Mar 2025 19:03:16 +0800
Message-Id: <20250304110318.159567-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304110318.159567-1-yizhou.tang@shopee.com>
References: <20250304110318.159567-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Currently, trace_balance_dirty_pages() already has 12 parameters. In the
patch #3, I initially attempted to introduce an additional parameter.
However, in include/linux/trace_events.h, bpf_trace_run12() only supports
up to 12 parameters and bpf_trace_run13() does not exist.

To reduce the number of parameters in trace_balance_dirty_pages(), we can
make it accept a pointer to struct dirty_throttle_control as a parameter.
To achieve this, we need to move the definition of struct
dirty_throttle_control from mm/page-writeback.c to
include/linux/writeback.h.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/linux/writeback.h        | 23 +++++++++++++++++++++
 include/trace/events/writeback.h | 16 ++++++---------
 mm/page-writeback.c              | 35 ++------------------------------
 3 files changed, 31 insertions(+), 43 deletions(-)

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
index a261e86e61fa..3213b9023794 100644
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
+		__entry->dirty		= dtc->dirty;
 		__entry->bdi_setpoint	= __entry->setpoint *
-						bdi_thresh / (thresh + 1);
-		__entry->bdi_dirty	= bdi_dirty;
+						dtc->wb_thresh / (dtc->thresh + 1);
+		__entry->bdi_dirty	= dtc->wb_dirty;
 		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
 		__entry->task_ratelimit	= KBps(task_ratelimit);
 		__entry->dirtied	= dirtied;
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


