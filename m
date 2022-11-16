Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D662B98F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiKPKnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238575AbiKPKm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:42:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A163FB9D
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668594605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZsyOpdl0voGwp/2HQsh2gXxw68zLpPACCuw4AqnFM0=;
        b=Hd39HWZ9ZocgY2pHGZL8SXzUlE6aDZbG7oY+3Dwp4tHYTMqQx0NOa1yRA10B54UFjaUEGq
        zD4jau259ZorPlTVPr79ahzProl64JKrk4Pf/l7kaMGk2KfhDRMhQSgZifjVO9G6MM2OSc
        B6GF//5z2pzHRe9I7MOX1tqC7Gk98gw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-uvWfBmc3PGG4yxhlAu7-Aw-1; Wed, 16 Nov 2022 05:30:04 -0500
X-MC-Unique: uvWfBmc3PGG4yxhlAu7-Aw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A0592A5957A;
        Wed, 16 Nov 2022 10:30:03 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39CE3207AD4C;
        Wed, 16 Nov 2022 10:29:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
Date:   Wed, 16 Nov 2022 11:26:59 +0100
Message-Id: <20221116102659.70287-21-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's make it clearer that functionality provided by FOLL_FORCE is
really only for ptrace access. Prevent accidental re-use in drivers
by renaming FOLL_FORCE to FOLL_PTRACE:

  git grep -l 'FOLL_FORCE' | xargs sed -i 's/FOLL_FORCE/FOLL_PTRACE/g'

In the future, we might want to use a separate set of flags for the
access_vm interface: most FOLL_* flags don't apply and we mostly only
want to pass FOLL_PTRACE and FOLL_WRITE.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/alpha/kernel/ptrace.c            |  6 +++---
 arch/arm64/kernel/mte.c               |  2 +-
 arch/ia64/kernel/ptrace.c             | 10 +++++-----
 arch/mips/kernel/ptrace32.c           |  4 ++--
 arch/mips/math-emu/dsemul.c           |  2 +-
 arch/powerpc/kernel/ptrace/ptrace32.c |  4 ++--
 arch/sparc/kernel/ptrace_32.c         |  4 ++--
 arch/sparc/kernel/ptrace_64.c         |  8 ++++----
 arch/x86/kernel/step.c                |  2 +-
 arch/x86/um/ptrace_32.c               |  2 +-
 arch/x86/um/ptrace_64.c               |  2 +-
 fs/exec.c                             |  2 +-
 fs/proc/base.c                        |  2 +-
 include/linux/mm.h                    |  8 ++++----
 kernel/events/uprobes.c               |  4 ++--
 kernel/ptrace.c                       | 12 ++++++------
 mm/gup.c                              | 28 +++++++++++++--------------
 mm/huge_memory.c                      |  8 ++++----
 mm/hugetlb.c                          |  2 +-
 mm/memory.c                           |  4 ++--
 mm/util.c                             |  4 ++--
 security/tomoyo/domain.c              |  2 +-
 22 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index a1a239ea002d..55def6479ff2 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -158,7 +158,7 @@ static inline int
 read_int(struct task_struct *task, unsigned long addr, int * data)
 {
 	int copied = access_process_vm(task, addr, data, sizeof(int),
-			FOLL_FORCE);
+			FOLL_PTRACE);
 	return (copied == sizeof(int)) ? 0 : -EIO;
 }
 
@@ -166,7 +166,7 @@ static inline int
 write_int(struct task_struct *task, unsigned long addr, int data)
 {
 	int copied = access_process_vm(task, addr, &data, sizeof(int),
-			FOLL_FORCE | FOLL_WRITE);
+			FOLL_PTRACE | FOLL_WRITE);
 	return (copied == sizeof(int)) ? 0 : -EIO;
 }
 
