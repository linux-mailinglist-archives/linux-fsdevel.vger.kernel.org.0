Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71E3E72E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 14:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfJ1NyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 09:54:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48296 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfJ1NyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:54:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP5TM-00041p-Ur; Mon, 28 Oct 2019 13:54:17 +0000
Date:   Mon, 28 Oct 2019 13:54:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] exfat: get rid of ->d_time mess
Message-ID: <20191028135416.GF26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Nothing ever reads ->d_time of exfat dentries.  Remove the
assignments, especially since exfat_lookup() one is actually
oopsable - d_splice_alias() may return ERR_PTR()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 3b2b0ceb7297..063a0d0016bf 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2394,7 +2394,6 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	 * timestamp is already written, so mark_inode_dirty() is unnecessary.
 	 */
 
-	dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
 	d_instantiate(dentry, inode);
 
 out:
@@ -2479,10 +2478,7 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 	dput(alias);
 out:
 	__unlock_super(sb);
-	dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
 	dentry = d_splice_alias(inode, dentry);
-	if (dentry)
-		dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
 	pr_debug("%s exited 2\n", __func__);
 	return dentry;
 
@@ -2620,7 +2616,6 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
-	dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
 	d_instantiate(dentry, inode);
 
 out:
@@ -2674,7 +2669,6 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
-	dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
 	d_instantiate(dentry, inode);
 
 out:
