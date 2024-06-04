Return-Path: <linux-fsdevel+bounces-20957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107E38FB619
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE67D282D45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6C14830E;
	Tue,  4 Jun 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="DmIt4Ukh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086C1474D6
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512168; cv=none; b=Ynt+dV2mzRz01HyE3NM3iInKU+hoO08mxzwVVt6VTnvFS0PO2XWVO8I4mLmsROTscxiN5CYz/1i3DsLCelnGJEP5Cwl+sh78ktErbUIDm2tgBlqgOv2MDBbeCRuWb+FcSAZc+1SFZ95FvcHNQtkZwFmJpLTxG9U7z+DvyA7ayBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512168; c=relaxed/simple;
	bh=7We/+tZi8h0RWf40KLSzJGP5wUTKovwlp/wvAjS926c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vk9EIXtBkbasXVBmRzOo4rxWcEk9j0hdvC3ypJ1qmPmRznooS6w9Wf66kPzgi5i6uSLNl/l/vKfT2HknzZnTvQtC67EdzwNK5Cfw0aLsSRc92eqXqQpLiwfQ5edjI5oON8EHzdJzMHyKzhunkbH2nMOh4xTNgmo9IPx5A5U6ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=DmIt4Ukh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so33107405e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717512165; x=1718116965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRCAwCBL+BIsgnWJn4hsN99PIDBFtmRQDHcbx/zD1tU=;
        b=DmIt4UkhLwC8rtxLkxM7bGgFH954BKTMZhTPZaSEcHrERHxWy9h47WRdVFav76ngzA
         N4TbD8E8PJhhUXCbm2cxtb8IV/B6QmlKvRZXVKEMqxeOjX4rifAWR+leOYyu9sp/hlwb
         t9pEQfCmkI4l6mTnLXBdnvln5DaWxQY/yHaeIzYftrB+9DbTrIxCC5mWWtJ6+8uwvqFZ
         HZ4Q0T30kIfNZjHYvQY64/MxNIYuCbAnsAOeI/Mfp6oYbzxdaNo+rwA7Pufcc7/OQOUu
         scJZCBufwTFYegOoF26SwDL6pabdr8pfF+tOjDfSNa9MCxaci5XDF6C75wNJ1jpPKarB
         5tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512165; x=1718116965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRCAwCBL+BIsgnWJn4hsN99PIDBFtmRQDHcbx/zD1tU=;
        b=CogxrPdXT+NRwd4NFJ8iFGc1+u7nx61TPMa012v0RZU7Y8c5KvBK34BzCoT3ycppSD
         7PvMGYpRja5Bvk7GlrZUT2w8etjNFzUx9vR82u6RGCsYLgOCNLPN06s0ewCbWvSUi4mG
         ahhjeRnJq3XPQx7vBzM0RCIIPmjWzpKKtcRb2tSOLIfutoa4GrKMbAdRYWWsAoARFQNQ
         qg9YL9C73/hDbXUP7mwB3ttRbsIzz7JBeve6YyKnEqT/8cz6xNk4COaMlAj7zji1no7M
         lTK1Sbz3er8XNBnqSDeO4B+/9SsZidel13ryphHfu6DiUbsr1i81sdolKFSR00LGiOtT
         rX1g==
X-Forwarded-Encrypted: i=1; AJvYcCXxfzihmzlkiysa1nJgpfiKwgqDqgwElXEVyiJ0TR420TeEN48uFyzPc/eeYlfIYT/lFCpy3vXEwAZbDMpC18+39cuST4evuNI6cUoBpg==
X-Gm-Message-State: AOJu0YyeIeIyuumZXBByyPxW4C+MBmPkmYiH9JrmW5+BKdNQ+DQgLx6x
	DRdwCsbpoK/mlFSHxkRJt052/oP1wjjAniVCT14H/TZ5QV9eUArtlVIQyUW9gi8=
X-Google-Smtp-Source: AGHT+IH0BLezorijkm6LilA7yxfjptfWPVcGAoCl9lPMtaigyEyQH11++G7gyrhU4E3tJmmgdakkBA==
X-Received: by 2002:a05:600c:19d2:b0:420:1a72:69dd with SMTP id 5b1f17b1804b1-4214511cb66mr29747005e9.10.1717512164925;
        Tue, 04 Jun 2024 07:42:44 -0700 (PDT)
Received: from airbuntu.BoongateKia.local ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213eca8a51sm62423295e9.14.2024.06.04.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:42:44 -0700 (PDT)
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
	Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 2/2] sched/rt, dl: Convert functions to return bool
Date: Tue,  4 Jun 2024 15:42:28 +0100
Message-Id: <20240604144228.1356121-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604144228.1356121-1-qyousef@layalina.io>
References: <20240604144228.1356121-1-qyousef@layalina.io>
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
 include/linux/sched/deadline.h |  8 +++-----
 include/linux/sched/rt.h       | 16 ++++++----------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 5cb88b748ad6..3a912ab42bb5 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -10,18 +10,16 @@
 
 #include <linux/sched.h>
 
-static inline int dl_prio(int prio)
+static inline bool dl_prio(int prio)
 {
-	if (unlikely(prio < MAX_DL_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_DL_PRIO);
 }
 
 /*
  * Returns true if a task has a priority that belongs to DL class. PI-boosted
  * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
  */
-static inline int dl_task(struct task_struct *p)
+static inline bool dl_task(struct task_struct *p)
 {
 	return dl_prio(p->prio);
 }
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index a055dd68a77c..91ef1ef2019f 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -6,25 +6,21 @@
 
 struct task_struct;
 
-static inline int rt_prio(int prio)
+static inline bool rt_prio(int prio)
 {
-	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO);
 }
 
-static inline int realtime_prio(int prio)
+static inline bool realtime_prio(int prio)
 {
-	if (unlikely(prio < MAX_RT_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_RT_PRIO);
 }
 
 /*
  * Returns true if a task has a priority that belongs to RT class. PI-boosted
  * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
  */
-static inline int rt_task(struct task_struct *p)
+static inline bool rt_task(struct task_struct *p)
 {
 	return rt_prio(p->prio);
 }
@@ -34,7 +30,7 @@ static inline int rt_task(struct task_struct *p)
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


