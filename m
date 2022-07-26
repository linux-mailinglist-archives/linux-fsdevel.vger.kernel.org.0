Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19E581755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiGZQXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiGZQVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:21:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D127164;
        Tue, 26 Jul 2022 09:21:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [203.135.47.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DE8C6601B11;
        Tue, 26 Jul 2022 17:21:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658852476;
        bh=YSZMWQRUF0OddQkVSeNEz2FybOLoLuH7kG5PHiHYpXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYdF24VsfkRAH0MPDnmat/nZqLHLpelG6HOTA6a8B5WawqZUKpJ1AMNaRWIIHyWxC
         Rpd4d5c/YyEuiSHkvnHB+jGyGduuf7tYosM9g0r3heiaOA/0vFDtJ6WmeEEPrfZFe4
         BRgUFmAUcvLpFCbteXmVMcFdaMrLUipwyMBlWmNoYgR4KMUHdaGdVch7sqWYqS0ilA
         fr0+D/GjydldqOJLLgD+tlifyqlL2xIhxpeccXU91mfryWIMMVKTNlf1JcvtUTBFNt
         MrTYqp7FS3hHiPXiutyAfbpuc/PER6JCkJ/TKT24g9Ytlf4fCkEn8lZE/z2iquccSN
         YZqJN1NxAR2Gg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-api@vger.kernel.org (open list:ABI/API),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        krisman@collabora.com
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 3/5] mm: wire up process_memwatch syscall for x86
Date:   Tue, 26 Jul 2022 21:18:52 +0500
Message-Id: <20220726161854.276359-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
References: <20220726161854.276359-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up syscall entry point for both i386 and x86_64 architectures.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl            | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl            | 1 +
 include/linux/syscalls.h                          | 3 ++-
 include/uapi/asm-generic/unistd.h                 | 5 ++++-
 kernel/sys_ni.c                                   | 1 +
 tools/include/uapi/asm-generic/unistd.h           | 5 ++++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 7 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..601d33909880 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	process_memwatch	sys_process_memwatch
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..3bddea588ce7 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	process_memwatch	sys_process_memwatch
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..efa240510e4c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -939,7 +939,6 @@ asmlinkage long sys_move_pages(pid_t pid, unsigned long nr_pages,
 				const int __user *nodes,
 				int __user *status,
 				int flags);
-
 asmlinkage long sys_rt_tgsigqueueinfo(pid_t tgid, pid_t  pid, int sig,
 		siginfo_t __user *uinfo);
 asmlinkage long sys_perf_event_open(
@@ -1056,6 +1055,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_process_memwatch(int pidfd, void __user *addr, int len,
+				     unsigned int flags, loff_t __user *vec, int vec_len);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..805a8d5cf0c4 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_process_memwatch 451
+__SC_COMP(__NR_process_memwatch, sys_process_memwatch, compat_sys_process_memwatch)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index a492f159624f..74f31317481a 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -298,6 +298,7 @@ COND_SYSCALL(set_mempolicy);
 COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
+COND_SYSCALL(process_memwatch);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..805a8d5cf0c4 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_process_memwatch 451
+__SC_COMP(__NR_process_memwatch, sys_process_memwatch, compat_sys_process_memwatch)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..3bddea588ce7 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	process_memwatch	sys_process_memwatch
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.30.2

