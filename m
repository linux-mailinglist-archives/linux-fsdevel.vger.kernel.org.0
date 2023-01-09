Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D2662A2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjAIPi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjAIPhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:37:37 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61C5C1ED;
        Mon,  9 Jan 2023 07:34:14 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id a25so957052qto.10;
        Mon, 09 Jan 2023 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aL7JeVTqAwg/RXtwS8yjASi+//+/JwdZxNzAPAGgnY=;
        b=lxflmllJcp9PPhY/2Pqsh0Zuo2eyUF/aulPZ2b+P6UZJY5JjeHhnpNfdBl4PRe+Z9k
         PXk4oPeMHOV98ud1xN18UL7dSeQjwdiRKaDMmkkk332Nxj463ecjN31DntQKRDMcicnl
         MEy28r+JnxX2k72+zpPSzogcrAtDUcjF4Vfirk4rEM/Le7oYGtlV8QJSdKoP3/waEQLH
         QQmzny4aAgdkZEImY8gMqMHS7LGdbLK1UI5Ybq1ZQw1ModxVs0ckxo8vlmiP2SZEEdwa
         QbT/2Pi+mCVQ2gSc7qH+7ZHtZ3oGoQ+Nbaz0e+NiV38+mYh8Ay8sIoeDgVW/BuTGA4sX
         VZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aL7JeVTqAwg/RXtwS8yjASi+//+/JwdZxNzAPAGgnY=;
        b=Wr2/0z0oCFcW/7+YbUsbfkT2PiNe0CJR4uiIrVTMoLIHc7QUke4CvRbIt3CF9k0u8R
         j7tWr/n5BIf7FZfC64MRaT0be4L3CVV/T83wMN+gC3pgBjXz6zaZR+YtyQPHgA1y7bLt
         JaWpvlO7vt2z34+YFNDjBrFziwqHyiMIxzG0Uw91L5g/f+j1LdNsuApxLHC+G8uJYFhD
         ZTjXHl4eVCPib/7EvU6Q6E1KMt2iXuFPf7+PhjD/gHw8+cAWddYA/FFAhJtJhSafUEFw
         fQdb5CJhkmT7uPLrV+mfp8mFGnM06Wzhg9VXq6Z6anrl4ldS94VQa12/rkx+1XkiTHgr
         G3Bg==
X-Gm-Message-State: AFqh2kpNpty1oZN+Ly81M2NzvaICy4aYY5KG24to0GC/TQo2wiqZ7nTX
        77mVLvnyjew1kIcvowmpQ73msFTkWA==
X-Google-Smtp-Source: AMrXdXsM7j5rXSNW5Wjc9Qg9ItWb7vUFxI7zM+ztcKxx9UyonVKCPXbpHCjg9c7eAAAkARc4oKG1Wg==
X-Received: by 2002:ac8:4d83:0:b0:3a8:1600:e60f with SMTP id a3-20020ac84d83000000b003a81600e60fmr85708193qtw.14.1673278453096;
        Mon, 09 Jan 2023 07:34:13 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id f1-20020ac81341000000b003a6a19ee4f0sm4687236qtj.33.2023.01.09.07.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:34:12 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 3/3] prctl,syscall_user_dispatch: add a getter for configuration info
Date:   Mon,  9 Jan 2023 10:33:48 -0500
Message-Id: <20230109153348.5625-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230109153348.5625-1-gregory.price@memverge.com>
References: <20230109153348.5625-1-gregory.price@memverge.com>
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

This patch implements simple getter interface for syscall user dispatch
configuration info.

To support checkpoint/resume of a syscall user dispatch process,
the prctl settings for syscall user dispatch must be fetchable.
Presently, these settings are write-only, making it impossible to
implement transparent checkpoint (coordination with the software is
required).

As Syscall User Dispatch is explicitly not for secure-container
development, exposing the configuration state via prctl does not
violate the original design intent.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     | 18 +++++++
 include/linux/syscall_user_dispatch.h         |  7 +++
 include/uapi/linux/prctl.h                    |  3 ++
 kernel/entry/syscall_user_dispatch.c          | 14 +++++
 kernel/sys.c                                  |  4 ++
 .../syscall_user_dispatch/sud_test.c          | 54 +++++++++++++++++++
 6 files changed, 100 insertions(+)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..8b2c8b6441b7 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -45,6 +45,10 @@ only the syscall dispatcher address and the userspace key.
 As the ABI of these intercepted syscalls is unknown to Linux, these
 syscalls are not instrumentable via ptrace or the syscall tracepoints.
 
