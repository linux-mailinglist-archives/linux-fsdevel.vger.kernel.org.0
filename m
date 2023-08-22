Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F192078432B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjHVOGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbjHVOGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2567E51;
        Tue, 22 Aug 2023 07:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73CB565792;
        Tue, 22 Aug 2023 14:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4D6C433C8;
        Tue, 22 Aug 2023 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713119;
        bh=O+hgb6HAJcyucIzKcwt3tnff8aEUiHSQ+f2DGknX0wM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZU/Mt79+mBjfWh8KUJcmJJItnIcx/zB6Fm8Q+yp6HYQEuBhPCHxfkwIn4dojMgk2p
         2Uf5PNZkBB0Q1+zfDT91CKyYa6zRjGODhB7jdb50yz4q4249xDmbFtba33JEyN9TFi
         lsTbIs0T2o1pVyiHmjHEIRElMKf7QhA3IXkpjqDK0f9Fg1oNphXqIZl+z+cJH6lw9U
         rSDqTC7UQ2KiB1Hxfck+E821kToTC2Yb/5C/fqqeaAQLW8HfGAQP80ZMBEWoi8DtzT
         jAZVvmtmQKz/AHyfkz8oaZIh8CIJhcq+MGPcMODyvugIgGnaEMG71Nmyx67LJ12CY6
         AUTdCCMpd7CrA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 22 Aug 2023 14:56:55 +0100
Subject: [PATCH v5 22/37] arm64/mm: Implement map_shadow_stack()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-arm64-gcs-v5-22-9ef181dd6324@kernel.org>
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
In-Reply-To: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4924; i=broonie@kernel.org;
 h=from:subject:message-id; bh=O+hgb6HAJcyucIzKcwt3tnff8aEUiHSQ+f2DGknX0wM=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBk5MABbsl98B0DZ02L45IJrxXjIIpMuYNsR9urERcI
 lQX8sKyJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOTAAQAKCRAk1otyXVSH0IKmB/
 i8vYStPzL6tmZ8N/SAyYvWs97/BrSQiCniMoiv7UQkwQqPEVB4gLSVLPVGJBRBpWvAC0NAIL2ZKoy6
 qXn032ELazlDeSMuydmyLeD6nXdNaykPRHI5jy2cGNpEIojFE1rM6R+i84xcR9NBFe5EcHPnDXPoEp
 jkKRrUDptk5eRoVH2Dz5jnMqVccEI43xfX4Q5q2rKJB/jf1i3wpo3cpnH3zCWc2xSnRZasKIH2zvbf
 a+MXqgZB7qcEuB8Akfr9ja65IUD3MrBldn2ngSpKMZ4Tyh5hNhNPmwEgFCJrqB6dv49Ygn3pNxp9vr
 LBS1RFeaM/Yp3Aelq/B5ztB5jlo7w=
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

As discussed extensively in the changelog for the addition of this
syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
existing mmap() and madvise() syscalls do not map entirely well onto the
security requirements for guarded control stacks since they lead to
windows where memory is allocated but not yet protected or stacks which
are not properly and safely initialised. Instead a new syscall
map_shadow_stack() has been defined which allocates and initialises a
shadow stack page.

Implement this for arm64.  Two flags are provided, allowing applications
to request that the stack be initialised with a valid cap token at the
top of the stack and optionally also an end of stack marker above that.
We support requesting an end of stack marker alone but since this is a
NULL pointer it is indistinguishable from not initialising anything by
itself.

Since the x86 code has not yet been rebased to v6.5-rc1 this includes
the architecture neutral parts of Rick Edgecmbe's "x86/shstk: Introduce
map_shadow_stack syscall".

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/gcs.c               | 58 ++++++++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h          |  1 +
 include/uapi/asm-generic/unistd.h |  5 +++-
 kernel/sys_ni.c                   |  1 +
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 2b2223b13fc3..2963041d1d64 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -43,7 +43,6 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	unsigned long addr;
 
 	size = gcs_size(size);
-
 	addr = alloc_gcs(0, size, 0, 0);
 	if (IS_ERR_VALUE(addr))
 		return addr;
@@ -55,6 +54,63 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	return addr;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	unsigned long alloc_size;
+	unsigned long __user *cap_ptr;
+	unsigned long cap_val;
+	int ret, cap_offset;
+
+	if (!system_supports_gcs())
+		return -EOPNOTSUPP;
+
+	if (flags & ~(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER))
+		return -EINVAL;
+
+	if (addr && (addr % PAGE_SIZE))
+		return -EINVAL;
+
+	if (size == 8 || size % 8)
+		return -EINVAL;
+
+	/*
+	 * An overflow would result in attempting to write the restore token
+	 * to the wrong location. Not catastrophic, but just return the right
+	 * error code and block it.
+	 */
+	alloc_size = PAGE_ALIGN(size);
+	if (alloc_size < size)
+		return -EOVERFLOW;
+
+	addr = alloc_gcs(addr, alloc_size, 0, false);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	/*
+	 * Put a cap token at the end of the allocated region so it
+	 * can be switched to.
+	 */
+	if (flags & SHADOW_STACK_SET_TOKEN) {
+		/* Leave an extra empty frame as a top of stack marker? */
+		if (flags & SHADOW_STACK_SET_MARKER)
+			cap_offset = 2;
+		else
+			cap_offset = 1;
+
+		cap_ptr = (unsigned long __user *)(addr + size -
+						   (cap_offset * sizeof(unsigned long)));
+		cap_val = GCS_CAP(cap_ptr);
+
+		ret = copy_to_user_gcs(cap_ptr, &cap_val, 1);
+		if (ret != 0) {
+			vm_munmap(addr, size);
+			return -EFAULT;
+		}
+	}
+
+	return addr;
+}
+
 /*
  * Apply the GCS mode configured for the specified task to the
  * hardware.
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 03e3d0121d5e..7f6dc0988197 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -953,6 +953,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
+asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index fd6c1cb585db..38885a795ea6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -820,8 +820,11 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
 
+#define __NR_map_shadow_stack 452
+__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
+
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 781de7cc6a4e..e137c1385c56 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -274,6 +274,7 @@ COND_SYSCALL(vm86old);
 COND_SYSCALL(modify_ldt);
 COND_SYSCALL(vm86);
 COND_SYSCALL(kexec_file_load);
+COND_SYSCALL(map_shadow_stack);
 
 /* s390 */
 COND_SYSCALL(s390_pci_mmio_read);

-- 
2.30.2

