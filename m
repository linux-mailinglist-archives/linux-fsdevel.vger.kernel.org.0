Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569FC5F796F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJGOGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJGOGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:06:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9536F9DDBC;
        Fri,  7 Oct 2022 07:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 525B2B8233B;
        Fri,  7 Oct 2022 14:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AE1C433C1;
        Fri,  7 Oct 2022 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665151564;
        bh=z2CK+WuCE6irKy/QV9yN5tmtG4JNJv7MRR9Sje3YZek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvCj0bd+ohMdrdTTh+BoAZDCtLVoHf/YeK+NbnniCqDQd59ipIHXjd9R7FRXQ60xe
         /64X/Jy3OP5CFvi82f605Ng0vjMF4DOvtkWwYM8zeIPKnGm33HIQAxQASL2TgrKSC0
         4kMClOpb148ooszvcXOdCAluGf5Mjc8+u6kKK39iQVoZlL7q5bZhemd6D4YZdM2iny
         zRbUJindx+k6xseSyINZzh0WXR934M4HKwqbixdT55ad8KA/dvLKP2kblLCyy0ACw3
         Avik4MEOfXsyn7nQ8X3lazs0BZLKdDVav+ObT70RhWvIdyDsnP5pT4bPpfqsJjb0JH
         7woj7dHGoJHrg==
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
Subject: [PATCH v2 1/5] attr: add setattr_drop_sgid()
Date:   Fri,  7 Oct 2022 16:05:39 +0200
Message-Id: <20221007140543.1039983-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007140543.1039983-1-brauner@kernel.org>
References: <20221007140543.1039983-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=brauner@kernel.org; h=from:subject; bh=z2CK+WuCE6irKy/QV9yN5tmtG4JNJv7MRR9Sje3YZek=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ7GOknuvy+/OnP1LX1kpr1N2dcOVXUdrGlx/rd4ek+oWa7 3n0+21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARXSOGfxrFO3kfvL36JVPmQ63Q2r VPa+a8WBWn8PvhmuWfW+TfRa9g+J/n8NRCc09pQzn73IhXymcr3okdD8nbXvHVXlP5r4HXYTYA
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

 fs/attr.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 1552a5f23d6b..b1cff6f5b715 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -18,6 +18,27 @@
 #include <linux/evm.h>
 #include <linux/ima.h>
 
+/**
+ * setattr_drop_sgid - check generic setgid permissions
+ * @mnt_userns:	User namespace of the mount the inode was created from
+ * @inode: inode to check
+ * @vfsgid: the new/current vfsgid of @inode
+ *
+ * This function determines whether the setgid bit needs to be removed because
+ * the caller lacks privileges over the inode.
+ *
+ * Return: true if the setgid bit needs to be removed, false if not.
+ */
+static bool setattr_drop_sgid(struct user_namespace *mnt_userns,
+			      const struct inode *inode, vfsgid_t vfsgid)
+{
+	if (vfsgid_in_group_p(vfsgid))
+		return false;
+	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+		return false;
+	return true;
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

