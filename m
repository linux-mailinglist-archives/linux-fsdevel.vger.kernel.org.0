Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975433F6FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbhHYGxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhHYGxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:53:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14517C061757;
        Tue, 24 Aug 2021 23:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UX7z+r+ZZdyqdaWEqqWWojeZONCIj31OAKPX18EzMUs=; b=YHu+rZc7cHjb0ncqlOGFDUqCF/
        dv6FiFGRXo/V/o+0DV5vDgT7L+bsnRHbAo1YbuJFzbuGzij+uMhzqpR7JtdTGy9YmJ2afZ6ROxW8p
        OtxcLKxNkMKNFfyX3AAL4oRowwBMm0VhDgRKnqysotCIxgLFDwaEwmNXONtOcl728h4+sZlQKtTXa
        wcUbNz1eXCLDjSNdF/sKzBrkkEh0edarwyppFh6GeaVpP+9fA4url0aDxOhPek9PiEhEShnkySQ/t
        5L88WQKAWhMy1jEvfOZTyAQyI3L6lvO/y5Qa0d+OAQ0IDKQ+WvDB0ZIaNEfJtwDM/Osb7jkQ4coyh
        VIAz+gKw==;
Received: from [2001:4bb8:193:fd10:ce54:74a1:df3f:e6a9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mImlR-00Bzg5-SK; Wed, 25 Aug 2021 06:52:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] configfs: fold configfs_attach_attr into configfs_lookup
Date:   Wed, 25 Aug 2021 08:49:05 +0200
Message-Id: <20210825064906.1694233-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825064906.1694233-1-hch@lst.de>
References: <20210825064906.1694233-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This makes it more clear what gets added to the dcache and prepares
for an additional locking fix.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/configfs/dir.c | 73 ++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 5d58569f0eea..fc20bd8a6337 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -45,7 +45,7 @@ static void configfs_d_iput(struct dentry * dentry,
 		/*
 		 * Set sd->s_dentry to null only when this dentry is the one
 		 * that is going to be killed.  Otherwise configfs_d_iput may
-		 * run just after configfs_attach_attr and set sd->s_dentry to
+		 * run just after configfs_lookup and set sd->s_dentry to
 		 * NULL even it's still in use.
 		 */
 		if (sd->s_dentry == dentry)
@@ -417,44 +417,13 @@ static void configfs_remove_dir(struct config_item * item)
 	dput(dentry);
 }
 
-
-/* attaches attribute's configfs_dirent to the dentry corresponding to the
- * attribute file
- */
-static int configfs_attach_attr(struct configfs_dirent * sd, struct dentry * dentry)
-{
-	struct configfs_attribute * attr = sd->s_element;
-	struct inode *inode;
-
-	spin_lock(&configfs_dirent_lock);
-	dentry->d_fsdata = configfs_get(sd);
-	sd->s_dentry = dentry;
-	spin_unlock(&configfs_dirent_lock);
-
-	inode = configfs_create(dentry, (attr->ca_mode & S_IALLUGO) | S_IFREG);
-	if (IS_ERR(inode)) {
-		configfs_put(sd);
-		return PTR_ERR(inode);
-	}
-	if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
-		inode->i_size = 0;
-		inode->i_fop = &configfs_bin_file_operations;
-	} else {
-		inode->i_size = PAGE_SIZE;
-		inode->i_fop = &configfs_file_operations;
-	}
-	d_add(dentry, inode);
-	return 0;
-}
-
 static struct dentry * configfs_lookup(struct inode *dir,
 				       struct dentry *dentry,
 				       unsigned int flags)
 {
 	struct configfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
 	struct configfs_dirent * sd;
-	int found = 0;
-	int err;
+	struct inode *inode = NULL;
 
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -471,28 +440,34 @@ static struct dentry * configfs_lookup(struct inode *dir,
 		return ERR_PTR(-ENOENT);
 
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
-		if (sd->s_type & CONFIGFS_NOT_PINNED) {
-			const unsigned char * name = configfs_get_name(sd);
+		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
+		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
+			struct configfs_attribute *attr = sd->s_element;
+			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
 
-			if (strcmp(name, dentry->d_name.name))
-				continue;
+			spin_lock(&configfs_dirent_lock);
+			dentry->d_fsdata = configfs_get(sd);
+			sd->s_dentry = dentry;
+			spin_unlock(&configfs_dirent_lock);
 
-			found = 1;
-			err = configfs_attach_attr(sd, dentry);
+			inode = configfs_create(dentry, mode);
+			if (IS_ERR(inode)) {
+				configfs_put(sd);
+				return ERR_CAST(inode);
+			}
+			if (sd->s_type & CONFIGFS_ITEM_BIN_ATTR) {
+				inode->i_size = 0;
+				inode->i_fop = &configfs_bin_file_operations;
+			} else {
+				inode->i_size = PAGE_SIZE;
+				inode->i_fop = &configfs_file_operations;
+			}
 			break;
 		}
 	}
 
-	if (!found) {
-		/*
-		 * If it doesn't exist and it isn't a NOT_PINNED item,
-		 * it must be negative.
-		 */
-		d_add(dentry, NULL);
-		return NULL;
-	}
-
-	return ERR_PTR(err);
+	d_add(dentry, inode);
+	return NULL;
 }
 
 /*
-- 
2.30.2

