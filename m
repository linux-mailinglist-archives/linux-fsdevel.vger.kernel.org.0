Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB8415AE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbhIWJ1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 05:27:02 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38678 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240127AbhIWJ1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:27:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpJnqyA_1632389129;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UpJnqyA_1632389129)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 17:25:29 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v5 4/5] fuse: enable per-file DAX
Date:   Thu, 23 Sep 2021 17:25:25 +0800
Message-Id: <20210923092526.72341-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DAX may be limited in some specific situation. When the number of usable
DAX windows is under watermark, the recalim routine will be triggered to
reclaim some DAX windows. It may have a negative impact on the
performance, since some processes may need to wait for DAX windows to be
recalimed and reused then. To mitigate the performance degradation, the
overall DAX window need to be expanded larger.

However, simply expanding the DAX window may not be a good deal in some
scenario. To maintain one DAX window chunk (i.e., 2MB in size), 32KB
(512 * 64 bytes) memory footprint will be consumed for page descriptors
inside guest, which is greater than the memory footprint if it uses
guest page cache when DAX disabled. Thus it'd better disable DAX for
those files smaller than 32KB, to reduce the demand for DAX window and
thus avoid the unworthy memory overhead.

Per-file DAX feature is introduced to address this issue, by offering a
finer grained control for dax to users, trying to achieve a balance
between performance and memory overhead.

The FUSE_ATTR_DAX flag in FUSE_LOOKUP reply is used to indicate whether
DAX should be enabled or not for corresponding file. Currently the state
whether DAX is enabled or not for the file is initialized only when
inode is instantiated.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c    | 12 ++++++++----
 fs/fuse/file.c   |  4 ++--
 fs/fuse/fuse_i.h |  4 ++--
 fs/fuse/inode.c  |  2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e87ddded38c7..b0682ddd5d77 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1333,7 +1333,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
 	.invalidatepage	= noop_invalidatepage,
 };
 
-static bool fuse_should_enable_dax(struct inode *inode)
+static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	unsigned int dax_mode = fc->dax_mode;
@@ -1342,12 +1342,16 @@ static bool fuse_should_enable_dax(struct inode *inode)
 	if (dax_mode == FUSE_DAX_NEVER)
 		return false;
 
-	return true;
+	if (dax_mode == FUSE_DAX_ALWAYS)
+		return true;
+
+	/* dax_mode == FUSE_DAX_INODE */
+	return flags & FUSE_ATTR_DAX;
 }
 
-void fuse_dax_inode_init(struct inode *inode)
+void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
 {
-	if (!fuse_should_enable_dax(inode))
+	if (!fuse_should_enable_dax(inode, flags))
 		return;
 
 	inode->i_flags |= S_DAX;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11404f8c21c7..40c667a48cf6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3163,7 +3163,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.write_end	= fuse_write_end,
 };
 
-void fuse_init_file_inode(struct inode *inode)
+void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
@@ -3177,5 +3177,5 @@ void fuse_init_file_inode(struct inode *inode)
 	fi->writepages = RB_ROOT;
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
-		fuse_dax_inode_init(inode);
+		fuse_dax_inode_init(inode, flags);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5abf9749923f..0270a41c31d7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1016,7 +1016,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
 /**
  * Initialize file operations on a regular file
  */
-void fuse_init_file_inode(struct inode *inode);
+void fuse_init_file_inode(struct inode *inode, unsigned int flags);
 
 /**
  * Initialize inode operations on regular files and special files
@@ -1268,7 +1268,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode mode,
 			struct dax_device *dax_dev);
 void fuse_dax_conn_free(struct fuse_conn *fc);
 bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
-void fuse_dax_inode_init(struct inode *inode);
+void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
 void fuse_dax_inode_cleanup(struct inode *inode);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b4b41683e97e..48f466a65b76 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -280,7 +280,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
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

