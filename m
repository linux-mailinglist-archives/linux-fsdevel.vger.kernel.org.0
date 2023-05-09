Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1054F6FCBF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjEIQ6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjEIQ5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:31 -0400
Received: from out-35.mta1.migadu.com (out-35.mta1.migadu.com [IPv6:2001:41d0:203:375::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09A2D67
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3fmI1GsqhKc/VjkbsmLsO1lPQkBpUyPyeZNLX2gLM4A=;
        b=HxbPD30d9PS44l4BFocC7+4W53wukqnTMPxPn1K1Dbc9Y/EsxCrjkf4QSlJqxIFFlazBMT
        6SVHA9CXL8xpVGqkipFpzj13Ez5vDhN2yCAlYAdQpq1Cff2u9KY26LppoRnsIuiZKmD0eD
        klJFD5WmmOeWr9WGDK7h91hyWwK5z5I=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 08/32] fs: factor out d_mark_tmpfile()
Date:   Tue,  9 May 2023 12:56:33 -0400
Message-Id: <20230509165657.1735798-9-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

New helper for bcachefs - bcachefs doesn't want the
inode_dec_link_count() call that d_tmpfile does, it handles i_nlink on
its own atomically with other btree updates

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/dcache.c            | 12 ++++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab..dbdafa2617 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3249,11 +3249,10 @@ void d_genocide(struct dentry *parent)
 
 EXPORT_SYMBOL(d_genocide);
 
-void d_tmpfile(struct file *file, struct inode *inode)
+void d_mark_tmpfile(struct file *file, struct inode *inode)
 {
 	struct dentry *dentry = file->f_path.dentry;
 
-	inode_dec_link_count(inode);
 	BUG_ON(dentry->d_name.name != dentry->d_iname ||
 		!hlist_unhashed(&dentry->d_u.d_alias) ||
 		!d_unlinked(dentry));
@@ -3263,6 +3262,15 @@ void d_tmpfile(struct file *file, struct inode *inode)
 				(unsigned long long)inode->i_ino);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dentry->d_parent->d_lock);
+}
+EXPORT_SYMBOL(d_mark_tmpfile);
+
+void d_tmpfile(struct file *file, struct inode *inode)
+{
+	struct dentry *dentry = file->f_path.dentry;
+
+	inode_dec_link_count(inode);
+	d_mark_tmpfile(file, inode);
 	d_instantiate(dentry, inode);
 }
 EXPORT_SYMBOL(d_tmpfile);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f..3da2f0545d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -251,6 +251,7 @@ extern struct dentry * d_make_root(struct inode *);
 /* <clickety>-<click> the ramfs-type tree */
 extern void d_genocide(struct dentry *);
 
+extern void d_mark_tmpfile(struct file *, struct inode *);
 extern void d_tmpfile(struct file *, struct inode *);
 
 extern struct dentry *d_find_alias(struct inode *);
-- 
2.40.1

