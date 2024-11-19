Return-Path: <linux-fsdevel+bounces-35187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C89D2521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 12:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC071F231ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BAA1CBEB4;
	Tue, 19 Nov 2024 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcRXVPVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01271CB324;
	Tue, 19 Nov 2024 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016773; cv=none; b=hiJ/v+uGmPP4Xv0ULRpXOJe4rfe3YJ2kpLbs4dcTY4IHBqlYU8ViI5CQcznkvoG0P1MGcdv9rYwBpAA04KhILbo8NZyQkNVDgly4N+SduGSpLAAwBjgM/H3+CNbGfUx1AnaaIyiHnBQAlGScNrdX4BAfRNPaLEeDrdAQO8mPnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016773; c=relaxed/simple;
	bh=xSvfXtCkpoaaDDBmlXnf7jS6faDw70aHrocw1POJ3zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbRMNZkeUyT0pBa5phpF3KT5uOcakkIygnxi5WujIc2267mJi/KaP+hSbf3cO/40bYioIrYXBvEt9w25QnfTOuOAAmBGgcazJLnR9yeNnxtEZ5iqsCylBbyE3LnNiok9FpijbGjr5wXLwUwv1vjrBR2IJxn25MJiqxiMGUGshRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcRXVPVG; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20cdbe608b3so52107665ad.1;
        Tue, 19 Nov 2024 03:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732016771; x=1732621571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4STO0iPgmcM5FLfwGndSr+i7SPybq2xxxE85AAR0y4=;
        b=kcRXVPVGBJcke21dYLPKHeDvC4tcZNJ3n4D0g4imTGiXy6KyvLQzUSbLBr2fUDkQ8D
         YGyhaqKFEQYdWggrzMTGWwDvvCbnpjD7pkGTbbYknWJKiXtv3+ugOCkFt/mN4PW5bAY9
         iXpW50LAp0eI6EmL80iPcEe598sRlWJfpE57tFklaK86OKSImpnvdYhtbn5vsbbeA0ZL
         UuzN5/7TtY1MAleueWf61MUCwEL3ataJh2t2TdvZdl+tP5bmuIFX5ka+n5Aj2rl9BB3c
         XnGtJfITOIOhn57ChLJE+DuL7JSE4WfTnJjrK9B6quWjRXi+NMHtNKWyiPRd55Uke876
         jhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016771; x=1732621571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4STO0iPgmcM5FLfwGndSr+i7SPybq2xxxE85AAR0y4=;
        b=xARH3RIGiZWDaQpPn/Brv16XMP0AFB4dQ1dGiR7wUUyH9SH2PF64c2DpSLXCRKNMIf
         zuoYTsxvOq0oZjdx87xbOgI9qxtUFIkGRFb8iUgRnW0i446kLMrE6RXTpEP97ChsqmmL
         owhKp0bPtSykCgzjkoCJHQvPxUOMeYbklZnEp7YzRlD+uTYS6kt3Na8lq8G2jie4/skA
         2Zv4Z12i7tDFTp2UBSWXRLlKw+6Kjh03D5V/BO6mu0g3gIhBz6BMEJr28+Fd7mKq7+vt
         3sUmTT1MC9JzcDGM7UBXwlclOBVz8Y63AjvPWt2BeEJzsxeXVISZJTxljGwj6Uwj7gfG
         pgAA==
X-Forwarded-Encrypted: i=1; AJvYcCWU/y1++c/Wd1+20Y17r/VeJmlLUhLf38txAnln7TLjYURBXd/mMQ1r6ns/fqDTIW5kp6gcd7tTzR5kk1k5@vger.kernel.org, AJvYcCXsiHYyV0aXQUpPV+GCFHxzp+28PsWpiEjwSLWC+xYLklhuRX6m81R+g3StZcMTWw1aIEqk8rZQG2x+ihkN@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpcWt/kD9IJmwm4fZPBhFwa6ogHaXTJil1J0DzVowkRAbwPRV
	ZQJJbPUZlZLj2BPLAgBao6RVUdvxhr9JiS2p/oOA5wGLqjVz6QHb
