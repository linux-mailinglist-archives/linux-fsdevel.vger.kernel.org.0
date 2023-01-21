Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9756765B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 11:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAUKXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 05:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAUKX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:23:27 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8B45BF0;
        Sat, 21 Jan 2023 02:23:25 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j9so6140417qtv.4;
        Sat, 21 Jan 2023 02:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgFqur+BidWWWQr7r2LPXldx8oTQot1Qp1tXD/WiXfY=;
        b=Y60BRocz38pQeT9LNHp+OoXGPTE5kAuDg3kXW+KKqMXkJ1wrdemi6j2so6grTKGJJt
         VaODOSwRAlmo2HB09dnLSkc5SPPADWxIayCQSspbs+j1KVBDMOAyAVeLiDswzBtRJdXl
         +9aDwn1LEoARBcTXYFikMtdcnEzRMDGHqZQ75lsTYpuP/7WFbLby/0UDh+P+4QBzGnf7
         l+POgSQDt1hgmlJFZLgcNrsx8iGxg2FJXw6p9NoZ385ZWpjRlVOWyc6ndulKsFDXBUUg
         ywRJq8es34UChKZYhajU64YCNZEiFlHAGih4QkYX1KVSNWwmg8XPW2KtfHfwS5jP8xAn
         69LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgFqur+BidWWWQr7r2LPXldx8oTQot1Qp1tXD/WiXfY=;
        b=S3IJXAGO7xcrPm2/t0ncdws6wkMyua7qFX6VP1k9yqOj0cMcFWd7aSMmZ0V5Zs5CQo
         e3fyPJrQrer4jriO4WrXfBkXPKbZ2x2hKGd+UuuZ1sl40Vk0HpUZ1mr6yNZUzPRBtFl8
         fc+nU0duZsgy1xI4ZI2sCYAHPNyIqJv7Pb4WeO8ck1NTa0BMk+R3MUSQePl9aw9g61ih
         I3mwExd/xDWaOHSTBzc6CnogypPvQAFU0BCDT0oUDjzzHYKJk416ZvcsOmWc2LgMIYNv
         VZtlSDX5sXUPQZBsoOrVMxJ1JeWl7wJYkH1GK1Wiu7dMn7Bztap0SE1TlI9nC6STNF63
         QUGA==
X-Gm-Message-State: AFqh2kqQRVtTLFhloxL/KPMTnpm4BzNGkN0DoPO+bXwALCGcx531S7eY
        +8Ooaos3T+QR4iT0mVnWG9HsBR52G/Rf
X-Google-Smtp-Source: AMrXdXuHQGEmCLoJYFISVqUDA492mFQpJoWc32U8Y4YOlLVLoy7qj3BAkQvnUl7dGluAVfy6aJpeiQ==
X-Received: by 2002:ac8:59ca:0:b0:3b6:6669:dd28 with SMTP id f10-20020ac859ca000000b003b66669dd28mr27405204qtf.18.1674296604839;
        Sat, 21 Jan 2023 02:23:24 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a44c200b006e42a8e9f9bsm14128630qkp.121.2023.01.21.02.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 02:23:24 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v4 3/3] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
Date:   Sat, 21 Jan 2023 05:23:16 -0500
Message-Id: <20230121102316.331935-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121102316.331935-1-gregory.price@memverge.com>
References: <20230121102316.331935-1-gregory.price@memverge.com>
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
 include/linux/syscall_user_dispatch.h         | 19 ++++++++
 include/uapi/linux/ptrace.h                   | 10 ++++
 kernel/entry/syscall_user_dispatch.c          | 46 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++++
 5 files changed, 88 insertions(+), 1 deletion(-)

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
index b5ec75164805..a303c8de59af 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -111,3 +111,49 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 
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
+	if (test_syscall_work(SYSCALL_USER_DISPATCH))
+		config.mode = PR_SYS_DISPATCH_ON;
+	else
+		config.mode = PR_SYS_DISPATCH_OFF;
+
+	config.offset = sd->offset;
+	config.len = sd->len;
+	config.selector = sd->selector;
+	config.on_dispatch = sd->on_dispatch;
+
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
index a348b68d07a2..76de46e080e2 100644
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

