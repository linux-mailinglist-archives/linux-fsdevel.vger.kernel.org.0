Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5581E7377
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391647AbgE2DKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389625AbgE2DKj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 23:10:39 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1334FC08C5C6;
        Thu, 28 May 2020 20:10:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeVPo-00HJwb-1G; Fri, 29 May 2020 03:10:36 +0000
Date:   Fri, 29 May 2020 04:10:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
Message-ID: <20200529031036.GB23230@ZenIV.linux.org.uk>
References: <20200529000345.GV23230@ZenIV.linux.org.uk>
 <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
 <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk>
 <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 06:54:11PM -0700, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 6:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         case S_IFREG:
> >                 inode->i_op = &dlmfs_file_inode_operations;
> >                 inode->i_fop = &dlmfs_file_operations;
> >
> >                 i_size_write(inode,  DLM_LVB_LEN);
> > is the only thing that does anything to size of that sucker.  IOW, that
> > i_size_read() might as well had been an explicit 64.
> 
> Heh. Indeed. I did actually grep for i_size_write() use in ocfs2 and
> saw several. But I didn't realize to limit it to just the dlmfs part.
> 
> So it does that crazy sequence number lock dance on 32-bit just to
> read a constant value.
> 
> Oh well.
> 
> It would be nice to get those follow-up cleanups eventually, but I
> guess the general user access cleanups are more important than this
> very odd special case silliness.

Not a problem - I'll put it into work.misc for the next cycle...
BTW, regarding uaccess - how badly does the following offend your taste?
Normally I'd just go for copy_from_user(), but these syscalls just might
be hot enough for overhead to matter...

commit 40f443f132306d724f43eaff5330b31c632455a6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed Feb 19 09:54:24 2020 -0500

    pselect6() and friends: take handling the combined 6th/7th args into helper
    
    ... and use unsafe_get_user(), while we are at it.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/select.c b/fs/select.c
index 11d0285d46b7..ff0489c67e3f 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -766,6 +766,24 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
  * which has a pointer to the sigset_t itself followed by a size_t containing
  * the sigset size.
  */
+static inline int unkludge_sigmask(void __user *sig,
+				   sigset_t __user **up,
+				   size_t *sigsetsize)
+{
+	if (sig) {
+		if (!user_read_access_begin(sig, sizeof(void *)+sizeof(size_t)))
+			return -EFAULT;
+		unsafe_get_user(*up, (sigset_t __user * __user *)sig, Efault);
+		unsafe_get_user(*sigsetsize,
+				(size_t __user *)(sig+sizeof(void *)), Efault);
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
@@ -773,13 +791,8 @@ SYSCALL_DEFINE6(pselect6, int, n, fd_set __user *, inp, fd_set __user *, outp,
 	size_t sigsetsize = 0;
 	sigset_t __user *up = NULL;
 
-	if (sig) {
-		if (!access_ok(sig, sizeof(void *)+sizeof(size_t))
-		    || __get_user(up, (sigset_t __user * __user *)sig)
-		    || __get_user(sigsetsize,
-				(size_t __user *)(sig+sizeof(void *))))
-			return -EFAULT;
-	}
+	if (unkludge_sigmask(sig, &up, &sigsetsize))
+		return -EFAULT;
 
 	return do_pselect(n, inp, outp, exp, tsp, up, sigsetsize, PT_TIMESPEC);
 }
@@ -793,13 +806,8 @@ SYSCALL_DEFINE6(pselect6_time32, int, n, fd_set __user *, inp, fd_set __user *,
 	size_t sigsetsize = 0;
 	sigset_t __user *up = NULL;
 
-	if (sig) {
-		if (!access_ok(sig, sizeof(void *)+sizeof(size_t))
-		    || __get_user(up, (sigset_t __user * __user *)sig)
-		    || __get_user(sigsetsize,
-				(size_t __user *)(sig+sizeof(void *))))
-			return -EFAULT;
-	}
+	if (unkludge_sigmask(sig, &up, &sigsetsize))
+		return -EFAULT;
 
 	return do_pselect(n, inp, outp, exp, tsp, up, sigsetsize, PT_OLD_TIMESPEC);
 }
@@ -1325,6 +1333,25 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	return poll_select_finish(&end_time, tsp, type, ret);
 }
 
+static inline int unkludge_compat_sigmask(void __user *sig,
+				   compat_uptr_t *up,
+				   compat_size_t *sigsetsize)
+{
+	if (sig) {
+		if (!user_read_access_begin(sig,
+				sizeof(compat_uptr_t)+sizeof(compat_size_t)))
+			return -EFAULT;
+		unsafe_get_user(*up, (compat_uptr_t __user *)sig, Efault);
+		unsafe_get_user(*sigsetsize,
+				(compat_size_t __user *)(sig+sizeof(up)), Efault);
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
@@ -1332,14 +1359,8 @@ COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
 	compat_size_t sigsetsize = 0;
 	compat_uptr_t up = 0;
 
-	if (sig) {
-		if (!access_ok(sig,
-				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
-				__get_user(up, (compat_uptr_t __user *)sig) ||
-				__get_user(sigsetsize,
-				(compat_size_t __user *)(sig+sizeof(up))))
-			return -EFAULT;
-	}
+	if (unkludge_compat_sigmask(sig, &up, &sigsetsize))
+		return -EFAULT;
 
 	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(up),
 				 sigsetsize, PT_TIMESPEC);
@@ -1354,14 +1375,8 @@ COMPAT_SYSCALL_DEFINE6(pselect6_time32, int, n, compat_ulong_t __user *, inp,
 	compat_size_t sigsetsize = 0;
 	compat_uptr_t up = 0;
 
-	if (sig) {
-		if (!access_ok(sig,
-				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
-		    	__get_user(up, (compat_uptr_t __user *)sig) ||
-		    	__get_user(sigsetsize,
-				(compat_size_t __user *)(sig+sizeof(up))))
-			return -EFAULT;
-	}
+	if (unkludge_compat_sigmask(sig, &up, &sigsetsize))
+		return -EFAULT;
 
 	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(up),
 				 sigsetsize, PT_OLD_TIMESPEC);
