Return-Path: <linux-fsdevel+bounces-38883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7477A096AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79F9188D656
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40184212B13;
	Fri, 10 Jan 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HcCjzzCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC8211285
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525064; cv=none; b=aqBHWyLesCgHCbr1c4/7GiisAzOQ5XDRBdqx/E0VCIRp5azKU67chl6iDT2TEWznUoaPHGYZcQZMMvyQqJ8m7T8JE5KZYA/s8wf1vqZzf/wSfF9C7wiG4eDW2RwZ3B2iw4qR692UPIDLFnLH/yWw6rNKLBKrpCw7sg7o2VPMajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525064; c=relaxed/simple;
	bh=F8Mla67SWQ9r7Z07mBQtXqM397VN7ABDNoM/gmtYNmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a2T94jMV83Exw/LYhiBkLM3UXLjBp8u60mFXsgsdTrlWIyq0ZlsVHYb+PcaEr9gXJd4z19NkzC7KXTIlaHMbcF7pUA/TB2/LTXBb+llfmgtXA05mgNV++u5TLULpenQQM85pH0DYVMY+NouW8nVmI+KyhJkIR3LiuFTB6QzKhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HcCjzzCI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1214226f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736525061; x=1737129861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSoP01tzB02pbAfxR1chCM56yNEmqMh6nl0Xn/8+k8g=;
        b=HcCjzzCIS+9jSDJK1W1q8HTpWlW4/Orfv012xLUR2I9/Oc9fczugXoATbz0qFPXrU+
         TlXsV8B6pO+evdUAbYAZJS8eXWRnKHUWFyU0vC33n9n0O+i87Qd+dlDhtQR4qE0i9Kua
         os9g2HwfVYrOcub8TFK/eucLhjqrlgB1hNgo3t0TaSgFAo8vjzImA4kG7IYBVunPZqUT
         lX6DKqTL22f8wt8BovJ/tipJGbwrUQQ+jwUlW5u4Mffs2AzkzPT4kY2NJEakxSH3zTzM
         dOBzKCIPeFvwe0M7StfyOprY8cibG3KbcT3EwmFuyOFUwJSFG7Cne+NO8mjBW3kym2L8
         wVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525061; x=1737129861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSoP01tzB02pbAfxR1chCM56yNEmqMh6nl0Xn/8+k8g=;
        b=NHEbjp8hwfjAqn2+wBIJXEVG0jGtgYAvRwbHOAUkOCtHgBOWTzJvHCMGiVXSimze1M
         xR8gh8Mb3cLUirXus1sCoxp862h26aHk/ZLmSL1EXUY5LAgrpr1BRh60LPLyeDo7ewbp
         AyaVjnYH4GaWskY5mRTRFy+dNy7oz2AbN3YBb4PEWkxHIk5cMWUZjH83pSa0UxUc6UTN
         JPm9fOTOj/qUXm3cjQiQhBN5dFrjFQP3qeFPaKn9OGwhS5ztcmFKcmHBCONIGmtf83mp
         WNrrJ4lhh6HunyYu5oFNZiiKRKfIrCl0pvU606umSkDGtW/v3DB/zRj2r4jkvL0nRja6
         SIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS2Akr6SS2q5jdirDaJeT5dtTGPzcZ1wS5SzfrRvRnOLP8erPP0lQTfh8URdbY3LzP/5cVAiq0WoNgeC+S@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPaQpZxmSTrVOQlA0KaWGpsXuTGx1SpHg82mU9ZNTsSmEl0hg
	6bCXcUMQie4Kx9LMiogSmdVZjgODboYCbMnz1rSS+a/Ei9aQS8FfRLM28Tbon8s=
X-Gm-Gg: ASbGncvImQcluVsryKEP8mdsUxpHtw8PNEJzt222xliTGQSQhKdw9nBXL98tlU2qz2t
	1eKnFVdlZKXhTouHb590spK6Rj0IbUuVJ4H48ffPksoANnjE3uulae+OYBDjSUwkmc+rd2i4YmZ
	COprj8e8J5ioObnYnbYDdD+ibikY4bZuNqrIe4UV+jIT8nC81fdKuSnF1BUktV1SafPCJhpJ3aX
	6IZrAHJcLOexMzJ3ayETGnTjBOMFQHervhI5592uA8fyZvYpzOd92YrGso=
X-Google-Smtp-Source: AGHT+IFVRrENAObyodMQ5YC33DsM8BDHNSlIFDvMNTFaX9MhydGcOuM/RCyIiTcS/mvDAuqQ8uXDBQ==
X-Received: by 2002:a05:6000:1a8c:b0:385:ebea:969d with SMTP id ffacd0b85a97d-38a872db37emr10434876f8f.22.1736525059564;
        Fri, 10 Jan 2025 08:04:19 -0800 (PST)
Received: from localhost.localdomain ([2a09:bac5:3807:1cdc::2e0:ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81b1sm4953413f8f.66.2025.01.10.08.04.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jan 2025 08:04:18 -0800 (PST)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	jack@suse.cz,
	juri.lelli@redhat.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	viro@zeniv.linux.org.uk,
	vschneid@redhat.com
Cc: kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oxana@cloudflare.com
Subject: [PATCH resend] hung_task: add task->flags, blocked by coredump to log
Date: Fri, 10 Jan 2025 16:03:28 +0000
Message-Id: <20250110160328.64947-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resending this patch as I haven't received feedback on my initial 
submission https://lore.kernel.org/all/20241204182953.10854-1-oxana@cloudflare.com/

For the processes which are terminated abnormally the kernel can provide 
a coredump if enabled. When the coredump is performed, the process and 
all its threads are put into the D state 
(TASK_UNINTERRUPTIBLE | TASK_FREEZABLE). 

On the other hand, we have kernel thread khungtaskd which monitors the 
processes in the D state. If the task stuck in the D state more than 
kernel.hung_task_timeout_secs, the hung_task alert appears in the kernel 
log.

The higher memory usage of a process, the longer it takes to create 
coredump, the longer tasks are in the D state. We have hung_task alerts 
for the processes with memory usage above 10Gb. Although, our 
kernel.hung_task_timeout_secs is 10 sec when the default is 120 sec.

Adding additional information to the log that the task is blocked by 
coredump will help with monitoring. Another approach might be to 
completely filter out alerts for such tasks, but in that case we would 
lose transparency about what is putting pressure on some system 
resources, e.g. we saw an increase in I/O when coredump occurs due its 
writing to disk.

Additionally, it would be helpful to have task_struct->flags in the log 
from the function sched_show_task(). Currently it prints 
task_struct->thread_info->flags, this seems misleading as the line 
starts with "task:xxxx".

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 kernel/hung_task.c  | 2 ++
 kernel/sched/core.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index c18717189f32..953169893a95 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -147,6 +147,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
 			init_utsname()->version);
+		if (t->flags & PF_POSTCOREDUMP)
+			pr_err("      Blocked by coredump.\n");
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
 		sched_show_task(t);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e5a6bf587f9..77b6af12e146 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7701,9 +7701,9 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d flags:0x%08lx\n",
+	pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%08lx flags:0x%08lx\n",
 		free, task_pid_nr(p), task_tgid_nr(p),
-		ppid, read_task_thread_flags(p));
+		ppid, p->flags, read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
-- 
2.39.5


