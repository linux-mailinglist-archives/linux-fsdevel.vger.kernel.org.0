Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2516416B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 08:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbhIXGXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 02:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbhIXGW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:22:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE462C0613E2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so8900489pjn.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtp+PhiNYL14RQ36xZy2Q/C53xERkhDc4tFWQNnO3vk=;
        b=fNdXsf2wBVkiDe6gWGju9kPx4AwSHKIvM1vTsiqeS3wn1Iu5U/KnbMDLraPJUIO8uk
         N3aouM1uMKmG6c0c0qREFiGypCqRzRWn3qsSlq2Q2pWXoJI+tzpXZmoNGgeCXEE2ifGj
         /80880cCTeP6f7uSPWy7pg/+N6GqRbqq8iaGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtp+PhiNYL14RQ36xZy2Q/C53xERkhDc4tFWQNnO3vk=;
        b=RwidvitbMQl1eltwcrpv/5WDg6uqugESvLy5RmNPnex2hnvNOqAKVFqwYEvrakk06c
         Ll/1OzUY95fBN/CSMim/tQVWBuohoRwe2+WSpepg7H8vhWA5zYM3KqilQtPNCWIH01tO
         AsOkm8Rp6olqHYKywaRpAOxgSg5eDzAjbf6DRdc1tF6tGw5+ipkgMQaGlMarLYB0ECcQ
         u0pJPhcUhj6Gzs7KCvD4pFN5woAfaHmzMPkvzElPqVYEJ55YBIk0rsTDm7sFfvpeWV8+
         CVflx7H0qRmboC4lHTkrFDPcP2IKf9CBBqLvU3PGLwj/FNCA8rnKJEjPY3RpLfSFvVbj
         O6AA==
X-Gm-Message-State: AOAM531YG2xSboKYIih4ecN5+11ep16lSALKUe9wT9ECsWPZGIib31b4
        4LMd8V43AvIYY4Da0Y+4r2ox+Q==
X-Google-Smtp-Source: ABdhPJy1zhOzlP3OCh0HTB40xpV43kVP1bbFS8pCx+Z34LJkWO7dDHbsvHF2OOX5mJ7P7a2qPluUQg==
X-Received: by 2002:a17:90a:2e0e:: with SMTP id q14mr234223pjd.171.1632464418245;
        Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w142sm7521009pfc.47.2021.09.23.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:20:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Vito Caputo <vcaputo@pengaru.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>, "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Stefan Metzmacher <metze@samba.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] x86: Fix get_wchan() to support the ORC unwinder
Date:   Thu, 23 Sep 2021 23:20:06 -0700
Message-Id: <20210924062006.231699-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924062006.231699-1-keescook@chromium.org>
References: <20210924062006.231699-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2655; i=keescook@chromium.org; h=from:subject; bh=h4Mwhvti6HC9Gzl6rvebY2d6U2FoXZWvHbtyd+yZEFo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTW4Wr/0QSzXjC1MlF3eZkA04AE/CdBQgh6sIk6Hd p5JfgfyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYU1uFgAKCRCJcvTf3G3AJvgvD/ 0Wj7dtO4lv/TyeF7NG65VuqZkcc0g9euy9CGnrus/2KjABDj/SDPpG5kn2qPiosFecigyVpj7ZcOG7 xo2svpeeZMqWDEOJcWKDaTFOh8VrQHuyk5hFFu2TalMkGchr2DZpRU3vP8HbCh/KWjScvx/Hjuktfl cCn9i2tuzuZWm2pw7n+ZB4BMkXg3dtcUUmLLiJgRff4oBkpoF4msWMubgYr54JRuRuVHBH23ZQP+k4 GDdm1MFMDoZ9bz6D2wDbP7mFXl5OzN09gKxl92IpVr9bOz7oZ+mzrJevkm8Frw2+Wd2FFTVkI4JJ2l F5BGukMT6aM+9Uio5hAQIFH0n+yRc6Vm9Pref6/4gb7QXzeuBP//kg8Z6qyZ50WwWMEIVg4RHH+Jqu MTsrlKAxfl8UWPTSB8pbBgjWxzJqWIlPTTIRXn0LFyqOKf/Z+I0ZG5F+7HrnvM6yhNcxmdddeRoUdP mNAOr2EoH/D4m3iqko+20JYvHgsgfrXqrHABEQ+JPO8NBZ3vKc19VMPLsHoUtOlVDGw/bVLMqAZn61 iIQxBEhODvlR4eXY3rO9Zs+k3hoHiV9/NZaZtjAVOVEAaeLUg2/pGoCVC2ltfxrlF8n9RiEC7OYWPB L3h8n6Nz1IgbJpcDgT5qPegnC8uVTjfBdyWOjmn2mbIHJS9ezNyH4CMBJ4BQ==
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
Link: https://lore.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
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

