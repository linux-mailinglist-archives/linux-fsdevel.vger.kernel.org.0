Return-Path: <linux-fsdevel+bounces-24732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E6D944214
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6892E1C2276B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443AE1448E5;
	Thu,  1 Aug 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="xrSGFsIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2672BB10;
	Thu,  1 Aug 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484401; cv=none; b=Tj9mdq5X9nMlIveYICVbKnlI0F/a4/nAUYPutgyCz/02OJyxvY85XRE2kwd1ALWnmgT2Y27H07DcB/NLXcxFmDkO5bBc7vA22pcATTPPz/9HVi2hTELbUAiMXK0xRbWKyLlLNDsO+7yubXR9tUdvH+XgbXowXjq1sArWmaTlOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484401; c=relaxed/simple;
	bh=1syH90mxQyN1JZLq+KtkoRx8aP8URN8qtch96dhqqfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1x++q+zP6NPLwMo8FQgCcQWIxBibjdQDhqBIzcIuNnSalF4ML6NfaPBTY/vdwq1gllRcMk9GizPNP9poQx+4k8jBXO1ceZgwATT+rxOnQR7CwuRtMp5vFV+1lkGIZbcwO4ryiEv9wg1Ukyu9NJh8ppSRpHHtJPnJphqbYGnK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=xrSGFsIv; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WZFRw1nmtz9sWc;
	Thu,  1 Aug 2024 05:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722484396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK1pAn3htk8ZyKf4LH6QeGiUOjLLEiElgYnQnuIac4A=;
	b=xrSGFsIvnww92LoytSn52At6V/qex8FDO9QKRJsq38Ym26LBvJ8erON3LKxA6Kha5yLfBr
	wAwW6AX/J+1KqiBOxhXmZkPeMqQv37E1rmVyLj/8GttOgGKJuP0OM8sYLoaNqJdAtxHV/y
	ERHeO8tYklTdm3bQX3bWC8EsyaSVWEjQbOVC8RfxwNpDRSX4lIy5gaW9Pq8ovcmAakF2MF
	CX3zdddPePKhq0q/UD9p0aHG2Z3AqX5bYGbkOhvPFurH1G+9wkZkgyP4UdNyOfPkt/F9ku
	lDYgPa5Kb7KtVKtKBrvKJyFV1hmlRw1IPVmbA0uBYXa8BF4nRCKo2PHngzp3Pw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 01 Aug 2024 13:52:41 +1000
Subject: [PATCH RFC v3 2/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-exportfs-u64-mount-id-v3-2-be5d6283144a@cyphar.com>
References: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
In-Reply-To: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5914; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=1syH90mxQyN1JZLq+KtkoRx8aP8URN8qtch96dhqqfM=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaStZutJC/hgcjQ452WRU3P2vj97trmsl+E8/TKA67nA4
 VNXwrh4O0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEerIZGc7lNl9TT/CKfPr5
 hL9A9KQJJ05XSJdYehyYuTM+VEtbz46R4eFTv02VPQ3Xp1n3zmwIsjzH9+AO30FHexm2IIUvdjc
 V2QA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4WZFRw1nmtz9sWc

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
2.45.2


