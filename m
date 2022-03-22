Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB604E408C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiCVOPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiCVOPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229713F56;
        Tue, 22 Mar 2022 07:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 368336160B;
        Tue, 22 Mar 2022 14:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96ABC340F4;
        Tue, 22 Mar 2022 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958426;
        bh=OOjmFqsuSQ6iDouhb3W2aUCiE/kjaCqYPJItBE4HMCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VmDxlJVmqbig2T3O+o7vZpraryySOD8lUZPk0aaN2TcVQ5A5R3+bCVhF9sAeqmMvw
         2DBzdj2jDUYSKt3Fn+Sg3MTHq1nb1/dyvCG5JNNxXb2Vq0y03W9IdT2JaWShXu3/fJ
         ZrhYInU/WwUJdto8XuYOWbaD49C2L5RIekL7gx09jXp9yzC3vex9cr4qxdUKmevZRh
         LBllhHeWHegoH50L6XIYRLgZJdEe2imZroek8rWPnj17Rt5vm8kzKqCm4DBEMETpyP
         QNGI0jxmTO+Q2r6eyFCPxbGkbGcnEWU0+dnK7JFFGMnMARJ5/xJpts9A8Y7OYhbVUG
         hMzUBxEJMDZCA==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 29/51] ceph: add some fscrypt guardrails
Date:   Tue, 22 Mar 2022 10:12:54 -0400
Message-Id: <20220322141316.41325-30-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the appropriate calls into fscrypt for various actions, including
link, rename, setattr, and the open codepaths.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c   |  8 ++++++++
 fs/ceph/file.c  | 14 +++++++++++++-
 fs/ceph/inode.c |  4 ++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 82a5f37e9d4a..8a9f916bfc6c 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1121,6 +1121,10 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
+	err = fscrypt_prepare_link(old_dentry, dir, dentry);
+	if (err)
+		return err;
+
 	dout("link in dir %p old_dentry %p dentry %p\n", dir,
 	     old_dentry, dentry);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LINK, USE_AUTH_MDS);
@@ -1318,6 +1322,10 @@ static int ceph_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
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
index 5832dcea2d8c..8a222ce5f8ce 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -372,8 +372,13 @@ int ceph_open(struct inode *inode, struct file *file)
 
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
@@ -842,6 +847,13 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
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
index fe006f189c0f..35e7ef462136 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2483,6 +2483,10 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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
2.35.1

