Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB868B1DFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfIMM6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:58:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387582AbfIMM6O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:58:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 725A9AF0B;
        Fri, 13 Sep 2019 12:58:12 +0000 (UTC)
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
Subject: [PATCH v9 5/8] powerpc/perf: remove current_is_64bit()
Date:   Fri, 13 Sep 2019 14:57:59 +0200
Message-Id: <61343717e7960595c3258cea6a9493d67adb56d8.1568319275.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568319275.git.msuchanek@suse.de>
References: <cover.1568319275.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
current_is_64bit() is quivalent to !is_32bit_task().
Remove the redundant function.

Link: https://github.com/linuxppc/issues/issues/275
Link: https://lkml.org/lkml/2019/9/12/540

Fixes: linuxppc#275
Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/perf/callchain.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 7863ee0a0e69..fbf76cb01026 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -275,16 +275,6 @@ static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 	}
 }
 
-static inline int current_is_64bit(void)
-{
-	/*
-	 * We can't use test_thread_flag() here because we may be on an
-	 * interrupt stack, and the thread flags don't get copied over
-	 * from the thread_info on the main stack to the interrupt stack.
-	 */
-	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
-}
-
 #else  /* CONFIG_PPC64 */
 static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 {
@@ -296,11 +286,6 @@ static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry
 {
 }
 
-static inline int current_is_64bit(void)
-{
-	return 0;
-}
-
 #define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
 #define sigcontext32		sigcontext
 #define mcontext32		mcontext
@@ -477,7 +462,7 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
-	if (current_is_64bit())
+	if (!is_32bit_task())
 		perf_callchain_user_64(entry, regs);
 	else
 		perf_callchain_user_32(entry, regs);
-- 
2.23.0

