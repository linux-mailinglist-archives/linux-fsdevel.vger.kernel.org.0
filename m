Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30D39F53B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhFHLlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFHLlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:41:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B832FC061574;
        Tue,  8 Jun 2021 04:39:25 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqa4q-005ptH-PL; Tue, 08 Jun 2021 11:39:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] teach set_nameidata() to handle setting the root as well
Date:   Tue,  8 Jun 2021 11:39:23 +0000
Message-Id: <20210608113924.1391062-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608113924.1391062-1-viro@zeniv.linux.org.uk>
References: <YL9WwAD547fY19EE@zeniv-ca.linux.org.uk>
 <20210608113924.1391062-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That way we don't need the callers to mess with manually setting any fields
of nameidata instances.  Old set_nameidata() gets renamed (__set_nameidata()),
new becomes an inlined helper that takes a struct path pointer and deals
with setting nd->root and putting ND_ROOT_PRESET in nd->state when new
argument is non-NULL.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 622b9f15bf1c..40ffb249aa7f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -577,7 +577,7 @@ struct nameidata {
 #define ND_ROOT_GRABBED 2
 #define ND_JUMPED 4
 
-static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
+static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 {
 	struct nameidata *old = current->nameidata;
 	p->stack = p->internal;
@@ -587,10 +587,20 @@ static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->path.dentry = NULL;
 	p->total_link_count = old ? old->total_link_count : 0;
 	p->saved = old;
-	p->state = 0;
 	current->nameidata = p;
 }
 
+static inline void set_nameidata(struct nameidata *p, int dfd, struct filename *name,
+			  const struct path *root)
+{
+	__set_nameidata(p, dfd, name);
+	p->state = 0;
+	if (unlikely(root)) {
+		p->state = ND_ROOT_PRESET;
+		p->root = *root;
+	}
+}
+
 static void restore_nameidata(void)
 {
 	struct nameidata *now = current->nameidata, *old = now->saved;
@@ -2454,11 +2464,7 @@ int filename_lookup(int dfd, struct filename *name, unsigned flags,
 	struct nameidata nd;
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	set_nameidata(&nd, dfd, name);
-	if (unlikely(root)) {
-		nd.root = *root;
-		nd.state = ND_ROOT_PRESET;
-	}
+	set_nameidata(&nd, dfd, name, root);
 	retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);
 	if (unlikely(retval == -ECHILD))
 		retval = path_lookupat(&nd, flags, path);
@@ -2499,7 +2505,7 @@ static struct filename *filename_parentat(int dfd, struct filename *name,
 
 	if (IS_ERR(name))
 		return name;
-	set_nameidata(&nd, dfd, name);
+	set_nameidata(&nd, dfd, name, NULL);
 	retval = path_parentat(&nd, flags | LOOKUP_RCU, parent);
 	if (unlikely(retval == -ECHILD))
 		retval = path_parentat(&nd, flags, parent);
@@ -3530,7 +3536,7 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
 	int flags = op->lookup_flags;
 	struct file *filp;
 
-	set_nameidata(&nd, dfd, pathname);
+	set_nameidata(&nd, dfd, pathname, NULL);
 	filp = path_openat(&nd, op, flags | LOOKUP_RCU);
 	if (unlikely(filp == ERR_PTR(-ECHILD)))
 		filp = path_openat(&nd, op, flags);
@@ -3555,9 +3561,7 @@ struct file *do_file_open_root(const struct path *root,
 	if (IS_ERR(filename))
 		return ERR_CAST(filename);
 
-	set_nameidata(&nd, -1, filename);
-	nd.root = *root;
-	nd.state = ND_ROOT_PRESET;
+	set_nameidata(&nd, -1, filename, root);
 	file = path_openat(&nd, op, flags | LOOKUP_RCU);
 	if (unlikely(file == ERR_PTR(-ECHILD)))
 		file = path_openat(&nd, op, flags);
-- 
2.11.0

