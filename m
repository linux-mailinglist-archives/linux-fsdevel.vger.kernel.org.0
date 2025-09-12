Return-Path: <linux-fsdevel+bounces-61074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0CB54C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B87D188B510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0C3081CD;
	Fri, 12 Sep 2025 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlFYJXiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE13081C7;
	Fri, 12 Sep 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678149; cv=none; b=lKiX0NHo9hQIBSxh8LwGkeP2Vt2Td0qppTGmI3bX1yB7H3VgXWB8Jggk8oTxhHZaAPCYEUvK5ib+UGDSwe0Z2Qnu1SC5oTqpm3wnOm9BSXf0asWCbFG2DINkaeoFK9elIRAz7IlGPzNTrAZCrcZsOHdsplGCFkGyG77K1Y+3NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678149; c=relaxed/simple;
	bh=yObUfUdPCVkTlHS/BGHOoNHxnFYodWOWM1Znc88D5to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRKxPlbvoz2E5sGyqAh3Z3HjuEDCDrxdcTIeFakP7r7ElmNMkeM2JuGTmq4LDTPwUQrGXrYQ/5XHK0UlUq6xH9F+Ybl7RO58hnxS7LCmo66gUtrknLIopkVd/W/1F37FE+m0Z72gMmoIszVnGqEouCFwaF4yQZrvp4npmSdODqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlFYJXiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F789C4CEF1;
	Fri, 12 Sep 2025 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678149;
	bh=yObUfUdPCVkTlHS/BGHOoNHxnFYodWOWM1Znc88D5to=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WlFYJXiPEx3J4cg1dDCH7gA6a+qROgJ6CHu5ndCpnNVw1xOKuZ98T+7Q24jMrNU6m
	 AaRIWvN4Szk6EjmhDzlDY2ZfHqnIy4C31E/GcH4Yam5fV14YJToNhql1lWtWOQOIfJ
	 M48hgm8lZaeN0v/aTCgHxKJCb/iR1tdR2Mejv93vMD1iJKgnPNQRG+VtTOrc83wt4U
	 8nnWVslYS05ecshAGveC/pgnvd0uEg8GgIH/nq8YCATrHJc46GddbXgo206UYF/Zpi
	 0l0y2xgXtLtEeRkTw+VqByxju3YJJ1cs1hf4vktL9S5TFiMARnfADd0ftJhRAY79WI
	 QqvkYHmBAM34w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:52 +0200
Subject: [PATCH v2 29/33] nsfs: support exhaustive file handles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-29-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yObUfUdPCVkTlHS/BGHOoNHxnFYodWOWM1Znc88D5to=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zy6LXCBk8NKqxfXJeoWdzAfTxFcuTtrNf/fPyZPH
 Xp4qnq3dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkdiLD/7LTuy4ttrNI2vP4
 /HL37TNWnFf6tWe529O1D4JD5h+KnvqPkWF7//MDb2zEZWSFQqtfVVn9j3fnd2WLLJz7S3dCJru
 5DAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pidfd file handles are exhaustive meaning they don't require a handle on
another pidfd to pass to open_by_handle_at() so it can derive the
filesystem to decode in. Instead it can be derived from the file
handle itself. The same is possible for namespace file handles.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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
index 926e2680414e..22765fcab18e 100644
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
@@ -598,4 +606,6 @@ void __init nsfs_init(void)
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


