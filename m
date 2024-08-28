Return-Path: <linux-fsdevel+bounces-27540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3400A9624AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0871F27480
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202616BE21;
	Wed, 28 Aug 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="srfh1/j2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B616B3B6;
	Wed, 28 Aug 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840436; cv=none; b=pn134X3FiRoNeA9rHy2A7koDQLO/M3hWUx16QNU+suZ3THqFpklj2+/Tk0sf7dT14diw/tAIlnd6Xv5q5s6xufw8MCc7kp/TSNC1Djjb/TkUAe247wSJoYydi/9/IwfYdk9c44ODtDJGlVa4E/M+66GHnv9io/7FgOpcEVi/ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840436; c=relaxed/simple;
	bh=V7tyZo42KRzhJMOB9sBnRwanzsU4h7z0p4i43WPkloc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCJDcWDYJUT+9YF2fdF3x3S/EWEtq9rY6jVVAOJYnJD9hpiy1qp2XWMdF7VUnsT2LI7U1MDp9E/v5F+BP+YhZZ1zMaX8rkuaHXjRS02zwpkqyoaK/nb9ynPPf07qon+wQD9IBMnfMZTOsTJxKtiXVswbhAYlJybiYzCCvV4pLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=srfh1/j2; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wv0m82GSxz9sxG;
	Wed, 28 Aug 2024 12:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1724840424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/etGWng+vYhHUDTPmtySIMqzp4DMXHgo5r9nN5CsXw=;
	b=srfh1/j2rt2BdkqLXBO2XOA6AqLofSnEL0E2ArCAsQFJE8k4c24J368PKSfoQAKkUef7L3
	leH/BJF+8nOankXab0tHP3BX0m2mDoxkgRY/ABfCYP15bCpvHXWWosZyMD2RihqytvKL0+
	mNX2fbq88sSOwH076p3xtiUakCQbBMfp5nbCncJLkfCH2y59xQyytGzrRRlh7ZNfWnHjRA
	gc4vmMTr2lfi2fR/4HVS8zYHa+nTCXbpTrcCVEVknTgB7jYzh9tBDOJvU7mw+bGYxDZtXc
	sxtOb5L2iW2qamiAwOf4rOYAyRT48IGxfpqnjZ2gQ47Xx8ZcF4h+nbcJ6Wm7Aw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 28 Aug 2024 20:19:43 +1000
Subject: [PATCH RESEND v3 2/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-exportfs-u64-mount-id-v3-2-10c2c4c16708@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
In-Reply-To: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5961; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=V7tyZo42KRzhJMOB9sBnRwanzsU4h7z0p4i43WPkloc=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSd+3lc8UbM4Smfko719Z+be32esdrpqgsxomJ56zX4u
 a0vNJ6z6ChlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATie5g+MMta2kWnMcYxJxY
 5xlTWG4gPH2iwGIr0fSHosYTa1xY1RkZjnjv23b9Tt1jjfLqQhmeE7dlF1mtD/T3M5tc+La4huE
 nOwA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Now that we provide a unique 64-bit mount ID interface in statx(2), we
can now provide a race-free way for name_to_handle_at(2) to provide a
file handle and corresponding mount without needing to worry about
racing with /proc/mountinfo parsing or having to open a file just to do
statx(2).

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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/fhandle.c                                       | 29 ++++++++++++++++------
 include/linux/syscalls.h                           |  2 +-
 include/uapi/linux/fcntl.h                         |  1 +
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |  1 +
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6e8cea16790e..8cb665629f4a 100644
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
index 4bcf6754738d..5758104921e6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -870,7 +870,7 @@ asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
 #endif
 asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
 				      struct file_handle __user *handle,
-				      int __user *mnt_id, int flag);
+				      void __user *mnt_id, int flag);
 asmlinkage long sys_open_by_handle_at(int mountdirfd,
 				      struct file_handle __user *handle,
 				      int flags);
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 38a6d66d9e88..87e2dec79fea 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -152,6 +152,7 @@
 #define AT_HANDLE_FID		0x200	/* File handle is needed to compare
 					   object identity and may not be
 					   usable with open_by_handle_at(2). */
+#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
 
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index 38a6d66d9e88..87e2dec79fea 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -152,6 +152,7 @@
 #define AT_HANDLE_FID		0x200	/* File handle is needed to compare
 					   object identity and may not be
 					   usable with open_by_handle_at(2). */
+#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
 
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000

-- 
2.46.0


