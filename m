Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DD61E8BE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgE2X10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgE2X1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:27:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA87C03E969;
        Fri, 29 May 2020 16:27:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoPL-000BhX-3Q; Fri, 29 May 2020 23:27:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] pselect6() and friends: take handling the combined 6th/7th args into helper
Date:   Sat, 30 May 2020 00:27:16 +0100
Message-Id: <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and use unsafe_get_user(), while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/select.c | 112 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 11d0285d46b7..7aef49552d4c 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -766,22 +766,38 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
  * which has a pointer to the sigset_t itself followed by a size_t containing
  * the sigset size.
  */
+struct sigset_argpack {
+	sigset_t __user *p;
+	size_t size;
+};
+
+static inline int get_sigset_argpack(struct sigset_argpack *to,
+				     struct sigset_argpack __user *from)
+{
+	// the path is hot enough for overhead of copy_from_user() to matter
+	if (from) {
+		if (!user_read_access_begin(from, sizeof(*from)))
+			return -EFAULT;
+		unsafe_get_user(to->p, &from->p, Efault);
+		unsafe_get_user(to->size, &from->size, Efault);
+		user_read_access_end();
+	}
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
 SYSCALL_DEFINE6(pselect6, int, n, fd_set __user *, inp, fd_set __user *, outp,
 		fd_set __user *, exp, struct __kernel_timespec __user *, tsp,
 		void __user *, sig)
 {
-	size_t sigsetsize = 0;
-	sigset_t __user *up = NULL;
-
-	if (sig) {
-		if (!access_ok(sig, sizeof(void *)+sizeof(size_t))
-		    || __get_user(up, (sigset_t __user * __user *)sig)
-		    || __get_user(sigsetsize,
-				(size_t __user *)(sig+sizeof(void *))))
-			return -EFAULT;
-	}
+	struct sigset_argpack x = {NULL, 0};
+
+	if (get_sigset_argpack(&x, sig))
+		return -EFAULT;
 
-	return do_pselect(n, inp, outp, exp, tsp, up, sigsetsize, PT_TIMESPEC);
+	return do_pselect(n, inp, outp, exp, tsp, x.p, x.size, PT_TIMESPEC);
 }
 
 #if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
@@ -790,18 +806,12 @@ SYSCALL_DEFINE6(pselect6_time32, int, n, fd_set __user *, inp, fd_set __user *,
 		fd_set __user *, exp, struct old_timespec32 __user *, tsp,
 		void __user *, sig)
 {
-	size_t sigsetsize = 0;
-	sigset_t __user *up = NULL;
-
-	if (sig) {
-		if (!access_ok(sig, sizeof(void *)+sizeof(size_t))
-		    || __get_user(up, (sigset_t __user * __user *)sig)
-		    || __get_user(sigsetsize,
-				(size_t __user *)(sig+sizeof(void *))))
-			return -EFAULT;
-	}
+	struct sigset_argpack x = {NULL, 0};
+
+	if (get_sigset_argpack(&x, sig))
+		return -EFAULT;
 
-	return do_pselect(n, inp, outp, exp, tsp, up, sigsetsize, PT_OLD_TIMESPEC);
+	return do_pselect(n, inp, outp, exp, tsp, x.p, x.size, PT_OLD_TIMESPEC);
 }
 
 #endif
@@ -1325,24 +1335,37 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	return poll_select_finish(&end_time, tsp, type, ret);
 }
 
+struct compat_sigset_argpack {
+	compat_uptr_t p;
+	compat_size_t size;
+};
+static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
+					    struct compat_sigset_argpack __user *from)
+{
+	if (from) {
+		if (!user_read_access_begin(from, sizeof(*from)))
+			return -EFAULT;
+		unsafe_get_user(to->p, &from->p, Efault);
+		unsafe_get_user(to->size, &from->size, Efault);
+		user_read_access_end();
+	}
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
 COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
 	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
 	struct __kernel_timespec __user *, tsp, void __user *, sig)
 {
-	compat_size_t sigsetsize = 0;
-	compat_uptr_t up = 0;
-
-	if (sig) {
-		if (!access_ok(sig,
-				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
-				__get_user(up, (compat_uptr_t __user *)sig) ||
-				__get_user(sigsetsize,
-				(compat_size_t __user *)(sig+sizeof(up))))
-			return -EFAULT;
-	}
+	struct compat_sigset_argpack x = {0, 0};
+
+	if (get_compat_sigset_argpack(&x, sig))
+		return -EFAULT;
 
-	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(up),
-				 sigsetsize, PT_TIMESPEC);
+	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(x.p),
+				 x.size, PT_TIMESPEC);
 }
 
 #if defined(CONFIG_COMPAT_32BIT_TIME)
@@ -1351,20 +1374,13 @@ COMPAT_SYSCALL_DEFINE6(pselect6_time32, int, n, compat_ulong_t __user *, inp,
 	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
 	struct old_timespec32 __user *, tsp, void __user *, sig)
 {
-	compat_size_t sigsetsize = 0;
-	compat_uptr_t up = 0;
-
-	if (sig) {
-		if (!access_ok(sig,
-				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
-		    	__get_user(up, (compat_uptr_t __user *)sig) ||
-		    	__get_user(sigsetsize,
-				(compat_size_t __user *)(sig+sizeof(up))))
-			return -EFAULT;
-	}
+	struct compat_sigset_argpack x = {0, 0};
+
+	if (get_compat_sigset_argpack(&x, sig))
+		return -EFAULT;
 
-	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(up),
-				 sigsetsize, PT_OLD_TIMESPEC);
+	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(x.p),
+				 x.size, PT_OLD_TIMESPEC);
 }
 
 #endif
-- 
2.11.0

