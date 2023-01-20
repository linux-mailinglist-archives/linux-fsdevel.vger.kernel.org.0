Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02896757B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjATOpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjATOp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:45:27 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70976D0DBF;
        Fri, 20 Jan 2023 06:44:50 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id r19so2415937ilt.7;
        Fri, 20 Jan 2023 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tm7r7/w+NTSuvZBNcrJh41bBRzvQQKHJ+pSw3+ziM6w=;
        b=d9hrNAP1hM3jAB/eHeVYlSgAOzwZ6HpHsmGPUB9k/S3hJoKV6ZKXsNpcifJyXeFd1Z
         hOsIOWnEERynuF11cD7WkoqawYUwuoJ3Oko5+nxiVlTcRTwod/Y08ApHYZdFv/69N3x6
         v9MBqMTqSHJ1jRPWVVrgVfaEOoYQgpn8+CiNEXrPULJtiYwH2upRnZlgDQ92UYnRqacO
         +ArPEu/p4v6CemcpChZMdHYXi3DqWUQuNGIcZPbLWWwrSwplUDoRiKj4j8QQ124qvPLu
         PvHYP1wruhHnATYaw3JLcYo1hI5MkbSDeSHwBKldHWWmqB6xofNCZYq4ARwcL7lgLRcR
         bY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm7r7/w+NTSuvZBNcrJh41bBRzvQQKHJ+pSw3+ziM6w=;
        b=I4g8cT52z8iYarGDPCf2cZmXvKee43p8UWz7fVYW5+VHE5krzr3NlY/ITmtOdQfl9i
         kaIho/EXJHU66L6zuluzuDE1S0iu0kP9C0Q1/X9xd9iJJj6+387C1LcszMz/S2foANcg
         MzAmJybWTLzTDiqLIo6xjDevy86+ABhUDpMAJ1vyAERX8a2RTs0AMB2cqLcvbrbZhU3p
         09iwsttRh8IR55Qr0Bl0Q92CifLLI9kvIej+7ttS0+QZpDpzfUqWbnF+15QcBoTwtN18
         xsnQn6Ee+7dXKvFdM8x8x8dZo4CoalRa8jfYbLOENinM0WUPOquMDUEhziL1C6PDKSWa
         boxg==
X-Gm-Message-State: AFqh2krutihkb46gButhchxjbK4IuRfLEDI4geddNpdLehRh/ac4A7VA
        LFYpmDORM7FQkbccN3fvG3BU/hzN89RA
X-Google-Smtp-Source: AMrXdXvFwKixDS/TIXDil0+nxTTZXuD9Hv1Pb5U4CyB5pJAmfEvnE626Cy7OLk1Q8SFJUdjAiwK6TA==
X-Received: by 2002:a92:2e09:0:b0:30f:1a48:b5ac with SMTP id v9-20020a922e09000000b0030f1a48b5acmr9475876ile.20.1674225859097;
        Fri, 20 Jan 2023 06:44:19 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id p185-20020a0229c2000000b003a7c47efde0sm1513852jap.11.2023.01.20.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:44:18 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 3/3] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
Date:   Fri, 20 Jan 2023 09:43:56 -0500
Message-Id: <20230120144356.40717-4-gregory.price@memverge.com>
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

Implement ptrace getter/setter interface for syscall user dispatch.

Presently, these settings are write-only via prctl, making it impossible
to implement transparent checkpoint (coordination with the software is
required).

This is modeled after a similar interface for SECCOMP, which can have
its configuration dumped by ptrace for software like CRIU.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  5 +-
 include/linux/syscall_user_dispatch.h         | 19 +++++++
 include/uapi/linux/ptrace.h                   | 10 ++++
 kernel/entry/syscall_user_dispatch.c          | 49 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++++
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..a23ae21a1d5b 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -43,7 +43,10 @@ doesn't rely on any of the syscall ABI to make the filtering.  It uses
 only the syscall dispatcher address and the userspace key.
 
 As the ABI of these intercepted syscalls is unknown to Linux, these
-syscalls are not instrumentable via ptrace or the syscall tracepoints.
+syscalls are not instrumentable via ptrace or the syscall tracepoints,
+however an interfaces to suspend, checkpoint, and restore syscall user
+dispatch configuration has been added to ptrace to assist userland
+checkpoint/restart software.
 
 Interface
 ---------
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..9e1bd0d87c1e 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,13 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
+
 #else
 struct syscall_user_dispatch {};
 
@@ -35,6 +42,18 @@ static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *
 {
 }
 
+static inline int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data)
+{
+	return -EINVAL;
+}
+
+static inline int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+	void __user *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_GENERIC_ENTRY */
 
 #endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index ba9e3f19a22c..8b93c78189b5 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,16 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
 
+#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
+#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
+struct syscall_user_dispatch_config {
+	__u64 mode;
+	__s8 *selector;
+	__u64 offset;
+	__u64 len;
+	__u8 on_dispatch;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index b5ec75164805..a3b24d498b39 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -111,3 +111,52 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 
 	return 0;
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+		void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct syscall_user_dispatch_config config;
+
+	if (size != sizeof(struct syscall_user_dispatch_config))
+		return -EINVAL;
+
+	if (sd->selector) {
+		config.mode = PR_SYS_DISPATCH_ON;
+		config.offset = sd->offset;
+		config.len = sd->len;
+		config.selector = sd->selector;
+		config.on_dispatch = sd->on_dispatch;
+	} else {
+		config.mode = PR_SYS_DISPATCH_OFF;
+		config.offset = 0;
+		config.len = 0;
+		config.selector = NULL;
+		config.on_dispatch = false;
+	}
+	if (copy_to_user(data, &config, sizeof(config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+		void __user *data)
+{
+	struct syscall_user_dispatch_config config;
+	int ret;
+
+	if (size != sizeof(struct syscall_user_dispatch_config))
+		return -EINVAL;
+
+	if (copy_from_user(&config, data, sizeof(config)))
+		return -EFAULT;
+
+	ret = set_syscall_user_dispatch(config.mode, config.offset, config.len,
+			config.selector);
+	if (ret)
+		return ret;
+
+	task->syscall_dispatch.on_dispatch = config.on_dispatch;
+	return 0;
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 99467ba5f55b..d1e9c0808905 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1263,6 +1264,14 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 #endif
 
+	case PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_set_config(child, addr, datavp);
+		break;
+
+	case PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_get_config(child, addr, datavp);
+		break;
+
 	default:
 		break;
 	}
-- 
2.39.0

