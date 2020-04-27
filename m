Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819A81BABE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgD0SEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:04:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49875 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgD0SEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588010646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zIEEdDuKiEvsA5sW9rg5poQ5Z9NyQI0sWoz0AtSctXc=;
        b=IIpHjiYMbT5sewRy6FuUuYhdoebhDUC49Y+CaOnXEP5y15pGAPKUWL1wOJLwAyQw9BTwLE
        lZdB0C55KMXFCR5J65ey63XVj4jBpxwrOI4BrZfltZ/xiLTRHn4E0IV/rhQSDV3xPHqSNe
        1ZdFVBVYTTX7BdmZQEZFr44iVtT/ceI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345--CUiw2gWMVaxLJe4ryry1Q-1; Mon, 27 Apr 2020 14:04:01 -0400
X-MC-Unique: -CUiw2gWMVaxLJe4ryry1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1B6A835B41;
        Mon, 27 Apr 2020 18:04:00 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B64B460CD3;
        Mon, 27 Apr 2020 18:03:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 310AA22036A; Mon, 27 Apr 2020 14:03:54 -0400 (EDT)
Date:   Mon, 27 Apr 2020 14:03:54 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chirantan Ekbote <chirantan@chromium.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] fuse, virtiofs: Do not alloc/install fuse device in
 fuse_fill_super_common()
Message-ID: <20200427180354.GD146096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As of now fuse_fill_super_common() allocates and installs one fuse device.
Filesystems like virtiofs can have more than one filesystem queues and
can have one fuse device per queue. Given, fuse_fill_super_common() only
handles one device, virtiofs allocates and installes fuse devices for
all queues except one.

This makes logic little twisted and hard to understand. It probably
is better to not do any device allocation/installation in
fuse_fill_super_common() and let caller take care of it instead.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h    |  3 ---
 fs/fuse/inode.c     | 19 ++++++++++++-------
 fs/fuse/virtio_fs.c |  9 +--------
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ca344bf71404..df0a62f963a8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -485,9 +485,6 @@ struct fuse_fs_context {
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
-
-	/* fuse_dev pointer to fill in, should contain NULL on entry */
-	void **fudptr;
 };
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 95d712d44ca1..135e8e9a80d8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1191,16 +1191,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (*ctx->fudptr)
-		goto err_unlock;
-
 	err = fuse_ctl_add_conn(fc);
 	if (err)
 		goto err_unlock;
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	*ctx->fudptr = fud;
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
@@ -1220,6 +1216,7 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	struct file *file;
 	int err;
 	struct fuse_conn *fc;
+	struct fuse_dev *fud;
 
 	err = -EINVAL;
 	file = fget(ctx->fd);
@@ -1233,13 +1230,16 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	if ((file->f_op != &fuse_dev_operations) ||
 	    (file->f_cred->user_ns != sb->s_user_ns))
 		goto err_fput;
-	ctx->fudptr = &file->private_data;
 
-	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
 	err = -ENOMEM;
-	if (!fc)
+	fud = fuse_dev_alloc();
+	if (!fud)
 		goto err_fput;
 
+	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
+	if (!fc)
+		goto err_free_dev;
+
 	fuse_conn_init(fc, sb->s_user_ns, &fuse_dev_fiq_ops, NULL);
 	fc->release = fuse_free_conn;
 	sb->s_fs_info = fc;
@@ -1247,6 +1247,9 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	err = fuse_fill_super_common(sb, ctx);
 	if (err)
 		goto err_put_conn;
+
+	fuse_dev_install(fud, fc);
+	file->private_data = fud;
 	/*
 	 * atomic_dec_and_test() in fput() provides the necessary
 	 * memory barrier for file->private_data to be visible on all
@@ -1259,6 +1262,8 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
  err_put_conn:
 	fuse_conn_put(fc);
 	sb->s_fs_info = NULL;
+ err_free_dev:
+	fuse_dev_free(fud);
  err_fput:
 	fput(file);
  err:
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bade74768903..87a7bc0f193c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1066,8 +1066,7 @@ static int virtio_fs_fill_super(struct super_block *sb)
 	}
 
 	err = -ENOMEM;
-	/* Allocate fuse_dev for hiprio and notification queues */
-	for (i = 0; i < VQ_REQUEST; i++) {
+	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
 		fsvq->fud = fuse_dev_alloc();
@@ -1075,18 +1074,12 @@ static int virtio_fs_fill_super(struct super_block *sb)
 			goto err_free_fuse_devs;
 	}
 
-	ctx.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
 	err = fuse_fill_super_common(sb, &ctx);
 	if (err < 0)
 		goto err_free_fuse_devs;
 
-	fc = fs->vqs[VQ_REQUEST].fud->fc;
-
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
-
-		if (i == VQ_REQUEST)
-			continue; /* already initialized */
 		fuse_dev_install(fsvq->fud, fc);
 	}
 
-- 
2.25.4

