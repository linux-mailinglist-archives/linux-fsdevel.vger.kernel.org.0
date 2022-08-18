Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCD6597BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 05:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbiHRC5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 22:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiHRC5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:57:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50997A6C0F;
        Wed, 17 Aug 2022 19:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F1vJoryCVMtuws0pPBOXFjXCep49VgErsKZNNDCOJYQ=; b=sKZFc9FLaiCKeXO7bE+jSttT6P
        PJ3B6EHGQpk7UMP4u0Sz5mmi6KRfIHUYSVI1OFOOv9bEjDXj2FT7yibhL22a+lfFQD8N+Rf5AzONS
        BrrjtMhDFVWWQI+v6DFy+GvrOAd++iEpFDLNE1ZsGsWoHJphOy4T1TD+YvbUB1qdCzMMJVt58/MRC
        h058FGLOoybGQoXjLYlR4Y+ydRhiafng4jtMJkbE2Wbm3f9PACo4QCCi+aN5/dvB+Pl8g+58HPFq/
        ug10cuwTN9eiPAQwrDbxzcrEhfp2oTVYm7gnuP+UtXLM5A3Zzlzo9Evh0pEdE2PckWHtTMfxwhGAt
        DuuK94zw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOViy-005aXn-Nu;
        Thu, 18 Aug 2022 02:57:36 +0000
Date:   Thu, 18 Aug 2022 03:57:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dynamic_dname(): drop unused dentry argument
Message-ID: <Yv2qoNQg48rtymGE@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/dma-buf/dma-buf.c | 2 +-
 fs/anon_inodes.c          | 2 +-
 fs/d_path.c               | 3 +--
 fs/nsfs.c                 | 2 +-
 fs/pipe.c                 | 2 +-
 include/linux/dcache.h    | 4 ++--
 net/socket.c              | 2 +-
 7 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index efb4990b29e1..5ec2f314b6e9 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -53,7 +53,7 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
 		ret = strlcpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
 	spin_unlock(&dmabuf->name_lock);
 
-	return dynamic_dname(dentry, buffer, buflen, "/%s:%s",
+	return dynamic_dname(buffer, buflen, "/%s:%s",
 			     dentry->d_name.name, ret > 0 ? name : "");
 }
 
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index e0c3e33c4177..24192a7667ed 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -32,7 +32,7 @@ static struct inode *anon_inode_inode;
  */
 static char *anon_inodefs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-	return dynamic_dname(dentry, buffer, buflen, "anon_inode:%s",
+	return dynamic_dname(buffer, buflen, "anon_inode:%s",
 				dentry->d_name.name);
 }
 
diff --git a/fs/d_path.c b/fs/d_path.c
index e4e0ebad1f15..ce8d9d49e1e7 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -297,8 +297,7 @@ EXPORT_SYMBOL(d_path);
 /*
  * Helper function for dentry_operations.d_dname() members
  */
-char *dynamic_dname(struct dentry *dentry, char *buffer, int buflen,
-			const char *fmt, ...)
+char *dynamic_dname(char *buffer, int buflen, const char *fmt, ...)
 {
 	va_list args;
 	char temp[64];
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..3506f6074288 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -28,7 +28,7 @@ static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
 	struct inode *inode = d_inode(dentry);
 	const struct proc_ns_operations *ns_ops = dentry->d_fsdata;
 
-	return dynamic_dname(dentry, buffer, buflen, "%s:[%lu]",
+	return dynamic_dname(buffer, buflen, "%s:[%lu]",
 		ns_ops->name, inode->i_ino);
 }
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 74ae9fafd25a..42c7ff41c2db 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -860,7 +860,7 @@ static struct vfsmount *pipe_mnt __read_mostly;
  */
 static char *pipefs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-	return dynamic_dname(dentry, buffer, buflen, "pipe:[%lu]",
+	return dynamic_dname(buffer, buflen, "pipe:[%lu]",
 				d_inode(dentry)->i_ino);
 }
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 92c78ed02b54..54d46518c481 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -287,8 +287,8 @@ static inline unsigned d_count(const struct dentry *dentry)
 /*
  * helper function for dentry_operations.d_dname() members
  */
-extern __printf(4, 5)
-char *dynamic_dname(struct dentry *, char *, int, const char *, ...);
+extern __printf(3, 4)
+char *dynamic_dname(char *, int, const char *, ...);
 
 extern char *__d_path(const struct path *, const struct path *, char *, int);
 extern char *d_absolute_path(const struct path *, char *, int);
diff --git a/net/socket.c b/net/socket.c
index 9b27c5e4e5ba..d183e83e0cdf 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -355,7 +355,7 @@ static const struct super_operations sockfs_ops = {
  */
 static char *sockfs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
-	return dynamic_dname(dentry, buffer, buflen, "socket:[%lu]",
+	return dynamic_dname(buffer, buflen, "socket:[%lu]",
 				d_inode(dentry)->i_ino);
 }
 
-- 
2.30.2

