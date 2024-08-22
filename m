Return-Path: <linux-fsdevel+bounces-26581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0EB95A8B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE587281F03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F7479F2;
	Thu, 22 Aug 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="O1A8Xhco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504C1D12FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286174; cv=none; b=Uc5Tzqx3QtH1EM8uef6RCzWZ7KrHOgkO8v4z+zFXPE/pvjT0Bi7A6+pDGqk4VITHgiGMe+cvC6H47uptk1ioP0N+MUc1mY2nrtlbudInVSx5LQ+PGXKV9srIlqUOtDPIIcu0wm+TevJXuACZlA3iM188sLzpIwsP93rypLwiEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286174; c=relaxed/simple;
	bh=ZieAIbjvYC0FIn+amotA5ukdDh0M3bKfMB+V9gGwAaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipKdRpv4sDOcnp5uYb9CIkMhdd8F7upYU40JyVeNnDcEqKHLmgnyXL/MMuFXR7nMZs1pwnJI7SHPelxsrqLqifXrA/KpNwWS7cjq20JOZ73NDD1zMvq3Q0HiEC70+6dLr2gViNWEL7SzTcbLVZw+tuqALyHM8/wRX1mPAXeQ0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=O1A8Xhco; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ziR8a8UdFQ5jxd9C2HBxYFLV/chzydtuqy+4doFrU+M=; b=O1A8XhcoHjIt+AR1+QfDITfenl
	UnVziHm/+eOiFGXIM9d9Pp575eRmdkkYJYVQ4JQHKexLDT+qX5h0h0ytCgUqxTcvwmg9rcNPyecdx
	PumkRznjToaHOSq5kiy0iztdhCNz1jHNhkvTTSE5nEMqq+ELt0bWzhzN3Dg2tXsAZKGJk1wkUWqc8
	Ljgx+i4SOE79+Q6bdoGe4p8eETSjZSTLY5JoQ07dY/9pGpWqVZr5dR4aMNBvhy7aYVWZmfmeBKLrA
	raJZ6Px+KgJ4cLM7uVMPtZ5vN0bHpEpcPF3AqcAOlnIa3KUQpwf9HeK/RfXrdKvSJGZ+D7TAI5UzS
	683ghSdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbG-00000003w7X-1blU;
	Thu, 22 Aug 2024 00:22:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 01/12] close_range(): fix the logics in descriptor table trimming
Date: Thu, 22 Aug 2024 01:22:39 +0100
Message-ID: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002012.GM504335@ZenIV>
References: <20240822002012.GM504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Cloning a descriptor table picks the size that would cover all currently
opened files.  That's fine for clone() and unshare(), but for close_range()
there's an additional twist - we clone before we close, and it would be
a shame to have
	close_range(3, ~0U, CLOSE_RANGE_UNSHARE)
leave us with a huge descriptor table when we are not going to keep
anything past stderr, just because some large file descriptor used to
be open before our call has taken it out.

Unfortunately, it had been dealt with in an inherently racy way -
sane_fdtable_size() gets a "don't copy anything past that" argument
(passed via unshare_fd() and dup_fd()), close_range() decides how much
should be trimmed and passes that to unshare_fd().

The problem is, a range that used to extend to the end of descriptor
table back when close_range() had looked at it might very well have stuff
grown after it by the time dup_fd() has allocated a new files_struct
and started to figure out the capacity of fdtable to be attached to that.

That leads to interesting pathological cases; at the very least it's a
QoI issue, since unshare(CLONE_FILES) is atomic in a sense that it takes
a snapshot of descriptor table one might have observed at some point.
Since CLOSE_RANGE_UNSHARE close_range() is supposed to be a combination
of unshare(CLONE_FILES) with plain close_range(), ending up with a
weird state that would never occur with unshare(2) is confusing, to put
it mildly.

It's not hard to get rid of - all it takes is passing both ends of the
range down to sane_fdtable_size().  There we are under ->files_lock,
so the race is trivially avoided.

So we do the following:
	* switch close_files() from calling unshare_fd() to calling
dup_fd().
	* undo the calling convention change done to unshare_fd() in
60997c3d45d9 "close_range: add CLOSE_RANGE_UNSHARE"
	* introduce struct fd_range, pass a pointer to that to dup_fd()
