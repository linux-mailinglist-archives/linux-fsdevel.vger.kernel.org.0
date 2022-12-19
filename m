Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3EA6509AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiLSJ55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 04:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiLSJ54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:57:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191C3889
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Dec 2022 01:57:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q71so5803205pgq.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Dec 2022 01:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUAthytXAfZNN9Q5GeW71pxiq2xX0mTpx+tGRKPO7HQ=;
        b=qebngIxbW6R5UjDO1+doGep8fMLZT+r7FEjXuNTNT6/x5sautCvI27Lv4OtuA5TMhS
         H/cRoCLANmAkSwNoxI/Zyve94erK4Ohn5BJ6eeRRW3F63QDYR1rSW6HEG9eRWCtuVqLw
         1bSmTfaijpg2ynphvej4a7tB6P7j9amRp+ydxphEupklKhxoQK1KgITIy5sDZTW4PfAq
         OtxEo1ykUSlGRi0pe1H+8tsPlj3Y5ghj8ULijV7L42QzzKSHYiooWkX+slXaTalkZ7RN
         DXE8N43n9Hwkrk+jAOldOksjt3TluQiXjxPtZXSlNEczllJAARRtjcFuEcFlTJERqydb
         FP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUAthytXAfZNN9Q5GeW71pxiq2xX0mTpx+tGRKPO7HQ=;
        b=ubOz4f7ZHRbP0E2oKsBtJLK9uAchOIbo1hTcj9cKCzBQrkshroSnVHQhCI61dS7ggL
         8sdy4o6IHViAvSGQwNs+r4wAbkFfXWuNICDllNdG0aZ3TNX7W1WViieL4KOP6lXCUU0x
         vSOByVVe+NCxxUAPkgDqRgSth9KKitFQ+WKY4mfSzorAPiJYfsZS9jlD9Ju3aOvnzuXG
         KwMYZwD5bBIwbt4jsrKmZIndVwGIK/sB2ptmNeS5TM1cr4uFPPDQglws/+GBBzUpAjXH
         hVUxceLmtztUpFJ7B1EQ8NoUXsaNt1Gdz1fA79JMGGrDoWF5UyudvBZ9WivMsDLXYi7P
         ezOg==
X-Gm-Message-State: ANoB5pnH/27rmH9FWuQ3Y1EneRFI45vicAxpmMNeGFVNvtbqD3YDfNjh
        pqVt3UkKq4TeZ0UMKczy9rFZjQAdPVEL+g==
X-Google-Smtp-Source: AA0mqf5Pc9yR3zQ1/z1lVPGOjJsmQTAZ5ZoCEBNZqsLWqQlTQHRspUuxcAzTq85zdsgJ8JPdIPkC/A==
X-Received: by 2002:a62:e806:0:b0:578:83e2:f1bd with SMTP id c6-20020a62e806000000b0057883e2f1bdmr31248707pfi.29.1671443873626;
        Mon, 19 Dec 2022 01:57:53 -0800 (PST)
Received: from localhost ([223.104.213.27])
        by smtp.gmail.com with ESMTPSA id k10-20020aa79d0a000000b00575da69a16asm6350193pfp.179.2022.12.19.01.57.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Dec 2022 01:57:52 -0800 (PST)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] fs: Unifiy the format of function pointers in some commonly used operation structures
