Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AB518B332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCSMTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 08:19:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:34322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgCSMTs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:19:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B79E4B203;
        Thu, 19 Mar 2020 12:19:45 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v11 4/8] powerpc/perf: consolidate valid_user_sp
Date:   Thu, 19 Mar 2020 13:19:32 +0100
Message-Id: <1b612025371bb9f2bcce72c700c809ae29e57392.1584620202.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1584620202.git.msuchanek@suse.de>
References: <20200225173541.1549955-1-npiggin@gmail.com> <cover.1584620202.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge the 32bit and 64bit version.

Halve the check constants on 32bit.

Use STACK_TOP since it is defined.

Passing is_64 is now redundant since is_32bit_task() is used to
determine which callchain variant should be used. Use STACK_TOP and
is_32bit_task() directly.

This removes a page from the valid 32bit area on 64bit:
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
 #define STACK_TOP_USER32 TASK_SIZE_USER32

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v8: new patch
v11: simplify by using is_32bit_task()
---
 arch/powerpc/perf/callchain.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index c9a78c6e4361..194c7fd933e6 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -102,6 +102,15 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	}
 }
 
+static inline int valid_user_sp(unsigned long sp)
+{
+	bool is_64 = !is_32bit_task();
+
+	if (!sp || (sp & (is_64 ? 7 : 3)) || sp > STACK_TOP - (is_64 ? 32 : 16))
+		return 0;
+	return 1;
+}
+
 #ifdef CONFIG_PPC64
 /*
  * On 64-bit we don't want to invoke hash_page on user addresses from
@@ -161,13 +170,6 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
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
@@ -226,7 +228,7 @@ static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 
 	while (entry->nr < entry->max_stack) {
 		fp = (unsigned long __user *) sp;
-		if (!valid_user_sp(sp, 1) || read_user_stack_64(fp, &next_sp))
+		if (!valid_user_sp(sp) || read_user_stack_64(fp, &next_sp))
 			return;
 		if (level > 0 && read_user_stack_64(&fp[2], &next_ip))
 			return;
@@ -275,13 +277,6 @@ static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry
 {
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
@@ -423,7 +418,7 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 
 	while (entry->nr < entry->max_stack) {
 		fp = (unsigned int __user *) (unsigned long) sp;
-		if (!valid_user_sp(sp, 0) || read_user_stack_32(fp, &next_sp))
+		if (!valid_user_sp(sp) || read_user_stack_32(fp, &next_sp))
 			return;
 		if (level > 0 && read_user_stack_32(&fp[1], &next_ip))
 			return;
-- 
2.23.0

