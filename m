Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A83279770
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgIZHEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 03:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgIZHEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:04:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7FBC0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5+cvC+Olnt2RYhxM/leFa/Y8/9TKxLp0Dqgd9JVP0q4=; b=Tzw0GNeUxpjf4C2sVJlTlyj4hn
        7Um1TnJueHQEt9/TZ/t6VDES1Ixsf4r7QPt7oR0DY9WD93ctmVLk+6K7POOuu7zMcx0QLiMb1mgOh
        ZYmBa8JGM78AICbnwYgGBxqMY3ZIOuZtI/SFpPR0XcoU3F69/Q6hTKbmxuvk5yQtFEHIA+1AX+Z4b
        IDxCBpLLmhmT75+/QfVUUFhNYPUL2Vke06u8Gmeg0WVowq/v/PC1Wx6Z3fsZMFKo5GnfL5FEwLOFl
        GzsZBTTPCqYdazo2rdaEbf9wPtAWiFWu8PEO07nyAcyn5eqKUvdAyNbJEXhpqpo6cPI0vvCtY5uj3
        PFW8Vx5Q==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4FY-0003vn-2M; Sat, 26 Sep 2020 07:04:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] fs: move vfs_fstatat out of line
Date:   Sat, 26 Sep 2020 09:03:59 +0200
Message-Id: <20200926070401.11816-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926070401.11816-1-hch@lst.de>
References: <20200926070401.11816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

