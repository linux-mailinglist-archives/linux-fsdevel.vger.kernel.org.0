Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE648B6DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350669AbiAKTRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350677AbiAKTQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A71FC029820;
        Tue, 11 Jan 2022 11:16:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D18761785;
        Tue, 11 Jan 2022 19:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D39C36AE9;
        Tue, 11 Jan 2022 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928588;
        bh=Lsmgt5A5ih2yLw7ckltyZGUoIOT+lEd5XZYiRpW2sJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pksdYO2C9wlgeoePLmasOb0mpQyZNYU868l88s25aDlRKRmAWsqv36Y5QWyDROrDz
         mDZ/LcU1igO18toM5tCouotCTtIdR3WVa/5FtjKTCEAXnqYKdWnj0tEKQRmEIvkh0X
         IMyFKisdGQIoxpbrlsfdj1KJIrNZbKwbXRMFWBtaWJwu+Qb5/Ubon/eranfA9KNhcZ
         7+ZidMP1sYBBRaCkpOX01Y+xkWb7WNcp2vWyHEYozASwmeN5YXk5eZk9bq+lp556TD
         2+Ilp1hKd24uMlE80biBp4fuANWo9+4iFlOX1l8Uewgg8Nyovxr0KA8kY7/j1vsNn7
         7axDQvxkJGIuw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 25/48] ceph: add some fscrypt guardrails
Date:   Tue, 11 Jan 2022 14:15:45 -0500
Message-Id: <20220111191608.88762-26-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
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
 fs/ceph/file.c  | 14 +++++++++++++-
 fs/ceph/inode.c |  4 ++++
 3 files changed, 25 insertions(+), 1 deletion(-)

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
index 5937a25ddddd..01e7cdd84c36 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -356,8 +356,13 @@ int ceph_open(struct inode *inode, struct file *file)
 
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
@@ -802,6 +807,13 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
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
index e7fb212661d1..55022fdb1fdf 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2504,6 +2504,10 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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
2.34.1

