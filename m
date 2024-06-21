Return-Path: <linux-fsdevel+bounces-22054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8AF9118B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA34B213D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD24129E66;
	Fri, 21 Jun 2024 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etnDdbay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16284A5B;
	Fri, 21 Jun 2024 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937147; cv=none; b=K0KBKwpe4qM0OhJ7PsF0D417IlaAF4vJkCEt8WErIeKenFrvdv8uCQhjDoTc7KRJ06aM4zAKaA+pU2cILuX4Kydv+aUITvm/A1bIdt9/8t0WwP4X7wwHRRv9KHatWxp3LTr8F7RAGBMKgaClvsTCirQySiJjpRpJn1zfYJQrqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937147; c=relaxed/simple;
	bh=/gCH7e28NIl/tMHPCXOAQ7VQOVOI1s0RashVXkQPLGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uG5EqVj6yOelhgPkz7D6VcyA5cY4K/djYXNzNwmetV38pDWS7UwujUUz0X+bt1IKwPgG1PnXTwCMNlEoou9NI9XWZmxftSJFhpIGj4dTFt8hfE09DOgCZSscHApcrEdimxCV0Qtqrd0z7ZInE1pzl3NwG5T0GhHvgbVe3RWM+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etnDdbay; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7041ed475acso1456251b3a.2;
        Thu, 20 Jun 2024 19:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937145; x=1719541945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQT31JSkonb7Xmqn+k1uqrjgngeoHr6IFKrX/+KN6Ok=;
        b=etnDdbayegwNamUecBGMT5hk8++KoNSMBt1RQmsSZ5IMNkbbnra959x+sdLt9ebQZe
         BM3dcDpezlRD+FvXG0ExYULCVI1AQgUQY2Yphq4Irn89kTXqx0shvTAKhXiHcv7RI79J
         wryCjJ8gsH6aKWCd/NX1VgHBEKUfg7WNcQeMZnnAZU40OG0KN0VvPsfxNUawKllfLlGJ
         0Abg6Vd45dXB2OyMw/rHdsJpAOvRdstbF0a9QPMDxs4b4FhXOlrrXV4ImjF9hRqiPObV
         aLKAdYjeUXhlaZgBzvnL38Ek4C6LQSex4Yk1TUVcpc28CV4g7cVd/bJYtJjZ5f36h6vA
         aYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937145; x=1719541945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQT31JSkonb7Xmqn+k1uqrjgngeoHr6IFKrX/+KN6Ok=;
        b=d0GjwgsH4x+BacyNzt3zTtJ3pXj0YAj5QdcJll6MeUtYzRkQDPWfCocERVXhuoo9gx
         Nxc8TUvgR98n9nq8lHpwEIUXK6yIwkB1TPVwu3olCClOzI1ZFVU5141B2Y9yKOMQkVnj
         5KWst/4cIhF3qa4pmZfiXifSmhYK0/2zL7ScBCKCc5l+SOkKpQh7gPJxwc0HkO6EqM46
         x5ntm0NIDXrhG9k/bjUzlt9UtjI7ySSKGOVVpKGbybN0sivaTDVM9ADAZ0+qVsqnmxB1
         W1Vpczcdw5XSiCOP57cwHCp9KsCkUc2FPQIUVTZNGyTWUaMIAWKszbCmROJ3INfANJgg
         f6zg==
X-Forwarded-Encrypted: i=1; AJvYcCUwryFs2ctgfS6B/qRjUbvslj+JxO9qTyWu4vwH4von3ABISx4XXo5je5vQurvvw8KhqlhaiShd+GCAko8ywvMw5g3RWiZM40kYpaXEJYJjieuMAp6lVB1oZbN9GVu6+VMCGyxBQT2/NRkiqBzOfoqtduILGWGFjQC3mGB/d12otQAl2nGiugzK6Zx1YewSxUsX0GPtlvjnEy4d068vtXceLQKFc8o0AOUNqsJ9WwScE2glPlKcg/Ui0b/v2Yq+Ljt2H3h1Rk4R1ISz2BbEW3afSF50uO+6vSIeDiPUkW78gxAWcVdP35tCavl9uUGrgoJBtVDjHg==
X-Gm-Message-State: AOJu0Yz4ekLuzxJz8j4uLlgRWj11H4wDQoBqP8ygcnh4HzRBa04A6H1V
	X1bOY5ag/FKFHCqSj4dhO3xzTsxbuFTJkyNfBkUBNQBMKouNtmdR
X-Google-Smtp-Source: AGHT+IGhhQvd2U/sH2KdV0ZtBjJthL8CznXxKI/3OBzCZg9mpyXqgc1aLbbwbnNImYe317PDiBUknw==
X-Received: by 2002:aa7:8b0f:0:b0:705:d9e3:6179 with SMTP id d2e1a72fcca58-7062bf98e16mr5991736b3a.26.1718937132481;
        Thu, 20 Jun 2024 19:32:12 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.32.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:32:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 09/11] tracing: Replace strncpy() with __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:57 +0800
Message-Id: <20240621022959.9124-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240621022959.9124-1-laoar.shao@gmail.com>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/trace/trace.c             | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 578a49ff5c32..ce94a86154a2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1907,7 +1907,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	__get_task_comm(max_data->comm, TASK_COMM_LEN, tsk);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..721d4758a79f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	strncpy(comm, task->comm, TASK_COMM_LEN);
+	__get_task_comm(comm, TASK_COMM_LEN, task);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
-- 
2.39.1