and sane_fdtable_size() instead of "trim everything past that point"
they are currently getting.  NULL means "we are not going to be punching
any holes"; NR_OPEN_MAX is gone.
	* make sane_fdtable_size() use find_last_bit() instead of
open-coding it; it's easier to follow that way.
	* while we are at it, have dup_fd() report errors by returning
ERR_PTR(), no need to use a separate int *errorp argument.

Fixes: 60997c3d45d9 "close_range: add CLOSE_RANGE_UNSHARE"
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c               | 95 +++++++++++++++--------------------------
 include/linux/fdtable.h |  8 ++--
 kernel/fork.c           | 32 ++++++--------
 3 files changed, 52 insertions(+), 83 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 655338effe9c..c2403cde40e4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -272,59 +272,45 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->open_fds);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
-{
-	unsigned int size = fdt->max_fds;
-	unsigned int i;
-
-	/* Find the last open fd */
-	for (i = size / BITS_PER_LONG; i > 0; ) {
-		if (fdt->open_fds[--i])
-			break;
-	}
-	i = (i + 1) * BITS_PER_LONG;
-	return i;
-}
-
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
  *
- * 'max_fds' will normally already be properly aligned, but it
- * turns out that in the close_range() -> __close_range() ->
- * unshare_fd() -> dup_fd() -> sane_fdtable_size() we can end
- * up having a 'max_fds' value that isn't already aligned.
- *
- * Rather than make close_range() have to worry about this,
- * just make that BITS_PER_LONG alignment be part of a sane
- * fdtable size. Becuase that's really what it is.
+ * punch_hole is optional - when close_range() is asked to unshare
+ * and close, we don't need to copy descriptors in that range, so
+ * a smaller cloned descriptor table might suffice if the last
+ * currently opened descriptor falls into that range.
  */
-static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
+static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punch_hole)
 {
-	unsigned int count;
-
-	count = count_open_files(fdt);
-	if (max_fds < NR_OPEN_DEFAULT)
-		max_fds = NR_OPEN_DEFAULT;
-	return ALIGN(min(count, max_fds), BITS_PER_LONG);
+	unsigned int last = find_last_bit(fdt->open_fds, fdt->max_fds);
+
+	if (last == fdt->max_fds)
+		return NR_OPEN_DEFAULT;
+	if (punch_hole && punch_hole->to >= last && punch_hole->from <= last) {
+		last = find_last_bit(fdt->open_fds, punch_hole->from);
+		if (last == punch_hole->from)
+			return NR_OPEN_DEFAULT;
+	}
+	return ALIGN(last + 1, BITS_PER_LONG);
 }
 
 /*
- * Allocate a new files structure and copy contents from the
- * passed in files structure.
- * errorp will be valid only when the returned files_struct is NULL.
+ * Allocate a new descriptor table and copy contents from the passed in
+ * instance.  Returns a pointer to cloned table on success, ERR_PTR()
+ * on failure.  For 'punch_hole' see sane_fdtable_size().
  */
-struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int *errorp)
+struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_hole)
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
+	int error;
 
-	*errorp = -ENOMEM;
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	atomic_set(&newf->count, 1);
 
@@ -341,7 +327,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = sane_fdtable_size(old_fdt, max_fds);
+	open_files = sane_fdtable_size(old_fdt, punch_hole);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -354,14 +340,14 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 		new_fdt = alloc_fdtable(open_files - 1);
 		if (!new_fdt) {
-			*errorp = -ENOMEM;
+			error = -ENOMEM;
 			goto out_release;
 		}
 
 		/* beyond sysctl_nr_open; nothing to do */
 		if (unlikely(new_fdt->max_fds < open_files)) {
 			__free_fdtable(new_fdt);
-			*errorp = -EMFILE;
+			error = -EMFILE;
 			goto out_release;
 		}
 
@@ -372,7 +358,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = sane_fdtable_size(old_fdt, max_fds);
+		open_files = sane_fdtable_size(old_fdt, punch_hole);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
@@ -406,8 +392,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 out_release:
 	kmem_cache_free(files_cachep, newf);
-out:
-	return NULL;
+	return ERR_PTR(error);
 }
 
 static struct fdtable *close_files(struct files_struct * files)
@@ -748,37 +733,25 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	if (fd > max_fd)
 		return -EINVAL;
 
