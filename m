Return-Path: <linux-fsdevel+bounces-22004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0738910CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9F8B27E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E11BC099;
	Thu, 20 Jun 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmS8IYAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF851B3F17;
	Thu, 20 Jun 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900712; cv=none; b=Dx6JmCjAJkcJ2MShrempVVMIN3trqNh0LkYObX332JmadvllZOCvm/xqhj13BZDNJKu1LQTtFX+qDNlHO7MuAk4+svSFBxkG44DZkPBY3BqsxTKhY1bSAO7vmlCYC73EOA/1oj+qHZJsVlHNwBlGxnpG1uztqMb4IsbqjoZC+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900712; c=relaxed/simple;
	bh=DmBAxbeYTBncX5bl/HvCmLsEpHQvV2w2CK/NjV0qTMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzQylYd77aXKtoahNXkGuSsVCipoA/WomAcD5zvNd6AGulNFDFDTbtA3LM5dxdoT2ZcdKgV6R93eTmS27nenUGcqYdnABx4RAzT1jEKiMD6jBy/CAAmPmXsqLNs3c4NgY3wenfQam6NV9rJe8QXjLeHwnWOPnk1RCLLk0kIoAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmS8IYAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27D5C2BD10;
	Thu, 20 Jun 2024 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900712;
	bh=DmBAxbeYTBncX5bl/HvCmLsEpHQvV2w2CK/NjV0qTMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmS8IYAQWW69dqUsoOQK9VgMXj75HkeXssxpRMqHnXS7IEXYdB8lDpuV539MnmBAh
	 s5gbZn3TjHFYOMff/qbOKiB91FcdJJ/B1yEBb87oOBGhFSSYAdGQ2TItgY+Uw8EkGX
	 g3gJpNwiRu+JLbhJ7yhZWxOK3wGEsIi6ljHwvnrJ2xTSutwPldayRZs/di4mcOMrbT
	 llX1acIQCyrfixIxAG/jVId1PA68MhgRz9IalJBS/cPw2/WhuLizVaP4BajooQVYtC
	 /KGI86ltLy3bRQy9J9vDepyHlhzcDRFgo8sX9ImC4EISDALjAc1kQaLDqQ5ZoGgC1c
	 GJtOFr4c9ZTEA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	libc-alpha@sourceware.org,
	musl@lists.openwall.com,
	ltp@lists.linux.it,
	stable@vger.kernel.org
Subject: [PATCH 14/15] asm-generic: unistd: fix time32 compat syscall handling
Date: Thu, 20 Jun 2024 18:23:15 +0200
Message-Id: <20240620162316.3674955-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620162316.3674955-1-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

arch/riscv/ appears to have accidentally enabled the compat time32
syscalls in 64-bit kernels even though the native 32-bit ABI does
not expose those.

Address this by adding another level of indirection, checking for both
the target ABI (32 or 64) and the __ARCH_WANT_TIME32_SYSCALLS macro.

The macro arguments are meant to follow the syscall.tbl format, the idea
here is that by the end of the series, all other syscalls are changed
to the same format to make it possible to move all architectures over
to generating the system call table consistently.
Only this patch needs to be backported though.

Cc: stable@vger.kernel.org # v5.19+
Fixes: 7eb6369d7acf ("RISC-V: Add support for rv32 userspace via COMPAT")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 146 +++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 52 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3fdaa573d661..e47c966557d0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -16,10 +16,32 @@
 #define __SYSCALL(x, y)
 #endif
 
+#ifndef __SC
+#define __SC(_cond, _nr, _sys) __SYSCALL_ ## _cond (_nr, _sys)
+#endif
+
+#ifndef __SCC
+#ifdef __SYSCALL_COMPAT
+#define __SCC(_cond, _nr, _sys, _comp) __SC(_cond, _nr, _comp)
+#else
+#define __SCC(_cond, _nr, _sys, _comp) __SC(_cond, _nr, _sys)
+#endif
+#endif
+
 #if __BITS_PER_LONG == 32 || defined(__SYSCALL_COMPAT)
 #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
+#define __SYSCALL_32(_nr, _sys)		__SYSCALL(__NR_ ## _nr, _sys)
+#define __SYSCALL_64(_nr, _sys)
 #else
 #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _64)
+#define __SYSCALL_32(_nr, _sys)
+#define __SYSCALL_64(_nr, _sys)		__SYSCALL(__NR_ ## _nr, _sys)
+#endif
+
+#if defined(__ARCH_WANT_TIME32_SYSCALLS)
+#define __SYSCALL_time32(_nr, _sys)	__SYSCALL_32(__NR_ ## _nr, _sys)
+#else
+#define __SYSCALL_time32(_nr, _sys)
 #endif
 
 #ifdef __SYSCALL_COMPAT
