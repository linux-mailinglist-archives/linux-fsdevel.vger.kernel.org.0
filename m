Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FFC2F840E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbhAOSUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388279AbhAOSUN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F176023AAA;
        Fri, 15 Jan 2021 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734773;
        bh=Jel0jSfxzz6JC5YFbmX2zBvLW5g+Ng3wqiU7Ogpwi0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV+PbKlE4fejFkAJT2QUpw8lFuA/9WiIzVOwQWxZ8m42b+BxHOeac7Nv6YlEjicfq
         9NSow62EK+Kce5qwM4tuIP2FNmGnI6wXaQpgyE3Oi2QZgObDE4cHU0EwJKw7W+7QI3
         juUYfw9Dd7eoWLJIeQpui6nAsYH85pO3czfkCYC/8+ei411Yaq6owCWkqVqFFI5m9S
         aVfh9Vxwm+x/hpT6nvN2QvoQIcFbjV8dhTFfs7RVUpxYhzHusxOnMS75ZVuA+qNssB
         DjCldKSxFgNoSAhvqz23SuCDosGmeRCT+VaVBego5uOG/vv9IgcpB8VIPQrt/BO3RZ
         Mx374CmaajuLg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 2/6] fs-verity: don't pass whole descriptor to fsverity_verify_signature()
Date:   Fri, 15 Jan 2021 10:18:15 -0800
Message-Id: <20210115181819.34732-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115181819.34732-1-ebiggers@kernel.org>
References: <20210115181819.34732-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that fsverity_get_descriptor() validates the sig_size field,
fsverity_verify_signature() doesn't need to do it.

Just change the prototype of fsverity_verify_signature() to take the
signature directly rather than take a fsverity_descriptor.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h |  6 ++----
 fs/verity/open.c             |  3 ++-
 fs/verity/signature.c        | 20 ++++++--------------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 6c9caccc06021..a7920434bae50 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -140,15 +140,13 @@ void __init fsverity_exit_info_cache(void);
 
 #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
 int fsverity_verify_signature(const struct fsverity_info *vi,
-			      const struct fsverity_descriptor *desc,
-			      size_t desc_size);
+			      const u8 *signature, size_t sig_size);
 
 int __init fsverity_init_signature(void);
 #else /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
 static inline int
 fsverity_verify_signature(const struct fsverity_info *vi,
-			  const struct fsverity_descriptor *desc,
-			  size_t desc_size)
+			  const u8 *signature, size_t sig_size)
 {
 	return 0;
 }
diff --git a/fs/verity/open.c b/fs/verity/open.c
index a987bb785e9b0..60ff8af7219fe 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -181,7 +181,8 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 		 vi->tree_params.hash_alg->name,
 		 vi->tree_params.digest_size, vi->file_digest);
 
-	err = fsverity_verify_signature(vi, desc, desc_size);
+	err = fsverity_verify_signature(vi, desc->signature,
+					le32_to_cpu(desc->sig_size));
 out:
 	if (err) {
 		fsverity_free_info(vi);
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 012468eda2a78..143a530a80088 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -29,21 +29,19 @@ static struct key *fsverity_keyring;
 /**
  * fsverity_verify_signature() - check a verity file's signature
  * @vi: the file's fsverity_info
- * @desc: the file's fsverity_descriptor
- * @desc_size: size of @desc
+ * @signature: the file's built-in signature
+ * @sig_size: size of signature in bytes, or 0 if no signature
  *
- * If the file's fs-verity descriptor includes a signature of the file digest,
- * verify it against the certificates in the fs-verity keyring.
+ * If the file includes a signature of its fs-verity file digest, verify it
+ * against the certificates in the fs-verity keyring.
  *
  * Return: 0 on success (signature valid or not required); -errno on failure
  */
 int fsverity_verify_signature(const struct fsverity_info *vi,
-			      const struct fsverity_descriptor *desc,
-			      size_t desc_size)
+			      const u8 *signature, size_t sig_size)
 {
 	const struct inode *inode = vi->inode;
 	const struct fsverity_hash_alg *hash_alg = vi->tree_params.hash_alg;
-	const u32 sig_size = le32_to_cpu(desc->sig_size);
 	struct fsverity_formatted_digest *d;
 	int err;
 
@@ -56,11 +54,6 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 		return 0;
 	}
 
-	if (sig_size > desc_size - sizeof(*desc)) {
-		fsverity_err(inode, "Signature overflows verity descriptor");
-		return -EBADMSG;
-	}
-
 	d = kzalloc(sizeof(*d) + hash_alg->digest_size, GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
@@ -70,8 +63,7 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 	memcpy(d->digest, vi->file_digest, hash_alg->digest_size);
 
 	err = verify_pkcs7_signature(d, sizeof(*d) + hash_alg->digest_size,
-				     desc->signature, sig_size,
-				     fsverity_keyring,
+				     signature, sig_size, fsverity_keyring,
 				     VERIFYING_UNSPECIFIED_SIGNATURE,
 				     NULL, NULL);
 	kfree(d);
-- 
2.30.0

