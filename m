Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04BD342CC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 13:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCTM07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 08:26:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48193 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCTM0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:26:46 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNagi-0004Pf-VA; Sat, 20 Mar 2021 12:26:41 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/4] fs: document mapping helpers
Date:   Sat, 20 Mar 2021 13:26:21 +0100
Message-Id: <20210320122623.599086-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210320122623.599086-1-christian.brauner@ubuntu.com>
References: <20210320122623.599086-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document new helpers we introduced this cycle.

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced
- Christoph Hellwig <hch@lst.de>:
  - Add kernel docs to helpers.
---
 include/linux/fs.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..4795a632ef0d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1574,36 +1574,84 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
+/**
+ * kuid_into_mnt - map a kuid down into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kuid: kuid to be mapped
+ *
+ * Return @kuid mapped according to @mnt_userns.
+ * If @kuid has no mapping INVALID_UID is returned.
+ */
 static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
 				   kuid_t kuid)
 {
 	return make_kuid(mnt_userns, __kuid_val(kuid));
 }
 
+/**
+ * kgid_into_mnt - map a kgid down into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kgid: kgid to be mapped
+ *
+ * Return @kgid mapped according to @mnt_userns.
+ * If @kgid has no mapping INVALID_GID is returned.
+ */
 static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
 				   kgid_t kgid)
 {
 	return make_kgid(mnt_userns, __kgid_val(kgid));
 }
 
+/**
+ * i_uid_into_mnt - map an inode's i_uid down into a mnt_userns
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @inode: inode to map
+ *
+ * Return the inode's i_uid mapped down according to @mnt_userns.
+ * If the inode's i_uid has no mapping INVALID_UID is returned.
+ */
 static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
 				    const struct inode *inode)
 {
 	return kuid_into_mnt(mnt_userns, inode->i_uid);
 }
 
+/**
+ * i_gid_into_mnt - map an inode's i_gid down into a mnt_userns
+ * @mnt_userns: user namespace of the mount the inode was found from
+ * @inode: inode to map
+ *
+ * Return the inode's i_gid mapped down according to @mnt_userns.
+ * If the inode's i_gid has no mapping INVALID_GID is returned.
+ */
 static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 				    const struct inode *inode)
 {
 	return kgid_into_mnt(mnt_userns, inode->i_gid);
 }
 
+/**
+ * kuid_from_mnt - map a kuid up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kuid: kuid to be mapped
+ *
+ * Return @kuid mapped up according to @mnt_userns.
+ * If @kuid has no mapping INVALID_UID is returned.
+ */
 static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
 				   kuid_t kuid)
 {
 	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
 }
 
+/**
+ * kgid_from_mnt - map a kgid up into a mnt_userns
+ * @mnt_userns: user namespace of the relevant mount
+ * @kgid: kgid to be mapped
+ *
+ * Return @kgid mapped up according to @mnt_userns.
+ * If @kgid has no mapping INVALID_GID is returned.
+ */
 static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
 				   kgid_t kgid)
 {
-- 
2.27.0

