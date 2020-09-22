Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D82746EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 18:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVQpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 12:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVQpl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:45:41 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A791E206A1;
        Tue, 22 Sep 2020 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600793140;
        bh=KJG/afDmK47m3rqnV39odPryEOApG6+ci5+fwNNs5Ng=;
        h=From:To:Cc:Subject:Date:From;
        b=Mm/DWdSLE1WMJH492kJmnuwRB/s2CaFpkoraM/faMp+jS8cGq3Gb6Gs8GwfdxkOXw
         MGWDDwiuER1SpOj9+kU6VFSswWMaqY/QQ28QyxYRB4x5diRvZIbNiCp0323miVKZmQ
         X+TUK3TK3CtXRJ1vXN88CKhxKEPiwWwm5qT6utoU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] vfs: don't unnecessarily clone write access for writable fds
Date:   Tue, 22 Sep 2020 09:44:18 -0700
Message-Id: <20200922164418.119184-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

There's no need for mnt_want_write_file() to increment mnt_writers when
the file is already open for writing, provided that
mnt_drop_write_file() is changed to conditionally decrement it.

We seem to have ended up in the current situation because
mnt_want_write_file() used to be paired with mnt_drop_write(), due to
mnt_drop_write_file() not having been added yet.  So originally
mnt_want_write_file() had to always increment mnt_writers.

But later mnt_drop_write_file() was added, and all callers of
mnt_want_write_file() were paired with it.  This makes the compatibility
between mnt_want_write_file() and mnt_drop_write() no longer necessary.

Therefore, make __mnt_want_write_file() and __mnt_drop_write_file() skip
incrementing mnt_writers on files already open for writing.  This
removes the only caller of mnt_clone_write(), so remove that too.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v3: added note to porting file.
v2: keep the check for emergency r/o remounts.

 Documentation/filesystems/porting.rst |  7 ++++
 fs/namespace.c                        | 53 ++++++++++-----------------
 include/linux/mount.h                 |  1 -
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 867036aa90b8..6a6d3e673b48 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -865,3 +865,10 @@ no matter what.  Everything is handled by the caller.
 
 clone_private_mount() returns a longterm mount now, so the proper destructor of
 its result is kern_unmount() or kern_unmount_array().
+
+---
+
+**mandatory**
+
+mnt_want_write_file() can now only be paired with mnt_drop_write_file(),
+whereas previously it could be paired with mnt_drop_write() as well.
diff --git a/fs/namespace.c b/fs/namespace.c
index bae0e95b3713..941d359f349f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -359,51 +359,37 @@ int mnt_want_write(struct vfsmount *m)
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
+ * This is like __mnt_want_write, but if the file is already open for writing it
+ * skips incrementing mnt_writers (since the open file already has a reference)
+ * and instead only does the check for emergency r/o remounts.  This must be
+ * paired with __mnt_drop_write_file.
  */
 int __mnt_want_write_file(struct file *file)
 {
-	if (!(file->f_mode & FMODE_WRITER))
-		return __mnt_want_write(file->f_path.mnt);
-	else
-		return mnt_clone_write(file->f_path.mnt);
+	if (file->f_mode & FMODE_WRITER) {
+		/*
+		 * Superblock may have become readonly while there are still
+		 * writable fd's, e.g. due to a fs error with errors=remount-ro
+		 */
+		if (__mnt_is_readonly(file->f_path.mnt))
+			return -EROFS;
+		return 0;
+	}
+	return __mnt_want_write(file->f_path.mnt);
 }
 
 /**
  * mnt_want_write_file - get write access to a file's mount
  * @file: the file who's mount on which to take a write
  *
- * This is like mnt_want_write, but it takes a file and can
- * do some optimisations if the file is open for write already
+ * This is like mnt_want_write, but if the file is already open for writing it
+ * skips incrementing mnt_writers (since the open file already has a reference)
+ * and instead only does the freeze protection and the check for emergency r/o
+ * remounts.  This must be paired with mnt_drop_write_file.
  */
 int mnt_want_write_file(struct file *file)
 {
@@ -449,7 +435,8 @@ EXPORT_SYMBOL_GPL(mnt_drop_write);
 
 void __mnt_drop_write_file(struct file *file)
 {
-	__mnt_drop_write(file->f_path.mnt);
+	if (!(file->f_mode & FMODE_WRITER))
+		__mnt_drop_write(file->f_path.mnt);
 }
 
 void mnt_drop_write_file(struct file *file)
diff --git a/include/linux/mount.h b/include/linux/mount.h
index de657bd211fa..29d216f927c2 100644
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
2.28.0

