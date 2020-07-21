Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715D3228573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgGUQ3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgGUQ3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:29:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD9CC0619DB;
        Tue, 21 Jul 2020 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L5mNnyAh7TTJU/UL2HuNsPfBcqjqx7vLymqkgOR15KI=; b=YSYO+n9G+8ENh/LnK3lm82oCfy
        ZAZ/aXpI71UChVbUuUrHksTQ5wuLlSfRL+lypBv5imfCxfbCbeVlWWr4ilawE5yWVP8u8NlmN9Wb2
        pma6AR47nsB3gQM5jd0rbxzOjM2QiKR+XFgtjAbtIDoLtd0/anX8qu4tJt5tHgkpB529m0hKGTT0+
        Z8qZMuQygqbkylPIBNlSF73vxcdfA1W9qeO8NIfithAb1nFttIGiTJbPZtWlXuOsb9s90+nxhV/8d
        25I86AV6KhFKIBOQzU0meFZOAci6NPBOa/c33zCo0p2zBVX3WvQpc0H4yH1DKABr6nVRzMLg7IzM9
        3+Dc6lWA==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8U-0007Z9-PH; Tue, 21 Jul 2020 16:28:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 24/24] init: add an init_lstat helper
Date:   Tue, 21 Jul 2020 18:28:18 +0200
Message-Id: <20200721162818.197315-25-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to lstat with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_lstat.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.h |  1 +
 init/fs.c        | 14 ++++++++++++++
 init/initramfs.c |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index a793bafc6c6f2b..20766cfe549b48 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,6 +16,7 @@ int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
+int __init init_lstat(const char *filename, struct kstat *stat);
 int __init init_mknod(const char *filename, umode_t mode, unsigned int dev);
 int __init init_link(const char *oldname, const char *newname);
 int __init init_symlink(const char *oldname, const char *newname);
diff --git a/init/fs.c b/init/fs.c
index 7f0e50a877fc98..b387ff67f365db 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -103,6 +103,20 @@ int __init init_eaccess(const char *filename)
 	return error;
 }
 
+int __init init_lstat(const char *filename, struct kstat *stat)
+{
+	struct path path;
+	int error;
+
+	error = kern_path(filename, 0, &path);
+	if (error)
+		return error;
+	error = vfs_getattr(&path, stat, STATX_BASIC_STATS,
+			    AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT);
+	path_put(&path);
+	return error;
+}
+
 int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 {
 	struct dentry *dentry;
diff --git a/init/initramfs.c b/init/initramfs.c
index bd685fdb5840f3..8c9f92f1660b96 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -304,7 +304,7 @@ static void __init clean_path(char *path, umode_t fmode)
 {
 	struct kstat st;
 
-	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
+	if (!init_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
 			init_rmdir(path);
 		else
-- 
2.27.0