@@ -284,7 +284,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
 	case PTRACE_PEEKDATA:
 		copied = ptrace_access_vm(child, addr, &tmp, sizeof(tmp),
-				FOLL_FORCE);
+				FOLL_PTRACE);
 		ret = -EIO;
 		if (copied != sizeof(tmp))
 			break;
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 7467217c1eaf..fa29fecaedbc 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -525,7 +525,7 @@ int mte_ptrace_copy_tags(struct task_struct *child, long request,
 	int ret;
 	struct iovec kiov;
 	struct iovec __user *uiov = (void __user *)data;
-	unsigned int gup_flags = FOLL_FORCE;
+	unsigned int gup_flags = FOLL_PTRACE;
 
 	if (!system_supports_mte())
 		return -EIO;
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index ab8aeb34d1d9..3781db1f506c 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -452,7 +452,7 @@ ia64_peek (struct task_struct *child, struct switch_stack *child_stack,
 			return 0;
 		}
 	}
-	copied = access_process_vm(child, addr, &ret, sizeof(ret), FOLL_FORCE);
+	copied = access_process_vm(child, addr, &ret, sizeof(ret), FOLL_PTRACE);
 	if (copied != sizeof(ret))
 		return -EIO;
 	*val = ret;
@@ -489,7 +489,7 @@ ia64_poke (struct task_struct *child, struct switch_stack *child_stack,
 			}
 		}
 	} else if (access_process_vm(child, addr, &val, sizeof(val),
-				FOLL_FORCE | FOLL_WRITE)
+				FOLL_PTRACE | FOLL_WRITE)
 		   != sizeof(val))
 		return -EIO;
 	return 0;
@@ -544,7 +544,7 @@ ia64_sync_user_rbs (struct task_struct *child, struct switch_stack *sw,
 		if (ret < 0)
 			return ret;
 		if (access_process_vm(child, addr, &val, sizeof(val),
-				FOLL_FORCE | FOLL_WRITE)
+				FOLL_PTRACE | FOLL_WRITE)
 		    != sizeof(val))
 			return -EIO;
 	}
@@ -561,7 +561,7 @@ ia64_sync_kernel_rbs (struct task_struct *child, struct switch_stack *sw,
 	/* now copy word for word from user rbs to kernel rbs: */
 	for (addr = user_rbs_start; addr < user_rbs_end; addr += 8) {
 		if (access_process_vm(child, addr, &val, sizeof(val),
-				FOLL_FORCE)
+				FOLL_PTRACE)
 				!= sizeof(val))
 			return -EIO;
 
@@ -1105,7 +1105,7 @@ arch_ptrace (struct task_struct *child, long request,
 	case PTRACE_PEEKDATA:
 		/* read word at location addr */
 		if (ptrace_access_vm(child, addr, &data, sizeof(data),
-				FOLL_FORCE)
+				FOLL_PTRACE)
 		    != sizeof(data))
 			return -EIO;
 		/* ensure return value is not mistaken for error code */
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index afcf27a877cb..31c1c805bb8e 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -71,7 +71,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 
 		copied = ptrace_access_vm(child, (u64)addrOthers, &tmp,
-				sizeof(tmp), FOLL_FORCE);
+				sizeof(tmp), FOLL_PTRACE);
 		if (copied != sizeof(tmp))
 			break;
 		ret = put_user(tmp, (u32 __user *) (unsigned long) data);
@@ -185,7 +185,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		ret = 0;
 		if (ptrace_access_vm(child, (u64)addrOthers, &data,
 					sizeof(data),
-					FOLL_FORCE | FOLL_WRITE) == sizeof(data))
+					FOLL_PTRACE | FOLL_WRITE) == sizeof(data))
 			break;
 		ret = -EIO;
 		break;
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index e02bd20b60a6..6111a46de2df 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -271,7 +271,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
 	/* Write the frame to user memory */
 	fr_uaddr = (unsigned long)&dsemul_page()[fr_idx];
 	ret = access_process_vm(current, fr_uaddr, &fr, sizeof(fr),
-				FOLL_FORCE | FOLL_WRITE);
+				FOLL_PTRACE | FOLL_WRITE);
 	if (unlikely(ret != sizeof(fr))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		free_emuframe(fr_idx, current->mm);
diff --git a/arch/powerpc/kernel/ptrace/ptrace32.c b/arch/powerpc/kernel/ptrace/ptrace32.c
index 19c224808982..336cfebd70df 100644
--- a/arch/powerpc/kernel/ptrace/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace/ptrace32.c
@@ -65,7 +65,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 
 		copied = ptrace_access_vm(child, (u64)addrOthers, &tmp,
-				sizeof(tmp), FOLL_FORCE);
+				sizeof(tmp), FOLL_PTRACE);
 		if (copied != sizeof(tmp))
 			break;
 		ret = put_user(tmp, (u32 __user *)data);
