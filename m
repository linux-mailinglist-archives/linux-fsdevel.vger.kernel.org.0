Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5494023F35B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgHGTzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:55:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgHGTzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUr6qXL+Ktb0A3a5N8RfttOYgtSgy+JNrWeUmkYSIHw=;
        b=dxyQECwePp7SlaKV/A9jJ2RkZN/lxr633Zu8kKwcqo2QpaoLomrsWs75WzPw7lWy/BdYZe
        UH7rsXbjtwLxiT7V85pi00QumFnIxNe+W0VlkBG9VVZTIw7cX1v5aJ8wWAeeNXzeDnSPaV
        EmeJ1eM1Gno0BaFuELSlg6YeS/6z2ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-65PRtwYVMeeCwkz0KDPIzQ-1; Fri, 07 Aug 2020 15:55:46 -0400
X-MC-Unique: 65PRtwYVMeeCwkz0KDPIzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2B1D1DE1;
        Fri,  7 Aug 2020 19:55:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ED0D2DE77;
        Fri,  7 Aug 2020 19:55:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D3C4C222E4D; Fri,  7 Aug 2020 15:55:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 08/20] fuse,virtiofs: Add a mount option to enable dax
Date:   Fri,  7 Aug 2020 15:55:14 -0400
Message-Id: <20200807195526.426056-9-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a mount option to allow using dax with virtio_fs.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    |  7 ++++
 fs/fuse/inode.c     |  3 ++
 fs/fuse/virtio_fs.c | 82 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index cf5e675100ec..04fdd7c41bd1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -486,10 +486,14 @@ struct fuse_fs_context {
 	bool destroy:1;
 	bool no_control:1;
 	bool no_force_umount:1;
+	bool dax:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
 
+	/* DAX device, may be NULL */
+	struct dax_device *dax_dev;
+
 	/* fuse_dev pointer to fill in, should contain NULL on entry */
 	void **fudptr;
 };
@@ -761,6 +765,9 @@ struct fuse_conn {
 
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** DAX device, non-NULL if DAX is supported */
+	struct dax_device *dax_dev;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2ac5713c4c32..beac337ccc10 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -589,6 +589,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 		seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+	if (fc->dax_dev)
+		seq_printf(m, ",dax");
 	return 0;
 }
 
@@ -1207,6 +1209,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	fc->dax_dev = ctx->dax_dev;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index afddae8ee2ec..add31794ca1a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -10,6 +10,7 @@
 #include <linux/virtio_fs.h>
 #include <linux/delay.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/highmem.h>
 #include "fuse_i.h"
 
@@ -71,6 +72,45 @@ struct virtio_fs_req_work {
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
+enum {
+	OPT_DAX,
+};
+
+static const struct fs_parameter_spec virtio_fs_parameters[] = {
+	fsparam_flag	("dax",		OPT_DAX),
+	{}
+};
+
+static int virtio_fs_parse_param(struct fs_context *fc,
+				 struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct fuse_fs_context *ctx = fc->fs_private;
+	int opt;
+
+	opt = fs_parse(fc, virtio_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch(opt) {
+	case OPT_DAX:
+		ctx->dax = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void virtio_fs_free_fc(struct fs_context *fc)
+{
+	struct fuse_fs_context *ctx = fc->fs_private;
+
+	if (ctx)
+		kfree(ctx);
+}
+
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 {
 	struct virtio_fs *fs = vq->vdev->priv;
@@ -1081,23 +1121,27 @@ static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.release			= virtio_fs_fiq_release,
 };
 
-static int virtio_fs_fill_super(struct super_block *sb)
+static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
+{
+	ctx->rootmode = S_IFDIR;
+	ctx->default_permissions = 1;
+	ctx->allow_other = 1;
+	ctx->max_read = UINT_MAX;
+	ctx->blksize = 512;
+	ctx->destroy = true;
+	ctx->no_control = true;
+	ctx->no_force_umount = true;
+}
+
+static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 	struct virtio_fs *fs = fc->iq.priv;
+	struct fuse_fs_context *ctx = fsc->fs_private;
 	unsigned int i;
 	int err;
-	struct fuse_fs_context ctx = {
-		.rootmode = S_IFDIR,
-		.default_permissions = 1,
-		.allow_other = 1,
-		.max_read = UINT_MAX,
-		.blksize = 512,
-		.destroy = true,
-		.no_control = true,
-		.no_force_umount = true,
-	};
 
+	virtio_fs_ctx_set_defaults(ctx);
 	mutex_lock(&virtio_fs_mutex);
 
 	/* After holding mutex, make sure virtiofs device is still there.
@@ -1121,8 +1165,10 @@ static int virtio_fs_fill_super(struct super_block *sb)
 	}
 
 	/* virtiofs allocates and installs its own fuse devices */
-	ctx.fudptr = NULL;
-	err = fuse_fill_super_common(sb, &ctx);
+	ctx->fudptr = NULL;
+	if (ctx->dax)
+		ctx->dax_dev = fs->dax_dev;
+	err = fuse_fill_super_common(sb, ctx);
 	if (err < 0)
 		goto err_free_fuse_devs;
 
@@ -1233,7 +1279,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 		return PTR_ERR(sb);
 
 	if (!sb->s_root) {
-		err = virtio_fs_fill_super(sb);
+		err = virtio_fs_fill_super(sb, fsc);
 		if (err) {
 			deactivate_locked_super(sb);
 			return err;
@@ -1248,11 +1294,19 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 }
 
 static const struct fs_context_operations virtio_fs_context_ops = {
+	.free		= virtio_fs_free_fc,
+	.parse_param	= virtio_fs_parse_param,
 	.get_tree	= virtio_fs_get_tree,
 };
 
 static int virtio_fs_init_fs_context(struct fs_context *fsc)
 {
+	struct fuse_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fsc->fs_private = ctx;
 	fsc->ops = &virtio_fs_context_ops;
 	return 0;
 }
-- 
2.25.4

