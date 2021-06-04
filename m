Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3D39BCBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFDQOJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 4 Jun 2021 12:14:09 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:24286 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231289AbhFDQOI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:14:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-t0Dzju7TPcSRjZqzmv1G4Q-1; Fri, 04 Jun 2021 12:12:18 -0400
X-MC-Unique: t0Dzju7TPcSRjZqzmv1G4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E0011007B1A;
        Fri,  4 Jun 2021 16:12:17 +0000 (UTC)
Received: from bahia.lan (ovpn-112-232.ams2.redhat.com [10.36.112.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7DAF648A1;
        Fri,  4 Jun 2021 16:12:15 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 4/7] fuse: Add dedicated filesystem context ops for submounts
Date:   Fri,  4 Jun 2021 18:11:53 +0200
Message-Id: <20210604161156.408496-5-groug@kaod.org>
In-Reply-To: <20210604161156.408496-1-groug@kaod.org>
References: <20210604161156.408496-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The creation of a submount is open-coded in fuse_dentry_automount().
This brings a lot of complexity and we recently had to fix bugs
because we weren't setting SB_BORN or because we were unlocking
sb->s_umount before sb was fully configured. Most of these could
have been avoided by using the mount API instead of open-coding.

Basically, this means coming up with a proper ->get_tree()
implementation for submounts and call vfs_get_tree(), or better
fc_mount().

The creation of the superblock for submounts is quite different from
the root mount. Especially, it doesn't require to allocate a FUSE
filesystem context, nor to parse parameters.

Introduce a dedicated context ops for submounts to make this clear.
This is just a placeholder for now, fuse_get_tree_submount() will
be populated in a subsequent patch.

Only visible change is that we stop allocating/freeing a useless FUSE
filesystem context with submounts.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/fuse_i.h    |  5 +++++
 fs/fuse/inode.c     | 16 ++++++++++++++++
 fs/fuse/virtio_fs.c |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e463e220053..862ad317bc89 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1097,6 +1097,11 @@ int fuse_fill_super_submount(struct super_block *sb,
  */
 bool fuse_mount_remove(struct fuse_mount *fm);
 
+/*
+ * Setup context ops for submounts
+ */
+int fuse_init_fs_context_submount(struct fs_context *fsc);
+
 /*
  * Shut down the connection (possibly sending DESTROY request).
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 393e36b74dc4..fa96a3762ea2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1313,6 +1313,22 @@ int fuse_fill_super_submount(struct super_block *sb,
 	return 0;
 }
 
+static int fuse_get_tree_submount(struct fs_context *fsc)
+{
+	return 0;
+}
+
+static const struct fs_context_operations fuse_context_submount_ops = {
+	.get_tree	= fuse_get_tree_submount,
+};
+
+int fuse_init_fs_context_submount(struct fs_context *fsc)
+{
+	fsc->ops = &fuse_context_submount_ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
+
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
 	struct fuse_dev *fud = NULL;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcb8a02e2d8b..e68467cc765c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1496,6 +1496,9 @@ static int virtio_fs_init_fs_context(struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx;
 
+	if (fsc->purpose == FS_CONTEXT_FOR_SUBMOUNT)
+		return fuse_init_fs_context_submount(fsc);
+
 	ctx = kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
-- 
2.31.1

