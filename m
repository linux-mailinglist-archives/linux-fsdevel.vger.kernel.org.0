Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6941CEB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346590AbhI2WF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 18:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346734AbhI2WEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2BC061768
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q23so3137198pfs.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24HVUmck1VAppvs7Tv/9xSBlIyZfrWIg2aOoPOSGCPk=;
        b=Z7lHWLK+hOMb6TEvynvt5OOVH+QHo2cH2h2k1Ry8FKJTYlHQETIp6IxEc+SmF1BeTX
         yJOzvuRU5hMPQzdYuHJ65wJIoEZw01G5PrAIGEON27gmtBXYz/wKT09kpuwkF/QySjet
         PmgwVIZDx7jTYnmGY8m2xgJopVcTncBlMz/2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24HVUmck1VAppvs7Tv/9xSBlIyZfrWIg2aOoPOSGCPk=;
        b=5b7FgG02zHOwJvL+Qj1GO/O1lOcYcog7JQhYLZrAEYVM2Yhz897DC0ISH67sc+L8d3
         4OtMYvtPfpq3L660PcDoTInS08rdoU7YonkG3HYTqlBR0l6SZ8y4gN8TLV/yy+czU4c5
         FQOvBZnblnxr7n0whyVNcryfFwdizPadRpbzCXIwPPvmCacrgBfOyNmoUVhjzqi1dypd
         jl09H3KdyEdKhF9kQ7ig+y/h3A67G0RyvjXIQ/rke21GDqj0f7hRHBE0Cyjl1CZ/YGaN
         ourrLPPv06B2oQT/4RdaAMU9xZ4GCvIxNrGH6e1JT9rJUkkOGn4vsBvwZhOOlQ2Pksct
         GvSA==
X-Gm-Message-State: AOAM531KE3Vu396nJCx25M/g2BZgOD2bSNpES0XE+P+rauZ3AI69+eSS
        kI7+EzHVH1eU/OBpL1nKtAuraw==
X-Google-Smtp-Source: ABdhPJwTXGwIeBPVP+42Jds8fbtC28D1cwIq/SGc7KPzUX4XorS7Wwdx4edKqckr5//XoxuyCbyXgQ==
X-Received: by 2002:a05:6a00:1a04:b0:44b:346a:2a25 with SMTP id g4-20020a056a001a0400b0044b346a2a25mr753024pfv.59.1632952944631;
        Wed, 29 Sep 2021 15:02:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm720217pfm.81.2021.09.29.15.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH v2 5/6] x86: Fix get_wchan() to support the ORC unwinder
Date:   Wed, 29 Sep 2021 15:02:17 -0700
Message-Id: <20210929220218.691419-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929220218.691419-1-keescook@chromium.org>
References: <20210929220218.691419-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=keescook@chromium.org; h=from:subject; bh=Q52zDV9YajI3kkCmjslJF3Brs06bPq6a2KD+X5RLir0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVOJpPZoMxuXMkWZwnGRPVVYkoF0bnz3DmLyKHCXu Uc/LlKWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVTiaQAKCRCJcvTf3G3AJhkJEA CSWLiYfLZArGwkCuomnnMwflTp76Al/53DgAspMiCGY+D9t1wxV/T0OQ+XuriYreg1Ob4OTVbSc7Ai MIFwyTGivV6BZBrE8hrDHjIUqcuKSeX4OU8TW9mDA79zmYv3etEQtpaliZi9F3ib9JuVjOJUKxBXly NXBX9p6RRX5RuxkNaiWIe1fiQfx4mF6ngBP+kyX40O6ZiIfnycCs6M9fqnaMf29HacI1kGKmfXieIL eZCQGdWLmGBwAaqhzhBcsPkPoCRmD+Z6NXu0xcwg7UeCQ2iwEOfdauHk/jIhQBy6eQ2ulLTqKHEFqV 22syyb7kEo3Nd0KxZGwIlLBko8LvmTaTgxNkOWSWBEycJgFO4z1myxXJath5y8VAxxJ9VL5VYQcE5E Rvi0MmCFsX1m9uW9jbtc8KHyJCH+Vosizn748Dgw/qV71Gb9cELpPnhe+qQxDw6kbw1/cklbxXc5n1 YrmgxCiKjSK6IAEcgHRKx/gQl/erbweNjGqeveXvp4hkKYd9YdLhRVVVeodSH32F105/S7GbYXGdzn NtN1ijRVXePtNwpGATDj8mNZfPIVZWevD0LHAFv1SnqnN2Y8yXFQx1bqThDITEct88Cuxujc2H7/kl bkSfx/sgrTI0SMpE9A+H4LKkTmQ1xD+aPxQ47C/a6x/lxMtP7AGoPiRrASmg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by default
on x86, but the implementation of get_wchan() is still based on the frame
pointer unwinder, so the /proc/<pid>/wchan usually returned 0 regardless
of whether the task <pid> is running.

Reimplement get_wchan() by calling stack_trace_save_tsk(), which is
adapted to the ORC and frame pointer unwinders.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com
---
 arch/x86/kernel/process.c | 51 +++------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..e645925f9f02 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -944,58 +944,13 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
-	int count = 0;
+	unsigned long entry = 0;
 
 	if (p == current || task_is_running(p))
 		return 0;
 
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start = (unsigned long)task_stack_page(p);
-	if (!start)
-		goto out;
-
-	/*
-	 * Layout of the stack page:
-	 *
-	 * ----------- topmax = start + THREAD_SIZE - sizeof(unsigned long)
-	 * PADDING
-	 * ----------- top = topmax - TOP_OF_KERNEL_STACK_PADDING
-	 * stack
-	 * ----------- bottom = start
-	 *
-	 * The tasks stack pointer points at the location where the
-	 * framepointer is stored. The data on the stack is:
-	 * ... IP FP ... IP FP
-	 *
-	 * We need to read FP and IP, so we need to adjust the upper
-	 * bound by another unsigned long.
-	 */
-	top = start + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
-	top -= 2 * sizeof(unsigned long);
-	bottom = start;
-
-	sp = READ_ONCE(p->thread.sp);
-	if (sp < bottom || sp > top)
-		goto out;
-
-	fp = READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
-	do {
-		if (fp < bottom || fp > top)
-			goto out;
-		ip = READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
-		if (!in_sched_functions(ip)) {
-			ret = ip;
-			goto out;
-		}
-		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && !task_is_running(p));
-
-out:
-	put_task_stack(p);
-	return ret;
+	stack_trace_save_tsk(p, &entry, 1, 0);
+	return entry;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-- 
2.30.2

