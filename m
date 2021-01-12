Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8592E2F2407
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbhALAcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbhALAbF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:31:05 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7771C061575;
        Mon, 11 Jan 2021 16:30:24 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id t3so1191452ilh.9;
        Mon, 11 Jan 2021 16:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6EHLJJ6+gpWtEBuXlVgzDefY9wB/OjVkEQk+6H+7KA=;
        b=pahmPHg0lCIpL+uEish6P+uUlvsyuRffx5ZlB4dlkWq3LYv2CT1YQLIEf9Yn5zWpyq
         WPPSki+2yCkoTr2U/Tjd4pMy684VxuWJOlOFaA2stKf6q99yiUCWxvc9ggqaSgrW8xf8
         xWVndZZq/0IRnxgaSa8bfDBxobKqYsQ0wCwPfQQ74i/47vJSUEgi4LZ36IcMZ1eq2292
         UsaUbWyMbjh+mFVO4Qw+vX24Ff66nu9w5M28NS90VOn6PqQ19lv7lMy6a5LGGgwLeaCo
         2RaAkrnLHDV4ZHKkP7E7KCIV9AM8fMdmnGOsHtGTwOZ42PXEkQtDMwUPebZSwLXVeT31
         2NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6EHLJJ6+gpWtEBuXlVgzDefY9wB/OjVkEQk+6H+7KA=;
        b=OA1P7rpiuWFATwnycAZH6b66lojvqPSbGYQxH+Zs7XRLSwi65BNNvQk0xIax90En2k
         Dp68EGnS6Fmg8SVGMp2e2R3Za9WPAQHpSD5jHYYrFLYaEr1YiANg/jSYw7Feqy4RzZat
         UGe7QX9MBQu6GT3f7v4KQdNlJPjq0X5w/kqYNwv7uWuE41aFcIXyLmrirN+BQXfMyCzA
         GZcxIk4NVPT95A2n2hNwzoP0fQUi5/h5dODMh6oYgZDO7ApSy2qZslv6v2wjAOhG4aPA
         2Rz8AuXRlZ8BpFQiFsBHnU/88P+f3NvKve63Lfzd7/YuKNmiI4KwpLyIDc3+FXFp+pqm
         Thsw==
X-Gm-Message-State: AOAM532GHCH13Yn0lj1x/myHo0jhf9rngZMgSRBRbV8Z/p+99bb20lr/
        GL6GIfpRSva0nlGKQB2dEAFSoLMf+6A=
X-Google-Smtp-Source: ABdhPJxouAx0r5yGZIgmXx0Rf6FA1fdQC6+I/Rc53B0Eyk3Ssm60bRrAAkMVM6PZyW4ARk8a1ZUVDw==
X-Received: by 2002:a92:9510:: with SMTP id y16mr1643455ilh.26.1610411423692;
        Mon, 11 Jan 2021 16:30:23 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id z10sm741723ioi.47.2021.01.11.16.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:30:23 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH 2/6] select: deduplicate compat logic
Date:   Mon, 11 Jan 2021 19:30:13 -0500
Message-Id: <20210112003017.4010304-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
References: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Select and pselect have multiple syscall implementations to handle
compat and 32-bit time variants.

Deduplicate core logic, which can cause divergence over time as
changes may not be applied consistently. See vmalloc support in
select, for one example.

Handle compat differences using in_compat_syscall() where needed.
Specifically, fd_set and sigmask may be compat variants. Handle
the !in_compat_syscall() case first, for branch prediction.

Handle timeval/timespec differences by passing along the type to
where the pointer is used.

Compat variants of select and old_select can now call standard
kern_select, removing all callers to do_compat_select.

Compat variants of pselect6 (time32 and time64) can now call standard
do_pselect, removing all callers to do_compat_pselect.

That removes both callers to compat_core_sys_select. And with that
callers to compat_[gs]et_fd_set.

