Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD84279828
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgIZJVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIZJU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:20:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29A4C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3OVxdsQImLkbv/t/rKL0Ih+YKEYR4oVCv+V+wx3AnnU=; b=UuOG3UEj5l56lurRqEvl/WyNLU
        FTus55A/Oc9hhQDbV86Dej5rdPST3BiaSRtBqqzAXUy/KWgFX6LXhUX7RWmizMNDeasaA9GlGqeze
        xcmLl9lExwqpqbkOND9pxUtOkxvIsQIQGmcfhdEL2RIX8SNS+7gUzAdn2kvpU/dyxWvtbGaUldexV
        VbPNO6XVZdswM4rfUnFlh/p8eq4Ekxl8wtt1qtTWglXf8BRnZ06dVPG+tbGWaoPF8fN65NxjKD0Z0
        hBLxFHaM6/BI3W6TlkO8F5w7mzyb3NEsJk80aAJSlb4ybGodSQ5X8eK/gQM04wp65pau6ooEgH3IS
        ERCvw46w==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM6O2-0002Fk-5r; Sat, 26 Sep 2020 09:20:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] fs: pass a nameidata into filename_lookup
Date:   Sat, 26 Sep 2020 11:20:50 +0200
Message-Id: <20200926092051.115577-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926092051.115577-1-hch@lst.de>
References: <20200926092051.115577-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows keeping the LOOKUP_ROOT case for vfs_path_lookup entirely
out of the normal fast path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/namei.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7963f97a130442..90e1cb008ae449 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2352,22 +2352,18 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 }
 
 static int filename_lookup(int dfd, struct filename *name, unsigned flags,
-		    struct path *path, struct path *root)
+		    struct path *path, struct nameidata *nd)
 {
 	int retval;
-	struct nameidata nd;
+
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	if (unlikely(root)) {
-		nd.root = *root;
-		flags |= LOOKUP_ROOT;
-	}
-	set_nameidata(&nd, dfd, name);
-	retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);
+	set_nameidata(nd, dfd, name);
+	retval = path_lookupat(nd, flags | LOOKUP_RCU, path);
 	if (unlikely(retval == -ECHILD))
-		retval = path_lookupat(&nd, flags, path);
+		retval = path_lookupat(nd, flags, path);
 	if (unlikely(retval == -ESTALE))
-		retval = path_lookupat(&nd, flags | LOOKUP_REVAL, path);
+		retval = path_lookupat(nd, flags | LOOKUP_REVAL, path);
 
 	if (likely(!retval))
 		audit_inode(name, path->dentry,
@@ -2450,8 +2446,10 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
-	return filename_lookup(AT_FDCWD, getname_kernel(name),
-			       flags, path, NULL);
+	struct nameidata nd;
+
+	return filename_lookup(AT_FDCWD, getname_kernel(name), flags, path,
+			       &nd);
 }
 EXPORT_SYMBOL(kern_path);
 
@@ -2467,10 +2465,12 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 		    const char *name, unsigned int flags,
 		    struct path *path)
 {
-	struct path root = {.mnt = mnt, .dentry = dentry};
-	/* the first argument of filename_lookup() is ignored with root */
+	struct nameidata nd;
+
+	nd.root.mnt = mnt;
+	nd.root.dentry = dentry;
 	return filename_lookup(AT_FDCWD, getname_kernel(name),
-			       flags , path, &root);
+			       flags | LOOKUP_ROOT, path, &nd);
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
@@ -2643,8 +2643,10 @@ int path_pts(struct path *path)
 int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
 		 struct path *path, int *empty)
 {
+	struct nameidata nd;
+
 	return filename_lookup(dfd, getname_flags(name, flags, empty),
-			       flags, path, NULL);
+			       flags, path, &nd);
 }
 EXPORT_SYMBOL(user_path_at_empty);
 
-- 
2.28.0

