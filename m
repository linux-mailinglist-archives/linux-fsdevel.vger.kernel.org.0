Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D547553448
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351057AbiFUOPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 10:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350853AbiFUOPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:15:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714C4205F5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 07:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0931DB817F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 14:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EFAC341C6;
        Tue, 21 Jun 2022 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655820911;
        bh=SMDqWvSPyMK2kHx5FbBDAIXsvYddrqx/ocnshxKcrO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dus0MZUaWkNdYT6mq1XZWbm0Oq9kV3wUrmiKrP3mK7JyNPbd7Cs6GbeSXAJ/rjwGR
         uyWjLK1wtUuWZ2pLiklN4QgV7RwU8sApA2OL++l3rPrzGzCBKe6UelIozjVgrUZM3r
         kEfX1CoSg6J02yhpVv+Zn5S94NsxD7PKs5SXH9VrHSUz++dRKxmQiCq+hVRHzS3ffx
         zP2QKDoz3JEk4JvT/Uf6O5BPjSnMBdIOdlzCbNbeYbyB8n5vmcqIG3zBWwdlelyzOG
         FMHJTCbnupEGIxqruEZp8L0ceV9RuXCvYnks/8o59zL5kY0VvNqCzbJb4Hv9NCnM84
         ZDJ9LfYt41qqg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 2/8] fs: add two type safe mapping helpers
Date:   Tue, 21 Jun 2022 16:14:48 +0200
Message-Id: <20220621141454.2914719-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621141454.2914719-1-brauner@kernel.org>
References: <20220621141454.2914719-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3420; h=from:subject; bh=SMDqWvSPyMK2kHx5FbBDAIXsvYddrqx/ocnshxKcrO8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtvBRWYqUy56lGhLAhv/HTO2ETNmw/GJ2tz3Jv7RGrC78z ZgQJd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkdgLD/4Qj/H63Ft3c9Up0SWJdFM PpY7t2+DNJWf/aIW28XX/qGwFGhqmC/n1dKh2x338q6HtWPby/Vd5KctXEtICDryozlmvmswMA
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

Introduce i_{g,u}id_into_vfs{g,u}id(). They return vfs{g,u}id_t. This
makes it way harder to confused idmapped mount {g,u}ids with filesystem
{g,u}ids.

The two helpers will eventually replace the old non type safe
i_{g,u}id_into_mnt() helpers once we finished converting all places. Add
a comment noting that they will be removed in the future.

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
 include/linux/fs.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..2c0e8d634bc4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1600,6 +1600,9 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
  * @mnt_userns: user namespace of the mount the inode was found from
  * @inode: inode to map
  *
+ * Note, this will eventually be removed completely in favor of the type-safe
+ * i_uid_into_vfsuid().
+ *
  * Return: the inode's i_uid mapped down according to @mnt_userns.
  * If the inode's i_uid has no mapping INVALID_UID is returned.
  */
@@ -1609,11 +1612,28 @@ static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
 	return mapped_kuid_fs(mnt_userns, i_user_ns(inode), inode->i_uid);
 }
 
+/**
+ * i_uid_into_vfsuid - map an inode's i_uid down into a mnt_userns
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @inode: inode to map
+ *
+ * Return: whe inode's i_uid mapped down according to @mnt_userns.
+ * If the inode's i_uid has no mapping INVALID_VFSUID is returned.
+ */
+static inline vfsuid_t i_uid_into_vfsuid(struct user_namespace *mnt_userns,
+					 const struct inode *inode)
+{
+	return VFSUIDT_INIT(i_uid_into_mnt(mnt_userns, inode));
+}
+
 /**
  * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
  * @mnt_userns: user namespace of the mount the inode was found from
  * @inode: inode to map
  *
+ * Note, this will eventually be removed completely in favor of the type-safe
+ * i_gid_into_vfsgid().
+ *
  * Return: the inode's i_gid mapped down according to @mnt_userns.
  * If the inode's i_gid has no mapping INVALID_GID is returned.
  */
@@ -1623,6 +1643,20 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 	return mapped_kgid_fs(mnt_userns, i_user_ns(inode), inode->i_gid);
 }
 
+/**
+ * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @inode: inode to map
+ *
+ * Return: the inode's i_gid mapped down according to @mnt_userns.
+ * If the inode's i_gid has no mapping INVALID_VFSGID is returned.
+ */
+static inline vfsgid_t i_gid_into_vfsgid(struct user_namespace *mnt_userns,
+					 const struct inode *inode)
+{
+	return VFSGIDT_INIT(i_gid_into_mnt(mnt_userns, inode));
+}
+
 /**
  * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
  * @inode: inode to initialize
-- 
2.34.1

