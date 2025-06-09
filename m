Return-Path: <linux-fsdevel+bounces-50957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5CAD173E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E61C3A9C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 03:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C111F22ACD3;
	Mon,  9 Jun 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wse6I/X9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F76146A60
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438504; cv=none; b=cL/PV9GEeBRJqnL08EXBJQydjqBF/UwNCwFRVMqDqlrccNPOp9FcpW6mOCuUb4/ewysi6hHSBNrxghqM9cD0D2HC//Jl2lAjbnpby82AQiVUZVUFmfhoi23zAa/b9w2z6KHq4785hbLE0P7ZVddAQEYkq2/37rxLqqLxjmCPheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438504; c=relaxed/simple;
	bh=Dz4BZOwoG735qXr2NNfV+1SB9IWMabweHe1jjafLKJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1tdmk+kYXYPhWg0CAm0dtQCu4/WLSkcdRR6jE30uxdRuEitCNpAD0QfV3bWDOLiaLkBe1Fq3sMHlEUdospn5NdmDiZ5ucUmI5myxiw4dzwLHj6ZrM1h/Oqn0mVnoxBXpx8Wghyi7oxv362CUxecgb1TRUxwnGHzMjZHA9x4ObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wse6I/X9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231e8553248so38013785ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jun 2025 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749438502; x=1750043302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJ5ljUqUtBgUphPBwqwQSdecLwZyYNnXtwMirJ7OhPU=;
        b=Wse6I/X9xYMqeixoJ4K8q+Iay7y9BU/jgq7klubxhKbW9OLhyTehUqB0Fqj8EDKK2c
         DQi8RxDnU0dA7GJcOFcIANKwzs2upQLVW89jSZvazsjZEzFdZ7sbObBIJKJysPouR7f7
         qkF0bX0PHuva7GYu/+dLuUDTsoFIYqHXfkHIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438502; x=1750043302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ5ljUqUtBgUphPBwqwQSdecLwZyYNnXtwMirJ7OhPU=;
        b=wziBGjlGqXp8d4kl8t0pvyR8xmh745dXnwp6jVEn9+KFpXjFsm91oOXVcCjg/k9Hku
         wZS7BEMqKu7TJe+da9bl70AiJccRh8xScuqSC+p1wLQpKmA8JhoyP1M6yPgGlYjpqAlP
         DfIEy4LA6gZwPoT4b0z37iEUevHSW5HtJvwUX1/az/+yu6GzOiXpzyrB/pg5EOM7Bv4W
         G5UwFwHu/S9XbJvuOIhY+pilh2zC2CIKsGDWzITzjVPF27KqAjgyuueYGcZLe5CXa/W9
         m63vAUbuMAwhjGd8YCniO+SVHNeq1yjr45wcMQpkpXzeRrTECXjOnDX2CtjHhxVI10cS
         Hmlw==
X-Forwarded-Encrypted: i=1; AJvYcCXxIJaM3r9+Yn7W1/iRIAYME0aFZaDUS8/z1wGrOGM1oNd6RIJkicm2d4VsrxOHnLXy8Ak4xpjVyfCMvgLs@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBhXwSWXQBcombi/LyDm37iQAGKs9qUVp9uhvNsS6w169MFR/
	NSzqX7BkP2gJXGhchGM/gDgoCUnrguc3aP21PYYPMIXGAqxos2gehQUZLQyh7W6czg==
X-Gm-Gg: ASbGnctFxI5kO1NjorEi0GzcUDPLaz5roMgj7jisPy6Wf4lTW49OVzAdV2jAMRV5H4x
	4yCgBq8hxgEsNvyQpAi+d/Elq5RU1ZJLsu3BGi/fmDINdNdDUugNLI1I3vdtDnnsqFqvnrqhoRm
	TL2D3ctiKB6G6vd5ttgydGweVG7VrMKqaA2Hn1CCX3eBnU1kGWA81Q0t5asjRhEJ6DRHtLUSga+
	fh2dX4/gjoPPxycgdESNXpv3ng9s3LHsiUIpEx1M4ysEtt7ND+e8BQn0B5N/sxs0ZiBLtc5lAhd
	WSyzJh9dffjYXPFrGhhbgn4BZJIGUPc+QSCIu+yk8KRJtNWISUeSW31JXGD4aaVSnfMw3pI5quM
	dpA==
X-Google-Smtp-Source: AGHT+IEZ/QggHpe+SjR545m8B1DjwJ23ZRKmlr+YvhhI7qVFUYft9GGSA1OnQ2N5skZa75gmHXfC2w==
X-Received: by 2002:a17:902:db07:b0:234:a139:1203 with SMTP id d9443c01a7336-23601d82d1bmr183050245ad.32.1749438502124;
        Sun, 08 Jun 2025 20:08:22 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:eb64:2cdb:5573:f6f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603410716sm44649645ad.199.2025.06.08.20.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:08:21 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/2] wait: add wait_event_freezable_killable_exclusive
Date: Mon,  9 Jun 2025 12:07:36 +0900
Message-ID: <20250609030759.3576335-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a freezable variant of exclusive wait.  This can be useful
in, for example, FUSE when system suspend occurs while FUSE is
blocked on requests (which prevents system suspend.)

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/wait.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 327894f022cf..b98cfd094543 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -657,6 +657,20 @@ do {										\
 	__ret;									\
 })
 
+#define __wait_event_freezable_killable_exclusive(wq, condition)		\
+	___wait_event(wq, condition, (TASK_KILLABLE|TASK_FREEZABLE), 1, 0,	\
+		      schedule())
+
+#define wait_event_freezable_killable_exclusive(wq, condition)			\
+({										\
+	int __ret = 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret = __wait_event_freezable_killable_exclusive(wq,		\
+								  condition);	\
+	__ret;									\
+})
+
 /**
  * wait_event_idle - wait for a condition without contributing to system load
  * @wq_head: the waitqueue to wait on
-- 
2.50.0.rc1.591.g9c95f17f64-goog


