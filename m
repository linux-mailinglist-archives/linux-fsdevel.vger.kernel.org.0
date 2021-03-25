Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA4A349A67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCYTim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhCYTiH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ta4CkjG/mjBUKrafZ3vedGcl5jpoCWT94WasqZXc5to=;
        b=jGhm+ckwyLuHZQxn2/Z6jgf1vfAgusL8nxP8VoVbghDHN0EiH6u2W4Rg/2BUzCrhWPkARO
        IwYart0Bs5+gKHA3yx6iY4jpI7qYEU8hAKLsufFGLcaDBLzgU7rfv76b7k7qKGV3YPPNh0
        J+cIfu2jZOHw3WcJ3vE0AnV0e1JZjlA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-YDhukK9YOMiwVGmjN4aPnw-1; Thu, 25 Mar 2021 15:38:03 -0400
X-MC-Unique: YDhukK9YOMiwVGmjN4aPnw-1
Received: by mail-ed1-f72.google.com with SMTP id r19so3211458edv.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ta4CkjG/mjBUKrafZ3vedGcl5jpoCWT94WasqZXc5to=;
        b=rfy39y1YXr6EW6TpilRjv1sSLdRJZd57cSYwCgfPxJshlnPL7toINeBQmljuCDNfGB
         HcRB+MZnb/JultGMIyNd98Voxb7eXsdRsdj512+AJk26gl9QwWr5EjNd0z1LzXAFV22l
         CocrHk6H75RsYmPW+1mOsUYJ6/Cb7JL957cIkMtALdcOAwqQq5N3UlaqsTI+1GnAz/lT
         ai/S8fcNDkRGxEyWGOjQUedggb9M3oiXZi5RSEKnTROEew6GNOQp62/QuEJ3c4oH1vyQ
         Fpy1kUsO8fJioVEVrIBZQ4eR84DCKL6lnOAmxFn3ypKnORmsZ2CZb2tDQLs7ToiJLYRo
         46oA==
X-Gm-Message-State: AOAM533PxxB1JnKAZZ6b+cLwMRjOTQg0crEnrjiqGwuJJ7jlpYY5x2Nl
        Uv+0ffsbfUPwRngddc/PWV+aizuXn293D+okXWjaTXtVt+X44DtU7bpi0DqiRQb5+BS/W7NWQxx
        qYHRgEFMpZaKAEAcHJ03Vqs3OBa+X6eyYwKJXskrJJTddsAdru/QKP4+05BJpBJIqdwcwExLYdC
        dj4A==
X-Received: by 2002:aa7:d316:: with SMTP id p22mr10582781edq.107.1616701080873;
        Thu, 25 Mar 2021 12:38:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZM843u5auKWMZBpd55b9eAYbS8hUYpb57eYIrIuZev0PFdRIh4WsfVqKshHFAeVf2GnnI8Q==
X-Received: by 2002:aa7:d316:: with SMTP id p22mr10582757edq.107.1616701080612;
        Thu, 25 Mar 2021 12:38:00 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:00 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/18] ovl: stack fileattr ops
Date:   Thu, 25 Mar 2021 20:37:40 +0100
Message-Id: <20210325193755.294925-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add stacking for the fileattr operations.

Add hack for calling security_file_ioctl() for now.  Probably better to
have a pair of specific hooks for these operations.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/dir.c       |  2 ++
 fs/overlayfs/inode.c     | 77 ++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h |  3 ++
 3 files changed, 82 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 836f14b9d3a6..93efe7048a77 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1301,4 +1301,6 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
+	.fileattr_get	= ovl_fileattr_get,
+	.fileattr_set	= ovl_fileattr_set,
 };
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 003cf83bf78a..c3c96b4b3b33 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -11,6 +11,8 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
+#include <linux/fileattr.h>
+#include <linux/security.h>
 #include "overlayfs.h"
 
 
@@ -500,6 +502,79 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return err;
 }
 
+/*
+ * Work around the fact that security_file_ioctl() takes a file argument.
+ * Introducing security_inode_fileattr_get/set() hooks would solve this issue
+ * properly.
+ */
+static int ovl_security_fileattr(struct dentry *dentry, struct fileattr *fa,
+				 bool set)
+{
+	struct path realpath;
+	struct file *file;
+	unsigned int cmd;
+	int err;
+
+	ovl_path_real(dentry, &realpath);
+	file = dentry_open(&realpath, O_RDONLY, current_cred());
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	if (set)
+		cmd = fa->fsx_valid ? FS_IOC_FSSETXATTR : FS_IOC_SETFLAGS;
+	else
+		cmd = fa->fsx_valid ? FS_IOC_FSGETXATTR : FS_IOC_GETFLAGS;
+
+	err = security_file_ioctl(file, cmd, 0);
+	fput(file);
+
+	return err;
+}
+
+int ovl_fileattr_set(struct user_namespace *mnt_userns,
+		     struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct dentry *upperdentry;
+	const struct cred *old_cred;
+	int err;
+
+	err = ovl_want_write(dentry);
+	if (err)
+		goto out;
+
+	err = ovl_copy_up(dentry);
+	if (!err) {
+		upperdentry = ovl_dentry_upper(dentry);
+
+		old_cred = ovl_override_creds(inode->i_sb);
+		err = ovl_security_fileattr(dentry, fa, true);
+		if (!err)
+			err = vfs_fileattr_set(&init_user_ns, upperdentry, fa);
+		revert_creds(old_cred);
+		ovl_copyflags(ovl_inode_real(inode), inode);
+	}
+	ovl_drop_write(dentry);
+out:
+	return err;
+}
+
+int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct dentry *realdentry = ovl_dentry_real(dentry);
+	const struct cred *old_cred;
+	int err;
+
+	old_cred = ovl_override_creds(inode->i_sb);
+	err = ovl_security_fileattr(dentry, fa, false);
+	if (!err)
+		err = vfs_fileattr_get(realdentry, fa);
+	revert_creds(old_cred);
+
+	return err;
+}
+
 static const struct inode_operations ovl_file_inode_operations = {
 	.setattr	= ovl_setattr,
 	.permission	= ovl_permission,
@@ -508,6 +583,8 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
+	.fileattr_get	= ovl_fileattr_get,
+	.fileattr_set	= ovl_fileattr_set,
 };
 
 static const struct inode_operations ovl_symlink_inode_operations = {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 95cff83786a5..a1c1b5ae59e9 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -521,6 +521,9 @@ int __init ovl_aio_request_cache_init(void);
 void ovl_aio_request_cache_destroy(void);
 long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int ovl_fileattr_set(struct user_namespace *mnt_userns,
+		     struct dentry *dentry, struct fileattr *fa);
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
-- 
2.30.2

