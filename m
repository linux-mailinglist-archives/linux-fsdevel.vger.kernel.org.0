Return-Path: <linux-fsdevel+bounces-36498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E49E436D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 19:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A38B281597
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB31A8F74;
	Wed,  4 Dec 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WkZpB7lI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4F28F4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337042; cv=none; b=l+WZC0ZABchfrJBMB66bdY2sK+zQrVV5QkW3zp9YXyY6B+/I+y7M13xuYIB9JDvIRV/06DxptIYnIcT9CRkDzGowMADrjaGPembJ1d2vG8ub8lILaGggSoK3nA4zgfKa/4FxYob2eB2mukifxRp6vL+TzBplJnzRJN/qVQIQEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337042; c=relaxed/simple;
	bh=nojpG4c1beIpZhf4bvivZiXALWDMVCjD1bi2Z20bOYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=msbMLkXrgCT0t2A71FM+T12z+rS7cHo/B9J2rWvBhctFsaP5h1xd1ZBVm68hRYB7gGKNFUvQN33thoMGelc3sTfdWdnnF21VjnL0xEI7QbjBI3mem65BVIwzTwksihdM5thabgljHJyDVVvYt7TjuP4/OaORuwJ9rpVTgckHzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WkZpB7lI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a736518eso1300385e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1733337038; x=1733941838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2R/rtBiTMeXkad/LAKBxDDqxrSG652bI00BQUuuZU=;
        b=WkZpB7lImq5KtcFpf9Oz/AxgYnOmvbumGosGyOQ4/chXg52BmIc4nI4Q25UrDDK0bX
         rBhz/vJq7zJbmlcJHJ96aCspntPIhxnwRXmq6E5LM1mIiq4DkS55GTSLqbPniywOPwB2
         QCIzYo3YbSXg6mDC0xrEGVlSG25Xri+k7SO8jWAZUoB9st47DRGybP8JhO3jhcx9Vgpx
         o1a2z0/Vh51I7q1Z1UK5LlIdEPr+sOluqwztHPID4RAfTirFeGb5AwCc47WT+CRNLm2y
         a3EtJoBURv2teyFf0YtzSNdSoknLa9p4etPJuiYCVpsWwad11Ga6poQV+gwauPDvn+sd
         vGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733337038; x=1733941838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c2R/rtBiTMeXkad/LAKBxDDqxrSG652bI00BQUuuZU=;
        b=lkWArIeMcoTWi4KnfXsrYULWOy/C0XBxWGkFHmAWhdTDzaHlmppW6HCYsZEW0381nd
         qHTGE/vM4n/Tk7OMU3DnWh9x+0zccYFCegMP3Tc/aPvwFDLojBKert4mj2mGR+Qwaqmh
         TqLKmZmuq8bCpF0/dD/WDvgr/oT3S0GmxwCIYHbTZp3Y8oq4H5ZSuzwZLyih1wPAP1Bo
         +wh/fP7b+ssniRhi0MXT0/fcuGFSPwow6B0ZBAg6GdahLkGelIQA4HP2zJJWCkpDKH1S
         UvFsdTFS/+BuG/Lvs68uZs+hnJCWMIFcAHSsnPARrUraNqNEo1pEmvzD2/u8+KoirkDI
         NCsA==
X-Forwarded-Encrypted: i=1; AJvYcCU3fUWdsQD5fViXbIa3BzJwqVopTcckomU/K/VEG/rB7n/9bXWGT7HYp8zCJ7Myr7hqCLCo5q/GuNqrFwhO@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpJUVhgnmyVDMM2jW9hTi7p/vPW8vYxZ7J6j3JVSC+3gNyIXn
	O73WGQIg7gS9TxgX4+vTj0KYdADHDqu0KA5Nj7imdsKw7BVSe3x5MJXra8hi37Y=
X-Gm-Gg: ASbGncu+siAyS/xxyIIbg6RpAWKvcI5YjrQ7JK+zKuMdqDiw+cuHsZHjRVrVaQr1jh8
	oGMoaC+tdzfZbCd7DYBnEhtbUsNXQXZIq4TGCyu5zJTwymT5pDad3wKh9TNWimeMiYHMciFA8hN
	/lYCjRka5f+akNWuGp/lqglsY0YJbXaMhYMH2c4tJYRvfkLOyWAIiCw2IBzdcS+mtHoMptDZZtl
	8O6AqBGy985/hSvJZnGK0XM9rDUlUmJWGgoFgH0UJo=
X-Google-Smtp-Source: AGHT+IFu12LYNC/Tx/9klPxHSPQBN9yUlRrYTOt5CkHJCzoKsicqwGPJeTwNeO94pltwtaAxw7Samw==
X-Received: by 2002:a05:600c:4511:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-434d0a284f2mr58025425e9.28.1733337038406;
        Wed, 04 Dec 2024 10:30:38 -0800 (PST)
Received: from DW927H4LGF.lan ([2a09:bac5:37e5:ebe::178:1c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm32199055e9.13.2024.12.04.10.30.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Dec 2024 10:30:38 -0800 (PST)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	oxana@cloudflare.com,
	kernel-team@cloudflare.com
Subject: [PATCH] hung_task: add task->flags, blocked by coredump to log
Date: Wed,  4 Dec 2024 18:29:53 +0000
Message-Id: <20241204182953.10854-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index c18717189..953169893 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -147,6 +147,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
                        print_tainted(), init_utsname()->release,
                        (int)strcspn(init_utsname()->version, " "),
                        init_utsname()->version);
+               if (t->flags & PF_POSTCOREDUMP)
+                       pr_err("      Blocked by coredump.\n");
                pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
                        " disables this message.\n");
                sched_show_task(t);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a..7f3dd4528 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7701,9 +7701,9 @@ void sched_show_task(struct task_struct *p)
        if (pid_alive(p))
                ppid = task_pid_nr(rcu_dereference(p->real_parent));
        rcu_read_unlock();
-       pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d flags:0x%08lx\n",
+       pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%08lx flags:0x%08lx\n",
                free, task_pid_nr(p), task_tgid_nr(p),
-               ppid, read_task_thread_flags(p));
+               ppid, p->flags, read_task_thread_flags(p));

        print_worker_info(KERN_INFO, p);
        print_stop_info(KERN_INFO, p);
-- 
2.39.5


