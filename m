Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F81226996
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbgGTQ12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731933AbgGTP7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F251CC061794;
        Mon, 20 Jul 2020 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GG95OiZu2CbYd0JRwLQ4UfdAnmHOnJcLKvPhKlyzJ48=; b=FNpj6qyMF4zS/bLhD4mCaL/01G
        yMDSh1DSkpzTLTJFm0Y6cZNZ1V7Be3Wq2/caQQipU8WxEgriN8O8BJCi9J4+PAP0/Lis3hRO29Ke1
        lW7X/nGlreRGMIBOCU2WT523JrubFK6oqvcQPkHCe/d9Y17jKwZz5+iNZa6piXFMX4FAI3Tvd0r3N
        BqBcn0HROLh4EXADwnUK/sPoknrqUJwl47Qozg1t/v7KrvUuPvxtUERHPFANdU61UryrHl/8CJHX3
        AnCLB5oHeK0xt4BZN7tq3++vG7yzdmOHEW3cFzFsTKFOtTi8p4hk03F3gIPuwJkjrUIVV0AEYtVu5
        iqsyHtbw==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCY-0007rU-VZ; Mon, 20 Jul 2020 15:59:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 20/24] fs: implement vfs_stat and vfs_lstat in terms of vfs_fstatat
Date:   Mon, 20 Jul 2020 17:58:58 +0200
Message-Id: <20200720155902.181712-21-hch@lst.de>
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

Go through vfs_fstatat instead of duplicating the *stat to statx mapping
three times.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0169d3efa844d0..4d9d33c62fa2e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3299,21 +3299,19 @@ extern int iterate_dir(struct file *, struct dir_context *);
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
2.27.0

