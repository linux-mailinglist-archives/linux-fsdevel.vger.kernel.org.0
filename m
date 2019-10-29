Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBAE89E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 14:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbfJ2NuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 09:50:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35400 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388561AbfJ2NuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:50:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPRt5-0005QJ-Kd; Tue, 29 Oct 2019 13:50:19 +0000
Date:   Tue, 29 Oct 2019 13:50:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] ceph_d_revalidate(): fix RCU case handling
Message-ID: <20191029135019.GG26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For RCU case ->d_revalidate() is called with rcu_read_lock() and
without pinning the dentry passed to it.  Which means that it
can't rely upon ->d_inode remaining stable; that's the reason
for d_inode_rcu(), actually.

Make sure we don't reload ->d_inode there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 4ca0b8ff9a72..d17a789fd856 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1553,36 +1553,37 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	int valid = 0;
 	struct dentry *parent;
-	struct inode *dir;
+	struct inode *dir, *inode;
 
 	if (flags & LOOKUP_RCU) {
 		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
 		if (!dir)
 			return -ECHILD;
+		inode = d_inode_rcu(dentry);
 	} else {
 		parent = dget_parent(dentry);
 		dir = d_inode(parent);
+		inode = d_inode(dentry);
 	}
 
 	dout("d_revalidate %p '%pd' inode %p offset %lld\n", dentry,
-	     dentry, d_inode(dentry), ceph_dentry(dentry)->offset);
+	     dentry, inode, ceph_dentry(dentry)->offset);
 
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
 		dout("d_revalidate %p '%pd' inode %p is SNAPPED\n", dentry,
-		     dentry, d_inode(dentry));
+		     dentry, inode);
 		valid = 1;
-	} else if (d_really_is_positive(dentry) &&
-		   ceph_snap(d_inode(dentry)) == CEPH_SNAPDIR) {
+	} else if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 		valid = 1;
 	} else {
 		valid = dentry_lease_is_valid(dentry, flags);
 		if (valid == -ECHILD)
 			return valid;
 		if (valid || dir_lease_is_valid(dir, dentry)) {
-			if (d_really_is_positive(dentry))
-				valid = ceph_is_any_caps(d_inode(dentry));
+			if (inode)
+				valid = ceph_is_any_caps(inode);
 			else
 				valid = 1;
 		}
