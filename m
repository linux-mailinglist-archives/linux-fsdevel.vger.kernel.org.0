Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392213C9BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhGOJda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:33:30 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50683 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234120AbhGOJd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:33:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UfrhSw3_1626341432;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UfrhSw3_1626341432)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Jul 2021 17:30:32 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bo.liu@linux.alibaba.com
Subject: [RFC PATCH 2/3] fuse: Make DAX mount option a tri-state
Date:   Thu, 15 Jul 2021 17:30:30 +0800
Message-Id: <20210715093031.55667-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
References: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We add 'always', 'never', and 'inode' (default). '-o dax' continues to
operate the same which is equivalent to 'always'.

By the time this patch is applied, 'inode' mode is actually equal to
'always' mode, before the per-file DAX flag is introduced in the
following patch.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c       | 13 ++++++++++++-
 fs/fuse/fuse_i.h    | 11 +++++++++--
 fs/fuse/inode.c     |  2 +-
 fs/fuse/virtio_fs.c | 16 ++++++++++++++--
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 97b8bd09baa3..4873d764cb66 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -70,6 +70,9 @@ struct fuse_inode_dax {
 };
 
 struct fuse_conn_dax {
+	/** dax mode: FUSE_DAX_MOUNT_* (always, never or per-file) **/
+	unsigned int mode;
+
 	/* DAX device */
 	struct dax_device *dev;
 
@@ -1288,7 +1291,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	return ret;
 }
 
-int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
+int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
+			struct dax_device *dax_dev)
 {
 	struct fuse_conn_dax *fcd;
 	int err;
@@ -1301,6 +1305,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
 		return -ENOMEM;
 
 	spin_lock_init(&fcd->lock);
+	fcd->mode = mode;
 	fcd->dev = dax_dev;
 	err = fuse_dax_mem_range_init(fcd);
 	if (err) {
@@ -1339,10 +1344,16 @@ static const struct address_space_operations fuse_dax_file_aops  = {
 static bool fuse_should_enable_dax(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned int mode;
 
 	if (!fc->dax)
 		return false;
  
+	mode = fc->dax->mode;
+
+	if (mode == FUSE_DAX_MOUNT_NEVER)
+		return false;
+
 	return true;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 07829ce78695..f29018323845 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -487,6 +487,12 @@ struct fuse_dev {
 	struct list_head entry;
 };
 
+enum {
+	FUSE_DAX_MOUNT_INODE,
+	FUSE_DAX_MOUNT_ALWAYS,
+	FUSE_DAX_MOUNT_NEVER,
+};
+
 struct fuse_fs_context {
 	int fd;
 	unsigned int rootmode;
@@ -503,7 +509,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
-	bool dax:1;
+	unsigned int dax;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -1242,7 +1248,8 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
 int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start, u64 dmap_end);
-int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev);
+int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
+			struct dax_device *dax_dev);
 void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
 void fuse_dax_inode_init(struct inode *inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b9beb39a4a18..f6b46395edb2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1434,7 +1434,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_subtype = ctx->subtype;
 	ctx->subtype = NULL;
 	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
-		err = fuse_dax_conn_alloc(fc, ctx->dax_dev);
+		err = fuse_dax_conn_alloc(fc, ctx->dax, ctx->dax_dev);
 		if (err)
 			goto err;
 	}
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8f52cdaa8445..561f711d1945 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -88,12 +88,21 @@ struct virtio_fs_req_work {
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
+static const struct constant_table dax_param_enums[] = {
+	{"inode",	FUSE_DAX_MOUNT_INODE },
+	{"always",	FUSE_DAX_MOUNT_ALWAYS },
+	{"never",	FUSE_DAX_MOUNT_NEVER },
+	{}
+};
+
 enum {
 	OPT_DAX,
+	OPT_DAX_ENUM,
 };
 
 static const struct fs_parameter_spec virtio_fs_parameters[] = {
 	fsparam_flag("dax", OPT_DAX),
+	fsparam_enum("dax", OPT_DAX_ENUM, dax_param_enums),
 	{}
 };
 
@@ -110,7 +119,10 @@ static int virtio_fs_parse_param(struct fs_context *fc,
 
 	switch (opt) {
 	case OPT_DAX:
-		ctx->dax = 1;
+		ctx->dax = FUSE_DAX_MOUNT_ALWAYS;
+		break;
+	case OPT_DAX_ENUM:
+		ctx->dax = result.uint_32;
 		break;
 	default:
 		return -EINVAL;
@@ -1326,7 +1338,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	/* virtiofs allocates and installs its own fuse devices */
 	ctx->fudptr = NULL;
-	if (ctx->dax) {
+	if (ctx->dax != FUSE_DAX_MOUNT_NEVER) {
 		if (!fs->dax_dev) {
 			err = -EINVAL;
 			pr_err("virtio-fs: dax can't be enabled as filesystem"
-- 
2.27.0