@@ -41,7 +63,8 @@ __SYSCALL(__NR_io_cancel, sys_io_cancel)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_getevents 4
-__SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
+__SC(time32, io_getevents, sys_io_getevents_time32)
+__SC(64, io_getevents, sys_io_getevents)
 #endif
 
 #define __NR_setxattr 5
@@ -190,9 +213,11 @@ __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_pselect6 72
-__SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
+__SCC(time32, pselect6, sys_pselect6_time32, compat_sys_pselect6_time32)
+__SC(64, pselect6, sys_pselect6)
 #define __NR_ppoll 73
-__SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
+__SCC(time32, ppoll, sys_ppoll_time32, compat_sys_ppoll_time32)
+__SC(64, ppoll, sys_ppoll)
 #endif
 
 #define __NR_signalfd4 74
@@ -235,16 +260,17 @@ __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timerfd_settime 86
-__SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
-	  sys_timerfd_settime)
+__SC(time32, timerfd_settime, sys_timerfd_settime32)
+__SC(64, timerfd_settime, sys_timerfd_settime)
 #define __NR_timerfd_gettime 87
-__SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
-	  sys_timerfd_gettime)
+__SC(time32, timerfd_gettime, sys_timerfd_gettime32)
+__SC(64, timerfd_gettime, sys_timerfd_gettime)
 #endif
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_utimensat 88
-__SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
+__SC(time32, utimensat, sys_utimensat_time32)
+__SC(64, utimensat, sys_utimensat)
 #endif
 
 #define __NR_acct 89
@@ -268,7 +294,8 @@ __SYSCALL(__NR_unshare, sys_unshare)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
-__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+__SC(time32, futex, sys_futex_time32)
+__SC(64, futex, sys_futex)
 #endif
 
 #define __NR_set_robust_list 99
@@ -280,7 +307,8 @@ __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
-__SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
+__SC(time32, nanosleep, sys_nanosleep_time32)
+__SC(64, nanosleep, sys_nanosleep)
 #endif
 
 #define __NR_getitimer 102
@@ -298,7 +326,8 @@ __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_gettime 108
-__SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
+__SC(time32, timer_gettime, sys_timer_gettime32)
+__SC(64, timer_gettime, sys_timer_gettime)
 #endif
 
 #define __NR_timer_getoverrun 109
@@ -306,7 +335,8 @@ __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_settime 110
-__SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
+__SC(time32, timer_settime, sys_timer_settime32)
+__SC(64, timer_settime, sys_timer_settime)
 #endif
 
 #define __NR_timer_delete 111
@@ -314,14 +344,17 @@ __SYSCALL(__NR_timer_delete, sys_timer_delete)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_settime 112
-__SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
+__SC(time32, clock_settime, sys_clock_settime32)
+__SC(64, clock_settime, sys_clock_settime)
 #define __NR_clock_gettime 113
-__SC_3264(__NR_clock_gettime, sys_clock_gettime32, sys_clock_gettime)
+__SC(time32, clock_gettime, sys_clock_gettime32)
+__SC(64, clock_gettime, sys_clock_gettime)
 #define __NR_clock_getres 114
-__SC_3264(__NR_clock_getres, sys_clock_getres_time32, sys_clock_getres)
+__SC(time32, clock_getres, sys_clock_getres_time32)
+__SC(64, clock_getres, sys_clock_getres)
 #define __NR_clock_nanosleep 115
-__SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
-	  sys_clock_nanosleep)
+__SC(time32, clock_nanosleep, sys_clock_nanosleep_time32)
+__SC(64, clock_nanosleep, sys_clock_nanosleep)
 #endif
 
 #define __NR_syslog 116
@@ -351,8 +384,8 @@ __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_sched_rr_get_interval 127
-__SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
-	  sys_sched_rr_get_interval)
+__SC(time32, sched_rr_get_interval, sys_sched_rr_get_interval_time32)
+__SC(64, sched_rr_get_interval, sys_sched_rr_get_interval)
 #endif
 
 #define __NR_restart_syscall 128
@@ -376,8 +409,8 @@ __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_rt_sigtimedwait 137
-__SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
-	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
+__SCC(time32, rt_sigtimedwait, sys_rt_sigtimedwait_time32, compat_sys_rt_sigtimedwait_time32)
+__SC(64, rt_sigtimedwait, sys_rt_sigtimedwait)
 #endif
 
 #define __NR_rt_sigqueueinfo 138
