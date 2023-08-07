Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76568773270
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 00:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHGWFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 18:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjHGWFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F32680;
        Mon,  7 Aug 2023 15:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E5862291;
        Mon,  7 Aug 2023 22:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BB3C4339A;
        Mon,  7 Aug 2023 22:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445811;
        bh=2KK/mGoHJbatstMicr5F2Ynx8xFfeN5q4Dmfeo7bTNE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ytg+tOV7+zRYzXcKtYz+aTBjb4TePeGTtv6fNHDqti3E74faEATUyxlcVKmEmctVF
         n0mdG4is8qr20/cuNimsjbWoIpvEnHxBqqFJHn0csKQJ00AsgGOW+gRVhqqH4M0Mdn
         avd2S0HNSACUUZeuD1DmwjqNHMQx211egQw66mJOA7ulBy3OYxdEuGDV2g4TfAigs/
         AHKAaavmqQpSY3gxtUSat6dRRB5CUwkeWdf6asQva0y9GuqcDIDoE67Xr0Pb5+ewiu
         CkOt8uFjDHYMq/+HxM8KmitCYbstOY3gx5ZeMO07mseoD7B1f1kXvrFrwBOutx3VVk
         oZyp2bc0uxPCg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:00:24 +0100
Subject: [PATCH v4 19/36] arm64/gcs: Allocate a new GCS for threads with
 GCS enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-gcs-v4-19-68cfa37f9069@kernel.org>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
In-Reply-To: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
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
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5142; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2KK/mGoHJbatstMicr5F2Ynx8xFfeN5q4Dmfeo7bTNE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0WmnwdJIM2X4zNIIdcYbprLlCRvxUgKxKl2+LhCm
 JT614omJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFppwAKCRAk1otyXVSH0EkJB/
 4kBL8J5Q2sAomH5KA43BnG4Bye1MDjIyvGNFKReJFsRz4+gkHmDRKTQ+WZ1DMreNewUseP+6OiOjBn
 rdV+8+ZB2WJOA7I9dwHFL4UweMVu4nhbF/fNCJsDM6tMFcbPB12HG6DUl8slTWRHL888PyIr55FsQS
 DHn1EAlDMQSiHVPGcXlXCWCFyvyO46wWbKAT3EhBHq1ct7dWsns0sG7FE0L4yuI8kp+Jdu1ZJf7Zk7
 WJAfDrMRhf6EAUD8I1s2QsdX3yZzhsJDK9gufCV+CohO0hwy2HBmiiA5BI/MO8DjmjR3EBt+Q5J1Mm
 9p+ZmreL3Z6r54fDRF/MGKEOUNODEQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/include/asm/gcs.h |  7 ++++++
 arch/arm64/kernel/process.c  | 30 ++++++++++++++++++++++++
 arch/arm64/mm/gcs.c          | 56 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

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
index b8a42471aea3..1de6371ca2d8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -284,9 +284,34 @@ static void flush_gcs(void)
 	}
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
 
@@ -368,6 +393,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long stack_start = args->stack;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
+	int ret;
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
@@ -409,6 +435,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
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
index b0a67efc522b..1e059c37088d 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -8,6 +8,62 @@
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
+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
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
+	/* Allocate RLIMIT_STACK with limits of PAGE_SIZE..4G */
+	size = PAGE_ALIGN(min_t(unsigned long long,
+				rlimit(RLIMIT_STACK), SZ_4G));
+	return max(PAGE_SIZE, size);
+}
+
+unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+				     unsigned long clone_flags, size_t size)
+{
+	unsigned long addr;
+
+	if (!system_supports_gcs())
+		return 0;
+
+	if (!task_gcs_el0_enabled(tsk))
+		return 0;
+
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+		return 0;
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

