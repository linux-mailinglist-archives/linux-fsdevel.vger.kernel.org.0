Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0156D34D61D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 19:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC2RgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 13:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhC2Rf7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:35:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5411961985;
        Mon, 29 Mar 2021 17:35:57 +0000 (UTC)
Date:   Mon, 29 Mar 2021 19:35:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
Message-ID: <20210329173554.tw7mbvuvq6f5eo76@wittgenstein>
References: <00000000000069c40405be6bdad4@google.com>
 <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
 <20210326091207.5si6knxs7tn6rmod@wittgenstein>
 <CACT4Y+atQdf_fe3BPFRGVCzT1Ba3V_XjAo6XsRciL8nwt4wasw@mail.gmail.com>
 <CAHrFyr7iUpMh4sicxrMWwaUHKteU=qHt-1O-3hojAAX3d5879Q@mail.gmail.com>
 <20210326135011.wscs4pxal7vvsmmw@wittgenstein>
 <YF/A0eZdQwi0/PJU@zeniv-ca.linux.org.uk>
 <20210329092129.g425sscvyfagig7f@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210329092129.g425sscvyfagig7f@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:21:34AM +0200, Christian Brauner wrote:
> On Sat, Mar 27, 2021 at 11:33:37PM +0000, Al Viro wrote:
> > On Fri, Mar 26, 2021 at 02:50:11PM +0100, Christian Brauner wrote:
> > > @@ -632,6 +632,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
> > >  static inline void __range_cloexec(struct files_struct *cur_fds,
> > >  				   unsigned int fd, unsigned int max_fd)
> > >  {
> > > +	unsigned int cur_max;
> > >  	struct fdtable *fdt;
> > >  
> > >  	if (fd > max_fd)
> > > @@ -639,7 +640,12 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
> > >  
> > >  	spin_lock(&cur_fds->file_lock);
> > >  	fdt = files_fdtable(cur_fds);
> > > -	bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
> > > +	/* make very sure we're using the correct maximum value */
> > > +	cur_max = fdt->max_fds;
> > > +	cur_max--;
> > > +	cur_max = min(max_fd, cur_max);
> > > +	if (fd <= cur_max)
> > > +		bitmap_set(fdt->close_on_exec, fd, cur_max - fd + 1);
> > >  	spin_unlock(&cur_fds->file_lock);
> > >  }
> > 
> > Umm...  That's harder to follow than it ought to be.  What's the point of
> > having
> >         max_fd = min(max_fd, cur_max);
> > done in the caller, anyway?  Note that in __range_close() you have to
> > compare with re-fetched ->max_fds (look at pick_file()), so...
> 
> Yeah, I'll massage that patch a bit. I wanted to know whether this fixes
> the issue first though.
> 
> > 
> > BTW, I really wonder if the cost of jerking ->file_lock up and down
> > in that loop in __range_close() is negligible.  What values do we
> 
> Just for the record, I remember you pointing at that originally. Linus
> argued that this likely wasn't going to be a problem and that if people
> see performance hits we'll optimize.
> 
> > typically get from callers and how sparse does descriptor table tend
> > to be for those?
> 
> Weirdly, I can actually somewhat answer that question since I tend to
> regularly "survey" large userspace projects I know or am involved in
> that adopt new APIs we added just to see how they use it.
> 
> A few users:
> 1. crun
>    https://github.com/containers/crun/blob/a1c0ef1b886ca30c2fb0906c7c43be04b555c52c/src/libcrun/utils.c#L1490
>    ret = syscall_close_range (n, UINT_MAX, CLOSE_RANGE_CLOEXEC);
> 
> 2. LXD
>    https://github.com/lxc/lxd/blob/f12f03a4ba4645892ef6cc167c24da49d1217b02/lxd/main_forkexec.go#L293
>    ret = close_range(EXEC_PIPE_FD + 1, UINT_MAX, CLOSE_RANGE_UNSHARE);
> 
> 3. LXC
>    https://github.com/lxc/lxc/blob/1718e6d6018d5d6072a01d92a11d5aafc314f98f/src/lxc/rexec.c#L165
>    ret = close_range(STDERR_FILENO + 1, MAX_FILENO, CLOSE_RANGE_CLOEXEC);
> 
> Of these three 1. and 3. don't matter because they rely on
> CLOSE_RANGE_CLOEXEC and exec.
> For 2. I can say that the fdtable is likely going to be sparse.
> close_range() here is basically used to prevent accidental fd leaks
> across an exec. So 2. should never have more > 4 file. In fact, this
> could and should probably be switched to CLOSE_RANGE_CLOEXEC too.
> 
> The next two cases might be more interesting:
> 
> 4. systemd
>    - https://github.com/systemd/systemd/blob/fe96c0f86d15e844d74d539c6cff7f971078cf84/src/basic/fd-util.c#L228
>      close_range(3, -1, 0)
>    - https://github.com/systemd/systemd/blob/fe96c0f86d15e844d74d539c6cff7f971078cf84/src/basic/fd-util.c#L271
>      https://github.com/systemd/systemd/blob/fe96c0f86d15e844d74d539c6cff7f971078cf84/src/basic/fd-util.c#L288
>      /* Close everything between the start and end fds (both of which shall stay open) */
>      if (close_range(start + 1, end - 1, 0) < 0) {
>      if (close_range(sorted[n_sorted-1] + 1, -1, 0) >= 0)
> 
> 5. Python
>    https://github.com/python/cpython/blob/9976834f807ea63ca51bc4f89be457d734148682/Python/fileutils.c#L2250
> 
> systemd has the regular case that others have too where it simply closes
> all fds over 3 and it also has the more complicated case where it has an
> ordered array of fds closing up to the lower bound and after the upper
> bound up to the maximum. PID 1 can have a large number of fds open
> because of socket activation so here close_range() will encounter less
> sparse fd tables where it needs to close a lot of fds.
> 
> For Python's os.closerange() implementation which depends on our syscall
> it's harder to say given that this will be used by a lot of projects but
> I would _guess_ that if people use closerange() they do so because they
> actually have something to close.
> 
> In short, I would think that close_range() without the
> CLOSE_RANGE_CLOEXEC feature will usually be used in scenarios where
> there's work to be done, i.e. where the caller likely knows that they
> might inherit a non-trivial number of file descriptors (usually after a
> fork) that they want to close and they want to do it either because they
> don't exec or they don't know when they'll exec. All others I'd expect
> to switch to CLOSE_RANGE_CLOEXEC on kernels where it's supported.

The patch below is a bit noiser then I'd like but it rips out the double
logic where we check min() twice and should also tweak the worst-case
where we keep taking the spinlock for a few fds that are already past
fdt->max_fds.
Afaict, this should be a very rare (pathological?) case. Even before
this change the logic would've capped max_fds to fdt->max_fds but
wouldn't have bothered to recheck within the pick_file() loop.
I've tweaked it to do that and then to return as soon as we see that
we're past the last fd. If you think that's worth then I'm happy to
write a commit message. I'm not sure if it's worth doing something more
fancy than this tbh but curious to hear what you think (Only compile
tested for now.):

---
 fs/file.c | 72 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index f3a4bac2cbe9..5027cd75ec59 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -596,18 +596,32 @@ void fd_install(unsigned int fd, struct file *file)
 
 EXPORT_SYMBOL(fd_install);
 
+/**
+ * pick_file - return file associatd with fd
+ * @files: file struct to retrieve file from
+ * @fd: file descriptor to retrieve file for
+ *
+ * If this functions returns an EINVAL error pointer the fd was beyond the
+ * current maximum number of file descriptors for that fdtable.
+ *
+ * Returns: The file associated with @fd, on error returns an error pointer.
+ */
 static struct file *pick_file(struct files_struct *files, unsigned fd)
 {
-	struct file *file = NULL;
+	struct file *file;
 	struct fdtable *fdt;
 
 	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
-	if (fd >= fdt->max_fds)
+	if (fd >= fdt->max_fds) {
+		file = ERR_PTR(-EINVAL);
 		goto out_unlock;
+	}
 	file = fdt->fd[fd];
-	if (!file)
+	if (!file) {
+		file = ERR_PTR(-EBADF);
 		goto out_unlock;
+	}
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	__put_unused_fd(files, fd);
 
@@ -622,24 +636,37 @@ int close_fd(unsigned fd)
 	struct file *file;
 
 	file = pick_file(files, fd);
-	if (!file)
+	if (IS_ERR(file))
 		return -EBADF;
 
 	return filp_close(file, files);
 }
 EXPORT_SYMBOL(close_fd); /* for ksys_close() */
 
+/**
+ * last_fd - return last valid index into fd table
+ * @cur_fds: files struct
+ *
+ * Context: Either rcu read lock or files_lock must be held.
+ *
+ * Returns: Last valid index into fdtable.
+ */
+static inline unsigned last_fd(struct fdtable *fdt)
+{
+	return fdt->max_fds - 1;
+}
+
 static inline void __range_cloexec(struct files_struct *cur_fds,
 				   unsigned int fd, unsigned int max_fd)
 {
 	struct fdtable *fdt;
 
-	if (fd > max_fd)
-		return;
-
+	/* make sure we're using the correct maximum value */
 	spin_lock(&cur_fds->file_lock);
 	fdt = files_fdtable(cur_fds);
-	bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
+	max_fd = min(last_fd(fdt), max_fd);
+	if (fd <= max_fd)
+		bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
 	spin_unlock(&cur_fds->file_lock);
 }
 
@@ -650,11 +677,16 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
 		struct file *file;
 
 		file = pick_file(cur_fds, fd++);
-		if (!file)
+		if (!IS_ERR(file)) {
+			/* found a valid file to close */
+			filp_close(file, cur_fds);
+			cond_resched();
 			continue;
+		}
 
-		filp_close(file, cur_fds);
-		cond_resched();
+		/* beyond the last fd in that table */
+		if (PTR_ERR(file) == -EINVAL)
+			return;
 	}
 }
 
