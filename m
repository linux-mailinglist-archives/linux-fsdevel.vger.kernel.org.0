Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1ABEA78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfIZCNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:13:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35334 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfIZCNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:13:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so751225wmi.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zh5jmyO5F3BUfYYd+HMTYNsKgvdRPm7apGOLmwRTjl4=;
        b=wtHeHlGYON58k0yQ7ju5K+mtZHXj30PbcpZIb6Uzix/WdCt0VohiK7nOLWeCLl7vmr
         UQE+DAKjzws4v1bhn0WRBcGA3dkDfuEtk7YpRve+LfWfwvrdH3ZgnThfw0QmMy+YwUcb
         IErZBuwMCfjPJv/zqiyMHNAHWtJrsdkvC2guA1QWb7D2u0dOWqIAA4OCh1ttWBZ+wOHk
         wNYMpiDibwGIzXhInMspOORC/DKfP6cSzUxGG+QdpHg1qYfH0L/WsyBra28T068YybgZ
         0B1XgTCUOx7qC3fbc+wKEQctLec3yYeLCLGncBEzQRGKR02/7ueRTg5mKJLoRuedLb9U
         /TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zh5jmyO5F3BUfYYd+HMTYNsKgvdRPm7apGOLmwRTjl4=;
        b=E5SxPSjOcoZQjoQOCiLYVrSFJAZPIkRFQu1+u8FVpP3FUdwYVD0g4zkaceE/9SDNPM
         LgEo7t86quyXXxZ1a6jh/XEOmMZANtCj/78Kv3O+OEQ244DyyXXfp2ZQ3N8oYo+9RFY+
         gh3N3vw913g03QjWsYaM4/mi/8jXFIoge51+2CU35HfRDRxw5HdkcAS7kpex0XEOb0dk
         hd9BUUsZr+2GNjnCSSY5LpsjlnqHg81liVbi1BJSAMdfNlw5RVbNO51utqEZkPPj/9Le
         SYl/SE4zMIZHuuzepLgBJO2JS4thvXupSNyWIrky9ydace4qu7O0SGDlCdoZGMwfyrrB
         bTEA==
X-Gm-Message-State: APjAAAXbF8TX5JDrVMLmyMgYe7uL349hT9IV7sB1AHU/ivTEFgmT5VAV
        55/wJBEyUHJ0Q88jk4XpDFdv0QBrN7g=
X-Google-Smtp-Source: APXvYqw2tKcpaTG4RbA5+4VSzIb3zCc/yvQJp5kJ5ofm5jLgOtRUXM7ql3rrieiHTW1FrsmGBN5D3w==
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr865378wme.96.1569463991342;
        Wed, 25 Sep 2019 19:13:11 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:13:10 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 10/16] zuf: symlink
Date:   Thu, 26 Sep 2019 05:07:19 +0300
Message-Id: <20190926020725.19601-11-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The symlink support is all hidden within the creation/open
of the inode.

As part of ZUFS_OP_NEW_INODE we also send the requested
content of the symlink for storage.

On an open of an existing symlink the link information
is returned within the zufs_inode structure via a zufs_dpp_t
pointer. (See Documentation about zufs_dpp_t pointers)

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile  |  2 +-
 fs/zuf/_extern.h |  7 +++++
 fs/zuf/inode.c   |  7 +++++
 fs/zuf/namei.c   | 27 ++++++++++++++++++
 fs/zuf/symlink.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 fs/zuf/symlink.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index 2bfed45723e3..04c31b7bb9ff 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,5 +17,5 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
-zuf-y += super.o inode.o directory.o namei.o file.o
+zuf-y += super.o inode.o directory.o namei.o file.o symlink.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index 50887792bf42..95413f65c47f 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -88,6 +88,10 @@ void zuf_set_inode_flags(struct inode *inode, struct zus_inode *zi);
 int zuf_add_dentry(struct inode *dir, struct qstr *str, struct inode *inode);
 int zuf_remove_dentry(struct inode *dir, struct qstr *str, struct inode *inode);
 
+/* symlink.c */
+uint zuf_prepare_symname(struct zufs_ioc_new_inode *ioc_new_inode,
+			const char *symname, ulong len, struct page *pages[2]);
+
 /* t1.c */
 int zuf_pmem_mmap(struct file *file, struct vm_area_struct *vma);
 
@@ -109,4 +113,7 @@ extern const struct inode_operations zuf_special_inode_operations;
 /* dir.c */
 extern const struct file_operations zuf_dir_operations;
 
+/* symlink.c */
+extern const struct inode_operations zuf_symlink_inode_operations;
+
 #endif	/*ndef __ZUF_EXTERN_H__*/
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
index 88cb1937c223..bf3f8b27f918 100644
--- a/fs/zuf/inode.c
+++ b/fs/zuf/inode.c
@@ -83,6 +83,9 @@ static void _set_inode_from_zi(struct inode *inode, struct zus_inode *zi)
 		inode->i_op = &zuf_dir_inode_operations;
 		inode->i_fop = &zuf_dir_operations;
 		break;
