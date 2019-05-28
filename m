Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08F2C9CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfE1PLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1569 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfE1PLV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:11:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AC2AC0AEE5C;
        Tue, 28 May 2019 15:11:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25A415D772;
        Tue, 28 May 2019 15:11:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/25] vfs: Allow fsinfo() to query what's in an fs_context
 [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:11:19 +0100
Message-ID: <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 28 May 2019 15:11:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow fsinfo() to be used to query the filesystem attached to an fs_context
once a superblock has been created or if it comes from fspick().

This is done with something like:

	fd = fsopen("ext4", 0);
	...
	fsconfig(fd, fsconfig_cmd_create, ...);
	fsinfo(fd, NULL, ...);

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c |   30 +++++++++++++++++++++++++++++-
 fs/statfs.c |    2 +-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index f9a63410e9a2..14db881dd02d 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -8,6 +8,7 @@
 #include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/fsinfo.h>
+#include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -315,13 +316,40 @@ static int vfs_fsinfo_path(int dfd, const char __user *filename,
 	return ret;
 }
 
+static int vfs_fsinfo_fscontext(struct fs_context *fc,
+				struct fsinfo_kparams *params)
+{
+	int ret;
+
+	if (fc->ops == &legacy_fs_context_ops)
+		return -EOPNOTSUPP;
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret < 0)
+		return ret;
+
+	ret = -EIO;
+	if (fc->root) {
+		struct path path = { .dentry = fc->root };
+
+		ret = vfs_fsinfo(&path, params);
+	}
+
+	mutex_unlock(&fc->uapi_mutex);
+	return ret;
+}
+
 static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
 {
 	struct fd f = fdget_raw(fd);
 	int ret = -EBADF;
 
 	if (f.file) {
-		ret = vfs_fsinfo(&f.file->f_path, params);
+		if (f.file->f_op == &fscontext_fops)
+			ret = vfs_fsinfo_fscontext(f.file->private_data,
+						   params);
+		else
+			ret = vfs_fsinfo(&f.file->f_path, params);
 		fdput(f);
 	}
 	return ret;
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

