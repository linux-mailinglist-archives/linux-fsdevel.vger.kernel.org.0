Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8977725FD5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgIGPoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 11:44:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbgIGPjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:39:21 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MIxBc-1jzIol2opu-00KM31; Mon, 07 Sep 2020 17:38:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
Date:   Mon,  7 Sep 2020 17:36:46 +0200
Message-Id: <20200907153701.2981205-6-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200907153701.2981205-1-arnd@arndb.de>
References: <20200907153701.2981205-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dS64v5/67WcSBvmrbNVGhphNt1FgRvU1pyHahjJkpeUqCsFd7QO
 OUcFy31jPNmRQ8vS6DJmGj8qP+2Z7MQousQb7TFS/y0SC/TssD72rmkHYSn75z1652WD9U0
 zXVBVfxV7RedghJgM3TRJivGp8v08m0tbuLWEndTIG+4mOkoK2WlevAI2uzJj1PUKUvFRMU
 wPQ/QS2t6GHeYMgWdyNUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1vSjxgylD+g=:lO5EfuQ2sJsunJ/uLaENqm
 LnK09T/s+nRK4GaPYwTHXc9TmKEMiwHyzDRW3B/4LEiRBInOtyo04+zGP7SE6I0QvbU3SiTiy
 nsOnD8zVA7f2jIT/UQnPO6HSV2fEqYKdqwwlAonG03x8+am/qIY1GMGwYYf2Gq3ryLH/EUpRp
 xRBk9hQqM6hH3C+8CCxqkrqPtsfumbpGjNdRWuW/umIz52o0nepdUqP2DqVWUy6K4bs7nlgds
 +wQi4ABbjatmaU7mwDeg07ohUOfUy0mluKFCnAoEhoupgFZPk8zJ7v4p+Mo+C/a30s2IENgsp
 32Cxekzrp/3TEzgmD176LpGtizkWTDjWIXfEk1Yqj73dXYiGEuzB1SqcJEsKO03isinF5s6vU
 TZNxIYgc1pxeQS+DKPIzRHx1e5Dh28PW8W54kcYpyP8VPjBdf9JTrZ2PV/lS8jwPZ9aN6g9hx
 zLenphWRlh2DW57jAL2ApnTmJzmI3ix0iWWLx6NA/LCXWuXXddJ+E4ZhFXrGys5z1fNFEO6gX
 6qMPZ2Qz9ifaYmYm82W+sBLesbfBvOGACqWClEnW/jYb5jbs0te1k4mY6OD2uteRMdtcHaV2S
 Qm3ug6t4g9RRYE8bR0p5m/Vxr0/qfyVZ4hVbI2fYRLj0z3phWkd1y/mRGgyyPdU6CTfOhn320
 5adQJhBVay0+Skbw5a6oZrcjCAihzQGl7zqezTc4AnpaofNJaaQL/qN853gByggw6ph+Z7veZ
 LnQDajcm2sN7nhKj4oKz8HzuNT/NV3ZgcAnugmWAWOHgw5TqrL9WElN5XLCp/xXhJu1zt4c0E
 GLv+zqeGEeupIxYiaLN/ulENDoElkhmms039vY+Q5+zjGfYMantbPlwZZDrK7bXldf0Oo6L
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The epoll_wait() system call wrapper is one of the remaining users of
the set_fs() infrasturcture for Arm. Changing it to not require set_fs()
is rather complex unfortunately.

The approach I'm taking here is to allow architectures to override
the code that copies the output to user space, and let the oabi-compat
implementation check whether it is getting called from an EABI or OABI
system call based on the thread_info->syscall value.

The in_oabi_syscall() check here mirrors the in_compat_syscall() and
in_x32_syscall() helpers for 32-bit compat implementations on other
architectures.

Overall, the amount of code goes down, at least with the newly added
sys_oabi_epoll_pwait() helper getting removed again. The downside
is added complexity in the source code for the native implementation.
There should be no difference in runtime performance except for Arm
kernels with CONFIG_OABI_COMPAT enabled that now have to go through
an external function call to check which of the two variants to use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/syscall.h    | 11 +++++
 arch/arm/kernel/sys_oabi-compat.c | 72 +++++++------------------------
 arch/arm/tools/syscall.tbl        |  4 +-
 fs/eventpoll.c                    |  5 +--
 include/linux/eventpoll.h         | 16 +++++++
 5 files changed, 46 insertions(+), 62 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index ff6cc365eaf7..0d8afceeefd9 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -28,6 +28,17 @@ static inline int syscall_get_nr(struct task_struct *task,
 	return task_thread_info(task)->syscall;
 }
 
