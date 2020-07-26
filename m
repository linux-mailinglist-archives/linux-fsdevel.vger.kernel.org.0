Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F25C22DCDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgGZHOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgGZHOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34FC0619D2;
        Sun, 26 Jul 2020 00:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m67RdQ+cLDv76HGUGUecOWlHz7zkGO1looBZ2dbrIkU=; b=JqutL/ev0yJ8+3+EBDGRL3gJMt
        t8gXjOTvtDaP+seE1B8Z55/ZpHpwbBiPPBpxFoOvSXmgkiNo4bRYoBksSfjnoa5V3Yaj9477riP6z
        fQJ0UUfpb9FeOELaqNnYkAnWrWqLvllDGmwEZ24oBEwPyVvQj3IcK9fyfHWE17wye225eoujZr2Bb
        2EXNPPJwFKddRMM2ulQOWRUbKgo4RutRDDj390GrC7WPS2E2lnry/3syTrxIJX7ZpSHmMdNNr2UnP
        pWkRkbS7KLOWNT/kQUj5hhgPIm0aJTiLTrlSAqezo/KTn6lNGuNWlynsDEvEsV7BLuOsE1LFxrz22
        z0Zz0myg==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarD-0002OG-GC; Sun, 26 Jul 2020 07:14:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 03/21] fs: push the getname from do_rmdir into the callers
Date:   Sun, 26 Jul 2020 09:13:38 +0200
Message-Id: <20200726071356.287160-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This mirrors do_unlinkat and will make life a little easier for
the init code to reuse the whole function with a kernel filename.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  2 +-
 fs/namei.c               | 10 ++++------
 include/linux/syscalls.h |  4 ++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd70892..e903d5aae139a2 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -65,7 +65,7 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		unsigned int dev);
 long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
-long do_rmdir(int dfd, const char __user *pathname);
+long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
 long do_symlinkat(const char __user *oldname, int newdfd,
 		  const char __user *newname);
diff --git a/fs/namei.c b/fs/namei.c
index 72d4219c93acb7..d75a6039ae3966 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3720,17 +3720,16 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(vfs_rmdir);
 
-long do_rmdir(int dfd, const char __user *pathname)
+long do_rmdir(int dfd, struct filename *name)
 {
 	int error = 0;
-	struct filename *name;
 	struct dentry *dentry;
 	struct path path;
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
 retry:
-	name = filename_parentat(dfd, getname(pathname), lookup_flags,
+	name = filename_parentat(dfd, name, lookup_flags,
 				&path, &last, &type);
 	if (IS_ERR(name))
 		return PTR_ERR(name);
@@ -3781,7 +3780,7 @@ long do_rmdir(int dfd, const char __user *pathname)
 
 SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 {
-	return do_rmdir(AT_FDCWD, pathname);
+	return do_rmdir(AT_FDCWD, getname(pathname));
 }
 
 /**
@@ -3926,8 +3925,7 @@ SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
 		return -EINVAL;
 
 	if (flag & AT_REMOVEDIR)
-		return do_rmdir(dfd, pathname);
-
+		return do_rmdir(dfd, getname(pathname));
 	return do_unlinkat(dfd, getname(pathname));
 }
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5b0f1fca4cfb9d..e43816198e6001 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1281,11 +1281,11 @@ static inline long ksys_unlink(const char __user *pathname)
 	return do_unlinkat(AT_FDCWD, getname(pathname));
 }
 
-extern long do_rmdir(int dfd, const char __user *pathname);
+long do_rmdir(int dfd, struct filename *name);
 
 static inline long ksys_rmdir(const char __user *pathname)
 {
-	return do_rmdir(AT_FDCWD, pathname);
+	return do_rmdir(AT_FDCWD, getname(pathname));
 }
 
 extern long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
-- 
2.27.0

