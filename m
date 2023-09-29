Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4367B7B3ADC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjI2T6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 15:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjI2T6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:58:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB51B2;
        Fri, 29 Sep 2023 12:58:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B0FC433C7;
        Fri, 29 Sep 2023 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696017483;
        bh=ZJq0041KdZfiOMXk+jzPIbTE3bU3L32O/t+4yOeEQRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3wCDFqt7Jk1yAoGX2OmrDbxVZluZvnmaeeu+atZl6FhQ7UupNGFBwEDHRV50rjuu
         6xHsHKJ5dFfnWAnM4DTZmOb31WOryCdoTMdDyaFF/1QL18nWp2ntvf6eF2gHq5iwOk
         VOqgFC3pEt1cAL0sh7HkDu091hpVUkIp2vf1vWx8+93oz8OBJ8EnOSDosRZvPjNIDt
         G6Ku7AEgXQYW6TnVMk5c9bG51uYpEJ5i5evDgUJK9zftOK1nQezfnjQSQ5l71uw7as
         GS4LCpMhBOaQR+9siKvFRxLEPoxW4WYOcKbstsnQE+lzxOhKkVl86BVO0uE4x/y3wW
         g2YKhnBO1A5wQ==
Date:   Fri, 29 Sep 2023 21:57:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20230929-test-lauf-693fda7ae36b@brauner>
References: <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f>
 <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner>
 <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
 <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="b3zz657ciemz5u3k"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--b3zz657ciemz5u3k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 29, 2023 at 03:31:29PM +0200, Jann Horn wrote:
> On Fri, Sep 29, 2023 at 11:20 AM Christian Brauner <brauner@kernel.org> wrote:
> > > But yes, that protection would be broken by SLAB_TYPESAFE_BY_RCU,
> > > since then the "f_count is zero" is no longer a final thing.
> >
> > I've tried coming up with a patch that is simple enough so the pattern
> > is easy to follow and then converting all places to rely on a pattern
> > that combine lookup_fd_rcu() or similar with get_file_rcu(). The obvious
> > thing is that we'll force a few places to now always acquire a reference
> > when they don't really need one right now and that already may cause
> > performance issues.
> 
> (Those places are probably used way less often than the hot
> open/fget/close paths though.)
> 
> > We also can't fully get rid of plain get_file_rcu() uses itself because
> > of users such as mm->exe_file. They don't go from one of the rcu fdtable
> > lookup helpers to the struct file obviously. They rcu replace the file
> > pointer in their struct ofc so we could change get_file_rcu() to take a
> > struct file __rcu **f and then comparing that the passed in pointer
> > hasn't changed before we managed to do atomic_long_inc_not_zero(). Which
> > afaict should work for such cases.
> >
> > But overall we would introduce a fairly big and at the same time subtle
> > semantic change. The idea is pretty neat and it was fun to do but I'm
> > just not convinced we should do it given how ubiquitous struct file is
> > used and now to make the semanics even more special by allowing
> > refcounts.
> >
> > I've kept your original release_empty_file() proposal in vfs.misc which
> > I think is a really nice change.
> >
> > Let me know if you all passionately disagree. ;)

So I'm appending the patch I had played with and a fix from Jann on top.
@Linus, if you have an opinion, let me know what you think.

Also available here:
https://gitlab.com/brauner/linux/-/commits/vfs.file.rcu

Might be interesting if this could be perfed to see if there is any real
gain for workloads with massive numbers of fds.

--b3zz657ciemz5u3k
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-PROBABLY-BROKEN-AS-ABSOLUTE-FSCK-AND-QUICKLY-DRAFTED.patch"

From ad101054772181fa044f7891c4575c0a0b6205fd Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 29 Sep 2023 08:45:59 +0200
Subject: [PATCH 1/2] [PROBABLY BROKEN AS ABSOLUTE FSCK AND QUICKLY DRAFTED]
 file: convert to SLAB_TYPESAFE_BY_RCU

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
which requires a few changes. In __fget_files_rcu() the check for f_mode
needs to move down to after we've acquired a reference on the object.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>

