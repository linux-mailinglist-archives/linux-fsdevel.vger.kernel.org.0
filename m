Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4730DA04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 13:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBCMnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 07:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229797AbhBCMnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSTGdlhf01vnqUGzMAyHoVvvPnSsrRjLGDiMeUTOedI=;
        b=VfmTSGs3CSYfIGz4X1VF/aBIgh+LKm4bS36MkUHIMng7OUwkkohe5Ju+qikzNz/WUCu3tT
        /ezt2cUrnQ7B1+0oNbF0azMePvC/G4M7Buz2KZxnxoJRemOTz0cRvcAT7hgUFL4K774Rju
        RrxQkQ3Rw3stl8JP8yTZpgW0/QZv6qI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-BqNSpq9yPEynJO53NwRI6A-1; Wed, 03 Feb 2021 07:41:38 -0500
X-MC-Unique: BqNSpq9yPEynJO53NwRI6A-1
Received: by mail-ej1-f69.google.com with SMTP id gt18so11994131ejb.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSTGdlhf01vnqUGzMAyHoVvvPnSsrRjLGDiMeUTOedI=;
        b=rjC0OnSchvA6WzM1KmRUDrN7VbU99h982uC5mwit5vHvv7605wUBwwLWs6YtP6auRR
         f+kjBIjCai0PUXgNWU7bM6nhCN4kMFXIhxhtIHDEjzn76hgzP2wkCXNM57A9oEmhb+zu
         B0HZ76e9Yk+WXP/sFK3dpA+LWdlRGrXo+4CMzwomSgtrxZMgAy7H4uVhye04sfowD+cM
         SCg7XVVvwZgIbenm0Faxcq36iQlFTVgdjKFx4dN6acs2kPFe+/fQMvmqDnVWscqFYjp+
         RSTBQgmPdC1/IFfPEXB3fXTmp99IT4nDlzWfC+njTeC8irbSdJYA2wpk13gs4BxHw2JF
         ouQQ==
X-Gm-Message-State: AOAM530/r9Y8J9d3B1nAir6HPBa1a0AdbEXsguFuLeBZacR7lW1r39K9
        sdLPrzDrvBjid+qvXUDDuIcqyDIxYNfZqKSiooUDIlzQkzlhMn7N+72kzDFPARXV4J8aOq+1sik
        oWfIinB5TJwyy+OpbqnVBT/Na+ckt+7+yZmTwQRZtNUwobLUvtQ+LYEPeWLc+/fWyQ+RlpgjnG7
        prhA==
X-Received: by 2002:a17:906:39d0:: with SMTP id i16mr3004870eje.18.1612356096486;
        Wed, 03 Feb 2021 04:41:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjV8uvWB/fRXlmYx4vCxkD9enIBDh1ypEAriqn3tbCGU4b83tHq+/gJ+/PIR9rlHwXi3gDig==
X-Received: by 2002:a17:906:39d0:: with SMTP id i16mr3004856eje.18.1612356096230;
        Wed, 03 Feb 2021 04:41:36 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:35 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] ovl: stack miscattr
Date:   Wed,  3 Feb 2021 13:40:57 +0100
Message-Id: <20210203124112.1182614-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203124112.1182614-1-mszeredi@redhat.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add stacking for the miscattr operations.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/dir.c       |  2 ++
 fs/overlayfs/inode.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 28a075b5f5b2..77c6b44f8d83 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1300,4 +1300,6 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
+	.miscattr_get	= ovl_miscattr_get,
+	.miscattr_set	= ovl_miscattr_set,
 };
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index d739e14c6814..97d36d1f28c3 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
+#include <linux/miscattr.h>
 #include "overlayfs.h"
 
 
@@ -495,6 +496,46 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return err;
 }
 
+int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma)
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
+		/* err = security_file_ioctl(real.file, cmd, arg); */
+		err = vfs_miscattr_set(upperdentry, ma);
+		revert_creds(old_cred);
+		ovl_copyflags(ovl_inode_real(inode), inode);
+	}
+	ovl_drop_write(dentry);
+out:
+	return err;
+}
+
+int ovl_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	struct dentry *realdentry = ovl_dentry_real(dentry);
+	const struct cred *old_cred;
+	int err;
+
+	old_cred = ovl_override_creds(inode->i_sb);
+	err = vfs_miscattr_get(realdentry, ma);
+	revert_creds(old_cred);
+
+	return err;
+}
+
 static const struct inode_operations ovl_file_inode_operations = {
 	.setattr	= ovl_setattr,
 	.permission	= ovl_permission,
@@ -503,6 +544,8 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
+	.miscattr_get	= ovl_miscattr_get,
+	.miscattr_set	= ovl_miscattr_set,
 };
 
 static const struct inode_operations ovl_symlink_inode_operations = {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b487e48c7fd4..d3ad02c34cca 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -509,6 +509,8 @@ int __init ovl_aio_request_cache_init(void);
 void ovl_aio_request_cache_destroy(void);
 long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int ovl_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int ovl_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
-- 
2.26.2

