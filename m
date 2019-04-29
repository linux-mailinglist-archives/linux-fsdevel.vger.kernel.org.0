Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E53DD9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 10:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfD2IUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 04:20:37 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45742 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727531AbfD2IUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:20:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TQUvbDU_1556526025;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TQUvbDU_1556526025)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 16:20:34 +0800
From:   zhangliguang <zhangliguang@linux.alibaba.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: move attr_version to a more relevant place
Date:   Mon, 29 Apr 2019 16:20:25 +0800
Message-Id: <1556526025-92556-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move attr_version assignment code to the more relevant place.

Signed-off-by: zhangliguang <zhangliguang@linux.alibaba.com>
---
 fs/fuse/dir.c     | 10 ++++------
 fs/fuse/readdir.c |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index dd0f64f..9a16064 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -191,8 +191,6 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (!forget)
 			goto out;
 
-		attr_version = fuse_get_attr_version(fc);
-
 		parent = dget_parent(entry);
 		fuse_lookup_init(fc, &args, get_node_id(d_inode(parent)),
 				 &entry->d_name, &outarg);
@@ -218,6 +216,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			goto invalid;
 
 		forget_all_cached_acls(inode);
+		
+		attr_version = fuse_get_attr_version(fc);
 		fuse_change_attributes(inode, &outarg.attr,
 				       entry_attr_timeout(&outarg),
 				       attr_version);
@@ -292,8 +292,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (!forget)
 		goto out;
 
-	attr_version = fuse_get_attr_version(fc);
-
 	fuse_lookup_init(fc, &args, nodeid, name, outarg);
 	err = fuse_simple_request(fc, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
@@ -306,6 +304,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	if (!fuse_valid_type(outarg->attr.mode))
 		goto out_put_forget;
 
+	attr_version = fuse_get_attr_version(fc);
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, entry_attr_timeout(outarg),
 			   attr_version);
@@ -873,8 +872,6 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	FUSE_ARGS(args);
 	u64 attr_version;
 
-	attr_version = fuse_get_attr_version(fc);
-
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outarg, 0, sizeof(outarg));
 	/* Directories have separate file-handle space */
@@ -898,6 +895,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 			make_bad_inode(inode);
 			err = -EIO;
 		} else {
+			attr_version = fuse_get_attr_version(fc);
 			fuse_change_attributes(inode, &outarg.attr,
 					       attr_timeout(&outarg),
 					       attr_version);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 574d03f..8b74fe0 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -320,7 +320,6 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	req->pages[0] = page;
 	req->page_descs[0].length = PAGE_SIZE;
 	if (plus) {
-		attr_version = fuse_get_attr_version(fc);
 		fuse_read_fill(req, file, ctx->pos, PAGE_SIZE,
 			       FUSE_READDIRPLUS);
 	} else {
@@ -340,6 +339,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 			if (ff->open_flags & FOPEN_CACHE_DIR)
 				fuse_readdir_cache_end(file, ctx->pos);
 		} else if (plus) {
+			attr_version = fuse_get_attr_version(fc);
 			err = parse_dirplusfile(page_address(page), nbytes,
 						file, ctx, attr_version);
 		} else {
-- 
1.8.3.1

