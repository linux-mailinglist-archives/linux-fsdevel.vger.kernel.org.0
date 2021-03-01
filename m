Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3E328C25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 19:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhCASqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 13:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240509AbhCASnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614624113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uJZBd2coTEvgErv9GqyxzXj5KMJORFQysjj0VXqj0Y=;
        b=Vpy1hBiGh2vrYV38NWv3HgIMPneZ1KxN89qR2YNpYnLGKkii9npEvy8gVgLKSOqLs3FsWC
        uDzw81+d/w6Vj33i0DECgsZpds+icSgP9kG8uzEulcwk64mD3xou5WW+93k+tNRQ96gfuj
        rTnMOuGx/bYeZRDMYW9rbubPbnCiIlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-FrCf8jzdOZyKUM-4QGYj_Q-1; Mon, 01 Mar 2021 13:41:51 -0500
X-MC-Unique: FrCf8jzdOZyKUM-4QGYj_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B621874980;
        Mon,  1 Mar 2021 18:41:50 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-84.ams2.redhat.com [10.36.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72ACE1A26A;
        Mon,  1 Mar 2021 18:41:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH resend 3/4] vboxsf: Add vboxsf_[create|release]_sf_handle() helpers
Date:   Mon,  1 Mar 2021 19:41:42 +0100
Message-Id: <20210301184143.29878-4-hdegoede@redhat.com>
In-Reply-To: <20210301184143.29878-1-hdegoede@redhat.com>
References: <20210301184143.29878-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 760524e78c88..d47e2d411bbd 100644
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
2.30.1

