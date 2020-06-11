Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AACC1F5FAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 03:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFKBwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 21:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgFKBwD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:52:03 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D01206FA;
        Thu, 11 Jun 2020 01:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840322;
        bh=qbhSXLGqy7qKk7V8hkialrDuSQLkU9NtfJIsVojnTwc=;
        h=From:To:Cc:Subject:Date:From;
        b=sbx8Li1Wuw7e/oAQaOUigHdRbD0pm5fYb454vG+P5N0XSoQipsxiiOk93Wl0gc55X
         wepuAwrWpSrGWRUp6z4kAzlTIZ3JSPd3n+UtZNymCtqvfrmK3kw6oAsVU5/LyE0aWJ
         9egxyTQ73g82Vn28GLHRvIkvqgHGveY5LupSF2Jo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: don't unnecessarily clone write access for writable fds
Date:   Wed, 10 Jun 2020 18:49:45 -0700
Message-Id: <20200611014945.237210-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

There's no need for mnt_want_write_file() to clone a write reference to
the mount when the file is already open for writing, provided that
mnt_drop_write_file() is changed to conditionally drop the reference.

We seem to have ended up in the current situation because
mnt_want_write_file() used to be paired with mnt_drop_write(), due to
mnt_drop_write_file() not having been added yet.  So originally
mnt_want_write_file() did have to always take a reference.

But later mnt_drop_write_file() was added, and all callers of
mnt_want_write_file() were paired with it.  This makes the compatibility
between mnt_want_write_file() and mnt_drop_write() no longer necessary.

Therefore, make __mnt_want_write_file() and __mnt_drop_write_file() be
no-ops on files already open for writing.  This removes the only caller
of mnt_clone_write(), so remove that too.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c        | 43 ++++++++++---------------------------------
 include/linux/mount.h |  1 -
 2 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7cd64240916573..7e78c7ae4ab34d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -359,51 +359,27 @@ int mnt_want_write(struct vfsmount *m)
 }
 EXPORT_SYMBOL_GPL(mnt_want_write);
 
-/**
- * mnt_clone_write - get write access to a mount
- * @mnt: the mount on which to take a write
- *
- * This is effectively like mnt_want_write, except
- * it must only be used to take an extra write reference
- * on a mountpoint that we already know has a write reference
- * on it. This allows some optimisation.
- *
- * After finished, mnt_drop_write must be called as usual to
- * drop the reference.
- */
-int mnt_clone_write(struct vfsmount *mnt)
-{
-	/* superblock may be r/o */
-	if (__mnt_is_readonly(mnt))
-		return -EROFS;
-	preempt_disable();
-	mnt_inc_writers(real_mount(mnt));
-	preempt_enable();
-	return 0;
-}
-EXPORT_SYMBOL_GPL(mnt_clone_write);
-
 /**
  * __mnt_want_write_file - get write access to a file's mount
  * @file: the file who's mount on which to take a write
  *
- * This is like __mnt_want_write, but it takes a file and can
- * do some optimisations if the file is open for write already
+ * This is like __mnt_want_write, but it does nothing if the file is already
+ * open for writing.  This must be paired with __mnt_drop_write_file.
  */
 int __mnt_want_write_file(struct file *file)
 {
-	if (!(file->f_mode & FMODE_WRITER))
-		return __mnt_want_write(file->f_path.mnt);
-	else
-		return mnt_clone_write(file->f_path.mnt);
+	if (file->f_mode & FMODE_WRITER)
+		return 0;
+	return __mnt_want_write(file->f_path.mnt);
 }
 
 /**
  * mnt_want_write_file - get write access to a file's mount
  * @file: the file who's mount on which to take a write
  *
- * This is like mnt_want_write, but it takes a file and can
- * do some optimisations if the file is open for write already
+ * This is like mnt_want_write, but it skips getting write access to the mount
+ * if the file is already open for writing.  The freeze protection is still
+ * done.  This must be paired with mnt_drop_write_file.
  */
 int mnt_want_write_file(struct file *file)
 {
@@ -449,7 +425,8 @@ EXPORT_SYMBOL_GPL(mnt_drop_write);
 
 void __mnt_drop_write_file(struct file *file)
 {
-	__mnt_drop_write(file->f_path.mnt);
+	if (!(file->f_mode & FMODE_WRITER))
+		__mnt_drop_write(file->f_path.mnt);
 }
 
 void mnt_drop_write_file(struct file *file)
diff --git a/include/linux/mount.h b/include/linux/mount.h
index de657bd211fa64..29d216f927c28c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -78,7 +78,6 @@ struct path;
 
 extern int mnt_want_write(struct vfsmount *mnt);
 extern int mnt_want_write_file(struct file *file);
-extern int mnt_clone_write(struct vfsmount *mnt);
 extern void mnt_drop_write(struct vfsmount *mnt);
 extern void mnt_drop_write_file(struct file *file);
 extern void mntput(struct vfsmount *mnt);
-- 
2.26.2

