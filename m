Return-Path: <linux-fsdevel+bounces-43081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B17A4DBC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CED178BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0DA1FFC66;
	Tue,  4 Mar 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Mxndf6Tz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B871FFC46
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086220; cv=none; b=o54OeGdyMDNO1io+Dgikqo9NP1jAql1vzxJBxA3cqd7hZIk4A+h0gNrs9KPPuajaQ94O97P4SfqE8g3rYSwCh/3w3Hb+tafe1o/tjub9Imqvjej1MmhEZJ40ouNymahGBDfpAb4zY+ClMuj085RmfJnPKZ25PECD4VzUag5dt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086220; c=relaxed/simple;
	bh=wzIi4HZXwqVOWENoquV+UIkh/r0UJZTDI0sJVxfYL0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSUNMCXTpnXG2x63m78TqWzy7Lh874fW/5irFI0/g0RrURckIyvPIWmTmSUW9xRhQMZtY0+hH0bxm5qqIZcWYk34+R+OgouD30HB5v4Ta2JoJkli49mFbINuCAYxBrbJsFoPqJRfc2GjxEAmwvqgSqqwGcInWADJM+tuwxDD2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Mxndf6Tz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22382657540so53954365ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086217; x=1741691017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGd6xUUug40ndWv/7UEStbMr4MjIVHoaP0yPiRkB0+c=;
        b=Mxndf6TzleS+dRPLQMadyqWS9fol6eDBfKYTyFAP3FcRTlGK5Bdfnt2yRUWOI7NFv+
         vm7I+i6koCEW9iBSc+/OkyzOKEYOVqX6pVPGJ9mg6eM/sucNWYZyYBgC+7ZOULQoaJEA
         tg2G/1/mbqP7jMdeh5gHuyVsN0e2IMU04CN9OxvBZOGTUNWs/B4JPSL8naJkAqLcW9HN
         WxqGW8FME4qh0WtGzYgeTNZSkoPPyQQ0XSMmG8XT07mMEiaslY0wG/q+jRP9nCkPUkPS
         TkSb7QjCEgApM3CxSio/GcNcPeHNOEgd5Wrf7bcemmfXoHUbD6/D8FvOJemXObW5b/XA
         iOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086217; x=1741691017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGd6xUUug40ndWv/7UEStbMr4MjIVHoaP0yPiRkB0+c=;
        b=EH8MXQZ9PuJk+wCIqt6rjEKNy2ZUDq5bf7praIqKZVqXaRngRaoOxn8aXOZW/B/Kcm
         X+Te4IBdHlikEUTLXKHgTbgUOQLZv7n5t7utlNMSnpAVPQazXajnZUS/LSsADtXbJZQQ
         XkIuxuwdHMdoN9Qah7KlXETve4i5oE5Ng5Q0W956sLk6zJtmpvo8BD3Az6UxErNfKDjG
         /X+laRhiJb9tv/QMAI77ooYdU1toZ+P59xZhQ76gv5yaX+deBLFZkyFmC6fxWhl19nGc
         67n58ETwAH5PyZ1JmxKZC9TS1wa9yMz3SaiiIcayXUcfRyZSonKtkd4tY6Bc9cTWYblC
         Ixig==
X-Forwarded-Encrypted: i=1; AJvYcCW+QXZck6aR00MbRmvYmEckma/aD96ob9CGAFfkYXXQzFGEiK4CxNrPucD9hAYZNOPuUPxXkgIarNiXYq+T@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2HYwYnKsdPxS3aoKgyJX0g83nec/FshlfPhztuwHEM5FSCDI
	d3G4SXa1O6lPjLOGp6TAOqQKGajshsVir62d7ztKyuBON4OYlydd/nufVcBD4cQ=
