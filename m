Return-Path: <linux-fsdevel+bounces-60802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0663B51A78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BFF44476C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589C374268;
	Wed, 10 Sep 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW6j41ii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0507371EAF;
	Wed, 10 Sep 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515194; cv=none; b=eUDLAHLF9A0jApDxOPxrxkqDM4kgDA6lV4J8GLn/cnSy/1utFShbaIhewSh10oyvqsM8PfbGlm+jjv1fPwKF41mnt7jRnq/Mf7kdiAX4FNWlO062cj/ol1nFWadLkzM2XXjRprw10YLQzy4UJ0iShNZ79jt01YP3YM9vNv61b1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515194; c=relaxed/simple;
	bh=jLmeRXfM/fHQlSZnDayQte5byFb73+eVfvcpuEjbG5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cy+Al7BY+O0a71OeUgsYRJfFhb2Exbz+mYcJvtIf158UkBKxFUBjf0SSgj0GT3imJB2giInZHuVh3sVYF4RwnSlnvuGJtudGSYjPSNi8KFhS7bqi5pcMFV/JyZA/IgNB7zujCk+dILamY6JAJema7WpO7K7hAw70SyQMU7ptZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW6j41ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CDDC4CEF0;
	Wed, 10 Sep 2025 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515193;
	bh=jLmeRXfM/fHQlSZnDayQte5byFb73+eVfvcpuEjbG5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eW6j41iihMu0DWvGQM6MkIx/Erya2gHx31P+WN7OskP0+9E3wtaTWiIC3eOIHMyIL
	 ToxQWdCf4Oy2NX+xEqTohsl63js51jUQBtrrtNlRPW+JIPJPD9gHnvfPf2R/ts2pjf
	 fRz0gPaZ8M3kDxJqO4lvtm972RGq0Jgs3d3N3W5+seGMPDrK1u9xH8TxgmTCIZZApA
	 c81tmHMTf6rjxrt5n7pO3z7lq4Y5hxTFNChjI2OeKcKl1GHOy8NGJVHRNPntDatMSP
	 3moJB0j8OnNDp19FsBuUyOHwCjzQd7DVpsZ+cnxgBhmqu222XqoT5cNLpoiSkDkvT7
	 JIBSuEf275yNw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:13 +0200
Subject: [PATCH 28/32] nsfs: support exhaustive file handles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-28-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jLmeRXfM/fHQlSZnDayQte5byFb73+eVfvcpuEjbG5w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OXMDuYW3la+4f+8mSb61edMgqQ4mQ/mJxyrFV59z
 /I2l/qNjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8aWb4X7uwpkpm8pwNcy1n
 irVznf58Vinr4K+u3zt/uB3IPVjvVcDwv+oKk4dOyumcS5KtgkZX+yOaOxOLvZ9Mvbf6yt0DXL9
 mcAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pidfd file handles are exhaustive meaning they don't require a handle on
another pidfd to pass to open_by_handle_at() so it can derive the
filesystem to decode in. Instead it can be derived from the file
handle itself. The same is possible for namespace file handles.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c               |  6 ++++++
 fs/internal.h              |  1 +
 fs/nsfs.c                  | 10 ++++++++++
 include/uapi/linux/fcntl.h |  1 +
 4 files changed, 18 insertions(+)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 7c236f64cdea..f18c855bb0c2 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -11,6 +11,7 @@
 #include <linux/personality.h>
 #include <linux/uaccess.h>
 #include <linux/compat.h>
+#include <linux/nsfs.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -189,6 +190,11 @@ static int get_path_anchor(int fd, struct path *root)
 		return 0;
 	}
 
+	if (fd == FD_NSFS_ROOT) {
+		nsfs_get_root(root);
+		return 0;
+	}
+
 	return -EBADF;
 }
 
diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..a33d18ee5b74 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -355,3 +355,4 @@ int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
 int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *attr);
 void pidfs_get_root(struct path *path);
+void nsfs_get_root(struct path *path);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index a1585a2f4f03..3c6fcf652633 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -25,6 +25,14 @@
 
 static struct vfsmount *nsfs_mnt;
 
+static struct path nsfs_root_path = {};
+
+void nsfs_get_root(struct path *path)
+{
+	*path = nsfs_root_path;
+	path_get(path);
+}
+
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg);
 static const struct file_operations ns_file_operations = {
@@ -616,4 +624,6 @@ void __init nsfs_init(void)
 	if (IS_ERR(nsfs_mnt))
 		panic("can't set nsfs up\n");
 	nsfs_mnt->mnt_sb->s_flags &= ~SB_NOUSER;
+	nsfs_root_path.mnt = nsfs_mnt;
+	nsfs_root_path.dentry = nsfs_mnt->mnt_root;
 }
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index f291ab4f94eb..3741ea1b73d8 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -111,6 +111,7 @@
 #define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
 
 #define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
+#define FD_NSFS_ROOT			-10003 /* Root of the nsfs filesystem */
 #define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */

-- 
2.47.3


