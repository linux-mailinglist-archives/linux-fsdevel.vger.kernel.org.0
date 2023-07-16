Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2E755778
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGPVw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGPVw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24404E40;
        Sun, 16 Jul 2023 14:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97A860E71;
        Sun, 16 Jul 2023 21:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0CAC433D9;
        Sun, 16 Jul 2023 21:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544376;
        bh=pjsLx6b1K0x937g9y/oHkxJKpquxYt6WMLA+SQZbCw0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=D6u3/V1MrlLBNBjRRjCkDs71lTKKLdxk4UVJjERzJR5KtW04sDJdFN6DY4BPTv7r0
         aTfNC0/NB9GX79XAFYhU9VdVRzw7MQZB2TF5LJweHmcGzRshXudBtlTD2haZIuC5LP
         NaMVrAzn6EMq6cEbwRZ7uCadAgG/757FAaXVcG059B2O2THi3ybHajqxcaPXT14ni/
         6NChUcGdOlfnZpMRnwjiRdGcw3nrq4zpyK9Bx75LgEsUYLdTuKOLC/IWjPFQaqy28Z
         elrpk8hcyukSHOh6r8e7/i+jKu2gyDkRcAfCoKCGTMq/2lOlXbHU4FnmZICc8ziKLS
         FgyPVP92q+o+A==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:50:57 +0100
Subject: [PATCH 01/35] prctl: arch-agnostic prctl for shadow stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-1-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3582; i=broonie@kernel.org;
 h=from:subject:message-id; bh=98fSp9zoycOoO4JRBJGcJJdFtBdtqinfhtbljBoqJQI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGaPOeEvYK+HaBvmOtGw+GIVwaAEnOI6agwGJ0VT
 4ZZsfRKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmjwAKCRAk1otyXVSH0BEJB/
 9TsUZy5D4ijFFo1Dfdcl7QkdIYj1UVRzxptIb9l671dL338Gc6GZhPmT4VkT3f+hyJjVzVSMK0BwQx
 7fE6Izud5qO6BfUkfyU51nyNtrLB7yLggC9+jRTraTvq081sRTpALcQTMwAYjiw8BoH1aDx04+TDp5
 m9GAxFLqSAzAvANMpV53ulubFEhZCOy172JSzFniKE4JCODuwQFC/Lc1Ze7H5Y8LHJoEx4NnI3FvY5
 hCcDa2LqJ6vTvaleevbA95bGiuxuE3DnaUGiWqcw/ZREbyi7SKv2jlGrWefGv7OMxEAHprq0ZEDBHW
 aTwFGtJ3i24vZYlTquUCFDGTC9O7Iw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Deepak Gupta <debug@rivosinc.com>

Three architectures (x86, aarch64, riscv) have announced support for
shadow stack.  This patch adds arch-agnostic prtcl support to enable
/disable/get/set status of shadow stack and forward control (landing pad)
flow cfi statuses.

New prctls are
      - PR_GET_SHADOW_STACK_STATUS, PR_SET_SHADOW_STACK_STATUS

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
[Rebased onto current kernels, renumbering to track other allocations
 already upstream, dropping indirect LP, updating to pass arg to set
  by value, fix missing prototypes for weak functions and update title.
  -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mm.h         |  3 +++
 include/uapi/linux/prctl.h | 17 +++++++++++++++++
 kernel/sys.c               | 20 ++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 97eddc83d19c..bf16edf2fcd9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3947,4 +3947,7 @@ static inline void accept_memory(phys_addr_t start, phys_addr_t end)
 
 #endif
 
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_MM_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 3c36aeade991..9fdc77fa2bfe 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -305,4 +305,21 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+/*
+ * get shadow stack status for current thread. Assumes shadow stack is min 4 byte aligned.
+ * Note shadow stack can be 8 byte aligned on 64bit.
+ * Lower 2 bits can give status of locked and enabled/disabled.
+ * size and address range can be obtained via /proc/maps. get_shadow_stack_status will
+ * return base of shadow stack.
+ */
+#define PR_GET_SHADOW_STACK_STATUS      71
+/*
+ * set shadow stack status for current thread (including enabling, disabling or locking)
+ * note that it will only set the status and setup of the shadow stack. Allocating shadow
+ * stack should be done separately using mmap.
+ */
+#define PR_SET_SHADOW_STACK_STATUS      72
+# define PR_SHADOW_STACK_LOCK           (1UL << 0)
+# define PR_SHADOW_STACK_ENABLE         (1UL << 1)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 05f838929e72..ebf9ea5f0fae 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2302,6 +2302,16 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int __weak arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2720,6 +2730,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_GET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_shadow_stack_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_shadow_stack_status(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;

-- 
2.30.2

