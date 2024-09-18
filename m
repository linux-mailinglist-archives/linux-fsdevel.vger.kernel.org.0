Return-Path: <linux-fsdevel+bounces-29646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E3297BD90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9111C23A19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F618C93A;
	Wed, 18 Sep 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBgm5reN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2918C01A;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668109; cv=none; b=r7bkamgowVshbckU4qBmmjjezjGr32bl24K8LdwiMm732vROmAwYoGVoJ6av2L6f17hIY4lOw6I7RoSjjo4S3WQQXgorLWFF1oVkRvuiYdF511UvP5DymS1kS4dfdPyHQvvsi9HB3Kl9Jl0bxzB3WIPupT+BM0rOWX0Az26xnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668109; c=relaxed/simple;
	bh=SrjfI6AJkMF7a6Yl8Mz1p1+x5RAggVoecp0mMtBpEhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyAaLgxzSochXk3NITAIq15XTFYMCXG8eOot4xV65Yeyx15GBOEmjnWDiu7zOsw9zvdQ0uuNCgeudbialVJ6tS+KPMd9mIrLlmu++ofrZKxhw3xX+UgVfhzjGXSBVvOgBhwHoi5voM/tk/yvV2JFdkS0Xw9W1pw467BHBTt/O3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBgm5reN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D5CEC4CECE;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668109;
	bh=SrjfI6AJkMF7a6Yl8Mz1p1+x5RAggVoecp0mMtBpEhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HBgm5reNAr+rZxQOxQgZlwIG7owMM6OIIndSPYrnOYTFZTjsn/Xl1mT3KwQ82a1oD
	 iCtitZNTEGR289ZXEki5QerBnBXtHCyHzraG0vGyOKGcoEuddzJ7EIA6UokyTDn0S1
	 3OqQo/xamrKYqfgf9jMp952jfdUruZ37e5ng+pBUko+iVaiycBgNS9p1GI6+gimMIb
	 QLlndbGT8Z9ZET+QVZbhEfcZvQ12dyGhpypKZOfrEY7mPMuSJ+g/YneIUvq2qO0+I2
	 mOSoGyd9DJALZNLnbULB6Xf9qwL8GhnYy4V/yh/Qk5d3iehIgx4meE5MwYvd5O9Wfy
	 BQvtxxy6LYF8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F084CCD1A5;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:01:21 +0800
Subject: [PATCH v6.10 3/3] vfs: support statx(..., NULL, AT_EMPTY_PATH,
 ...)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-10-y-v1-3-8364a071074f@gmail.com>
References: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8249;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=9J/bYSPlXIhi6E9ZB6fXyrlVsF3FwIjzHhYa5Djr6II=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t1KfUnRmp/RO24B5ffmTM9lmVdAkJCLpExWt
 CDy7GA9pmSJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurdSgAKCRCwMePKe/7Z
 budqEACnpGoT7Y0FlY2Hs2G5q/h3SoXGRAespgXTTIeFpKmWPIKeNlPnWKtyyLBIQTJMIzuABmQ
 VzY5fSizUDOH9hKyt6w2la06glIjq+0UXn8xpQUZwCY0zUfn/vHVNdzBjOx3KtHitTdyLERDw9x
 rLEOxCLye+X7wq+570ufY/bTjkPfWrWiTZjxHWkmYdgwo/MbGPj1CEJ/KS/vRFhVrTC3xxaRhkJ
 hpYc2qhM3KxOkpADfedtQijQYxjWDIfrqmx457NgeQrMdcNIk/Z2yUzkLs/MUqZ0+AVpeuaWkxK
 9CkMzKARdApRrZ2Eoy/J5y4Xw/L+3Glrd3jkDnQWQeMmxnU7izK0tQIaxf6LvABRKeUnsWcDU1c
 IEBTTuB7dtDCyrAfY9QoKR7Q8CD5yM3QkHoULr0zOu8i0f4zNduz/y5/OB4LyieLTqj2JPs0dGe
 yuzRacpyxh0AugoGlfqW6awB+WxfZaJO6JF+hVpIl3npdRa3nttd4utogGk1j9WsQSAptX25o4k
 dT56Ivbok6mxkw+XEQk3Pz/NActtImZppXw64YHomixrU92Evjh2u6loAHgDa/tpeNMcvZ6qwue
 Fx2F/nGdWmho/X5BqYo1E3EeaBl8SqDlOYpKbiQmo4AAMhbzmY1a3yFtpQd3BJQfNVOpXMaNSr9
 glbBWJcrl9U+YWg==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Mateusz Guzik <mjguzik@gmail.com>

