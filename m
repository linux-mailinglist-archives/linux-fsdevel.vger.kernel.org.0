Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2B3CB353
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhGPHjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 03:39:35 -0400
Received: from mail.synology.com ([211.23.38.101]:48874 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236603AbhGPHjd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:39:33 -0400
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1626420997; bh=KK6YlVgVAQfJEYMeRt+KgwyuMZzCVXDQfwETpiRmEnM=;
        h=From:To:Cc:Subject:Date;
        b=Mm8nXgrTXGx3x4EDrZUPsxcvl75IENzS0hA3uzBA32dQi5MbRNGMwV8HuSmO/3kI8
         K8HI4YoxQV3Osc5etdZabLNKm+dVarfRWxHv8tiUjUj1T8w07rrvLL1S3qGt1obIKq
         p7YgVHhNoiqAJhASxx1gHzyfeKYayqW8FlrIYnpY=
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        slava@dubeyko.com, gustavoars@kernel.org,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        mszeredi@redhat.com
Cc:     Chung-Chiang Cheng <cccheng@synology.com>
Subject: [RESEND PATCH v2] hfsplus: prevent negative dentries when casefolded
Date:   Fri, 16 Jul 2021 15:36:35 +0800
Message-Id: <20210716073635.1613671-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hfsplus uses the case-insensitive filenames by default, but VFS negative
dentries are incompatible with case-insensitive. For example, the
following instructions will get a cached filename 'aaa' which isn't
expected. There is no such problem in macOS.

  touch aaa
  rm aaa
  touch AAA

This patch takes the same approach to drop negative dentires as vfat does.
The dentry is revalidated without blocking and storing to the dentry,
and should be safe in rcu-walk.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/inode.c      |  1 +
 fs/hfsplus/unicode.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 1798949f269b..4ae7f1ca1584 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -520,6 +520,7 @@ int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
 int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
 			   const char *str, const struct qstr *name);
+int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int flags);
 
 /* wrapper.c */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 6fef67c2a9f0..4188a0760118 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -179,6 +179,7 @@ const struct address_space_operations hfsplus_aops = {
 const struct dentry_operations hfsplus_dentry_operations = {
 	.d_hash       = hfsplus_hash_dentry,
 	.d_compare    = hfsplus_compare_dentry,
+	.d_revalidate = hfsplus_revalidate_dentry,
 };
 
 static void hfsplus_get_perms(struct inode *inode,
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..e336631334eb 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/namei.h>
 #include <linux/nls.h>
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -518,3 +519,34 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 		return 1;
 	return 0;
 }
+
+int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int flags)
+{
+	/*
+	 * dentries are always valid when disabling casefold.
+	 */
+	if (!test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(dentry->d_sb)->flags))
+		return 1;
+
+	/*
+	 * Positive dentries are valid when enabling casefold.
+	 *
+	 * Note, rename() to existing directory entry will have ->d_inode, and
+	 * will use existing name which isn't specified name by user.
+	 *
+	 * We may be able to drop this positive dentry here. But dropping
+	 * positive dentry isn't good idea. So it's unsupported like
+	 * rename("filename", "FILENAME") for now.
+	 */
+	if (d_really_is_positive(dentry))
+		return 1;
+
+	/*
+	 * Drop the negative dentry, in order to make sure to use the case
+	 * sensitive name which is specified by user if this is for creation.
+	 */
+	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
+		return 0;
+
+	return 1;
+}
-- 
2.25.1

