Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4033168E82E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 07:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjBHGVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 01:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHGVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:21:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52C1410B7;
        Tue,  7 Feb 2023 22:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7218EB81C0B;
        Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC55DC433D2;
        Wed,  8 Feb 2023 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675837295;
        bh=rXzimvd4PWdjTx5BBrxxERaITqXWUNGccCwAWr6IKjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqgr3pjenH4hhu5yGdWxOmuBDTfjE4KLBRmr1eWNY3senk1DChomHChHvaaxF6sbw
         WFt0IatwITKGVY/itxERVpapqWkjt5alhkueEyIKT84lQoCu0gAZ4T1uEu4FJf33/o
         heMAhP1Ezd9x0FPiBMslUu7RBEXu3HgMborHvzBMxsapUwcOEVrGe3o0JmYKEwck9m
         S2m6eg9Fv1O+XZQUCAASPtvuI1I1bozwdJGolV70KdhTahQQadD71tVagZeGiTGqSg
         zLKtosWgeOdtBPa38BSfliQolz1TEODI3gol34EYGKeYBQmVPlK7+cRjlDgxXc/dC3
         T73UdOlm3P/mQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/5] fscrypt: add the test dummy encryption key on-demand
Date:   Tue,  7 Feb 2023 22:21:03 -0800
Message-Id: <20230208062107.199831-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When the key for an inode is not found but the inode is using the
test_dummy_encryption policy, automatically add the
test_dummy_encryption key to the filesystem keyring.  This eliminates
the need for all the individual filesystems to do this at mount time,
which is a bit tricky to clean up from on failure.

Note: this covers the call to fscrypt_find_master_key() from inode key
setup, but not from the fscrypt ioctls.  So, this isn't *exactly* the
same as the key being present from the very beginning.  I think we can
tolerate that, though, since the inode key setup caller is the only one
that actually matters in the context of test_dummy_encryption.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h |  1 +
 fs/crypto/keysetup.c        | 25 +++++++++++++++++++++++--
 fs/crypto/policy.c          |  3 +--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 316a778cec0ff..17dd33d9a522e 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -651,6 +651,7 @@ bool fscrypt_policies_equal(const union fscrypt_policy *policy1,
 			    const union fscrypt_policy *policy2);
 int fscrypt_policy_to_key_spec(const union fscrypt_policy *policy,
 			       struct fscrypt_key_specifier *key_spec);
+const union fscrypt_policy *fscrypt_get_dummy_policy(struct super_block *sb);
 bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
 			      const struct inode *inode);
 int fscrypt_policy_from_context(union fscrypt_policy *policy_u,
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 94757ccd30568..20323c0ba4c5e 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -438,6 +438,7 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 				     bool need_dirhash_key,
 				     struct fscrypt_master_key **mk_ret)
 {
+	struct super_block *sb = ci->ci_inode->i_sb;
 	struct fscrypt_key_specifier mk_spec;
 	struct fscrypt_master_key *mk;
 	int err;
@@ -450,8 +451,28 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 	if (err)
 		return err;
 
-	mk = fscrypt_find_master_key(ci->ci_inode->i_sb, &mk_spec);
-	if (!mk) {
+	mk = fscrypt_find_master_key(sb, &mk_spec);
+	if (unlikely(!mk)) {
+		const union fscrypt_policy *dummy_policy =
+			fscrypt_get_dummy_policy(sb);
+
+		/*
+		 * Add the test_dummy_encryption key on-demand.  In principle,
+		 * it should be added at mount time.  Do it here instead so that
+		 * the individual filesystems don't need to worry about adding
+		 * this key at mount time and cleaning up on mount failure.
+		 */
+		if (dummy_policy &&
+		    fscrypt_policies_equal(dummy_policy, &ci->ci_policy)) {
+			struct fscrypt_dummy_policy tmp = { dummy_policy };
+
+			err = fscrypt_add_test_dummy_key(sb, &tmp);
+			if (err)
+				return err;
+			mk = fscrypt_find_master_key(sb, &mk_spec);
+		}
+	}
+	if (unlikely(!mk)) {
 		if (ci->ci_policy.version != FSCRYPT_POLICY_V1)
 			return -ENOKEY;
 
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 893661b523769..69dca4ff5f488 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -53,8 +53,7 @@ int fscrypt_policy_to_key_spec(const union fscrypt_policy *policy,
 	}
 }
 
-static const union fscrypt_policy *
-fscrypt_get_dummy_policy(struct super_block *sb)
+const union fscrypt_policy *fscrypt_get_dummy_policy(struct super_block *sb)
 {
 	if (!sb->s_cop->get_dummy_policy)
 		return NULL;
-- 
2.39.1