@@ -169,7 +169,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		ret = 0;
 		if (ptrace_access_vm(child, (u64)addrOthers, &tmp,
 					sizeof(tmp),
-					FOLL_FORCE | FOLL_WRITE) == sizeof(tmp))
+					FOLL_PTRACE | FOLL_WRITE) == sizeof(tmp))
 			break;
 		ret = -EIO;
 		break;
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index e7db48acb838..b5c91855faee 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -56,7 +56,7 @@ static int regwindow32_get(struct task_struct *target,
 			return -EFAULT;
 	} else {
 		if (access_process_vm(target, reg_window, uregs, size,
-				      FOLL_FORCE) != size)
+				      FOLL_PTRACE) != size)
 			return -EFAULT;
 	}
 	return 0;
@@ -74,7 +74,7 @@ static int regwindow32_set(struct task_struct *target,
 			return -EFAULT;
 	} else {
 		if (access_process_vm(target, reg_window, uregs, size,
-				      FOLL_FORCE | FOLL_WRITE) != size)
+				      FOLL_PTRACE | FOLL_WRITE) != size)
 			return -EFAULT;
 	}
 	return 0;
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 86a7eb5c27ba..4de97cd1e55a 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -165,7 +165,7 @@ static int get_from_target(struct task_struct *target, unsigned long uaddr,
 			return -EFAULT;
 	} else {
 		int len2 = access_process_vm(target, uaddr, kbuf, len,
-				FOLL_FORCE);
+				FOLL_PTRACE);
 		if (len2 != len)
 			return -EFAULT;
 	}
@@ -180,7 +180,7 @@ static int set_to_target(struct task_struct *target, unsigned long uaddr,
 			return -EFAULT;
 	} else {
 		int len2 = access_process_vm(target, uaddr, kbuf, len,
-				FOLL_FORCE | FOLL_WRITE);
+				FOLL_PTRACE | FOLL_WRITE);
 		if (len2 != len)
 			return -EFAULT;
 	}
@@ -592,7 +592,7 @@ static int genregs32_set(struct task_struct *target,
 						      &reg_window[pos],
 						      (void *) k,
 						      sizeof(*k),
-						      FOLL_FORCE | FOLL_WRITE)
+						      FOLL_PTRACE | FOLL_WRITE)
 				    != sizeof(*k))
 					return -EFAULT;
 				k++;
