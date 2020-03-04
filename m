Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD01795FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbgCDQ7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730076AbgCDQ7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84soLbFVJt5QLbzQgNHPkCJ8pYYVyUy8Ln63dw+LzP0=;
        b=VOX80ZO3KziBse8M24epnlO5M9F3otih+ktBgoGqa8YeNXxagpLVs84H0uj/dmRKSjE3RI
        lFHajmWCB+SxjqJObCaVHH9YfJqN5wKp1yDOMTUQMWjKT/y3KDzEWfxxjy4ujMApS9Y66d
        v/gbzX37m6IF8YGAmkSs8frkXoKfgXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-HKxcbV3sMoWZRo33fsAcGw-1; Wed, 04 Mar 2020 11:59:21 -0500
X-MC-Unique: HKxcbV3sMoWZRo33fsAcGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56D8E18C35A0;
        Wed,  4 Mar 2020 16:59:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD12719C4F;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 58FED2257DA; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 08/20] fuse,virtiofs: Add a mount option to enable dax
Date:   Wed,  4 Mar 2020 11:58:33 -0500
Message-Id: <20200304165845.3081-9-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
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
index 2cebdf6dcfd8..1fe5065a2902 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -483,10 +483,14 @@ struct fuse_fs_context {
 	bool destroy:1;
 	bool no_control:1;
 	bool no_force_umount:1;
+	bool dax:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
=20
+	/* DAX device, may be NULL */
+	struct dax_device *dax_dev;
+
 	/* fuse_dev pointer to fill in, should contain NULL on entry */
 	void **fudptr;
 };
@@ -758,6 +762,9 @@ struct fuse_conn {
=20
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** DAX device, non-NULL if DAX is supported */
+	struct dax_device *dax_dev;
 };
=20
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *=
sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f160a3d47b63..84295fac4ff3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -569,6 +569,8 @@ static int fuse_show_options(struct seq_file *m, stru=
ct dentry *root)
 		seq_printf(m, ",max_read=3D%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize !=3D FUSE_DEFAULT_BLKSIZE)
 		seq_printf(m, ",blksize=3D%lu", sb->s_blocksize);
+	if (fc->dax_dev)
+		seq_printf(m, ",dax");
 	return 0;
 }
=20
@@ -1185,6 +1187,7 @@ int fuse_fill_super_common(struct super_block *sb, =
struct fuse_fs_context *ctx)
 	fc->destroy =3D ctx->destroy;
 	fc->no_control =3D ctx->no_control;
 	fc->no_force_umount =3D ctx->no_force_umount;
+	fc->dax_dev =3D ctx->dax_dev;
=20
 	err =3D -ENOMEM;
 	root =3D fuse_get_root_inode(sb, ctx->rootmode);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 3f786a15b0d9..62cdd6817b5b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -10,6 +10,7 @@
 #include <linux/virtio_fs.h>
 #include <linux/delay.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/highmem.h>
 #include "fuse_i.h"
=20
@@ -65,6 +66,45 @@ struct virtio_fs_forget {
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
=20
+enum {
+	OPT_DAX,
+};
+
+static const struct fs_parameter_spec virtio_fs_parameters[] =3D {
+	fsparam_flag	("dax",		OPT_DAX),
+	{}
+};
+
+static int virtio_fs_parse_param(struct fs_context *fc,
+				 struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct fuse_fs_context *ctx =3D fc->fs_private;
+	int opt;
+
+	opt =3D fs_parse(fc, virtio_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch(opt) {
+	case OPT_DAX:
+		ctx->dax =3D 1;
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
+	struct fuse_fs_context *ctx =3D fc->fs_private;
+
+	if (ctx)
+		kfree(ctx);
+}
+
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 {
 	struct virtio_fs *fs =3D vq->vdev->priv;
@@ -1045,23 +1085,27 @@ static const struct fuse_iqueue_ops virtio_fs_fiq=
_ops =3D {
 	.release			=3D virtio_fs_fiq_release,
 };
=20
-static int virtio_fs_fill_super(struct super_block *sb)
+static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ct=
x)
+{
+	ctx->rootmode =3D S_IFDIR;
+	ctx->default_permissions =3D 1;
+	ctx->allow_other =3D 1;
+	ctx->max_read =3D UINT_MAX;
+	ctx->blksize =3D 512;
+	ctx->destroy =3D true;
+	ctx->no_control =3D true;
+	ctx->no_force_umount =3D true;
+}
+
+static int virtio_fs_fill_super(struct super_block *sb, struct fs_contex=
t *fsc)
 {
 	struct fuse_conn *fc =3D get_fuse_conn_super(sb);
 	struct virtio_fs *fs =3D fc->iq.priv;
+	struct fuse_fs_context *ctx =3D fsc->fs_private;
 	unsigned int i;
 	int err;
-	struct fuse_fs_context ctx =3D {
-		.rootmode =3D S_IFDIR,
-		.default_permissions =3D 1,
-		.allow_other =3D 1,
-		.max_read =3D UINT_MAX,
-		.blksize =3D 512,
-		.destroy =3D true,
-		.no_control =3D true,
-		.no_force_umount =3D true,
-	};
=20
+	virtio_fs_ctx_set_defaults(ctx);
 	mutex_lock(&virtio_fs_mutex);
=20
 	/* After holding mutex, make sure virtiofs device is still there.
@@ -1084,8 +1128,10 @@ static int virtio_fs_fill_super(struct super_block=
 *sb)
 			goto err_free_fuse_devs;
 	}
=20
-	ctx.fudptr =3D (void **)&fs->vqs[VQ_REQUEST].fud;
-	err =3D fuse_fill_super_common(sb, &ctx);
+	ctx->fudptr =3D (void **)&fs->vqs[VQ_REQUEST].fud;
+	if (ctx->dax)
+		ctx->dax_dev =3D fs->dax_dev;
+	err =3D fuse_fill_super_common(sb, ctx);
 	if (err < 0)
 		goto err_free_fuse_devs;
=20
@@ -1200,7 +1246,7 @@ static int virtio_fs_get_tree(struct fs_context *fs=
c)
 		return PTR_ERR(sb);
=20
 	if (!sb->s_root) {
-		err =3D virtio_fs_fill_super(sb);
+		err =3D virtio_fs_fill_super(sb, fsc);
 		if (err) {
 			deactivate_locked_super(sb);
 			return err;
@@ -1215,11 +1261,19 @@ static int virtio_fs_get_tree(struct fs_context *=
fsc)
 }
=20
 static const struct fs_context_operations virtio_fs_context_ops =3D {
+	.free		=3D virtio_fs_free_fc,
+	.parse_param	=3D virtio_fs_parse_param,
 	.get_tree	=3D virtio_fs_get_tree,
 };
=20
 static int virtio_fs_init_fs_context(struct fs_context *fsc)
 {
+	struct fuse_fs_context *ctx;
+
+	ctx =3D kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fsc->fs_private =3D ctx;
 	fsc->ops =3D &virtio_fs_context_ops;
 	return 0;
 }
--=20
2.20.1

