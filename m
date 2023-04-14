Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F0E6E26E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDNP0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDNP0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:26:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEFDCD323;
        Fri, 14 Apr 2023 08:26:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 283E5152B;
        Fri, 14 Apr 2023 08:26:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D5CF3F6C4;
        Fri, 14 Apr 2023 08:25:14 -0700 (PDT)
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-morello@op-lists.linaro.org
Subject: [PATCH v2 2/5] fs: Pass argument to fcntl_setlease as int
Date:   Fri, 14 Apr 2023 16:24:56 +0100
Message-Id: <20230414152459.816046-3-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
References: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The interface for fcntl expects the argument passed for the command
F_SETLEASE to be of type int. The current code wrongly treats it as
a long. In order to avoid access to undefined bits, we should explicitly
cast the argument to int.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
Cc: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Laight <David.Laight@ACULAB.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Cc: linux-morello@op-lists.linaro.org
Signed-off-by: Luca Vizzarro <Luca.Vizzarro@arm.com>
---
 fs/cifs/cifsfs.c         |  2 +-
 fs/libfs.c               |  2 +-
 fs/locks.c               | 20 ++++++++++----------
 fs/nfs/nfs4_fs.h         |  2 +-
 fs/nfs/nfs4file.c        |  2 +-
 fs/nfs/nfs4proc.c        |  4 ++--
 include/linux/filelock.h | 12 ++++++------
 include/linux/fs.h       |  4 ++--
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index ac9034fce409..ad5b2cfe8320 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1069,7 +1069,7 @@ static loff_t cifs_llseek(struct file *file, loff_t offset, int whence)
 }
 
 static int
