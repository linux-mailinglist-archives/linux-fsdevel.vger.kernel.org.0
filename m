Return-Path: <linux-fsdevel+bounces-66958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA9CC319C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07A9F4F6B4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8D330B34;
	Tue,  4 Nov 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8X00ciB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E2330337;
	Tue,  4 Nov 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267614; cv=none; b=ttE7roP3ofhCXDQyyxzCPGk/nRAnW34KmaBuXbIErWEbWZ3KkcHvkkx4wS+xvHh1jZf6G9mFPBfbbjDCvWXQZKAkN1dA14rMw/KezYSgs4A7FWJHdyaMZjKKZ7bOqiP19NOngKb8wdA5qnmvZyEr8ctamtCBJBHTxLlj+/q7ubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267614; c=relaxed/simple;
	bh=Wyzxz/8CJ6Csnziy1oCaW9X4Bek3pjOE8flBfZVpb20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRqhpScf1xowkebXjg6cKNNEIIHzPlffIrM5w5eUPknCDbtBqgH6Fx2H2Y3ia/+BgOH4WhDyGGnyZ1JxfX+NNFWcPLGQx/++veYruqACFk3SRH/Aow1yDf+QwchKWju8bcnO/BXzjnMS0O05yO572gyO5O7MAa2dT0TjqXPUUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8X00ciB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52ECC116B1;
	Tue,  4 Nov 2025 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267614;
	bh=Wyzxz/8CJ6Csnziy1oCaW9X4Bek3pjOE8flBfZVpb20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K8X00ciB3m7GdTa3457A/CBMH2NzYPWJ5teAU+PWrq6rxoWrINCtgg+9pkqtbfFnn
	 h0Ce/vjLW/Suag6Y8hTJf/BwUeu3/VXcBDJUiaUJK7Ptkh8Cmrt3oP3vDsHQ45eO5g
	 KRQ+9VKnZ7R/YMhgTkQ9Xvttz+wxEYAtdUBDNMvwh34B5ayto9x1PpWMzt1IOHis43
	 w+rxneAiuvQv+Nj7cSeDAaCix/ONBcDuBqsOoahZpUgZmnT0705UTSBPLXKsyiZX4s
	 YQhy9t34w5KzBjtAOe1CdESnWQXzd9JbMIAiqDKFwc8zDKjEmwN2Fd0M9NcWqjZ0Dz
	 6jdvSDYzOeuDw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 15:46:33 +0100
Subject: [PATCH 2/3] fs: add fs_super_types header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-fs-header-v1-2-fb39a2efe39e@kernel.org>
References: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
In-Reply-To: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=27435; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Wyzxz/8CJ6Csnziy1oCaW9X4Bek3pjOE8flBfZVpb20=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyCd5omrHt+caA3raSAzdurzj6+fqnFv0tK88xzdFdd
 1I+m2FabkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE6rgY/lfyfbN7Vj1ZTV/9
 Ka/QxddzL2gu9fP7ezp02SOuZcduloUwMrxOOVLyT+ylwSQD3QzHh22nmc791z64Kr3zuuOpOx0
 NGjwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split out super block associated structures into a separate header.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h             | 308 +------------------------------------
 include/linux/fs_super_types.h | 335 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 336 insertions(+), 307 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3c971ddace41..17fa9b64354b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FS_H
 #define _LINUX_FS_H
 
+#include <linux/fs_super_types.h>
 #include <linux/vfsdebug.h>
 #include <linux/linkage.h>
 #include <linux/wait_bit.h>
@@ -11,7 +12,6 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/list.h>
-#include <linux/list_lru.h>
 #include <linux/llist.h>
 #include <linux/radix-tree.h>
 #include <linux/xarray.h>
@@ -37,7 +37,6 @@
 #include <linux/uuid.h>
 #include <linux/errseq.h>
 #include <linux/ioprio.h>
-#include <linux/fs_dirent.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
 #include <linux/mount.h>
@@ -52,11 +51,9 @@
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
 
-struct backing_dev_info;
 struct bdi_writeback;
 struct bio;
 struct io_comp_batch;
-struct export_operations;
 struct fiemap_extent_info;
 struct hd_geometry;
 struct iovec;
