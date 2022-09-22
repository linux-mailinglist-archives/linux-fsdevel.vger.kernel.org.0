Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13615E66DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIVPT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiIVPSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07635F0888
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 08:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73577B83840
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 15:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93C8C4347C;
        Thu, 22 Sep 2022 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859902;
        bh=8sBGiHTdqqGc3hueinqpJkPCJddsQQq2B5KQ3AnbMrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNokqEmQrIulJVZtQ75HepkRyWnEEfq4EKBXW5LOAzZ7n1o9veCWkwCZFi5DMFdc1
         6TH/Q/W7wiTbS1q+WOweUf2v95ZTr+wOYlEjAwyHBHzqszUlVoj9g9h5rO5B50lkA2
         EOBuPC2/3selYaLrwuVl1m8l/vtOlYEoHUZvyOfg3PXmXx40lLchcDJ/lFJILydGmD
         83lPlsVTkD6XKBPaaO4syvn4oQ7s161d0DEibRKYxZZQJf2cVGxxkkqwkpfo6ESm+g
         Kh6LXrHOheccpYVLuoM8GkguZW2Zz5NNwHIUTdmUNa/aFM25/iW78ctU+Fc+5/iwEA
         lHJUU/Q3d8IyQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 16/29] acl: add vfs_remove_acl()
Date:   Thu, 22 Sep 2022 17:17:14 +0200
Message-Id: <20220922151728.1557914-17-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3997; i=brauner@kernel.org; h=from:subject; bh=8sBGiHTdqqGc3hueinqpJkPCJddsQQq2B5KQ3AnbMrI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1FTxm+at+ha1QZ2lu7xx96HD+wxEHAzF1v/6bs1ZILM0 pCSso5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKn/jP8T5uvfuzDlP3TFx/O6J66uU XnT1mP73HVWVF6nT9sZ236uIiRYYrc9FXy+zRuCMct961h0TtolbW2fMtWS8NN5Q2aCV4VbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In previous patches we implemented get and set inode operations for all
non-stacking filesystems that support posix acls but didn't yet
implement get and/or set acl inode operations. This specifically
affected cifs and 9p.

Now we can build a posix acl api based solely on get and set inode
operations. We add a new vfs_remove_acl() api that can be used to set
posix acls. This finally removes all type unsafety and type conversion
issues explained in detail in [1] that we aim to get rid of.

After we finished building the vfs api we can switch stacking
filesystems to rely on the new posix api and then finally switch the
xattr system calls themselves to rely on the posix acl api.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c            | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/posix_acl.h |  8 +++++
 2 files changed, 73 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index e2d90dc37269..0c44a8008259 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1490,3 +1490,68 @@ struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 	return acl;
 }
 EXPORT_SYMBOL(vfs_get_acl);
+
+/**
+ * vfs_remove_acl - remove posix acls
+ * @mnt_userns: user namespace of the mount
+ * @dentry: the dentry based on which to retrieve the posix acls
+ * @acl_name: the name of the posix acl
+ *
+ * This function removes posix acls.
+ *
+ * Return: On success 0, on error negative errno.
+ */
+int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *acl_name)
+{
+	int acl_type;
+	int error;
+	struct inode *inode = d_inode(dentry);
+	struct inode *delegated_inode = NULL;
+
+	acl_type = posix_acl_type(acl_name);
+	if (acl_type < 0)
+		return -EINVAL;
+
+retry_deleg:
+	inode_lock(inode);
+
+	/*
+	 * We only care about restrictions the inode struct itself places upon
+	 * us otherwise POSIX ACLs aren't subject to any VFS restrictions.
+	 */
+	error = xattr_permission(mnt_userns, inode, acl_name, MAY_WRITE);
+	if (error)
+		goto out_inode_unlock;
+
+	error = security_inode_removexattr(mnt_userns, dentry, acl_name);
+	if (error)
+		goto out_inode_unlock;
+
+	error = try_break_deleg(inode, &delegated_inode);
+	if (error)
+		goto out_inode_unlock;
+
+	if (inode->i_opflags & IOP_XATTR)
+		error = set_posix_acl(mnt_userns, dentry, acl_type, NULL);
+	else if (unlikely(is_bad_inode(inode)))
+		error = -EIO;
+	else
+		error = -EOPNOTSUPP;
+	if (!error) {
+		fsnotify_xattr(dentry);
+		evm_inode_post_removexattr(dentry, acl_name);
+	}
+
+out_inode_unlock:
+	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(vfs_remove_acl);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 95c42ca2eb8d..5b7c494398ea 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -104,6 +104,8 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		const char *acl_name, struct posix_acl *kacl);
 struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, const char *acl_name);
+int vfs_remove_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   const char *acl_name);
 #else
 static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
 				  struct dentry *dentry, umode_t mode)
@@ -145,6 +147,12 @@ static inline struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
 {
 	return NULL;
 }
+
+static inline int vfs_remove_acl(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *acl_name)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_POSIX_ACL */
 
 struct posix_acl *get_acl(struct inode *inode, int type);
-- 
2.34.1

