Return-Path: <linux-fsdevel+bounces-43080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C5A4DBC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C22178666
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4A1FF7B0;
	Tue,  4 Mar 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="W5Ft+z9H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC61FE469
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086215; cv=none; b=rS+O0fUS9WprZWPC+XpJEsWkAjrvqK98t4vRRH+2QQUZ/YnBQ3KbsncCJ50RCSJScrYUwk0NajObMzs1UPtuDrdYmw0BQlAdNOO3kkr04baSyRllMZUH4owgml1oHBA1S9+OAJUGz3UbYaslmf3BkvnND15KxBMbxTulnFMD+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086215; c=relaxed/simple;
	bh=wFr310lePl+3sCKMgYEpa1cVuDPHCXJAKPYyZiwfkrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUikepKo5y5x3+e41fFRmU+cqw9TZLOBwCFVmmrxXVqsMqDpMP1fQz3bG7plEIIpMsMeLdVN7gMu5o/FMiHt2dWGa4M4lpIgID3OuNnTjsxcL0Q4PfV7Uf29BdTelAcMYH+LPIs+sTw33TyXufj5IxDJKtnckd2D8gKFLodQfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=W5Ft+z9H; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235189adaeso88599015ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086213; x=1741691013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lES0apB7zPp5Y1gMLsCJ52oXjFeABBbwB1psLGF4yI=;
        b=W5Ft+z9HUGS6ScmyN3/pxQBoH1N4U4CJdER5cU6G7ZhjMdNEzwMBhZDi7k4Jlt73XX
         rXFFdDCEn+KoKcRodtnt/eMw5oC2hfJtgf1WP7cOGc6m5B4m0H7bL771mYSLNtpe964N
         3i5CyYv3zuroTYOWQvX87ku9hkfEZxhJbR8z/8hBtwO27t5RAASQdTrsffXo6MDIR/R0
         ZipgHZEeQ7Jka5xtAyOIg0UxstT01Mwf91hUpCUI/nDrCvT1BMdWNv3q6DhhcwcTnt37
         XoOH8D++XRBRUObPwiXnzWDT7G5hwIcH7d2D7/onRdj15wn8XezuH1LCwNGN9N5Yebos
         1ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086213; x=1741691013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lES0apB7zPp5Y1gMLsCJ52oXjFeABBbwB1psLGF4yI=;
        b=bYIDOnNugRyrYWyUTQx1G0AWVgnHeFOfDZq+BEwyjP70KNzJrHKG+TQ+jOAqYjfkAq
         t/AVnsJEoLWlEu00V9b5rX1i/kM+SA8JMfH4rD2rrNDX8yMJsnGQ7G0aeiqaCd1X9p1t
         V0tfakexZl2HyeGnxxnyM5N9edSPX8YqAOa1YI3LKq7Vxdr1vA/2KMrtEvIE+zJYGMkx
         6pT0PNoBK9UYNkG8H4fBR6JE9qvo0HuGme/QF4usnRvufrAIUI5led0JknP+lM+pY8yY
         qjfHNkjl3KB5/0QcXswmpa+pgFqnoC2C1tTJfVFblwPX9Enif7abKq4y6yVy9EV1bQZn
         ImAA==
X-Forwarded-Encrypted: i=1; AJvYcCXTjbZFO614vqa4AcyLkOY1q8CuNjvtNnUVmwywR0ljmURdrPQOR81rI6o1Wf2E9zvtNY62bUfkJzEE5iv8@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwJXM4WLamEaUyTeKGMtRsRD7Kmbs2K5szmLMIAuvyLtiD6vZ
	9g3oTRpH6Kg9wvGh/hNHPJ9iiOnhPewabRfQCEgJHD3pseznbQxRQAdUlhDh0uE=
X-Gm-Gg: ASbGnctOcyKQu8Dj8AjAjTiZr4xa0+kJcuefwEXjRiFD3rjwsT70ZPHXvxuBQjogD8B
	ihNnMNw90wcNSbsuFqc9/qgeekBCjTkEKSFDssINlRPMq4R1tnwPoY5ugt8sdenCUfHfhVSnlYo
	aLx7WfC2y3K3d5a6HjTsGXi3aGiubTYkSZOeg2RPdJl6GNEZbwTuJxf3jH4LM4m/Kxxblc9yoA1
	uc8vh7Sej5Y7Pqn58Y2xTZidpnTQV/h0crU+hlIi6qPfuMuVR8y5z5tprwMZ+gFuX57+P2duplP
	IrYu7dbk80Zhuw4a1vGtFUMdOaCmng==
X-Google-Smtp-Source: AGHT+IEx0Bo+gN1RIbUhA8tGm6rA4iMJsFaRlXeDO7JP3HXXARwvvotVyI8kAbe7AiglMeVqNhDPfA==
X-Received: by 2002:a17:902:fc45:b0:221:2d4b:b4c6 with SMTP id d9443c01a7336-223d978eefdmr47027275ad.17.1741086213564;
        Tue, 04 Mar 2025 03:03:33 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:32 -0800 (PST)
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
Subject: [PATCH v2 2/3] writeback: Rename variables in trace_balance_dirty_pages()
Date: Tue,  4 Mar 2025 19:03:17 +0800
Message-Id: <20250304110318.159567-3-yizhou.tang@shopee.com>
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

Rename bdi_setpoint and bdi_dirty in the tracepoint to wb_setpoint and
wb_dirty, respectively. These changes were omitted by Tejun in the cgroup
writeback patchset.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/trace/events/writeback.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 3213b9023794..3046ca6b08ea 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -646,8 +646,8 @@ TRACE_EVENT(balance_dirty_pages,
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
@@ -667,9 +667,9 @@ TRACE_EVENT(balance_dirty_pages,
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
 						freerun) / 2;
 		__entry->dirty		= dtc->dirty;
-		__entry->bdi_setpoint	= __entry->setpoint *
+		__entry->wb_setpoint	= __entry->setpoint *
 						dtc->wb_thresh / (dtc->thresh + 1);
-		__entry->bdi_dirty	= dtc->wb_dirty;
+		__entry->wb_dirty	= dtc->wb_dirty;
 		__entry->dirty_ratelimit = KBps(dirty_ratelimit);
 		__entry->task_ratelimit	= KBps(task_ratelimit);
 		__entry->dirtied	= dirtied;
@@ -685,7 +685,7 @@ TRACE_EVENT(balance_dirty_pages,
 
 	TP_printk("bdi %s: "
 		  "limit=%lu setpoint=%lu dirty=%lu "
-		  "bdi_setpoint=%lu bdi_dirty=%lu "
+		  "wb_setpoint=%lu wb_dirty=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
 		  "dirtied=%u dirtied_pause=%u "
 		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
@@ -693,8 +693,8 @@ TRACE_EVENT(balance_dirty_pages,
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
-- 
2.25.1


