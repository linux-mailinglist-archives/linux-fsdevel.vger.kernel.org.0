Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0081BDF863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfJUXHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 19:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbfJUXHX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:07:23 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5B4214AE;
        Mon, 21 Oct 2019 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571699243;
        bh=cfR9eqGHizd+IHEPkNhVGw12eG6CrP2cnVFftii1848=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eS55tBi5xrlI4+oly2is5DTYZyWnWpyvABp9tC35TvrhqaeeewfG5UiWXOUFX4Svx
         4RjDnHxYZZ3d7f2XHKVrOCJJ/43MiNYdG8gQcJWcx1DdDvld6unFffX5FnxG5BLCm8
         vtFOMv+NIvWxGkfkCUwtWPt+sD5kWF9kWNRUPzqI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] ext4: add support for INLINE_CRYPT_OPTIMIZED encryption policies
Date:   Mon, 21 Oct 2019 16:03:54 -0700
Message-Id: <20191021230355.23136-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021230355.23136-1-ebiggers@kernel.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

INLINE_CRYPT_OPTIMIZED encryption policies have special requirements
from the filesystem:

- Inode numbers must never change, even if the filesystem is resized
- Inode numbers must be <= 32 bits
- File logical block numbers must be <= 32 bits

ext4 has 32-bit inode and file logical block numbers.  However,
resize2fs can re-number inodes when shrinking an ext4 filesystem.

However, many people who want to use inline encryption don't care about
filesystem shrinking.  They'd be fine with a solution that just prevents
the filesystem from being shrunk.

Therefore, add a new feature flag EXT4_FEATURE_COMPAT_STABLE_INODES that
will do exactly that.  Then wire up the fscrypt_operations to expose
this flag to fs/crypto/, so that it allows INLINE_CRYPT_OPTIMIZED
policies when this flag is set.

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
2.23.0.866.gb869b98d4c-goog

