Return-Path: <linux-fsdevel+bounces-9777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9565844D13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA163B34DF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40415151466;
	Wed, 31 Jan 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkg3ICda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732215146D;
	Wed, 31 Jan 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742323; cv=none; b=m1ZQ0G1lmm9q/12qEf4RfbVs0DMKj/o/hwKo5zT0KlBHI6S86ThKvdKtT9AEB8L8vMgf9Ex2/GZbuku9XSauAAnfIyNIdQeohJoZUDr5vFOmhJ8v3i1Phwh8w+Z+Sfh08vDN9c+EjLaebzzheyYBIzuMiU72MmEx5KJKIOONhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742323; c=relaxed/simple;
	bh=4WgMeK/Ywl+CBcUw6cg1uMRUFpYa3LU1t+XAsoYMMYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SyxEXakkLLLuu4EhRDSQWBfi2mxrTR5x5ukrZ2y3W+gGWuR9KMbuNwdihUVArZcE/HW3uM+znbgflmg9rqUHzKMRrcj/LmWl7J7gs50y2HETM3HpIixG5XJ72BkiW1jXcmkCKhl+jXIR69nKcbtFPrt/YjSB3EDAxbypwua0f2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkg3ICda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E508C433B1;
	Wed, 31 Jan 2024 23:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742323;
	bh=4WgMeK/Ywl+CBcUw6cg1uMRUFpYa3LU1t+XAsoYMMYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rkg3ICdadYvWnzBsfJgVALO3ygoPVrFCQdYYewPCwwsZMgH3BouMm9u4IV9UB5lXO
	 8xFv0rqMCfU/JsxBwbTrxnB8wxq1nojLcG5WcvaLMvdaJcx5CiPMMK8Xg46TdS53Ch
	 S3vyNgeVN2ZxIBFUhedQ0RLfS8SVAeNGie+6lm6qXE9db/vSeAJWOO1TuhR5EFewRo
	 OEbK1/rK/hXavixeTA3/wJ6IOT86TBmZCDuiNhwORteh7bOVv/auC9f9tbm1gM/724
	 9F+EXJdoSGsS1n3Vh8pgE6XFaCtRQSgwmzwG17oSQacFPoLGqYBgPX1xA770HLb+W7
	 YEfyyAj4AfG3A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:28 -0500
Subject: [PATCH v3 47/47] filelock: split leases out of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-47-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=31843; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4WgMeK/Ywl+CBcUw6cg1uMRUFpYa3LU1t+XAsoYMMYU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutF0AqHnXMgFUDi6kxoWex1VxcrzqtqfoAzqY
 2LTLawzTreJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRdAAKCRAADmhBGVaC
 FSWOD/98fHoHEQs/Ola91TSP/O2r+/KvzrRwaaMkz0s44GuwGLXWWRqyaP3XeDoBDekxZxxRsgy
 GmIOGCTeUJ5Nr8n76mQLLQrI3mpA7cmBGQ1jP0fmDOCTamjhPId7nzr1Pxmgi2v+YXE0EjdQ3hr
 +UXh8gQ1oiiEFcqYFCk/oWMq6BsB/JTm5QFPcbWDbgdu+4rbUFZoREZN53Qgjdy23egvKhpVq5y
 5inGD7j+0rqWSHAjUkvykcQ0d6FYK54E/fyjW6TG48J0agNeIUgoIa5vdUc/5A/CaByTrgMI38H
 g9zAMHpjN+M3WqtVQIzgjz/SbFbkBrbov86MyPHInNpdLVKINbjDttQNXMnVa5O99GnZHEgIOTx
 kHxrPHWfv/9JhuzYFnTwA0EDvygxSsoFTVW4N5wU4ulclntNmhvYeELU08dJGT5pSHy+PVsF9Am
 g5BlCgiOX3SN1+4Tlo8I75U/teU1TI34fiXVciSjZvg/LaQEkPN4vOfJWi9vcD7KC2m81kTTwIO
 Prue9GmIFLW05jgNcOHKmcN9bXsH/52y04RsZNRWzW5jOhFppqD/LKUtEbJBKSIwwyrL9g7RgyF
 2kAKxKxFmhvfRbLksiuwi45LNyiHRlNDalDrnpJDnGbGGf+rDdgbpKGPPjFdltXvEdArzqKX75T
 B/b3ex9CW5NQsNQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new struct file_lease and move the lease-specific fields from
