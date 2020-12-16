Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC92DC99C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 00:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgLPXd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 18:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730832AbgLPXdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608161546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/j8AnznhuFvsuzt8LMRV9SccvBVsiOm87kWl69oQMuI=;
        b=i8Au55S5LJNPUF3gS+SQ7km8d25Y9d3k7GLUG5DOirbXsrpdERn8dvMJf9NI27Q6V/8MZo
        DIuVFFcbOlmqI1WsNTna8ecSzNR+WrCwofabsa3itmHf/tG7khbaANzJbhKUe1L1EactAJ
        EjOQIIHnMLDz2NKSHzXC+33rxhF7iEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-BhMMAtBVMx6ndoGkaANqvA-1; Wed, 16 Dec 2020 18:32:22 -0500
X-MC-Unique: BhMMAtBVMx6ndoGkaANqvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2394EBBEE0;
        Wed, 16 Dec 2020 23:32:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-114.rdu2.redhat.com [10.10.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F11875D9CD;
        Wed, 16 Dec 2020 23:32:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7B769223D99; Wed, 16 Dec 2020 18:32:19 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     jlayton@kernel.org, vgoyal@redhat.com, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk
Subject: [PATCH 2/3] overlayfs: Implement f_op->syncfs() call
Date:   Wed, 16 Dec 2020 18:31:48 -0500
Message-Id: <20201216233149.39025-3-vgoyal@redhat.com>
In-Reply-To: <20201216233149.39025-1-vgoyal@redhat.com>
References: <20201216233149.39025-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide an implementation for ->syncfs(). Now if there is an error
returned by sync_filesystem(upper_sb), it will be visible to user
space. Currently in ovl_sync_fs() path, this error is ignored by VFS.

A later patch also adds logic to detect writeback error.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/overlayfs/file.c      |  1 +
 fs/overlayfs/overlayfs.h |  3 +++
 fs/overlayfs/readdir.c   |  1 +
 fs/overlayfs/super.c     | 30 ++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..affc1ba63202 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -806,6 +806,7 @@ const struct file_operations ovl_file_operations = {
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
+	.syncfs			= ovl_syncfs,
 };
 
 int __init ovl_aio_request_cache_init(void)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..1efb13800755 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -520,3 +520,6 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 
 /* export.c */
 extern const struct export_operations ovl_export_operations;
+
+/* super.c */
+int ovl_syncfs(struct file *file);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 01620ebae1bd..e89b450c8f8f 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -975,6 +975,7 @@ const struct file_operations ovl_dir_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ovl_compat_ioctl,
 #endif
+	.syncfs		= ovl_syncfs,
 };
 
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..b4d92e6fa5ce 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -286,6 +286,36 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	return ret;
 }
 
+int ovl_syncfs(struct file *file)
+{
+	struct super_block *sb = file->f_path.dentry->d_sb;
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct super_block *upper_sb;
+	int ret;
+
+	ret = 0;
+	down_read(&sb->s_umount);
+	if (sb_rdonly(sb))
+		goto out;
+
+	if (!ovl_upper_mnt(ofs))
+		goto out;
+
+	if (!ovl_should_sync(ofs))
+		goto out;
+
+	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
+
+	down_read(&upper_sb->s_umount);
+	ret = sync_filesystem(upper_sb);
+	up_read(&upper_sb->s_umount);
+
+
+out:
+	up_read(&sb->s_umount);
+	return ret;
+}
+
 /**
  * ovl_statfs
  * @sb: The overlayfs super block
-- 
2.25.4

