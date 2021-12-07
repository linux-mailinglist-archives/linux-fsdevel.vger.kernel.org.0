Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7070646BEF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhLGPOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 10:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhLGPNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:13:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE43C0698DE;
        Tue,  7 Dec 2021 07:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8901ACE1B6F;
        Tue,  7 Dec 2021 15:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DD1C341C5;
        Tue,  7 Dec 2021 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638889809;
        bh=2BmJx6yIJdFye4bXEzRWTrrg2Egv3kemAFm7efhWefI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfB8kU+9bb4ZtD/2LZoS7VpFT/QvWzYDEzWAuiYcyaIQWUG45rLXd3X7LpbYxleiA
         +8QMw2fb9G4em448oNUxy9+bc58rwc8T9XbhB8T/C9Zmfxx9jRZzaTKfgzhyv4H3DK
         9JYHWiT469zNVy0ICKqomxBXs8L5/+8bzljVcrpFTgU7IJkqdN3EPnEfOV7sJ3sP0o
         +J5tzWbBfZ504sE0M5MaJuYi3kyz9AyJOrK4NhNOjC/7nxZYZvoua5vMSkO5cfDGdX
         c4tyRc0A58dpAJwE8nUDMGc+1rUEfQgexM3lA/Zmt6WTFXkYgEk9t4tV+wUFVv/O8r
         QasDwKzu95kmQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [RFC 3/3] headers: repurpose linux/fs_types.h
Date:   Tue,  7 Dec 2021 16:09:27 +0100
Message-Id: <20211207150927.3042197-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211207150927.3042197-1-arnd@kernel.org>
References: <20211207150927.3042197-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

linux/fs_types.h traditionally describes the types of file systems we
deal with, but the file name could also be interpreted to refer to
data types used for interacting with file systems, similar to
linux/spinlock_types.h or linux/mm_types.h.

Splitting out the data type definitions from the generic header helps
avoid excessive indirect include hierarchies, so steal this file
name and repurpose it to contain the definitions for file, inode,
address_space, super_block, file_lock, quota and filename, along with
their respective callback operations, moving them out of linux/fs.h.

The preprocessed linux/fs_types.h is now about 50KB, compared to
over 1MB for the traditional linux/fs.h, and can be included from
most other headers that currently rely on type definitions from
linux/fs.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/fs.h       | 1151 +----------------------------------
 include/linux/fs_types.h | 1225 +++++++++++++++++++++++++++++++++++++-
 include/linux/quota.h    |   29 -
 3 files changed, 1227 insertions(+), 1178 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9617dea24978..dca9a2c073c5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
 
+#include <linux/fs_types.h>
 #include <linux/linkage.h>
 #include <linux/wait_bit.h>
 #include <linux/kdev_t.h>
@@ -36,7 +37,6 @@
 #include <linux/uuid.h>
 #include <linux/errseq.h>
 #include <linux/ioprio.h>
-#include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
 #include <linux/mount.h>
@@ -82,203 +82,11 @@ extern void __init files_maxfiles_init(void);
 extern unsigned long get_max_files(void);
 extern unsigned int sysctl_nr_open;
 
-typedef __kernel_rwf_t rwf_t;
-
-struct buffer_head;
-typedef int (get_block_t)(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create);
-typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
-			ssize_t bytes, void *private);
-
-#define MAY_EXEC		0x00000001
-#define MAY_WRITE		0x00000002
-#define MAY_READ		0x00000004
-#define MAY_APPEND		0x00000008
-#define MAY_ACCESS		0x00000010
-#define MAY_OPEN		0x00000020
-#define MAY_CHDIR		0x00000040
-/* called from RCU mode, don't block */
-#define MAY_NOT_BLOCK		0x00000080
-
-/*
- * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
- * to O_WRONLY and O_RDWR via the strange trick in do_dentry_open()
- */
-
-/* file is open for reading */
-#define FMODE_READ		((__force fmode_t)0x1)
-/* file is open for writing */
-#define FMODE_WRITE		((__force fmode_t)0x2)
-/* file is seekable */
-#define FMODE_LSEEK		((__force fmode_t)0x4)
-/* file can be accessed using pread */
-#define FMODE_PREAD		((__force fmode_t)0x8)
-/* file can be accessed using pwrite */
-#define FMODE_PWRITE		((__force fmode_t)0x10)
-/* File is opened for execution with sys_execve / sys_uselib */
-#define FMODE_EXEC		((__force fmode_t)0x20)
-/* File is opened with O_NDELAY (only set for block devices) */
-#define FMODE_NDELAY		((__force fmode_t)0x40)
-/* File is opened with O_EXCL (only set for block devices) */
-#define FMODE_EXCL		((__force fmode_t)0x80)
-/* File is opened using open(.., 3, ..) and is writeable only for ioctls
-   (specialy hack for floppy.c) */
-#define FMODE_WRITE_IOCTL	((__force fmode_t)0x100)
-/* 32bit hashes as llseek() offset (for directories) */
-#define FMODE_32BITHASH         ((__force fmode_t)0x200)
-/* 64bit hashes as llseek() offset (for directories) */
-#define FMODE_64BITHASH         ((__force fmode_t)0x400)
-
-/*
- * Don't update ctime and mtime.
- *
- * Currently a special hack for the XFS open_by_handle ioctl, but we'll
- * hopefully graduate it to a proper O_CMTIME flag supported by open(2) soon.
- */
-#define FMODE_NOCMTIME		((__force fmode_t)0x800)
-
-/* Expect random access pattern */
-#define FMODE_RANDOM		((__force fmode_t)0x1000)
-
-/* File is huge (eg. /dev/mem): treat loff_t as unsigned */
-#define FMODE_UNSIGNED_OFFSET	((__force fmode_t)0x2000)
-
-/* File is opened with O_PATH; almost nothing can be done with it */
-#define FMODE_PATH		((__force fmode_t)0x4000)
-
-/* File needs atomic accesses to f_pos */
-#define FMODE_ATOMIC_POS	((__force fmode_t)0x8000)
-/* Write access to underlying fs */
-#define FMODE_WRITER		((__force fmode_t)0x10000)
-/* Has read method(s) */
-#define FMODE_CAN_READ          ((__force fmode_t)0x20000)
-/* Has write method(s) */
-#define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
-
-#define FMODE_OPENED		((__force fmode_t)0x80000)
-#define FMODE_CREATED		((__force fmode_t)0x100000)
-
-/* File is stream-like */
-#define FMODE_STREAM		((__force fmode_t)0x200000)
-
-/* File was opened by fanotify and shouldn't generate fanotify events */
-#define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
-
-/* File is capable of returning -EAGAIN if I/O will block */
-#define FMODE_NOWAIT		((__force fmode_t)0x8000000)
-
-/* File represents mount that needs unmounting */
-#define FMODE_NEED_UNMOUNT	((__force fmode_t)0x10000000)
-
-/* File does not contribute to nr_files count */
-#define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
-
-/* File supports async buffered reads */
-#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
-
-/*
- * Attribute flags.  These should be or-ed together to figure out what
- * has been changed!
- */
-#define ATTR_MODE	(1 << 0)
-#define ATTR_UID	(1 << 1)
-#define ATTR_GID	(1 << 2)
-#define ATTR_SIZE	(1 << 3)
-#define ATTR_ATIME	(1 << 4)
-#define ATTR_MTIME	(1 << 5)
-#define ATTR_CTIME	(1 << 6)
-#define ATTR_ATIME_SET	(1 << 7)
-#define ATTR_MTIME_SET	(1 << 8)
-#define ATTR_FORCE	(1 << 9) /* Not a change, but a change it */
-#define ATTR_KILL_SUID	(1 << 11)
-#define ATTR_KILL_SGID	(1 << 12)
-#define ATTR_FILE	(1 << 13)
-#define ATTR_KILL_PRIV	(1 << 14)
-#define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
-#define ATTR_TIMES_SET	(1 << 16)
-#define ATTR_TOUCH	(1 << 17)
-
-/*
- * Whiteout is represented by a char device.  The following constants define the
- * mode and device number to use.
- */
-#define WHITEOUT_MODE 0
-#define WHITEOUT_DEV 0
-
-/*
- * This is the Inode Attributes structure, used for notify_change().  It
- * uses the above definitions as flags, to know which values have changed.
- * Also, in this manner, a Filesystem can look at only the values it cares
- * about.  Basically, these are the attributes that the VFS layer can
- * request to change from the FS layer.
- *
- * Derek Atkins <warlord@MIT.EDU> 94-10-20
- */
-struct iattr {
-	unsigned int	ia_valid;
-	umode_t		ia_mode;
-	kuid_t		ia_uid;
-	kgid_t		ia_gid;
-	loff_t		ia_size;
-	struct timespec64 ia_atime;
-	struct timespec64 ia_mtime;
-	struct timespec64 ia_ctime;
-
-	/*
-	 * Not an attribute, but an auxiliary info for filesystems wanting to
-	 * implement an ftruncate() like method.  NOTE: filesystem should
-	 * check for (ia_valid & ATTR_FILE), and not for (ia_file != NULL).
-	 */
-	struct file	*ia_file;
-};
-
 /*
  * Includes for diskquotas.
  */
 #include <linux/quota.h>
 
-/*
- * Maximum number of layers of fs stack.  Needs to be limited to
- * prevent kernel stack overflow
- */
-#define FILESYSTEM_MAX_STACK_DEPTH 2
-
-/** 
- * enum positive_aop_returns - aop return codes with specific semantics
- *
- * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
- * 			    completed, that the page is still locked, and
- * 			    should be considered active.  The VM uses this hint
- * 			    to return the page to the active list -- it won't
- * 			    be a candidate for writeback again in the near
- * 			    future.  Other callers must be careful to unlock
- * 			    the page if they get this return.  Returned by
- * 			    writepage(); 
- *
- * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
- *  			unlocked it and the page might have been truncated.
- *  			The caller should back up to acquiring a new page and
- *  			trying again.  The aop will be taking reasonable
- *  			precautions not to livelock.  If the caller held a page
- *  			reference, it should drop it before retrying.  Returned
- *  			by readpage().
- *
- * address_space_operation functions return these large constants to indicate
- * special semantics to the caller.  These are much larger than the bytes in a
- * page to allow for functions that return the number of bytes operated on in a
- * given page.
- */
-
-enum positive_aop_returns {
-	AOP_WRITEPAGE_ACTIVATE	= 0x80000,
-	AOP_TRUNCATED_PAGE	= 0x80001,
-};
-
-#define AOP_FLAG_CONT_EXPAND		0x0001 /* called from cont_expand */
-#define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
-						* helper code (eg buffer layer)
-						* to clear GFP_FS from alloc */
-
 /*
  * oh the beauties of C type declarations.
  */
@@ -287,130 +95,11 @@ struct address_space;
 struct writeback_control;
 struct readahead_control;
 
-/*
- * Write life time hint values.
- * Stored in struct inode as u8.
- */
-enum rw_hint {
-	WRITE_LIFE_NOT_SET	= 0,
-	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
-	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
-	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
-	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
-	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
-};
-
-/* Match RWF_* bits to IOCB bits */
-#define IOCB_HIPRI		(__force int) RWF_HIPRI
-#define IOCB_DSYNC		(__force int) RWF_DSYNC
-#define IOCB_SYNC		(__force int) RWF_SYNC
-#define IOCB_NOWAIT		(__force int) RWF_NOWAIT
-#define IOCB_APPEND		(__force int) RWF_APPEND
-
-/* non-RWF related bits - start at 16 */
-#define IOCB_EVENTFD		(1 << 16)
-#define IOCB_DIRECT		(1 << 17)
-#define IOCB_WRITE		(1 << 18)
-/* iocb->ki_waitq is valid */
-#define IOCB_WAITQ		(1 << 19)
-#define IOCB_NOIO		(1 << 20)
-/* can use bio alloc cache */
-#define IOCB_ALLOC_CACHE	(1 << 21)
-
-struct kiocb {
-	struct file		*ki_filp;
-
-	/* The 'ki_filp' pointer is shared in a union for aio */
-	randomized_struct_fields_start
-
-	loff_t			ki_pos;
-	void (*ki_complete)(struct kiocb *iocb, long ret);
-	void			*private;
-	int			ki_flags;
-	u16			ki_hint;
-	u16			ki_ioprio; /* See linux/ioprio.h */
-	struct wait_page_queue	*ki_waitq; /* for async buffered IO */
-	randomized_struct_fields_end
-};
-
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
 {
 	return kiocb->ki_complete == NULL;
 }
 
