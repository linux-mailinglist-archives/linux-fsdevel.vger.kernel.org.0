Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC42B7FB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKROq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 09:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgKROqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:46:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D694C0613D4;
        Wed, 18 Nov 2020 06:46:23 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a13so1980409qkl.4;
        Wed, 18 Nov 2020 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTbwznGPFvYh8IB1rVPV2ZSBBaIu9qwGgCY2xjyuFqI=;
        b=cJm+H3nEgqq/YUV3yzIyDWGogruKJW5tRlBj2b151KQ39b/f5eFPsEkqFvw6JhCFVU
         mdSzOs66R7/kAUYQveGRGdTM969popwnxkNEZn5BkrBYmeri/PCrxakvga5YVlVTy2Sm
         r8IV1eXq+WvwGNol1boXSAc+D0y29apn+yuiyN7euewKqag253mgja37HzbDgGOAuuQC
         9xSDecCIGMxmzIUhTPLPwJNWvz7+XCoZnuc9BiVGxiEna9jirDqg+PVnTnsbzLLKr93l
         fmLiMWiG8r119vAJ9b403a78wg35qhnc6zuE6A8Q+7zof+uNkWJxldk4xXrTnwbeyB5E
         tK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTbwznGPFvYh8IB1rVPV2ZSBBaIu9qwGgCY2xjyuFqI=;
        b=k5NSfM5Kv0biGHgSK0OcdHZbd3X+e9AtIPsAigW7ObWNeeL+BSOkjBXZDUmUTeZE2S
         n9w0HKMWcT39SzeRqtT8BCFdYR0WGs1D/Asa6ddjB9yRQFG2zwALylNlIZkbbPTS9kEt
         bvVg75kTvbkXa+qMuRBKOOvNXTbARRv+DLZH12+CT9DZmXUWW+WmG/g38brpcgHsaDCO
         um2biQf7J3kwkcLoeZR7eKzoVbtjOv1BpcJtN882AQS72PJ5NI0I41YrJ0X1XgYUxjEv
         dTDdzZqYUS5TAmKYy4sI0Rk3x2yOeCpCBGcb4XLbGjulhHeOSsgP48dcmIwR1ogKcD7l
         YkqQ==
X-Gm-Message-State: AOAM532RpiGJFg8WmPhh4CxL7N6kz9jPb+b3e7nPVJkDBmUdqiPfwffb
        LuCd0Nx9kjnG58lXUBbvBULhEykS6pw=
X-Google-Smtp-Source: ABdhPJwbUZtahW8pW4FK4ES7+sbL9Onv/iVtv9+8epoXbw5SrrP1DzjRtvhJMzz7XSU1rZl3N2W/jQ==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr4902251qks.193.1605710781670;
        Wed, 18 Nov 2020 06:46:21 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id k188sm4910810qkd.98.2020.11.18.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:46:21 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, soheil.kdev@gmail.com, arnd@arndb.de,
        shuochen@google.com, linux-man@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
Date:   Wed, 18 Nov 2020 09:46:15 -0500
Message-Id: <20201118144617.986860-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Add syscall epoll_pwait2, an epoll_wait variant with nsec resolution
that replaces int timeout with struct timespec. It is equivalent
otherwise.

    int epoll_pwait2(int fd, struct epoll_event *events,
                     int maxevents,
                     const struct timespec *timeout,
                     const sigset_t *sigset);

The underlying hrtimer is already programmed with nsec resolution.
pselect and ppoll also set nsec resolution timeout with timespec.

The sigset_t in epoll_pwait has a compat variant. epoll_pwait2 needs
the same.

For timespec, only support this new interface on 2038 aware platforms
that define __kernel_timespec_t. So no CONFIG_COMPAT_32BIT_TIME.

Changes
  v3:
  - rewrite: add epoll_pwait2 syscall instead of epoll_create1 flag
  v2:
  - cast to s64: avoid overflow on 32-bit platforms (Shuo Chen)
  - minor commit message rewording

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

This version applies cleanly to linux-next-20201117.
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 fs/eventpoll.c                              | 106 ++++++++++++++++----
 include/linux/compat.h                      |   6 ++
 include/linux/syscalls.h                    |   5 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/sys_ni.c                             |   2 +
 23 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c5cc5bfa2062..e0a599bfb0e1 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 549	common	faccessat2			sys_faccessat2
 550	common	process_madvise			sys_process_madvise
 551	common	watch_mount			sys_watch_mount
+552	common	epoll_pwait2			sys_epoll_pwait2
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
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 297aeb0ee9d1..0f0543e1cc6f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1714,13 +1714,11 @@ static int ep_send_events(struct eventpoll *ep,
 	return res;
 }
 
-static inline struct timespec64 ep_set_mstimeout(long ms)
+static inline struct timespec64 ep_set_nstimeout(s64 timeout)
 {
-	struct timespec64 now, ts = {
-		.tv_sec = ms / MSEC_PER_SEC,
-		.tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
-	};
+	struct timespec64 now, ts;
 
+	ts = ns_to_timespec64(timeout);
 	ktime_get_ts64(&now);
 	return timespec64_add_safe(now, ts);
 }