+	case S_IFLNK:
+		inode->i_op = &zuf_symlink_inode_operations;
+		break;
 	case S_IFBLK:
 	case S_IFCHR:
 	case S_IFIFO:
@@ -348,6 +351,10 @@ struct inode *zuf_new_inode(struct inode *dir, umode_t mode,
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	    S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		init_special_inode(inode, mode, rdev_or_isize);
+	} else if (symname) {
+		inode->i_size = rdev_or_isize;
+		nump = zuf_prepare_symname(&ioc_new_inode, symname,
+					   rdev_or_isize, pages);
 	}
 
 	err = _set_zi_from_inode(dir, &ioc_new_inode.zi, inode);
diff --git a/fs/zuf/namei.c b/fs/zuf/namei.c
index 299134ca7c07..e78aa04f10d5 100644
--- a/fs/zuf/namei.c
+++ b/fs/zuf/namei.c
@@ -164,6 +164,32 @@ static int zuf_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return 0;
 }
 
+static int zuf_symlink(struct inode *dir, struct dentry *dentry,
+		       const char *symname)
+{
+	struct inode *inode;
+	ulong len;
+
+	zuf_dbg_vfs("[%ld] de->name=%s symname=%s\n",
+			dir->i_ino, dentry->d_name.name, symname);
+
+	len = strlen(symname);
+	if (len + 1 > ZUFS_MAX_SYMLINK)
+		return -ENAMETOOLONG;
+
+	inode = zuf_new_inode(dir, S_IFLNK|S_IRWXUGO, &dentry->d_name,
+			       symname, len, false);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	inode->i_op = &zuf_symlink_inode_operations;
+	inode->i_mapping->a_ops = &zuf_aops;
+
+	_instantiate_unlock(dentry, inode);
+
+	return 0;
+}
+
 static int zuf_link(struct dentry *dest_dentry, struct inode *dir,
 		    struct dentry *dentry)
 {
@@ -385,6 +411,7 @@ const struct inode_operations zuf_dir_inode_operations = {
 	.lookup		= zuf_lookup,
 	.link		= zuf_link,
 	.unlink		= zuf_unlink,
+	.symlink	= zuf_symlink,
 	.mkdir		= zuf_mkdir,
 	.rmdir		= zuf_rmdir,
 	.mknod		= zuf_mknod,
diff --git a/fs/zuf/symlink.c b/fs/zuf/symlink.c
new file mode 100644
index 000000000000..1446bdf60cb9
--- /dev/null
+++ b/fs/zuf/symlink.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Symlink operations
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ *	Sagi Manole <sagim@netapp.com>"
+ */
+
+#include "zuf.h"
+
+/* Can never fail all checks already made before.
+ * Returns: The number of pages stored @pages
+ */
+uint zuf_prepare_symname(struct zufs_ioc_new_inode *ioc_new_inode,
+			 const char *symname, ulong len,
+			 struct page *pages[2])
+{
+	uint nump;
+
+	ioc_new_inode->zi.i_size = cpu_to_le64(len);
+	if (len < sizeof(ioc_new_inode->zi.i_symlink)) {
+		memcpy(&ioc_new_inode->zi.i_symlink, symname, len);
+		return 0;
+	}
+
+	pages[0] = virt_to_page(symname);
+	nump = 1;
+
+	ioc_new_inode->hdr.len = len;
+	ioc_new_inode->hdr.offset = (ulong)symname & (PAGE_SIZE - 1);
+
+	if (PAGE_SIZE < ioc_new_inode->hdr.offset + len) {
+		pages[1] = virt_to_page(symname + PAGE_SIZE);
+		++nump;
+	}
+
+	return nump;
+}
+
+/*
+ * In case of short symlink, we serve it directly from zi; otherwise, read
+ * symlink value directly from pmem using dpp mapping.
+ */
+static const char *zuf_get_link(struct dentry *dentry, struct inode *inode,
+				struct delayed_call *notused)
+{
+	const char *link;
+	struct zuf_inode_info *zii = ZUII(inode);
+
+	if (inode->i_size < sizeof(zii->zi->i_symlink))
+		return zii->zi->i_symlink;
+
+	link = zuf_dpp_t_addr(inode->i_sb, le64_to_cpu(zii->zi->i_sym_dpp));
+	if (!link) {
+		zuf_err("bad symlink: i_sym_dpp=0x%llx\n", zii->zi->i_sym_dpp);
+		return ERR_PTR(-EIO);
+	}
+	return link;
+}
+
+const struct inode_operations zuf_symlink_inode_operations = {
+	.get_link	= zuf_get_link,
+	.update_time	= zuf_update_time,
+	.setattr	= zuf_setattr,
+	.getattr	= zuf_getattr,
+};
-- 
2.21.0

