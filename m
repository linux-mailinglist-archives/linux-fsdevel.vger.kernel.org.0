Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2B6757A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjATOpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjATOpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:45:12 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC817D0D8D;
        Fri, 20 Jan 2023 06:44:43 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id u8so2770748ilq.13;
        Fri, 20 Jan 2023 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4L1pQ0JM1hC2pJHglk8l3j+fJVDjADjEl6sXRJ77Xs=;
        b=WkrvGr7UQb8Qru2B3v0x5Ay72pxJQYUv6DeKNen0IezGFgdRcayY42tSeeLpsB6fo4
         wO7PVmqxDKlhNMhpgMySgtT1W6mI9atfP+o9jBZAT7PaYq+MSCcfaAEG+zBtEh+ZK8hS
         3NqgsPJ2mp+amhb7fLnp1b3zL5Sbe1aRATddLqf5BZC5178EYZ63cy9uqm807y0c2jke
         S/mlNesYvJIVnkw71blPkNHQRKcc/CMEyJu+k+ddVwWEY1SAiwbfihJ3bYareLGkjlwN
         1sCSLzLnDdtFlmSF9XtqklE/F9i7iZtTolT466tH1PVc/iuct47xdg2XycyYknKpAly7
         uLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4L1pQ0JM1hC2pJHglk8l3j+fJVDjADjEl6sXRJ77Xs=;
        b=sZxxJJaFyZO4HJrj2fLR79xvkMnauDrTMK4nUAGuunZezgO3+8SeEOJKlN/J9e1BdZ
         euRLF8vo+vicw7yBbfYRsaYf0CQEUDZi2vYb3PCvAC4kMjETYo+Ki2lCmb/K7xLNzSK/
         0CsXnJAEJg8lzH+VMUaZid+IrSI9ondcX1DjH/CHlDohf+Auhx8vj0ibrB+hDZjDyXro
         VNUVJwHpaoXNeNxbDQ1YJ9Wuz0XMtj0kFjHhwvWSJ3P6OfgfrE+C254MpjuaX9UbVL9L
         iwueU4EWbR+3Rh20pBppYRmdJ1azy2+qtExgztQCpPAoBYqHZ62639Vcbg1Ezn37+V2N
         iv6A==
X-Gm-Message-State: AFqh2kpWj2GSNNWtrBuTmRD5TmkObAH4udwF3YJHv2cBPjlOzqT6p8qf
        j/WRXeNH9AKcpJpii3diRq1En2NZC/ux
X-Google-Smtp-Source: AMrXdXuTVKrotbzpNTgVhUT8ksOkhPVRLjQ2O1iU40UyKuopiGYvDqMz06qyac7d/RCk3MpXgtiG/A==
X-Received: by 2002:a05:6e02:1544:b0:30e:f4d0:c092 with SMTP id j4-20020a056e02154400b0030ef4d0c092mr21505925ilu.3.1674225851136;
        Fri, 20 Jan 2023 06:44:11 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id p185-20020a0229c2000000b003a7c47efde0sm1513852jap.11.2023.01.20.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:44:10 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 1/3] ptrace,syscall_user_dispatch: Implement Syscall User Dispatch Suspension
Date:   Fri, 20 Jan 2023 09:43:54 -0500
Message-Id: <20230120144356.40717-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120144356.40717-1-gregory.price@memverge.com>
References: <20230120144356.40717-1-gregory.price@memverge.com>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/ptrace.h               | 2 ++
 include/uapi/linux/ptrace.h          | 6 +++++-
 kernel/entry/syscall_user_dispatch.c | 5 +++++
 kernel/ptrace.c                      | 4 ++++
 4 files changed, 16 insertions(+), 1 deletion(-)

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
index 0b6379adff6b..b5ec75164805 100644
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
+	    unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
+		return false;
+
 	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
 		return false;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..99467ba5f55b 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -370,6 +370,10 @@ static int check_ptrace_options(unsigned long data)
 	if (data & ~(unsigned long)PTRACE_O_MASK)
 		return -EINVAL;
 
+	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH) &&
+	    (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART)))
+			return -EINVAL;
+
 	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
 		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
 		    !IS_ENABLED(CONFIG_SECCOMP))
-- 
2.39.0

