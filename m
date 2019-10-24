Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE2E3E9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 23:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfJXV5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 17:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbfJXV5J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:57:09 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D22E21BE5;
        Thu, 24 Oct 2019 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571954228;
        bh=+8luL/bZbW80xKvD+Y5+ihdXdtrAmLOtrJQG9TlkZRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeOTzezSHVhFDUS3z1MVMNpVpZbieE7y3cb8AVhIwjOipEey9gdJHO8RTPjScbkIN
         jlnEOEd1d386nG02+5FZio0Jh/ncn3P50e86w9T4B29QcJIRQo0pJOzxuDTtOVwFQB
         h0EBva4YYLMQzuwTPA/bB9fWPVxQklx00kF/mkmg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 2/3] ext4: add support for IV_INO_LBLK_64 encryption policies
Date:   Thu, 24 Oct 2019 14:54:37 -0700
Message-Id: <20191024215438.138489-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191024215438.138489-1-ebiggers@kernel.org>
References: <20191024215438.138489-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

IV_INO_LBLK_64 encryption policies have special requirements from the
filesystem beyond those of the existing encryption policies:

- Inode numbers must never change, even if the filesystem is resized.
- Inode numbers must be <= 32 bits.
- File logical block numbers must be <= 32 bits.

ext4 has 32-bit inode and file logical block numbers.  However,
resize2fs can re-number inodes when shrinking an ext4 filesystem.

However, typically the people who would want to use this format don't
care about filesystem shrinking.  They'd be fine with a solution that
just prevents the filesystem from being shrunk.

Therefore, add a new feature flag EXT4_FEATURE_COMPAT_STABLE_INODES that
will do exactly that.  Then wire up the fscrypt_operations to expose
this flag to fs/crypto/, so that it allows IV_INO_LBLK_64 policies when
this flag is set.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/super.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676ce..b3a2cc7c0252f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1678,6 +1678,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT4_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
@@ -1779,6 +1780,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
 EXT4_FEATURE_RO_COMPAT_FUNCS(large_file,	LARGE_FILE)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d9..b3cbf8622eab6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1345,6 +1345,18 @@ static bool ext4_dummy_context(struct inode *inode)
 	return DUMMY_ENCRYPTION_ENABLED(EXT4_SB(inode->i_sb));
 }
 
+static bool ext4_has_stable_inodes(struct super_block *sb)
+{
+	return ext4_has_feature_stable_inodes(sb);
+}
+
+static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
+				       int *ino_bits_ret, int *lblk_bits_ret)
+{
+	*ino_bits_ret = 8 * sizeof(EXT4_SB(sb)->s_es->s_inodes_count);
+	*lblk_bits_ret = 8 * sizeof(ext4_lblk_t);
+}
+
 static const struct fscrypt_operations ext4_cryptops = {
 	.key_prefix		= "ext4:",
 	.get_context		= ext4_get_context,
@@ -1352,6 +1364,8 @@ static const struct fscrypt_operations ext4_cryptops = {
 	.dummy_context		= ext4_dummy_context,
 	.empty_dir		= ext4_empty_dir,
 	.max_namelen		= EXT4_NAME_LEN,
+	.has_stable_inodes	= ext4_has_stable_inodes,
+	.get_ino_and_lblk_bits	= ext4_get_ino_and_lblk_bits,
 };
 #endif
 
-- 
2.24.0.rc0.303.g954a862665-goog

