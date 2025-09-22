Return-Path: <linux-fsdevel+bounces-62378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0DB8FCE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA3B3A7FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692282F617C;
	Mon, 22 Sep 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a6MuXr9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656C2F5A1E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534123; cv=none; b=ECnwAb/sko4lMS9dhp70vQHEXQNEmo2BihUODBv8koSBGDZYzAEGw/jYv0KmQJwOEilR9lDCPO0oxYF2Pm7C7MLf5HpLEnuPBs7BgGUDRYFLhFDYh33A+h4W7oMeZx7RkU+KoeFYpymHb7djB3mFH5r3hwqBrgMbdCV1klRPlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534123; c=relaxed/simple;
	bh=w2CQvHkt4M2gPEgsJ1Jr/TEVOrRgfKToXeIBZjuqn4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQqq98RqMroyLK2ARXXA9i9XcaPmBVfa+QpCyrMRTGhgzLfJow7vNGmOvdQXppY4G9xmGxLa2oknrvreywZA0EfBhS+E07cNa93LLx4P4pXywRCPRx8ut8E+Bx1/VPs+KZiiDydZdPePoyWQoUH8UgxJo84/20mn4x4oka6e5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a6MuXr9y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-278bfae33beso6599105ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534122; x=1759138922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOurKnsAQJhq1MI/K3lsAX/7s+mLOF8dCVHDunK7rpk=;
        b=a6MuXr9ymnM1X9xenimqx6UCDnN7iJ0GDjJJaHa/S1t3Qde5Ch8jGLWhUjlqyUhOhQ
         eerJxUMerpruFgqB1JI7B2pGqCPOnlPMd77gsMe9jKEx154XpiVr7z6u73rrlHdAShbP
         aCHMPyTFHyYiqR2Wm8SyIAlLMw8oo3wLfTYmBdCKnJ6xzaNxXJq0cTgshrJI01+/46CY
         8Od4hfqX3j9FwTLVccGQt/6Wm34dGasjENc0P8yc11C8lX0v/VqYSRg7IOY9dC4lQodg
         iXYPFjHz5ub+2ZblMo9J8W9wQSZFYKtrVjRvRqNWMigcwAxpMh5r56N1V5d2h0PLTP0d
         KhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534122; x=1759138922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOurKnsAQJhq1MI/K3lsAX/7s+mLOF8dCVHDunK7rpk=;
        b=LN12TuhCGPLHm7ScjbjqvdU3caa7nXlBN1CMxQ+v/ZxI9hHn34SmBB9GhlCS9omqvu
         LY6PLVYNKyFiP2HlLI1abIRs54PHSCikKbDA8ASbmPBwAle663FMzVxsUNObHlAfLyO1
         1FUK1ujR+ClcmGHgLTvSpGHLTZeUyZV/hD9lGj/C8TOHVLUx5CAn1sowas6JTXlrgu4J
         YeWBTDBYl8TNtJPdN8QK8txjfDHIXgMCwAZmyyNNwf3+ciT6CxFF1JXyccrFnFWI6B+G
         HEmz8Ye5DBZ4uqthg4l7QFLWc5X7teBOx5vrqCQxfMH2juvTYK+d1wj4pLdXMNRAWDu2
         8MXg==
X-Forwarded-Encrypted: i=1; AJvYcCVYlnfg3OuEDowshU5cTRHtr24i4SO8TgJdobFpuVnff7nCNIxw1evyEbReIeENirmkfS0jRs7FLroL8BpF@vger.kernel.org
X-Gm-Message-State: AOJu0YzGitxWEKPv0+UGEaxR0GM0u34/5GW59UQMycUJaA15rAoTDBtd
	L1boLerNntGfkXtN5QhbdmmS4Q5TZDA5hUid+BorewRP0bJQwiGOIS9NVNVQNvnSgKHFc9/KLkZ
	l0T27Ics=
