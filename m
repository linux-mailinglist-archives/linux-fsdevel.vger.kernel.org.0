Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B02FE2791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 03:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbfJXBGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 21:06:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33302 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389995AbfJXBGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:06:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNRaP-0001bv-Ne; Thu, 24 Oct 2019 01:06:45 +0000
Date:   Thu, 24 Oct 2019 02:06:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] ovl_obtain_alias(): don't call d_instantiate_anon() for old
 dentry
Message-ID: <20191024010645.GC26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Miklos, Amir - is there anything subtle I'm missing here?]

The situation is the same as for __d_obtain_alias() (which is what
that thing is parallel to) - if we find a preexisting alias, we
want to grab it, drop the inode and return the alias we'd found.

The only thing d_instantiate_anon() does compared to that is
spurious security_d_instiate() that has already been done to
that dentry with exact same arguments.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
--
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 73c9775215b3..a64195b194c2 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -317,29 +317,32 @@ static struct dentry *ovl_obtain_alias(struct super_block *sb,
 		ovl_set_flag(OVL_UPPERDATA, inode);
 
 	dentry = d_find_any_alias(inode);
-	if (!dentry) {
-		dentry = d_alloc_anon(inode->i_sb);
-		if (!dentry)
-			goto nomem;
-		oe = ovl_alloc_entry(lower ? 1 : 0);
-		if (!oe)
-			goto nomem;
-
-		if (lower) {
-			oe->lowerstack->dentry = dget(lower);
-			oe->lowerstack->layer = lowerpath->layer;
-		}
-		dentry->d_fsdata = oe;
-		if (upper_alias)
-			ovl_dentry_set_upper_alias(dentry);
+	if (dentry)
+		goto out_iput;
+
+	dentry = d_alloc_anon(inode->i_sb);
+	if (unlikely(!dentry))
+		goto nomem;
+	oe = ovl_alloc_entry(lower ? 1 : 0);
+	if (!oe)
+		goto nomem;
+
+	if (lower) {
+		oe->lowerstack->dentry = dget(lower);
+		oe->lowerstack->layer = lowerpath->layer;
 	}
+	dentry->d_fsdata = oe;
+	if (upper_alias)
+		ovl_dentry_set_upper_alias(dentry);
 
 	return d_instantiate_anon(dentry, inode);
 
 nomem:
-	iput(inode);
 	dput(dentry);
-	return ERR_PTR(-ENOMEM);
+	dentry = ERR_PTR(-ENOMEM);
+out_iput:
+	iput(inode);
+	return dentry;
 }
 
 /* Get the upper or lower dentry in stach whose on layer @idx */
