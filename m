Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD89817B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfHURi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44471 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730079AbfHURi0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42D67300BC78;
        Wed, 21 Aug 2019 17:38:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DB015D9D3;
        Wed, 21 Aug 2019 17:38:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DA1F4223D08; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH 12/13] virtio-fs: Do not provide abort interface in fusectl
Date:   Wed, 21 Aug 2019 13:37:41 -0400
Message-Id: <20190821173742.24574-13-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 21 Aug 2019 17:38:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtio-fs does not support aborting requests which are being processed. That
is requests which have been sent to fuse daemon on host.

So do not provide "abort" interface for virtio-fs in fusectl.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/control.c   | 4 ++--
 fs/fuse/fuse_i.h    | 4 ++++
 fs/fuse/inode.c     | 1 +
 fs/fuse/virtio_fs.c | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index c23f6f243ad4..c4681efc5ece 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -279,8 +279,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 
 	if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400, 1,
 				 NULL, &fuse_ctl_waiting_ops) ||
-	    !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1,
-				 NULL, &fuse_ctl_abort_ops) ||
+	    (!fc->no_abort && !fuse_ctl_add_dentry(parent, fc, "abort",
+			S_IFREG | 0200, 1, NULL, &fuse_ctl_abort_ops)) ||
 	    !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG | 0600,
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 73b23421b48e..25a6da6ee8c3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -73,6 +73,7 @@ struct fuse_mount_data {
 	unsigned default_permissions:1;
 	unsigned allow_other:1;
 	unsigned destroy:1;
+	unsigned no_abort:1;
 	unsigned max_read;
 	unsigned blksize;
 
@@ -789,6 +790,9 @@ struct fuse_conn {
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
+	/** Do not create abort file in fuse control fs */
+	unsigned no_abort:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fca81c40b2d7..16bcf0f95979 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1157,6 +1157,7 @@ int fuse_fill_super_common(struct super_block *sb,
 	fc->user_id = mount_data->user_id;
 	fc->group_id = mount_data->group_id;
 	fc->max_read = max_t(unsigned, 4096, mount_data->max_read);
+	fc->no_abort = mount_data->no_abort;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ce6b76598e74..ce1de9acde84 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -886,6 +886,7 @@ static int virtio_fs_fill_super(struct super_block *sb, char *opts,
 
 	d->fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
 	d->destroy = true; /* Send destroy request on unmount */
+	d->no_abort = 1;
 	err = fuse_fill_super_common(sb, d);
 	if (err < 0)
 		goto err_free_init_req;
-- 
2.20.1

