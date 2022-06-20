Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1082551EDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiFTOfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbiFTOeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C12606
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 966446151E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jun 2022 13:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4D5C341C4;
        Mon, 20 Jun 2022 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655733005;
        bh=SHWz8/Nptjbs1CdF29Y8vyjXxVb7fJzV+De/DgK+/TA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YuY+uVvMKM+kLH/b1dItyo3rc+ehMrf3o7jeX3bpYtF7m0l0EDChLD+SKB4T0eGEQ
         kN1q/ruzZgz+j6TS0DBnaegHpo3gsyDxdrKMWarZbGI1nxQ1Yxp3q6wRPF+sDhIJWW
         8VRwdRjc46qGs/ZhKvzbODfELSNFUIC/IVvs/Mv1dzOv81ZTwdJ4oUdIOhgbhpa9uQ
         WHF4l4O3SrJEIP/IkeGiVpKE98GNF3XUsZRADqCAwcT7rY9dEmjFQn2RS/1gYntFNH
         Uf8crr6zVFd54NkMtYRHftGKGQKLixkPopDMXPCqL7cMU0yIRBk8gRLEazmJ1ykusT
         lbN2zvcpY5rXg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/8] fs: add two type safe mapping helpers
Date:   Mon, 20 Jun 2022 15:49:41 +0200
Message-Id: <20220620134947.2772863-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620134947.2772863-1-brauner@kernel.org>
References: <20220620134947.2772863-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3434; h=from:subject; bh=SHWz8/Nptjbs1CdF29Y8vyjXxVb7fJzV+De/DgK+/TA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRtqHr9Qqbj7zT515ca1xRZdHGs/fpxxtkVURafptyZrvih 94AHT0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE8vUZ/ud06n3vqDHV++8VdP7TQa XFv++FXdzMoPKC9VSXibuM1UWGf5Ysu/dMSj8nsy5wYZ3ivDWWC+uXMC/5N7Xvd4jJtU0ixzgA
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

Introduce i_{g,u}id_into_mnt{g,u}id(). They return kmnt{g,u}id_t. This
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
 include/linux/fs.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..8724a31b95e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1600,6 +1600,9 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
  * @mnt_userns: user namespace of the mount the inode was found from
  * @inode: inode to map
  *
+ * Note, this will eventually be removed completely in favor of the type-safe
+ * i_uid_into_mntuid().
+ *
  * Return: the inode's i_uid mapped down according to @mnt_userns.
  * If the inode's i_uid has no mapping INVALID_UID is returned.
  */
@@ -1609,11 +1612,28 @@ static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
 	return mapped_kuid_fs(mnt_userns, i_user_ns(inode), inode->i_uid);
 }
 
+/**
+ * i_uid_into_mntuid - map an inode's i_uid down into a mnt_userns
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @inode: inode to map
+ *
+ * Return: whe inode's i_uid mapped down according to @mnt_userns.
+ * If the inode's i_uid has no mapping INVALID_KMNTUID is returned.
+ */
+static inline kmntuid_t i_uid_into_mntuid(struct user_namespace *mnt_userns,
+					  const struct inode *inode)
+{
+	return KMNTUIDT_INIT(i_uid_into_mnt(mnt_userns, inode));
+}
+
 /**
  * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
  * @mnt_userns: user namespace of the mount the inode was found from
  * @inode: inode to map
  *
+ * Note, this will eventually be removed completely in favor of the type-safe
+ * i_gid_into_mntgid().
+ *
  * Return: the inode's i_gid mapped down according to @mnt_userns.
  * If the inode's i_gid has no mapping INVALID_GID is returned.
  */
@@ -1623,6 +1643,23 @@ static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 	return mapped_kgid_fs(mnt_userns, i_user_ns(inode), inode->i_gid);
 }
 
+/**
+ * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @inode: inode to map
+ *
+ * Note, this will eventually be removed completely in favor of the type-safe
+ * i_gid_into_mntgid().
+ *
+ * Return: the inode's i_gid mapped down according to @mnt_userns.
+ * If the inode's i_gid has no mapping INVALID_KMNTGID is returned.
+ */
+static inline kmntgid_t i_gid_into_mntgid(struct user_namespace *mnt_userns,
+					  const struct inode *inode)
+{
+	return KMNTGIDT_INIT(i_gid_into_mnt(mnt_userns, inode));
+}
+
 /**
  * inode_fsuid_set - initialize inode's i_uid field with callers fsuid
  * @inode: inode to initialize
-- 
2.34.1

