Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AB22BC001
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgKUOoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgKUOoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:44:11 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D651C0613CF;
        Sat, 21 Nov 2020 06:44:08 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so11956733qke.1;
        Sat, 21 Nov 2020 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qE1x6H4Fy3MfUlojyiG5SemJMOEUWmWjoodQCFGhVSY=;
        b=I8fcH2d4kxycP5DFsTlrSERwVi0RV2zOfKcBl6K5+DltOtbM2re0GT+IgrDOyRB0El
         /LjdpTdRsshtGR0WHU+3MH1JZH0Z9Gd4c8SblO3WWnC9rOBv7tcXyV7cPceiLWgphCt6
         vlkYcGwI4x+I8Pv7zZYiDNdUy+F/l9Fl001RdhF26AQnEKGRDLGs1aT/t5oRhW9edysU
         j7axxP84bOjOw2WibPuR2R8LOP7ceBn58H6Q4JfMr+4IN8PCAl5GeTBHNEOFkghZDC9q
         0c5nOdEkm0/Q6cnlOYqupMBAEO3h0UPiAXcOFbBMOtSOjNroIamfdB0NG63tABJNpECW
         d+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qE1x6H4Fy3MfUlojyiG5SemJMOEUWmWjoodQCFGhVSY=;
        b=MvUdrfLU6VE0gYtVhkQwqjQRZtOu+5JiIkrO5DgovTjswvOlk/BJ2nHxwSarWmh4Jy
         Rag8Y7cnL+V9LeNKzYXQvm52AukpBxHRSr5WSvQWpH4MDZB6Utp3MCaQaN79ajHiOmXo
         yRP2uVqkDMg0yq9fYjvzicYsQwK/Hk+Miw+EYLiAAjXI83OyU8oj9qTxCw7eaTyUSUbL
         /clOrTJ5Z0umwdT+3tVELW9kmdbK3+3BxVjqbjVVnS9OLm8AZZIuIMVxaA2OgS3XF7PZ
         oIWmFPffauHQA2HhdYP11iShTG06go9PhTk8b5wAx0RAeT83qNQsy09E+cJUXqFglUJ0
         pR0g==
X-Gm-Message-State: AOAM531y5idV7KDPdn1QLPMxZEqvLZyLAbHJhxP+Ww5Kv2Zp8QuB9p+r
        QvqZKIL6w0NBMtz7rV0/+uDNe/ViYsw=
X-Google-Smtp-Source: ABdhPJy2fWW1j4wZlTT62pedAl0UryvreljPaG62csmYvZyy+Owz0EBIXIEhzpmbD16995kdCalH/Q==
X-Received: by 2002:a37:ad19:: with SMTP id f25mr20851752qkm.308.1605969847122;
        Sat, 21 Nov 2020 06:44:07 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id q15sm4055137qki.13.2020.11.21.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 06:44:06 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com,
        willy@infradead.org, arnd@arndb.de, shuochen@google.com,
        linux-man@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH v4 3/4] epoll: wire up syscall epoll_pwait2
Date:   Sat, 21 Nov 2020 09:43:59 -0500
Message-Id: <20201121144401.3727659-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
References: <20201121144401.3727659-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Split off from prev patch in the series that implements the syscall.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 2 ++
 arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/linux/compat.h                      | 6 ++++++
 include/linux/syscalls.h                    | 5 +++++
 include/uapi/asm-generic/unistd.h           | 4 +++-
 kernel/sys_ni.c                             | 2 ++
 22 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c5cc5bfa2062..506e59a9ff87 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 549	common	faccessat2			sys_faccessat2
 550	common	process_madvise			sys_process_madvise
 551	common	watch_mount			sys_watch_mount
