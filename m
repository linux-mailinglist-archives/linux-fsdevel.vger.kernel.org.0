Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10270263DA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIJGw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgIJGwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:52:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF9C0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5+cvC+Olnt2RYhxM/leFa/Y8/9TKxLp0Dqgd9JVP0q4=; b=WKmyz80t1EHbkiWmSYSYFKvYqs
        mdIoqiF5GEDIuZZbqtt86gHi0w4I11UznXEK6kxtZA4toF0Hn6HaWJ1BmobjAUyAXsCbxAfy7/2ON
        ZaDM9tQn6bBoGTVsirGV4pBtNt26ToCq+uFhxZ+Rel8qESnteTfJ0IXM6MdeI6BfiJPYha8zlDuQL
        HsHirYxpsVlRaKvRW7afj+crRC9YZoOHf0fD2JupZMzNMGT6H7Sz6MLBhixvELha2NN8tTot4HISF
        0GIEKNjKrvBffmae0VLOJ4Dgo220O2IC9dvSdCf3vIT9qpNqJjFm478vjHnwxjHwGvAsdmdxswjcL
        7/gwQSPg==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGGID-0000C9-Eg; Thu, 10 Sep 2020 06:42:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] fs: move vfs_fstatat out of line
Date:   Thu, 10 Sep 2020 08:42:41 +0200
Message-Id: <20200910064244.346913-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910064244.346913-1-hch@lst.de>
References: <20200910064244.346913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows to keep vfs_statx static in fs/stat.c to prepare for the following
changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/stat.c          | 9 +++++++--
 include/linux/fs.h | 9 ++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 2683a051ce07fa..ddf0176d4dbcd7 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -181,7 +181,7 @@ static inline unsigned vfs_stat_set_lookup_flags(unsigned *lookup_flags,
  *
  * 0 will be returned on success, and a -ve error code if unsuccessful.
  */
-int vfs_statx(int dfd, const char __user *filename, int flags,
+static int vfs_statx(int dfd, const char __user *filename, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
@@ -209,8 +209,13 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 out:
 	return error;
 }
-EXPORT_SYMBOL(vfs_statx);
 
+int vfs_fstatat(int dfd, const char __user *filename,
+			      struct kstat *stat, int flags)
+{
+	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
+			 stat, STATX_BASIC_STATS);
+}
 
 #ifdef __ARCH_WANT_OLD_STAT
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 107f6a84ead8f7..0678e9ca07b0ed 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3165,15 +3165,10 @@ extern const struct inode_operations simple_symlink_inode_operations;
 
 extern int iterate_dir(struct file *, struct dir_context *);
 
-extern int vfs_statx(int, const char __user *, int, struct kstat *, u32);
+int vfs_fstatat(int dfd, const char __user *filename, struct kstat *stat,
+		int flags);
 int vfs_fstat(int fd, struct kstat *stat);
 
-static inline int vfs_fstatat(int dfd, const char __user *filename,
-			      struct kstat *stat, int flags)
-{
-	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
-}
 static inline int vfs_stat(const char __user *filename, struct kstat *stat)
 {
 	return vfs_fstatat(AT_FDCWD, filename, stat, 0);
-- 
2.28.0

