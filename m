Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82E0652BC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 04:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiLUDWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 22:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLUDWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:22:01 -0500
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E83A713DCE;
        Tue, 20 Dec 2022 19:21:59 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0C7761E80CAE;
        Wed, 21 Dec 2022 11:16:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gVOmohsQp0sq; Wed, 21 Dec 2022 11:16:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 32ADF1E80CA0;
        Wed, 21 Dec 2022 11:16:53 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     keescook@chromium.org, akpm@linux-foundation.org,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] hfsplus: Remove unnecessary variable initialization
Date:   Wed, 21 Dec 2022 11:21:20 +0800
Message-Id: <20221221032119.10037-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Variables are assigned first and then used. Initialization is not required.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 fs/hfsplus/xattr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 49891b12c415..7c502df7ccac 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -257,7 +257,7 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 int __hfsplus_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags)
 {
-	int err = 0;
+	int err;
 	struct hfs_find_data cat_fd;
 	hfsplus_cat_entry entry;
 	u16 cat_entry_flags, cat_entry_type;
@@ -494,7 +494,7 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 	__be32 xattr_record_type;
 	u32 record_type;
 	u16 record_length = 0;
-	ssize_t res = 0;
+	ssize_t res;
 
 	if ((!S_ISREG(inode->i_mode) &&
 			!S_ISDIR(inode->i_mode)) ||
@@ -606,7 +606,7 @@ static inline int can_list(const char *xattr_name)
 static ssize_t hfsplus_listxattr_finder_info(struct dentry *dentry,
 						char *buffer, size_t size)
 {
-	ssize_t res = 0;
+	ssize_t res;
 	struct inode *inode = d_inode(dentry);
 	struct hfs_find_data fd;
 	u16 entry_type;
@@ -674,10 +674,10 @@ static ssize_t hfsplus_listxattr_finder_info(struct dentry *dentry,
 ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	ssize_t err;
-	ssize_t res = 0;
+	ssize_t res;
 	struct inode *inode = d_inode(dentry);
 	struct hfs_find_data fd;
-	u16 key_len = 0;
+	u16 key_len;
 	struct hfsplus_attr_key attr_key;
 	char *strbuf;
 	int xattr_name_len;
@@ -766,12 +766,12 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 static int hfsplus_removexattr(struct inode *inode, const char *name)
 {
-	int err = 0;
+	int err;
 	struct hfs_find_data cat_fd;
 	u16 flags;
 	u16 cat_entry_type;
-	int is_xattr_acl_deleted = 0;
-	int is_all_xattrs_deleted = 0;
+	int is_xattr_acl_deleted;
+	int is_all_xattrs_deleted;
 
 	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
 		return -EOPNOTSUPP;
-- 
2.18.2

