Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB92FEB0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbhAUNFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731453AbhAUNE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611234207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74r0kloHq1RcabhYwK+wK58+alYDzHyygYLYrG0WVX4=;
        b=QxgSY01YmCxXsSmV46vhzZFonxl/ibN8+aUSHgmt+6Lccp4dE63fDMNBs/6tlZP4/Ysp5B
        PHjeWfJuJVRo43yyS/ya+7HSP9+XvbpMS4uKeXUUyyuFJdXfyMwJGytrZGrHBB14ZhKwW7
        t8a4yO3csBjC2I2oNIkg59CD6YJ842w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-VktK9VlSNYCkkt8eLQoErw-1; Thu, 21 Jan 2021 08:03:24 -0500
X-MC-Unique: VktK9VlSNYCkkt8eLQoErw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F1B10054FF;
        Thu, 21 Jan 2021 13:03:22 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF26A60BF3;
        Thu, 21 Jan 2021 13:03:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] vboxsf: Add vboxsf_[create|release]_sf_handle() helpers
Date:   Thu, 21 Jan 2021 14:03:16 +0100
Message-Id: <20210121130317.146506-4-hdegoede@redhat.com>
In-Reply-To: <20210121130317.146506-1-hdegoede@redhat.com>
References: <20210121130317.146506-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out the code to create / release a struct vboxsf_handle into
2 new helper functions.

This is a preparation patch for adding atomic_open support.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 fs/vboxsf/file.c   | 71 ++++++++++++++++++++++++++++------------------
 fs/vboxsf/vfsmod.h |  7 +++++
 2 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index c4ab5996d97a..864c2fad23be 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -20,17 +20,39 @@ struct vboxsf_handle {
 	struct list_head head;
 };
 
-static int vboxsf_file_open(struct inode *inode, struct file *file)
+struct vboxsf_handle *vboxsf_create_sf_handle(struct inode *inode,
+					      u64 handle, u32 access_flags)
 {
 	struct vboxsf_inode *sf_i = VBOXSF_I(inode);
-	struct shfl_createparms params = {};
 	struct vboxsf_handle *sf_handle;
-	u32 access_flags = 0;
-	int err;
 
 	sf_handle = kmalloc(sizeof(*sf_handle), GFP_KERNEL);
 	if (!sf_handle)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+
+	/* the host may have given us different attr then requested */
+	sf_i->force_restat = 1;
+
+	/* init our handle struct and add it to the inode's handles list */
+	sf_handle->handle = handle;
+	sf_handle->root = VBOXSF_SBI(inode->i_sb)->root;
+	sf_handle->access_flags = access_flags;
+	kref_init(&sf_handle->refcount);
+
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_add(&sf_handle->head, &sf_i->handle_list);
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	return sf_handle;
+}
+
+static int vboxsf_file_open(struct inode *inode, struct file *file)
+{
+	struct vboxsf_sbi *sbi = VBOXSF_SBI(inode->i_sb);
+	struct shfl_createparms params = {};
+	struct vboxsf_handle *sf_handle;
+	u32 access_flags = 0;
+	int err;
 
 	/*
 	 * We check the value of params.handle afterwards to find out if
@@ -83,23 +105,14 @@ static int vboxsf_file_open(struct inode *inode, struct file *file)
 	err = vboxsf_create_at_dentry(file_dentry(file), &params);
 	if (err == 0 && params.handle == SHFL_HANDLE_NIL)
 		err = (params.result == SHFL_FILE_EXISTS) ? -EEXIST : -ENOENT;
-	if (err) {
-		kfree(sf_handle);
+	if (err)
 		return err;
-	}
-
-	/* the host may have given us different attr then requested */
-	sf_i->force_restat = 1;
 
-	/* init our handle struct and add it to the inode's handles list */
-	sf_handle->handle = params.handle;
-	sf_handle->root = VBOXSF_SBI(inode->i_sb)->root;
-	sf_handle->access_flags = access_flags;
-	kref_init(&sf_handle->refcount);
-
-	mutex_lock(&sf_i->handle_list_mutex);
-	list_add(&sf_handle->head, &sf_i->handle_list);
-	mutex_unlock(&sf_i->handle_list_mutex);
+	sf_handle = vboxsf_create_sf_handle(inode, params.handle, access_flags);
+	if (IS_ERR(sf_handle)) {
+		vboxsf_close(sbi->root, params.handle);
+		return PTR_ERR(sf_handle);
+	}
 
 	file->private_data = sf_handle;
 	return 0;
@@ -114,22 +127,26 @@ static void vboxsf_handle_release(struct kref *refcount)
 	kfree(sf_handle);
 }
 
-static int vboxsf_file_release(struct inode *inode, struct file *file)
+void vboxsf_release_sf_handle(struct inode *inode, struct vboxsf_handle *sf_handle)
 {
 	struct vboxsf_inode *sf_i = VBOXSF_I(inode);
-	struct vboxsf_handle *sf_handle = file->private_data;
 
+	mutex_lock(&sf_i->handle_list_mutex);
+	list_del(&sf_handle->head);
+	mutex_unlock(&sf_i->handle_list_mutex);
+
+	kref_put(&sf_handle->refcount, vboxsf_handle_release);
+}
+
+static int vboxsf_file_release(struct inode *inode, struct file *file)
+{
 	/*
 	 * When a file is closed on our (the guest) side, we want any subsequent
 	 * accesses done on the host side to see all changes done from our side.
 	 */
 	filemap_write_and_wait(inode->i_mapping);
 
-	mutex_lock(&sf_i->handle_list_mutex);
-	list_del(&sf_handle->head);
-	mutex_unlock(&sf_i->handle_list_mutex);
-
-	kref_put(&sf_handle->refcount, vboxsf_handle_release);
+	vboxsf_release_sf_handle(inode, file->private_data);
 	return 0;
 }
 
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 18f95b00fc33..a4050b166c99 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -18,6 +18,8 @@
 #define VBOXSF_SBI(sb)	((struct vboxsf_sbi *)(sb)->s_fs_info)
 #define VBOXSF_I(i)	container_of(i, struct vboxsf_inode, vfs_inode)
 
+struct vboxsf_handle;
+
 struct vboxsf_options {
 	unsigned long ttl;
 	kuid_t uid;
@@ -80,6 +82,11 @@ extern const struct file_operations vboxsf_reg_fops;
 extern const struct address_space_operations vboxsf_reg_aops;
 extern const struct dentry_operations vboxsf_dentry_ops;
 
+/* from file.c */
+struct vboxsf_handle *vboxsf_create_sf_handle(struct inode *inode,
+					      u64 handle, u32 access_flags);
+void vboxsf_release_sf_handle(struct inode *inode, struct vboxsf_handle *sf_handle);
+
 /* from utils.c */
 struct inode *vboxsf_new_inode(struct super_block *sb);
 void vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
-- 
2.28.0

