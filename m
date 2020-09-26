Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB7127976E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgIZHEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 03:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgIZHEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:04:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3C1C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JO41q0/wUWV3e29lw8/1jv5mxvs/Dutjv6L9E3A8Yh8=; b=EbaHj3X2SJp3Hl1t/D3mItTxhP
        eEP+yyFCRjFUpQGDA/Sd6/zFz4w98b6SYNnYn5b8zX7I3xvVxHFdsOYPInJtRw0opZwdUFaodYx0h
        Fsc6hTCWfPtxDYdgMXHoBWLnQBaP7DipG64O04sQpkHV7pFf9FA7GrmzuGQYGmdaaooFhjFq4MEWM
        1fm+GUSp8LZjG1OyrtqbnNY9uizzWPaX+IkQXXaRl9pj98wbtnjOEvoIw7ZJwDNKw6YLljn6SRMWu
        aqfJBtQXpcBkYNo7OFJjmAhXfFcZhNwRPJkEScMxyJXkBfCAz1YfqCL/JxeEVMA1874fof3Ojdj6S
        nRZy1S8A==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM4FX-0003vi-8y; Sat, 26 Sep 2020 07:04:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] fs: implement vfs_stat and vfs_lstat in terms of vfs_fstatat
Date:   Sat, 26 Sep 2020 09:03:58 +0200
Message-Id: <20200926070401.11816-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926070401.11816-1-hch@lst.de>
References: <20200926070401.11816-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

