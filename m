Return-Path: <linux-fsdevel+bounces-24945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126D946D4F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66AA2817F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91A21103;
	Sun,  4 Aug 2024 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdjVMHha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C84FC19;
	Sun,  4 Aug 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758318; cv=none; b=CAmJwuUByHKgReYB30Hjq3T8SMnNSDuDetmi1JJ/ZXEBLjuiGJz4mt3jkVmPE8qX+EEu30hAEAyGgp1zgBpFkZ4AFxsmQkiylBUmZ+VgPCyiRNHssZ+tXK2kqKVRAWB1XBVQZlVtsE/ED1JAMcm+tM67jz7hxz6V1FM/HeQpQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758318; c=relaxed/simple;
	bh=dlJhdNpYfBkg3mTKqD+vv3I6a5l+1nCkhKweBeFcl/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aaXqIfCcz+B9UB5K9WMegxnDAr2YUZxDIDYTbQ2jIP3bHGgu41U5geppDPanK4pPBOJuZjiax53PgHPmdZQIiCIjMFK82Gkj5GZfWYG14iVdQfil8DraKPaoFRQUVa4+fY3e0z6HagQrcvFT6Dz9jlGAWpLD9luxQoPI5IdNEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdjVMHha; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db2315d7ceso5601709b6e.1;
        Sun, 04 Aug 2024 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758316; x=1723363116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHFsexRAvS3+Twdq3ZGpnUTD4jZRkYjFMffxIhD4B7E=;
        b=UdjVMHhaMNtUDgj7RUhXXVf9qIqqIjyBLG87ixYesAlh6+cBfaJilnaMaUu64KW1Ow
         2ncmrEHI4CDXT41HH8uObX4bXABtTl+rewcbP1WmIothRqTWXo63T4HKzPoDT5bV/Ll0
         SekYLbPN8+prC/Flox3kVttr1ZIs5yhUiVzU21zr7REi7B8fzntkZfdf5URYUKYwJY/r
         ba+ZVWnhdjpMKDeUYJZpZB7Ju9+VlMJdAcSl0u3zgAKHfgg6o5kMbXbZOFq99cc+OifV
         bnTQmXty/xdnLh72+z8FDGYKtjg8ulKvo5rcXPoMpAVgRdsBCy74YNTDeITlAtMAN+fe
         h+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758316; x=1723363116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHFsexRAvS3+Twdq3ZGpnUTD4jZRkYjFMffxIhD4B7E=;
        b=ocX+GMQvzaXh1w03l1Ed5vJCPVXIh65zSE8SNuR8BgEWLvtPAJwLnIGecHeN+dNs1D
         MvGemRmUrasyVmNO6YjuxcssTXVfUSY7mKhmL7wGK8mPTmuw+brYEE+ctNJEjwC81c+6
         pB48ujKG7Aw/vMX7g41I8DhwIBx66kxKCsLKDGXnZL5OZkPm+7xZrBt+CmKLIA+ds1qC
         5XVcQXZy/uZNfh9vieFIkokwVjY5yzKkrI5+UH1/+r3y19J2qoWOKJDzmqOJE1JNOInS
         t/dg3qw0qmHk52uq3icchjQy+Vkdip4T7Gv+U93Pp1iVENRoOZ4uLDZcZGozDtQAGpUI
         PoQA==
X-Forwarded-Encrypted: i=1; AJvYcCVTIuHqsNtAePeJ32H9mVcXPwMool++4JDFyvK1AJ0O81iutNL6r/DgV7BWkSUNqfY5IyzrgyKlwsDDumiCAdf9ima5qXO7DOCsBTXqByvDBjJ3AfyKo92u/mTBHNaxXOOQa5wHSTYo5k/hoY5hRRY+QB+6dkYgdp7XKRbWNqrvsx3G5I2868hfK+v6l3K1ORCbhdRS3IMvBmkjlbyOnFoakyH8ERTo2+qlf5uWZJ9r/RWnQRYCWKSCuUd38YSW38S3ItH6GpK7EPK+5UMD5tSy22wy/l2eQihavoFYnlZIwUck0imt3ssiGvGY4Bx8PX7d7oi99A==
X-Gm-Message-State: AOJu0YwXqr0G3JMpa/Hd9YaGNlDB9oUyN2+OUmoxiGXx5EQQ1k+8hqSp
	Ep5enr9Q500Ncl0bgBtGFohK/yA1B/E+SPsK+gdcReoMNuGjmPph
X-Google-Smtp-Source: AGHT+IEQdsxKAJTw4i+uNNPkbgE3NiIW5Ir2yWohAneqMp4vDkArZBqW84U9DpBffvNg6sRs26e7Fw==
X-Received: by 2002:a05:6808:212a:b0:3d9:2562:7541 with SMTP id 5614622812f47-3db5580f273mr11989986b6e.24.1722758316365;
        Sun, 04 Aug 2024 00:58:36 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.58.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:58:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
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
Subject: [PATCH v5 7/9] tracing: Replace strncpy() with __get_task_comm()
Date: Sun,  4 Aug 2024 15:56:17 +0800
Message-Id: <20240804075619.20804-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
References: <20240804075619.20804-1-laoar.shao@gmail.com>
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
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/trace/trace.c             | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 10cd38bce2f1..985d2bf2bbc5 100644
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
2.34.1


