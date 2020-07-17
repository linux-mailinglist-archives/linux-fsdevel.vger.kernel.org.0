Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F12235DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGQHZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:25:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:48162 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgGQHZI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:25:08 -0400
IronPort-SDR: 8B8T2wveY3nm+pXo0LmDLyFw4uYADpvJRqWzkrkfMyLcKxgIf/LF+VnsD3VSFVd7DUWd5/uZy4
 QdECASlqJi7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129111934"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129111934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:05 -0700
IronPort-SDR: jdgqUyrD6mJZclK9bRc4XHstnhKlwHkX4CvIV3xrxfdOvOkxMcrBwQNSuFZVxiUAZawh7QjFyq
 lGsCJEioKRGw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="270757035"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:05 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 08/17] x86/pks: Add PKS Test code
Date:   Fri, 17 Jul 2020 00:20:47 -0700
Message-Id: <20200717072056.73134-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The core PKS functionality provides an interface for kernel users to
reserve keys to their domains set up the page tables with those keys and
control access to those domains when needed.

Define test code which exercises the core functionality of PKS via a
debugfs entry.  Basic checks can be triggered on boot with a kernel
command line option while both basic and preemption checks can be
triggered with separate debugfs values.

debugfs controls are:

'0' -- Run access tests with a single pkey
'1' -- Set up the pkey register with no access for the pkey allocated to
       this fd
'2' -- Check that the pkey register updated in '1' is still the same.
       (To be used after a forced context switch.)
'3' -- Allocate all pkeys possible and run tests on each pkey allocated.
       DEFAULT when run at boot.

Closing the fd will cleanup and release the pkey, therefore to fully
exercise context switch testing a user space program is provided in:

	.../tools/testing/selftests/x86/test_pks.c

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/pkeys.h           |   9 +
 arch/x86/mm/fault.c                    |  16 +-
 include/linux/pkeys.h                  |   4 +
 lib/Kconfig.debug                      |  12 +
 lib/Makefile                           |   3 +
 lib/pks/Makefile                       |   3 +
 lib/pks/pks_test.c                     | 452 +++++++++++++++++++++++++
 tools/testing/selftests/x86/Makefile   |   3 +-
 tools/testing/selftests/x86/test_pks.c |  65 ++++
 9 files changed, 562 insertions(+), 5 deletions(-)
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c
 create mode 100644 tools/testing/selftests/x86/test_pks.c

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index e30ea907abb6..097abca7784c 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -168,4 +168,13 @@ static inline void pks_update_protection(int pkey, unsigned long protection)
 }
 #endif /* CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
 
+#if defined(CONFIG_PKS_TESTING)
+bool pks_test_armed_and_clear(void);
+#else
+static inline bool pks_test_armed_and_clear(void)
+{
+	return false;
+}
+#endif
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 5e41949453cc..1384190a900c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_recover_from_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/pkeys.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1105,11 +1106,18 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
 	/*
-	 * Protection keys exceptions only happen on user pages.  We
-	 * have no user pages in the kernel portion of the address
-	 * space, so do not expect them here.
+	 * If we get a protection key exception it could be because we are
+	 * running the PKS test.  If so, pks_test_armed_and_clear() will clear
+	 * the protection mechanism and we can safely return.
+	 *
+	 * Otherwise we warn the user that something has gone wrong and
+	 * continue with the fault.
 	 */
-	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	if (hw_error_code & X86_PF_PK) {
+		if (pks_test_armed_and_clear())
+			return;
+		WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	}
 
 	/* Was the fault spurious, caused by lazy TLB invalidation? */
 	if (spurious_kernel_fault(hw_error_code, address))
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index e4bff77d7b49..1d84ab7c12d4 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -48,6 +48,10 @@ static inline void copy_init_pkru_to_fpregs(void)
 {
 }
 
+static inline bool pks_test_armed_and_clear(void)
+{
+	return false;
+}
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..aa876ebb4c8b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2329,6 +2329,18 @@ config HYPERV_TESTING
 	help
 	  Select this option to enable Hyper-V vmbus testing.
 