-/*
- * "descriptor" for what we're up to with a read.
- * This allows us to use the same read code yet
- * have multiple different users of the data that
- * we read from a file.
- *
- * The simplest case just copies the data to user
- * mode.
- */
-typedef struct {
-	size_t written;
-	size_t count;
-	union {
-		char __user *buf;
-		void *data;
-	} arg;
-	int error;
-} read_descriptor_t;
-
-typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
-		unsigned long, unsigned long);
-
-struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
-
-	/* Write back some dirty pages from this mapping. */
-	int (*writepages)(struct address_space *, struct writeback_control *);
-
-	/* Set a page dirty.  Return true if this dirtied it */
-	int (*set_page_dirty)(struct page *page);
-
-	/*
-	 * Reads in the requested pages. Unlike ->readpage(), this is
-	 * PURELY used for read-ahead!.
-	 */
-	int (*readpages)(struct file *filp, struct address_space *mapping,
-			struct list_head *pages, unsigned nr_pages);
-	void (*readahead)(struct readahead_control *);
-
-	int (*write_begin)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata);
-	int (*write_end)(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
-
-	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
-	sector_t (*bmap)(struct address_space *, sector_t);
-	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
-	int (*releasepage) (struct page *, gfp_t);
-	void (*freepage)(struct page *);
-	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
-	/*
-	 * migrate the contents of a page to the specified target. If
-	 * migrate_mode is MIGRATE_ASYNC, it must not block.
-	 */
-	int (*migratepage) (struct address_space *,
-			struct page *, struct page *, enum migrate_mode);
-	bool (*isolate_page)(struct page *, isolate_mode_t);
-	void (*putback_page)(struct page *);
-	int (*launder_page) (struct page *);
-	int (*is_partially_uptodate) (struct page *, unsigned long,
-					unsigned long);
-	void (*is_dirty_writeback) (struct page *, bool *, bool *);
-	int (*error_remove_page)(struct address_space *, struct page *);
-
-	/* swapfile support */
-	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
-				sector_t *span);
-	void (*swap_deactivate)(struct file *file);
-};
-
 extern const struct address_space_operations empty_aops;
 
 /*
@@ -425,60 +114,6 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned copied,
 				struct page *page, void *fsdata);
 
-/**
- * struct address_space - Contents of a cacheable, mappable object.
- * @host: Owner, either the inode or the block_device.
- * @i_pages: Cached pages.
- * @invalidate_lock: Guards coherency between page cache contents and
- *   file offset->disk block mappings in the filesystem during invalidates.
- *   It is also used to block modification of page cache contents through
- *   memory mappings.
- * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
- * @nr_thps: Number of THPs in the pagecache (non-shmem only).
- * @i_mmap: Tree of private and shared mappings.
- * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
- * @nrpages: Number of page entries, protected by the i_pages lock.
- * @writeback_index: Writeback starts here.
- * @a_ops: Methods.
- * @flags: Error bits and flags (AS_*).
- * @wb_err: The most recent error which has occurred.
- * @private_lock: For use by the owner of the address_space.
- * @private_list: For use by the owner of the address_space.
- * @private_data: For use by the owner of the address_space.
- */
-struct address_space {
-	struct inode		*host;
-	struct xarray		i_pages;
-	struct rw_semaphore	invalidate_lock;
-	gfp_t			gfp_mask;
-	atomic_t		i_mmap_writable;
-#ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	/* number of thp, only for non-shmem files */
-	atomic_t		nr_thps;
-#endif
-	struct rb_root_cached	i_mmap;
-	struct rw_semaphore	i_mmap_rwsem;
-	unsigned long		nrpages;
-	pgoff_t			writeback_index;
-	const struct address_space_operations *a_ops;
-	unsigned long		flags;
-	errseq_t		wb_err;
-	spinlock_t		private_lock;
-	struct list_head	private_list;
-	void			*private_data;
-} __attribute__((aligned(sizeof(long)))) __randomize_layout;
-	/*
-	 * On most architectures that alignment is already the case; but
-	 * must be enforced here for CRIS, to let the least significant bit
-	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
-	 */
-
-/* XArray tags, for tagging dirty and writeback pages in the pagecache. */
-#define PAGECACHE_TAG_DIRTY	XA_MARK_0
-#define PAGECACHE_TAG_WRITEBACK	XA_MARK_1
-#define PAGECACHE_TAG_TOWRITE	XA_MARK_2
-
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
@@ -569,9 +204,8 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 /*
  * Use sequence counter to get consistent i_size on 32-bit processors.
  */
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#ifdef __NEED_I_SIZE_ORDERED
 #include <linux/seqlock.h>
-#define __NEED_I_SIZE_ORDERED
 #define i_size_ordered_init(inode) seqcount_init(&inode->i_size_seqcount)
 #else
 #define i_size_ordered_init(inode) do { } while (0)
@@ -606,123 +240,6 @@ is_uncached_acl(struct posix_acl *acl)
 
 struct fsnotify_mark_connector;
 
-/*
- * Keep mostly read-only and often accessed (especially for
- * the RCU path lookup and 'stat' data) fields at the beginning
- * of the 'struct inode'
- */
-struct inode {
-	umode_t			i_mode;
-	unsigned short		i_opflags;
-	kuid_t			i_uid;
-	kgid_t			i_gid;
-	unsigned int		i_flags;
-
-#ifdef CONFIG_FS_POSIX_ACL
-	struct posix_acl	*i_acl;
-	struct posix_acl	*i_default_acl;
-#endif
-
-	const struct inode_operations	*i_op;
-	struct super_block	*i_sb;
-	struct address_space	*i_mapping;
-
-#ifdef CONFIG_SECURITY
-	void			*i_security;
-#endif
-
-	/* Stat data, not accessed from path walking */
-	unsigned long		i_ino;
-	/*
-	 * Filesystems may only read i_nlink directly.  They shall use the
-	 * following functions for modification:
-	 *
-	 *    (set|clear|inc|drop)_nlink
-	 *    inode_(inc|dec)_link_count
-	 */
-	union {
-		const unsigned int i_nlink;
-		unsigned int __i_nlink;
-	};
-	dev_t			i_rdev;
-	loff_t			i_size;
-	struct timespec64	i_atime;
-	struct timespec64	i_mtime;
-	struct timespec64	i_ctime;
-	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
-	unsigned short          i_bytes;
-	u8			i_blkbits;
-	u8			i_write_hint;
-	blkcnt_t		i_blocks;
-
-#ifdef __NEED_I_SIZE_ORDERED
-	seqcount_t		i_size_seqcount;
-#endif
-
-	/* Misc */
-	unsigned long		i_state;
-	struct rw_semaphore	i_rwsem;
-
-	unsigned long		dirtied_when;	/* jiffies of first dirtying */
-	unsigned long		dirtied_time_when;
-
-	struct hlist_node	i_hash;
-	struct list_head	i_io_list;	/* backing dev IO list */
-#ifdef CONFIG_CGROUP_WRITEBACK
-	struct bdi_writeback	*i_wb;		/* the associated cgroup wb */
-
-	/* foreign inode detection, see wbc_detach_inode() */
-	int			i_wb_frn_winner;
-	u16			i_wb_frn_avg_time;
-	u16			i_wb_frn_history;
-#endif
-	struct list_head	i_lru;		/* inode LRU list */
-	struct list_head	i_sb_list;
-	struct list_head	i_wb_list;	/* backing dev writeback list */
-	union {
-		struct hlist_head	i_dentry;
-		struct rcu_head		i_rcu;
-	};
-	atomic64_t		i_version;
-	atomic64_t		i_sequence; /* see futex */
-	atomic_t		i_count;
-	atomic_t		i_dio_count;
-	atomic_t		i_writecount;
-#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
-	atomic_t		i_readcount; /* struct files open RO */
-#endif
-	union {
-		const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
-		void (*free_inode)(struct inode *);
-	};
-	struct file_lock_context	*i_flctx;
-	struct address_space	i_data;
-	struct list_head	i_devices;
-	union {
-		struct pipe_inode_info	*i_pipe;
-		struct cdev		*i_cdev;
-		char			*i_link;
-		unsigned		i_dir_seq;
-	};
-
-	__u32			i_generation;
-
-#ifdef CONFIG_FSNOTIFY
-	__u32			i_fsnotify_mask; /* all events this inode cares about */
-	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
-#endif
-
-#ifdef CONFIG_FS_ENCRYPTION
-	struct fscrypt_info	*i_crypt_info;
-#endif
-
-#ifdef CONFIG_FS_VERITY
-	struct fsverity_info	*i_verity_info;
-#endif
-
-	void			*i_private; /* fs or device private pointer */
-} __randomize_layout;
-
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
 
 static inline unsigned int i_blocksize(const struct inode *node)
@@ -918,32 +435,6 @@ static inline unsigned imajor(const struct inode *inode)
 	return MAJOR(inode->i_rdev);
 }
 
-struct fown_struct {
-	rwlock_t lock;          /* protects pid, uid, euid fields */
-	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
-	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent to */
-	kuid_t uid, euid;	/* uid/euid of process setting the owner */
-	int signum;		/* posix.1b rt signal to be delivered on IO */
-};
-
-/**
- * struct file_ra_state - Track a file's readahead state.
- * @start: Where the most recent readahead started.
- * @size: Number of pages read in the most recent readahead.
- * @async_size: Start next readahead when this many pages are left.
- * @ra_pages: Maximum size of a readahead request.
- * @mmap_miss: How many mmap accesses missed in the page cache.
- * @prev_pos: The last byte in the most recent read request.
- */
-struct file_ra_state {
-	pgoff_t start;
-	unsigned int size;
-	unsigned int async_size;
-	unsigned int ra_pages;
-	unsigned int mmap_miss;
-	loff_t prev_pos;
-};
-
 /*
  * Check if @index falls in the readahead windows.
  */
@@ -953,54 +444,6 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
 		index <  ra->start + ra->size);
 }
 
