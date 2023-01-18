Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83D67290A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 21:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjARULJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 15:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjARULH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:11:07 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400C3FF21;
        Wed, 18 Jan 2023 12:11:06 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id w2so111100ilg.1;
        Wed, 18 Jan 2023 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOiR9hsOKHJTrMtW7FkV/+C4vzLu86o1/FGgQL4ndGw=;
        b=MP9MEFJx6JPcYQCK2rCpJH9emHNoPNuzy1oUsEJThem9bp6OoZKipVzp+ImVWaKMXZ
         1P9ja1sdvtRnLsStiPveQvrz95vpW01qjj9jq4ko2ADB4/Bz+cnx+Nq084G1FwFZ8xcT
         ZXLR0zjeV+ekRcDRl+0xXlNxuESL7xHQJXiMH+JTfQ+MWzBfXbitsapN0yD3r9WgVO7l
         JJXPmeWA3tohIMc7/Jqq4wtSkq4SUB+yWIU0XQ5aJOiUFZtkEyYuegCO8rRJugIQae4h
         jxoMWvUDCbVbGrsEYGSluWELCqr7dHwawOQjBJkfkBMNYCfYAER2ETj9kweF4OFXnupb
         +Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOiR9hsOKHJTrMtW7FkV/+C4vzLu86o1/FGgQL4ndGw=;
        b=EGcG1qLkfaEnOsCZMrLYvpytRrZnz08BwBCraxEWe/kicBm61rTEFRx1+IEN+TJ4mO
         1abCICvts3yrzjt2zpGiqUKHnjgKvZ/J7hWb2I0/ckLNhLvTWIc+cNPHxdw1XCs2Rj3m
         T1j66/BPLQm8+Pzb6Nitn/RUtPA4hnOH70mSldK6UdXlMXZYpQVvwg+SZL1cZ8FRGNGr
         NZU9btjNhQ4Ys3vsEffK0Dzs2XUwuCNHL0/NHlTXCU3HSGoXh2dydkZ6NxpnGWUrg8uQ
         BwAitSGGIlJxIDvxusad9L3fd50fxW4zy+aJOxlGe5eJkujWhDnQFJX9//v0ENxhQx/+
         Fs6Q==
X-Gm-Message-State: AFqh2kqvC6IYzjQX+4Zgz03RH2o5ZJPTDBIro+w0wNY4ONxM0iQhTCcZ
        B47oob4tycPSu6CTGoS8A3hb9FDf0vsZ
X-Google-Smtp-Source: AMrXdXuV8/yEJAdwese/wVzl4a1ZLYcALHuWn2qnkhWlb2o9Q9QsRzofUbqpleJ5rGD4dRf3Jv0Auw==
X-Received: by 2002:a92:d07:0:b0:30e:dfcf:3b76 with SMTP id 7-20020a920d07000000b0030edfcf3b76mr6499328iln.15.1674072665701;
        Wed, 18 Jan 2023 12:11:05 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id i5-20020a92c945000000b0030bfbc121a1sm10299998ilq.79.2023.01.18.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:11:05 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User Dispatch Suspension
Date:   Wed, 18 Jan 2023 15:10:53 -0500
Message-Id: <20230118201055.147228-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118201055.147228-1-gregory.price@memverge.com>
References: <20230118201055.147228-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
modify Syscall User Dispatch to suspend interception when enabled.

This is modeled after the SUSPEND_SECCOMP feature, which suspends
SECCOMP interposition.  Without doing this, software like CRIU will
inject system calls into a process and be intercepted by Syscall
User Dispatch, either causing a crash (due to blocked signals) or
the delivery of those signals to a ptracer (not the intended behavior).

Since Syscall User Dispatch is not a privileged feature, a check
for permissions is not required, however attempting to set this
option when CONFIG_CHECKPOINT_RESTORE it not supported should be
disallowed, as its intended use is checkpoint/resume.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/ptrace.h               | 2 ++
 include/uapi/linux/ptrace.h          | 6 +++++-
 kernel/entry/syscall_user_dispatch.c | 5 +++++
 kernel/ptrace.c                      | 5 +++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index eaaef3ffec22..461ae5c99d57 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -45,6 +45,8 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+#define PT_SUSPEND_SYSCALL_USER_DISPATCH \
+	(PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)
 
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..ba9e3f19a22c 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -146,9 +146,13 @@ struct ptrace_rseq_configuration {
 /* eventless options */
 #define PTRACE_O_EXITKILL		(1 << 20)
 #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
+#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH	(1 << 22)
 
 #define PTRACE_O_MASK		(\
-	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
+	0x000000ff | \
+	PTRACE_O_EXITKILL | \
+	PTRACE_O_SUSPEND_SECCOMP | \
+	PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)
 
 #include <asm/ptrace.h>
 
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..7607f4598dd8 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/signal.h>
 #include <linux/elf.h>
+#include <linux/ptrace.h>
 
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
@@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
 	char state;
 
+	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
+		unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
+		return false;
+
 	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
 		return false;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..a6ad815bd4be 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -370,6 +370,11 @@ static int check_ptrace_options(unsigned long data)
 	if (data & ~(unsigned long)PTRACE_O_MASK)
 		return -EINVAL;
 
+	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)) {
+		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART))
+			return -EINVAL;
+	}
+
 	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
 		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
 		    !IS_ENABLED(CONFIG_SECCOMP))
-- 
2.39.0

