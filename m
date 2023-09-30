Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341727B3F9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjI3JE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 05:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjI3JE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:04:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B739BF;
        Sat, 30 Sep 2023 02:04:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B578C433C8;
        Sat, 30 Sep 2023 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696064665;
        bh=up1EBdJF2x604Y2b963S0+Pa77MMN/XZWqnbxYF0YyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+14xeyVUI55X5OH+YtYcoid8gznX2752+oR0GQwWKVoEEYrgh2CipksE+52vHdqT
         HVnCUgUbRnTD4tICoRzQ5i84bubg/CwvU+qDhhgLxqUW+lMmMv2wqypFA1Miw5iqGx
         xlMnGhIUrc712w4ind3VyDfqYLNMHPsge37bFvlAWHpSwdVZ9EhMASxEadFmm3+5U+
         bE182TDGaYKB00a6lZmwORHuFduewSjTbKtfnZirVVRWvu4JZdfc5iW4udvuo93zV5
         Wk8c5VGhq90wlxyVX7/kOs7omoGkOLpKrE0KY9NZUhJaWqqE4AWE5YOz7Vm18V6vza
         8mAUONgLvRb0w==
Date:   Sat, 30 Sep 2023 11:04:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Jann Horn <jannh@google.com>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20230930-glitzer-errungenschaft-b86880c177c4@brauner>
References: <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner>
 <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
 <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner>
 <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
 <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
 <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="64yttpii3vmzvcyd"
Content-Disposition: inline
In-Reply-To: <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--64yttpii3vmzvcyd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Sep 29, 2023 at 04:57:29PM -0700, Linus Torvalds wrote:
> On Fri, 29 Sept 2023 at 14:39, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > So to be clear, obtaining the initial count would require a dedicated
> > accessor.
> 
> Please, no.
> 
> Sequence numbers here are fundamentally broken, since getting that
> initial sequence number would involve either (a) making it something
> outside of 'struct file' itself or (b) require the same re-validation
> of the file pointer that the non-sequence number code needed in the
> first place.
> 
> We already have the right model in the only place that really matters
> (ie fd lookup). Using that same "validate file pointer after you got
> the ref to it" for the two or three other cases that didn't do it (and
> are simpler: the exec pointer in particular doesn't need the fdt
> re-validation at all).
> 
> The fact that we had some fd lookup that didn't do the full thing that
> a *real* fd lookup did is just bad. Let's fix it, not introduce a
> sequence counter that only adds more complexity.

I agree.

So I guess we're trying this. The appeneded patch now includes
documentation and renames *lookup_*_fd_rcu() to *lookup_*_fdget_rcu() to
reflect the refcount bump. It's now tentatively in vfs.misc (cf. [1])
and I've merged it into vfs.all to let -next chew on it. Please take a
close look and may the rcu gods be with us all...

[1]: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git

--64yttpii3vmzvcyd
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-file-convert-to-SLAB_TYPESAFE_BY_RCU.patch"

From d266eee9d9d917f07774e2c2bab0115d2119a311 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 29 Sep 2023 08:45:59 +0200
Subject: [PATCH] file: convert to SLAB_TYPESAFE_BY_RCU

In recent discussions around some performance improvements in the file
handling area we discussed switching the file cache to rely on
SLAB_TYPESAFE_BY_RCU which allows us to get rid of call_rcu() based
freeing for files completely. This is a pretty sensitive change overall
but it might actually be worth doing.

The main downside is the subtlety. The other one is that we should
really wait for Jann's patch to land that enables KASAN to handle
SLAB_TYPESAFE_BY_RCU UAFs. Currently it doesn't but a patch for this
exists.

With SLAB_TYPESAFE_BY_RCU objects may be freed and reused multiple times
which requires a few changes. So it isn't sufficient anymore to just
acquire a reference to the file in question under rcu using
atomic_long_inc_not_zero() since the file might have already been
recycled and someone else might have bumped the reference.

