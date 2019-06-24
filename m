Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC64A50D52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfFXOJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfFXOJQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F4EE3079B8F;
        Mon, 24 Jun 2019 14:09:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD7291001B07;
        Mon, 24 Jun 2019 14:09:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/25] vfs: Allow fsinfo() to query what's in an fs_context
 [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:09:14 +0100
Message-ID: <156138535407.25627.15015993364565647650.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 24 Jun 2019 14:09:16 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow fsinfo() to be used to query the filesystem attached to an fs_context
once a superblock has been created or if it comes from fspick().

The caller must specify AT_FSINFO_FROM_FSOPEN in the parameters and must
supply the fd from fsopen() as dfd and must set filename to NULL.

This is done with something like:

	fd = fsopen("ext4", 0);
	...
	struct fsinfo_params params = {
		.at_flags = AT_FSINFO_FROM_FSOPEN;
		...
	};
	fsinfo(fd, NULL, &params, ...);

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                |   46 +++++++++++++++++++++++++++++++++++++++++++-
 fs/statfs.c                |    2 +-
 include/uapi/linux/fcntl.h |    2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 49b46f96dda3..c24701f994d1 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -8,6 +8,7 @@
 #include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/fsinfo.h>
+#include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -340,6 +341,42 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
 	return ret;
 }
 
+/*
+ * Allow access to an fs_context object as created by fsopen() or fspick().
+ */
+static int vfs_fsinfo_fscontext(int fd, struct fsinfo_kparams *params)
+{
+	struct fs_context *fc;
+	struct fd f = fdget(fd);
+	int ret;
+
+	if (!f.file)
+		return -EBADF;
+
+	ret = -EINVAL;
+	if (f.file->f_op == &fscontext_fops)
+		goto out_f;
+	ret = -EOPNOTSUPP;
+	if (fc->ops == &legacy_fs_context_ops)
+		goto out_f;
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret == 0) {
+		ret = -EIO;
+		if (fc->root) {
+			struct path path = { .dentry = fc->root };
+
+			ret = vfs_fsinfo(&path, params);
+		}
+
+		mutex_unlock(&fc->uapi_mutex);
+	}
+
+out_f:
+	fdput(f);
+	return ret;
+}
+
 /*
  * Return buffer information by requestable attribute.
  *
@@ -445,6 +482,9 @@ SYSCALL_DEFINE5(fsinfo,
 		params.request = user_params.request;
 		params.Nth = user_params.Nth;
 		params.Mth = user_params.Mth;
+
+		if ((params.at_flags & AT_FSINFO_FROM_FSOPEN) && filename)
+			return -EINVAL;
 	} else {
 		params.request = FSINFO_ATTR_STATFS;
 	}
@@ -453,6 +493,8 @@ SYSCALL_DEFINE5(fsinfo,
 		user_buf_size = 0;
 		user_buffer = NULL;
 	}
+	if ((params.at_flags & AT_FSINFO_FROM_FSOPEN) && filename)
+		return -EINVAL;
 
 	/* Allocate an appropriately-sized buffer.  We will truncate the
 	 * contents when we write the contents back to userspace.
@@ -500,7 +542,9 @@ SYSCALL_DEFINE5(fsinfo,
 	if (!params.buffer)
 		goto error_scratch;
 
-	if (filename)
+	if (params.at_flags & AT_FSINFO_FROM_FSOPEN)
+		ret = vfs_fsinfo_fscontext(dfd, &params);
+	else if (filename)
 		ret = vfs_fsinfo_path(dfd, filename, &params);
 	else
 		ret = vfs_fsinfo_fd(dfd, &params);
diff --git a/fs/statfs.c b/fs/statfs.c
index eea7af6f2f22..b9b63d9f4f24 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -86,7 +86,7 @@ int vfs_statfs(const struct path *path, struct kstatfs *buf)
 	int error;
 
 	error = statfs_by_dentry(path->dentry, buf);
-	if (!error)
+	if (!error && path->mnt)
 		buf->f_flags = calculate_f_flags(path->mnt);
 	return error;
 }
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..6a2402a8fa30 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -91,6 +91,8 @@
 #define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
 
+#define AT_FSINFO_FROM_FSOPEN	0x2000	/* Examine the fs_context attached to dfd by fsopen() */
+
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
 

