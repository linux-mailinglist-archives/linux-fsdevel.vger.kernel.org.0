Return-Path: <linux-fsdevel+bounces-20074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85078CDBAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FD1F23AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE07127B7D;
	Thu, 23 May 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Kdh1MfS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD62126F36;
	Thu, 23 May 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497873; cv=none; b=jLV0GiOIeMVkIjWg7K0a8IkgQsRx07JHg1Rvx6zlzFo4KtbKLtHULwitUNLPUUY1gn/BpmOhhU8GhNLxEvsnqvqL7+4roLoFys1/mxyslzFZNZi4Q6TVmqFpzMW/dy3nAommzxZ5n1KQFrVp1reTpvdQYjMn4e1/RIu/mvsnBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497873; c=relaxed/simple;
	bh=NJn6MLTQTNErU5Eoq/tTA+6eCKCQ76jbApbAUWEdt38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nrsRwgxyQDBMkYj/HNBdIrdOdk1BEJHaDSM+TcDsi6utUwggjiIGgq0mUmFynadp6PU34OximdQ0akWMr3AEAAimHemxm3aXnTTNDMah24zrRDaE6SWPx/e1bA66ZhEr8kqXB0fbo0/ARK69sHSWS2MkozPT1w2ujlQbUr/bsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Kdh1MfS+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VlgVL0y0Xz9t3R;
	Thu, 23 May 2024 22:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716497866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j36WhCaHkgE+WBH+Nt4uVRki6lOiFluehQWImsMWgQo=;
	b=Kdh1MfS+Kb2/2U1LiBiac3zEN5sl86RNy2HME1Y5FoPzgldMlicPycWr5TN7otkIi2iQjd
	LulPtryGb8sy7nguE2yDZSFefxvu2aKRbNW1IWIe8mqbKin4GcYcTY0LfVjt+N93nDnb3g
	l0TS7HVHrx+Redy12UEndNp+dQ2gLFZUmuBaken+I8oy9tD57ePnXTp0UuD5ghxSrIzAfi
	S8lk7M5Rd4Oub9ps245oZ4o+e5aJ3QVHKSZStOosxShe6jus66vaLljvSWtg9fXmXYD3FW
	lVenUeE2QWUXeOoc1nXWr2DCnlwoY+hC332lqcWnzJgxDayjVFjT8ABLyFMIyQ==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 23 May 2024 13:57:32 -0700
Subject: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
X-B4-Tracking: v=1; b=H4sIALutT2YC/3WNTQ6CMBCFr0Jm7RhaGQOuTEw8gFvDgpapdAElL
 RAI6d1tcO3y/X1vh8DecoBbtoPnxQbrhiTkKQPdNcOH0bZJg8xlkZMg5HV0fjIB52uBvZuHKTW
 wYqVIU6nooiFtR8/Grgf3Da/nA+pkdjZMzm/H1yKO6IeV+R/sIlCgITJtJQWpku96G7vGn7Xro
 Y4xfgHGHbgjwAAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11473; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=NJn6MLTQTNErU5Eoq/tTA+6eCKCQ76jbApbAUWEdt38=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaT5rz3qMXWbGefBtRoVvDsyVmalsy/49Djvx6qql+47Q
 z2nXJQW6ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQAT+eHCyPAnqCTSa4Oo0qPC
 uV9+FDTve3yr+Vn1jo9+17sVV4R8iMxkZLjvdNO/o3iNraTqpKd7HA7UVspLLmAxX/P1tPQ6lrP
 pmiwA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4VlgVL0y0Xz9t3R

Now that we provide a unique 64-bit mount ID interface in statx, we can
now provide a race-free way for name_to_handle_at(2) to provide a file
handle and corresponding mount without needing to worry about racing
with /proc/mountinfo parsing.