-struct file {
-	union {
-		struct llist_node	fu_llist;
-		struct rcu_head 	fu_rcuhead;
-	} f_u;
-	struct path		f_path;
-	struct inode		*f_inode;	/* cached value */
-	const struct file_operations	*f_op;
-
-	/*
-	 * Protects f_ep, f_flags.
-	 * Must not be taken from IRQ context.
-	 */
-	spinlock_t		f_lock;
-	enum rw_hint		f_write_hint;
-	atomic_long_t		f_count;
-	unsigned int 		f_flags;
-	fmode_t			f_mode;
-	struct mutex		f_pos_lock;
-	loff_t			f_pos;
-	struct fown_struct	f_owner;
-	const struct cred	*f_cred;
-	struct file_ra_state	f_ra;
-
-	u64			f_version;
-#ifdef CONFIG_SECURITY
-	void			*f_security;
-#endif
-	/* needed for tty driver, and maybe others */
-	void			*private_data;
-
-#ifdef CONFIG_EPOLL
-	/* Used by fs/eventpoll.c to link all the hooks to this file */
-	struct hlist_head	*f_ep;
-#endif /* #ifdef CONFIG_EPOLL */
-	struct address_space	*f_mapping;
-	errseq_t		f_wb_err;
-	errseq_t		f_sb_err; /* for syncfs */
-} __randomize_layout
-  __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
-
-struct file_handle {
-	__u32 handle_bytes;
-	int handle_type;
-	/* file identifier */
-	unsigned char f_handle[];
-};
-
 static inline struct file *get_file(struct file *f)
 {
 	atomic_long_inc(&f->f_count);
@@ -1011,68 +454,6 @@ static inline struct file *get_file(struct file *f)
 #define get_file_rcu(x) get_file_rcu_many((x), 1)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
-#define	MAX_NON_LFS	((1UL<<31) - 1)
-
-/* Page cache limit. The filesystems should put that into their s_maxbytes 
-   limits, otherwise bad things can happen in VM. */ 
-#if BITS_PER_LONG==32
-#define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
-#elif BITS_PER_LONG==64
-#define MAX_LFS_FILESIZE 	((loff_t)LLONG_MAX)
-#endif
-
-#define FL_POSIX	1
-#define FL_FLOCK	2
-#define FL_DELEG	4	/* NFSv4 delegation */
-#define FL_ACCESS	8	/* not trying to lock, just looking */
-#define FL_EXISTS	16	/* when unlocking, test for existence */
-#define FL_LEASE	32	/* lease held on this file */
-#define FL_CLOSE	64	/* unlock on close */
-#define FL_SLEEP	128	/* A blocking lock */
-#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
-#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
-#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
-#define FL_LAYOUT	2048	/* outstanding pNFS layout */
-#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
-
-#define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
-
-/*
- * Special return value from posix_lock_file() and vfs_lock_file() for
- * asynchronous locking.
- */
-#define FILE_LOCK_DEFERRED 1
-
-/* legacy typedef, should eventually be removed */
-typedef void *fl_owner_t;
-
-struct file_lock;
-
-struct file_lock_operations {
-	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
-	void (*fl_release_private)(struct file_lock *);
-};
-
-struct lock_manager_operations {
-	fl_owner_t (*lm_get_owner)(fl_owner_t);
-	void (*lm_put_owner)(fl_owner_t);
-	void (*lm_notify)(struct file_lock *);	/* unblock callback */
-	int (*lm_grant)(struct file_lock *, int);
-	bool (*lm_break)(struct file_lock *);
-	int (*lm_change)(struct file_lock *, int, struct list_head *);
-	void (*lm_setup)(struct file_lock *, void **);
-	bool (*lm_breaker_owns_lease)(struct file_lock *);
-};
-
-struct lock_manager {
-	struct list_head list;
-	/*
-	 * NFSv4 and up also want opens blocked during the grace period;
-	 * NLM doesn't care:
-	 */
-	bool block_opens;
-};
-
 struct net;
 void locks_start_grace(struct net *, struct lock_manager *);
 void locks_end_grace(struct lock_manager *);
@@ -1082,68 +463,6 @@ bool opens_in_grace(struct net *);
 /* that will die - we need it for nfs_lock_info */
 #include <linux/nfs_fs_i.h>
 
-/*
- * struct file_lock represents a generic "file lock". It's used to represent
- * POSIX byte range locks, BSD (flock) locks, and leases. It's important to
- * note that the same struct is used to represent both a request for a lock and
- * the lock itself, but the same object is never used for both.
- *
- * FIXME: should we create a separate "struct lock_request" to help distinguish
- * these two uses?
- *
- * The varous i_flctx lists are ordered by:
- *
- * 1) lock owner
- * 2) lock range start
- * 3) lock range end
- *
- * Obviously, the last two criteria only matter for POSIX locks.
- */
-struct file_lock {
-	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
-	struct list_head fl_list;	/* link into file_lock_context */
-	struct hlist_node fl_link;	/* node in global lists */
-	struct list_head fl_blocked_requests;	/* list of requests with
-						 * ->fl_blocker pointing here
-						 */
-	struct list_head fl_blocked_member;	/* node in
-						 * ->fl_blocker->fl_blocked_requests
-						 */
-	fl_owner_t fl_owner;
-	unsigned int fl_flags;
-	unsigned char fl_type;
-	unsigned int fl_pid;
-	int fl_link_cpu;		/* what cpu's list is this on? */
-	wait_queue_head_t fl_wait;
-	struct file *fl_file;
-	loff_t fl_start;
-	loff_t fl_end;
-
-	struct fasync_struct *	fl_fasync; /* for lease break notifications */
-	/* for lease breaks: */
-	unsigned long fl_break_time;
-	unsigned long fl_downgrade_time;
-
-	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
-	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
-	union {
-		struct nfs_lock_info	nfs_fl;
-		struct nfs4_lock_info	nfs4_fl;
-		struct {
-			struct list_head link;	/* link in AFS vnode's pending_locks list */
-			int state;		/* state of grant or error if -ve */
-			unsigned int	debug_id;
-		} afs;
-	} fl_u;
-} __randomize_layout;
-
-struct file_lock_context {
-	spinlock_t		flc_lock;
-	struct list_head	flc_flock;
-	struct list_head	flc_posix;
-	struct list_head	flc_lease;
-};
-
 /* The following constant reflects the upper bound of the file/locking space */
 #ifndef OFFSET_MAX
 #define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
@@ -1351,17 +670,6 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
 	return locks_lock_inode_wait(locks_inode(filp), fl);
 }
 
-struct fasync_struct {
-	rwlock_t		fa_lock;
-	int			magic;
-	int			fa_fd;
-	struct fasync_struct	*fa_next; /* singly linked list */
-	struct file		*fa_file;
-	struct rcu_head		fa_rcu;
-};
-
-#define FASYNC_MAGIC 0x4601
-
 /* SMP safe fasync helpers: */
 extern int fasync_helper(int, struct file *, int, struct fasync_struct **);
 extern struct fasync_struct *fasync_insert_entry(int, struct file *, struct fasync_struct **, struct fasync_struct *);
@@ -1378,221 +686,6 @@ extern void f_delown(struct file *filp);
 extern pid_t f_getown(struct file *filp);
 extern int send_sigurg(struct fown_struct *fown);
 
