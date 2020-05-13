Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA321D20C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 23:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEMVSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgEMVSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 17:18:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63588C061A0E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 14:18:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so294770pfx.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1rNHcVkoVP3m00RxTkA3Drc3OuzgByLtKnsWl4c3mwc=;
        b=AWIPRU+Gs9jvsCVgoVdhohoiXM5q/v586JSBh8skrSC0ezJMpZCDQqMhasTNTGpjW/
         hA0CZGCJRp/BHYX0oc42rpX50ggvU9RU9nq2INCzab3jx92lkrrgntNkdlu1K1794f41
         Zm6Kj8IjpNwLQAASuUseFRPLo7VZXeDEUDPmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1rNHcVkoVP3m00RxTkA3Drc3OuzgByLtKnsWl4c3mwc=;
        b=CamTQNw3SwOK56zwDcyLCd4XpeAB6ScjbmzdyZTCo+Fvr5DPAIMzxPiotqGLQHUS3n
         7pi8JzECU/YpPxBBA3OmAQNZI+2qC6kRoN5YPnJXC3FidJBU5EEmSH+BePkECONmJTcW
         44yCojsh7nXpJYo8pDpUJpsQl9hmjb/UsA0v3jS41wdtJsff2jPV5M7Rg7/imzyfV1+f
         dhvWZFWXEle/yNhWlN8bgWHgORzd89m5IihrZ1E8/M1uub1iG4svOk88sYTa27l6a6NO
         XI9uLcYy2MdKP1P1s8Y5nt6dgBaSpGw2WVNB1feeMjnXngVqh8Yp79ElNPvNfczlIBPo
         pN8Q==
X-Gm-Message-State: AOAM530cx8Bt0F1YmVyXydEDu48AiYj0TFDwNA1Iwpz8frLNTALXe9qe
        oep64H6QR3rNKf1DmChSVmUv8d+qmEQ=
X-Google-Smtp-Source: ABdhPJzRUUmxr0AoAn8WKx3bz7xSG1VsJwZL2EO2FmZzAI6BnJiQlbI/HmymBNtGDGNF/plcOvIgQg==
X-Received: by 2002:a62:4e87:: with SMTP id c129mr1163753pfb.178.1589404699797;
        Wed, 13 May 2020 14:18:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r12sm501950pgv.59.2020.05.13.14.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:18:18 -0700 (PDT)
Date:   Wed, 13 May 2020 14:18:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] seccomp: Report number of loaded filters in /proc/$pid/status
Message-ID: <202005131414.410DFE77DC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A common question asked when debugging seccomp filters is "how many
filters are attached to your process?" A common mistake for process
launchers is applying filters before fork, instead of after, which means
each progressive child has an extra redundant filter added, which will
slowly increase syscall overhead. Provide a way to easily diagnose these
conditions through /proc/$pid/status with a "Seccomp_filters" line.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/array.c         | 2 ++
 include/linux/seccomp.h | 2 ++
 init/init_task.c        | 3 +++
 kernel/seccomp.c        | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 8e16f14bb05a..8542a9c21dff 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -342,6 +342,8 @@ static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
 	seq_put_decimal_ull(m, "NoNewPrivs:\t", task_no_new_privs(p));
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);
+	seq_put_decimal_ull(m, "\nSeccomp_filters:\t",
+			    atomic_read(&p->seccomp.filter_count));
 #endif
 	seq_puts(m, "\nSpeculation_Store_Bypass:\t");
 	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 4192369b8418..2ec2720f83cc 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_SECCOMP
 
 #include <linux/thread_info.h>
+#include <linux/atomic.h>
 #include <asm/seccomp.h>
 
 struct seccomp_filter;
@@ -29,6 +30,7 @@ struct seccomp_filter;
  */
 struct seccomp {
 	int mode;
+	atomic_t filter_count;
 	struct seccomp_filter *filter;
 };
 
diff --git a/init/init_task.c b/init/init_task.c
index bd403ed3e418..dd108a8689ac 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -182,6 +182,9 @@ struct task_struct init_task
 #ifdef CONFIG_SECURITY
 	.security	= NULL,
 #endif
+#ifdef CONFIG_SECCOMP
+	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..46d883574476 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -398,6 +398,8 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		put_seccomp_filter(thread);
 		smp_store_release(&thread->seccomp.filter,
 				  caller->seccomp.filter);
+		atomic_set(&thread->seccomp.filter_count,
+			   atomic_read(&thread->seccomp.filter_count));
 
 		/*
 		 * Don't let an unprivileged task work around
@@ -544,6 +546,7 @@ static long seccomp_attach_filter(unsigned int flags,
 	 */
 	filter->prev = current->seccomp.filter;
 	current->seccomp.filter = filter;
+	atomic_inc(&current->seccomp.filter_count);
 
 	/* Now that the new filter is in place, synchronize to all threads. */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC)
-- 
2.20.1


-- 
Kees Cook