@@ -70,12 +67,8 @@ struct vfsmount;
 struct cred;
 struct swap_info_struct;
 struct seq_file;
-struct workqueue_struct;
 struct iov_iter;
-struct fscrypt_operations;
-struct fsverity_operations;
 struct fsnotify_mark_connector;
-struct fsnotify_sb_info;
 struct fs_context;
 struct fs_parameter_spec;
 struct file_kattr;
@@ -298,11 +291,6 @@ struct iattr {
 	struct file	*ia_file;
 };
 
-/*
- * Includes for diskquotas.
- */
-#include <linux/quota.h>
-
 /*
  * Maximum number of layers of fs stack.  Needs to be limited to
  * prevent kernel stack overflow
@@ -1347,49 +1335,6 @@ extern void f_delown(struct file *filp);
 extern pid_t f_getown(struct file *filp);
 extern int send_sigurg(struct file *file);
 
-/*
- * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
- * represented in both.
- */
-#define SB_RDONLY       BIT(0)	/* Mount read-only */
-#define SB_NOSUID       BIT(1)	/* Ignore suid and sgid bits */
-#define SB_NODEV        BIT(2)	/* Disallow access to device special files */
-#define SB_NOEXEC       BIT(3)	/* Disallow program execution */
-#define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
-#define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
-#define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchronous */
-#define SB_NOATIME      BIT(10)	/* Do not update access times. */
-#define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
-#define SB_SILENT       BIT(15)
-#define SB_POSIXACL     BIT(16)	/* Supports POSIX ACLs */
-#define SB_INLINECRYPT  BIT(17)	/* Use blk-crypto for encrypted files */
-#define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
-#define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
-#define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
-
-/* These sb flags are internal to the kernel */
-#define SB_DEAD         BIT(21)
-#define SB_DYING        BIT(24)
-#define SB_FORCE        BIT(27)
-#define SB_NOSEC        BIT(28)
-#define SB_BORN         BIT(29)
-#define SB_ACTIVE       BIT(30)
-#define SB_NOUSER       BIT(31)
-
-/* These flags relate to encoding and casefolding */
-#define SB_ENC_STRICT_MODE_FL		(1 << 0)
-#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
-
-#define sb_has_strict_encoding(sb) \
-	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
-
-#if IS_ENABLED(CONFIG_UNICODE)
-#define sb_no_casefold_compat_fallback(sb) \
-	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
-#else
-#define sb_no_casefold_compat_fallback(sb) (1)
-#endif
-
 /*
  *	Umount options
  */
@@ -1400,191 +1345,6 @@ extern int send_sigurg(struct file *file);
 #define UMOUNT_NOFOLLOW	0x00000008	/* Don't follow symlink on umount */
 #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
 
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
-#define SB_I_EVM_HMAC_UNSUPPORTED	0x00000080
-
-#define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
-#define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
-#define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
-#define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
-#define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
-#define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
-#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
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
-	unsigned short			frozen;		/* Is sb frozen? */
-	int				freeze_kcount;	/* How many kernel freeze requests? */
-	int				freeze_ucount;	/* How many userspace freeze requests? */
-	const void			*freeze_owner;	/* Owner of the freeze */
-	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
-};
-
-struct mount;
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
-	const struct xattr_handler * const *s_xattr;
-#ifdef CONFIG_FS_ENCRYPTION
-	const struct fscrypt_operations	*s_cop;
-	struct fscrypt_keyring	*s_master_keys; /* master crypto keys in use */
-#endif
-#ifdef CONFIG_FS_VERITY
-	const struct fsverity_operations *s_vop;
-#endif
-#if IS_ENABLED(CONFIG_UNICODE)
-	struct unicode_map *s_encoding;
-	__u16 s_encoding_flags;
-#endif
-	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
-	struct mount		*s_mounts;	/* list of mounts; _not_ for fs use */
-	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
-	struct file		*s_bdev_file;
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
-	 * s_fsnotify_info together for cache efficiency. They are frequently
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
-	u32			s_fsnotify_mask;
-	struct fsnotify_sb_info	*s_fsnotify_info;
-#endif
-
-	/*
-	 * q: why are s_id and s_sysfs_name not the same? both are human
-	 * readable strings that identify the filesystem
-	 * a: s_id is allowed to change at runtime; it's used in log messages,
-	 * and we want to when a device starts out as single device (s_id is dev
-	 * name) but then a device is hot added and we have to switch to
-	 * identifying it by UUID
-	 * but s_sysfs_name is a handle for programmatic access, and can't
-	 * change at runtime
-	 */
-	char			s_id[32];	/* Informational name */
-	uuid_t			s_uuid;		/* UUID */
-	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
-
-	/* if set, fs shows up under sysfs at /sys/fs/$FSTYP/s_sysfs_name */
-	char			s_sysfs_name[UUID_STRING_LEN + 1];
-
-	unsigned int		s_max_links;
-	unsigned int		s_d_flags;	/* default d_flags for dentries */
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
-	const struct dentry_operations *__s_d_op; /* default d_op for dentries */
-
-	struct shrinker *s_shrink;	/* per-sb shrinker handle */
-
-	/* Number of inodes with nlink == 0 but still referenced */
-	atomic_long_t s_remove_count;
-
-	/* Read-only state of the superblock is being changed */
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
@@ -2431,72 +2191,6 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
 