+553	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 47325b3b661a..dbde88a855b6 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -455,3 +455,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 949788f5ba40..d1f7d35f986e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		443
+#define __NR_compat_syscalls		444
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c71c3fe0b6cd..b84e24a7e2c0 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -893,6 +893,8 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
 #define __NR_memfd_secret 442
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
+#define __NR_epoll_pwait2 443
+__SYSCALL(__NR_epoll_pwait2, sys_epoll_pwait2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 033244462350..c8809959636f 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -362,3 +362,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index efd3ecb3cdfc..dde585616bf8 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 67ae5a5e4d21..4c09f27fedd0 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -447,3 +447,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index c59bc6acc47a..00921244242d 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -380,3 +380,4 @@
 439	n32	faccessat2			sys_faccessat2
 440	n32	process_madvise			sys_process_madvise
 441	n32	watch_mount			sys_watch_mount
+443	n32	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 50bbb9517052..b7920f76358d 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -356,3 +356,4 @@
 439	n64	faccessat2			sys_faccessat2
 440	n64	process_madvise			sys_process_madvise
 441	n64	watch_mount			sys_watch_mount
+443	n64	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 1d5644e221b4..2ab5ed500113 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -429,3 +429,4 @@
 439	o32	faccessat2			sys_faccessat2
 440	o32	process_madvise			sys_process_madvise
 441	o32	watch_mount			sys_watch_mount
+443	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 4492cc2fce23..9caf7d969846 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index ee122bfc2ddc..dce635420226 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -531,3 +531,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index b467b57d66d1..dedfa6db9f8d 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441	common	watch_mount		sys_watch_mount			sys_watch_mount
+443  common	epoll_pwait2		sys_epoll_pwait2		sys_epoll_pwait2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index f9c7ca5cb969..f7a383ae2c48 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 341fd4ba053b..a6cdf450d0f4 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -487,3 +487,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 109e6681b8fa..9a4e8ec207fc 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -447,3 +447,4 @@
 440	i386	process_madvise		sys_process_madvise
 441	i386	watch_mount		sys_watch_mount
 442	i386	memfd_secret		sys_memfd_secret
+443	i386	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 742cf17d7725..e2cb5f87e760 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -364,6 +364,7 @@
 440	common	process_madvise		sys_process_madvise
 441	common	watch_mount		sys_watch_mount
 442	common	memfd_secret		sys_memfd_secret
+443	common	epoll_pwait2		sys_epoll_pwait2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 6225d87be81f..1c8ae5fd026e 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -412,3 +412,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	watch_mount			sys_watch_mount
+443	common	epoll_pwait2			sys_epoll_pwait2
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 14d514233e1d..76dc28a2e7f1 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -505,6 +505,12 @@ asmlinkage long compat_sys_epoll_pwait(int epfd,
 			int maxevents, int timeout,
 			const compat_sigset_t __user *sigmask,
 			compat_size_t sigsetsize);
+asmlinkage long compat_sys_epoll_pwait2(int epfd,
+			struct epoll_event __user *events,
+			int maxevents,
+			const struct __kernel_timespec __user *timeout,
+			const compat_sigset_t __user *sigmask,
+			compat_size_t sigsetsize);
 
 /* fs/fcntl.c */
 asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e87a96ace85b..2ba45fb7874c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -362,6 +362,11 @@ asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
 				int maxevents, int timeout,
 				const sigset_t __user *sigmask,
 				size_t sigsetsize);
+asmlinkage long sys_epoll_pwait2(int epfd, struct epoll_event __user *events,
+				 int maxevents,
+				 const struct __kernel_timespec __user *timeout,
+				 const sigset_t __user *sigmask,
+				 size_t sigsetsize);
 
 /* fs/fcntl.c */
 asmlinkage long sys_dup(unsigned int fildes);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3bc087d14535..aa883388700e 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -865,9 +865,11 @@ __SYSCALL(__NR_watch_mount, sys_watch_mount)
 #define __NR_memfd_secret 442
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
+#define __NR_epoll_pwait2 443
+__SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 443
+#define __NR_syscalls 444
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 805fd7a668be..869aa6b5bf34 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -68,6 +68,8 @@ COND_SYSCALL(epoll_create1);
 COND_SYSCALL(epoll_ctl);
 COND_SYSCALL(epoll_pwait);
 COND_SYSCALL_COMPAT(epoll_pwait);
+COND_SYSCALL(epoll_pwait2);
+COND_SYSCALL_COMPAT(epoll_pwait2);
 
 /* fs/fcntl.c */
 
-- 
2.29.2.454.gaff20da3a2-goog

