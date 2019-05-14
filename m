Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781BF1E4B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfENWTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:19:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44906 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfENWTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:19:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so426783wrs.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lHvWPEdPz5M7DfRwzXnDIFqCatHT/VGerDKnxkatJLs=;
        b=WARQeUrm/NT+TkZelOgiWmqg+YGLpTlAMQ3NFnD7ht7ON0d6xY5k8UN/wZTCbrzQfk
         3E3+8lHV6MTkvvdkECQZwQo5uMMiPsXvAej60qhos5sl/eX5LLe+RdPL8Jvez7/2j658
         P/WHfbVUJf4ZJy+jyQGHXQtcN6zFeYcqa8OdFNbBSDXTklaJNiP0KCxLSfw+iQ8nGYTl
         K/MStvB3jWo5Nc6DGy8019POgxJdN8j72LKcYh1L1m4Jzg7I3LuFZ16iKkpAF69qgT/f
         h3RKvO6wME9o/WyOvY2ARe3t4xDotNLlEIeT56sWgjuJno9tMgquwjHEvWJQxnLMyIWJ
         tZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lHvWPEdPz5M7DfRwzXnDIFqCatHT/VGerDKnxkatJLs=;
        b=KkBn7K2RllXfd5YPecQoc2TYrMU+9MM9yschhVqjPs5yJ+RmGmDqw3rlvDRkaiW4l0
         XV335pdjPk+aSg4sNI0wo76t9JGZpmBZykv3pEVFrasO/MQAevdCxciPUGbHiB4Q6991
         UUXDXWMZsgSB3yrqLuL2km27sItslWH/NXpCt7l/qRJu6LsxxnJRBkIkbR+FSzcVIhVe
         xBQs2VpbnqEvc2UF3zG6c87F5IFPlmXQSNEexPUu6aILgPpUzyJ7Wbs+h9+K4/3oIOqE
         FPRWKGT87wVG+81s9WrpyRLn0IPb/eHYuhqvMs+evlq1I1+7PguaDBMfjOAHKHokKNV4
         Q1QA==
X-Gm-Message-State: APjAAAUTlLqqKVAD1XjhWs7lD/ts5d84gJDYym+VjHyhsKdvqYXnqRVW
        LfwxFVEgelMzs1Yn3oKY+84=
X-Google-Smtp-Source: APXvYqzeC7IK0k0ctAt3hzpTTxXVXPcz2RKRk6oje1eMjoFU73Xc2sfMqT3btYeaKPSi1hQy7hR9ug==
X-Received: by 2002:adf:b243:: with SMTP id y3mr22539278wra.21.1557872354937;
        Tue, 14 May 2019 15:19:14 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id h188sm423553wmf.48.2019.05.14.15.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:19:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 3/4] fs: convert filesystems to use simple_remove() helper
Date:   Wed, 15 May 2019 01:19:00 +0300
Message-Id: <20190514221901.29125-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514221901.29125-1-amir73il@gmail.com>
References: <20190514221901.29125-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert some filesystems to use the new simple_remove() helper.
This will allow them to generate fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 arch/s390/hypfs/inode.c            |  9 ++-------
 drivers/infiniband/hw/qib/qib_fs.c |  3 +--
 fs/debugfs/inode.c                 | 20 ++++----------------
 fs/tracefs/inode.c                 | 23 ++++-------------------
 net/sunrpc/rpc_pipe.c              | 16 ++--------------
 security/apparmor/apparmorfs.c     |  6 +-----
 6 files changed, 14 insertions(+), 63 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index ccad1398abd4..30a0ab967461 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -70,13 +70,8 @@ static void hypfs_remove(struct dentry *dentry)
 
 	parent = dentry->d_parent;
 	inode_lock(d_inode(parent));
-	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(d_inode(parent), dentry);
-		else
-			simple_unlink(d_inode(parent), dentry);
-	}
-	d_delete(dentry);
+	if (simple_positive(dentry))
+		simple_remove(d_inode(parent), dentry);
 	dput(dentry);
 	inode_unlock(d_inode(parent));
 }
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index ceb42d948412..795938a2488b 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -491,8 +491,7 @@ static int remove_device_files(struct super_block *sb,
 	}
 	remove_file(dir, "flash");
 	inode_unlock(d_inode(dir));
-	ret = simple_rmdir(d_inode(root), dir);
-	d_delete(dir);
+	ret = simple_remove(d_inode(root), dir);
 	dput(dir);
 
 bail:
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index acef14ad53db..bc96198df1d4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
-static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
+static void __debugfs_file_removed(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd;
 
-	simple_unlink(d_inode(parent), dentry);
-	d_delete(dentry);
-
 	/*
 	 * Paired with the closing smp_mb() implied by a successful
 	 * cmpxchg() in debugfs_file_get(): either
@@ -643,18 +640,9 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
 	int ret = 0;
 
 	if (simple_positive(dentry)) {
-		dget(dentry);
-		if (!d_is_reg(dentry)) {
-			if (d_is_dir(dentry))
-				ret = simple_rmdir(d_inode(parent), dentry);
-			else
-				simple_unlink(d_inode(parent), dentry);
-			if (!ret)
-				d_delete(dentry);
-		} else {
-			__debugfs_remove_file(dentry, parent);
-		}
-		dput(dentry);
+		ret = simple_remove(d_inode(parent), dentry);
+		if (d_is_reg(dentry))
+			__debugfs_file_removed(dentry);
 	}
 	return ret;
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7098c49f3693..6ac31ea9ad5d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -501,25 +501,10 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
 
 static int __tracefs_remove(struct dentry *dentry, struct dentry *parent)
 {
-	int ret = 0;
-
-	if (simple_positive(dentry)) {
-		if (dentry->d_inode) {
-			dget(dentry);
-			switch (dentry->d_inode->i_mode & S_IFMT) {
-			case S_IFDIR:
-				ret = simple_rmdir(parent->d_inode, dentry);
-				break;
-			default:
-				simple_unlink(parent->d_inode, dentry);
-				break;
-			}
-			if (!ret)
-				d_delete(dentry);
-			dput(dentry);
-		}
-	}
-	return ret;
+	if (simple_positive(dentry))
+		return simple_remove(d_inode(parent), dentry);
+
+	return 0;
 }
 
 /**
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 979d23646e33..5b1a59776b9a 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -593,24 +593,12 @@ static int __rpc_mkpipe_dentry(struct inode *dir, struct dentry *dentry,
 
 static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int ret;
-
-	dget(dentry);
-	ret = simple_rmdir(dir, dentry);
-	d_delete(dentry);
-	dput(dentry);
-	return ret;
+	return simple_remove(dir, dentry);
 }
 
 static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int ret;
-
-	dget(dentry);
-	ret = simple_unlink(dir, dentry);
-	d_delete(dentry);
-	dput(dentry);
-	return ret;
+	return simple_remove(dir, dentry);
 }
 
 static int __rpc_rmpipe(struct inode *dir, struct dentry *dentry)
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 9ab5613fe07c..4a10acb4a6d3 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -351,11 +351,7 @@ static void aafs_remove(struct dentry *dentry)
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(dir, dentry);
-		else
-			simple_unlink(dir, dentry);
-		d_delete(dentry);
+		simple_remove(dir, dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.17.1