@@ -451,11 +484,14 @@ __SYSCALL(__NR_getcpu, sys_getcpu)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
-__SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
+__SCC(time32, gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
+__SC(64, gettimeofday, sys_gettimeofday)
 #define __NR_settimeofday 170
-__SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
+__SCC(time32, settimeofday, sys_settimeofday, compat_sys_settimeofday)
+__SC(64, settimeofday, sys_settimeofday)
 #define __NR_adjtimex 171
-__SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
+__SC(time32, adjtimex, sys_adjtimex_time32)
+__SC(64, adjtimex, sys_adjtimex)
 #endif
 
 #define __NR_getpid 172
@@ -481,10 +517,11 @@ __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_mq_timedsend 182
-__SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
+__SC(time32, mq_timedsend, sys_mq_timedsend_time32)
+__SC(64, mq_timedsend, sys_mq_timedsend)
 #define __NR_mq_timedreceive 183
-__SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
-	  sys_mq_timedreceive)
+__SC(time32, mq_timedreceive, sys_mq_timedreceive_time32)
+__SC(64, mq_timedreceive, sys_mq_timedreceive)
 #endif
 
 #define __NR_mq_notify 184
@@ -506,7 +543,8 @@ __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
+__SC(time32, semtimedop, sys_semtimedop_time32)
+__SC(64, semtimedop, sys_semtimedop)
 #endif
 
 #define __NR_semop 193
@@ -618,7 +656,8 @@ __SYSCALL(__NR_accept4, sys_accept4)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_recvmmsg 243
-__SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
+__SCC(time32, recvmmsg, sys_recvmmsg_time32, compat_sys_recvmmsg_time32)
+__SC(64, recvmmsg, sys_recvmmsg)
 #endif
 
 /*
@@ -629,7 +668,8 @@ __SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recv
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_wait4 260
-__SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
+__SCC(time32, wait4, sys_wait4, compat_sys_wait4)
+__SC(64, wait4, sys_wait4)
 #endif
 
 #define __NR_prlimit64 261
@@ -645,7 +685,8 @@ __SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_adjtime 266
-__SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
+__SC(time32, clock_adjtime, sys_clock_adjtime32)
+__SC(64, clock_adjtime, sys_clock_adjtime)
 #endif
 
 #define __NR_syncfs 267
@@ -701,7 +742,8 @@ __SYSCALL(__NR_statx,     sys_statx)
 
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_pgetevents 292
-__SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
+__SCC(time32, io_pgetevents, sys_io_pgetevents_time32, compat_sys_io_pgetevents)
+__SC(64, io_pgetevents, sys_io_pgetevents)
 #endif
 
 #define __NR_rseq 293
@@ -713,45 +755,45 @@ __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
-__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+__SC(32, clock_gettime64, sys_clock_gettime)
 #define __NR_clock_settime64 404
-__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+__SC(32, clock_settime64, sys_clock_settime)
 #define __NR_clock_adjtime64 405
-__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+__SC(32, clock_adjtime64, sys_clock_adjtime)
 #define __NR_clock_getres_time64 406
-__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+__SC(32, clock_getres_time64, sys_clock_getres)
 #define __NR_clock_nanosleep_time64 407
-__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+__SC(32, clock_nanosleep_time64, sys_clock_nanosleep)
 #define __NR_timer_gettime64 408
-__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+__SC(32, timer_gettime64, sys_timer_gettime)
 #define __NR_timer_settime64 409
-__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+__SC(32, timer_settime64, sys_timer_settime)
 #define __NR_timerfd_gettime64 410
-__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+__SC(32, timerfd_gettime64, sys_timerfd_gettime)
 #define __NR_timerfd_settime64 411
-__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+__SC(32, timerfd_settime64, sys_timerfd_settime)
 #define __NR_utimensat_time64 412
-__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+__SC(32, utimensat_time64, sys_utimensat)
 #define __NR_pselect6_time64 413
-__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
+__SCC(32, pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
 #define __NR_ppoll_time64 414
-__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+__SCC(32, ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
+__SCC(32, io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
-__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
+__SCC(32, recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
-__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+__SC(32, mq_timedsend_time64, sys_mq_timedsend)
 #define __NR_mq_timedreceive_time64 419
-__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+__SC(32, mq_timedreceive_time64, sys_mq_timedreceive)
 #define __NR_semtimedop_time64 420
-__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+__SC(32, semtimedop_time64, sys_semtimedop)
 #define __NR_rt_sigtimedwait_time64 421
-__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
+__SCC(32, rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
 #define __NR_futex_time64 422
-__SYSCALL(__NR_futex_time64, sys_futex)
+__SC(32, futex_time64, sys_futex)
 #define __NR_sched_rr_get_interval_time64 423
-__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+__SC(32, sched_rr_get_interval_time64, sys_sched_rr_get_interval)
 #endif
 
 #define __NR_pidfd_send_signal 424
-- 
2.39.2


