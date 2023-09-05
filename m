Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B29792502
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjIEQAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbjIEBEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363E1BE;
        Mon,  4 Sep 2023 18:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DDB3B80D71;
        Tue,  5 Sep 2023 01:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07982C433CB;
        Tue,  5 Sep 2023 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693875867;
        bh=p3a2uN2tAZ707/skilVDeTRZvcvkaY5rfhOHvxATwY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhSgUiDXOmH5Kx+vNSNz1ej2NRNKMmxVC/mq7cJ51DmM+5XXRhsdFtzzv0YzM+5gw
         3U0zAVJnbS6PPaA6vlwpMWbdE0TdVZVq0zPdq2SrLJrq1ZM4HAcAjy+JyXtVy7fLAP
         9S9P92FIim1IzWNg46D3qXyDJC0pFLc/NE3uSAXCoOjt5gKFIfjXQXS7WFy+LlJT+J
         FmHXZI3nvb07FxhZows1ecXWcx/v/aAXH0eqTytqRm4/Jv82sCdxokgSI0btL7KpE1
         Vgt/ToAQZ9AefDXFqxuuwbOEiJBgbu2lZ4v1uUxAXhtXM1r+udnXl+f2CK0Qb8uG9C
         iaPlGmN+oFR1Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] fscrypt: use s_maxbytes instead of filesystem lblk_bits
Date:   Mon,  4 Sep 2023 17:58:28 -0700
Message-ID: <20230905005830.365985-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905005830.365985-1-ebiggers@kernel.org>
References: <20230905005830.365985-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

For a given filesystem, the number of bits used by the maximum file
logical block number is computable from the maximum file size and block
size.  These values are always present in struct super_block.
Therefore, compute it this way instead of using the value from
fscrypt_operations::get_ino_and_lblk_bits.  Since filesystems always
have to set the super_block fields anyway, this avoids having to provide
this information redundantly via fscrypt_operations.

This change is in preparation for adding support for sub-block data
units.  For that, the value that is needed will become "the maximum file
data unit number".  A hardcoded value won't suffice for that; it will
need to be computed anyway.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 10 ++++++++++
 fs/crypto/inline_crypt.c    |  7 ++-----
 fs/crypto/policy.c          | 20 +++++++++++---------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 2d63da48635ab..4b113214b53af 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -296,6 +296,16 @@ union fscrypt_iv {
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci);
 
+/*
+ * Return the number of bits used by the maximum file logical block number that
+ * is possible on the given filesystem.
+ */
+static inline int
+fscrypt_max_file_lblk_bits(const struct super_block *sb)
+{
+	return fls64(sb->s_maxbytes - 1) - sb->s_blocksize_bits;
+}
+
 /* fname.c */
 bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				    u32 orig_len, u32 max_len,
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 8bfb3ce864766..7d9f6c167de58 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -41,9 +41,8 @@ static struct block_device **fscrypt_get_devices(struct super_block *sb,
 
 static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
 {
-	struct super_block *sb = ci->ci_inode->i_sb;
+	const struct super_block *sb = ci->ci_inode->i_sb;
 	unsigned int flags = fscrypt_policy_flags(&ci->ci_policy);
-	int ino_bits = 64, lblk_bits = 64;
 
 	if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
 		return offsetofend(union fscrypt_iv, nonce);
@@ -55,9 +54,7 @@ static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
 		return sizeof(__le32);
 
 	/* Default case: IVs are just the file logical block number */
-	if (sb->s_cop->get_ino_and_lblk_bits)
-		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
-	return DIV_ROUND_UP(lblk_bits, 8);
+	return DIV_ROUND_UP(fscrypt_max_file_lblk_bits(sb), 8);
 }
 
 /*
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index f4456ecb3f877..36bffc4d6228d 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -119,8 +119,7 @@ static bool supported_direct_key_modes(const struct inode *inode,
 
 static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 					 const struct inode *inode,
-					 const char *type,
-					 int max_ino_bits, int max_lblk_bits)
+					 const char *type, int max_ino_bits)
 {
 	struct super_block *sb = inode->i_sb;
 	int ino_bits = 64, lblk_bits = 64;
@@ -154,13 +153,18 @@ static bool supported_iv_ino_lblk_policy(const struct fscrypt_policy_v2 *policy,
 		sb->s_cop->get_ino_and_lblk_bits(sb, &ino_bits, &lblk_bits);
 	if (ino_bits > max_ino_bits) {
 		fscrypt_warn(inode,
-			     "Can't use %s policy on filesystem '%s' because its inode numbers are too long",
+			     "Can't use %s policy on filesystem '%s' because its maximum inode number is too large",
 			     type, sb->s_id);
 		return false;
 	}
-	if (lblk_bits > max_lblk_bits) {
+
+	/*
+	 * IV_INO_LBLK_64 and IV_INO_LBLK_32 both require that file logical
+	 * block numbers fit in 32 bits.
+	 */
+	if (fscrypt_max_file_lblk_bits(sb) > 32) {
 		fscrypt_warn(inode,
-			     "Can't use %s policy on filesystem '%s' because its block numbers are too long",
+			     "Can't use %s policy on filesystem '%s' because its maximum file size is too large",
 			     type, sb->s_id);
 		return false;
 	}
@@ -239,8 +243,7 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		return false;
 
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
-	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_64",
-					  32, 32))
+	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_64", 32))
 		return false;
 
 	/*
@@ -250,8 +253,7 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 	 * implementation limit is 32 bits.
 	 */
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
-	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_32",
-					  32, 32))
+	    !supported_iv_ino_lblk_policy(policy, inode, "IV_INO_LBLK_32", 32))
 		return false;
 
 	if (memchr_inv(policy->__reserved, 0, sizeof(policy->__reserved))) {
-- 
2.42.0