+config PKS_TESTING
+	bool "PKey(S)upervisor testing"
+	default n
+	depends on ARCH_HAS_SUPERVISOR_PKEYS
+	help
+	  Select this option to enable testing of PKS core software and
+	  hardware.  The PKS core provides a mechanism to allocate keys as well
+	  as maintain the protection settings across context switches.
+	  Answer N if you don't know what supervisor keys are.
+
+	  If unsure, say N.
+
 endmenu # "Kernel Testing and Coverage"
 
 endmenu # Kernel hacking
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..667dea28cf7b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -318,3 +318,6 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+
+# PKS test
+obj-y += pks/
diff --git a/lib/pks/Makefile b/lib/pks/Makefile
new file mode 100644
index 000000000000..7d1df7563db9
--- /dev/null
+++ b/lib/pks/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PKS_TESTING) += pks_test.o
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
new file mode 100644
index 000000000000..6d8172734f97
--- /dev/null
+++ b/lib/pks/pks_test.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2020 Intel Corporation. All rights reserved.
+ *
+ * Implement PKS testing
+ * Access to run this test can be with a command line parameter
+ * ("pks-test-on-boot") or more detailed tests can be triggered through:
+ *
+ *    /sys/kernel/debug/x86/run_pks
+ *
+ *  debugfs controls are:
+ *
+ *  '0' -- Run access tests with a single pkey
+ *
+ *  '1' -- Set up the pkey register with no access for the pkey allocated to
+ *         this fd
+ *  '2' -- Check that the pkey register updated in '1' is still the same.  (To
+ *         be used after a forced context switch.)
+ *
+ *  '3' -- Allocate all pkeys possible and run tests on each pkey allocated.
+ *         DEFAULT when run at boot.
+ *
+ *  Closing the fd will cleanup and release the pkey.
+ *
+ *  A companion user space program is provided in:
+ *
+ *          .../tools/testing/selftests/x86/test_pks.c
+ *
+ *  which will better test the context switching.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/pgtable.h>
+
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/mman.h>
+#include <linux/module.h>
+#include <linux/pkeys.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#define PKS_TEST_MEM_SIZE (PAGE_SIZE)
+
+/*
+ * run_on_boot default '= false' which checkpatch complains about initializing;
+ * so we don't
+ */
+static bool run_on_boot;
+static struct dentry *pks_test_dentry;
+
+/*
+ * We must lock the following globals for brief periods while the fault handler
+ * checks/updates them.
+ */
+static DEFINE_SPINLOCK(test_lock);
+static int test_armed_key;
+static unsigned long prev_cnt;
+static unsigned long fault_cnt;
+
+struct pks_test_ctx {
+	bool pass;
+	bool pks_cpu_enabled;
+	int pkey;
+	char data[64];
+};
+
+static pte_t *walk_table(void *ptr)
+{
+	struct page *page = NULL;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ret = NULL;
+
+	pgdp = pgd_offset_k((unsigned long)ptr);
+	if (pgd_none(*pgdp) || pgd_bad(*pgdp))
+		goto error;
+
+	p4dp = p4d_offset(pgdp, (unsigned long)ptr);
+	if (p4d_none(*p4dp) || p4d_bad(*p4dp))
+		goto error;
+
+	pudp = pud_offset(p4dp, (unsigned long)ptr);
+	if (pud_none(*pudp) || pud_bad(*pudp))
+		goto error;
+
+	pmdp = pmd_offset(pudp, (unsigned long)ptr);
+	if (pmd_none(*pmdp) || pmd_bad(*pmdp))
+		goto error;
+
+	ret = pte_offset_map(pmdp, (unsigned long)ptr);
+	if (pte_present(*ret)) {
+		page = pte_page(*ret);
+		if (!page) {
+			pte_unmap(ret);
+			goto error;
+		}
+		pr_info("page 0x%lx; flags 0x%lx\n",
+		       (unsigned long)page, page->flags);
+	}
+
+error:
+	return ret;
+}
+
+/**
+ * pks_test_armed_and_clear() is exported so that the fault handler can detect
+ * and report back status of intentional faults.
+ *
+ * NOTE: It clears the protection key from the page such that the fault handler
+ * will not re-trigger.
+ */
+bool pks_test_armed_and_clear(void)
+{
+	bool armed = (test_armed_key != 0);
+
+	if (armed) {
+		/* Enable read and write to stop faults */
+		pks_update_protection(test_armed_key, 0);
+		fault_cnt++;
+	}
+
+	return armed;
+}
+EXPORT_SYMBOL(pks_test_armed_and_clear);
+
+static bool exception_caught(void)
+{
+	bool ret = (fault_cnt != prev_cnt);
+
+	prev_cnt = fault_cnt;
+	return ret;
+}
+
+static void report_pkey_settings(void *unused)
+{
+	u8 pkey;
+	unsigned long long msr = 0;
+	unsigned int cpu = smp_processor_id();
+
+	rdmsrl(MSR_IA32_PKRS, msr);
+
+	pr_info("for CPU %d : 0x%llx\n", cpu, msr);
+	for (pkey = 0; pkey < PKS_NUM_KEYS; pkey++) {
+		int ad, wd;
+
+		ad = (msr >> (pkey * PKR_BITS_PER_PKEY)) & PKEY_DISABLE_ACCESS;
+		wd = (msr >> (pkey * PKR_BITS_PER_PKEY)) & PKEY_DISABLE_WRITE;
+		pr_info("   %u: A:%d W:%d\n", pkey, ad, wd);
+	}
+}
+
+struct pks_access_test {
+	int ad;
+	int wd;
+	bool write;
+	bool exception;
+};
+
+static struct pks_access_test pkey_test_ary[] = {
+	/*  disable both */
+	{ PKEY_DISABLE_ACCESS, PKEY_DISABLE_WRITE,   true,  true },
+	{ PKEY_DISABLE_ACCESS, PKEY_DISABLE_WRITE,   false, true },
+
+	/*  enable both */
+	{ 0, 0, true,  false },
+	{ 0, 0, false, false },
+
+	/*  enable read only */
+	{ 0, PKEY_DISABLE_WRITE,  true,  true },
+	{ 0, PKEY_DISABLE_WRITE,  false, false },
+};
+
+static int run_access_test(struct pks_test_ctx *ctx,
+			   struct pks_access_test *test,
+			   void *ptr)
+{
+	int ret = 0;
+	bool exception;
+
+	pks_update_protection(ctx->pkey, test->ad | test->wd);
+
+	spin_lock(&test_lock);
+	test_armed_key = ctx->pkey;
+
+	if (test->write)
+		memcpy(ptr, ctx->data, 8);
+	else
+		memcpy(ctx->data, ptr, 8);
+
+	exception = exception_caught();
+
+	test_armed_key = 0;
+	spin_unlock(&test_lock);
+
+	if (test->exception != exception) {
+		pr_err("pkey test FAILED: ad %d; wd %d; write %s; exception %s != %s\n",
+			test->ad, test->wd,
+			test->write ? "TRUE" : "FALSE",
+			test->exception ? "TRUE" : "FALSE",
+			exception ? "TRUE" : "FALSE");
+		ret = -EFAULT;
+	}
+
+	return ret;
+}
+
+static void test_mem_access(struct pks_test_ctx *ctx)
+{
+	int i, rc;
+	u8 pkey;
+	void *ptr = NULL;
+	pte_t *ptep;
+
+	ptr = __vmalloc_node_range(PKS_TEST_MEM_SIZE, 1, VMALLOC_START, VMALLOC_END,
+				   GFP_KERNEL, PAGE_KERNEL_PKEY(ctx->pkey),
+				   0, NUMA_NO_NODE, __builtin_return_address(0));
+	if (!ptr) {
+		pr_err("Failed to vmalloc page???\n");
+		ctx->pass = false;
+		return;
+	}
+
+	ptep = walk_table(ptr);
+	if (!ptep) {
+		pr_err("Failed to walk table???\n");
+		ctx->pass = false;
+		goto done;
+	}
+
+	pkey = pte_flags_pkey(ptep->pte);
+	pr_info("ptep flags 0x%lx pkey %u\n",
+	       (unsigned long)ptep->pte, pkey);
+
+	if (pkey != ctx->pkey) {
+		pr_err("invalid pkey found: %u, test_pkey: %u\n",
+			pkey, ctx->pkey);
+		ctx->pass = false;
+		goto unmap;
+	}
+
+	if (!ctx->pks_cpu_enabled) {
+		pr_err("not CPU enabled; skipping access tests...\n");
+		ctx->pass = true;
+		goto unmap;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pkey_test_ary); i++) {
+		rc = run_access_test(ctx, &pkey_test_ary[i], ptr);
+
+		/*  only save last error is fine */
+		if (rc)
+			ctx->pass = false;
+	}
+
+unmap:
+	pte_unmap(ptep);
+done:
+	vfree(ptr);
+}
+
+static void pks_run_test(struct pks_test_ctx *ctx)
+{
+	ctx->pass = true;
+
+	pr_info("\n");
+	pr_info("\n");
+	pr_info("     ***** BEGIN: Testing (CPU enabled : %s) *****\n",
+		ctx->pks_cpu_enabled ? "TRUE" : "FALSE");
+
+	if (ctx->pks_cpu_enabled)
+		on_each_cpu(report_pkey_settings, NULL, 1);
+
+	pr_info("           BEGIN: pkey %d Testing\n", ctx->pkey);
+	test_mem_access(ctx);
+	pr_info("           END: PAGE_KERNEL_PKEY Testing : %s\n",
+		ctx->pass ? "PASS" : "FAIL");
+
+	pr_info("     ***** END: Testing *****\n");
+	pr_info("\n");
+	pr_info("\n");
+}
+
+static ssize_t pks_read_file(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct pks_test_ctx *ctx = file->private_data;
+	char buf[32];
+	unsigned int len;
+
+	if (!ctx)
+		len = sprintf(buf, "not run\n");
+	else
+		len = sprintf(buf, "%s\n", ctx->pass ? "PASS" : "FAIL");
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static struct pks_test_ctx *alloc_ctx(const char *name)
+{
+	struct pks_test_ctx *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx) {
+		pr_err("Failed to allocate memory for test context\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->pkey = pks_key_alloc(name);
+	if (ctx->pkey <= 0) {
+		pr_err("Failed to allocate memory for test context\n");
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->pks_cpu_enabled = cpu_feature_enabled(X86_FEATURE_PKS);
+	sprintf(ctx->data, "%s", "DEADBEEF");
+	return ctx;
+}
+
+static void free_ctx(struct pks_test_ctx *ctx)
+{
+	pks_key_free(ctx->pkey);
+	kfree(ctx);
+}
+
+static void run_all(void)
+{
+	struct pks_test_ctx *ctx[PKS_NUM_KEYS];
+	static char name[PKS_NUM_KEYS][64];
+	int i;
+
+	for (i = 1; i < PKS_NUM_KEYS; i++) {
+		sprintf(name[i], "pks ctx %d", i);
+		ctx[i] = alloc_ctx((const char *)name[i]);
+	}
+
+	for (i = 1; i < PKS_NUM_KEYS; i++) {
+		if (!IS_ERR(ctx[i]))
+			pks_run_test(ctx[i]);
+	}
+
+	for (i = 1; i < PKS_NUM_KEYS; i++) {
+		if (!IS_ERR(ctx[i]))
+			free_ctx(ctx[i]);
+	}
+}
+
+static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	char buf[2];
+	struct pks_test_ctx *ctx = file->private_data;
+
+	if (copy_from_user(buf, user_buf, 1))
+		return -EFAULT;
+	buf[1] = '\0';
+
+	/*
+	 * Test "3" will test allocating all keys. Do it first without
+	 * using "ctx".
+	 */
+	if (!strcmp(buf, "3"))
+		run_all();
+
+	if (!ctx) {
+		ctx = alloc_ctx("pks test");
+		if (IS_ERR(ctx))
+			return -ENOMEM;
+		file->private_data = ctx;
+	}
+
+	if (!strcmp(buf, "0"))
+		pks_run_test(ctx);
+
+	/* start of context switch test */
+	if (!strcmp(buf, "1")) {
+		/* Ensure a known state to test context switch */
+		pks_update_protection(ctx->pkey,
+				      PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
+	}
+
+	/* After context switch msr should be restored */
+	if (!strcmp(buf, "2") && ctx->pks_cpu_enabled) {
+		unsigned long reg_pkrs;
+		int access;
+
+		rdmsrl(MSR_IA32_PKRS, reg_pkrs);
+
+		access = (reg_pkrs >> (ctx->pkey * PKR_BITS_PER_PKEY)) &
+			  PKEY_ACCESS_MASK;
+		if (access != (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)) {
+			ctx->pass = false;
+			pr_err("Context switch check failed\n");
+		}
+	}
+
+	return count;
+}
+
+static int pks_release_file(struct inode *inode, struct file *file)
+{
+	struct pks_test_ctx *ctx = file->private_data;
+
+	if (!ctx)
+		return 0;
+
+	free_ctx(ctx);
+	return 0;
+}
+
+static const struct file_operations fops_init_pks = {
+	.read = pks_read_file,
+	.write = pks_write_file,
+	.llseek = default_llseek,
+	.release = pks_release_file,
+};
+
+static int __init parse_pks_test_options(char *str)
+{
+	run_on_boot = true;
+
+	return 0;
+}
+early_param("pks-test-on-boot", parse_pks_test_options);
+
+static int __init pks_test_init(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_PKS)) {
+		if (run_on_boot)
+			run_all();
+
+		pks_test_dentry = debugfs_create_file("run_pks", 0600, arch_debugfs_dir,
+						      NULL, &fops_init_pks);
+	}
+
+	return 0;
+}
+late_initcall(pks_test_init);
+
+static void __exit pks_test_exit(void)
+{
+	debugfs_remove(pks_test_dentry);
+	pr_info("test exit\n");
+}
+module_exit(pks_test_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d2796ea98c5a..3572dfb25c0a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,8 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vdso test_vsyscall mov_ss_trap \
-			syscall_arg_fault
+			syscall_arg_fault test_pks
+
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
new file mode 100644
index 000000000000..8037a2a9ff5f
--- /dev/null
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <assert.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+int main(void)
+{
+	cpu_set_t cpuset;
+	char result[32];
+	pid_t pid;
+	int fd;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	/* Two processes run on CPU 0 so that they go through context switch. */
+	sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
+
+	pid = fork();
+	if (pid == 0) {
+		fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
+		if (fd < 0) {
+			printf("cannot open file\n");
+			return -1;
+		}
+
+		/* Allocate test_pkey1 and run test. */
+		write(fd, "0", 1);
+
+		/* Arm for context switch test */
+		write(fd, "1", 1);
+
+		/* Context switch out... */
+		sleep(4);
+
+		/* Check msr restored */
+		write(fd, "2", 1);
+	} else {
+		sleep(2);
+
+		fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
+		if (fd < 0) {
+			printf("cannot open file\n");
+			return -1;
+		}
+
+		/* run test with alternate pkey */
+		write(fd, "0", 1);
+	}
+
+	read(fd, result, 10);
+	printf("#PF, context switch, pkey allocation and free tests: %s\n",
+	       result);
+
+	close(fd);
+
+	return 0;
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9

