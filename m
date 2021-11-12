Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABCF44E6A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhKLMrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4087 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhKLMre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:34 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HrJ7k6NSxz67bR7;
        Fri, 12 Nov 2021 20:39:46 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 13:44:41 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ebiggers@kernel.org>, <tytso@mit.edu>, <corbet@lwn.net>,
        <viro@zeniv.linux.org.uk>, <hughd@google.com>,
        <akpm@linux-foundation.org>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 2/5] fsverity: Revalidate built-in signatures at file open
Date:   Fri, 12 Nov 2021 13:44:08 +0100
Message-ID: <20211112124411.1948809-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112124411.1948809-1-roberto.sassu@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fsverity signatures are validated only upon request by the user by setting
the requirement through procfs or sysctl.

However, signatures are validated only when the fsverity-related
initialization is performed on the file. If the initialization happened
while the signature requirement was disabled, the signature is not
validated again.

Keep track in the fsverity_info structure if the signature was validated
and, based on that and on the signature requirement, perform signature
validation at every call of fsverity_file_open() (the behavior remains the
same if the requirement is not set).

Finally, expose the information of whether the signature was validated
through the new function fsverity_sig_validated(). It could be used for
example by IPE to enforce the signature requirement in a mandatory way (the
procfs/sysctl methods are discretionary).

NOTE: revalidation is not performed if the keys in the fs-verity keyring
changed; this would probably require a more sophisticated mechanism such as
one based on sequence numbers.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/verity/fsverity_private.h |  7 +++++--
 fs/verity/open.c             | 19 ++++++++++++++++++-
 fs/verity/signature.c        |  6 ++++--
 include/linux/fsverity.h     |  6 ++++++
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index a7920434bae5..bcd5c0587e42 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -75,6 +75,7 @@ struct fsverity_info {
 	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
 	const struct inode *inode;
+	bool sig_validated;
 };
 
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
@@ -138,14 +139,16 @@ void __init fsverity_exit_info_cache(void);
 
 /* signature.c */
 
+extern int fsverity_require_signatures;
+
 #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
-int fsverity_verify_signature(const struct fsverity_info *vi,
+int fsverity_verify_signature(struct fsverity_info *vi,
 			      const u8 *signature, size_t sig_size);
 
 int __init fsverity_init_signature(void);
 #else /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
 static inline int
-fsverity_verify_signature(const struct fsverity_info *vi,
+fsverity_verify_signature(struct fsverity_info *vi,
 			  const u8 *signature, size_t sig_size)
 {
 	return 0;
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 9127c77c6539..22c6644b0282 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -242,6 +242,17 @@ ssize_t fsverity_get_file_digest(struct fsverity_info *info, u8 *buf,
 	return hash_digest_size[*algo];
 }
 
+/*
+ * Provide the information of whether the fsverity built-in signature was
+ * validated.
+ *
+ * Return: true if the signature was validated, false if not
+ */
+bool fsverity_sig_validated(struct fsverity_info *info)
+{
+	return info->sig_validated;
+}
+
 static bool validate_fsverity_descriptor(struct inode *inode,
 					 const struct fsverity_descriptor *desc,
 					 size_t desc_size)
@@ -333,13 +344,19 @@ static int ensure_verity_info(struct inode *inode)
 	size_t desc_size;
 	int err;
 
-	if (vi)
+	if (vi && (!fsverity_require_signatures || vi->sig_validated))
 		return 0;
 
 	err = fsverity_get_descriptor(inode, &desc, &desc_size);
 	if (err)
 		return err;
 
+	if (vi) {
+		err = fsverity_verify_signature(vi, desc->signature,
+						le32_to_cpu(desc->sig_size));
+		goto out_free_desc;
+	}
+
 	vi = fsverity_create_info(inode, desc, desc_size);
 	if (IS_ERR(vi)) {
 		err = PTR_ERR(vi);
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 143a530a8008..dbe6b3b0431c 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -16,7 +16,7 @@
  * /proc/sys/fs/verity/require_signatures
  * If 1, all verity files must have a valid builtin signature.
  */
-static int fsverity_require_signatures;
+int fsverity_require_signatures;
 
 /*
  * Keyring that contains the trusted X.509 certificates.
@@ -37,7 +37,7 @@ static struct key *fsverity_keyring;
  *
  * Return: 0 on success (signature valid or not required); -errno on failure
  */
-int fsverity_verify_signature(const struct fsverity_info *vi,
+int fsverity_verify_signature(struct fsverity_info *vi,
 			      const u8 *signature, size_t sig_size)
 {
 	const struct inode *inode = vi->inode;
@@ -82,6 +82,8 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 		return err;
 	}
 
+	vi->sig_validated = true;
+
 	pr_debug("Valid signature for file digest %s:%*phN\n",
 		 hash_alg->name, hash_alg->digest_size, vi->file_digest);
 	return 0;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 877a7f609dd9..85e52333d1b8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -140,6 +140,7 @@ int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void fsverity_cleanup_inode(struct inode *inode);
 ssize_t fsverity_get_file_digest(struct fsverity_info *info, u8 *buf,
 				 size_t bufsize, enum hash_algo *algo);
+bool fsverity_sig_validated(struct fsverity_info *info);
 
 /* read_metadata.c */
 
@@ -197,6 +198,11 @@ static inline ssize_t fsverity_get_file_digest(struct fsverity_info *info,
 	return -EOPNOTSUPP;
 }
 
+static inline bool fsverity_sig_validated(struct fsverity_info *info)
+{
+	return false;
+}
+
 /* read_metadata.c */
 
 static inline int fsverity_ioctl_read_metadata(struct file *filp,
-- 
2.32.0

