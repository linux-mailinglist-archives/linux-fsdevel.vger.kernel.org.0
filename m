Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9546EBC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbhLIPlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42498 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbhLIPko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 576D1CE2693;
        Thu,  9 Dec 2021 15:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290BEC341C8;
        Thu,  9 Dec 2021 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064227;
        bh=Smy1IfHOzHvgq/bbRV24RJWOsBXNMJAfmKBqbTdoYSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srd0temEInR1UogqhxIeACqYJ9/bTJRiketKeAk8NtvvmMa8NCOy8QBZfkbc1sh2l
         yaR3Etcm1oKVB3J4QBkIvbXAc1zt8YFoPw+FCdnZFyXFUTJaPa+ljqUGreBhzyL7DC
         2h/Eluz7lIxOqejGUgq9XKkdcei/mwWAsAtRIcqo+R2GFmFIIqvHWqTD9I9v/UFq3a
         fhhDnMhcpS//OJuKY4o3F2vJtU6MPxfkUUZFSsM2ZijIsHK/Eop+lqX7/3LCBKmJDd
         y6LEfoYyblSk3T6FvTMg0e9ftaXGU4ywfmvjv0jf7adwOEJh8MeD6OpkLT6QtZJ3YI
         lKN/fNa3SUA6Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/36] ceph: add some fscrypt guardrails
Date:   Thu,  9 Dec 2021 10:36:37 -0500
Message-Id: <20211209153647.58953-27-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that we all into fscrypt to do a proper check for keys on link,
rename, etc.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c   |  8 ++++++++
 fs/ceph/file.c  | 18 +++++++++++++++++-
 fs/ceph/inode.c |  4 ++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index bf686e4af27a..37c9c589ee27 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1127,6 +1127,10 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
+	err = fscrypt_prepare_link(old_dentry, dir, dentry);
+	if (err)
+		return err;
+
 	dout("link in dir %p old_dentry %p dentry %p\n", dir,
 	     old_dentry, dentry);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LINK, USE_AUTH_MDS);
@@ -1324,6 +1328,10 @@ static int ceph_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	    (!ceph_quota_is_same_realm(old_dir, new_dir)))
 		return -EXDEV;
 
+	err = fscrypt_prepare_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
+	if (err)
+		return err;
+
 	dout("rename dir %p dentry %p to dir %p dentry %p\n",
 	     old_dir, old_dentry, new_dir, new_dentry);
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c2e3e833ffc0..edc6c2c25174 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -352,8 +352,13 @@ int ceph_open(struct inode *inode, struct file *file)
 
 	/* filter out O_CREAT|O_EXCL; vfs did that already.  yuck. */
 	flags = file->f_flags & ~(O_CREAT|O_EXCL);
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		flags = O_DIRECTORY;  /* mds likes to know */
+	} else if (S_ISREG(inode->i_mode)) {
+		err = fscrypt_file_open(inode, file);
+		if (err)
+			return err;
+	}
 
 	dout("open inode %p ino %llx.%llx file %p flags %d (%d)\n", inode,
 	     ceph_vinop(inode), file, flags, file->f_flags);
@@ -704,6 +709,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		return -ENOENT;
 	}
 
+	err = fscrypt_require_key(dir);
+	if (err)
+		return err;
+
 	/* do the open */
 	req = prepare_open_request(dir->i_sb, flags, mode);
 	if (IS_ERR(req)) {
@@ -798,6 +807,13 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		dout("atomic_open finish_no_open on dn %p\n", dn);
 		err = finish_no_open(file, dn);
 	} else {
+		if (IS_ENCRYPTED(dir) &&
+		    !fscrypt_has_permitted_context(dir, d_inode(dentry))) {
+			pr_warn("Inconsistent encryption context (parent %llx:%llx child %llx:%llx)\n",
+				ceph_vinop(dir), ceph_vinop(d_inode(dentry)));
+			goto out_req;
+		}
+
 		dout("atomic_open finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
 			struct inode *newino = d_inode(dentry);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index da242ff1756e..0dac3724c612 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2494,6 +2494,10 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
+	err = fscrypt_prepare_setattr(dentry, attr);
+	if (err)
+		return err;
+
 	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err != 0)
 		return err;
-- 
2.33.1