-/*
- * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
- * represented in both.
- */
-#define SB_RDONLY	 1	/* Mount read-only */
-#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
-#define SB_NODEV	 4	/* Disallow access to device special files */
-#define SB_NOEXEC	 8	/* Disallow program execution */
-#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
-#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
-#define SB_NOATIME	1024	/* Do not update access times. */
-#define SB_NODIRATIME	2048	/* Do not update directory access times */
-#define SB_SILENT	32768
-#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
-#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
-#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-
-/* These sb flags are internal to the kernel */
-#define SB_SUBMOUNT     (1<<26)
-#define SB_FORCE    	(1<<27)
-#define SB_NOSEC	(1<<28)
-#define SB_BORN		(1<<29)
-#define SB_ACTIVE	(1<<30)
-#define SB_NOUSER	(1<<31)
-
-/* These flags relate to encoding and casefolding */
-#define SB_ENC_STRICT_MODE_FL	(1 << 0)
-
-#define sb_has_strict_encoding(sb) \
-	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
-
-/*
- *	Umount options
- */
-
-#define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
-#define MNT_DETACH	0x00000002	/* Just detach from the tree */
-#define MNT_EXPIRE	0x00000004	/* Mark for expiry */
-#define UMOUNT_NOFOLLOW	0x00000008	/* Don't follow symlink on umount */
-#define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
-
-/* sb->s_iflags */
-#define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
-#define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
-#define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
-#define SB_I_STABLE_WRITES 0x00000008	/* don't modify blks until WB is done */
-
-/* sb->s_iflags to limit user namespace mounts */
-#define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
-#define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
-#define SB_I_UNTRUSTED_MOUNTER		0x00000040
-
-#define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
-#define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
-
-/* Possible states of 'frozen' field */
-enum {
-	SB_UNFROZEN = 0,		/* FS is unfrozen */
-	SB_FREEZE_WRITE	= 1,		/* Writes, dir ops, ioctls frozen */
-	SB_FREEZE_PAGEFAULT = 2,	/* Page faults stopped as well */
-	SB_FREEZE_FS = 3,		/* For internal FS use (e.g. to stop
-					 * internal threads if needed) */
-	SB_FREEZE_COMPLETE = 4,		/* ->freeze_fs finished successfully */
-};
-
-#define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
-
-struct sb_writers {
-	int				frozen;		/* Is sb frozen? */
-	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
-	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
-};
-
-struct super_block {
-	struct list_head	s_list;		/* Keep this first */
-	dev_t			s_dev;		/* search index; _not_ kdev_t */
-	unsigned char		s_blocksize_bits;
-	unsigned long		s_blocksize;
-	loff_t			s_maxbytes;	/* Max file size */
-	struct file_system_type	*s_type;
-	const struct super_operations	*s_op;
-	const struct dquot_operations	*dq_op;
-	const struct quotactl_ops	*s_qcop;
-	const struct export_operations *s_export_op;
-	unsigned long		s_flags;
-	unsigned long		s_iflags;	/* internal SB_I_* flags */
-	unsigned long		s_magic;
-	struct dentry		*s_root;
-	struct rw_semaphore	s_umount;
-	int			s_count;
-	atomic_t		s_active;
-#ifdef CONFIG_SECURITY
-	void                    *s_security;
-#endif
-	const struct xattr_handler **s_xattr;
-#ifdef CONFIG_FS_ENCRYPTION
-	const struct fscrypt_operations	*s_cop;
-	struct key		*s_master_keys; /* master crypto keys in use */
-#endif
-#ifdef CONFIG_FS_VERITY
-	const struct fsverity_operations *s_vop;
-#endif
-#ifdef CONFIG_UNICODE
-	struct unicode_map *s_encoding;
-	__u16 s_encoding_flags;
-#endif
-	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
-	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
-	struct block_device	*s_bdev;
-	struct backing_dev_info *s_bdi;
-	struct mtd_info		*s_mtd;
-	struct hlist_node	s_instances;
-	unsigned int		s_quota_types;	/* Bitmask of supported quota types */
-	struct quota_info	s_dquot;	/* Diskquota specific options */
-
-	struct sb_writers	s_writers;
-
-	/*
-	 * Keep s_fs_info, s_time_gran, s_fsnotify_mask, and
-	 * s_fsnotify_marks together for cache efficiency. They are frequently
-	 * accessed and rarely modified.
-	 */
-	void			*s_fs_info;	/* Filesystem private info */
-
-	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
-	u32			s_time_gran;
-	/* Time limits for c/m/atime in seconds */
-	time64_t		   s_time_min;
-	time64_t		   s_time_max;
-#ifdef CONFIG_FSNOTIFY
-	__u32			s_fsnotify_mask;
-	struct fsnotify_mark_connector __rcu	*s_fsnotify_marks;
-#endif
-
-	char			s_id[32];	/* Informational name */
-	uuid_t			s_uuid;		/* UUID */
-
-	unsigned int		s_max_links;
-	fmode_t			s_mode;
-
-	/*
-	 * The next field is for VFS *only*. No filesystems have any business
-	 * even looking at it. You had been warned.
-	 */
-	struct mutex s_vfs_rename_mutex;	/* Kludge */
-
-	/*
-	 * Filesystem subtype.  If non-empty the filesystem type field
-	 * in /proc/mounts will be "type.subtype"
-	 */
-	const char *s_subtype;
-
-	const struct dentry_operations *s_d_op; /* default d_op for dentries */
-
-	/*
-	 * Saved pool identifier for cleancache (-1 means none)
-	 */
-	int cleancache_poolid;
-
-	struct shrinker s_shrink;	/* per-sb shrinker handle */
-
-	/* Number of inodes with nlink == 0 but still referenced */
-	atomic_long_t s_remove_count;
-
-	/*
-	 * Number of inode/mount/sb objects that are being watched, note that
-	 * inodes objects are currently double-accounted.
-	 */
-	atomic_long_t s_fsnotify_connectors;
-
-	/* Being remounted read-only */
-	int s_readonly_remount;
-
-	/* per-sb errseq_t for reporting writeback errors via syncfs */
-	errseq_t s_wb_err;
-
-	/* AIO completions deferred from interrupt context */
-	struct workqueue_struct *s_dio_done_wq;
-	struct hlist_head s_pins;
-
-	/*
-	 * Owning user namespace and default context in which to
-	 * interpret filesystem uids, gids, quotas, device nodes,
-	 * xattrs and security labels.
-	 */
-	struct user_namespace *s_user_ns;
-
-	/*
-	 * The list_lru structure is essentially just a pointer to a table
-	 * of per-node lru lists, each of which has its own spinlock.
-	 * There is no need to put them into separate cachelines.
-	 */
-	struct list_lru		s_dentry_lru;
-	struct list_lru		s_inode_lru;
-	struct rcu_head		rcu;
-	struct work_struct	destroy_work;
-
-	struct mutex		s_sync_lock;	/* sync serialisation lock */
-
-	/*
-	 * Indicates how deep in a filesystem stack this SB is
-	 */
-	int s_stack_depth;
-
-	/* s_inode_list_lock protects s_inodes */
-	spinlock_t		s_inode_list_lock ____cacheline_aligned_in_smp;
-	struct list_head	s_inodes;	/* all inodes */
-
-	spinlock_t		s_inode_wblist_lock;
-	struct list_head	s_inodes_wb;	/* writeback inodes */
-} __randomize_layout;
-
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
 {
 	return inode->i_sb->s_user_ns;
@@ -1869,28 +962,6 @@ int vfs_rmdir(struct user_namespace *, struct inode *, struct dentry *);
 int vfs_unlink(struct user_namespace *, struct inode *, struct dentry *,
 	       struct inode **);
 
-/**
- * struct renamedata - contains all information required for renaming
- * @old_mnt_userns:    old user namespace of the mount the inode was found from
- * @old_dir:           parent of source
- * @old_dentry:                source
- * @new_mnt_userns:    new user namespace of the mount the inode was found from
- * @new_dir:           parent of destination
- * @new_dentry:                destination
- * @delegated_inode:   returns an inode needing a delegation break
- * @flags:             rename flags
- */
-struct renamedata {
-	struct user_namespace *old_mnt_userns;
-	struct inode *old_dir;
-	struct dentry *old_dentry;
-	struct user_namespace *new_mnt_userns;
-	struct inode *new_dir;
-	struct dentry *new_dentry;
-	struct inode **delegated_inode;
-	unsigned int flags;
-} __randomize_layout;
-
 int vfs_rename(struct renamedata *);
 
 static inline int vfs_whiteout(struct user_namespace *mnt_userns,
@@ -1927,146 +998,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
 
-/*
- * This is the "filldir" function type, used by readdir() to let
- * the kernel specify what kind of dirent layout it wants to have.
- * This allows the kernel to read directories into kernel space or
- * to have different dirent layouts depending on the binary type.
- */
-struct dir_context;
-typedef int (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
-			 unsigned);
-
-struct dir_context {
-	filldir_t actor;
-	loff_t pos;
-};
-
-/*
- * These flags let !MMU mmap() govern direct device mapping vs immediate
- * copying more easily for MAP_PRIVATE, especially for ROM filesystems.
- *
- * NOMMU_MAP_COPY:	Copy can be mapped (MAP_PRIVATE)
- * NOMMU_MAP_DIRECT:	Can be mapped directly (MAP_SHARED)
- * NOMMU_MAP_READ:	Can be mapped for reading
- * NOMMU_MAP_WRITE:	Can be mapped for writing
- * NOMMU_MAP_EXEC:	Can be mapped for execution
- */
-#define NOMMU_MAP_COPY		0x00000001
-#define NOMMU_MAP_DIRECT	0x00000008
-#define NOMMU_MAP_READ		VM_MAYREAD
-#define NOMMU_MAP_WRITE		VM_MAYWRITE
-#define NOMMU_MAP_EXEC		VM_MAYEXEC
-
-#define NOMMU_VMFLAGS \
-	(NOMMU_MAP_READ | NOMMU_MAP_WRITE | NOMMU_MAP_EXEC)
-
-/*
- * These flags control the behavior of the remap_file_range function pointer.
- * If it is called with len == 0 that means "remap to end of source file".
- * See Documentation/filesystems/vfs.rst for more details about this call.
- *
- * REMAP_FILE_DEDUP: only remap if contents identical (i.e. deduplicate)
- * REMAP_FILE_CAN_SHORTEN: caller can handle a shortened request
- */
-#define REMAP_FILE_DEDUP		(1 << 0)
-#define REMAP_FILE_CAN_SHORTEN		(1 << 1)
-
-/*
- * These flags signal that the caller is ok with altering various aspects of
- * the behavior of the remap operation.  The changes must be made by the
- * implementation; the vfs remap helper functions can take advantage of them.
- * Flags in this category exist to preserve the quirky behavior of the hoisted
- * btrfs clone/dedupe ioctls.
- */
-#define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
-
-struct iov_iter;
-
-struct file_operations {
-	struct module *owner;
-	loff_t (*llseek) (struct file *, loff_t, int);
-	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
-	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
-	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
-	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
-			unsigned int flags);
-	int (*iterate) (struct file *, struct dir_context *);
-	int (*iterate_shared) (struct file *, struct dir_context *);
-	__poll_t (*poll) (struct file *, struct poll_table_struct *);
-	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
-	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
-	int (*mmap) (struct file *, struct vm_area_struct *);
-	unsigned long mmap_supported_flags;
-	int (*open) (struct inode *, struct file *);
-	int (*flush) (struct file *, fl_owner_t id);
-	int (*release) (struct inode *, struct file *);
-	int (*fsync) (struct file *, loff_t, loff_t, int datasync);
-	int (*fasync) (int, struct file *, int);
-	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
-	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
-	int (*check_flags)(int);
-	int (*flock) (struct file *, int, struct file_lock *);
-	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
-	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
-	int (*setlease)(struct file *, long, struct file_lock **, void **);
-	long (*fallocate)(struct file *file, int mode, loff_t offset,
-			  loff_t len);
-	void (*show_fdinfo)(struct seq_file *m, struct file *f);
-#ifndef CONFIG_MMU
-	unsigned (*mmap_capabilities)(struct file *);
-#endif
-	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
-			loff_t, size_t, unsigned int);
-	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
-				   struct file *file_out, loff_t pos_out,
-				   loff_t len, unsigned int remap_flags);
-	int (*fadvise)(struct file *, loff_t, loff_t, int);
-} __randomize_layout;
-
-struct inode_operations {
-	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
-	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
-	int (*permission) (struct user_namespace *, struct inode *, int);
-	struct posix_acl * (*get_acl)(struct inode *, int, bool);
-
-	int (*readlink) (struct dentry *, char __user *,int);
-
-	int (*create) (struct user_namespace *, struct inode *,struct dentry *,
-		       umode_t, bool);
-	int (*link) (struct dentry *,struct inode *,struct dentry *);
-	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct user_namespace *, struct inode *,struct dentry *,
-			const char *);
-	int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,
-		      umode_t);
-	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,
-		      umode_t,dev_t);
-	int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
-			struct inode *, struct dentry *, unsigned int);
-	int (*setattr) (struct user_namespace *, struct dentry *,
-			struct iattr *);
-	int (*getattr) (struct user_namespace *, const struct path *,
-			struct kstat *, u32, unsigned int);
-	ssize_t (*listxattr) (struct dentry *, char *, size_t);
-	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
-		      u64 len);
-	int (*update_time)(struct inode *, struct timespec64 *, int);
-	int (*atomic_open)(struct inode *, struct dentry *,
-			   struct file *, unsigned open_flag,
-			   umode_t create_mode);
-	int (*tmpfile) (struct user_namespace *, struct inode *,
-			struct dentry *, umode_t);
-	int (*set_acl)(struct user_namespace *, struct inode *,
-		       struct posix_acl *, int);
-	int (*fileattr_set)(struct user_namespace *mnt_userns,
-			    struct dentry *dentry, struct fileattr *fa);
-	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
-} ____cacheline_aligned;
-
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
 				     struct iov_iter *iter)
 {
@@ -2107,41 +1038,6 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
 
-
-struct super_operations {
-   	struct inode *(*alloc_inode)(struct super_block *sb);
-	void (*destroy_inode)(struct inode *);
-	void (*free_inode)(struct inode *);
-
-   	void (*dirty_inode) (struct inode *, int flags);
-	int (*write_inode) (struct inode *, struct writeback_control *wbc);
-	int (*drop_inode) (struct inode *);
-	void (*evict_inode) (struct inode *);
-	void (*put_super) (struct super_block *);
-	int (*sync_fs)(struct super_block *sb, int wait);
-	int (*freeze_super) (struct super_block *);
-	int (*freeze_fs) (struct super_block *);
-	int (*thaw_super) (struct super_block *);
-	int (*unfreeze_fs) (struct super_block *);
-	int (*statfs) (struct dentry *, struct kstatfs *);
-	int (*remount_fs) (struct super_block *, int *, char *);
-	void (*umount_begin) (struct super_block *);
-
-	int (*show_options)(struct seq_file *, struct dentry *);
-	int (*show_devname)(struct seq_file *, struct dentry *);
-	int (*show_path)(struct seq_file *, struct dentry *);
-	int (*show_stats)(struct seq_file *, struct dentry *);
-#ifdef CONFIG_QUOTA
-	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
-	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	struct dquot **(*get_dquots)(struct inode *);
-#endif
-	long (*nr_cached_objects)(struct super_block *,
-				  struct shrink_control *);
-	long (*free_cached_objects)(struct super_block *,
-				    struct shrink_control *);
-};
-
 /*
  * Inode flags - they have no relation to superblock flags now
  */
@@ -2430,36 +1326,6 @@ extern int file_modified(struct file *file);
 
 int sync_inode_metadata(struct inode *inode, int wait);
 
-struct file_system_type {
-	const char *name;
-	int fs_flags;
-#define FS_REQUIRES_DEV		1 
-#define FS_BINARY_MOUNTDATA	2
-#define FS_HAS_SUBTYPE		4
-#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
-#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
-#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
-#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
-	int (*init_fs_context)(struct fs_context *);
-	const struct fs_parameter_spec *parameters;
-	struct dentry *(*mount) (struct file_system_type *, int,
-		       const char *, void *);
-	void (*kill_sb) (struct super_block *);
-	struct module *owner;
-	struct file_system_type * next;
-	struct hlist_head fs_supers;
-
-	struct lock_class_key s_lock_key;
-	struct lock_class_key s_umount_key;
-	struct lock_class_key s_vfs_rename_key;
-	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
-
-	struct lock_class_key i_lock_key;
-	struct lock_class_key i_mutex_key;
-	struct lock_class_key invalidate_lock_key;
-	struct lock_class_key i_mutex_dir_key;
-};
-
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
 
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
@@ -2631,16 +1497,6 @@ static inline int break_layout(struct inode *inode, bool wait)
 #endif /* CONFIG_FILE_LOCKING */
 
 /* fs/open.c */
-struct audit_names;
-struct filename {
-	const char		*name;	/* pointer to actual string */
-	const __user char	*uptr;	/* original userland pointer */
-	int			refcnt;
-	struct audit_names	*aname;
-	const char		iname[];
-};
-static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
-
 static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 {
 	return mnt_user_ns(file->f_path.mnt);
@@ -2686,6 +1542,7 @@ static inline struct file *file_clone_open(struct file *file)
 }
 extern int filp_close(struct file *, fl_owner_t id);
 
+static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
 extern struct filename *getname_flags(const char __user *, int, int *);
 extern struct filename *getname_uflags(const char __user *, int);
 extern struct filename *getname(const char __user *);
@@ -3027,7 +1884,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
- 
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
diff --git a/include/linux/fs_types.h b/include/linux/fs_types.h
index 54816791196f..3e6e21265eaf 100644
--- a/include/linux/fs_types.h
+++ b/include/linux/fs_types.h
@@ -3,8 +3,1229 @@
 #define _LINUX_FS_TYPES_H
 
 /*
- * This is a header for the common implementation of dirent
- * to fs on-disk file type conversion.  Although the fs on-disk
+ * Common data structures and type definitions for file systems
+ * and related objects.
+ *
+ * Only add headers for other data structures in here when
+ * absolutely required, and include this file instead of
+ * linux/fs.h from other headers, to keep the include hierarchy
+ * flat.
+ */
+#include <linux/types.h>
+#include <linux/cache.h>
+#include <linux/errseq.h>
+#include <linux/migrate_mode.h>
+#include <linux/nfs_fs_i.h>
+#include <linux/path.h>
+#include <linux/shrinker.h>
+#include <linux/struct_types.h>
+
+#include <uapi/linux/fs.h>
+#include <uapi/linux/fcntl.h>
+
+struct address_space;
+struct buffer_head;
+struct delayed_call;
+struct fiemap_extent_info;
+struct fileattr;
+struct fs_context;
+struct inode;
+struct io_comp_batch;
+struct iov_iter;
+struct kiocb;
+struct kstat;
+struct kstatfs;
+struct page;
+struct poll_table_struct;
+struct readahead_control;
+struct seq_file;
+struct swap_info_struct;
+struct vm_area_struct;
+struct writeback_control;
+
+typedef __kernel_rwf_t rwf_t;
+
+typedef int (get_block_t)(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create);
+typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
+			ssize_t bytes, void *private);
+
+#define MAY_EXEC		0x00000001
+#define MAY_WRITE		0x00000002
+#define MAY_READ		0x00000004
+#define MAY_APPEND		0x00000008
+#define MAY_ACCESS		0x00000010
+#define MAY_OPEN		0x00000020
+#define MAY_CHDIR		0x00000040
+/* called from RCU mode, don't block */
+#define MAY_NOT_BLOCK		0x00000080
+
+/*
+ * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
+ * to O_WRONLY and O_RDWR via the strange trick in do_dentry_open()
+ */
+
+/* file is open for reading */
+#define FMODE_READ		((__force fmode_t)0x1)
+/* file is open for writing */
+#define FMODE_WRITE		((__force fmode_t)0x2)
+/* file is seekable */
+#define FMODE_LSEEK		((__force fmode_t)0x4)
+/* file can be accessed using pread */
+#define FMODE_PREAD		((__force fmode_t)0x8)
+/* file can be accessed using pwrite */
+#define FMODE_PWRITE		((__force fmode_t)0x10)
+/* File is opened for execution with sys_execve / sys_uselib */
+#define FMODE_EXEC		((__force fmode_t)0x20)
+/* File is opened with O_NDELAY (only set for block devices) */
+#define FMODE_NDELAY		((__force fmode_t)0x40)
+/* File is opened with O_EXCL (only set for block devices) */
+#define FMODE_EXCL		((__force fmode_t)0x80)
+/* File is opened using open(.., 3, ..) and is writeable only for ioctls
+   (specialy hack for floppy.c) */
+#define FMODE_WRITE_IOCTL	((__force fmode_t)0x100)
+/* 32bit hashes as llseek() offset (for directories) */
+#define FMODE_32BITHASH         ((__force fmode_t)0x200)
+/* 64bit hashes as llseek() offset (for directories) */
+#define FMODE_64BITHASH         ((__force fmode_t)0x400)
+
+/*
+ * Don't update ctime and mtime.
+ *
+ * Currently a special hack for the XFS open_by_handle ioctl, but we'll
+ * hopefully graduate it to a proper O_CMTIME flag supported by open(2) soon.
+ */
+#define FMODE_NOCMTIME		((__force fmode_t)0x800)
+
+/* Expect random access pattern */
+#define FMODE_RANDOM		((__force fmode_t)0x1000)
+
+/* File is huge (eg. /dev/mem): treat loff_t as unsigned */
+#define FMODE_UNSIGNED_OFFSET	((__force fmode_t)0x2000)
+
+/* File is opened with O_PATH; almost nothing can be done with it */
+#define FMODE_PATH		((__force fmode_t)0x4000)
+
+/* File needs atomic accesses to f_pos */
+#define FMODE_ATOMIC_POS	((__force fmode_t)0x8000)
+/* Write access to underlying fs */
+#define FMODE_WRITER		((__force fmode_t)0x10000)
+/* Has read method(s) */
+#define FMODE_CAN_READ          ((__force fmode_t)0x20000)
+/* Has write method(s) */
+#define FMODE_CAN_WRITE         ((__force fmode_t)0x40000)
+
+#define FMODE_OPENED		((__force fmode_t)0x80000)
+#define FMODE_CREATED		((__force fmode_t)0x100000)
+
+/* File is stream-like */
+#define FMODE_STREAM		((__force fmode_t)0x200000)
+
+/* File was opened by fanotify and shouldn't generate fanotify events */
+#define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
+
+/* File is capable of returning -EAGAIN if I/O will block */
+#define FMODE_NOWAIT		((__force fmode_t)0x8000000)
+
+/* File represents mount that needs unmounting */
+#define FMODE_NEED_UNMOUNT	((__force fmode_t)0x10000000)
+
+/* File does not contribute to nr_files count */
+#define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
+
+/* File supports async buffered reads */
+#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
+
+/*
+ * Attribute flags.  These should be or-ed together to figure out what
+ * has been changed!
+ */
+#define ATTR_MODE	(1 << 0)
+#define ATTR_UID	(1 << 1)
+#define ATTR_GID	(1 << 2)
+#define ATTR_SIZE	(1 << 3)
+#define ATTR_ATIME	(1 << 4)
+#define ATTR_MTIME	(1 << 5)
+#define ATTR_CTIME	(1 << 6)
+#define ATTR_ATIME_SET	(1 << 7)
+#define ATTR_MTIME_SET	(1 << 8)
+#define ATTR_FORCE	(1 << 9) /* Not a change, but a change it */
+#define ATTR_KILL_SUID	(1 << 11)
+#define ATTR_KILL_SGID	(1 << 12)
+#define ATTR_FILE	(1 << 13)
+#define ATTR_KILL_PRIV	(1 << 14)
+#define ATTR_OPEN	(1 << 15) /* Truncating from open(O_TRUNC) */
+#define ATTR_TIMES_SET	(1 << 16)
+#define ATTR_TOUCH	(1 << 17)
+
+/*
+ * Whiteout is represented by a char device.  The following constants define the
+ * mode and device number to use.
+ */
+#define WHITEOUT_MODE 0
+#define WHITEOUT_DEV 0
+
+/*
+ * This is the Inode Attributes structure, used for notify_change().  It
+ * uses the above definitions as flags, to know which values have changed.
+ * Also, in this manner, a Filesystem can look at only the values it cares
+ * about.  Basically, these are the attributes that the VFS layer can
+ * request to change from the FS layer.
+ *
+ * Derek Atkins <warlord@MIT.EDU> 94-10-20
+ */
+struct iattr {
+	unsigned int	ia_valid;
+	umode_t		ia_mode;
+	kuid_t		ia_uid;
+	kgid_t		ia_gid;
+	loff_t		ia_size;
+	struct timespec64 ia_atime;
+	struct timespec64 ia_mtime;
+	struct timespec64 ia_ctime;
+
+	/*
+	 * Not an attribute, but an auxiliary info for filesystems wanting to
+	 * implement an ftruncate() like method.  NOTE: filesystem should
+	 * check for (ia_valid & ATTR_FILE), and not for (ia_file != NULL).
+	 */
+	struct file	*ia_file;
+};
+
+/*
+ * Write life time hint values.
+ * Stored in struct inode as u8.
+ */
+enum rw_hint {
+	WRITE_LIFE_NOT_SET	= 0,
+	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
+	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
+	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
+	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
+	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+};
+
+/* Match RWF_* bits to IOCB bits */
+#define IOCB_HIPRI		(__force int) RWF_HIPRI
+#define IOCB_DSYNC		(__force int) RWF_DSYNC
+#define IOCB_SYNC		(__force int) RWF_SYNC
+#define IOCB_NOWAIT		(__force int) RWF_NOWAIT
+#define IOCB_APPEND		(__force int) RWF_APPEND
+
+/* non-RWF related bits - start at 16 */
+#define IOCB_EVENTFD		(1 << 16)
+#define IOCB_DIRECT		(1 << 17)
+#define IOCB_WRITE		(1 << 18)
+/* iocb->ki_waitq is valid */
+#define IOCB_WAITQ		(1 << 19)
+#define IOCB_NOIO		(1 << 20)
+/* can use bio alloc cache */
+#define IOCB_ALLOC_CACHE	(1 << 21)
+
+struct kiocb {
+	struct file		*ki_filp;
+
+	/* The 'ki_filp' pointer is shared in a union for aio */
+	randomized_struct_fields_start
+
+	loff_t			ki_pos;
+	void (*ki_complete)(struct kiocb *iocb, long ret);
+	void			*private;
+	int			ki_flags;
+	u16			ki_hint;
+	u16			ki_ioprio; /* See linux/ioprio.h */
+	struct wait_page_queue	*ki_waitq; /* for async buffered IO */
+	randomized_struct_fields_end
+};
+
+/*
+ * Maximum number of layers of fs stack.  Needs to be limited to
+ * prevent kernel stack overflow
+ */
+#define FILESYSTEM_MAX_STACK_DEPTH 2
+
+/**
+ * enum positive_aop_returns - aop return codes with specific semantics
+ *
+ * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
+ *			    completed, that the page is still locked, and
+ *			    should be considered active.  The VM uses this hint
+ *			    to return the page to the active list -- it won't
+ *			    be a candidate for writeback again in the near
+ *			    future.  Other callers must be careful to unlock
+ *			    the page if they get this return.  Returned by
+ *			    writepage();
+ *
+ * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
+ *			unlocked it and the page might have been truncated.
+ *			The caller should back up to acquiring a new page and
+ *			trying again.  The aop will be taking reasonable
+ *			precautions not to livelock.  If the caller held a page
+ *			reference, it should drop it before retrying.  Returned
+ *			by readpage().
+ *	
+ * address_space_operation functions return these large constants to indicate
+ * special semantics to the caller.  These are much larger than the bytes in a
+ * page to allow for functions that return the number of bytes operated on in a
+ * given page.
+ */
+
+enum positive_aop_returns {
+	AOP_WRITEPAGE_ACTIVATE	= 0x80000,
+	AOP_TRUNCATED_PAGE	= 0x80001,
+};
+
+#define AOP_FLAG_CONT_EXPAND		0x0001 /* called from cont_expand */
+#define AOP_FLAG_NOFS			0x0002 /* used by filesystem to direct
+						* helper code (eg buffer layer)
+						* to clear GFP_FS from alloc */
+
+/*
+ * "descriptor" for what we're up to with a read.
+ * This allows us to use the same read code yet
+ * have multiple different users of the data that
+ * we read from a file.
+ *
+ * The simplest case just copies the data to user
+ * mode.
+ */
+typedef struct {
+	size_t written;
+	size_t count;
+	union {
+		char __user *buf;
+		void *data;
+	} arg;
+	int error;
+} read_descriptor_t;
+
+typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
+		unsigned long, unsigned long);
+
+struct address_space_operations {
+	int (*writepage)(struct page *page, struct writeback_control *wbc);
+	int (*readpage)(struct file *, struct page *);
+
+	/* Write back some dirty pages from this mapping. */
+	int (*writepages)(struct address_space *, struct writeback_control *);
+
+	/* Set a page dirty.  Return true if this dirtied it */
+	int (*set_page_dirty)(struct page *page);
+
+	/*
+	 * Reads in the requested pages. Unlike ->readpage(), this is
+	 * PURELY used for read-ahead!.
+	 */
+	int (*readpages)(struct file *filp, struct address_space *mapping,
+			struct list_head *pages, unsigned nr_pages);
+	void (*readahead)(struct readahead_control *);
+
+	int (*write_begin)(struct file *, struct address_space *mapping,
+				loff_t pos, unsigned len, unsigned flags,
+				struct page **pagep, void **fsdata);
+	int (*write_end)(struct file *, struct address_space *mapping,
+				loff_t pos, unsigned len, unsigned copied,
+				struct page *page, void *fsdata);
+
+	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
+	sector_t (*bmap)(struct address_space *, sector_t);
+	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
+	int (*releasepage) (struct page *, gfp_t);
+	void (*freepage)(struct page *);
+	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
+	/*
+	 * migrate the contents of a page to the specified target. If
+	 * migrate_mode is MIGRATE_ASYNC, it must not block.
+	 */
+	int (*migratepage) (struct address_space *,
+			struct page *, struct page *, enum migrate_mode);
+	bool (*isolate_page)(struct page *, isolate_mode_t);
+	void (*putback_page)(struct page *);
+	int (*launder_page) (struct page *);
+	int (*is_partially_uptodate) (struct page *, unsigned long,
+					unsigned long);
+	void (*is_dirty_writeback) (struct page *, bool *, bool *);
+	int (*error_remove_page)(struct address_space *, struct page *);
+
+	/* swapfile support */
+	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
+				sector_t *span);
+	void (*swap_deactivate)(struct file *file);
+};
+
+/**
+ * struct address_space - Contents of a cacheable, mappable object.
+ * @host: Owner, either the inode or the block_device.
+ * @i_pages: Cached pages.
+ * @invalidate_lock: Guards coherency between page cache contents and
+ *   file offset->disk block mappings in the filesystem during invalidates.
+ *   It is also used to block modification of page cache contents through
+ *   memory mappings.
+ * @gfp_mask: Memory allocation flags to use for allocating pages.
+ * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @nr_thps: Number of THPs in the pagecache (non-shmem only).
+ * @i_mmap: Tree of private and shared mappings.
+ * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
+ * @nrpages: Number of page entries, protected by the i_pages lock.
+ * @writeback_index: Writeback starts here.
+ * @a_ops: Methods.
+ * @flags: Error bits and flags (AS_*).
+ * @wb_err: The most recent error which has occurred.
+ * @private_lock: For use by the owner of the address_space.
+ * @private_list: For use by the owner of the address_space.
+ * @private_data: For use by the owner of the address_space.
+ */
+struct address_space {
+	struct inode		*host;
+	struct xarray		i_pages;
+	struct rw_semaphore	invalidate_lock;
+	gfp_t			gfp_mask;
+	atomic_t		i_mmap_writable;
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	/* number of thp, only for non-shmem files */
+	atomic_t		nr_thps;
+#endif
+	struct rb_root_cached	i_mmap;
+	struct rw_semaphore	i_mmap_rwsem;
+	unsigned long		nrpages;
+	pgoff_t			writeback_index;
+	const struct address_space_operations *a_ops;
+	unsigned long		flags;
+	errseq_t		wb_err;
+	spinlock_t		private_lock;
+	struct list_head	private_list;
+	void			*private_data;
+} __attribute__((aligned(sizeof(long)))) __randomize_layout;
+	/*
+	 * On most architectures that alignment is already the case; but
+	 * must be enforced here for CRIS, to let the least significant bit
+	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
+	 */
+
+/* XArray tags, for tagging dirty and writeback pages in the pagecache. */
+#define PAGECACHE_TAG_DIRTY	XA_MARK_0
+#define PAGECACHE_TAG_WRITEBACK	XA_MARK_1
+#define PAGECACHE_TAG_TOWRITE	XA_MARK_2
+
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#define __NEED_I_SIZE_ORDERED
+#endif
+
+/*
+ * Keep mostly read-only and often accessed (especially for
+ * the RCU path lookup and 'stat' data) fields at the beginning
+ * of the 'struct inode'
+ */
+struct inode {
+	umode_t			i_mode;
+	unsigned short		i_opflags;
+	kuid_t			i_uid;
+	kgid_t			i_gid;
+	unsigned int		i_flags;
+
+#ifdef CONFIG_FS_POSIX_ACL
+	struct posix_acl	*i_acl;
+	struct posix_acl	*i_default_acl;
+#endif
+
+	const struct inode_operations	*i_op;
+	struct super_block	*i_sb;
+	struct address_space	*i_mapping;
+
+#ifdef CONFIG_SECURITY
+	void			*i_security;
+#endif
+
+	/* Stat data, not accessed from path walking */
+	unsigned long		i_ino;
+	/*
+	 * Filesystems may only read i_nlink directly.  They shall use the
+	 * following functions for modification:
+	 *
+	 *    (set|clear|inc|drop)_nlink
+	 *    inode_(inc|dec)_link_count
+	 */
+	union {
+		const unsigned int i_nlink;
+		unsigned int __i_nlink;
+	};
+	dev_t			i_rdev;
+	loff_t			i_size;
+	struct timespec64	i_atime;
+	struct timespec64	i_mtime;
+	struct timespec64	i_ctime;
+	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
+	unsigned short          i_bytes;
+	u8			i_blkbits;
+	u8			i_write_hint;
+	blkcnt_t		i_blocks;
+
+#ifdef __NEED_I_SIZE_ORDERED
+	seqcount_t		i_size_seqcount;
+#endif
+
+	/* Misc */
+	unsigned long		i_state;
+	struct rw_semaphore	i_rwsem;
+
+	unsigned long		dirtied_when;	/* jiffies of first dirtying */
+	unsigned long		dirtied_time_when;
+
+	struct hlist_node	i_hash;
+	struct list_head	i_io_list;	/* backing dev IO list */
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct bdi_writeback	*i_wb;		/* the associated cgroup wb */
+
+	/* foreign inode detection, see wbc_detach_inode() */
+	int			i_wb_frn_winner;
+	u16			i_wb_frn_avg_time;
+	u16			i_wb_frn_history;
+#endif
+	struct list_head	i_lru;		/* inode LRU list */
+	struct list_head	i_sb_list;
+	struct list_head	i_wb_list;	/* backing dev writeback list */
+	union {
+		struct hlist_head	i_dentry;
+		struct rcu_head		i_rcu;
+	};
+	atomic64_t		i_version;
+	atomic64_t		i_sequence; /* see futex */
+	atomic_t		i_count;
+	atomic_t		i_dio_count;
+	atomic_t		i_writecount;
+#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
+	atomic_t		i_readcount; /* struct files open RO */
+#endif
+	union {
+		const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
+		void (*free_inode)(struct inode *);
+	};
+	struct file_lock_context	*i_flctx;
+	struct address_space	i_data;
+	struct list_head	i_devices;
+	union {
+		struct pipe_inode_info	*i_pipe;
+		struct cdev		*i_cdev;
+		char			*i_link;
+		unsigned		i_dir_seq;
+	};
+
+	__u32			i_generation;
+
+#ifdef CONFIG_FSNOTIFY
+	__u32			i_fsnotify_mask; /* all events this inode cares about */
+	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
+#endif
+
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_info	*i_crypt_info;
+#endif
+
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info	*i_verity_info;
+#endif
+
+	void			*i_private; /* fs or device private pointer */
+} __randomize_layout;
+
+struct fown_struct {
+	rwlock_t lock;          /* protects pid, uid, euid fields */
+	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
+	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent to */
+	kuid_t uid, euid;	/* uid/euid of process setting the owner */
+	int signum;		/* posix.1b rt signal to be delivered on IO */
+};
+
+/**
+ * struct file_ra_state - Track a file's readahead state.
+ * @start: Where the most recent readahead started.
+ * @size: Number of pages read in the most recent readahead.
+ * @async_size: Start next readahead when this many pages are left.
+ * @ra_pages: Maximum size of a readahead request.
+ * @mmap_miss: How many mmap accesses missed in the page cache.
+ * @prev_pos: The last byte in the most recent read request.
+ */
+struct file_ra_state {
+	pgoff_t start;
+	unsigned int size;
+	unsigned int async_size;
+	unsigned int ra_pages;
+	unsigned int mmap_miss;
+	loff_t prev_pos;
+};
+
+struct file {
+	union {
+		struct llist_node	fu_llist;
+		struct rcu_head		fu_rcuhead;
+	} f_u;
+	struct path		f_path;
+	struct inode		*f_inode;	/* cached value */
+	const struct file_operations	*f_op;
+
+	/*
+	 * Protects f_ep, f_flags.
+	 * Must not be taken from IRQ context.
+	 */
+	spinlock_t		f_lock;
+	enum rw_hint		f_write_hint;
+	atomic_long_t		f_count;
+	unsigned int		f_flags;
+	fmode_t			f_mode;
+	struct mutex		f_pos_lock;
+	loff_t			f_pos;
+	struct fown_struct	f_owner;
+	const struct cred	*f_cred;
+	struct file_ra_state	f_ra;
+
+	u64			f_version;
+#ifdef CONFIG_SECURITY
+	void			*f_security;
+#endif
+	/* needed for tty driver, and maybe others */
+	void			*private_data;
+
+#ifdef CONFIG_EPOLL
+	/* Used by fs/eventpoll.c to link all the hooks to this file */
+	struct hlist_head	*f_ep;
+#endif /* #ifdef CONFIG_EPOLL */
+	struct address_space	*f_mapping;
+	errseq_t		f_wb_err;
+	errseq_t		f_sb_err; /* for syncfs */
+} __randomize_layout
+  __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
+
+struct file_handle {
+	__u32 handle_bytes;
+	int handle_type;
+	/* file identifier */
+	unsigned char f_handle[];
+};
+
+#define	MAX_NON_LFS	((1UL<<31) - 1)
+
+/* Page cache limit. The filesystems should put that into their s_maxbytes
+   limits, otherwise bad things can happen in VM. */
+#if BITS_PER_LONG==32
+#define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
+#elif BITS_PER_LONG==64
+#define MAX_LFS_FILESIZE	((loff_t)LLONG_MAX)
+#endif
+
+#define FL_POSIX	1
+#define FL_FLOCK	2
+#define FL_DELEG	4	/* NFSv4 delegation */
+#define FL_ACCESS	8	/* not trying to lock, just looking */
+#define FL_EXISTS	16	/* when unlocking, test for existence */
+#define FL_LEASE	32	/* lease held on this file */
+#define FL_CLOSE	64	/* unlock on close */
+#define FL_SLEEP	128	/* A blocking lock */
+#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
+#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
+#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
+#define FL_LAYOUT	2048	/* outstanding pNFS layout */
+#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
+
+#define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
+
+/*
+ * Special return value from posix_lock_file() and vfs_lock_file() for
+ * asynchronous locking.
+ */
+#define FILE_LOCK_DEFERRED 1
+
+/* legacy typedef, should eventually be removed */
+typedef void *fl_owner_t;
+
+struct file_lock;
+
+struct file_lock_operations {
+	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
+	void (*fl_release_private)(struct file_lock *);
+};
+
+struct lock_manager_operations {
+	fl_owner_t (*lm_get_owner)(fl_owner_t);
+	void (*lm_put_owner)(fl_owner_t);
+	void (*lm_notify)(struct file_lock *);	/* unblock callback */
+	int (*lm_grant)(struct file_lock *, int);
+	bool (*lm_break)(struct file_lock *);
+	int (*lm_change)(struct file_lock *, int, struct list_head *);
+	void (*lm_setup)(struct file_lock *, void **);
+	bool (*lm_breaker_owns_lease)(struct file_lock *);
+};
+
+struct lock_manager {
+	struct list_head list;
+	/*
+	 * NFSv4 and up also want opens blocked during the grace period;
+	 * NLM doesn't care:
+	 */
+	bool block_opens;
+};
+
+/*
+ * struct file_lock represents a generic "file lock". It's used to represent
+ * POSIX byte range locks, BSD (flock) locks, and leases. It's important to
+ * note that the same struct is used to represent both a request for a lock and
+ * the lock itself, but the same object is never used for both.
+ *
+ * FIXME: should we create a separate "struct lock_request" to help distinguish
+ * these two uses?
+ *
+ * The varous i_flctx lists are ordered by:
+ *
+ * 1) lock owner
+ * 2) lock range start
+ * 3) lock range end
+ *
+ * Obviously, the last two criteria only matter for POSIX locks.
+ */
+struct file_lock {
+	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
+	struct list_head fl_list;	/* link into file_lock_context */
+	struct hlist_node fl_link;	/* node in global lists */
+	struct list_head fl_blocked_requests;	/* list of requests with
+						 * ->fl_blocker pointing here
+						 */
+	struct list_head fl_blocked_member;	/* node in
+						 * ->fl_blocker->fl_blocked_requests
+						 */
+	fl_owner_t fl_owner;
+	unsigned int fl_flags;
+	unsigned char fl_type;
+	unsigned int fl_pid;
+	int fl_link_cpu;		/* what cpu's list is this on? */
+	wait_queue_head_t fl_wait;
+	struct file *fl_file;
+	loff_t fl_start;
+	loff_t fl_end;
+
+	struct fasync_struct *	fl_fasync; /* for lease break notifications */
+	/* for lease breaks: */
+	unsigned long fl_break_time;
+	unsigned long fl_downgrade_time;
+
+	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
+	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
+	union {
+		struct nfs_lock_info	nfs_fl;
+		struct nfs4_lock_info	nfs4_fl;
+		struct {
+			struct list_head link;	/* link in AFS vnode's pending_locks list */
+			int state;		/* state of grant or error if -ve */
+			unsigned int	debug_id;
+		} afs;
+	} fl_u;
+} __randomize_layout;
+
+struct file_lock_context {
+	spinlock_t		flc_lock;
+	struct list_head	flc_flock;
+	struct list_head	flc_posix;
+	struct list_head	flc_lease;
+};
+
+struct fasync_struct {
+	rwlock_t		fa_lock;
+	int			magic;
+	int			fa_fd;
+	struct fasync_struct	*fa_next; /* singly linked list */
+	struct file		*fa_file;
+	struct rcu_head		fa_rcu;
+};
+
+#define FASYNC_MAGIC 0x4601
+
+/*
+ * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
+ * represented in both.
+ */
+#define SB_RDONLY	 1	/* Mount read-only */
+#define SB_NOSUID	 2	/* Ignore suid and sgid bits */
+#define SB_NODEV	 4	/* Disallow access to device special files */
+#define SB_NOEXEC	 8	/* Disallow program execution */
+#define SB_SYNCHRONOUS	16	/* Writes are synced at once */
+#define SB_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define SB_DIRSYNC	128	/* Directory modifications are synchronous */
+#define SB_NOATIME	1024	/* Do not update access times. */
+#define SB_NODIRATIME	2048	/* Do not update directory access times */
+#define SB_SILENT	32768
+#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
+#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
+#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
+#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+
+/* These sb flags are internal to the kernel */
+#define SB_SUBMOUNT     (1<<26)
+#define SB_FORCE	(1<<27)
+#define SB_NOSEC	(1<<28)
+#define SB_BORN		(1<<29)
+#define SB_ACTIVE	(1<<30)
+#define SB_NOUSER	(1<<31)
+
+/* These flags relate to encoding and casefolding */
+#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+
+#define sb_has_strict_encoding(sb) \
+	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
+
+/*
+ *	Umount options
+ */
+
+#define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
+#define MNT_DETACH	0x00000002	/* Just detach from the tree */
+#define MNT_EXPIRE	0x00000004	/* Mark for expiry */
+#define UMOUNT_NOFOLLOW	0x00000008	/* Don't follow symlink on umount */
+#define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
+
+/* sb->s_iflags */
+#define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
+#define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
+#define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
+#define SB_I_STABLE_WRITES 0x00000008	/* don't modify blks until WB is done */
+
+/* sb->s_iflags to limit user namespace mounts */
+#define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
+#define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
+#define SB_I_UNTRUSTED_MOUNTER		0x00000040
+
+#define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
+#define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
+
+/* Possible states of 'frozen' field */
+enum {
+	SB_UNFROZEN = 0,		/* FS is unfrozen */
+	SB_FREEZE_WRITE	= 1,		/* Writes, dir ops, ioctls frozen */
+	SB_FREEZE_PAGEFAULT = 2,	/* Page faults stopped as well */
+	SB_FREEZE_FS = 3,		/* For internal FS use (e.g. to stop
+					 * internal threads if needed) */
+	SB_FREEZE_COMPLETE = 4,		/* ->freeze_fs finished successfully */
+};
+
+#define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
+
+struct sb_writers {
+	int				frozen;		/* Is sb frozen? */
+	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
+	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
+};
+
+/* quota data structures for superblock */
+#define MAXQUOTAS 3
+#define USRQUOTA  0		/* element used for user quotas */
+#define GRPQUOTA  1		/* element used for group quotas */
+#define PRJQUOTA  2		/* element used for project quotas */
+
+typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
+typedef long long qsize_t;	/* Type in which we store sizes */
+
+/*
+ * Data for one quotafile kept in memory
+ */
+struct quota_format_type;
+
+struct mem_dqinfo {
+	struct quota_format_type *dqi_format;
+	int dqi_fmt_id;		/* Id of the dqi_format - used when turning
+				 * quotas on after remount RW */
+	struct list_head dqi_dirty_list;	/* List of dirty dquots [dq_list_lock] */
+	unsigned long dqi_flags;	/* DFQ_ flags [dq_data_lock] */
+	unsigned int dqi_bgrace;	/* Space grace time [dq_data_lock] */
+	unsigned int dqi_igrace;	/* Inode grace time [dq_data_lock] */
+	qsize_t dqi_max_spc_limit;	/* Maximum space limit [static] */
+	qsize_t dqi_max_ino_limit;	/* Maximum inode limit [static] */
+	void *dqi_priv;
+};
+
+
+struct quota_info {
+	unsigned int flags;			/* Flags for diskquotas on this device */
+	struct rw_semaphore dqio_sem;		/* Lock quota file while I/O in progress */
+	struct inode *files[MAXQUOTAS];		/* inodes of quotafiles */
+	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
+	const struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
+};
+
+struct super_block {
+	struct list_head	s_list;		/* Keep this first */
+	dev_t			s_dev;		/* search index; _not_ kdev_t */
+	unsigned char		s_blocksize_bits;
+	unsigned long		s_blocksize;
+	loff_t			s_maxbytes;	/* Max file size */
+	struct file_system_type	*s_type;
+	const struct super_operations	*s_op;
+	const struct dquot_operations	*dq_op;
+	const struct quotactl_ops	*s_qcop;
+	const struct export_operations *s_export_op;
+	unsigned long		s_flags;
+	unsigned long		s_iflags;	/* internal SB_I_* flags */
+	unsigned long		s_magic;
+	struct dentry		*s_root;
+	struct rw_semaphore	s_umount;
+	int			s_count;
+	atomic_t		s_active;
+#ifdef CONFIG_SECURITY
+	void                    *s_security;
+#endif
+	const struct xattr_handler **s_xattr;
+#ifdef CONFIG_FS_ENCRYPTION
+	const struct fscrypt_operations	*s_cop;
+	struct key		*s_master_keys; /* master crypto keys in use */
+#endif
+#ifdef CONFIG_FS_VERITY
+	const struct fsverity_operations *s_vop;
+#endif
+#ifdef CONFIG_UNICODE
+	struct unicode_map *s_encoding;
+	__u16 s_encoding_flags;
+#endif
+	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
+	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
+	struct block_device	*s_bdev;
+	struct backing_dev_info *s_bdi;
+	struct mtd_info		*s_mtd;
+	struct hlist_node	s_instances;
+	unsigned int		s_quota_types;	/* Bitmask of supported quota types */
+	struct quota_info	s_dquot;	/* Diskquota specific options */
+
+	struct sb_writers	s_writers;
+
+	/*
+	 * Keep s_fs_info, s_time_gran, s_fsnotify_mask, and
+	 * s_fsnotify_marks together for cache efficiency. They are frequently
+	 * accessed and rarely modified.
+	 */
+	void			*s_fs_info;	/* Filesystem private info */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	u32			s_time_gran;
+	/* Time limits for c/m/atime in seconds */
+	time64_t		   s_time_min;
+	time64_t		   s_time_max;
+#ifdef CONFIG_FSNOTIFY
+	__u32			s_fsnotify_mask;
+	struct fsnotify_mark_connector __rcu	*s_fsnotify_marks;
+#endif
+
+	char			s_id[32];	/* Informational name */
+	uuid_t			s_uuid;		/* UUID */
+
+	unsigned int		s_max_links;
+	fmode_t			s_mode;
+
+	/*
+	 * The next field is for VFS *only*. No filesystems have any business
+	 * even looking at it. You had been warned.
+	 */
+	struct mutex s_vfs_rename_mutex;	/* Kludge */
+
+	/*
+	 * Filesystem subtype.  If non-empty the filesystem type field
+	 * in /proc/mounts will be "type.subtype"
+	 */
+	const char *s_subtype;
+
+	const struct dentry_operations *s_d_op; /* default d_op for dentries */
+
+	/*
+	 * Saved pool identifier for cleancache (-1 means none)
+	 */
+	int cleancache_poolid;
+
+	struct shrinker s_shrink;	/* per-sb shrinker handle */
+
+	/* Number of inodes with nlink == 0 but still referenced */
+	atomic_long_t s_remove_count;
+
+	/*
+	 * Number of inode/mount/sb objects that are being watched, note that
+	 * inodes objects are currently double-accounted.
+	 */
+	atomic_long_t s_fsnotify_connectors;
+
+	/* Being remounted read-only */
+	int s_readonly_remount;
+
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
+	/* AIO completions deferred from interrupt context */
+	struct workqueue_struct *s_dio_done_wq;
+	struct hlist_head s_pins;
+
+	/*
+	 * Owning user namespace and default context in which to
+	 * interpret filesystem uids, gids, quotas, device nodes,
+	 * xattrs and security labels.
+	 */
+	struct user_namespace *s_user_ns;
+
+	/*
+	 * The list_lru structure is essentially just a pointer to a table
+	 * of per-node lru lists, each of which has its own spinlock.
+	 * There is no need to put them into separate cachelines.
+	 */
+	struct list_lru		s_dentry_lru;
+	struct list_lru		s_inode_lru;
+	struct rcu_head		rcu;
+	struct work_struct	destroy_work;
+
+	struct mutex		s_sync_lock;	/* sync serialisation lock */
+
+	/*
+	 * Indicates how deep in a filesystem stack this SB is
+	 */
+	int s_stack_depth;
+
+	/* s_inode_list_lock protects s_inodes */
+	spinlock_t		s_inode_list_lock ____cacheline_aligned_in_smp;
+	struct list_head	s_inodes;	/* all inodes */
+
+	spinlock_t		s_inode_wblist_lock;
+	struct list_head	s_inodes_wb;	/* writeback inodes */
+} __randomize_layout;
+
+/**
+ * struct renamedata - contains all information required for renaming
+ * @old_mnt_userns:    old user namespace of the mount the inode was found from
+ * @old_dir:           parent of source
+ * @old_dentry:                source
+ * @new_mnt_userns:    new user namespace of the mount the inode was found from
+ * @new_dir:           parent of destination
+ * @new_dentry:                destination
+ * @delegated_inode:   returns an inode needing a delegation break
+ * @flags:             rename flags
+ */
+struct renamedata {
+	struct user_namespace *old_mnt_userns;
+	struct inode *old_dir;
+	struct dentry *old_dentry;
+	struct user_namespace *new_mnt_userns;
+	struct inode *new_dir;
+	struct dentry *new_dentry;
+	struct inode **delegated_inode;
+	unsigned int flags;
+} __randomize_layout;
+
+/*
+ * This is the "filldir" function type, used by readdir() to let
+ * the kernel specify what kind of dirent layout it wants to have.
+ * This allows the kernel to read directories into kernel space or
+ * to have different dirent layouts depending on the binary type.
+ */
+struct dir_context;
+typedef int (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
+			 unsigned);
+
+struct dir_context {
+	filldir_t actor;
+	loff_t pos;
+};
+
+/*
+ * These flags let !MMU mmap() govern direct device mapping vs immediate
+ * copying more easily for MAP_PRIVATE, especially for ROM filesystems.
+ *
+ * NOMMU_MAP_COPY:	Copy can be mapped (MAP_PRIVATE)
+ * NOMMU_MAP_DIRECT:	Can be mapped directly (MAP_SHARED)
+ * NOMMU_MAP_READ:	Can be mapped for reading
+ * NOMMU_MAP_WRITE:	Can be mapped for writing
+ * NOMMU_MAP_EXEC:	Can be mapped for execution
+ */
+#define NOMMU_MAP_COPY		0x00000001
+#define NOMMU_MAP_DIRECT	0x00000008
+#define NOMMU_MAP_READ		VM_MAYREAD
+#define NOMMU_MAP_WRITE		VM_MAYWRITE
+#define NOMMU_MAP_EXEC		VM_MAYEXEC
+
+#define NOMMU_VMFLAGS \
+	(NOMMU_MAP_READ | NOMMU_MAP_WRITE | NOMMU_MAP_EXEC)
+
+/*
+ * These flags control the behavior of the remap_file_range function pointer.
+ * If it is called with len == 0 that means "remap to end of source file".
+ * See Documentation/filesystems/vfs.rst for more details about this call.
+ *
+ * REMAP_FILE_DEDUP: only remap if contents identical (i.e. deduplicate)
+ * REMAP_FILE_CAN_SHORTEN: caller can handle a shortened request
+ */
+#define REMAP_FILE_DEDUP		(1 << 0)
+#define REMAP_FILE_CAN_SHORTEN		(1 << 1)
+
+/*
+ * These flags signal that the caller is ok with altering various aspects of
+ * the behavior of the remap operation.  The changes must be made by the
+ * implementation; the vfs remap helper functions can take advantage of them.
+ * Flags in this category exist to preserve the quirky behavior of the hoisted
+ * btrfs clone/dedupe ioctls.
+ */
+#define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
+
+struct iov_iter;
+
+struct file_operations {
+	struct module *owner;
+	loff_t (*llseek) (struct file *, loff_t, int);
+	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
+	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
+	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
+	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
+			unsigned int flags);
+	int (*iterate) (struct file *, struct dir_context *);
+	int (*iterate_shared) (struct file *, struct dir_context *);
+	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
+	int (*mmap) (struct file *, struct vm_area_struct *);
+	unsigned long mmap_supported_flags;
+	int (*open) (struct inode *, struct file *);
+	int (*flush) (struct file *, fl_owner_t id);
+	int (*release) (struct inode *, struct file *);
+	int (*fsync) (struct file *, loff_t, loff_t, int datasync);
+	int (*fasync) (int, struct file *, int);
+	int (*lock) (struct file *, int, struct file_lock *);
+	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
+	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+	int (*check_flags)(int);
+	int (*flock) (struct file *, int, struct file_lock *);
+	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
+	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
+	int (*setlease)(struct file *, long, struct file_lock **, void **);
+	long (*fallocate)(struct file *file, int mode, loff_t offset,
+			  loff_t len);
+	void (*show_fdinfo)(struct seq_file *m, struct file *f);
+#ifndef CONFIG_MMU
+	unsigned (*mmap_capabilities)(struct file *);
+#endif
+	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
+			loff_t, size_t, unsigned int);
+	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
+				   struct file *file_out, loff_t pos_out,
+				   loff_t len, unsigned int remap_flags);
+	int (*fadvise)(struct file *, loff_t, loff_t, int);
+} __randomize_layout;
+
+struct inode_operations {
+	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
+	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
+	int (*permission) (struct user_namespace *, struct inode *, int);
+	struct posix_acl * (*get_acl)(struct inode *, int, bool);
+
+	int (*readlink) (struct dentry *, char __user *,int);
+
+	int (*create) (struct user_namespace *, struct inode *,struct dentry *,
+		       umode_t, bool);
+	int (*link) (struct dentry *,struct inode *,struct dentry *);
+	int (*unlink) (struct inode *,struct dentry *);
+	int (*symlink) (struct user_namespace *, struct inode *,struct dentry *,
+			const char *);
+	int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,
+		      umode_t);
+	int (*rmdir) (struct inode *,struct dentry *);
+	int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,
+		      umode_t,dev_t);
+	int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
+			struct inode *, struct dentry *, unsigned int);
+	int (*setattr) (struct user_namespace *, struct dentry *,
+			struct iattr *);
+	int (*getattr) (struct user_namespace *, const struct path *,
+			struct kstat *, u32, unsigned int);
+	ssize_t (*listxattr) (struct dentry *, char *, size_t);
+	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
+		      u64 len);
+	int (*update_time)(struct inode *, struct timespec64 *, int);
+	int (*atomic_open)(struct inode *, struct dentry *,
+			   struct file *, unsigned open_flag,
+			   umode_t create_mode);
+	int (*tmpfile) (struct user_namespace *, struct inode *,
+			struct dentry *, umode_t);
+	int (*set_acl)(struct user_namespace *, struct inode *,
+		       struct posix_acl *, int);
+	int (*fileattr_set)(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct fileattr *fa);
+	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+} ____cacheline_aligned;
+
+struct super_operations {
+	struct inode *(*alloc_inode)(struct super_block *sb);
+	void (*destroy_inode)(struct inode *);
+	void (*free_inode)(struct inode *);
+
+	void (*dirty_inode) (struct inode *, int flags);
+	int (*write_inode) (struct inode *, struct writeback_control *wbc);
+	int (*drop_inode) (struct inode *);
+	void (*evict_inode) (struct inode *);
+	void (*put_super) (struct super_block *);
+	int (*sync_fs)(struct super_block *sb, int wait);
+	int (*freeze_super) (struct super_block *);
+	int (*freeze_fs) (struct super_block *);
+	int (*thaw_super) (struct super_block *);
+	int (*unfreeze_fs) (struct super_block *);
+	int (*statfs) (struct dentry *, struct kstatfs *);
+	int (*remount_fs) (struct super_block *, int *, char *);
+	void (*umount_begin) (struct super_block *);
+
+	int (*show_options)(struct seq_file *, struct dentry *);
+	int (*show_devname)(struct seq_file *, struct dentry *);
+	int (*show_path)(struct seq_file *, struct dentry *);
+	int (*show_stats)(struct seq_file *, struct dentry *);
+#ifdef CONFIG_QUOTA
+	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
+	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
+	struct dquot **(*get_dquots)(struct inode *);
+#endif
+	long (*nr_cached_objects)(struct super_block *,
+				  struct shrink_control *);
+	long (*free_cached_objects)(struct super_block *,
+				    struct shrink_control *);
+};
+
+struct file_system_type {
+	const char *name;
+	int fs_flags;
+#define FS_REQUIRES_DEV		1
+#define FS_BINARY_MOUNTDATA	2
+#define FS_HAS_SUBTYPE		4
+#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
+#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+	int (*init_fs_context)(struct fs_context *);
+	const struct fs_parameter_spec *parameters;
+	struct dentry *(*mount) (struct file_system_type *, int,
+		       const char *, void *);
+	void (*kill_sb) (struct super_block *);
+	struct module *owner;
+	struct file_system_type * next;
+	struct hlist_head fs_supers;
+
+	struct lock_class_key s_lock_key;
+	struct lock_class_key s_umount_key;
+	struct lock_class_key s_vfs_rename_key;
+	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
+
+	struct lock_class_key i_lock_key;
+	struct lock_class_key i_mutex_key;
+	struct lock_class_key invalidate_lock_key;
+	struct lock_class_key i_mutex_dir_key;
+};
+
+struct audit_names;
+struct filename {
+	const char		*name;	/* pointer to actual string */
+	const __user char	*uptr;	/* original userland pointer */
+	int			refcnt;
+	struct audit_names	*aname;
+	const char		iname[];
+};
+
+/*
+ * This is the common implementation of dirent to fs
+ * on-disk file type conversion.  Although the fs on-disk
  * bits are specific to every file system, in practice, many
  * file systems use the exact same on-disk format to describe
  * the lower 3 file type bits that represent the 7 POSIX file
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 18ebd39c9487..b105e92290dd 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -62,9 +62,6 @@ enum quota_type {
 #define QTYPE_MASK_GRP (1 << GRPQUOTA)
 #define QTYPE_MASK_PRJ (1 << PRJQUOTA)
 
-typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
-typedef long long qsize_t;	/* Type in which we store sizes */
-
 struct kqid {			/* Type in which we store the quota identifier */
 	union {
 		kuid_t uid;
@@ -214,24 +211,6 @@ struct mem_dqblk {
 	time64_t dqb_itime;	/* time limit for excessive inode use */
 };
 
-/*
- * Data for one quotafile kept in memory
- */
-struct quota_format_type;
-
-struct mem_dqinfo {
-	struct quota_format_type *dqi_format;
-	int dqi_fmt_id;		/* Id of the dqi_format - used when turning
-				 * quotas on after remount RW */
-	struct list_head dqi_dirty_list;	/* List of dirty dquots [dq_list_lock] */
-	unsigned long dqi_flags;	/* DFQ_ flags [dq_data_lock] */
-	unsigned int dqi_bgrace;	/* Space grace time [dq_data_lock] */
-	unsigned int dqi_igrace;	/* Inode grace time [dq_data_lock] */
-	qsize_t dqi_max_spc_limit;	/* Maximum space limit [static] */
-	qsize_t dqi_max_ino_limit;	/* Maximum inode limit [static] */
-	void *dqi_priv;
-};
-
 struct super_block;
 
 /* Mask for flags passed to userspace */
@@ -516,14 +495,6 @@ static inline void quota_send_warning(struct kqid qid, dev_t dev,
 }
 #endif /* CONFIG_QUOTA_NETLINK_INTERFACE */
 
-struct quota_info {
-	unsigned int flags;			/* Flags for diskquotas on this device */
-	struct rw_semaphore dqio_sem;		/* Lock quota file while I/O in progress */
-	struct inode *files[MAXQUOTAS];		/* inodes of quotafiles */
-	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
-	const struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
-};
-
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
 
-- 
2.29.2

