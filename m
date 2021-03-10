Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F0333A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 11:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhCJKm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 05:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhCJKmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:42:00 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A546C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:42:00 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o20so12562583qtx.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TJtkCAibz7hjjm1jVaTeeVhou55l9X9TvLV9OEul/NU=;
        b=Hl7F9vqabKzO1JpvAJxKoO0eKsrcLd75bjR7n6OK04UutFIdlrWoJNDywWph1TWQ9D
         4/XH75IwjJvZxDCijI5dDOYaHqJIQi6lmFdqRoOrsyHhMTc4m4QCCGkjR1Io97dEiTi8
         OndOpPezWItJNWZKuE4FAhaCbFHMaC/xf6u5n6ZU983LFxhVxApCxqRQTCMVHdBd1FOo
         Fxu/tnl802jTGtCqjapJ6XWBZMI+o0UT51ptRD3EqxNdfzm+UqZnwY9BLPhexchPimEs
         23R4vDm+jHihsSKDuv1AkURDbZ0zj9t5EYhEijQyTyf5GJhZlj0mAsokco+r7kvN9UiE
         SthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TJtkCAibz7hjjm1jVaTeeVhou55l9X9TvLV9OEul/NU=;
        b=A2nXymGZK0Rf519/D6rERFSqpr/diIWTa2zjxvSydX3628rVC3uAkHc0sABwW2irx4
         rxOKniL78XW+OzH7PBqK9DuvJc+T9OtF3Bd6x52Xs9HS0ZOgwl9YHqm2uhZhmcKoYVKa
         X5jbU5eQyO7HY6JmIM9tbK53md+Fv03w47l32WukzQNP/hUpZELJERBPwhmKXZFxZ5oc
         HgumcsERI4r1P27RYwigZKL9zBmPmiXaQIFQ1qPWPJbMghwZSfWa/eC6oLtLcBv/By/L
         v10dzkQYjydeF1SOM1WBbFtg07tWrsPS++b13QGWrtAnd0/GeSlhhj7A9FvykKUSHmUj
         +T8w==
X-Gm-Message-State: AOAM533Weu3QTgJ9XjXvHIfhjtUc1DOfas/QqGIgnvBuInRSK3rPc4GJ
        NtX1yTRXA+sN/AXHyJKmC+Z+f3dexw==
X-Google-Smtp-Source: ABdhPJw0lHjg5zwIAtMr6GblQojvjUWlevPqNsc+waoiHuzSZKERaPy1g/Wnbrm4g69+1jZNoe5plHpeKg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
 (user=elver job=sendgmr) by 2002:a05:6214:90b:: with SMTP id
 dj11mr2130953qvb.52.1615372919806; Wed, 10 Mar 2021 02:41:59 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:41:35 +0100
In-Reply-To: <20210310104139.679618-1-elver@google.com>
Message-Id: <20210310104139.679618-5-elver@google.com>
Mime-Version: 1.0
References: <20210310104139.679618-1-elver@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH RFC v2 4/8] signal: Introduce TRAP_PERF si_code and si_perf to siginfo
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduces the TRAP_PERF si_code, and associated siginfo_t field
si_perf. These will be used by the perf event subsystem to send signals
(if requested) to the task where an event occurred.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/m68k/kernel/signal.c          |  3 +++
 arch/x86/kernel/signal_compat.c    |  5 ++++-
 fs/signalfd.c                      |  4 ++++
 include/linux/compat.h             |  2 ++
 include/linux/signal.h             |  1 +
 include/uapi/asm-generic/siginfo.h |  6 +++++-
 include/uapi/linux/signalfd.h      |  4 +++-
 kernel/signal.c                    | 11 +++++++++++
 8 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 349570f16a78..a4b7ee1df211 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -622,6 +622,9 @@ static inline void siginfo_build_tests(void)
 	/* _sigfault._addr_pkey */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x12);
 
+	/* _sigfault._perf */
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x10);
+
 	/* _sigpoll */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_fd)     != 0x10);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a5330ff498f0..0e5d0a7e203b 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -29,7 +29,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGFPE  != 15);
 	BUILD_BUG_ON(NSIGSEGV != 9);
 	BUILD_BUG_ON(NSIGBUS  != 5);
-	BUILD_BUG_ON(NSIGTRAP != 5);
+	BUILD_BUG_ON(NSIGTRAP != 6);
 	BUILD_BUG_ON(NSIGCHLD != 6);
 	BUILD_BUG_ON(NSIGSYS  != 2);
 
