Return-Path: <linux-fsdevel+bounces-42926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796CA4BBAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 11:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBC1892FBA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16B1F1525;
	Mon,  3 Mar 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Fs+7Qod3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC71F37BA
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996394; cv=none; b=HBY0fJd6FVJK10RfInZ5CgDCYEOtS/BUXG8h9UVTTSZDV7/LVYSwnrNxKIIRufrg/eR6muUbKmnqz9MyJ5Vu3cH2fg0rGw2eyVRr1oJLP7eg+dbpOhJm723Z/XTXdLSiX/xHUgsKWZtYxR8cZPNMYdtg0QJceAQSDbFpjXgJZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996394; c=relaxed/simple;
	bh=q4V8PCiwKojPy1QYgapBfO9lTDA+LB5m3KPLTH/ST84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrCSHGSj0urAf9IbK4IVBVS0YypOQLk9b7kXp3QOegXyCTvLqehwJb76l0XVliPNpTvVHruiycdjdKbYRQIq5EUb4VqD3FajDX+JLxLBdcvcW0sciojaAGDi2dT+VXFOUQe0S2Of2pQ02eWyn85eBeBAMfyKIif2wbtNdAay6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Fs+7Qod3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235189adaeso64204115ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 02:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1740996391; x=1741601191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlOgUF0I+Rkuiq5isF50AFm1bBn1sNSF5ax0jaYNIBw=;
        b=Fs+7Qod3K10fvD4Su8HbWX/q4o85LCBPoozoYzvvUAcDRlQl96GY+8btzFXi/rEZ52
         bXLnNFbVUY960ppNVBcLbURzjWh+w+uy49nkbwVdNDdBdyepRkFOHdPMY7pQIdULSmZ9
         gTshS3wtf6dYNs9aKECZOV1JNyNSh1r6zS+AzY8AIUFaA+RezauogotUWq23PNaeeSIB
         dCeezkzk3qJGiTe+yRtaJtcKGfm5B5AKobl9ak29polJQQhWYAC1m2/xbiUJ6DSSTHhE
         3cbwawafLwWhDfdoHgeoEQBnlsFpgn5yb7BNnE+TIH7VQdMoflefL+ZOxpzzcRb0A5vN
         suqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996391; x=1741601191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlOgUF0I+Rkuiq5isF50AFm1bBn1sNSF5ax0jaYNIBw=;
        b=TTjY9+1c9gTBlt9InuotvHbKZNMCA6sppSOF825RBqH0PpIbN1F5cd6ECaqt0QVQR2
         2hUKw7Eyl0nr+tUi/ewj1sRIyZFlzu7alaVlxfXX+sSyVVNUA7G34K9YCiQEkUC0ue3p
         ucu8CT9n4oUbDOwVW7ZmSkvEdNmJeMZFKMCbu959JlvXp4w0XXoEWcMdnG/0+aDY4Zl+
         U1pGUwZTFibCgY6cztdkF8jffwVGKNhMa1uAGUnxCvFSykrLilILp9LO0LdyCqQQGeon
         bX58eR+ltPIpdAwteKIEq77+MLyrtJOrnwktJ+SjBgIZxOqMou3GVQjT49JQxN3XF2kQ
         gTTw==
X-Forwarded-Encrypted: i=1; AJvYcCXYIvSC7DzQU3vR28gjDi2GWyPdb/hdkDqsq0jmGQGqkldU0mCQJp7BQorTPHZpRgEJeR0UKT+E8aZIO1vt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/VMMXSGX11HmOp0eSJfUAHoRqZx0wo+Tg1nVgNZtqv+2zUWQ
	PBEDnZ4sSFW++ToxGOecW2nvlL/p8ka1m8sdguGfsIdBmd/O7NK9lPbcY+qTEBc=
X-Gm-Gg: ASbGncvS8cYkm1IeJOFpqy4kWTNq7Q1BB1uNHVT4mt56BLzyGE0Pnv8qWV2Lqi4U4mv
	/PRzhzkikVJorsbNuENkizAZVosrc+6WXRXa7CUmAHD+v4wzMqvPTFGnvTlvL+KK+aiTGJ79rAx
	3oznNSNxXgBlT9romu/0q91jBC4ifKCYwuQ1+q69d755enYYYLMgISoVKHrNfavCIfzkN+SImtD
	9l9ACgTR66Byf+NAmThC+td4H22U68KzJDb65CmNSB25KX92ylauNvs6Zi1di6xKM1+HpSWjgMs
	3gtQSQrh1s8PMlzWIJZy1XKxjVyg+Q==
X-Google-Smtp-Source: AGHT+IHIVt3VPmyTSVrkUCPhcW9I+/9BdLXMLDmjaYIvdMR9bAGzwWvrVsZS6NIolMs+7Bf7bchTHQ==
X-Received: by 2002:a17:903:1252:b0:223:4d5e:76a6 with SMTP id d9443c01a7336-22367413da7mr199503185ad.1.1740996391188;
        Mon, 03 Mar 2025 02:06:31 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350537b47sm74397275ad.251.2025.03.03.02.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:06:30 -0800 (PST)
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
Subject: [PATCH RESEND 2/2] writeback: Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Mon,  3 Mar 2025 18:06:17 +0800
Message-Id: <20250303100617.223677-3-yizhou.tang@shopee.com>
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


