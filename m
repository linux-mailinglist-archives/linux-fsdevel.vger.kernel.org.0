Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F126B263DA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgIJGxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 02:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgIJGwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:52:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131DBC061757
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JO41q0/wUWV3e29lw8/1jv5mxvs/Dutjv6L9E3A8Yh8=; b=JLsIF4YpzS/mOiMNlf/n0AYRsT
        A1CDw/ewffsqtdz546M/Huf1TjP7QTXG/pGJICOZ67UmJsMnLLdMwJb97EmkLDPZVq7FZVxigtuBQ
        JgTtkB9Cg6KK6Q1f0nJckMn/O7HWo2X6vFb+Kyos2G7h38A7+lYqbq7EvK1YyyR+JVLi5GrOoWz/Q
        lwe/BE84aUP0vkmhItYL2C9Lz1+8q5BcROBTgAhOicm6ZcrUd8YRLud8O6wtDC6fKrXMKY6BnzYJX
        mjjQNZGfxfN6eE7/z9M8YoosuMgy/trSMC4KFPmzEYUa06Gu6wj7WXvKsJn+jauJop0A/AotogJde
        5AoAsUXg==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGGIC-0000Bv-7G; Thu, 10 Sep 2020 06:42:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] fs: implement vfs_stat and vfs_lstat in terms of vfs_fstatat
Date:   Thu, 10 Sep 2020 08:42:40 +0200
Message-Id: <20200910064244.346913-3-hch@lst.de>
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

Go through vfs_fstatat instead of duplicating the *stat to statx mapping
three times.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bde55e637d5a12..107f6a84ead8f7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3168,21 +3168,19 @@ extern int iterate_dir(struct file *, struct dir_context *);
 extern int vfs_statx(int, const char __user *, int, struct kstat *, u32);
 int vfs_fstat(int fd, struct kstat *stat);
 
-static inline int vfs_stat(const char __user *filename, struct kstat *stat)
+static inline int vfs_fstatat(int dfd, const char __user *filename,
+			      struct kstat *stat, int flags)
 {
-	return vfs_statx(AT_FDCWD, filename, AT_NO_AUTOMOUNT,
+	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);
 }
-static inline int vfs_lstat(const char __user *name, struct kstat *stat)
+static inline int vfs_stat(const char __user *filename, struct kstat *stat)
 {
-	return vfs_statx(AT_FDCWD, name, AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
+	return vfs_fstatat(AT_FDCWD, filename, stat, 0);
 }
-static inline int vfs_fstatat(int dfd, const char __user *filename,
-			      struct kstat *stat, int flags)
+static inline int vfs_lstat(const char __user *name, struct kstat *stat)
 {
-	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
+	return vfs_fstatat(AT_FDCWD, name, stat, AT_SYMLINK_NOFOLLOW);
 }
 
 extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
-- 
2.28.0

