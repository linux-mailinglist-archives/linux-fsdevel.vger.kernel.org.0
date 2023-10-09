Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23117BDB27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346683AbjJIMPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbjJIMOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:14:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB361BD1;
        Mon,  9 Oct 2023 05:13:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCB5C43395;
        Mon,  9 Oct 2023 12:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696853587;
        bh=E2gRzIKAAZCXusVDWf1D5bQzl21y5pQx3M5rhoickm0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DfxThh3JD9h1tOr6J5VYdfQd4aCvkngudYG5TecsG7vkGYuC35Q80neOaDu6Tbny3
         rYdJcf4Z/S4JZmg0CAeSvONbOti9zln+C7neG4Vf86ChE2Mta/qf372narPM63V8O4
         pZi4HYe9kK9lHF6zKKaF0kBs20M2CYaBCgk4jsg9kxvgh0WEJHKqussFVu+wD0Qj8l
         exXX68bKmGAEYYIhseFueDHD4rEWnEt73UlBhpnZkZuSLkYwHg5c4oQOdDCs+D0oa/
         J4AFMlo42agVepPlqtIEifI5v6p+Zo7ia5shuBI5uCm6cwApjChHrrbO8MZGL679q4
         EJZONL4I72DXg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 09 Oct 2023 13:08:55 +0100
Subject: [PATCH v6 21/38] arm64/gcs: Allocate a new GCS for threads with
 GCS enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-arm64-gcs-v6-21-78e55deaa4dd@kernel.org>
References: <20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org>
In-Reply-To: <20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org>
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
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5172; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E2gRzIKAAZCXusVDWf1D5bQzl21y5pQx3M5rhoickm0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlI+2hQ86d3PPUInKcJHG5iSyi18S/kyJjbjGChV3k
 KtZIv9uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZSPtoQAKCRAk1otyXVSH0JBVB/
 9gNePxI0Zw/qlNdC1P5YbfLS0mCs1hDryY8iNHtyG5iv6tWakcE03on8SkNYa2TyeV1OydkoqWHKuY
 f0o9+onuTPpxlE0M5XeF7Q61az2uZqpJ/6mGH3zIODsz+Md7CFkp4qYDMn3uPFn8uVZLVaY5FuC1Nw
 WueTGn9bybX9TklFREMnvNoD4RlGceACd+YtAfCM7bRBHlSVXxstlgfgW02nqRgMJu9K5Hh9T3yB8v
 JAlVMUr+LBseMtXMVVQGv/aeq9AYUoiv/IDlGrOe8xQ4u8uDYsJ5lIvYLv4whZcFxEa0YW0EwWCDLM
 4YFrFzSM33KvcTwbHPvv/8tHTE17Pq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We do not currently have a mechanism to specify a new GCS for a new
thread so when a thread is created which has GCS enabled allocate one
for it.  Since there is no current API for specifying the size of the
GCS we follow the extensively discussed x86 implementation and allocate
min(RLIMIT_STACK, 4G).  Since the GCS only stores the call stack and not
any variables this should be more than sufficient for most applications.

When allocating the stack we initialise GCSPR_EL0 to point to one entry
below the end of the region allocated, this keeps the top entry of the
stack 0 so software walking the GCS can easily detect the end of the
region.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |  7 +++++++
 arch/arm64/kernel/process.c  | 36 +++++++++++++++++++++++++++++++++
 arch/arm64/mm/gcs.c          | 47 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 04594ef59dad..4371a2f99b4a 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -58,6 +58,8 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 void gcs_set_el0_mode(struct task_struct *task);
 void gcs_free(struct task_struct *task);
 void gcs_preserve_current_state(void);
+unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+			    unsigned long clone_flags, size_t size);
 
 #else
 
@@ -69,6 +71,11 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 static inline void gcs_set_el0_mode(struct task_struct *task) { }
 static inline void gcs_free(struct task_struct *task) { }
 static inline void gcs_preserve_current_state(void) { }
+static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+				     unsigned long clone_flags, size_t size)
+{
+	return -ENOTSUPP;
+}
 
 #endif
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 84bac012f744..bc4f73fb0713 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -285,9 +285,40 @@ static void flush_gcs(void)
 	write_sysreg_s(0, SYS_GCSPR_EL0);
 }
 
+static int copy_thread_gcs(struct task_struct *p, unsigned long clone_flags,
+			   size_t stack_size)
+{
+	unsigned long gcs;
+
+	if (!system_supports_gcs())
+		return 0;
+
+	if (!task_gcs_el0_enabled(p))
+		return 0;
+
+	p->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+		return 0;
+
+	/* Ensure the current state of the GCS is seen by CoW */
+	gcsb_dsync();
+
+	gcs = gcs_alloc_thread_stack(p, clone_flags, stack_size);
+	if (IS_ERR_VALUE(gcs))
+		return PTR_ERR((void *)gcs);
+
+	return 0;
+}
+
 #else
 
 static void flush_gcs(void) { }
+static int copy_thread_gcs(struct task_struct *p, unsigned long clone_flags,
+			   size_t stack_size)
+{
+	return 0;
+}
 
 #endif
 
@@ -369,6 +400,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long stack_start = args->stack;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
+	int ret;
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
@@ -410,6 +442,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 			p->thread.uw.tp_value = tls;
 			p->thread.tpidr2_el0 = 0;
 		}
+
+		ret = copy_thread_gcs(p, clone_flags, args->stack_size);
+		if (ret != 0)
+			return ret;
 	} else {
 		/*
 		 * A kthread has no context to ERET to, so ensure any buggy
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index b0a67efc522b..cb0a64bf90af 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -8,6 +8,53 @@
 #include <asm/cpufeature.h>
 #include <asm/page.h>
 
+static unsigned long alloc_gcs(unsigned long addr, unsigned long size,
+			       unsigned long token_offset, bool set_res_tok)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	struct mm_struct *mm = current->mm;
+	unsigned long mapped_addr, unused;
+
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
+
+	mmap_write_lock(mm);
+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ | PROT_WRITE, flags,
+			      VM_SHADOW_STACK, 0, &unused, NULL);
+	mmap_write_unlock(mm);
+
+	return mapped_addr;
+}
+
+static unsigned long gcs_size(unsigned long size)
+{
+	if (size)
+		return PAGE_ALIGN(size);
+
+	/* Allocate RLIMIT_STACK/2 with limits of PAGE_SIZE..2G */
+	size = PAGE_ALIGN(min_t(unsigned long long,
+				rlimit(RLIMIT_STACK) / 2, SZ_2G));
+	return max(PAGE_SIZE, size);
+}
+
+unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+				     unsigned long clone_flags, size_t size)
+{
+	unsigned long addr;
+
+	size = gcs_size(size);
+
+	addr = alloc_gcs(0, size, 0, 0);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	tsk->thread.gcs_base = addr;
+	tsk->thread.gcs_size = size;
+	tsk->thread.gcspr_el0 = addr + size - sizeof(u64);
+
+	return addr;
+}
+
 /*
  * Apply the GCS mode configured for the specified task to the
  * hardware.

-- 
2.30.2