@@ -622,7 +622,7 @@ static int genregs32_set(struct task_struct *target,
 						      (unsigned long)
 						      &reg_window[pos],
 						      &reg, sizeof(reg),
-						      FOLL_FORCE | FOLL_WRITE)
+						      FOLL_PTRACE | FOLL_WRITE)
 				    != sizeof(reg))
 					return -EFAULT;
 				pos++;
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index 8e2b2552b5ee..7c11da8bbe4c 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -60,7 +60,7 @@ static int is_setting_trap_flag(struct task_struct *child, struct pt_regs *regs)
 	unsigned long addr = convert_ip_to_linear(child, regs);
 
 	copied = access_process_vm(child, addr, opcode, sizeof(opcode),
-			FOLL_FORCE);
+			FOLL_PTRACE);
 	for (i = 0; i < copied; i++) {
 		switch (opcode[i]) {
 		/* popf and iret */
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 0bc4b73a9cde..a40430123448 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -38,7 +38,7 @@ int is_syscall(unsigned long addr)
 		 * in case of singlestepping, if copy_from_user failed.
 		 */
 		n = access_process_vm(current, addr, &instr, sizeof(instr),
-				FOLL_FORCE);
+				FOLL_PTRACE);
 		if (n != sizeof(instr)) {
 			printk(KERN_ERR "is_syscall : failed to read "
 			       "instruction from 0x%lx\n", addr);
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index 289d0159b041..d9f8cba121d6 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -203,7 +203,7 @@ int is_syscall(unsigned long addr)
 		 * in case of singlestepping, if copy_from_user failed.
 		 */
 		n = access_process_vm(current, addr, &instr, sizeof(instr),
-				FOLL_FORCE);
+				FOLL_PTRACE);
 		if (n != sizeof(instr)) {
 			printk("is_syscall : failed to read instruction from "
 			       "0x%lx\n", addr);
diff --git a/fs/exec.c b/fs/exec.c
index a0b1f0337a62..e616abec8b82 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -199,7 +199,7 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 {
 	struct page *page;
 	int ret;
-	unsigned int gup_flags = FOLL_FORCE;
+	unsigned int gup_flags = FOLL_PTRACE;
 
 #ifdef CONFIG_STACK_GROWSUP
 	if (write) {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..f84a85a0f36d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -854,7 +854,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = FOLL_PTRACE | (write ? FOLL_WRITE : 0);
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e8cc838f42f9..037423431225 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2999,7 +2999,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_TOUCH	0x02	/* mark page accessed */
 #define FOLL_GET	0x04	/* do get_page on page */
 #define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
-#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
+#define FOLL_PTRACE	0x10	/* get_user_pages read/write w/o permission */
 #define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
 				 * and return without waiting upon it */
 #define FOLL_NOFAULT	0x80	/* do not fault in pages */
@@ -3151,12 +3151,12 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
 static inline bool gup_can_follow_protnone(unsigned int flags)
 {
 	/*
-	 * FOLL_FORCE has to be able to make progress even if the VMA is
-	 * inaccessible. Further, FOLL_FORCE access usually does not represent
+	 * FOLL_PTRACE has to be able to make progress even if the VMA is
+	 * inaccessible. Further, FOLL_PTRACE access usually does not represent
 	 * application behaviour and we should avoid triggering NUMA hinting
 	 * faults.
 	 */
-	return flags & FOLL_FORCE;
+	return flags & FOLL_PTRACE;
 }
 
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c..6f67c1164f10 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -466,7 +466,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
 	bool orig_page_huge = false;
-	unsigned int gup_flags = FOLL_FORCE;
+	unsigned int gup_flags = FOLL_PTRACE;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
@@ -2028,7 +2028,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	 * but we treat this as a 'remote' access since it is
 	 * essentially a kernel access to the memory.
 	 */
-	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,
+	result = get_user_pages_remote(mm, vaddr, 1, FOLL_PTRACE, &page,
 			NULL, NULL);
 	if (result < 0)
 		return result;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..81394ebd96aa 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -632,7 +632,7 @@ int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst
 		int this_len, retval;
 
 		this_len = (len > sizeof(buf)) ? sizeof(buf) : len;
-		retval = ptrace_access_vm(tsk, src, buf, this_len, FOLL_FORCE);
+		retval = ptrace_access_vm(tsk, src, buf, this_len, FOLL_PTRACE);
 
 		if (!retval) {
 			if (copied)
@@ -661,7 +661,7 @@ int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long ds
 		if (copy_from_user(buf, src, this_len))
 			return -EFAULT;
 		retval = ptrace_access_vm(tsk, dst, buf, this_len,
-				FOLL_FORCE | FOLL_WRITE);
+				FOLL_PTRACE | FOLL_WRITE);
 		if (!retval) {
 			if (copied)
 				break;
@@ -1309,7 +1309,7 @@ int generic_ptrace_peekdata(struct task_struct *tsk, unsigned long addr,
 	unsigned long tmp;
 	int copied;
 
-	copied = ptrace_access_vm(tsk, addr, &tmp, sizeof(tmp), FOLL_FORCE);
+	copied = ptrace_access_vm(tsk, addr, &tmp, sizeof(tmp), FOLL_PTRACE);
 	if (copied != sizeof(tmp))
 		return -EIO;
 	return put_user(tmp, (unsigned long __user *)data);
@@ -1321,7 +1321,7 @@ int generic_ptrace_pokedata(struct task_struct *tsk, unsigned long addr,
 	int copied;
 
 	copied = ptrace_access_vm(tsk, addr, &data, sizeof(data),
-			FOLL_FORCE | FOLL_WRITE);
+			FOLL_PTRACE | FOLL_WRITE);
 	return (copied == sizeof(data)) ? 0 : -EIO;
 }
 
@@ -1339,7 +1339,7 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 	case PTRACE_PEEKTEXT:
 	case PTRACE_PEEKDATA:
 		ret = ptrace_access_vm(child, addr, &word, sizeof(word),
-				FOLL_FORCE);
+				FOLL_PTRACE);
 		if (ret != sizeof(word))
 			ret = -EIO;
 		else
@@ -1349,7 +1349,7 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 	case PTRACE_POKETEXT:
 	case PTRACE_POKEDATA:
 		ret = ptrace_access_vm(child, addr, &data, sizeof(data),
-				FOLL_FORCE | FOLL_WRITE);
+				FOLL_PTRACE | FOLL_WRITE);
 		ret = (ret != sizeof(data) ? -EIO : 0);
 		break;
 
diff --git a/mm/gup.c b/mm/gup.c
index 01116699c863..323edebd0399 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -482,7 +482,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 	return -EEXIST;
 }
 
-/* FOLL_FORCE can write to even unwritable PTEs in COW mappings. */
+/* FOLL_PTRACE can write to even unwritable PTEs in COW mappings. */
 static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 					struct vm_area_struct *vma,
 					unsigned int flags)
@@ -491,11 +491,11 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 	if (pte_write(pte))
 		return true;
 
-	/* Maybe FOLL_FORCE is set to override it? */
-	if (!(flags & FOLL_FORCE))
+	/* Maybe FOLL_PTRACE is set to override it? */
+	if (!(flags & FOLL_PTRACE))
 		return false;
 
-	/* But FOLL_FORCE has no effect on shared mappings */
+	/* But FOLL_PTRACE has no effect on shared mappings */
 	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
 		return false;
 
@@ -942,7 +942,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
-			if (!(gup_flags & FOLL_FORCE))
+			if (!(gup_flags & FOLL_PTRACE))
 				return -EFAULT;
 			/*
 			 * We used to let the write,force case do COW in a
@@ -957,7 +957,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 				return -EFAULT;
 		}
 	} else if (!(vm_flags & VM_READ)) {
-		if (!(gup_flags & FOLL_FORCE))
+		if (!(gup_flags & FOLL_PTRACE))
 			return -EFAULT;
 		/*
 		 * Is there actually any vma we can reach here which does not
@@ -1455,7 +1455,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * other than PROT_NONE.
 	 */
 	if (vma_is_accessible(vma))
-		gup_flags |= FOLL_FORCE;
+		gup_flags |= FOLL_PTRACE;
 
 	/*
 	 * We made sure addr is within a VMA, so the following will
@@ -1507,11 +1507,11 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 	/*
 	 * FOLL_TOUCH: Mark page accessed and thereby young; will also mark
 	 *	       the page dirty with FOLL_WRITE -- which doesn't make a
-	 *	       difference with !FOLL_FORCE, because the page is writable
+	 *	       difference with !FOLL_PTRACE, because the page is writable
 	 *	       in the page table.
 	 * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
 	 *		  a poisoned page.
-	 * !FOLL_FORCE: Require proper access permissions.
+	 * !FOLL_PTRACE: Require proper access permissions.
 	 */
 	gup_flags = FOLL_TOUCH | FOLL_HWPOISON;
 	if (write)
@@ -1601,11 +1601,11 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 	long i;
 
 	/* calculate required read or write permissions.
-	 * If FOLL_FORCE is set, we only require the "MAY" flags.
+	 * If FOLL_PTRACE is set, we only require the "MAY" flags.
 	 */
 	vm_flags  = (foll_flags & FOLL_WRITE) ?
 			(VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
-	vm_flags &= (foll_flags & FOLL_FORCE) ?
+	vm_flags &= (foll_flags & FOLL_PTRACE) ?
 			(VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
 
 	for (i = 0; i < nr_pages; i++) {
@@ -1807,7 +1807,7 @@ struct page *get_dump_page(unsigned long addr)
 	if (mmap_read_lock_killable(mm))
 		return NULL;
 	ret = __get_user_pages_locked(mm, addr, 1, &page, NULL, &locked,
-				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
+				      FOLL_PTRACE | FOLL_DUMP | FOLL_GET);
 	if (locked)
 		mmap_read_unlock(mm);
 	return (ret == 1) ? page : NULL;
@@ -2198,7 +2198,7 @@ EXPORT_SYMBOL(get_user_pages);
  *
  * It is functionally equivalent to get_user_pages_fast so
  * get_user_pages_fast should be used instead if specific gup_flags
- * (e.g. FOLL_FORCE) are not required.
+ * (e.g. FOLL_PTRACE) are not required.
  */
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     struct page **pages, unsigned int gup_flags)
@@ -2869,7 +2869,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	int ret;
 
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
-				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
+				       FOLL_PTRACE | FOLL_PIN | FOLL_GET |
 				       FOLL_FAST_ONLY | FOLL_NOFAULT)))
 		return -EINVAL;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dec7a7c0eca8..695792d2495d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1371,7 +1371,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 	return pmd_dirty(pmd);
 }
 
