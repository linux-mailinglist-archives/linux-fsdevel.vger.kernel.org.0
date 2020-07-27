Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4A22F6EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgG0Rmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbgG0Rmx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:42:53 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0AD20714;
        Mon, 27 Jul 2020 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595871772;
        bh=ozOE6UcON1RhZRLjtldC0B+EDLULU+0SvtdCa41mDdc=;
        h=From:To:Cc:Subject:Date:From;
        b=LBdDwGb+BxMrhL4dI59/DVNUo1GjKSYw9URg4Hdmy6WB9h2T62oHc1A0I16S8ljl5
         p+CHUA2oy0y3SbsAUmcAwQjQG5cYXYlPo0dIM/Y0h7r8X3w3buT6d7oKCvoh2+fpwP
         M+QvmPMnjg/IvpmdNKk4ahflJ0mRWcmjC968YWAA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH] fscrypt: don't load ->i_crypt_info before it's known to be valid
Date:   Mon, 27 Jul 2020 10:41:58 -0700
Message-Id: <20200727174158.121456-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In fscrypt_set_bio_crypt_ctx(), ->i_crypt_info isn't known to be
non-NULL until we check fscrypt_inode_uses_inline_crypto().  So, load
->i_crypt_info after the check rather than before.  This makes no
difference currently, but it prevents people from introducing bugs where
the pointer is dereferenced when it may be NULL.

Suggested-by: Dave Chinner <david@fromorbit.com>
Cc: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/inline_crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index dfb06375099ae..b6b8574caa13c 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -244,11 +244,12 @@ static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
 void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 			       u64 first_lblk, gfp_t gfp_mask)
 {
-	const struct fscrypt_info *ci = inode->i_crypt_info;
+	const struct fscrypt_info *ci;
 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 
 	if (!fscrypt_inode_uses_inline_crypto(inode))
 		return;
+	ci = inode->i_crypt_info;
 
 	fscrypt_generate_dun(ci, first_lblk, dun);
 	bio_crypt_set_ctx(bio, &ci->ci_enc_key.blk_key->base, dun, gfp_mask);
-- 
2.27.0

