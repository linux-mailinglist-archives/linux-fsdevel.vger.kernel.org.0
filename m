Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF9ED43B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 19:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfKCSvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 13:51:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40794 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCSvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:51:36 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRKyL-0003ah-Hr; Sun, 03 Nov 2019 18:51:33 +0000
Date:   Sun, 3 Nov 2019 18:51:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, wugyuan@cn.ibm.com,
        jlayton@kernel.org, hsiangkao@aol.com, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ecryptfs@vger.kernel.org
Subject: [PATCH][RFC] =?iso-8859-1?Q?ecryptfs=5Floo?=
 =?iso-8859-1?B?a3VwX2ludGVycG9zZSgpOqBsb3dlcl9kZW50cnktPmRfaW5vZA==?=
 =?iso-8859-1?Q?e?= is not stable
Message-ID: <20191103185133.GR26530@ZenIV.linux.org.uk>
References: <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
 <20191103163524.GO26530@ZenIV.linux.org.uk>
 <20191103182058.GQ26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103182058.GQ26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

lower_dentry can't go from positive to negative (we have it pinned),
but it *can* go from negative to positive.  So fetching ->d_inode
into a local variable, doing a blocking allocation, checking that
now ->d_inode is non-NULL and feeding the value we'd fetched
earlier to a function that won't accept NULL is not a good idea.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index a905d5f4f3b0..3c2298721359 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -319,7 +319,7 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 				     struct dentry *lower_dentry)
 {
-	struct inode *inode, *lower_inode = d_inode(lower_dentry);
+	struct inode *inode, *lower_inode;
 	struct ecryptfs_dentry_info *dentry_info;
 	struct vfsmount *lower_mnt;
 	int rc = 0;
@@ -339,7 +339,15 @@ static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 	dentry_info->lower_path.mnt = lower_mnt;
 	dentry_info->lower_path.dentry = lower_dentry;
 
-	if (d_really_is_negative(lower_dentry)) {
+	/*
+	 * negative dentry can go positive under us here - its parent is not
+	 * locked.  That's OK and that could happen just as we return from
+	 * ecryptfs_lookup() anyway.  Just need to be careful and fetch
+	 * ->d_inode only once - it's not stable here.
+	 */
+	lower_inode = READ_ONCE(lower_dentry->d_inode);
+
+	if (!lower_inode) {
 		/* We want to add because we couldn't find in lower */
 		d_add(dentry, NULL);
 		return NULL;
