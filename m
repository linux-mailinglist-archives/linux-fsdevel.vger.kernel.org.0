Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4122698B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbgGTQ1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbgGTP7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE6C0619D2;
        Mon, 20 Jul 2020 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QosMaJ9e4wJ6Jpqetx8GoN2rz3W82HkGcZbMWAJHqpI=; b=Zvw2Zpbh6ELKUZp4eA+LFdqEOA
        mhQXwlnv+VWdxfh0zCUCR8yWZdRUvAyOnMxgqICdGaE87zo8BiNnoly6UZCiuX5dxwtPcMIlHxK9B
        virJCHC1ITJDwb+T4GArGGe+vEgyYZkreQ3X9R3DDSIP82geqE3KBKqFHrN0YTW8EMPdqpuoLCPJ0
        WYc1inr5Tu7l0G4UFDzlpU+cEl9KskC96v12xEwJXYLpN2G9ANKQh+Q8KwrLjxvaJgJEpi4XJ1RC6
        c+3C3PheoSWKLX3QMfcWpUhZ5Wt48e6vnW8oFtxMUujkWpSmnS6LGTp0ph1n6ON0zIoYr1JyHd+gu
        RQvHO8Gw==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCa-0007rn-Gk; Mon, 20 Jul 2020 15:59:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 21/24] fs: move vfs_fstatat out of line
Date:   Mon, 20 Jul 2020 17:58:59 +0200
Message-Id: <20200720155902.181712-22-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720155902.181712-1-hch@lst.de>
References: <20200720155902.181712-1-hch@lst.de>
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
index 4d9d33c62fa2e5..0e0cd6a988bb38 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3296,15 +3296,10 @@ extern const struct inode_operations simple_symlink_inode_operations;
 
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
2.27.0

