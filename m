Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD65F2F8401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbhAOSUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388270AbhAOSUO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9308E23A5E;
        Fri, 15 Jan 2021 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734772;
        bh=pnSpeOrfVdsQbidSVJ8VQ9KwStcDDpOuhhsM9wOH/nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOzDaPKRnueyCaOwugViCqx2ufgeTgSyZJuXHoHj+EWmWBeGBSq3rVN9H8KnHmvRT
         vWX40lG+SD+bCDG7wH5vF2qtiqALPqkwB0KMw2M6g9ChPX3lP27q51zHo7s9EKkDYR
         fQxjHEnpWRVJYLn1MFma7sCHPto+1/nd1b8+z0uLqTiUVVktoX9+MwLdoqPhP7wFep
         39ZG4ZpVXDfbaN3EgU+rGvi3WYmJfxsntpc+SLd3zsi/k0VYHCZtObLObIvH5NkaNZ
         UCOKc2ptZ7mFX3lAXpuS7hfaSuH9edKF6DuKv0w4e4v37ek7fYz2+JTG4OXrDIF9jf
         xkb/k3jRJp/ag==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 1/6] fs-verity: factor out fsverity_get_descriptor()
Date:   Fri, 15 Jan 2021 10:18:14 -0800
Message-Id: <20210115181819.34732-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115181819.34732-1-ebiggers@kernel.org>
References: <20210115181819.34732-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The FS_IOC_READ_VERITY_METADATA ioctl will need to return the fs-verity
descriptor (and signature) to userspace.

There are a few ways we could implement this:

- Save a copy of the descriptor (and signature) in the fsverity_info
  struct that hangs off of the in-memory inode.  However, this would
  waste memory since most of the time it wouldn't be needed.

- Regenerate the descriptor from the merkle_tree_params in the
  fsverity_info.  However, this wouldn't work for the signature, nor for
  the salt which the merkle_tree_params only contains indirectly as part
  of the 'hashstate'.  It would also be error-prone.

- Just get them from the filesystem again.  The disadvantage is that in
  general we can't trust that they haven't been maliciously changed
  since the file has opened.  However, the use cases for
  FS_IOC_READ_VERITY_METADATA don't require that it verifies the chain
  of trust.  So this is okay as long as we do some basic validation.

In preparation for implementing the third option, factor out a helper
function fsverity_get_descriptor() which gets the descriptor (and
appended signature) from the filesystem and does some basic validation.

As part of this, start checking the sig_size field for overflow.
Currently fsverity_verify_signature() does this.  But the new ioctl will
need this too, so do it earlier.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h |   7 +-
 fs/verity/open.c             | 130 +++++++++++++++++++++++------------
 2 files changed, 91 insertions(+), 46 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 6413d28664d6d..6c9caccc06021 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -122,12 +122,17 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 				     const u8 *salt, size_t salt_size);
 
 struct fsverity_info *fsverity_create_info(const struct inode *inode,
-					   void *desc, size_t desc_size);
+					   struct fsverity_descriptor *desc,
+					   size_t desc_size);
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
 
 void fsverity_free_info(struct fsverity_info *vi);
 