commit 0ef625b upstream.

The newly used helper also checks for empty ("") paths.

NULL paths with any flag value other than AT_EMPTY_PATH go the usual
route and end up with -EFAULT to retain compatibility (Rust is abusing
calls of the sort to detect availability of statx).

This avoids path lookup code, lockref management, memory allocation and
in case of NULL path userspace memory access (which can be quite
expensive with SMAP on x86_64).

Benchmarked with statx(..., AT_EMPTY_PATH, ...) running on Sapphire
Rapids, with the "" path for the first two cases and NULL for the last
one.

Results in ops/s:
stock:     4231237
pre-check: 5944063 (+40%)
NULL path: 6601619 (+11%/+56%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/r/20240625151807.620812-1-mjguzik@gmail.com
Tested-by: Xi Ruoyao <xry111@xry111.site>
[brauner: use path_mounted() and other tweaks]
Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/internal.h  |  14 ++++++++
 fs/namespace.c |  13 -------
 fs/stat.c      | 111 ++++++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 97 insertions(+), 41 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index ab2225136f60..f26454c60a98 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -247,6 +247,8 @@ extern const struct dentry_operations ns_dentry_operations;
 int getname_statx_lookup_flags(int flags);
 int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	     unsigned int mask, struct statx __user *buffer);
+int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
+		struct statx __user *buffer);
 
 /*
  * fs/splice.c:
@@ -321,3 +323,15 @@ struct stashed_operations {
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+/**
+ * path_mounted - check whether path is mounted
+ * @path: path to check
+ *
+ * Determine whether @path refers to the root of a mount.
+ *
+ * Return: true if @path is the root of a mount, false if not.
+ */
+static inline bool path_mounted(const struct path *path)
+{
+	return path->mnt->mnt_root == path->dentry;
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index e1ced589d835..0134eda41b71 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1846,19 +1846,6 @@ bool may_mount(void)
 	return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
-/**
- * path_mounted - check whether path is mounted
- * @path: path to check
- *
- * Determine whether @path refers to the root of a mount.
- *
- * Return: true if @path is the root of a mount, false if not.
- */
-static inline bool path_mounted(const struct path *path)
-{
-	return path->mnt->mnt_root == path->dentry;
-}
-
 static void warn_mandlock(void)
 {
 	pr_warn_once("=======================================================\n"
diff --git a/fs/stat.c b/fs/stat.c
index 0e8558f9c0b3..52fde6fe0086 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -214,6 +214,43 @@ int getname_statx_lookup_flags(int flags)
 	return lookup_flags;
 }
 
+static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
+			  u32 request_mask)
+{
+	int error = vfs_getattr(path, stat, request_mask, flags);
+
+	if (request_mask & STATX_MNT_ID_UNIQUE) {
+		stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
+		stat->result_mask |= STATX_MNT_ID_UNIQUE;
+	} else {
+		stat->mnt_id = real_mount(path->mnt)->mnt_id;
+		stat->result_mask |= STATX_MNT_ID;
+	}
+
+	if (path_mounted(path))
+		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
+	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+
+	/* Handle STATX_DIOALIGN for block devices. */
+	if (request_mask & STATX_DIOALIGN) {
+		struct inode *inode = d_backing_inode(path->dentry);
+
+		if (S_ISBLK(inode->i_mode))
+			bdev_statx_dioalign(inode, stat);
+	}
+
+	return error;
+}
+
+static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
+			  u32 request_mask)
+{
+	CLASS(fd_raw, f)(fd);
+	if (!f.file)
+		return -EBADF;
+	return vfs_statx_path(&f.file->f_path, flags, stat, request_mask);
+}
+
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative filename
@@ -243,36 +280,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 retry:
 	error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
 	if (error)
