Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24734BCAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhC1Oo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 10:44:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhC1Oo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 10:44:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C8BF11F4418B
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     krisman@collabora.com, kernel@collabora.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Chao Yu <yuchao0@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/3] fs/dcache: Add d_clear_dir_neg_dentries()
Date:   Sun, 28 Mar 2021 11:43:54 -0300
Message-Id: <20210328144356.12866-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210328144356.12866-1-andrealmeid@collabora.com>
References: <20210328144356.12866-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For directories with negative dentries that are becoming case-insensitive
dirs, we need to remove all those negative dentries, otherwise they will
become dangling dentries. During the creation of a new file, if a d_hash
collision happens and the names match in a case-insensitive way, the name
of the file will be the name defined at the negative dentry, that may be
different from the specified by the user. To prevent this from
happening, we need to remove all dentries in a directory. Given that the
directory must be empty before we call this function we are sure that
all dentries there will be negative.

Create a function to remove all negative dentries from a directory, to
be used as explained above by filesystems that support case-insensitive
lookups.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 fs/dcache.c            | 27 +++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d24ff7eb206..fafb3016d6fd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1723,6 +1723,33 @@ void d_invalidate(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_invalidate);
 
+/**
+ * d_clear_dir_neg_dentries - Remove negative dentries in an inode
+ * @dir: Directory to clear negative dentries
+ *
+ * For directories with negative dentries that are becoming case-insensitive
+ * dirs, we need to remove all those negative dentries, otherwise they will
+ * become dangling dentries. During the creation of a new file, if a d_hash
+ * collision happens and the names match in a case-insensitive, the name of
+ * the file will be the name defined at the negative dentry, that can be
+ * different from the specified by the user. To prevent this from happening, we
+ * need to remove all dentries in a directory. Given that the directory must be
+ * empty before we call this function we are sure that all dentries there will
+ * be negative.
+ */
+void d_clear_dir_neg_dentries(struct inode *dir)
+{
+	struct dentry *alias, *dentry;
+
+	hlist_for_each_entry(alias, &dir->i_dentry, d_u.d_alias) {
+		list_for_each_entry(dentry, &alias->d_subdirs, d_child) {
+			d_drop(dentry);
+			dput(dentry);
+		}
+	}
+}
+EXPORT_SYMBOL(d_clear_dir_neg_dentries);
+
 /**
  * __d_alloc	-	allocate a dcache entry
  * @sb: filesystem it will belong to
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1e48014106f..c43cd0be077f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -250,6 +250,7 @@ extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
 extern void shrink_dcache_for_umount(struct super_block *);
 extern void d_invalidate(struct dentry *);
+extern void d_clear_dir_neg_dentries(struct inode *);
 
 /* only used at mount-time */
 extern struct dentry * d_make_root(struct inode *);
-- 
2.31.0