@@ -669,7 +701,6 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
  */
 int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 {
-	unsigned int cur_max;
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
 
@@ -679,13 +710,6 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	if (fd > max_fd)
 		return -EINVAL;
 
-	rcu_read_lock();
-	cur_max = files_fdtable(cur_fds)->max_fds;
-	rcu_read_unlock();
-
-	/* cap to last valid index into fdtable */
-	cur_max--;
-
 	if (flags & CLOSE_RANGE_UNSHARE) {
 		int ret;
 		unsigned int max_unshare_fds = NR_OPEN_MAX;
@@ -697,8 +721,12 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 		 * If the caller requested all fds to be made cloexec copy all
 		 * of the file descriptors since they still want to use them.
 		 */
-		if (!(flags & CLOSE_RANGE_CLOEXEC) && (max_fd >= cur_max))
-			max_unshare_fds = fd;
+		if (!(flags & CLOSE_RANGE_CLOEXEC)) {
+			rcu_read_lock();
+			if (max_fd >= last_fd(files_fdtable(cur_fds)))
+				max_unshare_fds = fd;
+			rcu_read_unlock();
+		}
 
 		ret = unshare_fd(CLONE_FILES, max_unshare_fds, &fds);
 		if (ret)
@@ -712,8 +740,6 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 			swap(cur_fds, fds);
 	}
 
-	max_fd = min(max_fd, cur_max);
-
 	if (flags & CLOSE_RANGE_CLOEXEC)
 		__range_cloexec(cur_fds, fd, max_fd);
 	else
-- 
2.27.0

