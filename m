Return-Path: <linux-fsdevel+bounces-29013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D397341C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 12:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA66A1C24E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB3192B6B;
	Tue, 10 Sep 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j5DHJ2Ml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026518B488;
	Tue, 10 Sep 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964472; cv=none; b=u+MVA4BHS7h2jFPM8+1gJmBwzf172yLjPvQIPFSPDXs+J0Z0GnUplPBupOcn481I5mJ0Nsah951IS+C5npkBDfh1Wt9TRoR8xK1dNwpH8j5+BMsYVJVJlWgY6vSbClGNTkjjBHfQdo0cUmjepWXevbPa3+j3LW4e/IBKrn0hoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964472; c=relaxed/simple;
	bh=FtRYpJY9aLy9pHP3pTx2RgorHQDkI2pGMNIu0mggR2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQsnkE2DgGNJnYWJSXQCw3nOd4lo/uWPq3l9mwFA9ldbLFKjhmBQSWM5dB+4p9Ju0NBNLEO9gzJSgboVBKNgYlEIBZ0X3b88QPGaXNdYV4Xl9QQhWCDqjCTS6iiOmaSjU5ZKV1FhuwCgLkrkWDNsKkcHulvKDj9ZdfP6x0tNlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j5DHJ2Ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2663DC4CEC3;
	Tue, 10 Sep 2024 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964472;
	bh=FtRYpJY9aLy9pHP3pTx2RgorHQDkI2pGMNIu0mggR2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5DHJ2MlbbbblDHwOyhcTmYv6tHamjhfrWoNFUQAWXROt7u8AiTYL2H2Dsl9m+RR+
	 t6he/UFE/7ucI0dYjrsvuo4C9CvP0/2eRTamycLXUZaFO54HhtW7MTKEXJDViatDYI
	 uiyppBRHg+AEhvSy+R2mN5UHkNsaG8dRT/YZRD28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 177/269] vfs: Fix potential circular locking through setxattr() and removexattr()
Date: Tue, 10 Sep 2024 11:32:44 +0200
Message-ID: <20240910092614.478086490@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit c3a5e3e872f3688ae0dc57bb78ca633921d96a91 ]

When using cachefiles, lockdep may emit something similar to the circular
locking dependency notice below.  The problem appears to stem from the
following:

 (1) Cachefiles manipulates xattrs on the files in its cache when called
     from ->writepages().

 (2) The setxattr() and removexattr() system call handlers get the name
     (and value) from userspace after taking the sb_writers lock, putting
     accesses of the vma->vm_lock and mm->mmap_lock inside of that.

 (3) The afs filesystem uses a per-inode lock to prevent multiple
     revalidation RPCs and in writeback vs truncate to prevent parallel
     operations from deadlocking against the server on one side and local
     page locks on the other.

Fix this by moving the getting of the name and value in {get,remove}xattr()
outside of the sb_writers lock.  This also has the minor benefits that we
don't need to reget these in the event of a retry and we never try to take
the sb_writers lock in the event we can't pull the name and value into the
kernel.