Also move up zero_fd_set, to avoid one open-coded variant.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 fs/select.c | 254 ++++++++++++----------------------------------------
 1 file changed, 57 insertions(+), 197 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 37aaa8317f3a..dee7dfc5217b 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -382,32 +382,39 @@ typedef struct {
 #define FDS_LONGS(nr)	(((nr)+FDS_BITPERLONG-1)/FDS_BITPERLONG)
 #define FDS_BYTES(nr)	(FDS_LONGS(nr)*sizeof(long))
 
+static inline
+void zero_fd_set(unsigned long nr, unsigned long *fdset)
+{
+	memset(fdset, 0, FDS_BYTES(nr));
+}
+
 /*
  * Use "unsigned long" accesses to let user-mode fd_set's be long-aligned.
  */
 static inline
 int get_fd_set(unsigned long nr, void __user *ufdset, unsigned long *fdset)
 {
-	nr = FDS_BYTES(nr);
-	if (ufdset)
-		return copy_from_user(fdset, ufdset, nr) ? -EFAULT : 0;
+	if (!ufdset) {
+		zero_fd_set(nr, fdset);
+		return 0;
+	}
 
-	memset(fdset, 0, nr);
-	return 0;
+	if (!in_compat_syscall())
+		return copy_from_user(fdset, ufdset, FDS_BYTES(nr)) ? -EFAULT : 0;
+	else
+		return compat_get_bitmap(fdset, ufdset, nr);
 }
 
 static inline unsigned long __must_check
 set_fd_set(unsigned long nr, void __user *ufdset, unsigned long *fdset)
 {
-	if (ufdset)
-		return __copy_to_user(ufdset, fdset, FDS_BYTES(nr));
-	return 0;
-}
+	if (!ufdset)
+		return 0;
 
-static inline
-void zero_fd_set(unsigned long nr, unsigned long *fdset)
-{
-	memset(fdset, 0, FDS_BYTES(nr));
+	if (!in_compat_syscall())
+		return __copy_to_user(ufdset, fdset, FDS_BYTES(nr));
+	else
+		return compat_put_bitmap(ufdset, fdset, nr);
 }
 
 #define FDS_IN(fds, n)		(fds->in + n)
@@ -698,15 +705,29 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 }
 
 static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
-		       fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
+		       fd_set __user *exp, void __user *tvp,
+		       enum poll_time_type type)
 {
 	struct timespec64 end_time, *to = NULL;
 	struct __kernel_old_timeval tv;
+	struct old_timeval32 otv;
 	int ret;
 
 	if (tvp) {
-		if (copy_from_user(&tv, tvp, sizeof(tv)))
-			return -EFAULT;
+		switch (type) {
+		case PT_TIMEVAL:
+			if (copy_from_user(&tv, tvp, sizeof(tv)))
+				return -EFAULT;
+			break;
+		case PT_OLD_TIMEVAL:
+			if (copy_from_user(&otv, tvp, sizeof(otv)))
+				return -EFAULT;
+			tv.tv_sec = otv.tv_sec;
+			tv.tv_usec = otv.tv_usec;
+			break;
+		default:
+			BUG();
+		}
 
 		to = &end_time;
 		if (poll_select_set_timeout(to,
@@ -716,18 +737,18 @@ static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
 	}
 
 	ret = core_sys_select(n, inp, outp, exp, to);
-	return poll_select_finish(&end_time, tvp, PT_TIMEVAL, ret);
+	return poll_select_finish(&end_time, tvp, type, ret);
 }
 
 SYSCALL_DEFINE5(select, int, n, fd_set __user *, inp, fd_set __user *, outp,
 		fd_set __user *, exp, struct __kernel_old_timeval __user *, tvp)
 {
-	return kern_select(n, inp, outp, exp, tvp);
+	return kern_select(n, inp, outp, exp, tvp, PT_TIMEVAL);
 }
 
 static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 		       fd_set __user *exp, void __user *tsp,
-		       const sigset_t __user *sigmask, size_t sigsetsize,
+		       const void __user *sigmask, size_t sigsetsize,
 		       enum poll_time_type type)
 {
 	struct timespec64 ts, end_time, *to = NULL;
@@ -752,7 +773,10 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 			return -EINVAL;
 	}
 
-	ret = set_user_sigmask(sigmask, sigsetsize);
+	if (!in_compat_syscall())
+		ret = set_user_sigmask(sigmask, sigsetsize);
+	else
+		ret = set_compat_user_sigmask(sigmask, sigsetsize);
 	if (ret)
 		return ret;
 
@@ -829,7 +853,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
-	return kern_select(a.n, a.inp, a.outp, a.exp, a.tvp);
+	return kern_select(a.n, a.inp, a.outp, a.exp, a.tvp, PT_TIMEVAL);
 }
 #endif
 
