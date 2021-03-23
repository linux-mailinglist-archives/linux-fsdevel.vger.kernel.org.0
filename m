Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50934696F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhCWUAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhCWUAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B66DC061574;
        Tue, 23 Mar 2021 13:00:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 084781F44DB0
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 1/4] Revert "libfs: unexport generic_ci_d_compare() and generic_ci_d_hash()"
Date:   Tue, 23 Mar 2021 16:59:38 -0300
Message-Id: <20210323195941.69720-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210323195941.69720-1-andrealmeid@collabora.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reverts commit 794c43f716845e2d48ce195ed5c4179a4e05ce5f.

For implementing casefolding support at tmpfs, it needs to set dentry
operations at superblock level, given that tmpfs has no support for
fscrypt and we don't need to set operations on a per-dentry basis.
Revert this commit so we can access those exported function from tmpfs
code.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 fs/libfs.c         | 8 +++++---
 include/linux/fs.h | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e2de5401abca..d1d06494463a 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1387,8 +1387,8 @@ static bool needs_casefold(const struct inode *dir)
  *
  * Return: 0 if names match, 1 if mismatch, or -ERRNO
  */
-static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-				const char *str, const struct qstr *name)
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			  const char *str, const struct qstr *name)
 {
 	const struct dentry *parent = READ_ONCE(dentry->d_parent);
 	const struct inode *dir = READ_ONCE(parent->d_inode);
@@ -1425,6 +1425,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 		return 1;
 	return !!memcmp(str, name->name, len);
 }
+EXPORT_SYMBOL(generic_ci_d_compare);
 
 /**
  * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
@@ -1433,7 +1434,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  *
  * Return: 0 if hash was successful or unchanged, and -EINVAL on error
  */
-static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
@@ -1448,6 +1449,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(generic_ci_d_hash);
 
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..29a0c6371f7d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3313,6 +3313,11 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
+#ifdef CONFIG_UNICODE
+extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
+extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+				const char *str, const struct qstr *name);
+#endif
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
 #ifdef CONFIG_MIGRATION
-- 
2.31.0