While this is not necessary if you are using AT_EMPTY_PATH and don't
care about an extra statx(2) call, users that pass full paths into
name_to_handle_at(2) need to know which mount the file handle comes from
(to make sure they don't try to open_by_handle_at a file handle from a
different filesystem) and switching to AT_EMPTY_PATH would require
allocating a file for every name_to_handle_at(2) call, turning

  err = name_to_handle_at(-EBADF, "/foo/bar/baz", &handle, &mntid,
                          AT_HANDLE_MNT_ID_UNIQUE);

into

  int fd = openat(-EBADF, "/foo/bar/baz", O_PATH | O_CLOEXEC);
  err1 = name_to_handle_at(fd, "", &handle, &unused_mntid, AT_EMPTY_PATH);
  err2 = statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &statxbuf);
  mntid = statxbuf.stx_mnt_id;
  close(fd);

Unlike AT_HANDLE_FID, as per Amir's suggestion, AT_HANDLE_MNT_ID_UNIQUE
uses a new AT_* bit from the historically-unused 0xFF range (which we
now define as being the "per-syscall" range for AT_* bits).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- Fixed a few minor compiler warnings and a buggy copy_to_user() check.
- Rename AT_HANDLE_UNIQUE_MOUNT_ID -> AT_HANDLE_MNT_ID_UNIQUE to match statx.
- Switched to using an AT_* bit from 0xFF and defining that range as
  being "per-syscall" for future usage.
- Sync tools/ copy of <linux/fcntl.h> to include changes.
- v1: <https://lore.kernel.org/r/20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
---
 fs/fhandle.c                     | 29 ++++++++++++++++++++++-------
 include/linux/syscalls.h         |  2 +-
 include/uapi/linux/fcntl.h       | 28 +++++++++++++++++++++-------
 tools/include/uapi/linux/fcntl.h | 28 +++++++++++++++++++++-------
 4 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 8a7f86c2139a..c6e90161b900 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -16,7 +16,8 @@
 
 static long do_sys_name_to_handle(const struct path *path,
 				  struct file_handle __user *ufh,
-				  int __user *mnt_id, int fh_flags)
+				  void __user *mnt_id, bool unique_mntid,
+				  int fh_flags)
 {
 	long retval;
 	struct file_handle f_handle;
@@ -69,9 +70,19 @@ static long do_sys_name_to_handle(const struct path *path,
 	} else
 		retval = 0;
 	/* copy the mount id */
-	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
-	    copy_to_user(ufh, handle,
-			 struct_size(handle, f_handle, handle_bytes)))
+	if (unique_mntid) {
+		if (put_user(real_mount(path->mnt)->mnt_id_unique,
+			     (u64 __user *) mnt_id))
+			retval = -EFAULT;
+	} else {
+		if (put_user(real_mount(path->mnt)->mnt_id,
+			     (int __user *) mnt_id))
+			retval = -EFAULT;
+	}
+	/* copy the handle */
+	if (retval != -EFAULT &&
+		copy_to_user(ufh, handle,
+			     struct_size(handle, f_handle, handle_bytes)))
 		retval = -EFAULT;
 	kfree(handle);
 	return retval;
@@ -83,6 +94,7 @@ static long do_sys_name_to_handle(const struct path *path,
  * @name: name that should be converted to handle.
  * @handle: resulting file handle
  * @mnt_id: mount id of the file system containing the file
+ *          (u64 if AT_HANDLE_MNT_ID_UNIQUE, otherwise int)
  * @flag: flag value to indicate whether to follow symlink or not
  *        and whether a decodable file handle is required.
  *
@@ -92,7 +104,7 @@ static long do_sys_name_to_handle(const struct path *path,
  * value required.
  */
 SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
-		struct file_handle __user *, handle, int __user *, mnt_id,
+		struct file_handle __user *, handle, void __user *, mnt_id,
 		int, flag)
 {
 	struct path path;
@@ -100,7 +112,8 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 	int fh_flags;
 	int err;
 
-	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID))
+	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
+		     AT_HANDLE_MNT_ID_UNIQUE))
 		return -EINVAL;
 
 	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