+int fsverity_get_descriptor(struct inode *inode,
+			    struct fsverity_descriptor **desc_ret,
+			    size_t *desc_size_ret);
+
 int __init fsverity_init_info_cache(void);
 void __init fsverity_exit_info_cache(void);
 
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 228d0eca3e2e5..a987bb785e9b0 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -142,45 +142,17 @@ static int compute_file_digest(struct fsverity_hash_alg *hash_alg,
 }
 
 /*
- * Validate the given fsverity_descriptor and create a new fsverity_info from
- * it.  The signature (if present) is also checked.
+ * Create a new fsverity_info from the given fsverity_descriptor (with optional
+ * appended signature), and check the signature if present.  The
+ * fsverity_descriptor must have already undergone basic validation.
  */
 struct fsverity_info *fsverity_create_info(const struct inode *inode,
-					   void *_desc, size_t desc_size)
+					   struct fsverity_descriptor *desc,
+					   size_t desc_size)
 {
-	struct fsverity_descriptor *desc = _desc;
 	struct fsverity_info *vi;
 	int err;
 
-	if (desc_size < sizeof(*desc)) {
-		fsverity_err(inode, "Unrecognized descriptor size: %zu bytes",
-			     desc_size);
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (desc->version != 1) {
-		fsverity_err(inode, "Unrecognized descriptor version: %u",
-			     desc->version);
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (memchr_inv(desc->__reserved, 0, sizeof(desc->__reserved))) {
-		fsverity_err(inode, "Reserved bits set in descriptor");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (desc->salt_size > sizeof(desc->salt)) {
-		fsverity_err(inode, "Invalid salt_size: %u", desc->salt_size);
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (le64_to_cpu(desc->data_size) != inode->i_size) {
-		fsverity_err(inode,
-			     "Wrong data_size: %llu (desc) != %lld (inode)",
-			     le64_to_cpu(desc->data_size), inode->i_size);
-		return ERR_PTR(-EINVAL);
-	}
-
 	vi = kmem_cache_zalloc(fsverity_info_cachep, GFP_KERNEL);
 	if (!vi)
 		return ERR_PTR(-ENOMEM);
@@ -245,15 +217,57 @@ void fsverity_free_info(struct fsverity_info *vi)
 	kmem_cache_free(fsverity_info_cachep, vi);
 }
 
-/* Ensure the inode has an ->i_verity_info */
-static int ensure_verity_info(struct inode *inode)
+static bool validate_fsverity_descriptor(struct inode *inode,
+					 const struct fsverity_descriptor *desc,
+					 size_t desc_size)
 {
-	struct fsverity_info *vi = fsverity_get_info(inode);
-	struct fsverity_descriptor *desc;
-	int res;
+	if (desc_size < sizeof(*desc)) {
+		fsverity_err(inode, "Unrecognized descriptor size: %zu bytes",
+			     desc_size);
+		return false;
+	}
 
-	if (vi)
-		return 0;
+	if (desc->version != 1) {
+		fsverity_err(inode, "Unrecognized descriptor version: %u",
+			     desc->version);
+		return false;
+	}
+
+	if (memchr_inv(desc->__reserved, 0, sizeof(desc->__reserved))) {
+		fsverity_err(inode, "Reserved bits set in descriptor");
+		return false;
+	}
+
+	if (desc->salt_size > sizeof(desc->salt)) {
+		fsverity_err(inode, "Invalid salt_size: %u", desc->salt_size);
+		return false;
+	}
+
+	if (le64_to_cpu(desc->data_size) != inode->i_size) {
+		fsverity_err(inode,
+			     "Wrong data_size: %llu (desc) != %lld (inode)",
+			     le64_to_cpu(desc->data_size), inode->i_size);
+		return false;
+	}
+
+	if (le32_to_cpu(desc->sig_size) > desc_size - sizeof(*desc)) {
+		fsverity_err(inode, "Signature overflows verity descriptor");
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Read the inode's fsverity_descriptor (with optional appended signature) from
+ * the filesystem, and do basic validation of it.
+ */
+int fsverity_get_descriptor(struct inode *inode,
+			    struct fsverity_descriptor **desc_ret,
+			    size_t *desc_size_ret)
+{
+	int res;
+	struct fsverity_descriptor *desc;
 
 	res = inode->i_sb->s_vop->get_verity_descriptor(inode, NULL, 0);
 	if (res < 0) {
@@ -272,20 +286,46 @@ static int ensure_verity_info(struct inode *inode)
 	res = inode->i_sb->s_vop->get_verity_descriptor(inode, desc, res);
 	if (res < 0) {
 		fsverity_err(inode, "Error %d reading verity descriptor", res);
-		goto out_free_desc;
+		kfree(desc);
+		return res;
+	}
+
+	if (!validate_fsverity_descriptor(inode, desc, res)) {
+		kfree(desc);
+		return -EINVAL;
 	}
 
-	vi = fsverity_create_info(inode, desc, res);
+	*desc_ret = desc;
+	*desc_size_ret = res;
+	return 0;
+}
+
+/* Ensure the inode has an ->i_verity_info */
+static int ensure_verity_info(struct inode *inode)
+{
+	struct fsverity_info *vi = fsverity_get_info(inode);
+	struct fsverity_descriptor *desc;
+	size_t desc_size;
+	int err;
+
+	if (vi)
+		return 0;
+
+	err = fsverity_get_descriptor(inode, &desc, &desc_size);
+	if (err)
+		return err;
+
+	vi = fsverity_create_info(inode, desc, desc_size);
 	if (IS_ERR(vi)) {
-		res = PTR_ERR(vi);
+		err = PTR_ERR(vi);
 		goto out_free_desc;
 	}
 
 	fsverity_set_info(inode, vi);
-	res = 0;
+	err = 0;
 out_free_desc:
 	kfree(desc);
-	return res;
+	return err;
 }
 
 /**
-- 
2.30.0