struct file_lock to it. Convert the appropriate API calls to take
struct file_lease instead, and convert the callers to use them.

There is zero overlap between the lock manager operations for file
locks and the ones for file leases, so split the lease-related
operations off into a new lease_manager_operations struct.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/libfs.c                      |   2 +-
 fs/locks.c                      | 123 ++++++++++++++++++++++++++--------------
 fs/nfs/nfs4_fs.h                |   2 +-
 fs/nfs/nfs4file.c               |   2 +-
 fs/nfs/nfs4proc.c               |   4 +-
 fs/nfsd/nfs4layouts.c           |  17 +++---
 fs/nfsd/nfs4state.c             |  27 ++++-----
 fs/smb/client/cifsfs.c          |   2 +-
 include/linux/filelock.h        |  49 ++++++++++------
 include/linux/fs.h              |   5 +-
 include/trace/events/filelock.h |  18 +++---
 11 files changed, 153 insertions(+), 98 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..8b67cb4655d5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1580,7 +1580,7 @@ EXPORT_SYMBOL(alloc_anon_inode);
  * All arguments are ignored and it just returns -EINVAL.
  */
 int
-simple_nosetlease(struct file *filp, int arg, struct file_lock **flp,
+simple_nosetlease(struct file *filp, int arg, struct file_lease **flp,
 		  void **priv)
 {
 	return -EINVAL;
diff --git a/fs/locks.c b/fs/locks.c
index 1a4b01203d3d..33c7f4a8c729 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -74,12 +74,17 @@ static struct file_lock *file_lock(struct file_lock_core *flc)
 	return container_of(flc, struct file_lock, c);
 }
 
-static bool lease_breaking(struct file_lock *fl)
+static struct file_lease *file_lease(struct file_lock_core *flc)
+{
+	return container_of(flc, struct file_lease, c);
+}
+
+static bool lease_breaking(struct file_lease *fl)
 {
 	return fl->c.flc_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
 }
 
-static int target_leasetype(struct file_lock *fl)
+static int target_leasetype(struct file_lease *fl)
 {
 	if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 		return F_UNLCK;
@@ -166,6 +171,7 @@ static DEFINE_SPINLOCK(blocked_lock_lock);
 
 static struct kmem_cache *flctx_cache __ro_after_init;
 static struct kmem_cache *filelock_cache __ro_after_init;
+static struct kmem_cache *filelease_cache __ro_after_init;
 
 static struct file_lock_context *
 locks_get_lock_context(struct inode *inode, int type)
@@ -275,6 +281,18 @@ struct file_lock *locks_alloc_lock(void)
 }
 EXPORT_SYMBOL_GPL(locks_alloc_lock);
 
+/* Allocate an empty lock structure. */
+struct file_lease *locks_alloc_lease(void)
+{
+	struct file_lease *fl = kmem_cache_zalloc(filelease_cache, GFP_KERNEL);
+
+	if (fl)
+		locks_init_lock_heads(&fl->c);
+
+	return fl;
+}
+EXPORT_SYMBOL_GPL(locks_alloc_lease);
+
 void locks_release_private(struct file_lock *fl)
 {
 	struct file_lock_core *flc = &fl->c;
@@ -336,15 +354,25 @@ void locks_free_lock(struct file_lock *fl)
 }
 EXPORT_SYMBOL(locks_free_lock);
 
+/* Free a lease which is not in use. */
+void locks_free_lease(struct file_lease *fl)
+{
+	kmem_cache_free(filelease_cache, fl);
+}
+EXPORT_SYMBOL(locks_free_lease);
+
 static void
 locks_dispose_list(struct list_head *dispose)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
 	while (!list_empty(dispose)) {
-		fl = list_first_entry(dispose, struct file_lock, c.flc_list);
-		list_del_init(&fl->c.flc_list);
-		locks_free_lock(fl);
+		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
+		list_del_init(&flc->flc_list);
+		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
+			locks_free_lease(file_lease(flc));
+		else
+			locks_free_lock(file_lock(flc));
 	}
 }
 
@@ -355,6 +383,13 @@ void locks_init_lock(struct file_lock *fl)
 }
 EXPORT_SYMBOL(locks_init_lock);
 
+void locks_init_lease(struct file_lease *fl)
+{
+	memset(fl, 0, sizeof(*fl));
+	locks_init_lock_heads(&fl->c);
+}
+EXPORT_SYMBOL(locks_init_lease);
+
 /*
  * Initialize a new lock from an existing file_lock structure.
  */