In other words, callers might see reference count bumps from newer
users. For this is reason it is necessary to verify that the pointer is
the same before and after the reference count increment. This pattern
can be seen in get_file_rcu() and __files_get_rcu().

In addition, it isn't possible to access or check fields in struct file
without first aqcuiring a reference on it. Not doing that was always
very dodgy and it was only usable for non-pointer data in struct file.
With SLAB_TYPESAFE_BY_RCU it is necessary that callers first acquire a
reference under rcu or they must hold the files_lock of the fdtable.
Failing to do either one of this is a bug.

Thanks to Jann for pointing out that we need to ensure memory ordering
between reallocations and pointer check by ensuring that all subsequent
loads have a dependency on the second load in get_file_rcu() and
providing a fixup that was folded into this patch.

Cc: Jann Horn <jannh@google.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/files.rst          | 51 +++++------
 arch/powerpc/platforms/cell/spufs/coredump.c |  9 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c     |  2 +-
 fs/file.c                                    | 96 ++++++++++++++++----
 fs/file_table.c                              | 41 +++++----
 fs/gfs2/glock.c                              | 11 ++-
 fs/notify/dnotify/dnotify.c                  |  6 +-
 fs/proc/fd.c                                 | 11 ++-
 include/linux/fdtable.h                      | 16 ++--
 include/linux/fs.h                           |  4 +-
 kernel/bpf/task_iter.c                       |  4 +-
 kernel/fork.c                                |  4 +-
 kernel/kcmp.c                                |  4 +-
 13 files changed, 163 insertions(+), 96 deletions(-)

diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
index bcf84459917f..f761bdae961d 100644
--- a/Documentation/filesystems/files.rst
+++ b/Documentation/filesystems/files.rst
@@ -62,7 +62,7 @@ the fdtable structure -
    be held.
 
 4. To look up the file structure given an fd, a reader
-   must use either lookup_fd_rcu() or files_lookup_fd_rcu() APIs. These
+   must use either lookup_fdget_rcu() or files_lookup_fdget_rcu() APIs. These
    take care of barrier requirements due to lock-free lookup.
 
    An example::
@@ -70,43 +70,22 @@ the fdtable structure -
 	struct file *file;
 
 	rcu_read_lock();
-	file = lookup_fd_rcu(fd);
-	if (file) {
-		...
-	}
-	....
+	file = lookup_fdget_rcu(fd);
 	rcu_read_unlock();
-
-5. Handling of the file structures is special. Since the look-up
-   of the fd (fget()/fget_light()) are lock-free, it is possible
-   that look-up may race with the last put() operation on the
-   file structure. This is avoided using atomic_long_inc_not_zero()
-   on ->f_count::
-
-	rcu_read_lock();
-	file = files_lookup_fd_rcu(files, fd);
 	if (file) {
-		if (atomic_long_inc_not_zero(&file->f_count))
-			*fput_needed = 1;
-		else
-		/* Didn't get the reference, someone's freed */
-			file = NULL;
+		...
+                fput(file);
 	}
-	rcu_read_unlock();
 	....
-	return file;
-
-   atomic_long_inc_not_zero() detects if refcounts is already zero or
-   goes to zero during increment. If it does, we fail
-   fget()/fget_light().
 
-6. Since both fdtable and file structures can be looked up
+5. Since both fdtable and file structures can be looked up
    lock-free, they must be installed using rcu_assign_pointer()
    API. If they are looked up lock-free, rcu_dereference()
    must be used. However it is advisable to use files_fdtable()
-   and lookup_fd_rcu()/files_lookup_fd_rcu() which take care of these issues.
+   and lookup_fdget_rcu()/files_lookup_fdget_rcu() which take care of these
+   issues.
 
-7. While updating, the fdtable pointer must be looked up while
+6. While updating, the fdtable pointer must be looked up while
    holding files->file_lock. If ->file_lock is dropped, then
    another thread expand the files thereby creating a new
    fdtable and making the earlier fdtable pointer stale.
