Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B036C59F26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfF1Poh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58383 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1Poh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:44:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1BF88B120;
        Fri, 28 Jun 2019 15:44:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D63EE1001B11;
        Fri, 28 Jun 2019 15:44:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/11] vfs: Allow fsinfo() to query what's in an fs_context
 [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:44:28 +0100
Message-ID: <156173666802.14042.13414281886470689522.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 28 Jun 2019 15:44:36 +0000 (UTC)
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

 fs/fsinfo.c                |   44 +++++++++++++++++++++++++++++++++++++++++++-
 fs/statfs.c                |    2 +-
 include/uapi/linux/fcntl.h |    2 ++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 09e743b16235..d419cccbf3db 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -13,6 +13,7 @@
 #include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/fsinfo.h>
+#include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -347,6 +348,42 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
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
+	if (f.file->f_op != &fscontext_fops)
+		goto out_f;
+	ret = -EOPNOTSUPP;
+	if (fc->ops == &legacy_fs_context_ops)
+		goto out_f;
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret == 0) {
+		ret = -EBADFD;
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
@@ -452,6 +489,9 @@ SYSCALL_DEFINE5(fsinfo,
 		kparams.request = user_params.request;
 		kparams.Nth = user_params.Nth;
 		kparams.Mth = user_params.Mth;
+
+		if ((kparams.at_flags & AT_FSINFO_FROM_FSOPEN) && pathname)
+			return -EINVAL;
 	} else {
 		kparams.request = FSINFO_ATTR_STATFS;
 	}
@@ -508,7 +548,9 @@ SYSCALL_DEFINE5(fsinfo,
 	if (!kparams.buffer)
 		goto error_scratch;
 
-	if (pathname)
+	if (kparams.at_flags & AT_FSINFO_FROM_FSOPEN)
+		ret = vfs_fsinfo_fscontext(dfd, &kparams);
+	else if (pathname)
 		ret = vfs_fsinfo_path(dfd, pathname, &kparams);
 	else
 		ret = vfs_fsinfo_fd(dfd, &kparams);
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
 
 