@@ -518,14 +553,14 @@ static int flock_to_posix_lock(struct file *filp, struct file_lock *fl,
 
 /* default lease lock manager operations */
 static bool
-lease_break_callback(struct file_lock *fl)
+lease_break_callback(struct file_lease *fl)
 {
 	kill_fasync(&fl->fl_fasync, SIGIO, POLL_MSG);
 	return false;
 }
 
 static void
-lease_setup(struct file_lock *fl, void **priv)
+lease_setup(struct file_lease *fl, void **priv)
 {
 	struct file *filp = fl->c.flc_file;
 	struct fasync_struct *fa = *priv;
@@ -541,7 +576,7 @@ lease_setup(struct file_lock *fl, void **priv)
 	__f_setown(filp, task_pid(current), PIDTYPE_TGID, 0);
 }
 
-static const struct lock_manager_operations lease_manager_ops = {
+static const struct lease_manager_operations lease_manager_ops = {
 	.lm_break = lease_break_callback,
 	.lm_change = lease_modify,
 	.lm_setup = lease_setup,
@@ -550,7 +585,7 @@ static const struct lock_manager_operations lease_manager_ops = {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, int type, struct file_lock *fl)
+static int lease_init(struct file *filp, int type, struct file_lease *fl)
 {
 	if (assign_type(&fl->c, type) != 0)
 		return -EINVAL;
@@ -560,17 +595,14 @@ static int lease_init(struct file *filp, int type, struct file_lock *fl)
 
 	fl->c.flc_file = filp;
 	fl->c.flc_flags = FL_LEASE;
-	fl->fl_start = 0;
-	fl->fl_end = OFFSET_MAX;
-	fl->fl_ops = NULL;
 	fl->fl_lmops = &lease_manager_ops;
 	return 0;
 }
 
 /* Allocate a file_lock initialised to this type of lease */
-static struct file_lock *lease_alloc(struct file *filp, int type)
+static struct file_lease *lease_alloc(struct file *filp, int type)
 {
-	struct file_lock *fl = locks_alloc_lock();
+	struct file_lease *fl = locks_alloc_lease();
 	int error = -ENOMEM;
 
 	if (fl == NULL)
@@ -578,7 +610,7 @@ static struct file_lock *lease_alloc(struct file *filp, int type)
 
 	error = lease_init(filp, type, fl);
 	if (error) {
-		locks_free_lock(fl);
+		locks_free_lease(fl);
 		return ERR_PTR(error);
 	}
 	return fl;
@@ -1395,7 +1427,7 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 	return error;
 }
 
-static void lease_clear_pending(struct file_lock *fl, int arg)
+static void lease_clear_pending(struct file_lease *fl, int arg)
 {
 	switch (arg) {
 	case F_UNLCK:
@@ -1407,7 +1439,7 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 }
 
 /* We already had a lease on this file; just change its type */
-int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
+int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
 {
 	int error = assign_type(&fl->c, arg);
 
@@ -1442,7 +1474,7 @@ static bool past_time(unsigned long then)
 static void time_out_leases(struct inode *inode, struct list_head *dispose)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
-	struct file_lock *fl, *tmp;
+	struct file_lease *fl, *tmp;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
@@ -1458,8 +1490,8 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 static bool leases_conflict(struct file_lock_core *lc, struct file_lock_core *bc)
 {
 	bool rc;
-	struct file_lock *lease = file_lock(lc);
-	struct file_lock *breaker = file_lock(bc);
+	struct file_lease *lease = file_lease(lc);
+	struct file_lease *breaker = file_lease(bc);
 
 	if (lease->fl_lmops->lm_breaker_owns_lease
 			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
@@ -1480,7 +1512,7 @@ static bool leases_conflict(struct file_lock_core *lc, struct file_lock_core *bc
 }
 
 static bool
-any_leases_conflict(struct inode *inode, struct file_lock *breaker)
+any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
 	struct file_lock_core *flc;
@@ -1511,7 +1543,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 {
 	int error = 0;
 	struct file_lock_context *ctx;
-	struct file_lock *new_fl, *fl, *tmp;
+	struct file_lease *new_fl, *fl, *tmp;
 	unsigned long break_time;
 	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
@@ -1571,7 +1603,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	}
 
 restart:
-	fl = list_first_entry(&ctx->flc_lease, struct file_lock, c.flc_list);
+	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
 	break_time = fl->fl_break_time;
 	if (break_time != 0)
 		break_time -= jiffies;
@@ -1590,7 +1622,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	trace_break_lease_unblock(inode, new_fl);
-	locks_delete_block(new_fl);
+	__locks_delete_block(&new_fl->c);
 	if (error >= 0) {
 		/*
 		 * Wait for the next conflicting lease that has not been
@@ -1607,7 +1639,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	percpu_up_read(&file_rwsem);
 	locks_dispose_list(&dispose);
 free_lock:
-	locks_free_lock(new_fl);
+	locks_free_lease(new_fl);
 	return error;
 }
 EXPORT_SYMBOL(__break_lease);
@@ -1625,14 +1657,14 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 {
 	bool has_lease = false;
 	struct file_lock_context *ctx;
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
 	ctx = locks_inode_context(inode);
 	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
 		spin_lock(&ctx->flc_lock);
-		fl = list_first_entry_or_null(&ctx->flc_lease,
-					      struct file_lock, c.flc_list);
-		if (fl && lock_is_write(fl))
+		flc = list_first_entry_or_null(&ctx->flc_lease,
+					       struct file_lock_core, flc_list);
+		if (flc && flc->flc_type == F_WRLCK)
 			has_lease = true;
 		spin_unlock(&ctx->flc_lock);
 	}
@@ -1667,7 +1699,7 @@ EXPORT_SYMBOL(lease_get_mtime);
  */
 int fcntl_getlease(struct file *filp)
 {
-	struct file_lock *fl;
+	struct file_lease *fl;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	int type = F_UNLCK;
@@ -1739,9 +1771,9 @@ check_conflicting_open(struct file *filp, const int arg, int flags)
 }
 
 static int
-generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **priv)
+generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **priv)
 {
-	struct file_lock *fl, *my_fl = NULL, *lease;
+	struct file_lease *fl, *my_fl = NULL, *lease;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	bool is_deleg = (*flp)->c.flc_flags & FL_DELEG;
@@ -1850,7 +1882,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 static int generic_delete_lease(struct file *filp, void *owner)
 {
 	int error = -EAGAIN;
-	struct file_lock *fl, *victim = NULL;
+	struct file_lease *fl, *victim = NULL;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	LIST_HEAD(dispose);
@@ -1890,7 +1922,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
  *	The (input) flp->fl_lmops->lm_break function is required
  *	by break_lease().
  */
-int generic_setlease(struct file *filp, int arg, struct file_lock **flp,
+int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
 	struct inode *inode = file_inode(filp);
@@ -1937,7 +1969,7 @@ lease_notifier_chain_init(void)
 }
 
 static inline void
-setlease_notifier(int arg, struct file_lock *lease)
+setlease_notifier(int arg, struct file_lease *lease)
 {
 	if (arg != F_UNLCK)
 		srcu_notifier_call_chain(&lease_notifier_chain, arg, lease);
@@ -1973,7 +2005,7 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
  * may be NULL if the lm_setup operation doesn't require it.
  */
 int
-vfs_setlease(struct file *filp, int arg, struct file_lock **lease, void **priv)
+vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 {
 	if (lease)
 		setlease_notifier(arg, *lease);
@@ -1986,7 +2018,7 @@ EXPORT_SYMBOL_GPL(vfs_setlease);
 
 static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
 {
-	struct file_lock *fl;
+	struct file_lease *fl;
 	struct fasync_struct *new;
 	int error;
 
@@ -1996,14 +2028,14 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
 
 	new = fasync_alloc();
 	if (!new) {
-		locks_free_lock(fl);
+		locks_free_lease(fl);
 		return -ENOMEM;
 	}
 	new->fa_fd = fd;
 
 	error = vfs_setlease(filp, arg, &fl, (void **)&new);
 	if (fl)
-		locks_free_lock(fl);
+		locks_free_lease(fl);
 	if (new)
 		fasync_free(new);
 	return error;
@@ -2626,7 +2658,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 static void
 locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 {
-	struct file_lock *fl, *tmp;
+	struct file_lease *fl, *tmp;
 	LIST_HEAD(dispose);
 
 	if (list_empty(&ctx->flc_lease))
@@ -2755,14 +2787,16 @@ static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
 	} else if (flc->flc_flags & FL_FLOCK) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
 	} else if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
-		type = target_leasetype(fl);
+		struct file_lease *lease = file_lease(flc);
+
+		type = target_leasetype(lease);
 
 		if (flc->flc_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
 			seq_puts(f, "LEASE  ");
 
-		if (lease_breaking(fl))
+		if (lease_breaking(lease))
 			seq_puts(f, "BREAKING  ");
 		else if (flc->flc_file)
 			seq_puts(f, "ACTIVE    ");
@@ -2945,6 +2979,9 @@ static int __init filelock_init(void)
 	filelock_cache = kmem_cache_create("file_lock_cache",
 			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
 
+	filelease_cache = kmem_cache_create("file_lock_cache",
+			sizeof(struct file_lease), 0, SLAB_PANIC, NULL);
+
 	for_each_possible_cpu(i) {
 		struct file_lock_list_struct *fll = per_cpu_ptr(&file_lock_list, i);
 
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 581698f1b7b2..6ff41ceb9f1c 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -330,7 +330,7 @@ extern int update_open_stateid(struct nfs4_state *state,
 				const nfs4_stateid *deleg_stateid,
 				fmode_t fmode);
 extern int nfs4_proc_setlease(struct file *file, int arg,
-			      struct file_lock **lease, void **priv);
+			      struct file_lease **lease, void **priv);
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
 		struct nfs_fsinfo *fsinfo);
 extern void nfs4_update_changeattr(struct inode *dir,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e238abc78a13..1cd9652f3c28 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -439,7 +439,7 @@ void nfs42_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */
 
-static int nfs4_setlease(struct file *file, int arg, struct file_lock **lease,
+static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
 			 void **priv)
 {
 	return nfs4_proc_setlease(file, arg, lease, priv);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91dddcd79004..815996cb27fc 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7604,7 +7604,7 @@ static int nfs4_delete_lease(struct file *file, void **priv)
 	return generic_setlease(file, F_UNLCK, NULL, priv);
 }
 
-static int nfs4_add_lease(struct file *file, int arg, struct file_lock **lease,
+static int nfs4_add_lease(struct file *file, int arg, struct file_lease **lease,
 			  void **priv)
 {
 	struct inode *inode = file_inode(file);
@@ -7622,7 +7622,7 @@ static int nfs4_add_lease(struct file *file, int arg, struct file_lock **lease,
 	return -EAGAIN;
 }
 
-int nfs4_proc_setlease(struct file *file, int arg, struct file_lock **lease,
+int nfs4_proc_setlease(struct file *file, int arg, struct file_lease **lease,
 		       void **priv)
 {
 	switch (arg) {
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index daae68e526e0..4fa21b74a981 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -25,7 +25,7 @@ static struct kmem_cache *nfs4_layout_cache;
 static struct kmem_cache *nfs4_layout_stateid_cache;
 
 static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
-static const struct lock_manager_operations nfsd4_layouts_lm_ops;
+static const struct lease_manager_operations nfsd4_layouts_lm_ops;
 
 const struct nfsd4_layout_ops *nfsd4_layout_ops[LAYOUT_TYPE_MAX] =  {
 #ifdef CONFIG_NFSD_FLEXFILELAYOUT
@@ -182,20 +182,19 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 static int
 nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 {
-	struct file_lock *fl;
+	struct file_lease *fl;
 	int status;
 
 	if (nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
 		return 0;
 
-	fl = locks_alloc_lock();
+	fl = locks_alloc_lease();
 	if (!fl)
 		return -ENOMEM;
-	locks_init_lock(fl);
+	locks_init_lease(fl);
 	fl->fl_lmops = &nfsd4_layouts_lm_ops;
 	fl->c.flc_flags = FL_LAYOUT;
 	fl->c.flc_type = F_RDLCK;
-	fl->fl_end = OFFSET_MAX;
 	fl->c.flc_owner = ls;
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = ls->ls_file->nf_file;
@@ -203,7 +202,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 	status = vfs_setlease(fl->c.flc_file, fl->c.flc_type, &fl,
 			      NULL);
 	if (status) {
-		locks_free_lock(fl);
+		locks_free_lease(fl);
 		return status;
 	}
 	BUG_ON(fl != NULL);
@@ -724,7 +723,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_layout_ops = {
 };
 
 static bool
-nfsd4_layout_lm_break(struct file_lock *fl)
+nfsd4_layout_lm_break(struct file_lease *fl)
 {
 	/*
 	 * We don't want the locks code to timeout the lease for us;
@@ -737,14 +736,14 @@ nfsd4_layout_lm_break(struct file_lock *fl)
 }
 
 static int
-nfsd4_layout_lm_change(struct file_lock *onlist, int arg,
+nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 		struct list_head *dispose)
 {
 	BUG_ON(!(arg & F_UNLCK));
 	return lease_modify(onlist, arg, dispose);
 }
 
-static const struct lock_manager_operations nfsd4_layouts_lm_ops = {
+static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
 	.lm_break	= nfsd4_layout_lm_break,
 	.lm_change	= nfsd4_layout_lm_change,
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4a1d462209cd..441b1d08894e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4922,7 +4922,7 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 
 /* Called from break_lease() with flc_lock held. */
 static bool
-nfsd_break_deleg_cb(struct file_lock *fl)
+nfsd_break_deleg_cb(struct file_lease *fl)
 {
 	struct nfs4_delegation *dp = (struct nfs4_delegation *) fl->c.flc_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
@@ -4960,7 +4960,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
  *   %true: Lease conflict was resolved
  *   %false: Lease conflict was not resolved.
  */
-static bool nfsd_breaker_owns_lease(struct file_lock *fl)
+static bool nfsd_breaker_owns_lease(struct file_lease *fl)
 {
 	struct nfs4_delegation *dl = fl->c.flc_owner;
 	struct svc_rqst *rqst;
@@ -4977,7 +4977,7 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 }
 
 static int
-nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
+nfsd_change_deleg_cb(struct file_lease *onlist, int arg,
 		     struct list_head *dispose)
 {
 	struct nfs4_delegation *dp = (struct nfs4_delegation *) onlist->c.flc_owner;
@@ -4991,7 +4991,7 @@ nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 		return -EAGAIN;
 }
 
-static const struct lock_manager_operations nfsd_lease_mng_ops = {
+static const struct lease_manager_operations nfsd_lease_mng_ops = {
 	.lm_breaker_owns_lease = nfsd_breaker_owns_lease,
 	.lm_break = nfsd_break_deleg_cb,
 	.lm_change = nfsd_change_deleg_cb,
@@ -5331,18 +5331,17 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
 	return clp->cl_minorversion && clp->cl_cb_state == NFSD4_CB_UNKNOWN;
 }
 
-static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
+static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 						int flag)
 {
-	struct file_lock *fl;
+	struct file_lease *fl;
 
-	fl = locks_alloc_lock();
+	fl = locks_alloc_lease();
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
 	fl->c.flc_flags = FL_DELEG;
 	fl->c.flc_type = flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK;
-	fl->fl_end = OFFSET_MAX;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
@@ -5463,7 +5462,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf = NULL;
-	struct file_lock *fl;
+	struct file_lease *fl;
 	u32 dl_type;
 
 	/*
@@ -5536,7 +5535,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	status = vfs_setlease(fp->fi_deleg_file->nf_file,
 			      fl->c.flc_type, &fl, NULL);
 	if (fl)
-		locks_free_lock(fl);
+		locks_free_lease(fl);
 	if (status)
 		goto out_clnt_odstate;
 
@@ -8453,7 +8452,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 {
 	__be32 status;
 	struct file_lock_context *ctx;
-	struct file_lock *fl;
+	struct file_lease *fl;
 	struct nfs4_delegation *dp;
 
 	ctx = locks_inode_context(inode);
@@ -8461,6 +8460,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 		return 0;
 	spin_lock(&ctx->flc_lock);
 	for_each_file_lock(fl, &ctx->flc_lease) {
+		unsigned char type = fl->c.flc_type;
+
 		if (fl->c.flc_flags == FL_LAYOUT)
 			continue;
 		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
@@ -8469,11 +8470,11 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 			 * we are done; there isn't any write delegation
 			 * on this inode
 			 */
-			if (lock_is_read(fl))
+			if (type == F_RDLCK)
 				break;
 			goto break_lease;
 		}
-		if (lock_is_write(fl)) {
+		if (type == F_WRLCK) {
 			dp = fl->c.flc_owner;
 			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
 				spin_unlock(&ctx->flc_lock);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2a4a4e3a8751..d2a9a52c867f 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1085,7 +1085,7 @@ static loff_t cifs_llseek(struct file *file, loff_t offset, int whence)
 }
 
 static int
-cifs_setlease(struct file *file, int arg, struct file_lock **lease, void **priv)
+cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv)
 {
 	/*
 	 * Note that this is called by vfs setlease with i_lock held to
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index ceadd979e110..4a5ad26962c1 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -27,6 +27,7 @@
 #define FILE_LOCK_DEFERRED 1
 
 struct file_lock;
+struct file_lease;
 
 struct file_lock_operations {
 	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
@@ -39,14 +40,17 @@ struct lock_manager_operations {
 	void (*lm_put_owner)(fl_owner_t);
 	void (*lm_notify)(struct file_lock *);	/* unblock callback */
 	int (*lm_grant)(struct file_lock *, int);
-	bool (*lm_break)(struct file_lock *);
-	int (*lm_change)(struct file_lock *, int, struct list_head *);
-	void (*lm_setup)(struct file_lock *, void **);
-	bool (*lm_breaker_owns_lease)(struct file_lock *);
 	bool (*lm_lock_expirable)(struct file_lock *cfl);
 	void (*lm_expire_lock)(void);
 };
 
+struct lease_manager_operations {
+	bool (*lm_break)(struct file_lease *);
+	int (*lm_change)(struct file_lease *, int, struct list_head *);
+	void (*lm_setup)(struct file_lease *, void **);
+	bool (*lm_breaker_owns_lease)(struct file_lease *);
+};
+
 struct lock_manager {
 	struct list_head list;
 	/*
@@ -110,11 +114,6 @@ struct file_lock {
 	loff_t fl_start;
 	loff_t fl_end;
 
-	struct fasync_struct *	fl_fasync; /* for lease break notifications */
-	/* for lease breaks: */
-	unsigned long fl_break_time;
-	unsigned long fl_downgrade_time;
-
 	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
 	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
 	union {
@@ -131,6 +130,15 @@ struct file_lock {
 	} fl_u;
 } __randomize_layout;
 
+struct file_lease {
+	struct file_lock_core c;
+	struct fasync_struct *	fl_fasync; /* for lease break notifications */
+	/* for lease breaks: */
+	unsigned long fl_break_time;
+	unsigned long fl_downgrade_time;
+	const struct lease_manager_operations *fl_lmops; /* Callbacks for lease managers */
+} __randomize_layout;
+
 struct file_lock_context {
 	spinlock_t		flc_lock;
 	struct list_head	flc_flock;
@@ -179,7 +187,7 @@ static inline void locks_wake_up(struct file_lock *fl)
 void locks_free_lock_context(struct inode *inode);
 void locks_free_lock(struct file_lock *fl);
 void locks_init_lock(struct file_lock *);
-struct file_lock * locks_alloc_lock(void);
+struct file_lock *locks_alloc_lock(void);
 void locks_copy_lock(struct file_lock *, struct file_lock *);
 void locks_copy_conflock(struct file_lock *, struct file_lock *);
 void locks_remove_posix(struct file *, fl_owner_t);
@@ -193,11 +201,15 @@ int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_l
 int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
 bool vfs_inode_has_locks(struct inode *inode);
 int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
+
+void locks_init_lease(struct file_lease *);
+void locks_free_lease(struct file_lease *fl);
+struct file_lease *locks_alloc_lease(void);
 int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
 void lease_get_mtime(struct inode *, struct timespec64 *time);
-int generic_setlease(struct file *, int, struct file_lock **, void **priv);
-int vfs_setlease(struct file *, int, struct file_lock **, void **);
-int lease_modify(struct file_lock *, int, struct list_head *);
+int generic_setlease(struct file *, int, struct file_lease **, void **priv);
+int vfs_setlease(struct file *, int, struct file_lease **, void **);
+int lease_modify(struct file_lease *, int, struct list_head *);
 
 struct notifier_block;
 int lease_register_notifier(struct notifier_block *);
@@ -261,6 +273,11 @@ static inline void locks_init_lock(struct file_lock *fl)
 	return;
 }
 
+static inline void locks_init_lease(struct file_lease *fl)
+{
+	return;
+}
+
 static inline void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
 {
 	return;
@@ -335,18 +352,18 @@ static inline void lease_get_mtime(struct inode *inode,
 }
 
 static inline int generic_setlease(struct file *filp, int arg,
-				    struct file_lock **flp, void **priv)
+				    struct file_lease **flp, void **priv)
 {
 	return -EINVAL;
 }
 
 static inline int vfs_setlease(struct file *filp, int arg,
-			       struct file_lock **lease, void **priv)
+			       struct file_lease **lease, void **priv)
 {
 	return -EINVAL;
 }
 
-static inline int lease_modify(struct file_lock *fl, int arg,
+static inline int lease_modify(struct file_lease *fl, int arg,
 			       struct list_head *dispose)
 {
 	return -EINVAL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..162877197bf1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1064,6 +1064,7 @@ struct file *get_file_active(struct file **f);
 typedef void *fl_owner_t;
 
 struct file_lock;
+struct file_lease;
 
 /* The following constant reflects the upper bound of the file/locking space */
 #ifndef OFFSET_MAX
@@ -2005,7 +2006,7 @@ struct file_operations {
 	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
 	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
 	void (*splice_eof)(struct file *file);
-	int (*setlease)(struct file *, int, struct file_lock **, void **);
+	int (*setlease)(struct file *, int, struct file_lease **, void **);
 	long (*fallocate)(struct file *file, int mode, loff_t offset,
 			  loff_t len);
 	void (*show_fdinfo)(struct seq_file *m, struct file *f);
@@ -3238,7 +3239,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
-extern int simple_nosetlease(struct file *, int, struct file_lock **, void **);
+extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index c778061c6249..b8d1e00a7982 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -117,12 +117,12 @@ DEFINE_EVENT(filelock_lock, flock_lock_inode,
 		TP_ARGS(inode, fl, ret));
 
 DECLARE_EVENT_CLASS(filelock_lease,
-	TP_PROTO(struct inode *inode, struct file_lock *fl),
+	TP_PROTO(struct inode *inode, struct file_lease *fl),
 
 	TP_ARGS(inode, fl),
 
 	TP_STRUCT__entry(
-		__field(struct file_lock *, fl)
+		__field(struct file_lease *, fl)
 		__field(unsigned long, i_ino)
 		__field(dev_t, s_dev)
 		__field(struct file_lock_core *, blocker)
@@ -153,23 +153,23 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->break_time, __entry->downgrade_time)
 );
 
-DEFINE_EVENT(filelock_lease, break_lease_noblock, TP_PROTO(struct inode *inode, struct file_lock *fl),
+DEFINE_EVENT(filelock_lease, break_lease_noblock, TP_PROTO(struct inode *inode, struct file_lease *fl),
 		TP_ARGS(inode, fl));
 
-DEFINE_EVENT(filelock_lease, break_lease_block, TP_PROTO(struct inode *inode, struct file_lock *fl),
+DEFINE_EVENT(filelock_lease, break_lease_block, TP_PROTO(struct inode *inode, struct file_lease *fl),
 		TP_ARGS(inode, fl));
 
-DEFINE_EVENT(filelock_lease, break_lease_unblock, TP_PROTO(struct inode *inode, struct file_lock *fl),
+DEFINE_EVENT(filelock_lease, break_lease_unblock, TP_PROTO(struct inode *inode, struct file_lease *fl),
 		TP_ARGS(inode, fl));
 
-DEFINE_EVENT(filelock_lease, generic_delete_lease, TP_PROTO(struct inode *inode, struct file_lock *fl),
+DEFINE_EVENT(filelock_lease, generic_delete_lease, TP_PROTO(struct inode *inode, struct file_lease *fl),
 		TP_ARGS(inode, fl));
 
-DEFINE_EVENT(filelock_lease, time_out_leases, TP_PROTO(struct inode *inode, struct file_lock *fl),
+DEFINE_EVENT(filelock_lease, time_out_leases, TP_PROTO(struct inode *inode, struct file_lease *fl),
 		TP_ARGS(inode, fl));
 
 TRACE_EVENT(generic_add_lease,
-	TP_PROTO(struct inode *inode, struct file_lock *fl),
+	TP_PROTO(struct inode *inode, struct file_lease *fl),
 
 	TP_ARGS(inode, fl),
 
@@ -204,7 +204,7 @@ TRACE_EVENT(generic_add_lease,
 );
 
 TRACE_EVENT(leases_conflict,
-	TP_PROTO(bool conflict, struct file_lock *lease, struct file_lock *breaker),
+	TP_PROTO(bool conflict, struct file_lease *lease, struct file_lease *breaker),
 
 	TP_ARGS(conflict, lease, breaker),
 

-- 
2.43.0