@@ -109,7 +122,9 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 		lookup_flags |= LOOKUP_EMPTY;
 	err = user_path_at(dfd, name, lookup_flags, &path);
 	if (!err) {
-		err = do_sys_name_to_handle(&path, handle, mnt_id, fh_flags);
+		err = do_sys_name_to_handle(&path, handle, mnt_id,
+					    flag & AT_HANDLE_MNT_ID_UNIQUE,
+					    fh_flags);
 		path_put(&path);
 	}
 	return err;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e619ac10cd23..99c5a783a01e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -863,7 +863,7 @@ asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
 				  const char  __user *pathname);
 asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
 				      struct file_handle __user *handle,
-				      int __user *mnt_id, int flag);
+				      void __user *mnt_id, int flag);
 asmlinkage long sys_open_by_handle_at(int mountdirfd,
 				      struct file_handle __user *handle,
 				      int flags);
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..9ed9d65842c1 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -87,22 +87,24 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define AT_FDCWD		-100    /* Special value used to indicate
+                                           openat should use the current
+                                           working directory. */
+#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+
 /*
- * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
- * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
+ * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS
+ * is meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
  * unlinkat.  The two functions do completely different things and therefore,
  * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
  * faccessat would be undefined behavior and thus treating it equivalent to
  * AT_EACCESS is valid undefined behavior.
  */
-#define AT_FDCWD		-100    /* Special value used to indicate
-                                           openat should use the current
-                                           working directory. */
-#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
 #define AT_EACCESS		0x200	/* Test access permitted for
                                            effective IDs, not real IDs.  */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
+
 #define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
 #define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
 #define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
@@ -114,10 +116,22 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
-/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
+/*
+ * All new purely-syscall-specific AT_* flags should consider using bits from
+ * 0xFF, but the bits used by RENAME_* (0x7) should be avoided in case users
+ * decide to pass AT_* flags to renameat2() by accident. These flag bits are
+ * free for re-use by other syscall's syscall-specific flags without worry.
+ */
+
+/*
+ * Flags for name_to_handle_at(2). To save AT_ flag space we re-use the
+ * AT_EACCESS/AT_REMOVEDIR bit for AT_HANDLE_FID.
+ */
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
 					compare object identity and may not
 					be usable to open_by_handle_at(2) */
+#define AT_HANDLE_MNT_ID_UNIQUE	0x80	/* return the u64 unique mount id */
+
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
 #endif
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 282e90aeb163..f671312ca481 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -85,22 +85,24 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define AT_FDCWD		-100    /* Special value used to indicate
+                                           openat should use the current
+                                           working directory. */
+#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+
 /*
- * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
- * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
+ * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS
+ * is meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
  * unlinkat.  The two functions do completely different things and therefore,
  * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
  * faccessat would be undefined behavior and thus treating it equivalent to
  * AT_EACCESS is valid undefined behavior.
  */
-#define AT_FDCWD		-100    /* Special value used to indicate
-                                           openat should use the current
-                                           working directory. */
-#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
 #define AT_EACCESS		0x200	/* Test access permitted for
                                            effective IDs, not real IDs.  */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
+
 #define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
 #define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
 #define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
@@ -112,10 +114,22 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
-/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
+/*
+ * All new purely-syscall-specific AT_* flags should consider using bits from
+ * 0xFF, but the bits used by RENAME_* (0x7) should be avoided in case users
+ * decide to pass AT_* flags to renameat2() by accident. These flag bits are
+ * free for re-use by other syscall's syscall-specific flags without worry.
+ */
+
+/*
+ * Flags for name_to_handle_at(2). To save AT_ flag space we re-use the
+ * AT_EACCESS/AT_REMOVEDIR bit for AT_HANDLE_FID.
+ */
 #define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
 					compare object identity and may not
 					be usable to open_by_handle_at(2) */
+#define AT_HANDLE_MNT_ID_UNIQUE	0x80 /* returned mount id is the u64 unique mount id */
+
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
 #endif

---
base-commit: 584bbf439d0fa83d728ec49f3a38c581bdc828b4
change-id: 20240515-exportfs-u64-mount-id-9ebb5c58b53c

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