X-Gm-Gg: ASbGncvlHKwaDCbbguPA3liTeOLwilPUlCj5hLtLAfrFsIyU+2qpX3wABI52/E9mo0e
	tQmKeTyu0opF/aLR/JQ1HLoS9MstamQWSmRUvo9PcFn+Do/END8JowSJhytcKr32YAhBxs0IhaF
	nphaAEUQEQvJ6wn3p2cuHw759vaa+Un3AE58F/qS1pb7ychUUzyAqUqlCPOe+F60XvE3TMru2yf
	HX+nviAckbLuioNcG1MI/x+Wsol7+GzokhXNRaKeO/hPAzS0sNybs7vJV38c7xH+ejeDTi3fG9y
	hIfsUrEWKjRiBvVYLfju4tRM4YIPgQ==
X-Google-Smtp-Source: AGHT+IHC27naAV4G4mjua+6oLFQl9im5/HZZ3hI9l/b48C3Mb32O1UgWu/XF/2xkyJ8188GOgWiflw==
X-Received: by 2002:a17:902:f990:b0:220:c911:3f60 with SMTP id d9443c01a7336-2236926a639mr179441625ad.47.1741086217307;
        Tue, 04 Mar 2025 03:03:37 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:36 -0800 (PST)
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
Subject: [PATCH v2 3/3] writeback: Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Tue,  4 Mar 2025 19:03:18 +0800
Message-Id: <20250304110318.159567-4-yizhou.tang@shopee.com>
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

In the commit dcc25ae76eb7 ("writeback: move global_dirty_limit into
wb_domain") of the cgroup writeback backpressure propagation patchset,
Tejun made some adaptations to trace_balance_dirty_pages() for cgroup
writeback. However, this adaptation was incomplete and Tejun missed
further adaptation in the subsequent patches.

In the cgroup writeback scenario, if sdtc in balance_dirty_pages() is
assigned to mdtc, then upon entering trace_balance_dirty_pages(),
__entry->limit should be assigned based on the dirty_limit of the
corresponding memcg's wb_domain, rather than global_wb_domain.

To address this issue and simplify the implementation, introduce a 'limit'
field in struct dirty_throttle_control to store the hard_limit value
computed in wb_position_ratio() by calling hard_dirty_limit(). This field
will then be used in trace_balance_dirty_pages() to assign the value to
__entry->limit.

Fixes: dcc25ae76eb7 ("writeback: move global_dirty_limit into wb_domain")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/linux/writeback.h        | 1 +
 include/trace/events/writeback.h | 5 ++---
 mm/page-writeback.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 32095928365c..58bda3347914 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -326,6 +326,7 @@ struct dirty_throttle_control {
 	unsigned long		dirty;		/* file_dirty + write + nfs */
 	unsigned long		thresh;		/* dirty threshold */
 	unsigned long		bg_thresh;	/* dirty background threshold */
+	unsigned long		limit;		/* hard dirty limit */
 
 	unsigned long		wb_dirty;	/* per-wb counterparts */
 	unsigned long		wb_thresh;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 3046ca6b08ea..0ff388131fc9 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -663,9 +663,8 @@ TRACE_EVENT(balance_dirty_pages,
 		unsigned long freerun = (dtc->thresh + dtc->bg_thresh) / 2;
 		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
 
-		__entry->limit		= global_wb_domain.dirty_limit;
-		__entry->setpoint	= (global_wb_domain.dirty_limit +
-						freerun) / 2;
+		__entry->limit		= dtc->limit;
+		__entry->setpoint	= (dtc->limit + freerun) / 2;
 		__entry->dirty		= dtc->dirty;
 		__entry->wb_setpoint	= __entry->setpoint *
 						dtc->wb_thresh / (dtc->thresh + 1);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e980b2aec352..3147119a9a04 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1072,7 +1072,7 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
 	struct bdi_writeback *wb = dtc->wb;
 	unsigned long write_bw = READ_ONCE(wb->avg_write_bandwidth);
 	unsigned long freerun = dirty_freerun_ceiling(dtc->thresh, dtc->bg_thresh);
-	unsigned long limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
+	unsigned long limit = dtc->limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
 	unsigned long wb_thresh = dtc->wb_thresh;
 	unsigned long x_intercept;
 	unsigned long setpoint;		/* dirty pages' target balance point */
-- 
2.25.1


