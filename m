Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EAC43A4F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhJYUuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233343AbhJYUuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635194861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+shCfiwDIxREhpU9yJITTWiE4HzHuG6QCUx+tDPuJZc=;
        b=KjuvPvegiJdrTmmOXuNg/h+FzZIoXiLfWd6YNMUvdiOSFE0Zj1BfibsTx+YPodpSWWSTuu
        PUV8ZSQRXWzAQ/blNkAzmT4wYO5lLt29+jZOf1uObxt98PUfdBhUmBHf2gkNgfoCSGR9eq
        z5124sLOIvQtiN5zIckYBvt/OlWi5gE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-xVMkyi4_PoOC2neMvxRNFQ-1; Mon, 25 Oct 2021 16:47:38 -0400
X-MC-Unique: xVMkyi4_PoOC2neMvxRNFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F6761054F90;
        Mon, 25 Oct 2021 20:47:37 +0000 (UTC)
Received: from iangelak.redhat.com (unknown [10.22.32.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1660E60CA1;
        Mon, 25 Oct 2021 20:47:35 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>
Subject: [RFC PATCH 6/7] FUSE,Fsnotify: Add the fuse_fsnotify_event inode operation
Date:   Mon, 25 Oct 2021 16:46:33 -0400
Message-Id: <20211025204634.2517-7-iangelak@redhat.com>
In-Reply-To: <20211025204634.2517-1-iangelak@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To avoid duplicate events we need to "suppress" the local events generated
by the guest kernel for FUSE inodes. To achieve this we introduce a new
inode operation "fuse_fsnotify_event". Any VFS operation on a FUSE inode
that calls the fsnotify subsystem will call this function.

Specifically, the new inode operation "fuse_fsnotify_event" is called by
the "fsnotify" wrapper function in fsnotify.c, if the inode is a FUSE
inode. In turn "fuse_fsnotify_event" will check if the remote inotify is
enabled and if yes the event will be dropped, since the local inotify
events should be "suppressed". If the remote inotify is not enabled the
event will go through as expected.

In the case where the remote inotify is enabled, FUSE will directly call
"__fsnotify" to send the remote events to user space and not the "fsnotify"
wrapper.

Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/dir.c      | 27 +++++++++++++++++++++++++++
 include/linux/fs.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f666aafc8d3f..d36f85bd4dda 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1831,6 +1831,30 @@ static int fuse_fsnotify_update_mark(struct inode *inode, uint32_t action,
 	return fuse_fsnotify_send_request(inode, mask, action, group);
 }
 
+static int fuse_fsnotify_event(__u32 mask, const void *data, int data_type,
+			       struct inode *dir, const struct qstr *file_name,
+			       struct inode *inode, u32 cookie)
+{
+	struct fuse_mount *fm = NULL;
+
+	if (inode != NULL)
+		fm = get_fuse_mount(inode);
+	else
+		fm = get_fuse_mount(dir);
+
+	/* Remote inotify supported. Do nothing */
+	if (!(fm->fc->no_fsnotify)) {
+		return 0;
+	/*
+	 * Remote inotify not supported. Call the __fsnotify function
+	 * directly
+	 */
+	} else {
+		return __fsnotify(mask, data, data_type, dir, file_name,
+				  inode, cookie);
+	}
+}
+
 static const struct inode_operations fuse_dir_inode_operations = {
 	.lookup		= fuse_lookup,
 	.mkdir		= fuse_mkdir,
@@ -1851,6 +1875,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
 	.fsnotify_update = fuse_fsnotify_update_mark,
+	.fsnotify_event = fuse_fsnotify_event,
 };
 
 static const struct file_operations fuse_dir_operations = {
@@ -1874,6 +1899,7 @@ static const struct inode_operations fuse_common_inode_operations = {
 	.fileattr_get	= fuse_fileattr_get,
 	.fileattr_set	= fuse_fileattr_set,
 	.fsnotify_update = fuse_fsnotify_update_mark,
+	.fsnotify_event = fuse_fsnotify_event,
 };
 
 static const struct inode_operations fuse_symlink_inode_operations = {
@@ -1882,6 +1908,7 @@ static const struct inode_operations fuse_symlink_inode_operations = {
 	.getattr	= fuse_getattr,
 	.listxattr	= fuse_listxattr,
 	.fsnotify_update = fuse_fsnotify_update_mark,
+	.fsnotify_event = fuse_fsnotify_event,
 };
 
 void fuse_init_common(struct inode *inode)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 86bcc44e3ab8..ed6b62e2131a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2151,6 +2151,9 @@ struct inode_operations {
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	int (*fsnotify_update)(struct inode *inode, uint32_t action,
 			       uint64_t group, uint32_t mask);
+	int (*fsnotify_event)(__u32 mask, const void *data, int data_type,
+			      struct inode *dir, const struct qstr *file_name,
+			      struct inode *inode, u32 cookie);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
-- 
2.33.0

