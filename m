Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBB2CF7A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 00:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLDXk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 18:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLDXk5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:40:57 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] libfs: unexport generic_ci_d_compare() and generic_ci_d_hash()
Date:   Fri,  4 Dec 2020 15:39:40 -0800
Message-Id: <20201204233940.52144-1-ebiggers@kernel.org>
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

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

This patch applies to f2fs/dev, as it depends on "libfs: Add generic
function for setting dentry_ops" and "fscrypt: Have filesystems handle
their d_ops" which are queued in f2fs/dev.

 fs/libfs.c         | 8 +++-----
 include/linux/fs.h | 5 -----
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index bac9186990220..a33bc3451d096 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1386,8 +1386,8 @@ static bool needs_casefold(const struct inode *dir)
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
@@ -1424,7 +1424,6 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 		return 1;
 	return !!memcmp(str, name->name, len);
 }
-EXPORT_SYMBOL(generic_ci_d_compare);
 
 /**
  * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
@@ -1433,7 +1432,7 @@ EXPORT_SYMBOL(generic_ci_d_compare);
  *
  * Return: 0 if hash was successful or unchanged, and -EINVAL on error
  */
-int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
@@ -1448,7 +1447,6 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 		return -EINVAL;
 	return 0;
 }
-EXPORT_SYMBOL(generic_ci_d_hash);
 
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a25ab4dbd3e9..f000cccaa6ac7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3181,11 +3181,6 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
-#ifdef CONFIG_UNICODE
-extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
-extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-				const char *str, const struct qstr *name);
-#endif
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
 #ifdef CONFIG_MIGRATION

base-commit: a7f72973ac2342644fce026e01943ed0f41fcc4a
-- 
2.29.2