Date:   Mon, 19 Dec 2022 01:57:29 -0800
Message-Id: <20221219095729.16615-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In current, the format of function pointer in structures
is somewhat messy, some function prototypes have space
after the function name and some do not. Unified them in
some commonly used operation structures.

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 include/linux/fs.h | 118 ++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 066555ad1bf8..42da98570891 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -269,7 +269,7 @@ struct iattr {
  */
 #define FILESYSTEM_MAX_STACK_DEPTH 2
 
-/** 
+/**
  * enum positive_aop_returns - aop return codes with specific semantics
  *
  * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
@@ -279,7 +279,7 @@ struct iattr {
  * 			    be a candidate for writeback again in the near
  * 			    future.  Other callers must be careful to unlock
  * 			    the page if they get this return.  Returned by
- * 			    writepage(); 
+ * 			    writepage();
  *
  * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
  *  			unlocked it and the page might have been truncated.
@@ -354,47 +354,47 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 }
 
 struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*read_folio)(struct file *, struct folio *);
+	int (*writepage) (struct page *page, struct writeback_control *wbc);
+	int (*read_folio) (struct file *, struct folio *);
 
 	/* Write back some dirty pages from this mapping. */
-	int (*writepages)(struct address_space *, struct writeback_control *);
+	int (*writepages) (struct address_space *, struct writeback_control *);
 
 	/* Mark a folio dirty.  Return true if this dirtied it */
-	bool (*dirty_folio)(struct address_space *, struct folio *);
+	bool (*dirty_folio) (struct address_space *, struct folio *);
 
-	void (*readahead)(struct readahead_control *);
+	void (*readahead) (struct readahead_control *);
 
-	int (*write_begin)(struct file *, struct address_space *mapping,
+	int (*write_begin) (struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len,
 				struct page **pagep, void **fsdata);
-	int (*write_end)(struct file *, struct address_space *mapping,
+	int (*write_end) (struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata);
 
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
-	sector_t (*bmap)(struct address_space *, sector_t);
+	sector_t (*bmap) (struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
-	bool (*release_folio)(struct folio *, gfp_t);
-	void (*free_folio)(struct folio *folio);
-	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
+	bool (*release_folio) (struct folio *, gfp_t);
+	void (*free_folio) (struct folio *folio);
+	ssize_t (*direct_IO) (struct kiocb *, struct iov_iter *iter);
 	/*
 	 * migrate the contents of a folio to the specified target. If
 	 * migrate_mode is MIGRATE_ASYNC, it must not block.
 	 */
-	int (*migrate_folio)(struct address_space *, struct folio *dst,
+	int (*migrate_folio) (struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
-	int (*launder_folio)(struct folio *);
+	int (*launder_folio) (struct folio *);
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
 	void (*is_dirty_writeback) (struct folio *, bool *dirty, bool *wb);
-	int (*error_remove_page)(struct address_space *, struct page *);
+	int (*error_remove_page) (struct address_space *, struct page *);
 
 	/* swapfile support */
-	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
+	int (*swap_activate) (struct swap_info_struct *sis, struct file *file,
 				sector_t *span);
-	void (*swap_deactivate)(struct file *file);
-	int (*swap_rw)(struct kiocb *iocb, struct iov_iter *iter);
+	void (*swap_deactivate) (struct file *file);
+	int (*swap_rw) (struct kiocb *iocb, struct iov_iter *iter);
 };
 
 extern const struct address_space_operations empty_aops;
@@ -995,8 +995,8 @@ static inline struct file *get_file(struct file *f)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
-/* Page cache limit. The filesystems should put that into their s_maxbytes 
-   limits, otherwise bad things can happen in VM. */ 
+/* Page cache limit. The filesystems should put that into their s_maxbytes
+   limits, otherwise bad things can happen in VM. */
 #if BITS_PER_LONG==32
 #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
 #elif BITS_PER_LONG==64
@@ -2092,7 +2092,7 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
+	int (*iopoll) (struct kiocb *kiocb, struct io_comp_batch *,
 			unsigned int flags);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
@@ -2108,34 +2108,34 @@ struct file_operations {
 	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
-	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
-	int (*check_flags)(int);
+	unsigned long (*get_unmapped_area) (struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+	int (*check_flags) (int);
 	int (*flock) (struct file *, int, struct file_lock *);
-	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
-	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
-	int (*setlease)(struct file *, long, struct file_lock **, void **);
-	long (*fallocate)(struct file *file, int mode, loff_t offset,
+	ssize_t (*splice_write) (struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
+	ssize_t (*splice_read) (struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
+	int (*setlease) (struct file *, long, struct file_lock **, void **);
+	long (*fallocate) (struct file *file, int mode, loff_t offset,
 			  loff_t len);
-	void (*show_fdinfo)(struct seq_file *m, struct file *f);
+	void (*show_fdinfo) (struct seq_file *m, struct file *f);
 #ifndef CONFIG_MMU
-	unsigned (*mmap_capabilities)(struct file *);
+	unsigned (*mmap_capabilities) (struct file *);
 #endif
-	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
+	ssize_t (*copy_file_range) (struct file *, loff_t, struct file *,
 			loff_t, size_t, unsigned int);
-	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
+	loff_t (*remap_file_range) (struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
-	int (*fadvise)(struct file *, loff_t, loff_t, int);
-	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
-	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
+	int (*fadvise) (struct file *, loff_t, loff_t, int);
+	int (*uring_cmd) (struct io_uring_cmd *ioucmd, unsigned int issue_flags);
+	int (*uring_cmd_iopoll) (struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 } __randomize_layout;
 
 struct inode_operations {
-	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
-	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
+	struct dentry *(*lookup) (struct inode *,struct dentry *, unsigned int);
+	const char *(*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct user_namespace *, struct inode *, int);
-	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
+	struct posix_acl *(*get_inode_acl)(struct inode *, int, bool);
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
@@ -2157,21 +2157,21 @@ struct inode_operations {
 	int (*getattr) (struct user_namespace *, const struct path *,
 			struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
-	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
+	int (*fiemap) (struct inode *, struct fiemap_extent_info *, u64 start,
 		      u64 len);
-	int (*update_time)(struct inode *, struct timespec64 *, int);
-	int (*atomic_open)(struct inode *, struct dentry *,
+	int (*update_time) (struct inode *, struct timespec64 *, int);
+	int (*atomic_open) (struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
 	int (*tmpfile) (struct user_namespace *, struct inode *,
 			struct file *, umode_t);
-	struct posix_acl *(*get_acl)(struct user_namespace *, struct dentry *,
+	struct posix_acl *(*get_acl) (struct user_namespace *, struct dentry *,
 				     int);
-	int (*set_acl)(struct user_namespace *, struct dentry *,
+	int (*set_acl) (struct user_namespace *, struct dentry *,
 		       struct posix_acl *, int);
-	int (*fileattr_set)(struct user_namespace *mnt_userns,
+	int (*fileattr_set) (struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct fileattr *fa);
-	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+	int (*fileattr_get) (struct dentry *dentry, struct fileattr *fa);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
@@ -2219,9 +2219,9 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 
 
 struct super_operations {
-   	struct inode *(*alloc_inode)(struct super_block *sb);
-	void (*destroy_inode)(struct inode *);
-	void (*free_inode)(struct inode *);
+   	struct inode *(*alloc_inode) (struct super_block *sb);
+	void (*destroy_inode) (struct inode *);
+	void (*free_inode) (struct inode *);
 
    	void (*dirty_inode) (struct inode *, int flags);
 	int (*write_inode) (struct inode *, struct writeback_control *wbc);
@@ -2237,18 +2237,18 @@ struct super_operations {
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*umount_begin) (struct super_block *);
 
-	int (*show_options)(struct seq_file *, struct dentry *);
-	int (*show_devname)(struct seq_file *, struct dentry *);
-	int (*show_path)(struct seq_file *, struct dentry *);
-	int (*show_stats)(struct seq_file *, struct dentry *);
+	int (*show_options) (struct seq_file *, struct dentry *);
+	int (*show_devname) (struct seq_file *, struct dentry *);
+	int (*show_path) (struct seq_file *, struct dentry *);
+	int (*show_stats) (struct seq_file *, struct dentry *);
 #ifdef CONFIG_QUOTA
-	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
-	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	struct dquot **(*get_dquots)(struct inode *);
+	ssize_t (*quota_read) (struct super_block *, int, char *, size_t, loff_t);
+	ssize_t (*quota_write) (struct super_block *, int, const char *, size_t, loff_t);
+	struct dquot **(*get_dquots) (struct inode *);
 #endif
-	long (*nr_cached_objects)(struct super_block *,
+	long (*nr_cached_objects) (struct super_block *,
 				  struct shrink_control *);
-	long (*free_cached_objects)(struct super_block *,
+	long (*free_cached_objects) (struct super_block *,
 				    struct shrink_control *);
 };
 
@@ -2524,7 +2524,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
@@ -3020,7 +3020,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
- 
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
-- 
2.17.1

