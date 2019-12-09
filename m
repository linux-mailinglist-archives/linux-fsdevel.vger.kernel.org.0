Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22C1177C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 21:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLIUvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 15:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfLIUvB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:51:01 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B4E2068E;
        Mon,  9 Dec 2019 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575924660;
        bh=oCaaWnTFgChg9u4LKnle9ELlHgCeHYXQyxSgx1NPH1E=;
        h=From:To:Cc:Subject:Date:From;
        b=2c87cQA+9qJ3QJ73oMKaGjjmI69neV7VyZ/4P1heGa9J5RJTYUspnEA/Pby9verd2
         8tsl6+f+6tLT2LyJYcBJjmJFo7F+EL+Neh3REDU6qcnK5Of2l6yNaiq+hEmiLUCb6B
         FqSRQ0p4YDK6aYEbtYVxr+bQCFsuhHh6ApHcVL7A=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fscrypt: introduce fscrypt_needs_contents_encryption()
Date:   Mon,  9 Dec 2019 12:50:21 -0800
Message-Id: <20191209205021.231767-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a function fscrypt_needs_contents_encryption() which takes an inode
and returns true if it's an encrypted regular file and the kernel was
built with fscrypt support.

This will allow replacing duplicated checks of IS_ENCRYPTED() &&
S_ISREG() on the I/O paths in ext4 and f2fs, while also optimizing out
unneeded code when !CONFIG_FS_ENCRYPTION.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fscrypt.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index cb18b5fbcef92..2a29f56b1a1cb 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -72,6 +72,21 @@ static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 	return READ_ONCE(inode->i_crypt_info) != NULL;
 }
 
+/**
+ * fscrypt_needs_contents_encryption() - check whether an inode needs
+ *					 contents encryption
+ *
+ * Return: %true iff the inode is an encrypted regular file and the kernel was
+ * built with fscrypt support.
+ *
+ * If you need to know whether the encrypt bit is set even when the kernel was
+ * built without fscrypt support, you must use IS_ENCRYPTED() directly instead.
+ */
+static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
+{
+	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode);
+}
+
 static inline bool fscrypt_dummy_context_enabled(struct inode *inode)
 {
 	return inode->i_sb->s_cop->dummy_context &&
@@ -269,6 +284,11 @@ static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 	return false;
 }
 
+static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
+{
+	return false;
+}
+
 static inline bool fscrypt_dummy_context_enabled(struct inode *inode)
 {
 	return false;
-- 
2.24.0.393.g34dc348eaf-goog

