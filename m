Return-Path: <linux-fsdevel+bounces-20291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13BD8D10A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 01:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86592834DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69713D50B;
	Mon, 27 May 2024 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2rH9TvBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AC13C8F0
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853525; cv=none; b=KjVxq489c8QaCSRepNKPuxw9DGapbbOZfUjq8ZP1VEci/Co7Ux6t8UPlJhZbvjB1WoHicKFdHVrTXWAL1i1FlY9s0tzgFpVHYCHWDGMI0ft8IIb2XbVHJ+udzSHFrI9mCoIGUvZnmCLCAHX5ShrO0QBuZYdERmQd06gfdZp9x4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853525; c=relaxed/simple;
	bh=r0I8WXwNICm+VrTNgL8eelRj73Nyj9XjwKgQCzzkGQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1Tju5bKa8TZ/bnpzu3L7R/IFZ0UvFkTcVjrkm3cGceZoqCBotHCv3llRg7QnkmsaCFZ+9EB0TKhPq94t4oHPFdMtBrdqLmqp6kFLDCXYlx5FmonXDH/aMr3cA7o1YsFnFk8hIQy+lPwf+6YCirPqgCmKiOoIVsDsdtMbIyFzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2rH9TvBr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4202ca70318so1537165e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716853522; x=1717458322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNry0zoFn66IZX3uvbz/6TnygFqmohU9To85tOy+8kg=;
        b=2rH9TvBrRqNzcLEKK21rk6S/c+QXXj2gqSEPIyh8sNmiy3zeDm3gUdpztHFbZhZHmD
         yhx/Wg3cDw27AnbePqkwu3LuiJOQ3krGbAlnkFoM6KdEHfDFP7gl8oiVGBrp5nIQA1gb
         u7wgu/7fUCvP87v+xsOw1xBrBrrL0qim/PHLSl48pUZ+YdmBjquQUmcIxr8hY5HYbqeU
         4aR+01b44BbZZXrSHGXzfM1IXfCVED+Qehmh5SihlPKTn+6S2N7qfJNnyXMiS63ovd54
         JgyhQzFuEktQKRUlpnIsQdBbwi8kHmhQ9kCbTTIpEj+gNrVPH6AmU03oryn6iF4sJvQR
         TtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716853522; x=1717458322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNry0zoFn66IZX3uvbz/6TnygFqmohU9To85tOy+8kg=;
        b=XRD5qGZN6iYZCDjpzmawOcGWY4aCbVJRIJ64cjLc6Q8GhIabQKiMRIA66CMaDBOzEz
         i18j5xHEnCQNLHrjN5pzvmDuezTvUvbs/zCqmejot8PeRD6A9S05PKQ+0aZj0YRScGhH
         2A5CtQayefRgGgt4pqkXFqLYfjgx0gyk9mYFkgbATE836ZBrYjGL/qVyfPPPlXMV+cG/
         pysYmNfg2J877DKZTk7ylhdeRavDjybV15LKzESRuvYPg3CNWVdAi8+4COH2qYCzDfOW
         LKBs9yL2EUe03QmJnN/3hko+9OjJN4hCF25BaNghtw1A/12etISY9Yx2kDqkExW1vNmt
         zY0w==
X-Forwarded-Encrypted: i=1; AJvYcCVYbIk0waRF1JCD0tm06L2Hnj+pKNGlI/zfy0vTmruMEA1+RFh7MWcrwzqn89boxbVbJekDdTpXgB8gKmoeOqzO5x66dPwGXKoi7yRdyw==
X-Gm-Message-State: AOJu0YxDDJacLswSD544NoafzLQ8Dy/ikHgmgiBj9CKTHu3gVTxgCbxG
	d5zp/7LD0FBTvyZtwNCKGb0wngTaQOg78z5ostBqzV8x5rUYBrl9ZpMT4W/FgnR+nxdjrRQ/y2o
	3
X-Google-Smtp-Source: AGHT+IF9T8Y/YkvAOvS0rS97TuRQ2Ix59hiyfEGtGD745/9EUk8XFN2C3Rg4A4HSPq7FUd53hxMojg==
X-Received: by 2002:a05:600c:4f94:b0:41b:fea6:6526 with SMTP id 5b1f17b1804b1-421089f8d2cmr66410055e9.33.1716853522480;
        Mon, 27 May 2024 16:45:22 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm123535515e9.17.2024.05.27.16.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:45:22 -0700 (PDT)
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
Subject: [PATCH v3 3/3] sched/rt, dl: Convert functions to return bool
Date: Tue, 28 May 2024 00:45:08 +0100
Message-Id: <20240527234508.1062360-4-qyousef@layalina.io>
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

{rt, realtime, dl}_{task, prio}() functions return value is actually
a bool.  Convert their return type to reflect that.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/deadline.h | 4 ++--
 include/linux/sched/rt.h       | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 5cb88b748ad6..87d2370dd3db 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -10,7 +10,7 @@
 
 #include <linux/sched.h>
 
-static inline int dl_prio(int prio)
+static inline bool dl_prio(int prio)
 {
 	if (unlikely(prio < MAX_DL_PRIO))
 		return 1;
@@ -21,7 +21,7 @@ static inline int dl_prio(int prio)
  * Returns true if a task has a priority that belongs to DL class. PI-boosted
  * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
  */
-static inline int dl_task(struct task_struct *p)
+static inline bool dl_task(struct task_struct *p)
 {
 	return dl_prio(p->prio);
 }
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index a055dd68a77c..78da97cdac48 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -6,14 +6,14 @@
 
 struct task_struct;
 
-static inline int rt_prio(int prio)
+static inline bool rt_prio(int prio)
 {
 	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
 		return 1;
 	return 0;
 }
 
-static inline int realtime_prio(int prio)
+static inline bool realtime_prio(int prio)
 {
 	if (unlikely(prio < MAX_RT_PRIO))
 		return 1;
@@ -24,7 +24,7 @@ static inline int realtime_prio(int prio)
  * Returns true if a task has a priority that belongs to RT class. PI-boosted
  * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
  */
-static inline int rt_task(struct task_struct *p)
+static inline bool rt_task(struct task_struct *p)
 {
 	return rt_prio(p->prio);
 }
@@ -34,7 +34,7 @@ static inline int rt_task(struct task_struct *p)
  * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
  * PI-boosted tasks.
  */
-static inline int realtime_task(struct task_struct *p)
+static inline bool realtime_task(struct task_struct *p)
 {
 	return realtime_prio(p->prio);
 }
-- 
2.34.1


