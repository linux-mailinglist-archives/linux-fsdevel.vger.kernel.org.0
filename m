Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED07557D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGPV5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjGPV43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:56:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FD01701;
        Sun, 16 Jul 2023 14:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072A660EC4;
        Sun, 16 Jul 2023 21:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AC9C433CD;
        Sun, 16 Jul 2023 21:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544502;
        bh=sCynytFiMn0HVRaCw9wATO/MQrUseepmFl+nT2jYk/s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KjXrfm/wSRDdF+7YCpEGZEO+lSs+OqgoSQgrfDj9DVQZpExsCZkfUKQnOJVXYoE7P
         PfkNIr2tSuxKaaNcHBG9NeHHpfhOSd2atGj6izLAif7Q+YYeuwfnFSG7gum7gDbZm2
         QvxxHFaPdAYDUz3qiI2hZjYHGtBlt8SlAmXMu5nNgnYb2/cFvBWgDeYOyq9l/rOaRW
         N/g9cHAlpOjVSh6Bu0aNvQcLdlrK24PA5KHq9XuSuyaueqlrPX8b/yQw8c+JgGhSwo
         thBNYortK6za79ujqUOGOXut8DgdfS+5pXkJhCNIN8IqcACV9BWSmLG6W468TAJ/lf
         en3TjwAu0bUJQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:17 +0100
Subject: [PATCH 21/35] arm64/gcs: Implement shadow stack prctl() interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-21-bf567f93bba6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sCynytFiMn0HVRaCw9wATO/MQrUseepmFl+nT2jYk/s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGafpYt4RHzf+znR2MMO8WH/q7lZQApjc5kZAGv8
 bxNTw/6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmnwAKCRAk1otyXVSH0IvWB/
 0eBO46ZWbi3FkEnPnLnNDUJL2rLooaAWsLABOPnXo+GV5miqbDIJqOX2yx7A4yvqRY1vX5rppQvQou
 UunGCboCgcdlOHMc1YkJgbMIZu+8uvqCzs78QLUdI5SVQLMX/Oek6Qfdnv/K+pg1GnJoxoDJuBg84L
 BGOrkPGtB2/EIXhAhWPzi/rWeJDPBNkE8bBb8BmcWPY1zBXQC+uV/VQKDsSRyukIHE1w5z8ED9+nnv
 ols7/RmacQ5LnVCzH6YJVy+STu1EWtNuoScWdMP5ZHVfYs2/kzZGmIOw9POUPAkiqDXia5RGkEjBaE
 nV1BQO10tqr9If6MxXuD60AdR2bAUx
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

Implement the architecture neutral prtctl() interface for setting the
shadow stack status, this supports setting and reading the current GCS
configuration for the current thread.

Userspace can enable basic GCS functionality and additionally also
support for GCS pushes and arbatrary GCS stores.  It is expected that
this prctl() will be called very early in application startup, for
example by the dynamic linker, and not subsequently adjusted during
normal operation.  Users should carefully note that after enabling GCS
for a thread GCS will become active with no call stack so it is not
normally possible to return from the function that invoked the prctl().

State is stored per thread, enabling GCS for a thread causes a GCS to be
allocated for that thread.

Userspace may lock the current GCS configuration by specifying
PR_SHADOW_STACK_ENABLE_LOCK, this prevents any further changes to the
GCS configuration via any means.

If GCS is not being enabled then all flags other than _LOCK are ignored,
it is not possible to enable stores or pops without enabling GCS.

When disabling the GCS we do not free the allocated stack, this allows
for inspection of the GCS after disabling as part of fault reporting.
Since it is not an expected use case and since it presents some
complications in determining what to do with previously initialsed data
on the GCS attempts to reenable GCS after this are rejected.  This can
be revisted if a use case arises.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |  4 +++
 arch/arm64/mm/gcs.c          | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 4371a2f99b4a..8655ba8054c7 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -48,6 +48,10 @@ static inline u64 gcsss2(void)
 	return Xt;
 }
 
+#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK \
+	(PR_SHADOW_STACK_LOCK | PR_SHADOW_STACK_ENABLE | \
+	 PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH)
+
 #ifdef CONFIG_ARM64_GCS
 
 static inline bool task_gcs_el0_enabled(struct task_struct *task)
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 1e059c37088d..b137493c594d 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -93,3 +93,67 @@ void gcs_free(struct task_struct *task)
 	task->thread.gcs_base = 0;
 	task->thread.gcs_size = 0;
 }
+
+int arch_set_shadow_stack_status(struct task_struct *task, unsigned long arg)
+{
+	unsigned long gcs, size;
+
+	if (!system_supports_gcs())
+		return -EINVAL;
+
+	if (is_compat_thread(task_thread_info(task)))
+		return -EINVAL;
+
+	/* Reject unknown flags */
+	if (arg & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	/* If the task has been locked block any attempted changes */
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_LOCK)
+		return -EBUSY;
+
+	/* Drop flags other than lock if disabling */
+	if (!(arg & PR_SHADOW_STACK_ENABLE))
+		arg &= ~PR_SHADOW_STACK_LOCK;
+
+	/* If we are enabling GCS then make sure we have a stack */
+	if (arg & PR_SHADOW_STACK_ENABLE) {
+		if (!task_gcs_el0_enabled(task)) {
+			/* Do not allow GCS to be reenabled */
+			if (task->thread.gcs_base)
+				return -EINVAL;
+
+			size = gcs_size(0);
+			gcs = alloc_gcs(task->thread.gcspr_el0, size,
+					0, 0);
+			if (!gcs)
+				return -ENOMEM;
+
+			task->thread.gcspr_el0 = gcs + size - sizeof(u64);
+			task->thread.gcs_base = gcs;
+			task->thread.gcs_size = size;
+			if (task == current)
+				write_sysreg_s(task->thread.gcspr_el0,
+					       SYS_GCSPR_EL0);
+
+		}
+	}
+
+	task->thread.gcs_el0_mode = arg;
+	if (task == current)
+		gcs_set_el0_mode(task);
+
+	return 0;
+}
+
+int arch_get_shadow_stack_status(struct task_struct *task,
+				 unsigned long __user *arg)
+{
+	if (!system_supports_gcs())
+		return -EINVAL;
+
+	if (is_compat_thread(task_thread_info(task)))
+		return -EINVAL;
+
+	return put_user(task->thread.gcs_el0_mode, arg);
+}

-- 
2.30.2

