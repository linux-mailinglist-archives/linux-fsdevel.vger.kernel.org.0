Return-Path: <linux-fsdevel+bounces-36149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD539DE7D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC6FB23A51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C71A76DE;
	Fri, 29 Nov 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJbYnNsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABF1A7274;
	Fri, 29 Nov 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887574; cv=none; b=G7v9kXjoT/TwYE+PE8J5wiDmkX2EgbTsE20lk87BQeRddC4Q9lSlaMoRuJ129YV2iN1D1A+8N6AnLBT0BVK8Zxw5Bmi4Q0uJ2shdWeCnizjNE9Lv/ZjaUNE5w0t2hYNGNs6qG1qTVxP75mnxyno1QL+htfFGwY6d03dXaUTOK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887574; c=relaxed/simple;
	bh=mZfbHs4mNu6U8OuHnn6AHXjPoepY5hOvawaSJo/awdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmKw2otBJvEdJghiY01xw35EGeFDJpD2/5o9+eYxtjTrMVx2X2umhGLZRBv6c9UcW3JuiLXIq0+qKDKAgs1v3pjzrGJHsBlbvn6BrhSm72d59krcxhDtzm0/KgA/UW6JGFHy7BICvOUUQZ2ZaEg1FMJd4tBN6dcS+A5f5MFa+Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJbYnNsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D465C4CED2;
	Fri, 29 Nov 2024 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887573;
	bh=mZfbHs4mNu6U8OuHnn6AHXjPoepY5hOvawaSJo/awdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJbYnNsWr8gAk6kku4/yzZo9cZRyG0eQqJlnfXRYA4BD4UPtgnBk3rjjq+YA6dr4/
	 7PTi1cxghYMPERjCq1NIVnfrpcf95uC/g3gtzSMRK33s1yp3D+Lf3DtKK5AHrId8u9
	 ZfExURO96dLLn92ODwKFZzwfcW9Ywzvzc6i5uLcnIxObppCowfsU/wSOs8FzYK65BA
	 dFxxbroGNLk8/q9P97Y3m18Iw/9Tt3hxA4W5rzedUmMfZPYdPM64OT+gcpT66Ic8oD
	 lREfy345wtMt34fejmX/gur5M54adEgnXYXxjfCkxqo4TtmVFcum+EZCJsOx8NKbOV
	 xkZn2mKMNOiFQ==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 5/6] exportfs: add permission method
Date: Fri, 29 Nov 2024 14:38:04 +0100
Message-ID: <20241129-work-pidfs-file_handle-v1-5-87d803a42495@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542; i=brauner@kernel.org; h=from:subject:message-id; bh=mZfbHs4mNu6U8OuHnn6AHXjPoepY5hOvawaSJo/awdo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7Hj7IHNIUIFB0X+vnw6L4CXP2Phe1bhGK/P5+AaOhq /ma3lmnOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaywZ+RoX+bcZzqxJ9uj89Y JAWekPebccBm2oa1Cx+78+eu3M4wV5CR4cf2yrO/1JIqz07ZlbP3YtzvV1o3Fu8w3nv18+aunLD +Wm4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This allows filesystems such as pidfs to provide their custom permission
checks.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c             | 21 +++++++--------------
 include/linux/exportfs.h | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 031ad5592a0beabcc299436f037ad5fe626332e6..23491094032ec037066a271873ea8ff794616bee 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -187,17 +187,6 @@ static int get_path_from_fd(int fd, struct path *root)
 	return 0;
 }
 
-enum handle_to_path_flags {
-	HANDLE_CHECK_PERMS   = (1 << 0),
-	HANDLE_CHECK_SUBTREE = (1 << 1),
-};
-
-struct handle_to_path_ctx {
-	struct path root;
-	enum handle_to_path_flags flags;
-	unsigned int fh_flags;
-};
-
 static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 {
 	struct handle_to_path_ctx *ctx = context;
@@ -335,15 +324,19 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	struct file_handle f_handle;
 	struct file_handle *handle = NULL;
 	struct handle_to_path_ctx ctx = {};
+	const struct export_operations *eops;
 
 	retval = get_path_from_fd(mountdirfd, &ctx.root);
 	if (retval)
 		goto out_err;
 
-	if (!may_decode_fh(&ctx, o_flags)) {
-		retval = -EPERM;
+	eops = ctx.root.mnt->mnt_sb->s_export_op;
+	if (eops && eops->permission)
+		retval = eops->permission(&ctx, o_flags);
+	else
+		retval = may_decode_fh(&ctx, o_flags);
+	if (retval)
 		goto out_path;
-	}
 
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
 		retval = -EFAULT;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index c69b79b64466d5bc32ffe9b2796a388130fe72d8..a087606ace194ccc9d1250f990ce55627aaf8dc5 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -3,6 +3,7 @@
 #define LINUX_EXPORTFS_H 1
 
 #include <linux/types.h>
+#include <linux/path.h>
 
 struct dentry;
 struct iattr;
@@ -10,7 +11,6 @@ struct inode;
 struct iomap;
 struct super_block;
 struct vfsmount;
-struct path;
 
 /* limit the handle size to NFSv4 handle size now */
 #define MAX_HANDLE_SZ 128
@@ -157,6 +157,17 @@ struct fid {
 	};
 };
 
+enum handle_to_path_flags {
+	HANDLE_CHECK_PERMS   = (1 << 0),
+	HANDLE_CHECK_SUBTREE = (1 << 1),
+};
+
+struct handle_to_path_ctx {
+	struct path root;
+	enum handle_to_path_flags flags;
+	unsigned int fh_flags;
+};
+
 #define EXPORT_FH_CONNECTABLE	0x1 /* Encode file handle with parent */
 #define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
 #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a directory */
@@ -226,6 +237,9 @@ struct fid {
  *    is also a directory.  In the event that it cannot be found, or storage
  *    space cannot be allocated, a %ERR_PTR should be returned.
  *
+ * permission:
+ *    Allow filesystems to specify a custom permission function.
+ *
  * open:
  *    Allow filesystems to specify a custom open function.
  *
@@ -255,6 +269,7 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
+	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
 	struct file * (*open)(struct path *path, unsigned int oflags);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */

-- 
2.45.2


