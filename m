Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842CF3F6FE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 08:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbhHYGyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbhHYGyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:54:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A676C061757;
        Tue, 24 Aug 2021 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1enB9YVobt+Zl/ChJzBQuQLDnWStDIIhYMzFIU7dnz8=; b=lYAvNUIrtrZKwUtVm2gWzmP2Hb
        maeX4PocszdSQERsixb6AkIB5feBGzryi8fi+qtMosZ7/X9Pv/qhDzn0Wr9O+8hRIElDADJMkRNoQ
        8WLXNesonRkJbLWCywkVtAEKM4ccuNzcov3dVtAsA9JCrtEZHylK/1l3RuFvVp5Pgjugo2ECCvo08
        dtcl41Zwzg9fDTfcT5x7PR0+2yEOFWS8eltqe8af6Tt//Im7Pk2LvI3gxsNK9rLhOgprLWYASDExJ
        1tbpEamlQAdlCT5GvsUNBrSGnyrNO4nu49F7qQwXj7mOAT/2OmZE9ch5IrQihR3zYGemcH5XkYtpj
        z7c7bW0A==;
Received: from [2001:4bb8:193:fd10:ce54:74a1:df3f:e6a9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mImmH-00Bzib-Tv; Wed, 25 Aug 2021 06:52:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] configfs: fix a race in configfs_lookup()
Date:   Wed, 25 Aug 2021 08:49:06 +0200
Message-Id: <20210825064906.1694233-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825064906.1694233-1-hch@lst.de>
References: <20210825064906.1694233-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sishuai Gong <sishuai@purdue.edu>

When configfs_lookup() is executing list_for_each_entry(),
it is possible that configfs_dir_lseek() is calling list_del().
Some unfortunate interleavings of them can cause a kernel NULL
pointer dereference error

Thread 1                  Thread 2
//configfs_dir_lseek()    //configfs_lookup()
list_del(&cursor->s_sibling);
                         list_for_each_entry(sd, ...)

Fix this by grabbing configfs_dirent_lock in configfs_lookup()
while iterating ->s_children.

Signed-off-by: Sishuai Gong <sishuai@purdue.edu>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/configfs/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index fc20bd8a6337..1466b5d01cbb 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -439,13 +439,13 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	if (!configfs_dirent_is_ready(parent_sd))
 		return ERR_PTR(-ENOENT);
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
 		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
 			struct configfs_attribute *attr = sd->s_element;
 			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
 
-			spin_lock(&configfs_dirent_lock);
 			dentry->d_fsdata = configfs_get(sd);
 			sd->s_dentry = dentry;
 			spin_unlock(&configfs_dirent_lock);
@@ -462,10 +462,11 @@ static struct dentry * configfs_lookup(struct inode *dir,
 				inode->i_size = PAGE_SIZE;
 				inode->i_fop = &configfs_file_operations;
 			}
-			break;
+			goto done;
 		}
 	}
-
+	spin_unlock(&configfs_dirent_lock);
+done:
 	d_add(dentry, inode);
 	return NULL;
 }
-- 
2.30.2

