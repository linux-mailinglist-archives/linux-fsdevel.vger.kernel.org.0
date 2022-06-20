Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149E8551EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiFTOfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiFTOeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3389B62FF
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5988B80EA6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B3C341C5;
        Mon, 20 Jun 2022 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733009;
        bh=Klv+2Slv/OB3rUIilwi1lRC1SCM4KTOuZHYm19O+zSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKkSVYo1tBDAKgZ1UXPjgnsESJrYKv6vAupVVZ281/XyitoCoJIccI5rURMKnqeK9
         eGkenrWBol0TW0MjhhRx3P0vJrZvwtlNrB2BuRX7VdC+pCr5bXt2dX7AURFPKif+Fi
         uWIM6l6fA2qUjoEPMQquk1stG1m8WvBAxcRSnvwqbp+X+gZLSnGRKQhUQ+9oW3YqWW
         DygctoHB0niyab4xnWfTDhSG4o+zf5e8xuCx1M+2Bsk9WkSVmuWwXn2s1BMgwURb/o
         zPcPcMQrpR6Xa0JPv8ILoz78tEuJzY1FRoQdgvN5gKYbtmlcfpsysgGf4pFXcxuDp8
         dRGG2nSWkBhQA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/8] fs: introduce tiny iattr ownership update helpers
Date:   Mon, 20 Jun 2022 15:49:43 +0200
Message-Id: <20220620134947.2772863-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620134947.2772863-1-brauner@kernel.org>
References: <20220620134947.2772863-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4790; h=from:subject; bh=Klv+2Slv/OB3rUIilwi1lRC1SCM4KTOuZHYm19O+zSE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHpT+nfyVQEOhmNfE/2WORw8es5V8rHeJO3Hb6ZrN5rn JAid6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjICiVGhmmCwftXCN+rY53IkmK4KH GRb/HNoivXd4oVrBHe8vzDByNGhl87SmbYL5u5MDfWPT7wWtjMpYdsFz+XtD3nWDtJa5adBwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nearly all fileystems currently open-code the same checks for
determining whether the i{g,u}_id fields of an inode need to be updated
and then updating the fields.

Introduce tiny helpers i_{g,u}id_needs_update() and i_{g,u}id_update()
that wrap this logic. This allows filesystems to not care updating
inode->i_{g,u}id with the correct values themselves instead leaving this
to the helpers.

We also get rid of a lot of code duplication and make it easier to
change struct iattr in the future since changes can be localized to
these helpers.

And finally we make it hard to conflate k{g,u}id_t types with
kmnt{g,u}id_t types for filesystems that support idmapped mounts.

In the following patch we will port all filesystems that raise
FS_ALLOW_IDMAP to use the new helpers. However, the ultimate goal is to
convert all filesystems to make use of these helpers.

All new helpers are nops on non-idmapped mounts.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 include/linux/fs.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0da6c0481dbd..998ac36ea7b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1640,6 +1640,44 @@ static inline kmntuid_t i_uid_into_mntuid(struct user_namespace *mnt_userns,
 	return KMNTUIDT_INIT(i_uid_into_mnt(mnt_userns, inode));
 }
 
+/**
+ * i_uid_needs_update - check whether inode's i_uid needs to be updated
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @attr: the new attributes of @inode
+ * @inode: the inode to update
+ *
+ * Check whether the $inode's i_uid field needs to be updated taking idmapped
+ * mounts into account if the filesystem supports it.
+ *
+ * Return: true if @inode's i_uid field needs to be updated, false if not.
+ */
+static inline bool i_uid_needs_update(struct user_namespace *mnt_userns,
+				      const struct iattr *attr,
+				      const struct inode *inode)
+{
+	return ((attr->ia_valid & ATTR_UID) &&
+		!kmntuid_eq(attr->ia_mntuid,
+			    i_uid_into_mntuid(mnt_userns, inode)));
+}
+
+/**
+ * i_uid_update - update @inode's i_uid field
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @attr: the new attributes of @inode
+ * @inode: the inode to update
+ *
+ * Safely update @inode's i_uid field translating the kmntuid of any idmapped
+ * mount into the filesystem kuid.
+ */
+static inline void i_uid_update(struct user_namespace *mnt_userns,
+				const struct iattr *attr,
+				struct inode *inode)
+{
+	if (attr->ia_valid & ATTR_UID)
+		inode->i_uid = kmntuid_to_kuid(mnt_userns, i_user_ns(inode),
+					       attr->ia_mntuid);
+}
+
 /**
  * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
  * @mnt_userns: user namespace of the mount the inode was found from
@@ -1674,6 +1712,44 @@ static inline kmntgid_t i_gid_into_mntgid(struct user_namespace *mnt_userns,
 	return KMNTGIDT_INIT(i_gid_into_mnt(mnt_userns, inode));
 }
 
+/**
+ * i_gid_needs_update - check whether inode's i_gid needs to be updated
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @attr: the new attributes of @inode
+ * @inode: the inode to update
+ *
+ * Check whether the $inode's i_gid field needs to be updated taking idmapped
+ * mounts into account if the filesystem supports it.
+ *
+ * Return: true if @inode's i_gid field needs to be updated, false if not.
+ */
+static inline bool i_gid_needs_update(struct user_namespace *mnt_userns,
+				      const struct iattr *attr,
+				      const struct inode *inode)
+{
+	return ((attr->ia_valid & ATTR_GID) &&
+		!kmntgid_eq(attr->ia_mntgid,
+			    i_gid_into_mntgid(mnt_userns, inode)));
+}
+
+/**
+ * i_gid_update - update @inode's i_gid field
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @attr: the new attributes of @inode
+ * @inode: the inode to update
+ *
+ * Safely update @inode's i_gid field translating the kmntgid of any idmapped
+ * mount into the filesystem kgid.
+ */
+static inline void i_gid_update(struct user_namespace *mnt_userns,
+				const struct iattr *attr,
+				struct inode *inode)
+{
+	if (attr->ia_valid & ATTR_GID)
+		inode->i_gid = kmntgid_to_kgid(mnt_userns, i_user_ns(inode),
+					       attr->ia_mntgid);
+}
+
 /**
  * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
  * @inode: inode to initialize
-- 
2.34.1

