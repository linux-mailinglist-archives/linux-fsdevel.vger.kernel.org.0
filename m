Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1333EE440
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 04:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhHQCXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 22:23:00 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47979 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236155AbhHQCW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:22:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjHTKZL_1629166942;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UjHTKZL_1629166942)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 10:22:23 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH v4 5/8] fuse: enable per-file DAX
Date:   Tue, 17 Aug 2021 10:22:17 +0800
Message-Id: <20210817022220.17574-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable per-file DAX if fuse server advertises that the file supports
that.

Currently the state whether the file enables DAX or not is initialized
only when inode is instantiated.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c    | 12 ++++++++----
 fs/fuse/file.c   |  4 ++--
 fs/fuse/fuse_i.h |  4 ++--
 fs/fuse/inode.c  |  2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index fe4e9593a590..30833f8d37dd 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1339,7 +1339,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
 	.invalidatepage	= noop_invalidatepage,
 };
 
-static bool fuse_should_enable_dax(struct inode *inode)
+static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	unsigned int dax_mode = fc->dax_mode;
@@ -1348,12 +1348,16 @@ static bool fuse_should_enable_dax(struct inode *inode)
 	if (dax_mode == FUSE_DAX_NEVER)
 		return false;
 
-	return true;
+	if (dax_mode == FUSE_DAX_ALWAYS)
+		return true;
+
+	WARN_ON_ONCE(dax_mode != FUSE_DAX_INODE);
+	return fc->perfile_dax && (flags & FUSE_ATTR_DAX);
 }
 
-void fuse_dax_inode_init(struct inode *inode)
+void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
 {
-	if (!fuse_should_enable_dax(inode))
+	if (!fuse_should_enable_dax(inode, flags))
 		return;
 
 	inode->i_flags |= S_DAX;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ec48bc7ef0a5..1231128f8dd6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3148,7 +3148,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.write_end	= fuse_write_end,
 };
 
-void fuse_init_file_inode(struct inode *inode)
+void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
@@ -3162,5 +3162,5 @@ void fuse_init_file_inode(struct inode *inode)
 	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
-		fuse_dax_inode_init(inode);
+		fuse_dax_inode_init(inode, flags);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0b21e76a379a..7b7b4c208af2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1006,7 +1006,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
 /**
  * Initialize file operations on a regular file
  */
-void fuse_init_file_inode(struct inode *inode);
+void fuse_init_file_inode(struct inode *inode, unsigned int flags);
 
 /**
  * Initialize inode operations on regular files and special files
@@ -1258,7 +1258,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode mode,
 			struct dax_device *dax_dev);
 void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
-void fuse_dax_inode_init(struct inode *inode);
+void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
 void fuse_dax_inode_cleanup(struct inode *inode);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9d302079281c..8080f78befed 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -281,7 +281,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 	inode->i_ctime.tv_nsec = attr->ctimensec;
 	if (S_ISREG(inode->i_mode)) {
 		fuse_init_common(inode);
-		fuse_init_file_inode(inode);
+		fuse_init_file_inode(inode, attr->flags);
 	} else if (S_ISDIR(inode->i_mode))
 		fuse_init_dir(inode);
 	else if (S_ISLNK(inode->i_mode))
-- 
2.27.0