-		goto out;
-
-	error = vfs_getattr(&path, stat, request_mask, flags);
-
-	if (request_mask & STATX_MNT_ID_UNIQUE) {
-		stat->mnt_id = real_mount(path.mnt)->mnt_id_unique;
-		stat->result_mask |= STATX_MNT_ID_UNIQUE;
-	} else {
-		stat->mnt_id = real_mount(path.mnt)->mnt_id;
-		stat->result_mask |= STATX_MNT_ID;
-	}
-
-	if (path.mnt->mnt_root == path.dentry)
-		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
-	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
-
-	/* Handle STATX_DIOALIGN for block devices. */
-	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
-
-		if (S_ISBLK(inode->i_mode))
-			bdev_statx_dioalign(inode, stat);
-	}
-
+		return error;
+	error = vfs_statx_path(&path, flags, stat, request_mask);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-out:
 	return error;
 }
 
@@ -666,7 +680,8 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
 
-	/* STATX_CHANGE_COOKIE is kernel-only for now. Ignore requests
+	/*
+	 * STATX_CHANGE_COOKIE is kernel-only for now. Ignore requests
 	 * from userland.
 	 */
 	mask &= ~STATX_CHANGE_COOKIE;
@@ -678,16 +693,41 @@ int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	return cp_statx(&stat, buffer);
 }
 
+int do_statx_fd(int fd, unsigned int flags, unsigned int mask,
+	     struct statx __user *buffer)
+{
+	struct kstat stat;
+	int error;
+
+	if (mask & STATX__RESERVED)
+		return -EINVAL;
+	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
+		return -EINVAL;
+
+	/*
+	 * STATX_CHANGE_COOKIE is kernel-only for now. Ignore requests
+	 * from userland.
+	 */
+	mask &= ~STATX_CHANGE_COOKIE;
+
+	error = vfs_statx_fd(fd, flags, &stat, mask);
+	if (error)
+		return error;
+
+	return cp_statx(&stat, buffer);
+}
+
 /**
  * sys_statx - System call to get enhanced stats
  * @dfd: Base directory to pathwalk from *or* fd to stat.
- * @filename: File to stat or "" with AT_EMPTY_PATH
+ * @filename: File to stat or either NULL or "" with AT_EMPTY_PATH
  * @flags: AT_* flags to control pathwalk.
  * @mask: Parts of statx struct actually required.
  * @buffer: Result buffer.
  *
  * Note that fstat() can be emulated by setting dfd to the fd of interest,
- * supplying "" as the filename and setting AT_EMPTY_PATH in the flags.
+ * supplying "" (or preferably NULL) as the filename and setting AT_EMPTY_PATH
+ * in the flags.
  */
 SYSCALL_DEFINE5(statx,
 		int, dfd, const char __user *, filename, unsigned, flags,
@@ -695,8 +735,23 @@ SYSCALL_DEFINE5(statx,
 		struct statx __user *, buffer)
 {
 	int ret;
+	unsigned lflags;
 	struct filename *name;
 
+	/*
+	 * Short-circuit handling of NULL and "" paths.
+	 *
+	 * For a NULL path we require and accept only the AT_EMPTY_PATH flag
+	 * (possibly |'d with AT_STATX flags).
+	 *
+	 * However, glibc on 32-bit architectures implements fstatat as statx
+	 * with the "" pathname and AT_NO_AUTOMOUNT | AT_EMPTY_PATH flags.
+	 * Supporting this results in the uglification below.
+	 */
+	lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
+	if (lflags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
+		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
+
 	name = getname_flags(filename, getname_statx_lookup_flags(flags), NULL);
 	ret = do_statx(dfd, name, flags, mask, buffer);
 	putname(name);

-- 
2.43.0