@@ -126,3 +105,17 @@ the fdtable structure -
    Since locate_fd() can drop ->file_lock (and reacquire ->file_lock),
    the fdtable pointer (fdt) must be loaded after locate_fd().
 
+On newer kernels rcu based file lookup has been switched to rely on
+SLAB_TYPESAFE_BY_RCU instead of call_rcu(). It isn't sufficient anymore to just
+acquire a reference to the file in question under rcu using
+atomic_long_inc_not_zero() since the file might have already been recycled and
+someone else might have bumped the reference. In other words, the caller might
+see reference count bumps from newer users. For this is reason it is necessary
+to verify that the pointer is the same before and after the reference count
+increment. This pattern can be seen in get_file_rcu() and __files_get_rcu().
+
+In addition, it isn't possible to access or check fields in struct file without
+first aqcuiring a reference on it. Not doing that was always very dodgy and it
+was only usable for non-pointer data in struct file. With SLAB_TYPESAFE_BY_RCU
+it is necessary that callers first acquire a reference under rcu or they must
+hold the files_lock of the fdtable. Failing to do either one of this is a bug.
diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 1a587618015c..5e157f48995e 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -74,10 +74,13 @@ static struct spu_context *coredump_next_context(int *fd)
 	*fd = n - 1;
 
 	rcu_read_lock();
-	file = lookup_fd_rcu(*fd);
-	ctx = SPUFS_I(file_inode(file))->i_ctx;
-	get_spu_context(ctx);
+	file = lookup_fdget_rcu(*fd);
 	rcu_read_unlock();
+	if (file) {
+		ctx = SPUFS_I(file_inode(file))->i_ctx;
+		get_spu_context(ctx);
+		fput(file);
+	}
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index aa4d842d4c5a..b2f00f54218f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -917,7 +917,7 @@ static struct file *mmap_singleton(struct drm_i915_private *i915)
 
 	rcu_read_lock();
 	file = READ_ONCE(i915->gem.mmap_singleton);
-	if (file && !get_file_rcu(file))
+	if (!get_file_rcu(&file))
 		file = NULL;
 	rcu_read_unlock();
 	if (file)
