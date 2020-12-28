Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8B2E6C80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 00:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgL1X00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 18:26:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgL1X00 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:26:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4712207A6;
        Mon, 28 Dec 2020 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609197945;
        bh=XexadEGIGMK8fTqIyWmcxjIb63KnYpJCztV+y0Etza4=;
        h=From:To:Cc:Subject:Date:From;
        b=Ior1RgNwd0kdZSKEy4Y6f7pSHKkDQO3Ypor5fkuIgDhz62CcOoNYxeVsZQMP61Yrv
         ORfvNS+OKKzYju0w2QfjUhpN5DPIhhoLa9DpsqNAjeAgX9nN3yx5RxoYIxClizHrQR
         EM3rYqlrH28VuhbYjAmXlfotleQU2InQtdo8a2VGTsFYlw8qn/hfrpAvAmLV4LHg3K
         Wnu612+Aa6uIFG7VQU49h5qP26sJArzaqdOdS7vzxZPX8SQjbXQ3Ml45/GAyGllIxS
         +hSXeVun8V4XohYCyuChO2BluUVnC/JlxWPNv2TKHDEZujm8M4DfNukfVMVJcdZRws
         QzSFXOS4nyvyg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH RESEND] libfs: unexport generic_ci_d_compare() and generic_ci_d_hash()
Date:   Mon, 28 Dec 2020 15:25:29 -0800
Message-Id: <20201228232529.45365-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that generic_set_encrypted_ci_d_ops() has been added and ext4 and
f2fs are using it, it's no longer necessary to export
generic_ci_d_compare() and generic_ci_d_hash() to filesystems.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/libfs.c         | 8 +++-----
 include/linux/fs.h | 5 -----
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index d1c3bade9f30d..79721571e014e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1388,8 +1388,8 @@ static bool needs_casefold(const struct inode *dir)
  *
  * Return: 0 if names match, 1 if mismatch, or -ERRNO
  */
-int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-			  const char *str, const struct qstr *name)
+static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+				const char *str, const struct qstr *name)
 {
 	const struct dentry *parent = READ_ONCE(dentry->d_parent);
 	const struct inode *dir = READ_ONCE(parent->d_inode);
@@ -1426,7 +1426,6 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 		return 1;
 	return !!memcmp(str, name->name, len);
 }
-EXPORT_SYMBOL(generic_ci_d_compare);
 
 /**
  * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
@@ -1435,7 +1434,7 @@ EXPORT_SYMBOL(generic_ci_d_compare);
  *
  * Return: 0 if hash was successful or unchanged, and -EINVAL on error
  */
-int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
@@ -1450,7 +1449,6 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 		return -EINVAL;
 	return 0;
 }
-EXPORT_SYMBOL(generic_ci_d_hash);
 
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c176..6d8b1e7337e48 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3192,11 +3192,6 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
-#ifdef CONFIG_UNICODE
-extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
-extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-				const char *str, const struct qstr *name);
-#endif
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
 #ifdef CONFIG_MIGRATION
-- 
2.29.2

