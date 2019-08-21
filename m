Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C391E98216
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfHUR6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:58:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbfHUR5i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77687308402D;
        Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAAB360600;
        Wed, 21 Aug 2019 17:57:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9908D223D02; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 06/19] fuse, dax: add fuse_conn->dax_dev field
Date:   Wed, 21 Aug 2019 13:57:07 -0400
Message-Id: <20190821175720.25901-7-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

A struct dax_device instance is a prerequisite for the DAX filesystem
APIs.  Let virtio_fs associate a dax_device with a fuse_conn.  Classic
FUSE and CUSE set the pointer to NULL, disabling DAX.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/cuse.c      | 3 ++-
 fs/fuse/fuse_i.h    | 9 ++++++++-
 fs/fuse/inode.c     | 9 ++++++---
 fs/fuse/virtio_fs.c | 5 +++--
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 04727540bdbb..0f9e3c93b056 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -504,7 +504,8 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * Limit the cuse channel to requests that can
 	 * be represented in file->f_cred->user_ns.
 	 */
-	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
+	fuse_conn_init(&cc->fc, file->f_cred->user_ns, NULL, &fuse_dev_fiq_ops,
+					NULL);
 
 	fud = fuse_dev_alloc_install(&cc->fc);
 	if (!fud) {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 25a6da6ee8c3..ecd9dbc3312e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -77,6 +77,9 @@ struct fuse_mount_data {
 	unsigned max_read;
 	unsigned blksize;
 
+	/* DAX device, may be NULL */
+	struct dax_device *dax_dev;
+
 	/* fuse input queue operations */
 	const struct fuse_iqueue_ops *fiq_ops;
 
@@ -831,6 +834,9 @@ struct fuse_conn {
 
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** DAX device, non-NULL if DAX is supported */
+	struct dax_device *dax_dev;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
@@ -1061,7 +1067,8 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
  * Initialize fuse_conn
  */
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
+			struct dax_device *dax_dev,
+			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
 
 /**
  * Release reference to fuse_conn
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 16bcf0f95979..6d9258a4091a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -591,7 +591,8 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 }
 
 void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
+			struct dax_device *dax_dev,
+			const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -616,6 +617,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	atomic64_set(&fc->attr_version, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
+	fc->dax_dev = dax_dev;
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 }
@@ -1132,8 +1134,8 @@ int fuse_fill_super_common(struct super_block *sb,
 		err = -ENOMEM;
 		if (!fc)
 			goto err;
-		fuse_conn_init(fc, sb->s_user_ns, mount_data->fiq_ops,
-			       mount_data->fiq_priv);
+		fuse_conn_init(fc, sb->s_user_ns, mount_data->dax_dev,
+			       mount_data->fiq_ops, mount_data->fiq_priv);
 		fc->release = fuse_free_conn;
 	}
 
@@ -1237,6 +1239,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 		goto err_fput;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
+	d.dax_dev = NULL;
 	d.fiq_ops = &fuse_dev_fiq_ops;
 	d.fiq_priv = NULL;
 	d.fudptr = &file->private_data;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ce1de9acde84..706b27e0502a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -986,8 +986,9 @@ static struct dentry *virtio_fs_mount(struct file_system_type *fs_type,
 	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
 	if (!fc)
 		return ERR_PTR(-ENOMEM);
-	fuse_conn_init(fc, get_user_ns(current_user_ns()), &virtio_fs_fiq_ops,
-		       fs);
+	d.dax_dev = NULL;
+	fuse_conn_init(fc, get_user_ns(current_user_ns()), d.dax_dev,
+		       &virtio_fs_fiq_ops, fs);
 	fc->release = fuse_free_conn;
 
 	s = sget(fs_type, virtio_fs_test_super, virtio_fs_set_super, flags, fc);
-- 
2.20.1

