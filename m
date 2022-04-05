Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9B24F4D0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456276AbiDEXil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573584AbiDETXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3584A4A910;
        Tue,  5 Apr 2022 12:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9B9C61899;
        Tue,  5 Apr 2022 19:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C0BC385A3;
        Tue,  5 Apr 2022 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186465;
        bh=z6i7+1naGRJ17oSoDdDmMlOtJ7LJFiXxSfJ3S7KoaqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiQdlvTzhjRwJP6Mzz9TVIY8iE/q/hyXdo9g0rYao26aQZ1bdfKyHo0pqS6F14EzI
         ZXz4qCi4F2Gq9w+c/tqyiN3WVqfsLbQnm5lb6Ahhu5O34fp1IQ/uZhnjUmIJtYFVc2
         6DYDq4dqvi57kRsSE6E3RKRqP6EzO3tdm9tIQoxo2ypRSlnf58h2UXm3/aVDKuQjUr
         2f9my0R6nk11CuVC6dGcHEWAfex93Y/5WoVfxiBprna+/TwpIIa84GLl6HL2qr1mke
         XF8yl3o6S+ZwgNGiRIbVP1awnZnjxEVq64YkI6shrd0CtpjCZ+IANo8V+1G1rBu3JP
         53BgivWs/Bwlw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 36/59] ceph: add some fscrypt guardrails
Date:   Tue,  5 Apr 2022 15:20:07 -0400
Message-Id: <20220405192030.178326-37-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index dfc02caf4229..a3afdb9cfddb 100644
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
@@ -847,6 +852,13 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
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
index bb1b1a57970c..183b9f52dc7d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2487,6 +2487,10 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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