-/**
- * enum freeze_holder - holder of the freeze
- * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
- * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
- * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
- * @FREEZE_EXCL: a freeze that can only be undone by the owner
- *
- * Indicate who the owner of the freeze or thaw request is and whether
- * the freeze needs to be exclusive or can nest.
- * Without @FREEZE_MAY_NEST, multiple freeze and thaw requests from the
- * same holder aren't allowed. It is however allowed to hold a single
- * @FREEZE_HOLDER_USERSPACE and a single @FREEZE_HOLDER_KERNEL freeze at
- * the same time. This is relied upon by some filesystems during online
- * repair or similar.
- */
-enum freeze_holder {
-	FREEZE_HOLDER_KERNEL	= (1U << 0),
-	FREEZE_HOLDER_USERSPACE	= (1U << 1),
-	FREEZE_MAY_NEST		= (1U << 2),
-	FREEZE_EXCL		= (1U << 3),
-};
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
-	int (*freeze_super) (struct super_block *, enum freeze_holder who, const void *owner);
-	int (*freeze_fs) (struct super_block *);
-	int (*thaw_super) (struct super_block *, enum freeze_holder who, const void *owner);
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
-	struct dquot __rcu **(*get_dquots)(struct inode *);
-#endif
-	long (*nr_cached_objects)(struct super_block *,
-				  struct shrink_control *);
-	long (*free_cached_objects)(struct super_block *,
-				    struct shrink_control *);
-	/*
-	 * If a filesystem can support graceful removal of a device and
-	 * continue read-write operations, implement this callback.
-	 *
-	 * Return 0 if the filesystem can continue read-write.
-	 * Non-zero return value or no such callback means the fs will be shutdown
-	 * as usual.
-	 */
-	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
-	void (*shutdown)(struct super_block *sb);
-};
-
 /*
  * Inode flags - they have no relation to superblock flags now
  */
