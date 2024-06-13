Return-Path: <linux-fsdevel+bounces-21591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92D9061F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD631C216D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D712F385;
	Thu, 13 Jun 2024 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahzSj4bB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DB33F6;
	Thu, 13 Jun 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245927; cv=none; b=rtnM8D1ISiJzlH7mOuamF7xz0okpX92qVf29ZX16hVOJgSaTA15NEnQOM1zyPHKGXOZA3jQ7D14kJrmtyx9sbfUflsH3uxPXpKT9i9n9lFYtaR6MbcSVTHHnPSLB/KTElrq6c8JbV1OlzfrBE1bm1ZamzYyYq5yC2Af84PcuDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245927; c=relaxed/simple;
	bh=/gCH7e28NIl/tMHPCXOAQ7VQOVOI1s0RashVXkQPLGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1i0nrn7v77gD3XrP28ELMMTCieUhDGlOIBGGuFAcErBm46P/dWu6wwnX8jVo5gbgUxEyurj4X9WwL5CrEEqWxns7l1RB/qRnQxkJuvh0lFjmSJT9OkEbbaT/QSKqfJaKL4JkHcvEQeUi3D9TX0mdSv8LKiBE81h6z9JMV5QTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahzSj4bB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a0050b9aso4929575ad.2;
        Wed, 12 Jun 2024 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245925; x=1718850725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQT31JSkonb7Xmqn+k1uqrjgngeoHr6IFKrX/+KN6Ok=;
        b=ahzSj4bBabw5mTPe2ui8++fY3UPhZ4793SJtyzsXDMY4mm/KVBk3Xiy7Ik3mY+U0VW
         yllAsNR9DdOs12k/b8ivorcWkdiGSlM3qW7l0koN3NytmIekX/VFRR2onZhvPVaJxyYn
         0Cybg1pVvcgAUWPJEaIRZPm3ThoCOqRZyLj6Vqyu+WkDyS3hiVj6mhPQf0gWrJxFrme5
         pkMYT+yAmZjk+ECzN+PQUMOiACWVjFTBjedbyOh+7zkMyZP49fAnidhYCCAik4ZEi73H
         rusWyGDmssIQVQoc0TNeAuNn7HtDAHGSkC7Jiuk1rmTsAWs8bEXFcWlkwDMKXiH0fAWI
         PQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245925; x=1718850725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQT31JSkonb7Xmqn+k1uqrjgngeoHr6IFKrX/+KN6Ok=;
        b=YfNzyC20TrQg7qwea8UixKmh6yCy/Dn4AVm6GMeL5qXv5XguKOtcEMlfHZaKt8Yofh
         Dr4THKp6zaZ6FNrjIjlpaC8mRown8wwb/RgvoNxl0u42PMUJdKZx0/0M/h1mxdOxXJ15
         bn1ntBTP29mJR5guzvm+KeOmq9KiGlH5cRvhtJ7oD6d53QkJDVLkEvEWMLvlSsQ8qYYL
         DK8i7PTB1SYVpCH8NCstzuxGZaXeSQz5enrd+00BMMRrU70xut2lvm3PNPAgZcf36ucH
         txvLmfyxQAPE3lRnGJpppfurgqPLE+DWjMkQObWMjD4GeUCDZK+WQ7OuHxB2GqNXQleN
         5xmg==
X-Forwarded-Encrypted: i=1; AJvYcCXpdo++oAtSQzFhaNB/0+QScE5PcqNfkUBWD1Wq8ETdrhB+JGrqaM7W3jfRs28v0b+ORw37rLi5fJxJkGHJu4VwOT5QltjmYtjKvEuNv/lxQ3MC+E6QnUAihy26esSQeRhKG120M1lVBv29rVULkqFQjcyExrV9IQuYyJtxDZNJslxeodW54vlbsu9FiNkeWSN/883uHcX4Hci4siKyn0I4pB9/qlplEweH+YfrqN+aiLM8QSXLRBL3qtRbFmlZ1LMP5Iv4YIQemi5IYvwpK8+2bFrUl34y+P/fcWA3yJH42GgNuOQawXGnXS5XArRgfeG0bvM27A==
X-Gm-Message-State: AOJu0YwOMg0labgbRUlcJbn92Ka5CVs36uLCAveTS4HEGB2yFz9BHGdt
	DrAAT9n89yATJ6vrbSZO/S6GuyPR2hxIk+umbCSflsA0OL8XZ2vn
X-Google-Smtp-Source: AGHT+IE/Thj9zy8OzNEgltY85A2YMlP/9PBe6RK31xV6C4QSBrLzPw+agMFJyhDUlBI6xydC6ujXaw==
X-Received: by 2002:a17:903:1c2:b0:1f6:89b1:a419 with SMTP id d9443c01a7336-1f83b5583a6mr41814045ad.17.1718245925584;
        Wed, 12 Jun 2024 19:32:05 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:32:05 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
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
Subject: [PATCH v2 08/10] tracing: Replace strncpy() with __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:42 +0800
Message-Id: <20240613023044.45873-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
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