@@ -1734,7 +1732,7 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
  *          stored.
  * @maxevents: Size (in terms of number of events) of the caller event buffer.
  * @timeout: Maximum timeout for the ready events fetch operation, in
- *           milliseconds. If the @timeout is zero, the function will not block,
+ *           nanoseconds. If the @timeout is zero, the function will not block,
  *           while if the @timeout is less than zero, the function will block
  *           until at least one event has been retrieved (or an error
  *           occurred).
@@ -1743,7 +1741,7 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
  *          error code, in case of error.
  */
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
-		   int maxevents, long timeout)
+		   int maxevents, s64 timeout)
 {
 	int res, eavail, timed_out = 0;
 	u64 slack = 0;
@@ -1753,7 +1751,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	lockdep_assert_irqs_enabled();
 
 	if (timeout > 0) {
-		struct timespec64 end_time = ep_set_mstimeout(timeout);
+		struct timespec64 end_time = ep_set_nstimeout(timeout);
 
 		slack = select_estimate_accuracy(&end_time);
 		to = &expires;
@@ -2177,7 +2175,7 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
  * part of the user space epoll_wait(2).
  */
 static int do_epoll_wait(int epfd, struct epoll_event __user *events,
-			 int maxevents, int timeout)
+			 int maxevents, s64 timeout)
 {
 	int error;
 	struct fd f;
@@ -2218,19 +2216,27 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	return error;
 }
 
+static s64 timeout_to_ns(int timeout)
+{
+	if (timeout <= 0)
+		return timeout;
+	else
+		return timeout * (s64)NSEC_PER_MSEC;
+}
+
 SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 		int, maxevents, int, timeout)
 {
-	return do_epoll_wait(epfd, events, maxevents, timeout);
+	return do_epoll_wait(epfd, events, maxevents, timeout_to_ns(timeout));
 }
 
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_pwait(2).
  */
-SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
-		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
-		size_t, sigsetsize)
+static int do_epoll_pwait(int epfd, struct epoll_event __user *events,
+			  int maxevents, s64 timeout,
+			  const sigset_t __user *sigmask, size_t sigsetsize)
 {
 	int error;
 
@@ -2248,12 +2254,40 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 	return error;
 }
 
+SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
+		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
+		size_t, sigsetsize)
+{
+	return do_epoll_pwait(epfd, events, maxevents, timeout_to_ns(timeout),
+			      sigmask, sigsetsize);
+}
+
+SYSCALL_DEFINE6(epoll_pwait2, int, epfd, struct epoll_event __user *, events,
+		int, maxevents, const struct __kernel_timespec __user *, timeout,
+		const sigset_t __user *, sigmask, size_t, sigsetsize)
+{
+	struct timespec64 ts;
+	s64 timeout_ns;
+
+	if (timeout) {
+		if (get_timespec64(&ts, timeout))
+			return -EFAULT;
+		if (!timespec64_valid(&ts))
+			return -EINVAL;
+		timeout_ns = timespec64_to_ns(&ts);
+	} else {
+		timeout_ns = -1;
+	}
+
+	return do_epoll_pwait(epfd, events, maxevents, timeout_ns,
+			      sigmask, sigsetsize);
+}
+
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
-			struct epoll_event __user *, events,
-			int, maxevents, int, timeout,
-			const compat_sigset_t __user *, sigmask,
-			compat_size_t, sigsetsize)
+static int do_compat_epoll_pwait(int epfd, struct epoll_event __user *events,
+				 int maxevents, s64 timeout,
+				 const compat_sigset_t __user *sigmask,
+				 compat_size_t sigsetsize)
 {
 	long err;
 
@@ -2270,6 +2304,42 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 
 	return err;
 }
+
+COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
+		       struct epoll_event __user *, events,
+		       int, maxevents, int, timeout,
+		       const compat_sigset_t __user *, sigmask,
+		       compat_size_t, sigsetsize)
+{
+	return do_compat_epoll_pwait(epfd, events, maxevents,
+				     timeout_to_ns(timeout),
+				     sigmask, sigsetsize);
+}
+
+COMPAT_SYSCALL_DEFINE6(epoll_pwait2, int, epfd,
+		       struct epoll_event __user *, events,
+		       int, maxevents,
+		       const struct __kernel_timespec __user *, timeout,
+		       const compat_sigset_t __user *, sigmask,
+		       compat_size_t, sigsetsize)
+{
+	struct timespec64 ts;
+	s64 timeout_ns;
+
+	if (timeout) {
+		if (get_timespec64(&ts, timeout))
+			return -EFAULT;
+		if (!timespec64_valid(&ts))
+			return -EINVAL;
+		timeout_ns = timespec64_to_ns(&ts);
+	} else {
+		timeout_ns = -1;
+	}
+
+	return do_compat_epoll_pwait(epfd, events, maxevents, timeout_ns,
+				     sigmask, sigsetsize);
+}
+
 #endif
 
 static int __init eventpoll_init(void)
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

