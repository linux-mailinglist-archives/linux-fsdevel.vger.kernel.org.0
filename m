Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B386341CEA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 00:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346867AbhI2WEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346355AbhI2WED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3664C061767
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id me3-20020a17090b17c300b0019f44d2e401so1040307pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WCcuqE5ATqYYHgSY5EFkOCbHMpsSpyspHQpjUNcv5Y=;
        b=auL8+W3vWjgmvU2tpA+erOXzo26U1U+3xcJSDWNYhxjCshW4qRv6EuJyBzF+NF+ALI
         VtFzV5eIXd9AJWySPinc3ZYYQvnPsqmVS3V6IoTI0GD6gspmuxNSGc8jbwxm/Vg8og3X
         56m/Y56wUuRRWtKXu2Uu6yB4QOf5dPLgXDGyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WCcuqE5ATqYYHgSY5EFkOCbHMpsSpyspHQpjUNcv5Y=;
        b=gxOYTID1f9U+FBoqlQ9g8eW8fMRWp+1aiANYkJjOgdqffvZLkqJKJ8bWu7TjxWS8u/
         2ZC6hcXHxBFVueGdIhN2PvFd1P4JVbKkbwy5NagXNDN5piqtB4mZNMFUQat39iaoaqs7
         5Mu2B5Bek2DFmL/OyNeVVC48WnmEpvZ8Vv0XPTYwRybZ+PdT3XBmlBcZ3K2+U2RhgV3E
         HTpwK/ySdC3QheEJeufcqqAN3KCCXPKpbOptK1/8j2AieN5673JqNdndBYakDifsBWN8
         8b9Z3fzNjGJcddJRQ/rJVQD2/DU/RNJMjhK8IyP2RhH8lNvLHpgzZsEmvcQtnh+Ri0us
         KgcA==
X-Gm-Message-State: AOAM532V/oQyr3MSUXGG7KhvOIS3rkL1uglhDW/qUFgRmbTpEyQa/Qmn
        Mn7tvrfzOKvO8ttXkGU5ypdniA==
X-Google-Smtp-Source: ABdhPJzwLR/Ap0q0v0NMoFhrZVvZI/xyv011wmpW7jJR760oWKWM1Dryn4XWEISn5sCM7FhYCnSVNg==
X-Received: by 2002:a17:902:c3c5:b0:13d:efe4:c10a with SMTP id j5-20020a170902c3c500b0013defe4c10amr768762plj.54.1632952941354;
        Wed, 29 Sep 2021 15:02:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm671348pfe.217.2021.09.29.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:02:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 1/6] Revert "proc/wchan: use printk format instead of lookup_symbol_name()"
Date:   Wed, 29 Sep 2021 15:02:13 -0700
Message-Id: <20210929220218.691419-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929220218.691419-1-keescook@chromium.org>
References: <20210929220218.691419-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; h=from:subject; bh=48rNinxgYhX0MMt+z9ytmuG8GHuOw2IZ5/XYplBnCcc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVOJo3aAmkY3cNkeh8mx6qR4Wd4ABLM9VfEd7+ihZ Bx7vHSCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVTiaAAKCRCJcvTf3G3AJiiED/ wKvQpREXh7suSjafXjjgxvDNfXY3HL8kOvjEmH4RtOMi5mz+9HRnMPSrE7uRwIaONoG4ufwr/n3H3P 6Kja0xtlj0MeCsARdSb7yfNwDwdkvJTU9zYmkc6FD0HWZOwMbOzRTj5YX6cI3xzvdliMv7iBmIo83d 8Me5vaMEeP4ipheIbrebMIjZ3wRD3Q2jjWQciQI5VRPe9u8u1Le06t9baVYeg49LWj0IrFoOy11jLp E8Qjwbx2yLB26dZ1HeFyXOrO4Kn+0RX4s3Xu3TPOUme/W4000nwYEFFuGJOrSqsoIHYiLaq4KsPSmg yCixLdJvE6BnqSi5k3tGK1/y3iNDnlK4v2mGquYuFgSwtOnkYOY8x6q1baJAyWvt7ttfZaP6h65PEx +VS94JngCROP2FMOdyUzkqOW1lXm67lV9aT+bMPTO2PYZJPpFl4DpK2W/vqUsWFvo98UUgYIGbiFfE xeDctTh2NhYvhW2pOQKdzEaEDHJD0+4ipb6NlrtI0vse43Uana/wFt55xPCcvTymIT2RnxjbJu0d6Z JPSErNRmubclWQ50ZRZoeUD2CVmsqqqfcMqdzGtcuzuCnL9s9nfe7vIK2d3CHP0cwjYDrnBy6PBmcb YSK36RKsGmsiO4nzn/++uNyY8O30t5BSglmAsrFBqHEQJ1eU9lTE1CaE78WQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reverts commit 152c432b128cb043fc107e8f211195fe94b2159c.

When a kernel address couldn't be symbolized for /proc/$pid/wchan, it
would leak the raw value, a potential information exposure. This is a
regression compared to the safer pre-v5.12 behavior.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/all/20210103142726.GC30643@xsang-OptiPlex-9020/
Reported-by: Vito Caputo <vcaputo@pengaru.com>
Link: https://lore.kernel.org/lkml/20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com/
Reported-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/lkml/CAG48ez2zC=+PuNgezH53HBPZ8CXU5H=vkWx7nJs60G8RXt3w0Q@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/base.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..1f394095eb88 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -67,6 +67,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/rcupdate.h>
+#include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
 #include <linux/resource.h>
 #include <linux/module.h>
@@ -386,17 +387,19 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
 	unsigned long wchan;
+	char symname[KSYM_NAME_LEN];
 
-	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		wchan = get_wchan(task);
-	else
-		wchan = 0;
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		goto print0;
 
-	if (wchan)
-		seq_printf(m, "%ps", (void *) wchan);
-	else
-		seq_putc(m, '0');
+	wchan = get_wchan(task);
+	if (wchan && !lookup_symbol_name(wchan, symname)) {
+		seq_puts(m, symname);
+		return 0;
+	}
 
+print0:
+	seq_putc(m, '0');
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
-- 
2.30.2