-cifs_setlease(struct file *file, long arg, struct file_lock **lease, void **priv)
+cifs_setlease(struct file *file, int arg, struct file_lock **lease, void **priv)
 {
 	/*
 	 * Note that this is called by vfs setlease with i_lock held to
diff --git a/fs/libfs.c b/fs/libfs.c
index 4eda519c3002..1c451e76560c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1274,7 +1274,7 @@ EXPORT_SYMBOL(alloc_anon_inode);
  * All arguments are ignored and it just returns -EINVAL.
  */
 int
-simple_nosetlease(struct file *filp, long arg, struct file_lock **flp,
+simple_nosetlease(struct file *filp, int arg, struct file_lock **flp,
 		  void **priv)
 {
 	return -EINVAL;
diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..265b5190db3e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -438,7 +438,7 @@ static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
 	fl->fl_end = OFFSET_MAX;
 }
 
-static int assign_type(struct file_lock *fl, long type)
+static int assign_type(struct file_lock *fl, int type)
 {
 	switch (type) {
 	case F_RDLCK:
@@ -549,7 +549,7 @@ static const struct lock_manager_operations lease_manager_ops = {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, long type, struct file_lock *fl)
+static int lease_init(struct file *filp, int type, struct file_lock *fl)
 {
 	if (assign_type(fl, type) != 0)
 		return -EINVAL;
@@ -567,7 +567,7 @@ static int lease_init(struct file *filp, long type, struct file_lock *fl)
 }
 
 /* Allocate a file_lock initialised to this type of lease */
-static struct file_lock *lease_alloc(struct file *filp, long type)
+static struct file_lock *lease_alloc(struct file *filp, int type)
 {
 	struct file_lock *fl = locks_alloc_lock();
 	int error = -ENOMEM;
@@ -1666,7 +1666,7 @@ int fcntl_getlease(struct file *filp)
  * conflict with the lease we're trying to set.
  */
 static int
-check_conflicting_open(struct file *filp, const long arg, int flags)
+check_conflicting_open(struct file *filp, const int arg, int flags)
 {
 	struct inode *inode = file_inode(filp);
 	int self_wcount = 0, self_rcount = 0;
@@ -1701,7 +1701,7 @@ check_conflicting_open(struct file *filp, const long arg, int flags)
 }
 
 static int
-generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **priv)
+generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **priv)
 {
 	struct file_lock *fl, *my_fl = NULL, *lease;
 	struct inode *inode = file_inode(filp);
@@ -1859,7 +1859,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
  *	The (input) flp->fl_lmops->lm_break function is required
  *	by break_lease().
  */
-int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
+int generic_setlease(struct file *filp, int arg, struct file_lock **flp,
 			void **priv)
 {
 	struct inode *inode = file_inode(filp);
@@ -1906,7 +1906,7 @@ lease_notifier_chain_init(void)
 }
 
 static inline void
-setlease_notifier(long arg, struct file_lock *lease)
+setlease_notifier(int arg, struct file_lock *lease)
 {
 	if (arg != F_UNLCK)
 		srcu_notifier_call_chain(&lease_notifier_chain, arg, lease);
@@ -1942,7 +1942,7 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
  * may be NULL if the lm_setup operation doesn't require it.
  */
 int
-vfs_setlease(struct file *filp, long arg, struct file_lock **lease, void **priv)
+vfs_setlease(struct file *filp, int arg, struct file_lock **lease, void **priv)
 {
 	if (lease)
 		setlease_notifier(arg, *lease);
@@ -1953,7 +1953,7 @@ vfs_setlease(struct file *filp, long arg, struct file_lock **lease, void **priv)
 }
 EXPORT_SYMBOL_GPL(vfs_setlease);
 
-static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
+static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
 {
 	struct file_lock *fl;
 	struct fasync_struct *new;
@@ -1988,7 +1988,7 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
  *	Note that you also need to call %F_SETSIG to
  *	receive a signal when the lease is broken.
  */
-int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
+int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 {
 	if (arg == F_UNLCK)
 		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 4c9f8bd866ab..47c5c1f86d66 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -328,7 +328,7 @@ extern int update_open_stateid(struct nfs4_state *state,
 				const nfs4_stateid *open_stateid,
 				const nfs4_stateid *deleg_stateid,
 				fmode_t fmode);
-extern int nfs4_proc_setlease(struct file *file, long arg,
+extern int nfs4_proc_setlease(struct file *file, int arg,
 			      struct file_lock **lease, void **priv);
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
 		struct nfs_fsinfo *fsinfo);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 2563ed8580f3..26c2d3539d75 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -438,7 +438,7 @@ void nfs42_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */
 
-static int nfs4_setlease(struct file *file, long arg, struct file_lock **lease,
+static int nfs4_setlease(struct file *file, int arg, struct file_lock **lease,
 			 void **priv)
 {
 	return nfs4_proc_setlease(file, arg, lease, priv);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5607b1e2b821..ba59ad558209 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7559,7 +7559,7 @@ static int nfs4_delete_lease(struct file *file, void **priv)
 	return generic_setlease(file, F_UNLCK, NULL, priv);
 }
 
-static int nfs4_add_lease(struct file *file, long arg, struct file_lock **lease,
+static int nfs4_add_lease(struct file *file, int arg, struct file_lock **lease,
 			  void **priv)
 {
 	struct inode *inode = file_inode(file);
@@ -7577,7 +7577,7 @@ static int nfs4_add_lease(struct file *file, long arg, struct file_lock **lease,
 	return -EAGAIN;
 }
 
-int nfs4_proc_setlease(struct file *file, long arg, struct file_lock **lease,
+int nfs4_proc_setlease(struct file *file, int arg, struct file_lock **lease,
 		       void **priv)
 {
 	switch (arg) {
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index efcdd1631d9b..95e868e09e29 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -144,7 +144,7 @@ int fcntl_setlk64(unsigned int, struct file *, unsigned int,
 			struct flock64 *);
 #endif
 
-int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
+int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
 int fcntl_getlease(struct file *filp);
 
 /* fs/locks.c */
@@ -167,8 +167,8 @@ bool vfs_inode_has_locks(struct inode *inode);
 int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
 int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
-int generic_setlease(struct file *, long, struct file_lock **, void **priv);
-int vfs_setlease(struct file *, long, struct file_lock **, void **);
+int generic_setlease(struct file *, int, struct file_lock **, void **priv);
+int vfs_setlease(struct file *, int, struct file_lock **, void **);
 int lease_modify(struct file_lock *, int, struct list_head *);
 
 struct notifier_block;
@@ -213,7 +213,7 @@ static inline int fcntl_setlk64(unsigned int fd, struct file *file,
 	return -EACCES;
 }
 #endif
-static inline int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
+static inline int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 {
 	return -EINVAL;
 }
@@ -306,13 +306,13 @@ static inline void lease_get_mtime(struct inode *inode,
 	return;
 }
 
-static inline int generic_setlease(struct file *filp, long arg,
+static inline int generic_setlease(struct file *filp, int arg,
 				    struct file_lock **flp, void **priv)
 {
 	return -EINVAL;
 }
 
-static inline int vfs_setlease(struct file *filp, long arg,
+static inline int vfs_setlease(struct file *filp, int arg,
 			       struct file_lock **lease, void **priv)
 {
 	return -EINVAL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8da79822dbba..0c9367980636 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1779,7 +1779,7 @@ struct file_operations {
 	int (*flock) (struct file *, int, struct file_lock *);
 	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
 	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
-	int (*setlease)(struct file *, long, struct file_lock **, void **);
+	int (*setlease)(struct file *, int, struct file_lock **, void **);
 	long (*fallocate)(struct file *file, int mode, loff_t offset,
 			  loff_t len);
 	void (*show_fdinfo)(struct seq_file *m, struct file *f);
@@ -2914,7 +2914,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
-extern int simple_nosetlease(struct file *, long, struct file_lock **, void **);
+extern int simple_nosetlease(struct file *, int, struct file_lock **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
-- 
2.34.1