+static inline bool __in_oabi_syscall(struct task_struct *task)
+{
+	return IS_ENABLED(CONFIG_OABI_COMPAT) &&
+		(task_thread_info(task)->syscall & __NR_OABI_SYSCALL_BASE);
+}
+
+static inline bool in_oabi_syscall(void)
+{
+	return __in_oabi_syscall(current);
+}
+
 static inline void syscall_rollback(struct task_struct *task,
 				    struct pt_regs *regs)
 {
diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 2ce3e8c6ca91..abf1153c5315 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -83,6 +83,8 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+#include <asm/syscall.h>
+
 struct oldabi_stat64 {
 	unsigned long long st_dev;
 	unsigned int	__pad1;
@@ -264,68 +266,24 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 	return do_epoll_ctl(epfd, op, fd, &kernel, false);
 }
 
-static long do_oabi_epoll_wait(int epfd, struct oabi_epoll_event __user *events,
-			       int maxevents, int timeout)
+struct epoll_event __user *
+epoll_put_uevent(__poll_t revents, __u64 data, struct epoll_event __user *uevent)
 {
-	struct epoll_event *kbuf;
-	struct oabi_epoll_event e;
-	mm_segment_t fs;
-	long ret, err, i;
+	if (in_oabi_syscall()) {
+		struct oabi_epoll_event *oevent = (void __user *)uevent;
 
-	if (maxevents <= 0 ||
-			maxevents > (INT_MAX/sizeof(*kbuf)) ||
-			maxevents > (INT_MAX/sizeof(*events)))
-		return -EINVAL;
-	if (!access_ok(events, sizeof(*events) * maxevents))
-		return -EFAULT;
-	kbuf = kmalloc_array(maxevents, sizeof(*kbuf), GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_epoll_wait(epfd, kbuf, maxevents, timeout);
-	set_fs(fs);
-	err = 0;
-	for (i = 0; i < ret; i++) {
-		e.events = kbuf[i].events;
-		e.data = kbuf[i].data;
-		err = __copy_to_user(events, &e, sizeof(e));
-		if (err)
-			break;
-		events++;
-	}
-	kfree(kbuf);
-	return err ? -EFAULT : ret;
-}
+		if (__put_user(revents, &oevent->events) ||
+		    __put_user(data, &oevent->data))
+			return NULL;
 
-SYSCALL_DEFINE4(oabi_epoll_wait, int, epfd, struct oabi_epoll_event __user *, events,
-		int, maxevents, int, timeout)
-{
-	return do_oabi_epoll_wait(epfd, events, maxevents, timeout);
-}
-
-/*
- * Implement the event wait interface for the eventpoll file. It is the kernel
- * part of the user space epoll_pwait(2).
- */
-SYSCALL_DEFINE6(oabi_epoll_pwait, int, epfd, struct oabi_epoll_event __user *, events,
-		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
-		size_t, sigsetsize)
-{
-	int error;
-
-	/*
-	 * If the caller wants a certain signal mask to be set during the wait,
-	 * we apply it here.
-	 */
-	error = set_user_sigmask(sigmask, sigsetsize);
-	if (error)
-		return error;
+		return (void __user *)uevent+1;
+	}
 
-	error = do_oabi_epoll_wait(epfd, events, maxevents, timeout);
-	restore_saved_sigmask_unless(error == -EINTR);
+	if (__put_user(revents, &uevent->events) ||
+	    __put_user(data, &uevent->data))
+		return NULL;
 
-	return error;
+	return uevent+1;
 }
 
 struct oabi_sembuf {
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 39a24bee7df8..fe5cd48fed91 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -266,7 +266,7 @@
 249	common	lookup_dcookie		sys_lookup_dcookie
 250	common	epoll_create		sys_epoll_create
 251	common	epoll_ctl		sys_epoll_ctl		sys_oabi_epoll_ctl
-252	common	epoll_wait		sys_epoll_wait		sys_oabi_epoll_wait
+252	common	epoll_wait		sys_epoll_wait
 253	common	remap_file_pages	sys_remap_file_pages
 # 254 for set_thread_area
 # 255 for get_thread_area
@@ -360,7 +360,7 @@
 343	common	vmsplice		sys_vmsplice
 344	common	move_pages		sys_move_pages
 345	common	getcpu			sys_getcpu
-346	common	epoll_pwait		sys_epoll_pwait		sys_oabi_epoll_pwait
+346	common	epoll_pwait		sys_epoll_pwait
 347	common	kexec_load		sys_kexec_load
 348	common	utimensat		sys_utimensat_time32
 349	common	signalfd		sys_signalfd
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 12eebcdea9c8..796d9e72dc96 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1745,8 +1745,8 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 		if (!revents)
 			continue;
 
-		if (__put_user(revents, &uevent->events) ||
-		    __put_user(epi->event.data, &uevent->data)) {
+		uevent = epoll_put_uevent(revents, epi->event.data, uevent);
+		if (!uevent) {
 			list_add(&epi->rdllink, head);
 			ep_pm_stay_awake(epi);
 			if (!esed->res)
@@ -1754,7 +1754,6 @@ static __poll_t ep_send_events_proc(struct eventpoll *ep, struct list_head *head
 			return 0;
 		}
 		esed->res++;
-		uevent++;
 		if (epi->event.events & EPOLLONESHOT)
 			epi->event.events &= EP_PRIVATE_BITS;
 		else if (!(epi->event.events & EPOLLET)) {
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 8f000fada5a4..60df60ee78c6 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -77,4 +77,20 @@ static inline void eventpoll_release(struct file *file) {}
 
 #endif
 
+#if !defined(CONFIG_ARM) || !defined(CONFIG_OABI_COMPAT)
+/* ARM OABI has an incompatible struct layout and needs a special handler */
+static inline struct epoll_event __user *
+epoll_put_uevent(__poll_t revents, __u64 data, struct epoll_event __user *uevent)
+{
+	if (__put_user(revents, &uevent->events) ||
+	    __put_user(data, &uevent->data))
+		return NULL;
+
+	return uevent+1;
+}
+#else
+struct epoll_event __user *
+epoll_put_uevent(__poll_t revents, __u64 data, struct epoll_event __user *uevent);
+#endif
+
 #endif /* #ifndef _LINUX_EVENTPOLL_H */
-- 
2.27.0

