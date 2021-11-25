Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A145D51B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 08:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351325AbhKYHKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 02:10:45 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42887 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352564AbhKYHIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:08:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyESXW1_1637823932;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UyESXW1_1637823932)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Nov 2021 15:05:32 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: [PATCH v8 2/7] fuse: make DAX mount option a tri-state
Date:   Thu, 25 Nov 2021 15:05:25 +0800
Message-Id: <20211125070530.79602-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We add 'always', 'never', and 'inode' (default). '-o dax' continues to
operate the same which is equivalent to 'always'.

The following behavior is consistent with that on ext4/xfs:
- The default behavior (when neither '-o dax' nor
  '-o dax=always|never|inode' option is specified) is equal to 'inode'
  mode, while 'dax=inode' won't be printed among the mount option list.
- The 'inode' mode is only advisory. It will silently fallback to
  'never' mode if fuse server doesn't support that.

Also noted that by the time of this commit, 'inode' mode is actually
equal to 'always' mode, before the per inode DAX flag is introduced in
the following patch.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c       | 13 ++++++++++++-
 fs/fuse/fuse_i.h    | 20 ++++++++++++++++++--
 fs/fuse/inode.c     | 10 +++++++---
 fs/fuse/virtio_fs.c | 18 +++++++++++++++---
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 4c48a57632bd..b9a031a82934 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1281,11 +1281,14 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
 	return ret;
 }
 
-int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
+int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode dax_mode,
+			struct dax_device *dax_dev)
 {
 	struct fuse_conn_dax *fcd;
 	int err;
 
+	fc->dax_mode = dax_mode;
+
 	if (!dax_dev)
 		return 0;
 
@@ -1332,7 +1335,15 @@ static const struct address_space_operations fuse_dax_file_aops  = {
 static bool fuse_should_enable_dax(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	enum fuse_dax_mode dax_mode = fc->dax_mode;
+
+	if (dax_mode == FUSE_DAX_NEVER)
+		return false;
 
+	/*
+	 * fc->dax may be NULL in 'inode' mode when filesystem device doesn't
+	 * support DAX, in which case it will silently fallback to 'never' mode.
+	 */
 	if (!fc->dax)
 		return false;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 198637b41e19..19ded93cfc49 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -480,6 +480,18 @@ struct fuse_dev {
 	struct list_head entry;
 };
 
+enum fuse_dax_mode {
+	FUSE_DAX_INODE_DEFAULT,	/* default */
+	FUSE_DAX_ALWAYS,	/* "-o dax=always" */
+	FUSE_DAX_NEVER,		/* "-o dax=never" */
+	FUSE_DAX_INODE_USER,	/* "-o dax=inode" */
+};
+
+static inline bool fuse_is_inode_dax_mode(enum fuse_dax_mode mode)
+{
+	return mode == FUSE_DAX_INODE_DEFAULT || mode == FUSE_DAX_INODE_USER;
+}
+
 struct fuse_fs_context {
 	int fd;
 	struct file *file;
@@ -497,7 +509,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
-	bool dax:1;
+	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -802,6 +814,9 @@ struct fuse_conn {
 	struct list_head devices;
 
 #ifdef CONFIG_FUSE_DAX
+	/* Dax mode */
+	enum fuse_dax_mode dax_mode;
+
 	/* Dax specific conn data, non-NULL if DAX is enabled */
 	struct fuse_conn_dax *dax;
 #endif
@@ -1269,7 +1284,8 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
 int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start, u64 dmap_end);
-int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev);
+int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode mode,
+			struct dax_device *dax_dev);
 void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
 void fuse_dax_inode_init(struct inode *inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8b89e3ba7df3..4a41e6a73f3f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -767,8 +767,12 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
 	}
 #ifdef CONFIG_FUSE_DAX
-	if (fc->dax)
-		seq_puts(m, ",dax");
+	if (fc->dax_mode == FUSE_DAX_ALWAYS)
+		seq_puts(m, ",dax=always");
+	else if (fc->dax_mode == FUSE_DAX_NEVER)
+		seq_puts(m, ",dax=never");
+	else if (fc->dax_mode == FUSE_DAX_INODE_USER)
+		seq_puts(m, ",dax=inode");
 #endif
 
 	return 0;
@@ -1514,7 +1518,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_subtype = ctx->subtype;
 	ctx->subtype = NULL;
 	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
-		err = fuse_dax_conn_alloc(fc, ctx->dax_dev);
+		err = fuse_dax_conn_alloc(fc, ctx->dax_mode, ctx->dax_dev);
 		if (err)
 			goto err;
 	}
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4cfa4bc1f579..e54dc069587d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -88,12 +88,21 @@ struct virtio_fs_req_work {
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight);
 
+static const struct constant_table dax_param_enums[] = {
+	{"always",	FUSE_DAX_ALWAYS },
+	{"never",	FUSE_DAX_NEVER },
+	{"inode",	FUSE_DAX_INODE_USER },
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
 
@@ -110,7 +119,10 @@ static int virtio_fs_parse_param(struct fs_context *fsc,
 
 	switch (opt) {
 	case OPT_DAX:
-		ctx->dax = 1;
+		ctx->dax_mode = FUSE_DAX_ALWAYS;
+		break;
+	case OPT_DAX_ENUM:
+		ctx->dax_mode = result.uint_32;
 		break;
 	default:
 		return -EINVAL;
@@ -1326,8 +1338,8 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 
 	/* virtiofs allocates and installs its own fuse devices */
 	ctx->fudptr = NULL;
-	if (ctx->dax) {
-		if (!fs->dax_dev) {
+	if (ctx->dax_mode != FUSE_DAX_NEVER) {
+		if (ctx->dax_mode == FUSE_DAX_ALWAYS && !fs->dax_dev) {
 			err = -EINVAL;
 			pr_err("virtio-fs: dax can't be enabled as filesystem"
 			       " device does not support it.\n");
-- 
2.27.0