@@ -138,6 +138,9 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
 
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x18);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf) != 0x10);
+
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
 	CHECK_SI_SIZE   (_sigpoll, 4*sizeof(int));
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 456046e15873..040a1142915f 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -134,6 +134,10 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 #endif
 		new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
 		break;
+	case SIL_PERF_EVENT:
+		new.ssi_addr = (long) kinfo->si_addr;
+		new.ssi_perf = kinfo->si_perf;
+		break;
 	case SIL_CHLD:
 		new.ssi_pid    = kinfo->si_pid;
 		new.ssi_uid    = kinfo->si_uid;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be753603..c8821d966812 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -236,6 +236,8 @@ typedef struct compat_siginfo {
 					char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
 					u32 _pkey;
 				} _addr_pkey;
+				/* used when si_code=TRAP_PERF */
+				compat_u64 _perf;
 			};
 		} _sigfault;
 
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 205526c4003a..1e98548d7cf6 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -43,6 +43,7 @@ enum siginfo_layout {
 	SIL_FAULT_MCEERR,
 	SIL_FAULT_BNDERR,
 	SIL_FAULT_PKUERR,
+	SIL_PERF_EVENT,
 	SIL_CHLD,
 	SIL_RT,
 	SIL_SYS,
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d2597000407a..d0bb9125c853 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -91,6 +91,8 @@ union __sifields {
 				char _dummy_pkey[__ADDR_BND_PKEY_PAD];
 				__u32 _pkey;
 			} _addr_pkey;
+			/* used when si_code=TRAP_PERF */
+			__u64 _perf;
 		};
 	} _sigfault;
 
@@ -155,6 +157,7 @@ typedef struct siginfo {
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
+#define si_perf		_sifields._sigfault._perf
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
@@ -253,7 +256,8 @@ typedef struct siginfo {
 #define TRAP_BRANCH     3	/* process taken branch trap */
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
 #define TRAP_UNK	5	/* undiagnosed trap */
-#define NSIGTRAP	5
+#define TRAP_PERF	6	/* perf event with sigtrap=1 */
+#define NSIGTRAP	6
 
 /*
  * There is an additional set of SIGTRAP si_codes used by ptrace
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index 83429a05b698..7e333042c7e3 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -39,6 +39,8 @@ struct signalfd_siginfo {
 	__s32 ssi_syscall;
 	__u64 ssi_call_addr;
 	__u32 ssi_arch;
+	__u32 __pad3;
+	__u64 ssi_perf;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
@@ -49,7 +51,7 @@ struct signalfd_siginfo {
 	 * comes out of a read(2) and we really don't want to have
 	 * a compat on read(2).
 	 */
-	__u8 __pad[28];
+	__u8 __pad[16];
 };
 
 
diff --git a/kernel/signal.c b/kernel/signal.c
index ba4d1ef39a9e..f68351825e5e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1199,6 +1199,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
+	case SIL_PERF_EVENT:
 	case SIL_SYS:
 		ret = false;
 		break;
@@ -2531,6 +2532,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
+	case SIL_PERF_EVENT:
 		ksig->info.si_addr = arch_untagged_si_addr(
 			ksig->info.si_addr, ksig->sig, ksig->info.si_code);
 		break;
@@ -3333,6 +3335,10 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 #endif
 		to->si_pkey = from->si_pkey;
 		break;
+	case SIL_PERF_EVENT:
+		to->si_addr = ptr_to_compat(from->si_addr);
+		to->si_perf = from->si_perf;
+		break;
 	case SIL_CHLD:
 		to->si_pid = from->si_pid;
 		to->si_uid = from->si_uid;
@@ -3413,6 +3419,10 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 #endif
 		to->si_pkey = from->si_pkey;
 		break;
+	case SIL_PERF_EVENT:
+		to->si_addr = compat_ptr(from->si_addr);
+		to->si_perf = from->si_perf;
+		break;
 	case SIL_CHLD:
 		to->si_pid    = from->si_pid;
 		to->si_uid    = from->si_uid;
@@ -4593,6 +4603,7 @@ static inline void siginfo_buildtime_checks(void)
 	CHECK_OFFSET(si_lower);
 	CHECK_OFFSET(si_upper);
 	CHECK_OFFSET(si_pkey);
+	CHECK_OFFSET(si_perf);
 
 	/* sigpoll */
 	CHECK_OFFSET(si_band);
-- 
2.30.1.766.gb4fecdf3b7-goog