-	if (flags & CLOSE_RANGE_UNSHARE) {
-		int ret;
-		unsigned int max_unshare_fds = NR_OPEN_MAX;
+	if ((flags & CLOSE_RANGE_UNSHARE) && atomic_read(&cur_fds->count) > 1) {
+		struct fd_range range = {fd, max_fd}, *punch_hole = &range;
 
 		/*
 		 * If the caller requested all fds to be made cloexec we always
 		 * copy all of the file descriptors since they still want to
 		 * use them.
 		 */
-		if (!(flags & CLOSE_RANGE_CLOEXEC)) {
-			/*
-			 * If the requested range is greater than the current
-			 * maximum, we're closing everything so only copy all
-			 * file descriptors beneath the lowest file descriptor.
-			 */
-			rcu_read_lock();
-			if (max_fd >= last_fd(files_fdtable(cur_fds)))
-				max_unshare_fds = fd;
-			rcu_read_unlock();
-		}
-
-		ret = unshare_fd(CLONE_FILES, max_unshare_fds, &fds);
-		if (ret)
-			return ret;
+		if (flags & CLOSE_RANGE_CLOEXEC)
+			punch_hole = NULL;
 
+		fds = dup_fd(cur_fds, punch_hole);
+		if (IS_ERR(fds))
+			return PTR_ERR(fds);
 		/*
 		 * We used to share our file descriptor table, and have now
 		 * created a private one, make sure we're using it below.
 		 */
-		if (fds)
-			swap(cur_fds, fds);
+		swap(cur_fds, fds);
 	}
 
 	if (flags & CLOSE_RANGE_CLOEXEC)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 2944d4aa413b..b1c5722f2b3c 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -22,7 +22,6 @@
  * as this is the granularity returned by copy_fdset().
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
-#define NR_OPEN_MAX ~0U
 
 struct fdtable {
 	unsigned int max_fds;
@@ -106,7 +105,10 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
-struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
+struct fd_range {
+	unsigned int from, to;
+};
+struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
@@ -115,8 +117,6 @@ int iterate_fd(struct files_struct *, unsigned,
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *file_close_fd(unsigned int fd);
-extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-		      struct files_struct **new_fdp);
 
 extern struct kmem_cache *files_cachep;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..6b97fb2ac4af 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1754,33 +1754,30 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 		      int no_files)
 {
 	struct files_struct *oldf, *newf;
-	int error = 0;
 
 	/*
 	 * A background process may not have any files ...
 	 */
 	oldf = current->files;
 	if (!oldf)
-		goto out;
+		return 0;
 
 	if (no_files) {
 		tsk->files = NULL;
-		goto out;
+		return 0;
 	}
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
-		goto out;
+		return 0;
 	}
 
-	newf = dup_fd(oldf, NR_OPEN_MAX, &error);
-	if (!newf)
-		goto out;
+	newf = dup_fd(oldf, NULL);
+	if (IS_ERR(newf))
+		return PTR_ERR(newf);
 
 	tsk->files = newf;
-	error = 0;
-out:
-	return error;
+	return 0;
 }
 
 static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
@@ -3232,17 +3229,16 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 /*
  * Unshare file descriptor table if it is being shared
  */
-int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-	       struct files_struct **new_fdp)
+static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
-	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(fd, max_fds, &error);
-		if (!*new_fdp)
-			return error;
+		fd = dup_fd(fd, NULL);
+		if (IS_ERR(fd))
+			return PTR_ERR(fd);
+		*new_fdp = fd;
 	}
 
 	return 0;
@@ -3300,7 +3296,7 @@ int ksys_unshare(unsigned long unshare_flags)
 	err = unshare_fs(unshare_flags, &new_fs);
 	if (err)
 		goto bad_unshare_out;
-	err = unshare_fd(unshare_flags, NR_OPEN_MAX, &new_fd);
+	err = unshare_fd(unshare_flags, &new_fd);
 	if (err)
 		goto bad_unshare_cleanup_fs;
 	err = unshare_userns(unshare_flags, &new_cred);
@@ -3392,7 +3388,7 @@ int unshare_files(void)
 	struct files_struct *old, *copy = NULL;
 	int error;
 
-	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
+	error = unshare_fd(CLONE_FILES, &copy);
 	if (error || !copy)
 		return error;
 
-- 
2.39.2