-/* FOLL_FORCE can write to even unwritable PMDs in COW mappings. */
+/* FOLL_PTRACE can write to even unwritable PMDs in COW mappings. */
 static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 					struct vm_area_struct *vma,
 					unsigned int flags)
@@ -1380,11 +1380,11 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 	if (pmd_write(pmd))
 		return true;
 
-	/* Maybe FOLL_FORCE is set to override it? */
-	if (!(flags & FOLL_FORCE))
+	/* Maybe FOLL_PTRACE is set to override it? */
+	if (!(flags & FOLL_PTRACE))
 		return false;
 
-	/* But FOLL_FORCE has no effect on shared mappings */
+	/* But FOLL_PTRACE has no effect on shared mappings */
 	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
 		return false;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c3aab6d5b7aa..de78ff9db801 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5315,7 +5315,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 
 	/*
-	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
+	 * hugetlb does not support FOLL_PTRACE-style write faults that keep the
 	 * PTE mapped R/O such as maybe_mkwrite() would do.
 	 */
 	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
diff --git a/mm/memory.c b/mm/memory.c
index 56b21ab1e4d2..8b47cd40a7b9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3383,7 +3383,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	/*
 	 * Private mapping: create an exclusive anonymous page copy if reuse
-	 * is impossible. We might miss VM_WRITE for FOLL_FORCE handling.
+	 * is impossible. We might miss VM_WRITE for FOLL_PTRACE handling.
 	 */
 	if (folio && folio_test_anon(folio)) {
 		/*
@@ -5172,7 +5172,7 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 		/* Write faults on read-only mappings are impossible ... */
 		if (WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE)))
 			return VM_FAULT_SIGSEGV;
