Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BBF600BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJQKGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJQKG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D4D111;
        Mon, 17 Oct 2022 03:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5378A6100B;
        Mon, 17 Oct 2022 10:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2176FC4347C;
        Mon, 17 Oct 2022 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666001177;
        bh=iWJzG298VZA6BRm9ykeKkQ3cBRDf48HraqlmWBBpLWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9loeSvFNME6vgrDS/XsMExHmDAOaJ4VbI2DUCDj7EWhNwuB/4r2qVJDvHMOZmcvI
         Q9jC/iRnScv1q6yKTrg9B7WbqtqMLuLWoEP96zFpCBYivME5GXAYQ8xYb1FSS82qGC
         LwzxjTjJ+teLh+W0BxC1FJAO96FjY6yKCcyQv8zA6m0sKPs0yUMD39u8MGghvSGDB+
         2/k8AxH57AVeZlCr4pXDLLxydgZ4C+Bur1FIEWgoqa79AbX7eUTWntReI/lNi9pXfK
         qcHpgvfXdZIayK3Ntk4htbcAaGsgDeFwNERNluTYQJNT9lwkq8E3KaHU+stWAaCJkx
         yZsu/kVyTRbHA==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/5] attr: add setattr_drop_sgid()
Date:   Mon, 17 Oct 2022 12:05:56 +0200
Message-Id: <20221017100600.70269-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017100600.70269-1-brauner@kernel.org>
References: <20221017100600.70269-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2634; i=brauner@kernel.org; h=from:subject; bh=iWJzG298VZA6BRm9ykeKkQ3cBRDf48HraqlmWBBpLWc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7avw+WVH0I1V6ycPwo02ibvsma9g1pN2P77dtunKX8y1v nMP6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIu8Z2R4dNRfXtdC9lBBh0fIFsf3Ov VuLvaXX+6KsNNVWLPuae5bhv/1r6Y9Nau/85C7573VSru6J7m//i767L/iSduFtU0Bs2bzAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In setattr_{copy,prepare}() we need to perform the same permission
checks to determine whether we need to drop the setgid bit or not.
Instead of open-coding it twice add a simple helper the encapsulates the
logic. We will reuse this helpers to make dropping the setgid bit during
write operations more consistent in a follow up patch.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    patch added
    
    /* v3 */
    Amir Goldstein <amir73il@gmail.com>:
    - Return 0 or ATTR_KILL_SGID to make all dropping helpers behave similarly.

 fs/attr.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 1552a5f23d6b..8bc2edd6bd3c 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -18,6 +18,27 @@
 #include <linux/evm.h>
 #include <linux/ima.h>
 
+/**
+ * setattr_drop_sgid - check generic setgid permissions
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @inode:	inode to check
+ * @vfsgid:	the new/current vfsgid of @inode
+ *
+ * This function determines whether the setgid bit needs to be removed because
+ * the caller lacks privileges over the inode.
+ *
+ * Return: ATTR_KILL_SGID if the setgid bit needs to be removed, 0 if not.
+ */
+static int setattr_drop_sgid(struct user_namespace *mnt_userns,
+			     const struct inode *inode, vfsgid_t vfsgid)
+{
+	if (vfsgid_in_group_p(vfsgid))
+		return 0;
+	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+		return 0;
+	return ATTR_KILL_SGID;
+}
+
 /**
  * chown_ok - verify permissions to chown inode
  * @mnt_userns:	user namespace of the mount @inode was found from
@@ -140,8 +161,7 @@ int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
 			vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
 
 		/* Also check the setgid bit! */
-		if (!vfsgid_in_group_p(vfsgid) &&
-		    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+		if (setattr_drop_sgid(mnt_userns, inode, vfsgid))
 			attr->ia_mode &= ~S_ISGID;
 	}
 
@@ -251,9 +271,8 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-		vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
-		if (!vfsgid_in_group_p(vfsgid) &&
-		    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+		if (setattr_drop_sgid(mnt_userns, inode,
+				      i_gid_into_vfsgid(mnt_userns, inode)))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
-- 
2.34.1

