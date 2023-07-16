Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014FC7557D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGPV45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGPV4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90181BF8;
        Sun, 16 Jul 2023 14:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC1C60EC9;
        Sun, 16 Jul 2023 21:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D98C433D9;
        Sun, 16 Jul 2023 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544490;
        bh=Rgc5Qgd3MxiPmSczNumLpnYq/5VM+tdWkyCFPClJUpc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=L0LM1PnPVqRj0EvQTmf9UWM0fykN7tpZjSVQRf7i/zGpPKsE/+6hSVAdvRbJbsQqW
         SNFiz09CLphfKRjxe1rnHXa6BD3W+2rQH/4aKqz49P5PNOFSomrsH9z2MasbpaNjkY
         HiGzvE6YSZwRel3WWmbrhkNSzrNgbxXENJTgwQmZa+Hh9Ou9PU+WLwFtmqgUtMVbEi
         J37vhncJ8izUqQvagozEUcvWDJNKa0z7rF7UnNp+IK++ys4fX63SiBJJlARbfFuCp6
         cixT0o3KAKRnUfW7y6N6BwjmnfuU5sA7jxylnHvIjQBWFkdmmIxPYzRjnCV9hv3BwW
         PO1hnzw5bUioA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:15 +0100
Subject: [PATCH 19/35] arm64/gcs: Context switch GCS registers for EL0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-19-bf567f93bba6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6274; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Rgc5Qgd3MxiPmSczNumLpnYq/5VM+tdWkyCFPClJUpc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGaeVpFJs5nBnOgOtGTa05DxettjuHoqUtmvd9PY
 CfYG0NaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmngAKCRAk1otyXVSH0M9gB/
 4/JP0lf//e3wM7Ga3dNyAUezn7ZksBtTvGPYrDTMhI6s/mD33X/PVDthOLZzGPzMYPkYqqe6OCZgLt
 qd98HEz6WAxXxgKild0ELIVQ4Vd2I5iBVcchc94h3GE3M1DPNZ7zJIEg9u71pkUkzf+jSbLzspGuHj
 tcIGt8nI+xGu82AEC3YniPbsv53R7H9vw74JNW/RpH8ymupodgpMicoGapDNhIJWPVflml8fkSSOL3
 CW08JkIiazPE+koHIyTDOBEQpaZspeknYAfO6/Jvo4yO0QIYSyme5nMB3eNUqk62nsBjzGy8WL+bUO
 UgEysdhG3TRK4BlrNp4zfhDnsQjc0N
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two registers controlling the GCS state of EL0, GCSPR_EL0 which
is the current GCS pointer and GCSCRE0_EL1 which has enable bits for the
specific GCS functionality enabled for EL0. Manage these on context switch
and process lifetime events, GCS is reset on exec().

Since the current GCS configuration of a thread will be visible to
userspace we store the configuration in the format used with userspace
and provide a helper which configures the system register as needed.

On systems that support GCS we always allow access to GCSPR_EL0, this
facilitates reporting of GCS faults if userspace implements disabling of
GCS on error - the GCS can still be discovered and examined even if GCS
has been disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h       | 24 +++++++++++++++++++
 arch/arm64/include/asm/processor.h |  6 +++++
 arch/arm64/kernel/process.c        | 47 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/gcs.c                | 39 +++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 7c5e95218db6..04594ef59dad 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -48,4 +48,28 @@ static inline u64 gcsss2(void)
 	return Xt;
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+static inline bool task_gcs_el0_enabled(struct task_struct *task)
+{
+	return current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE;
+}
+
+void gcs_set_el0_mode(struct task_struct *task);
+void gcs_free(struct task_struct *task);
+void gcs_preserve_current_state(void);
+
+#else
+
+static inline bool task_gcs_el0_enabled(struct task_struct *task)
+{
+	return false;
+}
+
+static inline void gcs_set_el0_mode(struct task_struct *task) { }
+static inline void gcs_free(struct task_struct *task) { }
+static inline void gcs_preserve_current_state(void) { }
+
+#endif
+
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 3918f2a67970..f1551228a143 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -179,6 +179,12 @@ struct thread_struct {
 	u64			sctlr_user;
 	u64			svcr;
 	u64			tpidr2_el0;
+#ifdef CONFIG_ARM64_GCS
+	unsigned int		gcs_el0_mode;
+	u64			gcspr_el0;
+	u64			gcs_base;
+	u64			gcs_size;
+#endif
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0fcc4eb1a7ab..0d07f78b6c85 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -48,6 +48,7 @@
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
+#include <asm/gcs.h>
 #include <asm/mmu_context.h>
 #include <asm/mte.h>
 #include <asm/processor.h>
@@ -271,12 +272,30 @@ static void flush_tagged_addr_state(void)
 		clear_thread_flag(TIF_TAGGED_ADDR);
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+static void flush_gcs(void)
+{
+	if (system_supports_gcs()) {
+		gcs_free(current);
+		write_sysreg_s(0, SYS_GCSCRE0_EL1);
+		write_sysreg_s(0, SYS_GCSPR_EL0);
+	}
+}
+
+#else
+
+static void flush_gcs(void) { }
+
+#endif
+
 void flush_thread(void)
 {
 	fpsimd_flush_thread();
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
+	flush_gcs();
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -474,6 +493,33 @@ static void entry_task_switch(struct task_struct *next)
 	__this_cpu_write(__entry_task, next);
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+void gcs_preserve_current_state(void)
+{
+	if (task_gcs_el0_enabled(current))
+		current->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+}
+
+static void gcs_thread_switch(struct task_struct *next)
+{
+	if (!system_supports_gcs())
+		return;
+
+	gcs_preserve_current_state();
+
+	gcs_set_el0_mode(next);
+	write_sysreg_s(next->thread.gcspr_el0, SYS_GCSPR_EL0);
+}
+
+#else
+
+static void gcs_thread_switch(struct task_struct *next)
+{
+}
+
+#endif
+
 /*
  * ARM erratum 1418040 handling, affecting the 32bit view of CNTVCT.
  * Ensure access is disabled when switching to a 32bit task, ensure
@@ -533,6 +579,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(next);
 	ptrauth_thread_switch_user(next);
+	gcs_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index dbd1bc95967d..4e7cb2f02999 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
 obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
+obj-$(CONFIG_ARM64_GCS)		+= gcs.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
new file mode 100644
index 000000000000..b0a67efc522b
--- /dev/null
+++ b/arch/arm64/mm/gcs.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+
+#include <asm/cpufeature.h>
+#include <asm/page.h>
+
+/*
+ * Apply the GCS mode configured for the specified task to the
+ * hardware.
+ */
+void gcs_set_el0_mode(struct task_struct *task)
+{
+	u64 gcscre0_el1 = GCSCRE0_EL1_nTR;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE)
+		gcscre0_el1 |= GCSCRE0_EL1_RVCHKEN | GCSCRE0_EL1_PCRSEL;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_WRITE)
+		gcscre0_el1 |= GCSCRE0_EL1_STREn;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_PUSH)
+		gcscre0_el1 |= GCSCRE0_EL1_PUSHMEn;
+
+	write_sysreg_s(gcscre0_el1, SYS_GCSCRE0_EL1);
+}
+
+void gcs_free(struct task_struct *task)
+{
+	if (task->thread.gcs_base)
+		vm_munmap(task->thread.gcs_base, task->thread.gcs_size);
+
+	task->thread.gcspr_el0 = 0;
+	task->thread.gcs_base = 0;
+	task->thread.gcs_size = 0;
+}

-- 
2.30.2

