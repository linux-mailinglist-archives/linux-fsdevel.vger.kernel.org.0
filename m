Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83578141E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 22:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379901AbjHRUJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 16:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379904AbjHRUIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:08:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA9A3C20;
        Fri, 18 Aug 2023 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UGZv0mcmqWJU2GElWXQ4POFjyVj5GsY8tdHi57flpjA=; b=bmSAo9yw2d7X/wbitTbnlRgaG6
        X9rXlHhzcITAiS5/7vpokhpYR+A0CGooKUcSc0O07/oIcpx+KahZ02g3c8G907FHN/MVv1UFpI2QQ
        yiCV4PBKdg+8lT70J34+bEfPUDtAy59+EoPdDPFt9xghEi9cAZTauecJh9WCmwiuOekFCkq8co2ng
        8SEPlfetFnf6W6miqD46/aJcmdqFOemkY2n8DU2Xikx/FWOylN4ReycMNdXY+7wGoqjmvwSuJliVD
        axVPLHfFHoGk92lK7xPXmiJN3yfZyRHgjm34bTUb5jHBX3yyZHYHJQJn5sRGS3TZRfeUZYgWW95Xq
        keqAtDqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5lp-00BPbZ-Hh; Fri, 18 Aug 2023 20:08:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: [PATCH] fs: Fix kernel-doc warnings
Date:   Fri, 18 Aug 2023 21:08:24 +0100
Message-Id: <20230818200824.2720007-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These have a variety of causes and a corresponding variety of solutions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/file.c             |  3 ++-
 fs/fs_context.c       | 12 +++++++++---
 fs/ioctl.c            | 10 +++++++---
 fs/kernel_read_file.c | 12 ++++++------
 fs/namei.c            |  3 +++
 fs/open.c             |  4 ++--
 6 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index a8c47c4b6b17..3e4a4dfa38fc 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -668,7 +668,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
 
 /**
  * last_fd - return last valid index into fd table
- * @cur_fds: files struct
+ * @fdt: File descriptor table.
  *
  * Context: Either rcu read lock or files_lock must be held.
  *
@@ -724,6 +724,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
+ * @flags:  CLOSE_RANGE flags.
  *
  * This closes a range of file descriptors. All file descriptors
  * from @fd up to and including @max_fd are closed.
diff --git a/fs/fs_context.c b/fs/fs_context.c
index fbcdcd301465..a0ad7a0c4680 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -162,6 +162,10 @@ EXPORT_SYMBOL(vfs_parse_fs_param);
 
 /**
  * vfs_parse_fs_string - Convenience function to just parse a string.
+ * @fc: Filesystem context.
+ * @key: Parameter name.
+ * @value: Default value.
+ * @v_size: Maximum number of bytes in the value.
  */
 int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			const char *value, size_t v_size)
@@ -189,7 +193,7 @@ EXPORT_SYMBOL(vfs_parse_fs_string);
 
 /**
  * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
- * @ctx: The superblock configuration to fill in.
+ * @fc: The superblock configuration to fill in.
  * @data: The data to parse
  *
  * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
@@ -354,7 +358,7 @@ void fc_drop_locked(struct fs_context *fc)
 static void legacy_fs_context_free(struct fs_context *fc);
 
 /**
- * vfs_dup_fc_config: Duplicate a filesystem context.
+ * vfs_dup_fs_context - Duplicate a filesystem context.
  * @src_fc: The context to copy.
  */
 struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
@@ -400,7 +404,9 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
 
 /**
  * logfc - Log a message to a filesystem context
- * @fc: The filesystem context to log to.
+ * @log: The filesystem context to log to, or NULL to use printk.
+ * @prefix: A string to prefix the output with, or NULL.
+ * @level: 'w' for a warning, 'e' for an error.  Anything else is a notice.
  * @fmt: The format of the buffer.
  */
 void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...)
diff --git a/fs/ioctl.c b/fs/ioctl.c
index a56cbceedcd1..f5fd99d6b0d4 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -109,9 +109,6 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
  * Returns 0 on success, -errno on error, 1 if this was the last
  * extent that will fit in user array.
  */
-#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
-#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
-#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
 int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 			    u64 phys, u64 len, u32 flags)
 {
@@ -127,6 +124,10 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
 		return 1;
 
+#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
+#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
+#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
+
 	if (flags & SET_UNKNOWN_FLAGS)
 		flags |= FIEMAP_EXTENT_UNKNOWN;
 	if (flags & SET_NO_UNMOUNTED_IO_FLAGS)
@@ -877,6 +878,9 @@ SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 #ifdef CONFIG_COMPAT
 /**
  * compat_ptr_ioctl - generic implementation of .compat_ioctl file operation
+ * @file: The file to operate on.
+ * @cmd: The ioctl command number.
+ * @arg: The argument to the ioctl.
  *
  * This is not normally called as a function, but instead set in struct
  * file_operations as
diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..c429c42a6867 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -8,16 +8,16 @@
 /**
  * kernel_read_file() - read file contents into a kernel buffer
  *
- * @file	file to read from
- * @offset	where to start reading from (see below).
- * @buf		pointer to a "void *" buffer for reading into (if
+ * @file:	file to read from
+ * @offset:	where to start reading from (see below).
+ * @buf:	pointer to a "void *" buffer for reading into (if
  *		*@buf is NULL, a buffer will be allocated, and
  *		@buf_size will be ignored)
- * @buf_size	size of buf, if already allocated. If @buf not
+ * @buf_size:	size of buf, if already allocated. If @buf not
  *		allocated, this is the largest size to allocate.
- * @file_size	if non-NULL, the full size of @file will be
+ * @file_size:	if non-NULL, the full size of @file will be
  *		written here.
- * @id		the kernel_read_file_id identifying the type of
+ * @id:		the kernel_read_file_id identifying the type of
  *		file contents being read (for LSMs to examine)
  *
  * @offset must be 0 unless both @buf and @file_size are non-NULL
diff --git a/fs/namei.c b/fs/namei.c
index 2bae29ea52ff..567ee547492b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -643,6 +643,8 @@ static bool nd_alloc_stack(struct nameidata *nd)
 
 /**
  * path_connected - Verify that a dentry is below mnt.mnt_root
+ * @mnt: The mountpoint to check.
+ * @dentry: The dentry to check.
  *
  * Rename can sometimes move a file or directory outside of a bind
  * mount, path_connected allows those cases to be detected.
@@ -1083,6 +1085,7 @@ fs_initcall(init_fs_namei_sysctls);
 /**
  * may_follow_link - Check symlink following for unsafe situations
  * @nd: nameidata pathwalk data
+ * @inode: Used for idmapping.
  *
  * In the case of the sysctl_protected_symlinks sysctl being enabled,
  * CAP_DAC_OVERRIDE needs to be specifically ignored if the symlink is
diff --git a/fs/open.c b/fs/open.c
index 0142c3895b8c..98f6601fbac6 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1165,7 +1165,7 @@ EXPORT_SYMBOL_GPL(kernel_file_open);
  * backing_file_open - open a backing file for kernel internal use
  * @path:	path of the file to open
  * @flags:	open flags
- * @path:	path of the backing file
+ * @real_path:	path of the backing file
  * @cred:	credentials for open
  *
  * Open a backing file for a stackable filesystem (e.g., overlayfs).
@@ -1582,7 +1582,7 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
 }
 
 /**
- * close_range() - Close all file descriptors in a given range.
+ * sys_close_range() - Close all file descriptors in a given range.
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
-- 
2.40.1

