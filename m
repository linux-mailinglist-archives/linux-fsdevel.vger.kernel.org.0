Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B0B1DFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbfIMM6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:58:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:44700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729830AbfIMM6N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:58:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 716FCAFB6;
        Fri, 13 Sep 2019 12:58:11 +0000 (UTC)
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
Subject: [PATCH v9 4/8] powerpc/perf: consolidate valid_user_sp
Date:   Fri, 13 Sep 2019 14:57:58 +0200
Message-Id: <6429623dfb3f92e45c9d403194e16943eb51da79.1568319275.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568319275.git.msuchanek@suse.de>
References: <cover.1568319275.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge the 32bit and 64bit version.

Halve the check constants on 32bit.

Use STACK_TOP since it is defined.

This removes a page from the valid 32bit area on 64bit:
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
 #define STACK_TOP_USER32 TASK_SIZE_USER32

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v8: new patch
---
 arch/powerpc/perf/callchain.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index d86bdbffda9e..7863ee0a0e69 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -102,6 +102,20 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	}
 }
 
+static inline int valid_user_sp(unsigned long sp, int is_64)
+{
+	unsigned long stack_top;
+
+	if (IS_ENABLED(CONFIG_PPC32))
+		stack_top = STACK_TOP;
+	else    /* STACK_TOP uses is_32bit_task() but we want is_64 */
+		stack_top = is_64 ? STACK_TOP_USER64 : STACK_TOP_USER32;
+
+	if (!sp || (sp & (is_64 ? 7 : 3)) || sp > stack_top - (is_64 ? 32 : 16))
+		return 0;
+	return 1;
+}
+
 #ifdef CONFIG_PPC64
 /*
  * On 64-bit we don't want to invoke hash_page on user addresses from
@@ -165,13 +179,6 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
 	return read_user_stack_slow(ptr, ret, 8);
 }
 
-static inline int valid_user_sp(unsigned long sp, int is_64)
-{
-	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
-		return 0;
-	return 1;
-}
-
 /*
  * 64-bit user processes use the same stack frame for RT and non-RT signals.
  */
@@ -294,13 +301,6 @@ static inline int current_is_64bit(void)
 	return 0;
 }
 
-static inline int valid_user_sp(unsigned long sp, int is_64)
-{
-	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
-		return 0;
-	return 1;
-}
-
 #define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
 #define sigcontext32		sigcontext
 #define mcontext32		mcontext
-- 
2.23.0

