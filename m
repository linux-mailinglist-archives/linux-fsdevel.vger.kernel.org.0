Return-Path: <linux-fsdevel+bounces-59629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E92B3B7A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BAF1C807DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F533054DB;
	Fri, 29 Aug 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhvqwzBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A533985;
	Fri, 29 Aug 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460883; cv=none; b=WQDEdeVjS0bLsirFq+iekU0/twka6S5/Wba6kgkb2KaA8FwjfoPMTsGCQAWmiIjLxPPDQkWjLFD4BvQTLwvqoU870eiXAR5zGX1AZKvVYtqgs9dfKREkYorEsk5BOdJx76ajqyUMr3wd65R7/VMNrN6vEOv8tF96DoK6nrCtXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460883; c=relaxed/simple;
	bh=c/nLtzvIjWghajbObEXEYoMuDbVvHsLyXpDONNIuyys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbzL6Y4ywNOOtP8WdHoYauYdb5CIWGtW6X3GbG6SOi7id1waEXrjrKhmvOkN9hPNNDvXpFDzbC93LSbJQW6KVsuYGk0E5gqjB2EaT6xpfH7WSF6It8xCjmwDae8tT9MjEz91uUsfOeFOEjELAvC5/kchr65eiRGT+q4RJOgnKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhvqwzBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC19C4CEF6;
	Fri, 29 Aug 2025 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756460882;
	bh=c/nLtzvIjWghajbObEXEYoMuDbVvHsLyXpDONNIuyys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhvqwzBlD0vhRISffYFW/jHR6T+9q4xzM0ncFhAeZSgivmCzIWl8eS0asllwkDcp8
	 nXg7SEzPFXijk0YQ47hMH+8YVQcK0t8VpJFp3/c4vKjxb5hc2dXs2PPEVUdmg35XBi
	 Dg1PoySLqIlm9yJNb+M5nf/5EYj4RK6aS0hCQNUm8f6z9Ht4usjMbRkAEfylu0AG8d
	 Ftf4oN5S8QxZyNdsoxUcVB1xF9LLciOznTYbIvRQFoasDVLqrQtHRmMgiXBSmVhVo2
	 uqNr8/YC1FN2SIrWCqeLd3HVqeYo6/nst0ufX1Bec7iuJQ1OSbg0WNMoC5f+WtgJ/P
	 3QGeE08GKsu+g==
Date: Fri, 29 Aug 2025 11:47:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <20250829-diskette-landbrot-aa01bc844435@brauner>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a4513fe-6eae-9269-c235-c8b0bc1ae05b@ispras.ru>

On Fri, Aug 29, 2025 at 10:21:35AM +0300, Alexander Monakov wrote:
> 
> On Wed, 27 Aug 2025, Alexander Monakov wrote:
> 
> > Dear fs hackers,
> > 
> > I suspect there's an unfortunate race window in __fput where file locks are
> > dropped (locks_remove_file) prior to decreasing writer refcount
> > (put_file_access). If I'm not mistaken, this window is observable and it
> > breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> > in more detail below.
> 
> The race in __fput is a problem irrespective of how the testcase triggers it,
> right? It's just showing a real-world scenario. But the issue can be
> demonstrated without a multithreaded fork: imagine one process placing an
> exclusive lock on a file and writing to it, another process waiting on that
> lock and immediately execve'ing when the lock is released.
> 
> Can put_file_access be moved prior to locks_remove_file in __fput?

Even if we fix this there's no guarantee that the kernel will give that
letting the close() of a writably opened file race against a concurrent
exec of the same file will not result in EBUSY in some arcane way
currently or in the future.

The fundamental problem is the idiotic exe_file_deny_write_access()
mechanism for execve. This is the crux of the whole go issue. I've tried
to removethis nonsense (twice?). Everytime because of some odd userspace
regression we had to revert (And now we're apparently at the stage where
in another patchset people think that this stuff needs to become a uapi
O_* flag which will absolutely not happen.).

My point is: currently you need synchronization for this to work cleanly
in some form.

But what I would do is the following. So far we've always failed to
remove the deny on write mechanism because doing it unconditionally
broke very weird use-cases with very strange justificatons.

I think we should turn this on its head and give execveat() a flag
AT_EXECVE_NODENYWRITE that allows applications to ignore the write
restrictions.

Applications like go can just start using this flag when exec'ing.
Applications that need the annoying deny-write mechanism can just
continue exec'ing as before without AT_EXECVE_NODENYWRITE.

__Completely untested and uncompiled__ draft below:

diff --git a/fs/exec.c b/fs/exec.c
index 2a1e5e4042a1..59e8fcd3fc19 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -766,7 +766,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
        int err;
        struct file *file __free(fput) = NULL;
        struct open_flags open_exec_flags = {
-               .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
+               .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC | __F_EXEC_NODENYWRITE,
                .acc_mode = MAY_EXEC,
                .intent = LOOKUP_OPEN,
                .lookup_flags = LOOKUP_FOLLOW,
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5598e4d57422..b0c01cba1560 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1158,10 +1158,10 @@ static int __init fcntl_init(void)
         * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
         * is defined as O_NONBLOCK on some platforms and not on others.
         */
-       BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
+       BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
                HWEIGHT32(
                        (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
-                       __FMODE_EXEC));
+                       __FMODE_EXEC | __F_EXEC_NODENYWRITE));

        fasync_cache = kmem_cache_create("fasync_cache",
                                         sizeof(struct fasync_struct), 0,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..123f74cbe7a4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3215,12 +3215,16 @@ static inline int exe_file_deny_write_access(struct file *exe_file)
 {
        if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
                return 0;
+       if (unlikely(exe_file->f_flags & __F_EXEC_NODENYWRITE))
+               return 0;
        return deny_write_access(exe_file);
 }
 static inline void exe_file_allow_write_access(struct file *exe_file)
 {
        if (unlikely(!exe_file || FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
                return;
+       if (unlikely(exe_file->f_flags & __F_EXEC_NODENYWRITE))
+               return;
        allow_write_access(exe_file);
 }

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..f3c8a457bc7d 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -61,6 +61,9 @@
 #ifndef O_CLOEXEC
 #define O_CLOEXEC      02000000        /* set close_on_exec */
 #endif
+#ifdef __KERNEL__
+#define __F_EXEC_NODENYWRITE 020000000000 /* bit 31 */
+#endif

 /*
  * Before Linux 2.6.33 only O_DSYNC semantics were implemented, but using
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index f291ab4f94eb..123fb158dc5b 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -174,6 +174,7 @@
 #define AT_HANDLE_CONNECTABLE  0x002   /* Request a connectable file handle */

 /* Flags for execveat2(2). */
+#define AT_EXECVE_NODENYWRITE  0x001   /* Allow writable file descriptors to the executable file. */
 #define AT_EXECVE_CHECK                0x10000 /* Only perform a check if execution
                                           would be allowed. */

