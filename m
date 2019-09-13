Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5CB1DF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfIMM6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:58:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729863AbfIMM6M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:58:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6754BB116;
        Fri, 13 Sep 2019 12:58:10 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v9 3/8] powerpc/perf: consolidate read_user_stack_32
Date:   Fri, 13 Sep 2019 14:57:57 +0200
Message-Id: <488f195b714b57c80045a89c2625afed924d3b83.1568319275.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568319275.git.msuchanek@suse.de>
References: <cover.1568319275.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two almost identical copies for 32bit and 64bit.

The function is used only in 32bit code which will be split out in next
patch so consolidate to one function.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v6: new patch
v8: move the consolidated function out of the ifdef block.
---
 arch/powerpc/perf/callchain.c | 59 +++++++++++++++--------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index c84bbd4298a0..d86bdbffda9e 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -165,22 +165,6 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
 	return read_user_stack_slow(ptr, ret, 8);
 }
 
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
-{
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	pagefault_disable();
-	if (!__get_user_inatomic(*ret, ptr)) {
-		pagefault_enable();
-		return 0;
-	}
-	pagefault_enable();
-
-	return read_user_stack_slow(ptr, ret, 4);
-}
-
 static inline int valid_user_sp(unsigned long sp, int is_64)
 {
 	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
@@ -295,25 +279,9 @@ static inline int current_is_64bit(void)
 }
 
 #else  /* CONFIG_PPC64 */
-/*
- * On 32-bit we just access the address and let hash_page create a
- * HPTE if necessary, so there is no need to fall back to reading
- * the page tables.  Since this is called at interrupt level,
- * do_page_fault() won't treat a DSI as a page fault.
- */
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 {
-	int rc;
-
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	pagefault_disable();
-	rc = __get_user_inatomic(*ret, ptr);
-	pagefault_enable();
-
-	return rc;
+	return 0;
 }
 
 static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
@@ -341,6 +309,29 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
 
 #endif /* CONFIG_PPC64 */
 
+/*
+ * On 32-bit we just access the address and let hash_page create a
+ * HPTE if necessary, so there is no need to fall back to reading
+ * the page tables.  Since this is called at interrupt level,
+ * do_page_fault() won't treat a DSI as a page fault.
+ */
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+{
+	int rc;
+
+	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
+	    ((unsigned long)ptr & 3))
+		return -EFAULT;
+
+	pagefault_disable();
+	rc = __get_user_inatomic(*ret, ptr);
+	pagefault_enable();
+
+	if (IS_ENABLED(CONFIG_PPC64) && rc)
+		return read_user_stack_slow(ptr, ret, 4);
+	return rc;
+}
+
 /*
  * Layout for non-RT signal frames
  */
-- 
2.23.0