diff --git a/include/linux/fs_super_types.h b/include/linux/fs_super_types.h
new file mode 100644
index 000000000000..45cfd45b9fe0
--- /dev/null
+++ b/include/linux/fs_super_types.h
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FS_SUPER_TYPES_H
+#define _LINUX_FS_SUPER_TYPES_H
+
+#include <linux/fs_dirent.h>
+#include <linux/errseq.h>
+#include <linux/list_lru.h>
+#include <linux/list.h>
+#include <linux/list_bl.h>
+#include <linux/llist.h>
+#include <linux/uidgid.h>
+#include <linux/uuid.h>
+#include <linux/percpu-rwsem.h>
+#include <linux/workqueue_types.h>
+#include <linux/quota.h>
+
+struct backing_dev_info;
+struct block_device;
+struct dentry;
+struct dentry_operations;
+struct dquot_operations;
+struct export_operations;
+struct file;
+struct file_system_type;
+struct fscrypt_operations;
+struct fsnotify_sb_info;
+struct fsverity_operations;
+struct kstatfs;
+struct mount;
+struct mtd_info;
+struct quotactl_ops;
+struct shrinker;
+struct unicode_map;
+struct user_namespace;
+struct workqueue_struct;
+struct writeback_control;
+struct xattr_handler;
+
+extern struct super_block *blockdev_superblock;
+
+/* Possible states of 'frozen' field */
+enum {
+	SB_UNFROZEN		= 0,	/* FS is unfrozen */
+	SB_FREEZE_WRITE		= 1,	/* Writes, dir ops, ioctls frozen */
+	SB_FREEZE_PAGEFAULT	= 2,	/* Page faults stopped as well */
+	SB_FREEZE_FS		= 3,	/* For internal FS use (e.g. to stop internal threads if needed) */
+	SB_FREEZE_COMPLETE	= 4,	/* ->freeze_fs finished successfully */
+};
+
+#define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
+
+struct sb_writers {
+	unsigned short			frozen;		/* Is sb frozen? */
+	int				freeze_kcount;	/* How many kernel freeze requests? */
+	int				freeze_ucount;	/* How many userspace freeze requests? */
+	const void			*freeze_owner;	/* Owner of the freeze */
+	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
+};
+
+/**
+ * enum freeze_holder - holder of the freeze
+ * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
+ * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
+ * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
+ * @FREEZE_EXCL: a freeze that can only be undone by the owner
+ *
+ * Indicate who the owner of the freeze or thaw request is and whether
+ * the freeze needs to be exclusive or can nest.
+ * Without @FREEZE_MAY_NEST, multiple freeze and thaw requests from the
+ * same holder aren't allowed. It is however allowed to hold a single
+ * @FREEZE_HOLDER_USERSPACE and a single @FREEZE_HOLDER_KERNEL freeze at
+ * the same time. This is relied upon by some filesystems during online
+ * repair or similar.
+ */
+enum freeze_holder {
+	FREEZE_HOLDER_KERNEL	= (1U << 0),
+	FREEZE_HOLDER_USERSPACE	= (1U << 1),
+	FREEZE_MAY_NEST		= (1U << 2),
+	FREEZE_EXCL		= (1U << 3),
+};
+
+struct super_operations {
+	struct inode *(*alloc_inode)(struct super_block *sb);
+	void (*destroy_inode)(struct inode *inode);
+	void (*free_inode)(struct inode *inode);
+	void (*dirty_inode)(struct inode *inode, int flags);
+	int (*write_inode)(struct inode *inode, struct writeback_control *wbc);
+	int (*drop_inode)(struct inode *inode);
+	void (*evict_inode)(struct inode *inode);
+	void (*put_super)(struct super_block *sb);
+	int (*sync_fs)(struct super_block *sb, int wait);
+	int (*freeze_super)(struct super_block *sb, enum freeze_holder who,
+			    const void *owner);
+	int (*freeze_fs)(struct super_block *sb);
+	int (*thaw_super)(struct super_block *sb, enum freeze_holder who,
+			  const void *owner);
+	int (*unfreeze_fs)(struct super_block *sb);
+	int (*statfs)(struct dentry *dentry, struct kstatfs *kstatfs);
+	int (*remount_fs) (struct super_block *, int *, char *);
+	void (*umount_begin)(struct super_block *sb);
+
+	int (*show_options)(struct seq_file *seq, struct dentry *dentry);
+	int (*show_devname)(struct seq_file *seq, struct dentry *dentry);
+	int (*show_path)(struct seq_file *seq, struct dentry *dentry);
+	int (*show_stats)(struct seq_file *seq, struct dentry *dentry);
+#ifdef CONFIG_QUOTA
+	ssize_t (*quota_read)(struct super_block *sb, int type, char *data,
+			      size_t len, loff_t off);
+	ssize_t (*quota_write)(struct super_block *sb, int type,
+			       const char *data, size_t len, loff_t off);
+	struct dquot __rcu **(*get_dquots)(struct inode *inode);
+#endif
+	long (*nr_cached_objects)(struct super_block *sb,
+				  struct shrink_control *sc);
+	long (*free_cached_objects)(struct super_block *sb,
+				    struct shrink_control *sc);
+	/*
+	 * If a filesystem can support graceful removal of a device and
+	 * continue read-write operations, implement this callback.
+	 *
+	 * Return 0 if the filesystem can continue read-write.
+	 * Non-zero return value or no such callback means the fs will be shutdown
+	 * as usual.
+	 */
+	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
+	void (*shutdown)(struct super_block *sb);
+};
+
+struct super_block {
+	struct list_head			s_list;		/* Keep this first */
+	dev_t					s_dev;		/* search index; _not_ kdev_t */
+	unsigned char				s_blocksize_bits;
+	unsigned long				s_blocksize;
+	loff_t					s_maxbytes;	/* Max file size */
+	struct file_system_type			*s_type;
+	const struct super_operations		*s_op;
+	const struct dquot_operations		*dq_op;
+	const struct quotactl_ops		*s_qcop;
+	const struct export_operations		*s_export_op;
+	unsigned long				s_flags;
+	unsigned long				s_iflags;	/* internal SB_I_* flags */
+	unsigned long				s_magic;
+	struct dentry				*s_root;
+	struct rw_semaphore			s_umount;
+	int					s_count;
+	atomic_t				s_active;
+#ifdef CONFIG_SECURITY
+	void					*s_security;
+#endif
+	const struct xattr_handler		*const *s_xattr;
+#ifdef CONFIG_FS_ENCRYPTION
+	const struct fscrypt_operations		*s_cop;
+	struct fscrypt_keyring			*s_master_keys; /* master crypto keys in use */
+#endif
+#ifdef CONFIG_FS_VERITY
+	const struct fsverity_operations	*s_vop;
+#endif
+#if IS_ENABLED(CONFIG_UNICODE)
+	struct unicode_map			*s_encoding;
+	__u16					s_encoding_flags;
+#endif
+	struct hlist_bl_head			s_roots;	/* alternate root dentries for NFS */
+	struct mount				*s_mounts;	/* list of mounts; _not_ for fs use */
+	struct block_device			*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
+	struct file				*s_bdev_file;
+	struct backing_dev_info 		*s_bdi;
+	struct mtd_info				*s_mtd;
+	struct hlist_node			s_instances;
+	unsigned int				s_quota_types;	/* Bitmask of supported quota types */
+	struct quota_info			s_dquot;	/* Diskquota specific options */
+
+	struct sb_writers			s_writers;
+
+	/*
+	 * Keep s_fs_info, s_time_gran, s_fsnotify_mask, and
+	 * s_fsnotify_info together for cache efficiency. They are frequently
+	 * accessed and rarely modified.
+	 */
+	void					*s_fs_info;	/* Filesystem private info */
+
+	/* Granularity of c/m/atime in ns (cannot be worse than a second) */
+	u32					s_time_gran;
+	/* Time limits for c/m/atime in seconds */
+	time64_t				s_time_min;
+	time64_t		   		s_time_max;
+#ifdef CONFIG_FSNOTIFY
+	u32					s_fsnotify_mask;
+	struct fsnotify_sb_info			*s_fsnotify_info;
+#endif
+
+	/*
+	 * q: why are s_id and s_sysfs_name not the same? both are human
+	 * readable strings that identify the filesystem
+	 * a: s_id is allowed to change at runtime; it's used in log messages,
+	 * and we want to when a device starts out as single device (s_id is dev
+	 * name) but then a device is hot added and we have to switch to
+	 * identifying it by UUID
+	 * but s_sysfs_name is a handle for programmatic access, and can't
+	 * change at runtime
+	 */
+	char					s_id[32];	/* Informational name */
+	uuid_t					s_uuid;		/* UUID */
+	u8					s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
+
+	/* if set, fs shows up under sysfs at /sys/fs/$FSTYP/s_sysfs_name */
+	char					s_sysfs_name[UUID_STRING_LEN + 1];
+
+	unsigned int				s_max_links;
+	unsigned int				s_d_flags;	/* default d_flags for dentries */
+
+	/*
+	 * The next field is for VFS *only*. No filesystems have any business
+	 * even looking at it. You had been warned.
+	 */
+	struct mutex				s_vfs_rename_mutex;	/* Kludge */
+
+	/*
+	 * Filesystem subtype.  If non-empty the filesystem type field
+	 * in /proc/mounts will be "type.subtype"
+	 */
+	const char				*s_subtype;
+
+	const struct dentry_operations		*__s_d_op; /* default d_op for dentries */
+
+	struct shrinker				*s_shrink;	/* per-sb shrinker handle */
+
+	/* Number of inodes with nlink == 0 but still referenced */
+	atomic_long_t				s_remove_count;
+
+	/* Read-only state of the superblock is being changed */
+	int					s_readonly_remount;
+
+	/* per-sb errseq_t for reporting writeback errors via syncfs */
+	errseq_t s_wb_err;
+
+	/* AIO completions deferred from interrupt context */
+	struct workqueue_struct			*s_dio_done_wq;
+	struct hlist_head			s_pins;
+
+	/*
+	 * Owning user namespace and default context in which to
+	 * interpret filesystem uids, gids, quotas, device nodes,
+	 * xattrs and security labels.
+	 */
+	struct user_namespace			*s_user_ns;
+
+	/*
+	 * The list_lru structure is essentially just a pointer to a table
+	 * of per-node lru lists, each of which has its own spinlock.
+	 * There is no need to put them into separate cachelines.
+	 */
+	struct list_lru				s_dentry_lru;
+	struct list_lru				s_inode_lru;
+	struct rcu_head				rcu;
+	struct work_struct			destroy_work;
+
+	struct mutex				s_sync_lock;	/* sync serialisation lock */
+
+	/*
+	 * Indicates how deep in a filesystem stack this SB is
+	 */
+	int s_stack_depth;
+
+	/* s_inode_list_lock protects s_inodes */
+	spinlock_t				s_inode_list_lock ____cacheline_aligned_in_smp;
+	struct list_head			s_inodes;	/* all inodes */
+
+	spinlock_t				s_inode_wblist_lock;
+	struct list_head			s_inodes_wb;	/* writeback inodes */
+} __randomize_layout;
+
+/*
+ * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
+ * represented in both.
+ */
+#define SB_RDONLY       BIT(0)	/* Mount read-only */
+#define SB_NOSUID       BIT(1)	/* Ignore suid and sgid bits */
+#define SB_NODEV        BIT(2)	/* Disallow access to device special files */
+#define SB_NOEXEC       BIT(3)	/* Disallow program execution */
+#define SB_SYNCHRONOUS  BIT(4)	/* Writes are synced at once */
+#define SB_MANDLOCK     BIT(6)	/* Allow mandatory locks on an FS */
+#define SB_DIRSYNC      BIT(7)	/* Directory modifications are synchronous */
+#define SB_NOATIME      BIT(10)	/* Do not update access times. */
+#define SB_NODIRATIME   BIT(11)	/* Do not update directory access times */
+#define SB_SILENT       BIT(15)
+#define SB_POSIXACL     BIT(16)	/* Supports POSIX ACLs */
+#define SB_INLINECRYPT  BIT(17)	/* Use blk-crypto for encrypted files */
+#define SB_KERNMOUNT    BIT(22)	/* this is a kern_mount call */
+#define SB_I_VERSION    BIT(23)	/* Update inode I_version field */
+#define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
+
+/* These sb flags are internal to the kernel */
+#define SB_DEAD         BIT(21)
+#define SB_DYING        BIT(24)
+#define SB_FORCE        BIT(27)
+#define SB_NOSEC        BIT(28)
+#define SB_BORN         BIT(29)
+#define SB_ACTIVE       BIT(30)
+#define SB_NOUSER       BIT(31)
+
+/* These flags relate to encoding and casefolding */
+#define SB_ENC_STRICT_MODE_FL		(1 << 0)
+#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
+
+#define sb_has_strict_encoding(sb) \
+	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
+
+#if IS_ENABLED(CONFIG_UNICODE)
+#define sb_no_casefold_compat_fallback(sb) \
+	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
+#else
+#define sb_no_casefold_compat_fallback(sb) (1)
+#endif
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
+#define SB_I_EVM_HMAC_UNSUPPORTED	0x00000080
+
+#define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
+#define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
+#define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
+#define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
+#define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
+#define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
+#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
+
+#endif /* _LINUX_FS_SUPER_TYPES_H */

-- 
2.47.3


