Return-Path: <linux-fsdevel+bounces-74365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6AAD39E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4A3830490A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E15326CE2F;
	Mon, 19 Jan 2026 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zUknqBWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC025F96B;
	Mon, 19 Jan 2026 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803799; cv=none; b=ZELRYlf6MujG5OphHxD/imV+zWiQ70v4N43CQSdkdBqTyaQVqdi5pqd37QU6eZPujUy7QGKx03Yj7GaSTEPFJL1Zlq9aMlqhm8Bo9TIDa61WQVnIYPxgf/rxEFBxVdKCKdwPUw1zzKYXPkeSF9FRkC418y2tkMazS5EM5ez0+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803799; c=relaxed/simple;
	bh=9j6+G8aj+43n+IrvM8Cm+Y4gSMfwTXr9jI7qGJrNJHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPRJlPhKWD+hqG+cMKK+aVbqwnxBJdVup6qdpDMxuC3h+1EyjsSXuNhf5au4XCZJqTitpg6oimqDf8zn73it/K9B1lztrOLyANmek4OcC0NZezo2cvjOW6zu/nesqwTJL8TewLUcxhgREJ2Hj4H5FmvjxCbKLog1UhbScTdKIGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zUknqBWI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=m7GlT00SLu2Nm7/9Y9dcJI7Ezxq/U09mHeb0mFUU1Nk=; b=zUknqBWIS9Rpc40DAMxqJ6Go0w
	q23jH0m6JroMnfB1Ycgm3HvXINgUnflNJHvr7lP0GH0ABx+mI8ueI9buq/YRQTW6FbnFt7SSADibv
	AhNDhUgWwpgOtOgIXh1PegJ5hIWUAU10bX0ZKL20L2FukchpIf0GjzTLLznilSg9PtLNtHpo/M8qH
	eRRYz+mB/J/SY079opfS4ahe6CQ0bhYMgQaRu6wNJQpQnMh8eHjuWV11G927xyy2HkNjzwQ8Uz7DJ
	wp5C3pLFyWLHxujHlyJwFRaMaJBCPvbqYwxCwbRbpj7+e/Uq++nBD+ZXpJz5pLJZ/tekta0ESn9et
	djokk29g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhifS-00000001OoB-2fOA;
	Mon, 19 Jan 2026 06:23:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 3/6] fs,fsverity: handle fsverity in generic_file_open
Date: Mon, 19 Jan 2026 07:22:44 +0100
Message-ID: <20260119062250.3998674-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119062250.3998674-1-hch@lst.de>
References: <20260119062250.3998674-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Call into fsverity_file_open from generic_file_open instead of requiring
the file system to handle it explicitly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file.c          |  6 ------
 fs/ext4/file.c           |  4 ----
 fs/f2fs/file.c           |  4 ----
 fs/open.c                |  8 +++++++-
 fs/verity/open.c         | 10 ++++++++--
 include/linux/fsverity.h | 32 +-------------------------------
 6 files changed, 16 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1abc7ed2990e..4b3a31b2b52e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3808,16 +3808,10 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	int ret;
-
 	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
 		return -EIO;
 
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-
-	ret = fsverity_file_open(inode, filp);
-	if (ret)
-		return ret;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b30932189..a7dc8c10273e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -906,10 +906,6 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 	if (ret)
 		return ret;
 
-	ret = fsverity_file_open(inode, filp);
-	if (ret)
-		return ret;
-
 	/*
 	 * Set up the jbd2_inode if we are opening the inode for
 	 * writing and the journal is present
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index da029fed4e5a..f1510ab657b6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -624,10 +624,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	err = fsverity_file_open(inode, filp);
-	if (err)
-		return err;
-
 	filp->f_mode |= FMODE_NOWAIT;
 	filp->f_mode |= FMODE_CAN_ODIRECT;
 
diff --git a/fs/open.c b/fs/open.c
index f328622061c5..dea93bab8795 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -10,6 +10,7 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/fsnotify.h>
+#include <linux/fsverity.h>
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/namei.h>
@@ -1604,10 +1605,15 @@ SYSCALL_DEFINE0(vhangup)
  * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
  * on this flag in sys_open.
  */
-int generic_file_open(struct inode * inode, struct file * filp)
+int generic_file_open(struct inode *inode, struct file *filp)
 {
 	if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
 		return -EOVERFLOW;
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
+		if (filp->f_mode & FMODE_WRITE)
+			return -EPERM;
+		return fsverity_file_open(inode, filp);
+	}
 	return 0;
 }
 
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 090cb77326ee..8ed915be9c91 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -376,13 +376,19 @@ static int ensure_verity_info(struct inode *inode)
 	return err;
 }
 
-int __fsverity_file_open(struct inode *inode, struct file *filp)
+/*
+ * When opening a verity file, deny the open if it is for writing.  Otherwise,
+ * set up the inode's verity info if not already done.
+ *
+ * When combined with fscrypt, this must be called after fscrypt_file_open().
+ * Otherwise, we won't have the key set up to decrypt the verity metadata.
+ */
+int fsverity_file_open(struct inode *inode, struct file *filp)
 {
 	if (filp->f_mode & FMODE_WRITE)
 		return -EPERM;
 	return ensure_verity_info(inode);
 }
-EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
 void fsverity_cleanup_inode(struct inode *inode)
 {
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index b7bf2401c574..4980ea55cdaa 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -130,6 +130,7 @@ struct fsverity_operations {
 				       u64 pos, unsigned int size);
 };
 
+int fsverity_file_open(struct inode *inode, struct file *filp);
 void fsverity_cleanup_inode(struct inode *inode);
 
 #ifdef CONFIG_FS_VERITY
@@ -178,10 +179,6 @@ int fsverity_get_digest(struct inode *inode,
 			u8 raw_digest[FS_VERITY_MAX_DIGEST_SIZE],
 			u8 *alg, enum hash_algo *halg);
 
-/* open.c */
-
-int __fsverity_file_open(struct inode *inode, struct file *filp);
-
 /* read_metadata.c */
 
 int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
@@ -225,13 +222,6 @@ static inline int fsverity_get_digest(struct inode *inode,
 	return 0;
 }
 
-/* open.c */
-
-static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
-{
-	return -EOPNOTSUPP;
-}
-
 /* read_metadata.c */
 
 static inline int fsverity_ioctl_read_metadata(struct file *filp,
@@ -289,24 +279,4 @@ static inline bool fsverity_active(const struct inode *inode)
 	return fsverity_get_info(inode) != NULL;
 }
 
-/**
- * fsverity_file_open() - prepare to open a verity file
- * @inode: the inode being opened
- * @filp: the struct file being set up
- *
- * When opening a verity file, deny the open if it is for writing.  Otherwise,
- * set up the inode's verity info if not already done.
- *
- * When combined with fscrypt, this must be called after fscrypt_file_open().
- * Otherwise, we won't have the key set up to decrypt the verity metadata.
- *
- * Return: 0 on success, -errno on failure
- */
-static inline int fsverity_file_open(struct inode *inode, struct file *filp)
-{
-	if (IS_VERITY(inode))
-		return __fsverity_file_open(inode, filp);
-	return 0;
-}
-
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3