Alternative approaches that might fix this include moving the dispatch of a
write to the cache off to a workqueue or trying to do without the
validation lock in afs.  Note that this might also affect other filesystems
that use netfslib and/or cachefiles.

 ======================================================
 WARNING: possible circular locking dependency detected
 6.10.0-build2+ #956 Not tainted
 ------------------------------------------------------
 fsstress/6050 is trying to acquire lock:
 ffff888138fd82f0 (mapping.invalidate_lock#3){++++}-{3:3}, at: filemap_fault+0x26e/0x8b0

 but task is already holding lock:
 ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x165/0x250

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #4 (&vma->vm_lock->lock){++++}-{3:3}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        down_write+0x3b/0x50
        vma_start_write+0x6b/0xa0
        vma_link+0xcc/0x140
        insert_vm_struct+0xb7/0xf0
        alloc_bprm+0x2c1/0x390
        kernel_execve+0x65/0x1a0
        call_usermodehelper_exec_async+0x14d/0x190
        ret_from_fork+0x24/0x40
        ret_from_fork_asm+0x1a/0x30

 -> #3 (&mm->mmap_lock){++++}-{3:3}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        __might_fault+0x7c/0xb0
        strncpy_from_user+0x25/0x160
        removexattr+0x7f/0x100
        __do_sys_fremovexattr+0x7e/0xb0
        do_syscall_64+0x9f/0x100
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #2 (sb_writers#14){.+.+}-{0:0}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        percpu_down_read+0x3c/0x90
        vfs_iocb_iter_write+0xe9/0x1d0
        __cachefiles_write+0x367/0x430
        cachefiles_issue_write+0x299/0x2f0
        netfs_advance_write+0x117/0x140
        netfs_write_folio.isra.0+0x5ca/0x6e0
        netfs_writepages+0x230/0x2f0
        afs_writepages+0x4d/0x70
        do_writepages+0x1e8/0x3e0
        filemap_fdatawrite_wbc+0x84/0xa0
        __filemap_fdatawrite_range+0xa8/0xf0
        file_write_and_wait_range+0x59/0x90
        afs_release+0x10f/0x270
        __fput+0x25f/0x3d0
        __do_sys_close+0x43/0x70
        do_syscall_64+0x9f/0x100
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #1 (&vnode->validate_lock){++++}-{3:3}:
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        down_read+0x95/0x200
        afs_writepages+0x37/0x70
        do_writepages+0x1e8/0x3e0
        filemap_fdatawrite_wbc+0x84/0xa0
        filemap_invalidate_inode+0x167/0x1e0
        netfs_unbuffered_write_iter+0x1bd/0x2d0
        vfs_write+0x22e/0x320
        ksys_write+0xbc/0x130
        do_syscall_64+0x9f/0x100
        entry_SYSCALL_64_after_hwframe+0x76/0x7e

 -> #0 (mapping.invalidate_lock#3){++++}-{3:3}:
        check_noncircular+0x119/0x160
        check_prev_add+0x195/0x430
        __lock_acquire+0xaf0/0xd80
        lock_acquire.part.0+0x103/0x280
        down_read+0x95/0x200
        filemap_fault+0x26e/0x8b0
        __do_fault+0x57/0xd0
        do_pte_missing+0x23b/0x320
        __handle_mm_fault+0x2d4/0x320
        handle_mm_fault+0x14f/0x260
        do_user_addr_fault+0x2a2/0x500
        exc_page_fault+0x71/0x90
        asm_exc_page_fault+0x22/0x30

 other info that might help us debug this:

 Chain exists of:
   mapping.invalidate_lock#3 --> &mm->mmap_lock --> &vma->vm_lock->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(&vma->vm_lock->lock);
                                lock(&mm->mmap_lock);
                                lock(&vma->vm_lock->lock);
   rlock(mapping.invalidate_lock#3);

  *** DEADLOCK ***

 1 lock held by fsstress/6050:
  #0: ffff888113f26d18 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x165/0x250

 stack backtrace:
 CPU: 0 PID: 6050 Comm: fsstress Not tainted 6.10.0-build2+ #956
 Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x80
  check_noncircular+0x119/0x160
  ? queued_spin_lock_slowpath+0x4be/0x510
  ? __pfx_check_noncircular+0x10/0x10
  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
  ? mark_lock+0x47/0x160
  ? init_chain_block+0x9c/0xc0
  ? add_chain_block+0x84/0xf0
  check_prev_add+0x195/0x430
  __lock_acquire+0xaf0/0xd80
  ? __pfx___lock_acquire+0x10/0x10
  ? __lock_release.isra.0+0x13b/0x230
  lock_acquire.part.0+0x103/0x280
  ? filemap_fault+0x26e/0x8b0
  ? __pfx_lock_acquire.part.0+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? lock_acquire+0xd7/0x120
  down_read+0x95/0x200
  ? filemap_fault+0x26e/0x8b0
  ? __pfx_down_read+0x10/0x10
  ? __filemap_get_folio+0x25/0x1a0
  filemap_fault+0x26e/0x8b0
  ? __pfx_filemap_fault+0x10/0x10
  ? find_held_lock+0x7c/0x90
  ? __pfx___lock_release.isra.0+0x10/0x10
  ? __pte_offset_map+0x99/0x110
  __do_fault+0x57/0xd0
  do_pte_missing+0x23b/0x320
  __handle_mm_fault+0x2d4/0x320
  ? __pfx___handle_mm_fault+0x10/0x10
  handle_mm_fault+0x14f/0x260
  do_user_addr_fault+0x2a2/0x500
  exc_page_fault+0x71/0x90
  asm_exc_page_fault+0x22/0x30

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/2136178.1721725194@warthog.procyon.org.uk
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: Gao Xiang <xiang@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
[brauner: fix minor issues]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xattr.c | 91 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index efd4736bc94b..c20046548f21 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -631,10 +631,9 @@ int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
 
-static long
-setxattr(struct mnt_idmap *idmap, struct dentry *d,
-	const char __user *name, const void __user *value, size_t size,
-	int flags)
+static int path_setxattr(const char __user *pathname,
+			 const char __user *name, const void __user *value,
+			 size_t size, int flags, unsigned int lookup_flags)
 {
 	struct xattr_name kname;
 	struct xattr_ctx ctx = {
@@ -644,33 +643,20 @@ setxattr(struct mnt_idmap *idmap, struct dentry *d,
 		.kname    = &kname,
 		.flags    = flags,
 	};
+	struct path path;
 	int error;
 
 	error = setxattr_copy(name, &ctx);
 	if (error)
 		return error;
 
-	error = do_setxattr(idmap, d, &ctx);
-
-	kvfree(ctx.kvalue);
-	return error;
-}
-
-static int path_setxattr(const char __user *pathname,
-			 const char __user *name, const void __user *value,
-			 size_t size, int flags, unsigned int lookup_flags)
-{
-	struct path path;
-	int error;
-
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
-		return error;
+		goto out;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = setxattr(mnt_idmap(path.mnt), path.dentry, name,
-				 value, size, flags);
+		error = do_setxattr(mnt_idmap(path.mnt), path.dentry, &ctx);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -678,6 +664,9 @@ static int path_setxattr(const char __user *pathname,
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
+
+out:
+	kvfree(ctx.kvalue);
 	return error;
 }
 
@@ -698,20 +687,32 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-	struct fd f = fdget(fd);
-	int error = -EBADF;
+	struct xattr_name kname;
+	struct xattr_ctx ctx = {
+		.cvalue   = value,
+		.kvalue   = NULL,
+		.size     = size,
+		.kname    = &kname,
+		.flags    = flags,
+	};
+	int error;
 
+	CLASS(fd, f)(fd);
 	if (!f.file)
-		return error;
+		return -EBADF;
+
 	audit_file(f.file);
+	error = setxattr_copy(name, &ctx);
+	if (error)
+		return error;
+
 	error = mnt_want_write_file(f.file);
 	if (!error) {
-		error = setxattr(file_mnt_idmap(f.file),
-				 f.file->f_path.dentry, name,
-				 value, size, flags);
+		error = do_setxattr(file_mnt_idmap(f.file),
+				    f.file->f_path.dentry, &ctx);
 		mnt_drop_write_file(f.file);
 	}
-	fdput(f);
+	kvfree(ctx.kvalue);
 	return error;
 }
 
@@ -900,9 +901,17 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct mnt_idmap *idmap, struct dentry *d,
-	    const char __user *name)
+removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
 {
+	if (is_posix_acl_xattr(name))
+		return vfs_remove_acl(idmap, d, name);
+	return vfs_removexattr(idmap, d, name);
+}
+
+static int path_removexattr(const char __user *pathname,
+			    const char __user *name, unsigned int lookup_flags)
+{
+	struct path path;
 	int error;
 	char kname[XATTR_NAME_MAX + 1];
 
@@ -911,25 +920,13 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
 		error = -ERANGE;
 	if (error < 0)
 		return error;
-
-	if (is_posix_acl_xattr(kname))
-		return vfs_remove_acl(idmap, d, kname);
-
-	return vfs_removexattr(idmap, d, kname);
-}
-
-static int path_removexattr(const char __user *pathname,
-			    const char __user *name, unsigned int lookup_flags)
-{
-	struct path path;
-	int error;
 retry:
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
-		error = removexattr(mnt_idmap(path.mnt), path.dentry, name);
+		error = removexattr(mnt_idmap(path.mnt), path.dentry, kname);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -955,15 +952,23 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
 	struct fd f = fdget(fd);
+	char kname[XATTR_NAME_MAX + 1];
 	int error = -EBADF;
 
 	if (!f.file)
 		return error;
 	audit_file(f.file);
+
+	error = strncpy_from_user(kname, name, sizeof(kname));
+	if (error == 0 || error == sizeof(kname))
+		error = -ERANGE;
+	if (error < 0)
+		return error;
+
 	error = mnt_want_write_file(f.file);
 	if (!error) {
 		error = removexattr(file_mnt_idmap(f.file),
-				    f.file->f_path.dentry, name);
+				    f.file->f_path.dentry, kname);
 		mnt_drop_write_file(f.file);
 	}
 	fdput(f);
-- 
2.43.0