[PROBABLY BROKEN AS ABSOLUTE FSCK AND QUICKLY DRAFTED] file: convert to SLAB_TYPESAFE_BY_RCU

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/files.rst          |  7 +++
 arch/powerpc/platforms/cell/spufs/coredump.c |  7 ++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c     |  2 +-
 fs/file.c                                    | 60 +++++++++++++++-----
 fs/file_table.c                              | 36 ++++++------
 fs/gfs2/glock.c                              |  7 ++-
 fs/notify/dnotify/dnotify.c                  |  4 +-
 fs/proc/fd.c                                 |  7 ++-
 include/linux/fdtable.h                      | 15 +++--
 include/linux/fs.h                           |  3 +-
 kernel/bpf/task_iter.c                       |  2 -
 kernel/fork.c                                |  4 +-
 kernel/kcmp.c                                |  2 +
 13 files changed, 105 insertions(+), 51 deletions(-)

diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
index bcf84459917f..9e77f46a7389 100644
--- a/Documentation/filesystems/files.rst
+++ b/Documentation/filesystems/files.rst
@@ -126,3 +126,10 @@ the fdtable structure -
    Since locate_fd() can drop ->file_lock (and reacquire ->file_lock),
    the fdtable pointer (fdt) must be loaded after locate_fd().
 
+On newer kernels rcu based file lookup has been switched to rely on
+SLAB_TYPESAFE_BY_RCU. This means it isn't sufficient anymore to just acquire a
+reference to the file in question under rcu using atomic_long_inc_not_zero()
+since the file might have already been recycled and someone else might have
+bumped the reference. In other words, the caller might see reference
+count bumps from newer users. For this is reason it is necessary to verify that
+the pointer is the same before and after the reference count increment.
diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 1a587618015c..6fe84037bccd 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -75,9 +75,12 @@ static struct spu_context *coredump_next_context(int *fd)
 
 	rcu_read_lock();
 	file = lookup_fd_rcu(*fd);
-	ctx = SPUFS_I(file_inode(file))->i_ctx;
-	get_spu_context(ctx);
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
index 3e4a4dfa38fc..e983cf3b9e01 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -853,8 +853,39 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static inline struct file *__fget_files_rcu(struct files_struct *files,
-	unsigned int fd, fmode_t mask)
+struct file *get_file_rcu(struct file __rcu **f)
+{
+	for (;;) {
+		struct file __rcu *file;
+
+		file = rcu_dereference_raw(*f);
+		if (!file)
+			return NULL;
+
+		if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
+			continue;
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
+		if (file == rcu_access_pointer(*f))
+			return rcu_pointer_handoff(file);
+
+		fput(file);
+	}
+}
+
+struct file *__fget_files_rcu(struct files_struct *files, unsigned int fd, fmode_t mask)
 {
 	for (;;) {
 		struct file *file;
@@ -865,12 +896,6 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
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
@@ -882,8 +907,9 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
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
@@ -893,12 +919,16 @@ static inline struct file *__fget_files_rcu(struct files_struct *files,
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
@@ -1272,12 +1302,16 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 {
 	if (unlikely(newfd == oldfd)) { /* corner case */
 		struct files_struct *files = current->files;
+		struct file *f;
 		int retval = oldfd;
 
 		rcu_read_lock();
-		if (!files_lookup_fd_rcu(files, oldfd))
+		f = files_lookup_fd_rcu(files, oldfd);
+		if (!f)
 			retval = -EBADF;
 		rcu_read_unlock();
+		if (f)
+			fput(f);
 		return retval;
 	}
 	return ksys_dup3(oldfd, newfd, 0);
diff --git a/fs/file_table.c b/fs/file_table.c
index e68e97d4f00a..844c97d21b33 100644
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
@@ -184,6 +184,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	f->f_mode = OPEN_FMODE(flags);
 	/* f->f_version: 0 */
 
+	atomic_long_set(&f->f_count, 1);
 	return 0;
 }
 
@@ -483,7 +484,8 @@ EXPORT_SYMBOL(__fput_sync);
 void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
+				SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
+				SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9cbf8d98489a..ced04c49e37c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2723,10 +2723,11 @@ static struct file *gfs2_glockfd_next_file(struct gfs2_glockfd_iter *i)
 			break;
 		}
 		inode = file_inode(i->file);
-		if (inode->i_sb != i->sb)
+		if (inode->i_sb != i->sb) {
+			fput(i->file);
 			continue;
-		if (get_file_rcu(i->file))
-			break;
+		}
+		break;
 	}
 	rcu_read_unlock();
 	return i->file;
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index ebdcc25df0f7..987db4c8bbff 100644
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
 
@@ -392,6 +392,8 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		fsnotify_put_mark(new_fsn_mark);
 	if (dn)
 		kmem_cache_free(dnotify_struct_cache, dn);
+	if (f)
+		fput(f);
 	return error;
 }
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 6276b3938842..47a717142efa 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -114,9 +114,11 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 
 	rcu_read_lock();
 	file = task_lookup_fd_rcu(task, fd);