diff --git a/fs/file.c b/fs/file.c
index 3e4a4dfa38fc..dc0ad2ca3faa 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -853,8 +853,53 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static inline struct file *__fget_files_rcu(struct files_struct *files,
-	unsigned int fd, fmode_t mask)
+struct file *get_file_rcu(struct file __rcu **f)
+{
+	for (;;) {
+		struct file __rcu *file;
+		struct file __rcu *file_reloaded;
+		struct file __rcu *file_reloaded_cmp;
+
+		file = rcu_dereference_raw(*f);
+		if (!file)
+			return NULL;
+
+		if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
+			continue;
+
+		file_reloaded = rcu_dereference_raw(*f);
+
+		/*
+		 * Ensure that all accesses have a dependency on the
+		 * load from rcu_dereference_raw() above so we get
+		 * correct ordering between reuse/allocation and the
+		 * pointer check below.
+		 */
+		file_reloaded_cmp = file_reloaded;
+		OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
+
+		/*
+		 * atomic_long_inc_not_zero() serves as a full memory
+		 * barrier when we acquired a reference.
+		 *
+		 * This is paired with the write barrier from assigning
+		 * to the __rcu protected file pointer so that if that
+		 * pointer still matches the current file, we know we
+		 * have successfully acquire a reference to it.
+		 *
+		 * If the pointers don't match the file has been
+		 * reallocated by SLAB_TYPESAFE_BY_RCU. So verify that
+		 * we're holding the right reference.
+		 */
+		if (file == file_reloaded_cmp)
+			return file_reloaded;
+
+		fput(file);
+	}
+}
+
+static struct file *__fget_files_rcu(struct files_struct *files,
+				     unsigned int fd, fmode_t mask)
 {
 	for (;;) {
 		struct file *file;
@@ -865,12 +910,6 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 			return NULL;
 
 		fdentry = fdt->fd + array_index_nospec(fd, fdt->max_fds);
-		file = rcu_dereference_raw(*fdentry);
-		if (unlikely(!file))
-			return NULL;
-
-		if (unlikely(file->f_mode & mask))
-			return NULL;
 
 		/*
 		 * Ok, we have a file pointer. However, because we do
@@ -882,8 +921,9 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 *  (a) the file ref already went down to zero,
 		 *      and get_file_rcu() fails. Just try again:
 		 */
-		if (unlikely(!get_file_rcu(file)))
-			continue;
+		file = get_file_rcu(fdentry);
+		if (unlikely(!file))
+			return NULL;
 
 		/*
 		 *  (b) the file table entry has changed under us.
@@ -893,12 +933,16 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 		 *
 		 * If so, we need to put our ref and try again.
 		 */
-		if (unlikely(rcu_dereference_raw(files->fdt) != fdt) ||
-		    unlikely(rcu_dereference_raw(*fdentry) != file)) {
+		if (unlikely(rcu_dereference_raw(files->fdt) != fdt)) {
 			fput(file);
 			continue;
 		}
 
+		if (unlikely(file->f_mode & mask)) {
+			fput(file);
+			return NULL;
+		}
+
 		/*
 		 * Ok, we have a ref to the file, and checked that it
 		 * still exists.
@@ -907,6 +951,11 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
 	}
 }
 
+struct file *fget_files_rcu(struct files_struct *files, unsigned int fd)
+{
+	return __fget_files_rcu(files, fd, 0);
+}
+
 static struct file *__fget_files(struct files_struct *files, unsigned int fd,
 				 fmode_t mask)
 {
@@ -948,7 +997,14 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
 	return file;
 }
 
-struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd)
+static inline struct file *files_lookup_fdget_rcu(struct files_struct *files, unsigned int fd)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "suspicious rcu_dereference_check() usage");
+	return lookup_fdget_rcu(fd);
+}
+
+struct file *task_lookup_fdget_rcu(struct task_struct *task, unsigned int fd)
 {
 	/* Must be called with rcu_read_lock held */
 	struct files_struct *files;
@@ -957,13 +1013,13 @@ struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd)
 	task_lock(task);
 	files = task->files;
 	if (files)
-		file = files_lookup_fd_rcu(files, fd);
+		file = files_lookup_fdget_rcu(files, fd);
 	task_unlock(task);
 
 	return file;
 }
 
-struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *ret_fd)
+struct file *task_lookup_next_fdget_rcu(struct task_struct *task, unsigned int *ret_fd)
 {
 	/* Must be called with rcu_read_lock held */
 	struct files_struct *files;
@@ -974,7 +1030,7 @@ struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *ret
 	files = task->files;
 	if (files) {
 		for (; fd < files_fdtable(files)->max_fds; fd++) {
-			file = files_lookup_fd_rcu(files, fd);
+			file = files_lookup_fdget_rcu(files, fd);
 			if (file)
 				break;
 		}
@@ -983,7 +1039,7 @@ struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *ret
 	*ret_fd = fd;
 	return file;
 }
-EXPORT_SYMBOL(task_lookup_next_fd_rcu);
+EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
 
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
@@ -1272,12 +1328,16 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 {
 	if (unlikely(newfd == oldfd)) { /* corner case */
 		struct files_struct *files = current->files;
+		struct file *f;
 		int retval = oldfd;
 
 		rcu_read_lock();
-		if (!files_lookup_fd_rcu(files, oldfd))
+		f = files_lookup_fdget_rcu(files, oldfd);
+		if (!f)
 			retval = -EBADF;
 		rcu_read_unlock();
+		if (f)
+			fput(f);
 		return retval;
 	}
 	return ksys_dup3(oldfd, newfd, 0);
diff --git a/fs/file_table.c b/fs/file_table.c
index e68e97d4f00a..17b06b32fdee 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -65,33 +65,34 @@ static void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f = container_of(head, struct file, f_rcuhead);
 
-	put_cred(f->f_cred);
-	if (unlikely(f->f_mode & FMODE_BACKING))
-		kfree(backing_file(f));
-	else
-		kmem_cache_free(filp_cachep, f);
+	kfree(backing_file(f));
 }
 
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	if (unlikely(f->f_mode & FMODE_BACKING))
-		path_put(backing_file_real_path(f));
 	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
 		percpu_counter_dec(&nr_files);
-	call_rcu(&f->f_rcuhead, file_free_rcu);
+	put_cred(f->f_cred);
+	if (unlikely(f->f_mode & FMODE_BACKING)) {
+		path_put(backing_file_real_path(f));
+		call_rcu(&f->f_rcuhead, file_free_rcu);
+	} else {
+		kmem_cache_free(filp_cachep, f);
+	}
 }
 
 void release_empty_file(struct file *f)
 {
 	WARN_ON_ONCE(f->f_mode & (FMODE_BACKING | FMODE_OPENED));
-	/* Uhm, we better find out who grabs references to an unopened file. */
-	WARN_ON_ONCE(atomic_long_cmpxchg(&f->f_count, 1, 0) != 1);
-	security_file_free(f);
-	put_cred(f->f_cred);
-	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
-		percpu_counter_dec(&nr_files);
-	kmem_cache_free(filp_cachep, f);
+	if (atomic_long_dec_and_test(&f->f_count)) {
+		security_file_free(f);
+		put_cred(f->f_cred);
+		if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
+			percpu_counter_dec(&nr_files);
+		kmem_cache_free(filp_cachep, f);
+		return;
+	}
 }
 
 /*
@@ -176,7 +177,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 		return error;
 	}
 
-	atomic_long_set(&f->f_count, 1);
 	rwlock_init(&f->f_owner.lock);
 	spin_lock_init(&f->f_lock);
 	mutex_init(&f->f_pos_lock);
@@ -184,6 +184,12 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	f->f_mode = OPEN_FMODE(flags);
 	/* f->f_version: 0 */
 