X-Google-Smtp-Source: AGHT+IF0AWadxz0cWwHYidBQa9AYa+e5jib+lfeOkhLDfGyXzY8wZsXdzJNfC5G6279qRUp9jyrQKg==
X-Received: by 2002:a17:902:e748:b0:211:ff13:8652 with SMTP id d9443c01a7336-211ff138fd5mr153530625ad.28.1732016771107;
        Tue, 19 Nov 2024 03:46:11 -0800 (PST)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2124ce8040asm13547225ad.134.2024.11.19.03.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:46:10 -0800 (PST)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: jimzhao.ai@gmail.com
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: [PATCH v2] mm/page-writeback: raise wb_thresh to prevent write blocking with strictlimit
Date: Tue, 19 Nov 2024 19:44:42 +0800
Message-Id: <20241119114444.3925495-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113100735.4jafa56p4td66z7a@quack3>
References: <20241113100735.4jafa56p4td66z7a@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the strictlimit flag, wb_thresh acts as a hard limit in
balance_dirty_pages() and wb_position_ratio().  When device write
operations are inactive, wb_thresh can drop to 0, causing writes to be
blocked.  The issue occasionally occurs in fuse fs, particularly with
network backends, the write thread is blocked frequently during a period.
To address it, this patch raises the minimum wb_thresh to a controllable
level, similar to the non-strictlimit case.

Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
---
Changes in v2:
1. Consolidate all wb_thresh bumping logic in __wb_calc_thresh for consistency;
2. Replace the limit variable with thresh for calculating the bump value,
as __wb_calc_thresh is also used to calculate the background threshold;
3. Add domain_dirty_avail in wb_calc_thresh to get dtc->dirty.
---
 mm/page-writeback.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e5a9eb795f99..8b13bcb42de3 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -917,7 +917,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 				      unsigned long thresh)
 {
 	struct wb_domain *dom = dtc_dom(dtc);
+	struct bdi_writeback *wb = dtc->wb;
 	u64 wb_thresh;
+	u64 wb_max_thresh;
 	unsigned long numerator, denominator;
 	unsigned long wb_min_ratio, wb_max_ratio;
 
@@ -931,11 +933,27 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
-	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
+	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
 	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
-	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
-		wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+
+	/*
+	 * It's very possible that wb_thresh is close to 0 not because the
+	 * device is slow, but that it has remained inactive for long time.
+	 * Honour such devices a reasonable good (hopefully IO efficient)
+	 * threshold, so that the occasional writes won't be blocked and active
+	 * writes can rampup the threshold quickly.
+	 */
+	if (thresh > dtc->dirty) {
+		if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT))
+			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 100);
+		else
+			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
+	}
+
+	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	if (wb_thresh > wb_max_thresh)
+		wb_thresh = wb_max_thresh;
 
 	return wb_thresh;
 }
@@ -944,6 +962,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
 {
 	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
 
+	domain_dirty_avail(&gdtc, true);
 	return __wb_calc_thresh(&gdtc, thresh);
 }
 
@@ -1120,12 +1139,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
 	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
 		long long wb_pos_ratio;
 
-		if (dtc->wb_dirty < 8) {
-			dtc->pos_ratio = min_t(long long, pos_ratio * 2,
-					   2 << RATELIMIT_CALC_SHIFT);
-			return;
-		}
-
 		if (dtc->wb_dirty >= wb_thresh)
 			return;
 
@@ -1196,14 +1209,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
 	 */
 	if (unlikely(wb_thresh > dtc->thresh))
 		wb_thresh = dtc->thresh;
-	/*
-	 * It's very possible that wb_thresh is close to 0 not because the
-	 * device is slow, but that it has remained inactive for long time.
-	 * Honour such devices a reasonable good (hopefully IO efficient)
-	 * threshold, so that the occasional writes won't be blocked and active
-	 * writes can rampup the threshold quickly.
-	 */
-	wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
 	/*
 	 * scale global setpoint to wb's:
 	 *	wb_setpoint = setpoint * wb_thresh / thresh
@@ -1459,17 +1464,10 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
 	 * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
 	 * Hence, to calculate "step" properly, we have to use wb_dirty as
 	 * "dirty" and wb_setpoint as "setpoint".
-	 *
-	 * We rampup dirty_ratelimit forcibly if wb_dirty is low because
-	 * it's possible that wb_thresh is close to zero due to inactivity
-	 * of backing device.
 	 */
 	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
 		dirty = dtc->wb_dirty;
-		if (dtc->wb_dirty < 8)
-			setpoint = dtc->wb_dirty + 1;
-		else
-			setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
+		setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
 	}
 
 	if (dirty < setpoint) {
-- 
2.20.1


