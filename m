Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60C5553447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351098AbiFUOPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 10:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351040AbiFUOPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE621E15
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 07:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5A061653
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4867C341C6;
        Tue, 21 Jun 2022 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655820916;
        bh=sOepuIehWFfejNM7lv2Ncuo0kxy422dwpI9LgIcFjJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnC3NVPTht1vjCj6oe7atZtKRPcXOM1BI4KNhs/ByvOxFbIkbplYRvPBinesU0YOT
         JJzw2XE43p9+/kLJhB6zYOKn/z9wlpwEBNwqH7freEJZd03x0XIB5QWTsuh99cV05U
         d4EWpRXWn8pu1gmkK05ewEVInQuTV4hPygBjSM1pDNKyRG6Q/2slNTHBGK2h0QRYX3
         b1bsW35ZbXyvdjRt8YxtermhGQ97xGKtOoZheL6jPRgupFi7rig5m0quypbTWVhtWc
         iRcgqyUaQBpKR1UjvaSuZ3FDTjyXJ4OlIpwRpZNnq4ZQ4HNDDQkmr666Yiao2wgBtE
         6cApxH5Vd5Cpw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 4/8] fs: introduce tiny iattr ownership update helpers
Date:   Tue, 21 Jun 2022 16:14:50 +0200
Message-Id: <20220621141454.2914719-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621141454.2914719-1-brauner@kernel.org>
References: <20220621141454.2914719-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4890; h=from:subject; bh=sOepuIehWFfejNM7lv2Ncuo0kxy422dwpI9LgIcFjJY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtvBTO6bXpV5PSjx93zqUt2uomcls+bb66arHl+gMrop8n O2h3dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEk4OR4ZecTZvbmhjndYe5i2V2ps xYO/3sF6ZEjqS8eo957L7xOYwMP07syb787exiPbtlD52aTTUd3l72eX1/7sU6ZttLnxtv8AAA
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
determining whether the i_{g,u}id fields of an inode need to be updated
and then updating the fields.

Introduce tiny helpers i_{g,u}id_needs_update() and i_{g,u}id_update()
that wrap this logic. This allows filesystems to not care about updating
inode->i_{g,u}id with the correct values themselves instead leaving this
to the helpers.

We also get rid of a lot of code duplication and make it easier to
change struct iattr in the future since changes can be localized to
these helpers.

And finally we make it hard to conflate k{g,u}id_t types with
vfs{g,u}id_t types for filesystems that support idmapped mounts.

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
/* v2 */
- Linus Torvalds <torvalds@linux-foundation.org>:
  - Rename s/kmnt{g,u}id_t/vfs{g,u}id_t/g
---
 include/linux/fs.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 642627b3fa53..770f4817e330 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1640,6 +1640,44 @@ static inline vfsuid_t i_uid_into_vfsuid(struct user_namespace *mnt_userns,
 	return VFSUIDT_INIT(i_uid_into_mnt(mnt_userns, inode));
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
+		!vfsuid_eq(attr->ia_vfsuid,
+			   i_uid_into_vfsuid(mnt_userns, inode)));
+}
+
+/**
+ * i_uid_update - update @inode's i_uid field
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @attr: the new attributes of @inode
+ * @inode: the inode to update
+ *
+ * Safely update @inode's i_uid field translating the vfsuid of any idmapped
+ * mount into the filesystem kuid.
+ */
+static inline void i_uid_update(struct user_namespace *mnt_userns,
+				const struct iattr *attr,
+				struct inode *inode)
+{
+	if (attr->ia_valid & ATTR_UID)
+		inode->i_uid = vfsuid_to_kuid(mnt_userns, i_user_ns(inode),
+					      attr->ia_vfsuid);
+}
+
 /**
  * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
  * @mnt_userns: user namespace of the mount the inode was found from
@@ -1671,6 +1709,44 @@ static inline vfsgid_t i_gid_into_vfsgid(struct user_namespace *mnt_userns,
 	return VFSGIDT_INIT(i_gid_into_mnt(mnt_userns, inode));
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
+		!vfsgid_eq(attr->ia_vfsgid,
+			   i_gid_into_vfsgid(mnt_userns, inode)));
+}
+
+/**
+ * i_gid_update - update @inode's i_gid field
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @attr: the new attributes of @inode
+ * @inode: the inode to update
+ *
+ * Safely update @inode's i_gid field translating the vfsgid of any idmapped
+ * mount into the filesystem kgid.
+ */
+static inline void i_gid_update(struct user_namespace *mnt_userns,
+				const struct iattr *attr,
+				struct inode *inode)
+{
+	if (attr->ia_valid & ATTR_GID)
+		inode->i_gid = vfsgid_to_kgid(mnt_userns, i_user_ns(inode),
+					      attr->ia_vfsgid);
+}
+
 /**
  * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
  * @inode: inode to initialize
-- 
2.34.1