+	/*
+	 * We're SLAB_TYPESAFE_BY_RCU so initialize f_count last. While
+	 * fget-rcu pattern users need to be able to handle spurious
+	 * refcount bumps we should reinitialize the reused file first.
+	 */
+	atomic_long_set(&f->f_count, 1);
 	return 0;
 }
 
@@ -483,7 +489,8 @@ EXPORT_SYMBOL(__fput_sync);
 void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
+				SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
+				SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9cbf8d98489a..b4bc873aab7d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2717,16 +2717,19 @@ static struct file *gfs2_glockfd_next_file(struct gfs2_glockfd_iter *i)
 	for(;; i->fd++) {
 		struct inode *inode;
 
-		i->file = task_lookup_next_fd_rcu(i->task, &i->fd);
+		i->file = task_lookup_next_fdget_rcu(i->task, &i->fd);
 		if (!i->file) {
 			i->fd = 0;
 			break;
 		}
+
 		inode = file_inode(i->file);
-		if (inode->i_sb != i->sb)
-			continue;
-		if (get_file_rcu(i->file))
+		if (inode->i_sb == i->sb)
 			break;
+
+		rcu_read_unlock();
+		fput(i->file);
+		rcu_read_lock();
 	}
 	rcu_read_unlock();
 	return i->file;
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index ebdcc25df0f7..869b016014d2 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -265,7 +265,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 	struct dnotify_struct *dn;
 	struct inode *inode;
 	fl_owner_t id = current->files;
-	struct file *f;
+	struct file *f = NULL;
 	int destroy = 0, error = 0;
 	__u32 mask;
 
@@ -345,7 +345,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 	}
 
 	rcu_read_lock();