@@ -1148,146 +1172,14 @@ SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds, unsigned int, nfds,
 #endif
 
 #ifdef CONFIG_COMPAT
-#define __COMPAT_NFDBITS       (8 * sizeof(compat_ulong_t))
-
-/*
- * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
- * 64-bit unsigned longs.
- */
-static
-int compat_get_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
-			unsigned long *fdset)
-{
-	if (ufdset) {
-		return compat_get_bitmap(fdset, ufdset, nr);
-	} else {
-		zero_fd_set(nr, fdset);
-		return 0;
-	}
-}
-
-static
-int compat_set_fd_set(unsigned long nr, compat_ulong_t __user *ufdset,
-		      unsigned long *fdset)
-{
-	if (!ufdset)
-		return 0;
-	return compat_put_bitmap(ufdset, fdset, nr);
-}
-
-
-/*
- * This is a virtual copy of sys_select from fs/select.c and probably
- * should be compared to it from time to time
- */
-
-/*
- * We can actually return ERESTARTSYS instead of EINTR, but I'd
- * like to be certain this leads to no problems. So I return
- * EINTR just for safety.
- *
- * Update: ERESTARTSYS breaks at least the xview clock binary, so
- * I'm trying ERESTARTNOHAND which restart only when you want to.
- */
-static int compat_core_sys_select(int n, compat_ulong_t __user *inp,
-	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	struct timespec64 *end_time)
-{
-	fd_set_bits fds;
-	void *bits;
-	int size, max_fds, ret = -EINVAL;
-	struct fdtable *fdt;
-	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
-
-	if (n < 0)
-		goto out_nofds;
-
-	/* max_fds can increase, so grab it once to avoid race */
-	rcu_read_lock();
-	fdt = files_fdtable(current->files);
-	max_fds = fdt->max_fds;
-	rcu_read_unlock();
-	if (n > max_fds)
-		n = max_fds;
-
-	/*
-	 * We need 6 bitmaps (in/out/ex for both incoming and outgoing),
-	 * since we used fdset we need to allocate memory in units of
-	 * long-words.
-	 */
-	size = FDS_BYTES(n);
-	bits = stack_fds;
-	if (size > sizeof(stack_fds) / 6) {
-		bits = kmalloc_array(6, size, GFP_KERNEL);
-		ret = -ENOMEM;
-		if (!bits)
-			goto out_nofds;
-	}
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
-
-	if ((ret = compat_get_fd_set(n, inp, fds.in)) ||
-	    (ret = compat_get_fd_set(n, outp, fds.out)) ||
-	    (ret = compat_get_fd_set(n, exp, fds.ex)))
-		goto out;
-	zero_fd_set(n, fds.res_in);
-	zero_fd_set(n, fds.res_out);
-	zero_fd_set(n, fds.res_ex);
-
-	ret = do_select(n, &fds, end_time);
-
-	if (ret < 0)
-		goto out;
-	if (!ret) {
-		ret = -ERESTARTNOHAND;
-		if (signal_pending(current))
-			goto out;
-		ret = 0;
-	}
-
-	if (compat_set_fd_set(n, inp, fds.res_in) ||
-	    compat_set_fd_set(n, outp, fds.res_out) ||
-	    compat_set_fd_set(n, exp, fds.res_ex))
-		ret = -EFAULT;
-out:
-	if (bits != stack_fds)
-		kfree(bits);
-out_nofds:
-	return ret;
-}
-
-static int do_compat_select(int n, compat_ulong_t __user *inp,
-	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	struct old_timeval32 __user *tvp)
-{
-	struct timespec64 end_time, *to = NULL;
-	struct old_timeval32 tv;
-	int ret;
-
-	if (tvp) {
-		if (copy_from_user(&tv, tvp, sizeof(tv)))
-			return -EFAULT;
-
-		to = &end_time;
-		if (poll_select_set_timeout(to,
-				tv.tv_sec + (tv.tv_usec / USEC_PER_SEC),
-				(tv.tv_usec % USEC_PER_SEC) * NSEC_PER_USEC))
-			return -EINVAL;
-	}
-
-	ret = compat_core_sys_select(n, inp, outp, exp, to);
-	return poll_select_finish(&end_time, tvp, PT_OLD_TIMEVAL, ret);
-}
 
 COMPAT_SYSCALL_DEFINE5(select, int, n, compat_ulong_t __user *, inp,
 	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
 	struct old_timeval32 __user *, tvp)
 {
-	return do_compat_select(n, inp, outp, exp, tvp);
+	return kern_select(n, (void __user *)inp, (void __user *)outp,
+			   (void __user *)exp, (void __user *)tvp,
+			   PT_OLD_TIMEVAL);
 }
 
 struct compat_sel_arg_struct {
@@ -1304,43 +1196,9 @@ COMPAT_SYSCALL_DEFINE1(old_select, struct compat_sel_arg_struct __user *, arg)
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
-	return do_compat_select(a.n, compat_ptr(a.inp), compat_ptr(a.outp),
-				compat_ptr(a.exp), compat_ptr(a.tvp));
-}
-
-static long do_compat_pselect(int n, compat_ulong_t __user *inp,
-	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	void __user *tsp, compat_sigset_t __user *sigmask,
-	compat_size_t sigsetsize, enum poll_time_type type)
-{
-	struct timespec64 ts, end_time, *to = NULL;
-	int ret;
-
-	if (tsp) {
-		switch (type) {
-		case PT_OLD_TIMESPEC:
-			if (get_old_timespec32(&ts, tsp))
-				return -EFAULT;
-			break;
-		case PT_TIMESPEC:
-			if (get_timespec64(&ts, tsp))
-				return -EFAULT;
-			break;
-		default:
-			BUG();
-		}
-
-		to = &end_time;
-		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
-			return -EINVAL;
-	}
-
-	ret = set_compat_user_sigmask(sigmask, sigsetsize);
-	if (ret)
-		return ret;
-
-	ret = compat_core_sys_select(n, inp, outp, exp, to);
-	return poll_select_finish(&end_time, tsp, type, ret);
+	return kern_select(a.n, compat_ptr(a.inp), compat_ptr(a.outp),
+				compat_ptr(a.exp), compat_ptr(a.tvp),
+				PT_OLD_TIMEVAL);
 }
 
 struct compat_sigset_argpack {
@@ -1372,8 +1230,9 @@ COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
 	if (get_compat_sigset_argpack(&x, sig))
 		return -EFAULT;
 
-	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(x.p),
-				 x.size, PT_TIMESPEC);
+	return do_pselect(n, (void __user *)inp, (void __user *)outp,
+			  (void __user *)exp, (void __user *)tsp,
+			  compat_ptr(x.p), x.size, PT_TIMESPEC);
 }
 
 #if defined(CONFIG_COMPAT_32BIT_TIME)
@@ -1387,8 +1246,9 @@ COMPAT_SYSCALL_DEFINE6(pselect6_time32, int, n, compat_ulong_t __user *, inp,
 	if (get_compat_sigset_argpack(&x, sig))
 		return -EFAULT;
 
-	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(x.p),
-				 x.size, PT_OLD_TIMESPEC);
+	return do_pselect(n, (void __user *)inp, (void __user *)outp,
+			  (void __user *)exp, (void __user *)tsp,
+			  compat_ptr(x.p), x.size, PT_OLD_TIMESPEC);
 }
 
 #endif
-- 
2.30.0.284.gd98b1dd5eaa7-goog

