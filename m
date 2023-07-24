Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0274F75F72F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGXMwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjGXMwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FA4487;
        Mon, 24 Jul 2023 05:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9419B61150;
        Mon, 24 Jul 2023 12:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326E7C433CB;
        Mon, 24 Jul 2023 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690202954;
        bh=oiakJxhCl2ggQgHDbaP+YYLLswWzPu+vDfVc2y5agDo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iW4c/cKlMkXGakJEmv5ZwTIxvq878gnNDj+1oSPH1KFmgWa6wBDpZxSUhj7nvUg0R
         C7EX0V38YzWq4SHlqfCI/khHXiWAYgGihlh5r0pD3fSIOgJLNmHqrVVQc90LoUiYV2
         78UomftH4dyLkiXIShFrg03qx0augPdJW5PvzhQYlbrdlVazVDdixcrfac6GMQaPOH
         psokPim4W/YjQvcX/EiPPgtL4JOiu9KUKxZMyBelYO9nJHA3UCs1i3KuzVjoznhZ4x
         BnQckU+EdV+0GilnY0gysLZXiNFw62zJxnzQuAJbSwrSSfz/hJ1Mjfob3plWceCAWu
         Ie1I6yA9wwfdg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 13:46:08 +0100
Subject: [PATCH v2 21/35] arm64/mm: Implement map_shadow_stack()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-gcs-v2-21-dc2c1d44c2eb@kernel.org>
References: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
In-Reply-To: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4500; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oiakJxhCl2ggQgHDbaP+YYLLswWzPu+vDfVc2y5agDo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvnKktMiW5/GsUPeWzIjvMe318oOP15ClcHBNUp4G
 MyFwT8yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL5ypAAKCRAk1otyXVSH0PNoB/
 9zFHT1nbXDtnhngqR1FqjYTuHzb8PFLjwSV3lGPDApwGMZUbIiH07S2VAlsQBAKasLM8PVd9fz280e
 cMzuJUk31R6C/icE3L4wa5pjg43SqaF/ViWBiD1gfXsqb67Q4D/eizuJy8uSsDCSUT295YUVhsWqvx
 I/DggO8L0BTSmd1MeKgyqhYr+1cbQ9VuewlaI3JYErjhqxxNDo1dn6Ete7+Zyhf6IbxnHo/bI9z6Jo
 MKQyU0WANNLBpdu2O9cdoKBa59xw7dolesWpa419qwAQ3eNv1C2CKkEBXnF9ARkGRXA0ysA7CJQOJ7
 sfqPYQo9jxN0xvTRaxLXDO3AaoYW+j
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Implement this for arm64, initialising memory allocated this way with
the top two entries in the stack being 0 (to allow detection of the end
of the GCS) and a GCS cap token (to allow switching to the newly
allocated GCS via the GCS switch instructions).

Since the x86 code has not yet been rebased to v6.5-rc1 this includes
the architecture neutral parts of Rick Edgecmbe's "x86/shstk: Introduce
map_shadow_stack syscall".

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/gcs.c               | 50 ++++++++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h          |  1 +
 include/uapi/asm-generic/unistd.h |  5 +++-
 kernel/sys_ni.c                   |  1 +
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 64c9f9a85925..c24fe367e15a 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -52,7 +52,6 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 		return 0;
 
 	size = gcs_size(size);
-
 	addr = alloc_gcs(0, size, 0, 0);
 	if (IS_ERR_VALUE(addr))
 		return addr;
@@ -64,6 +63,55 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	return addr;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	unsigned long alloc_size;
+	unsigned long __user *cap_ptr;
+	unsigned long cap_val;
+	int ret;
+
+	if (!system_supports_gcs())
+		return -EOPNOTSUPP;
+
+	if (flags)
+		return -EINVAL;
+
+	if (addr % 16)
+		return -EINVAL;
+
+	if (size == 16 || size % 16)
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
+	cap_ptr = (unsigned long __user *)(addr + size -
+					   (2 * sizeof(unsigned long)));
+	cap_val = GCS_CAP(cap_ptr);
+
+	ret = copy_to_user_gcs(cap_ptr, &cap_val, 1);
+	if (ret != 0) {
+		vm_munmap(addr, size);
+		return -EFAULT;
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