-	if (file)
-		*mode = file->f_mode;
 	rcu_read_unlock();
+	if (file) {
+		*mode = file->f_mode;
+		fput(file);
+	}
 	return !!file;
 }
 
@@ -265,6 +267,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 			break;
 		data.mode = f->f_mode;
 		rcu_read_unlock();
+		fput(f);
 		data.fd = fd;
 
 		len = snprintf(name, sizeof(name), "%u", fd);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..6d088f069228 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -77,6 +77,8 @@ struct dentry;
 #define files_fdtable(files) \
 	rcu_dereference_check_fdtable((files), (files)->fdt)
 
+struct file *__fget_files_rcu(struct files_struct *files, unsigned int fd, fmode_t mask);
+
 /*
  * The caller must ensure that fd table isn't shared or hold rcu or file lock
  */
@@ -98,16 +100,17 @@ static inline struct file *files_lookup_fd_locked(struct files_struct *files, un
 	return files_lookup_fd_raw(files, fd);
 }
 
-static inline struct file *files_lookup_fd_rcu(struct files_struct *files, unsigned int fd)
+static inline struct file *lookup_fd_rcu(unsigned int fd)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
-			   "suspicious rcu_dereference_check() usage");
-	return files_lookup_fd_raw(files, fd);
+	return __fget_files_rcu(current->files, fd, 0);
+
 }
 
-static inline struct file *lookup_fd_rcu(unsigned int fd)
+static inline struct file *files_lookup_fd_rcu(struct files_struct *files, unsigned int fd)
 {
-	return files_lookup_fd_rcu(current->files, fd);
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			   "suspicious rcu_dereference_check() usage");
+	return lookup_fd_rcu(fd);
 }
 
 struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 58dea591a341..f9a601629517 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1042,7 +1042,8 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
-#define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
+struct file *get_file_rcu(struct file __rcu **f);
+
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..ee1d5c0ccf5a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -310,8 +310,6 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 		struct file *f;
 		f = task_lookup_next_fd_rcu(curr_task, &curr_fd);
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
index 5353edfad8e1..e0dfa82606cb 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -66,6 +66,8 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 	rcu_read_lock();
 	file = task_lookup_fd_rcu(task, idx);
 	rcu_read_unlock();
+	if (file)
+		fput(file);
 
 	return file;
 }
-- 
2.34.1


--b3zz657ciemz5u3k
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-file-ensure-ordering-between-memory-reallocation-and.patch"

From 479d59bdfb5a157a218f8cafb04d1556e175fc80 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 29 Sep 2023 21:49:39 +0200
Subject: [PATCH 2/2] file: ensure ordering between memory reallocation and
 pointer check

by ensuring that all subsequent loads have a dependency on the second
load from *f.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index e983cf3b9e01..8d3c10dfb98a 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -857,6 +857,8 @@ struct file *get_file_rcu(struct file __rcu **f)
 {
 	for (;;) {
 		struct file __rcu *file;
+		struct file __rcu *file_reloaded;
+		struct file __rcu *file_reloaded_cmp;
 
 		file = rcu_dereference_raw(*f);
 		if (!file)
@@ -877,9 +879,15 @@ struct file *get_file_rcu(struct file __rcu **f)
 		 * If the pointers don't match the file has been
 		 * reallocated by SLAB_TYPESAFE_BY_RCU. So verify that
 		 * we're holding the right reference.
+		 *
+		 * Ensure that all accesses have a dependency on the
+		 * load from rcu_dereference_raw().
 		 */
-		if (file == rcu_access_pointer(*f))
-			return rcu_pointer_handoff(file);
+		file_reloaded = rcu_dereference_raw(*f);
+		file_reloaded_cmp = file_reloaded;
+		OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
+		if (file == file_reloaded_cmp)
+			return file_reloaded;
 
 		fput(file);
 	}
-- 
2.34.1


--b3zz657ciemz5u3k--
