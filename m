Return-Path: <linux-fsdevel+bounces-20290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD68D109E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 01:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC89E1C21974
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5834013C903;
	Mon, 27 May 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zv3Fm8NW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D313C3E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853523; cv=none; b=WkdeXFtpA/0sUzinjoLuWhJxinESr+BmD6CSX3J2zfnpEUPT28uw6IkiFCaWnCOXhNvPPG5ow7S3J5I5lINuNamvfmeTVBIlnV500TRWBRdffDdDEa5uEX/rK56wLKtwmnLVPjmkQo135m1QufC0xhRQObO1DZ5Tllc0EUde2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853523; c=relaxed/simple;
	bh=DukxrWCXAjyyH7zpUw9lAqh0pCE9UlNjO3BaKcx0yMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9SkmlfHJC0Num/Hibd+H4NP6L0SAeNmlL60BlggtKtXODJHRpGaWZbFuxEEpYvtLxRYw6OlbGXQaqVdbL5/Zlw42vYuM281hNBPFC2iOz748b6+sNyNWVkiAbPdKxjRYFDPima8YwkD30WvK7/77d4GArMmNMiwldYixs/Eq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zv3Fm8NW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354fb2d9026so192592f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716853520; x=1717458320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LabiRKd6+Fdc1S9teFQ4XXd5rRTCMDgsFOfIBlpIeJQ=;
        b=zv3Fm8NWfLrh94W5mbCakfMstwMO4wu8AdTeDfEvLpZSjKRj/4qeCIwudlWxcYS8ol
         p/Eb3wAeirABuNhlt5fJ69Pbrl6sTz4RECNH6BHdBgfxzo1Oz7afBzHmRWPChALa+v6n
         gIHFNppSN7onGqSKdvk00hjjUaltzuTdP5Oqmy7Lf0gaZ/fjX/oc8+6LY445PtIwURfp
         vVhZ1EoHqaVsXZRy3MdTpqE6o4Rf/CSPIPS93M4nXMU+0lBVSz63EvB9IDGG4SJOGrK3
         eKuNQaKYD6iobPN6WcIeIIJ+w552eGfxrJEh2VCugtOCUIddCiifv/EXBboMlW75GA9C
         kQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716853520; x=1717458320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LabiRKd6+Fdc1S9teFQ4XXd5rRTCMDgsFOfIBlpIeJQ=;
        b=nAqEMMD9Qs0Jop7Uq6i7ZFt5pidwVXzAYtlAczjzOHAEOsIape625E9u0BVSEqB4nO
         D/lnqHrJsNVqNhTv3QuQViMP9z4JsFsl96reJmSCONJqcLce0WdJNVBe5bEWGCTr+mbf
         zQv9Zjx1HMTG0fRArVsMdNDQpXfs/oHWNStUh5ll2ODR3Ehr/3TnVJ2d0uAjEQsJfwzT
         qgplluwHcqv+R4S70/w4RBXT3TnBjALDMbHvsXsywImsdPsP7ZV130ARmkdzH5ZF5GUt
         Fq3RFgxD61oKKnHsgoDUxN6QHLPrBa9P0qsbd1lO9V9LagzZWWT+a+3YJljvx8RNm4vE
         iL0A==
X-Forwarded-Encrypted: i=1; AJvYcCXLYTQdEEMCl+hfdsVvYJFSx5xBlXvw8XXMAWrIpAm94QHbrFK79yI6xktZYWu1+YItrGNu76Tc1Z18WdzNxgDcQXTKUcBL89FL3i//uQ==
X-Gm-Message-State: AOJu0YyflfU1GdOn84UcAQKt5mbnZwjdzVPZtOyQ7HQVj2vtSjGl785J
	lqL8mTxQS5rPBg4q6KoM3oqM6IaI0J1WhdrHVD2ii3pB06lczkjfxTnvp/oC10U=
X-Google-Smtp-Source: AGHT+IGy/gagOKc04QMh7vQyWY1fx5jjEL/7vEbfZ1S7DNLjj4/0M9wIHpNhOOn/pNT8THqBrympIA==
X-Received: by 2002:a05:600c:3ca5:b0:41a:b54a:9ad8 with SMTP id 5b1f17b1804b1-421089fa29dmr70623995e9.0.1716853520726;
        Mon, 27 May 2024 16:45:20 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm123535515e9.17.2024.05.27.16.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:45:20 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 2/3] hrtimer: Convert realtime_task() to realtime_task_policy()
Date: Tue, 28 May 2024 00:45:07 +0100
Message-Id: <20240527234508.1062360-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527234508.1062360-1-qyousef@layalina.io>
References: <20240527234508.1062360-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Sebastian explained in [1], We need only look at the policy to decide
if we need to remove the slack because PI-boosted tasks should not
sleep.

[1] https://lore.kernel.org/lkml/20240521110035.KRIwllGe@linutronix.de/

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 89d4da59059d..36086ab46d08 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2073,7 +2073,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	u64 slack;
 
 	slack = current->timer_slack_ns;
-	if (realtime_task(current))
+	if (realtime_task_policy(current))
 		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
@@ -2278,7 +2278,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	 * Override any slack passed by the user if under
 	 * rt contraints.
 	 */
-	if (realtime_task(current))
+	if (realtime_task_policy(current))
 		delta = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
-- 
2.34.1


