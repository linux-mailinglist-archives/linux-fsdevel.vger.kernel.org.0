Return-Path: <linux-fsdevel+bounces-44993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA31A6FE71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5775F17406D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB927F4CE;
	Tue, 25 Mar 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBdZnQ6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1332594B7;
	Tue, 25 Mar 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905495; cv=none; b=mexu96zlOzhrGaqxw/Vg6F5mcX0bgbabxPbgsgIxRQXFsqQUT8p3y1Q8RZqpIHUlUZI5I9QJyvKmUWBKUQC3i/hQOwcVZ5RH4zlIo/SagfmkeJKq7QAMMhISIreN9FyhfiCbwCsaCecoGs/QCKpl/8fSV4q9XqsY9WdYRYYlriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905495; c=relaxed/simple;
	bh=JwtECzOHq6ymjHklbfhF05tHrVz/dVoFwQnBuog4LCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkJB5aUK0m0GsdcCf4gj5pv6rEgxe6PzTI6PMHZpRWUixyM1tZIAPKxZ4W1LRSQso83QYaURxQNPjkjo0CwAuo0hWbnv413x0pZKQB1z46kKxyi7nbCf40RMANcGLQBpriWzGpdpIDPfKlG08IzKIdTstm8PYJFcRaSYarZlX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBdZnQ6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE93C4CEE4;
	Tue, 25 Mar 2025 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905494;
	bh=JwtECzOHq6ymjHklbfhF05tHrVz/dVoFwQnBuog4LCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBdZnQ6wGqSC6QfVLwGWKEPwB7OJ2JptqWNe6hKJxvNlO7hfByhpmxMvHthIUgk61
	 dNUcCE7m/h28WuqOcXJmgPZQk3Hy8cSc4aiS4wgdEwf37RF7fMts6mVPBiUNrWNCWt
	 oWzAZgLDhGX29uKl8dWvRO9Mm1JoxE4/TpLaaQgKCG0EvxU9De7+6S+NM9bXKazZUh
	 iiJaT6DEIOs44LKfjd1QeKJBQDjIo3VxGUUBkRirfVvYipwwzvO9PksRO3PoHIeu8G
	 685HBjMd/zqHvy1H0+rm2OtgsMHs8OXxw2D6U5NNsckTsb6/vNidB7w2u683wCRv8q
	 kinJAJyufOtuA==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 34/43] rv64ilp32_abi: mm: Adapt vm_flags_t struct
Date: Tue, 25 Mar 2025 08:16:15 -0400
Message-Id: <20250325121624.523258-35-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

RV64ILP32 ABI linux kernel is based on CONFIG_64BIT, so uses
unsigned long long as vm_flags struct type.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 fs/proc/task_mmu.c       |  9 +++++++--
 include/linux/mm.h       | 10 +++++++---
 include/linux/mm_types.h |  4 ++++
 mm/debug.c               |  4 ++++
 mm/memory.c              |  4 ++++
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f02cd362309a..6c4eaba794da 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -905,6 +905,11 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
+#ifdef CONFIG_64BIT
+#define MNEMONICS_SZ 64
+#else
+#define MNEMONICS_SZ 32
+#endif
 static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 {
 	/*
@@ -917,11 +922,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 	 * -Werror=unterminated-string-initialization warning
 	 *  with GCC 15
 	 */
-	static const char mnemonics[BITS_PER_LONG][3] = {
+	static const char mnemonics[MNEMONICS_SZ][3] = {
 		/*
 		 * In case if we meet a flag we don't know about.
 		 */
-		[0 ... (BITS_PER_LONG-1)] = "??",
+		[0 ... (MNEMONICS_SZ-1)] = "??",
 
 		[ilog2(VM_READ)]	= "rd",
 		[ilog2(VM_WRITE)]	= "wr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 454fb8ca724c..d9735cd7efe9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -412,7 +412,11 @@ extern unsigned int kobjsize(const void *objp);
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 # define VM_UFFD_MINOR_BIT	38
+#ifdef CONFIG_64BIT
+# define VM_UFFD_MINOR		BIT_ULL(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
+#else
 # define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
+#endif
 #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 # define VM_UFFD_MINOR		VM_NONE
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
@@ -426,14 +430,14 @@ extern unsigned int kobjsize(const void *objp);
  */
 #ifdef CONFIG_64BIT
 #define VM_ALLOW_ANY_UNCACHED_BIT	39
-#define VM_ALLOW_ANY_UNCACHED		BIT(VM_ALLOW_ANY_UNCACHED_BIT)
+#define VM_ALLOW_ANY_UNCACHED		BIT_ULL(VM_ALLOW_ANY_UNCACHED_BIT)
 #else
 #define VM_ALLOW_ANY_UNCACHED		VM_NONE
 #endif
 
 #ifdef CONFIG_64BIT
 #define VM_DROPPABLE_BIT	40
-#define VM_DROPPABLE		BIT(VM_DROPPABLE_BIT)
+#define VM_DROPPABLE		BIT_ULL(VM_DROPPABLE_BIT)
 #elif defined(CONFIG_PPC32)
 #define VM_DROPPABLE		VM_ARCH_1
 #else
@@ -442,7 +446,7 @@ extern unsigned int kobjsize(const void *objp);
 
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
+#define VM_SEALED	_BITULL(63)
 #endif
 
 /* Bits set in the VMA until the stack is in its final location */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0d436b0217fd..900665c5eca8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -571,7 +571,11 @@ static inline void *folio_get_private(struct folio *folio)
 	return folio->private;
 }
 
+#ifdef CONFIG_64BIT
+typedef unsigned long long vm_flags_t;
+#else
 typedef unsigned long vm_flags_t;
+#endif
 
 /*
  * A region containing a mapping of a non-memory backed file under NOMMU
diff --git a/mm/debug.c b/mm/debug.c
index 8d2acf432385..0fcb85e6efea 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -181,7 +181,11 @@ void dump_vma(const struct vm_area_struct *vma)
 	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
+#ifdef CONFIG_64BIT
+		"flags: %#llx(%pGv)\n",
+#else
 		"flags: %#lx(%pGv)\n",
+#endif
 		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..3c4a9663c094 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -533,7 +533,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
 	if (page)
 		dump_page(page, "bad pte");
+#ifdef CONFIG_64BIT
+	pr_alert("addr:%px vm_flags:%08llx anon_vma:%px mapping:%px index:%lx\n",
+#else
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
+#endif
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
 	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
 		 vma->vm_file,
-- 
2.40.1


