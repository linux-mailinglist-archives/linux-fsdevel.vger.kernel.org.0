Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEB1FAB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfEOT3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DE5F3003C77;
        Wed, 15 May 2019 19:27:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE03919C71;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 31BA8225492; Wed, 15 May 2019 15:27:30 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 30/30] virtio-fs: Do not provide abort interface in fusectl
Date:   Wed, 15 May 2019 15:27:15 -0400
Message-Id: <20190515192715.18000-31-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 15 May 2019 19:27:34 +0000 (UTC)
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
index fe80bea4ad89..c1423f2ebc5e 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -278,8 +278,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 
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
index b4a5728444bb..7ac7f9a0b81b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -86,6 +86,7 @@ struct fuse_mount_data {
 	unsigned allow_other:1;
 	unsigned dax:1;
 	unsigned destroy:1;
+	unsigned no_abort:1;
 	unsigned max_read;
 	unsigned blksize;
 
@@ -847,6 +848,9 @@ struct fuse_conn {
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
+	/** Do not create abort file in fuse control fs */
+	unsigned no_abort:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8af7f31c6e19..302f7e04b645 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1272,6 +1272,7 @@ int fuse_fill_super_common(struct super_block *sb,
 	fc->user_id = mount_data->user_id;
 	fc->group_id = mount_data->group_id;
 	fc->max_read = max_t(unsigned, 4096, mount_data->max_read);
+	fc->no_abort = mount_data->no_abort;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 76c46edcc8ac..18fc0dca0abc 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1042,6 +1042,7 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
 	d.fiq_priv = fs;
 	d.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
 	d.destroy = true; /* Send destroy request on unmount */
+	d.no_abort = 1;
 	err = fuse_fill_super_common(sb, &d);
 	if (err < 0)
 		goto err_free_init_req;
-- 
2.20.1

