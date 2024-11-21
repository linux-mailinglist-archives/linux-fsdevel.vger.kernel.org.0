Return-Path: <linux-fsdevel+bounces-35403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460619D4A69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053F4282DA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6161CB32F;
	Thu, 21 Nov 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnateCbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF45695;
	Thu, 21 Nov 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183548; cv=none; b=lTScuyDjQZHRiUSN1jofHHYBqqdglfWIFiHtpspLeBGofrHAmAe4w1wDR2t/mKen9qY+ss+p4MrTmmicihDS0r25/sV07jNS0Y/6iGVO4FI5N9NCatiP0G0fsnZyWFHWA5kQZU1kI9JTettu+YkqbC/zNd1zi7ADe48blSUr6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183548; c=relaxed/simple;
	bh=H9rh7ixMdRmHYOtcOw1jzmgpDuKoxFLFcA7ty6yRJ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z4ykXyVDenBM9Or9QEpJf1/3em7dodzPUw1oeSzxUC9a+2A8arJOtAfx20HY3GWW9E97+9lAM9yeB7PFBnAOtymQS7WfWyX2R/G2o3S3cNuM/6raeuibMbkgddAN9Ji3m2CGngzUVCAaCuZkPtjhauyaPDVwLQDjzDcMraY+TvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnateCbM; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21271dc4084so6290985ad.2;
        Thu, 21 Nov 2024 02:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732183546; x=1732788346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUrUVwBo4XxPjlkazoAS4h6kGrnp7h/1FcU9qVjOigg=;
        b=lnateCbMzuv006jYWljC/Wde8iKRRCuexpqCFysPbcNtNquQB1/I3RxUmYK40nAJiX
         KJFrMkGRmex/kPDS2k397oVjzB/cmj4shM7qG67qWuHv7+gH5uBasjvlTjQlgpdfE5MW
         9o1z2Bbaqm25kKnnQGZnfGm9S73ppM9wJh3zwVi64hH3Kp363u9YEKRxSsadjoIhXahT
         Y+m0TZJSRG87/2yS9yxPT3LO5/WtQ7Nz0BSdBXOAqHQ2kkZlfH8HANIq+ljWSCiUIlFD
         Xd7GgJOmBUShQiaTzPeIxbm8PuWnHphtDhn3gLAqOKRyK3VEhHp5pOckMj6szO/xlHbm
         lc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732183546; x=1732788346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUrUVwBo4XxPjlkazoAS4h6kGrnp7h/1FcU9qVjOigg=;
        b=HMDpmYTsL7wfLuI2ZrOdQKD7Ki/bZQb3O9BwzCrTnufhnVOsKi1xOh/JEdGsgq4lEY
         KXOwki52zWzIRRkJXS4VuX+/9NKT5aMXBsKpqjtbiANUq3iGGs0d5on3a+lZSAgSoBbI
         P8Z7RSOHrNFknVOgoKWo+n45E6JceT9rmO74sa+OMS3/Nn5ts0GI5FIb7NFPtmGATrVV
         I6MLpwJlh+lYyFNXMxjkOw182VJj9shqKX97SKSKrcRQBS09TKGxzU8Gnyja92TQXEll
         tHHy0j8tTRWJSSgzDqdi0bCThSOQ/YEXHgxvbG1yAGVITIQvi005YExn+tfdGffVTLzs
         dbxg==
X-Forwarded-Encrypted: i=1; AJvYcCUnFXE0Kyjxy8R9dweqg2wdltWjfiFGPLBR8wyjhUkMy4b4t5ghO27KjQm6pRhBEYPNR2kEX3MKF39BO3z/@vger.kernel.org, AJvYcCXmboJzJ1aLEEQvwG5AQjfIy8ODjlGuzToVRGOhpIIKN7z+rZxitZrEvrwKv/byweVFJT9aW8ENqa1YPFdh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsn7/J1/HoIoxWjmTCSFtSMt/La35Rft5GLlcmrq2SIxuB5um8
	c56pgHWRfbfTgsikJ+xe4ZGoRgFJyngagN0J2ul3SmPE0nbupU7B
X-Google-Smtp-Source: AGHT+IEmnMMPsdelV/V/PG0DRmKJhSB4OuIOdsqaA4YHEYyzfR7yABVt/N/ruR2LECG+LHaZQ1GuBQ==
X-Received: by 2002:a17:902:ec82:b0:212:46c2:6329 with SMTP id d9443c01a7336-2126cb371f5mr61197935ad.47.1732183544931;
        Thu, 21 Nov 2024 02:05:44 -0800 (PST)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21288400139sm10024715ad.252.2024.11.21.02.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:05:44 -0800 (PST)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: akpm@linux-foundation.org
Cc: jack@suse.cz,
	willy@infradead.org,
	jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic into __wb_calc_thresh
Date: Thu, 21 Nov 2024 18:05:39 +0800
Message-Id: <20241121100539.605818-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
The wb_thresh bumping logic is scattered across wb_position_ratio,
__wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
consolidate all wb_thresh bumping logic into __wb_calc_thresh.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
---
 mm/page-writeback.c | 53 ++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d213ead95675..8b13bcb42de3 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -936,26 +936,25 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
 	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
-	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
-	if (wb_thresh > wb_max_thresh)
-		wb_thresh = wb_max_thresh;
 
 	/*
-	 * With strictlimit flag, the wb_thresh is treated as
-	 * a hard limit in balance_dirty_pages() and wb_position_ratio().
-	 * It's possible that wb_thresh is close to zero, not because
-	 * the device is slow, but because it has been inactive.
-	 * To prevent occasional writes from being blocked, we raise wb_thresh.
+	 * It's very possible that wb_thresh is close to 0 not because the
+	 * device is slow, but that it has remained inactive for long time.
+	 * Honour such devices a reasonable good (hopefully IO efficient)
+	 * threshold, so that the occasional writes won't be blocked and active
+	 * writes can rampup the threshold quickly.
 	 */
-	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
-		unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
-		u64 wb_scale_thresh = 0;
-
-		if (limit > dtc->dirty)
-			wb_scale_thresh = (limit - dtc->dirty) / 100;
-		wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh / 4));
+	if (thresh > dtc->dirty) {
+		if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT))
+			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 100);
+		else
+			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
 	}
 
+	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	if (wb_thresh > wb_max_thresh)
+		wb_thresh = wb_max_thresh;
+
 	return wb_thresh;
 }
 
@@ -963,6 +962,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
 {
 	struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
 
+	domain_dirty_avail(&gdtc, true);
 	return __wb_calc_thresh(&gdtc, thresh);
 }
 
@@ -1139,12 +1139,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
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
 
@@ -1215,14 +1209,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
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
@@ -1478,17 +1464,10 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
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


