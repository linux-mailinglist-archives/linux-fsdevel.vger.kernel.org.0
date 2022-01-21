Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B806495B88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 09:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379365AbiAUIC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 03:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379356AbiAUICy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:02:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D78BC061574;
        Fri, 21 Jan 2022 00:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GkhYswWhgZDhLTeBb8jA3GhQ7m9q872GlOap+afnEQI=; b=FiaAtqncYkONo8snw9SQkJCsw9
        VG4CNYHf0YXnS2SYDh0oAp2TfIMCv2tKKyAb35y4hVkq8A8KL2iFiB5UvZTH65I4H1th7LYptCN/S
        Yg3/6L5X660xq/qYdJxfFYHM8Nh69tqCK3P4/061gSjLn6UdjawCJyQLleMhRBsVlIFQKTlX56rTu
        IRcyhFSvsTz9Ubmawk2BNhhIeDVs/rAAHM2ZCdKM9i/olJw8ExzrXY8aXlgjJF60d0dsZw7VLGRAd
        Tqb4mOCk4aspLz4CnJt3eMJr4lrJhpl+AIbVtCg71qFIeznHBs4GP/V+cpXDVX7s/nVdCf18CKksO
        U6sGRBOQ==;
Received: from [2001:4bb8:184:72a4:a29c:780c:65f6:27e6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAosk-00EBvi-3w; Fri, 21 Jan 2022 08:02:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: rename S_KERNEL_FILE
Date:   Fri, 21 Jan 2022 09:02:46 +0100
Message-Id: <20220121080246.459804-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

S_KERNEL_FILE is grossly misnamed.  We have plenty of files hold open by
the kernel kernel using filp_open.  This flag OTOH signals the inode as
being a special snowflage that cachefiles holds onto that can't be
unlinked becaue of ..., erm, pixie dust.  So clearly mark it as such.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/cachefiles/namei.c | 12 ++++++------
 fs/namei.c            |  2 +-
 include/linux/fs.h    |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 9bd692870617c..599dc13a7d9ab 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -20,8 +20,8 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
 	struct inode *inode = d_backing_inode(dentry);
 	bool can_use = false;
 
-	if (!(inode->i_flags & S_KERNEL_FILE)) {
-		inode->i_flags |= S_KERNEL_FILE;
+	if (!(inode->i_flags & S_CACHEFILE)) {
+		inode->i_flags |= S_CACHEFILE;
 		trace_cachefiles_mark_active(object, inode);
 		can_use = true;
 	} else {
@@ -51,7 +51,7 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	inode->i_flags &= ~S_KERNEL_FILE;
+	inode->i_flags &= ~S_CACHEFILE;
 	trace_cachefiles_mark_inactive(object, inode);
 }
 
@@ -742,7 +742,7 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
 		goto lookup_error;
 	if (d_is_negative(victim))
 		goto lookup_put;
-	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
+	if (d_inode(victim)->i_flags & S_CACHEFILE)
 		goto lookup_busy;
 	return victim;
 
@@ -789,11 +789,11 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	/* check to see if someone is using this object */
 	inode = d_inode(victim);
 	inode_lock(inode);
-	if (inode->i_flags & S_KERNEL_FILE) {
+	if (inode->i_flags & S_CACHEFILE) {
 		ret = -EBUSY;
 	} else {
 		/* Stop the cache from picking it back up */
-		inode->i_flags |= S_KERNEL_FILE;
+		inode->i_flags |= S_CACHEFILE;
 		ret = 0;
 	}
 	inode_unlock(inode);
diff --git a/fs/namei.c b/fs/namei.c
index d81f04f8d8188..7402277ecc1f5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3959,7 +3959,7 @@ int vfs_rmdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 	error = -EBUSY;
 	if (is_local_mountpoint(dentry) ||
-	    (dentry->d_inode->i_flags & S_KERNEL_FILE))
+	    (dentry->d_inode->i_flags & S_CACHEFILE))
 		goto out;
 
 	error = security_inode_rmdir(dir, dentry);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c8510da6cc6dc..099d7e03d46e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2173,7 +2173,7 @@ struct super_operations {
 #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
-#define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
+#define S_CACHEFILE	(1 << 17) /* In use as cachefile, can't be unlinked */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
-- 
2.30.2

