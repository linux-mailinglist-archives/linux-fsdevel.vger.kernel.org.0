Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838A4279829
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 11:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgIZJVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 05:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgIZJVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:21:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F9C0613D4
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/ivdUATQZkP6+hgnvpZgn5U9ayT1PU/oH61zOJIUGD0=; b=DoP77tW2RDBYNJh7O/kZPzFgne
        WWz8XGRRCNYJUSqce9WVS/n1Ni8sSBsaM8bygmV65hZKmonc1g9UB0iq0L2mItNb9uY+sWJjyQg7M
        ng7ZC4DWqa2lDFmv+yGuLTYnKpi0/aSemq5wyTcJN+IsIOKhV30JYh1/4bzOWPHEIwy2EwcMFOiMr
        2DZTq5vXu3NdqsV626MX71OVyBFp8wVf3IAkIAWogtgUKzQ7TpCGAGqaYtWvjaT+eic9hY/WALkzs
        IDlrzdAiRQrdb1ufJlnqVp6wfFUtWye5Zdqmv6lmq/jjzBSfqEC1faW4EHmihE/kRR3SAQ0j6DmIA
        n44bJe3g==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM6O2-0002Fp-UY; Sat, 26 Sep 2020 09:20:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] fs: simplify vfs_path_lookup
Date:   Sat, 26 Sep 2020 11:20:51 +0200
Message-Id: <20200926092051.115577-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926092051.115577-1-hch@lst.de>
References: <20200926092051.115577-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_path_lookup is only used to lookup mount points.  So drop the dentry
parameter that is always set to mnt->mnt_root, remove the unused export
and rename the function to mount_path_lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h  |  4 ++--
 fs/namei.c     | 16 +++-------------
 fs/namespace.c |  8 +++-----
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 695e12bc285061..bbdae2648f6b7d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -71,8 +71,8 @@ extern int finish_clean_context(struct fs_context *fc);
 /*
  * namei.c
  */
-extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
-			   const char *, unsigned int, struct path *);
+int mount_path_lookup(struct vfsmount *mnt, const char *name,
+		      unsigned int flags, struct path *path);
 long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct path *link);
diff --git a/fs/namei.c b/fs/namei.c
index 90e1cb008ae449..30f7caf5eda79b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2453,26 +2453,16 @@ int kern_path(const char *name, unsigned int flags, struct path *path)
 }
 EXPORT_SYMBOL(kern_path);
 
-/**
- * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
- * @dentry:  pointer to dentry of the base directory
- * @mnt: pointer to vfs mount of the base directory
- * @name: pointer to file name
- * @flags: lookup flags
- * @path: pointer to struct path to fill
- */
-int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
-		    const char *name, unsigned int flags,
-		    struct path *path)
+int mount_path_lookup(struct vfsmount *mnt, const char *name,
+		unsigned int flags, struct path *path)
 {
 	struct nameidata nd;
 
 	nd.root.mnt = mnt;
-	nd.root.dentry = dentry;
+	nd.root.dentry = mnt->mnt_root;
 	return filename_lookup(AT_FDCWD, getname_kernel(name),
 			       flags | LOOKUP_ROOT, path, &nd);
 }
-EXPORT_SYMBOL(vfs_path_lookup);
 
 static int lookup_one_len_common(const char *name, struct dentry *base,
 				 int len, struct qstr *this)
diff --git a/fs/namespace.c b/fs/namespace.c
index bae0e95b3713a3..0e904b27f7baeb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3368,9 +3368,8 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 	ns->mounts++;
 	list_add(&mnt->mnt_list, &ns->list);
 
-	err = vfs_path_lookup(m->mnt_root, m,
-			name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
-
+	err = mount_path_lookup(m, name, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
+				&path);
 	put_mnt_ns(ns);
 
 	if (err)
@@ -4060,8 +4059,7 @@ static int mntns_install(struct nsset *nsset, struct ns_common *ns)
 	nsproxy->mnt_ns = mnt_ns;
 
 	/* Find the root */
-	err = vfs_path_lookup(mnt_ns->root->mnt.mnt_root, &mnt_ns->root->mnt,
-				"/", LOOKUP_DOWN, &root);
+	err = mount_path_lookup(&mnt_ns->root->mnt, "/", LOOKUP_DOWN, &root);
 	if (err) {
 		/* revert to old namespace */
 		nsproxy->mnt_ns = old_mnt_ns;
-- 
2.28.0