+A getter interface is supplied for the purpose of userland
+checkpoint/restore software being able to suspend and restore the
+current state of the system.
+
 Interface
 ---------
 
@@ -73,6 +77,20 @@ thread-wide, without the need to invoke the kernel directly.  selector
 can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
 Any other value should terminate the program with a SIGSYS.
 
+
+A thread can fetch the current Syscall User Dispatch configuration with the following prctl:
+
+  prctl(PR_GET_SYSCALL_USER_DISPATCH, <dispatch_config>))
+
+<dispatch_config> is a pointer to a ``struct syscall_user_dispatch`` as defined in ``linux/include/linux/syscall_user_dispatch.h``::
+
+  struct syscall_user_dispatch {
+        char __user *selector;
+        unsigned long offset;
+        unsigned long len;
+        bool    on_dispatch;
+  };
+
 Security Notes
 --------------
 
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..aab25e5b6496 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -16,6 +16,7 @@ struct syscall_user_dispatch {
 	bool		on_dispatch;
 };
 
+int get_syscall_user_dispatch(struct syscall_user_dispatch __user *usd);
 int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 			      unsigned long len, char __user *selector);
 
@@ -25,6 +26,12 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #else
 struct syscall_user_dispatch {};
 
+static inline int get_syscall_user_dispatch(
+	struct syscall_user_dispatch __user *usd)
+{
+	return -EINVAL;
+}
+
 static inline int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 					    unsigned long len, char __user *selector)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..221c0e369cc0 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,7 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/* Get Syscall User Dispatch configuraiton settings */
+#define PR_GET_SYSCALL_USER_DISPATCH	65
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index f097c06224c9..71441664571a 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -73,6 +73,20 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	return true;
 }
 
+int get_syscall_user_dispatch(struct syscall_user_dispatch __user *usd)
+{
+	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
+
+	if (usd) {
+		if (copy_to_user(usd, sd, sizeof(*sd)))
+			return -EFAULT;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 			      unsigned long len, char __user *selector)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e886..b762c49fc424 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2618,6 +2618,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = set_syscall_user_dispatch(arg2, arg3, arg4,
 						  (char __user *) arg5);
 		break;
+	case PR_GET_SYSCALL_USER_DISPATCH:
+		error = get_syscall_user_dispatch(
+			  (struct syscall_user_dispatch __user *) arg2);
+		break;
 #ifdef CONFIG_SCHED_CORE
 	case PR_SCHED_CORE:
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e..555912f3c192 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -35,6 +35,16 @@
 #define SYSCALL_DISPATCH_ON(x) ((x) = SYSCALL_DISPATCH_FILTER_BLOCK)
 #define SYSCALL_DISPATCH_OFF(x) ((x) = SYSCALL_DISPATCH_FILTER_ALLOW)
 
+#ifndef PR_GET_SYSCALL_USER_DISPATCH
+#define PR_GET_SYSCALL_USER_DISPATCH 65
+#endif
+struct syscall_user_dispatch {
+	char *selector;
+	unsigned long offset;
+	unsigned long len;
+	bool    on_dispatch;
+};
+
 /* Test Summary:
  *
  * - dispatch_trigger_sigsys: Verify if PR_SET_SYSCALL_USER_DISPATCH is
@@ -309,4 +319,48 @@ TEST(direct_dispatch_range)
 	}
 }
 
+
+TEST(get_dispatch_settings)
+{
+	int ret = 0;
+	struct syscall_user_dispatch usd;
+
+	glob_sel = SYSCALL_DISPATCH_FILTER_ALLOW;
+
+	/* Check the negative paths - bad user pointer */
+	ret = prctl(PR_GET_SYSCALL_USER_DISPATCH, NULL);
+	ASSERT_EQ(-1, ret) {
+		TH_LOG("Kernel reported success to accessing a NULL pointer");
+	}
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Get the settings prior to it being activated */
+	ret = prctl(PR_GET_SYSCALL_USER_DISPATCH, &usd);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel failed to fetch syscall user dispatch settings");
+	}
+
+	/* Make sure selector is off prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0L, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Failed to get Syscall User Dispatch settings");
+	}
+
+	/* sanity check the settings */
+	ret = prctl(PR_GET_SYSCALL_USER_DISPATCH, &usd);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Failed to get Syscall User Dispatch settings");
+	}
+	ASSERT_EQ(&glob_sel, usd.selector) {
+		TH_LOG("Selector is an unexpected pointer");
+	}
+	ASSERT_EQ(0, usd.offset) {
+		TH_LOG("Offset is an unexpected value");
+	}
+	ASSERT_EQ(0, usd.len) {
+		TH_LOG("Length is an unexpected value");
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.37.3