-	f = lookup_fd_rcu(fd);
+	f = lookup_fdget_rcu(fd);
 	rcu_read_unlock();
 
 	/* if (f != filp) means that we lost a race and another task/thread
@@ -392,6 +392,8 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		fsnotify_put_mark(new_fsn_mark);
 	if (dn)
 		kmem_cache_free(dnotify_struct_cache, dn);
+	if (f)
+		fput(f);
 	return error;
 }
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6276b3938842..6e72e5ad42bc 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -113,10 +113,12 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 	struct file *file;
 
 	rcu_read_lock();
-	file = task_lookup_fd_rcu(task, fd);
-	if (file)
-		*mode = file->f_mode;
+	file = task_lookup_fdget_rcu(task, fd);
 	rcu_read_unlock();
+	if (file) {
+		*mode = file->f_mode;
+		fput(file);
+	}
 	return !!file;
 }
 
@@ -259,12 +261,13 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		char name[10 + 1];
 		unsigned int len;
 
-		f = task_lookup_next_fd_rcu(p, &fd);
+		f = task_lookup_next_fdget_rcu(p, &fd);
 		ctx->pos = fd + 2LL;
 		if (!f)
 			break;
 		data.mode = f->f_mode;
 		rcu_read_unlock();
+		fput(f);
 		data.fd = fd;
 
 		len = snprintf(name, sizeof(name), "%u", fd);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..805305a1d4fd 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -77,6 +77,8 @@ struct dentry;
 #define files_fdtable(files) \
 	rcu_dereference_check_fdtable((files), (files)->fdt)
 
+struct file *fget_files_rcu(struct files_struct *files, unsigned int fd);
+
 /*
  * The caller must ensure that fd table isn't shared or hold rcu or file lock
  */
@@ -98,20 +100,14 @@ static inline struct file *files_lookup_fd_locked(struct files_struct *files, un
 	return files_lookup_fd_raw(files, fd);
 }
 
-static inline struct file *files_lookup_fd_rcu(struct files_struct *files, unsigned int fd)
+static inline struct file *lookup_fdget_rcu(unsigned int fd)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
-			   "suspicious rcu_dereference_check() usage");
-	return files_lookup_fd_raw(files, fd);
-}
+	return fget_files_rcu(current->files, fd);
 
-static inline struct file *lookup_fd_rcu(unsigned int fd)
-{
-	return files_lookup_fd_rcu(current->files, fd);
 }
 
-struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd);
-struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *fd);
+struct file *task_lookup_fdget_rcu(struct task_struct *task, unsigned int fd);
+struct file *task_lookup_next_fdget_rcu(struct task_struct *task, unsigned int *fd);
 
 struct task_struct;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 58dea591a341..ceafc40cc25f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1042,7 +1042,9 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
-#define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
+
+struct file *get_file_rcu(struct file __rcu **f);
+
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..d82f0ece42d2 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -308,10 +308,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 	rcu_read_lock();
 	for (;; curr_fd++) {
 		struct file *f;
-		f = task_lookup_next_fd_rcu(curr_task, &curr_fd);
+		f = task_lookup_next_fdget_rcu(curr_task, &curr_fd);
 		if (!f)
-			break;
-		if (!get_file_rcu(f))
 			continue;
 
 		/* set info->fd */
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..640123767726 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1492,9 +1492,7 @@ struct file *get_mm_exe_file(struct mm_struct *mm)
 	struct file *exe_file;
 
 	rcu_read_lock();
-	exe_file = rcu_dereference(mm->exe_file);
-	if (exe_file && !get_file_rcu(exe_file))
-		exe_file = NULL;
+	exe_file = get_file_rcu(&mm->exe_file);
 	rcu_read_unlock();
 	return exe_file;
 }
diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 5353edfad8e1..b0639f21041f 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -64,8 +64,10 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 	struct file *file;
 
 	rcu_read_lock();
-	file = task_lookup_fd_rcu(task, idx);
+	file = task_lookup_fdget_rcu(task, idx);
 	rcu_read_unlock();
+	if (file)
+		fput(file);
 
 	return file;
 }
-- 
2.34.1


--64yttpii3vmzvcyd--