-		/* ... and FOLL_FORCE only applies to COW mappings. */
+		/* ... and FOLL_PTRACE only applies to COW mappings. */
 		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE) &&
 				 !is_cow_mapping(vma->vm_flags)))
 			return VM_FAULT_SIGSEGV;
diff --git a/mm/util.c b/mm/util.c
index b56c92fb910f..04be917bfb1b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -985,7 +985,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	if (len > buflen)
 		len = buflen;
 
-	res = access_process_vm(task, arg_start, buffer, len, FOLL_FORCE);
+	res = access_process_vm(task, arg_start, buffer, len, FOLL_PTRACE);
 
 	/*
 	 * If the nul at the end of args has been overwritten, then
@@ -1001,7 +1001,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 				len = buflen - res;
 			res += access_process_vm(task, env_start,
 						 buffer+res, len,
-						 FOLL_FORCE);
+						 FOLL_PTRACE);
 			res = strnlen(buffer, res);
 		}
 	}
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 31af29f669d2..c52a93631866 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -916,7 +916,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	 */
 	mmap_read_lock(bprm->mm);
 	ret = get_user_pages_remote(bprm->mm, pos, 1,
-				    FOLL_FORCE, &page, NULL, NULL);
+				    FOLL_PTRACE, &page, NULL, NULL);
 	mmap_read_unlock(bprm->mm);
 	if (ret <= 0)
 		return false;
-- 
2.38.1