X-Gm-Gg: ASbGncsiQ9Enu2mAttALHoreMHBL8c6xCcpC34TfThM79ZFj/z8HP7jc+fQ1iXaGyJh
	o5MY4gN02CO45luLNmYPWF9BqOWg53wN27+mVyl5BkDmHB80gSJDjt9325tN5JdRf53CO59fj+q
	XkQO8T3PyEfnLnXC1WuAKeqTPgmkXbEyaycWJyQD4oti5MPKD1poN7NMQ2qGilZAsmAtlf1zS5U
	YzvQMxhLK4aVpWIQAPyJyDurYoj0O50OmgYNNip+iCPiDGfQdQhHe2qsKDEAsUjj2paAn75si1g
	DeuXiB0uvxM8xugrZ7iKAeWMgyFZvE8pVU/qElv+58WLKWJJTmdt0cYyFap+gheGjpU2LxFAEc4
	4VB0FKVzrNjm7lTXs2Ci5YVOZnoz9MtC8vG2LFA==
X-Google-Smtp-Source: AGHT+IEYZ/C3dL0qp2wE+58Yl2Bn+i2OwzxTRskr6Hw/lJro+/C/gVzHqm7+saAW2gcX3d53cPh8Dg==
X-Received: by 2002:a17:903:1b68:b0:266:88ae:be6d with SMTP id d9443c01a7336-269ba3c255emr167678175ad.6.1758534121484;
        Mon, 22 Sep 2025 02:42:01 -0700 (PDT)
Received: from localhost ([106.38.226.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c098sm123997705ad.33.2025.09.22.02.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:42:01 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 2/3] writeback: Introduce wb_wait_for_completion_no_hung().
Date: Mon, 22 Sep 2025 17:41:45 +0800
Message-Id: <20250922094146.708272-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces wait_event_no_hung() and
wb_wait_for_completion_no_hung() to make hung task detector
ignore the current task if it waits for a long time.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c           | 15 +++++++++++++++
 include/linux/backing-dev.h |  1 +
 include/linux/wait.h        | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..eebb7f145734 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -216,6 +216,21 @@ void wb_wait_for_completion(struct wb_completion *done)
 	wait_event(*done->waitq, !atomic_read(&done->cnt));
 }
 
+/*
+ * Same as wb_wait_for_completion() but hung task warning will not be
+ * triggered if it wait for a long time. Use this function with caution
+ * unless you are sure that the hung task is undesirable.
+ * When is this undesirable? From the kernel code perspective, there is
+ * no misbehavior and it has no impact on user behavior. For example, a
+ * *background* kthread/kworker used to clean resources while waiting a
+ * long time for writeback to finish.
+ */
+ void wb_wait_for_completion_no_hung(struct wb_completion *done)
+ {
+	atomic_dec(&done->cnt);		/* put down the initial count */
+	wait_event_no_hung(*done->waitq, !atomic_read(&done->cnt));
+ }
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 /*
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..9d3335866f6f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -40,6 +40,7 @@ void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
 
 void wb_wait_for_completion(struct wb_completion *done);
+void wb_wait_for_completion_no_hung(struct wb_completion *done);
 
 extern spinlock_t bdi_lock;
 extern struct list_head bdi_list;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..8f05d0bb8db7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -330,6 +330,21 @@ __out:	__ret;									\
 	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			    schedule())
 
+#define __wait_event_no_hung(wq_head, condition)					\
+	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			    current_set_flags(PF_DONT_HUNG);	\
+			    schedule();						\
+			    current_clear_flags(PF_DONT_HUNG))
+
+#define wait_event_no_hung(wq_head, condition)						\
+do {										\
+	might_sleep();								\
+	if (condition)								\
+		break;								\
+	__wait_event_no_hung(wq_head, condition);					\
+} while (0)
+
+
 /**
  * wait_event - sleep until a condition gets true
  * @wq_head: the waitqueue to wait on
-- 
2.39.5


