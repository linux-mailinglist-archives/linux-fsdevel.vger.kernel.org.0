Return-Path: <linux-fsdevel+bounces-8115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE782F794
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569C5B23CB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A13CF51;
	Tue, 16 Jan 2024 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esBeGGdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040C82D98;
	Tue, 16 Jan 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434485; cv=none; b=eDkMvitPo098i+SoHZPF1hu6bSYOLfYm43IxlXKgMxNPEx2TTBQNYNiCJ49tXBFvekw7oEQMMq5bNfYvQYLqpqdynbE26yssr/d0C4NvjC3hVpZIOeT4+eUr6ITPXHR/CWLJfun9IxV9+CfveMyuIOSNgxzxbqM2VaAmAdDaJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434485; c=relaxed/simple;
	bh=tUgny3IKWhbScVuSTLV7DUCLBlNMDIBoYB+H+8vByek=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=Ijjr46swxTtkkyEmT5ZA7x5MrPRWyqH7eYitX4NWucYNJmwr8CXn239gQ4yJvYhqkbPakhELuKTQf2mNhP9N9zyn4KT21fTKvscClPLJTSZuSukjE3ui/BPjlrhHWtl7qUZ3gn02QV0XF7lvA1xwgOEuNb6R+HMSnn7D9S8BzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esBeGGdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCAEC433F1;
	Tue, 16 Jan 2024 19:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434485;
	bh=tUgny3IKWhbScVuSTLV7DUCLBlNMDIBoYB+H+8vByek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=esBeGGdEninZHvph53qN//97ESmW2HYfWhrFu7zRRzGq66gsFHoCtvnDXQaUpwNpU
	 v5MpOBDb3FK1gnycr/rm8PMcQSzkREvDuIfKg4QQM+n+eww23mHGBQ4sQE/E/a6w25
	 tLHS56E7ecolnIO4NqIBD9CaghHdnpCwc9b8wTpILaWJE4ElG5DS6LSeeWxFg0ybE7
	 tsuJEf5B4W9dqNX/ACQQ87/yY1/+a0Tnp2BCKnoXRabbXibmty1qcs0jA7WPJrVVDO
	 erOIyLKM5L72csfZhgl81y2mFnSM6PnrKwJ63i7rhik6ZWJoisdP2IbD6g4fibMeoU
	 OiAS2zJJVwWwA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:16 -0500
Subject: [PATCH 20/20] filelock: split leases out of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-20-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
In-Reply-To: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <lsahlber@redhat.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=32025; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tUgny3IKWhbScVuSTLV7DUCLBlNMDIBoYB+H+8vByek=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0i1dB3Oo3SpA6n32QmMmESoKqFsJEotRttN
 e3Un3ICfnyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIgAKCRAADmhBGVaC
 FSGEEACG4VI4KJIOEol/8Wvcq9bT8SZEY/46btJujElDZuyEB1QsZhwZYfaGpiWV5LUvSwM/OYV
 7wyzrlEYShy6Sm6QOgyapNYDTCEV26q+puaJv6XKC1DN6Yd5KEvcyWcIOm4TnHsH2QZyj2e8J3z
 F8Qti36s55qijnFc1btze7OBMwR3MFKcs7JGlEzrdDY+uThnQ2agTPY5vpS1+G1Uv1ASNyicWip
 ik0HyeqU6Zr4o0EohAIBh4pPJop0ehnGpX65rZlnjblpE3sENAQ95p50Nol/WhdBee3A3oOLJZq
 WXk1+4z1tLT+IF5i6uiWDfMM1/gl70Hh092YmAQAoPLXEb7l5eD71yapern6FlLjUhzVHLR6vuU
 QCs8lQujMCUnvt7ByIGCQuSz5HlL100KEUhowjpHKIE2ILk4ziAOlfEMUDffVSYyjrzfOo+KZ3c
 sz7JJWcTr+kB9EMKlpUfX+aUkbppSPNodEwWBaw/at4+NUsWGapn9Vw2wsCYpw1WR1UjHYhkE4z
 fIksLsuXTHcza7oct6zMJn3e16k5GfYA2P/KYw52jC7DivZi9FW6b8p9BnOoMp4jhwbKw31DE7d
 ADxp4+Ivs0s8gzkT+1uCsE2lBYZll7u2Bi4glmSe/7tPWKcPyiuTSCtn3Zda3kibx1BqL8zzTJ8
 n0lIX3KYCHdUBRg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new struct file_lease and move the lease-specific fields from
struct file_lock to it. Convert the appropriate API calls to take
struct file_lease instead, and convert the callers to use them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/libfs.c                      |   2 +-
 fs/locks.c                      | 130 ++++++++++++++++++++++++++--------------
 fs/nfs/nfs4_fs.h                |   2 +-
 fs/nfs/nfs4file.c               |   2 +-
 fs/nfs/nfs4proc.c               |   4 +-
 fs/nfsd/nfs4layouts.c           |  17 +++---
 fs/nfsd/nfs4state.c             |  21 ++++---
 fs/smb/client/cifsfs.c          |   2 +-
 include/linux/filelock.h        |  49 ++++++++++-----
 include/linux/fs.h              |   5 +-
 include/trace/events/filelock.h |  18 +++---
 11 files changed, 154 insertions(+), 98 deletions(-)

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
index 6d24cf2525ec..014cc984e295 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -92,17 +92,22 @@ static inline bool IS_LEASE(struct file_lock_core *flc)
 
 #define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <= 0)
 
-struct file_lock *file_lock(struct file_lock_core *flc)
+static struct file_lock *file_lock(struct file_lock_core *flc)
 {
 	return container_of(flc, struct file_lock, fl_core);
 }
 
-static bool lease_breaking(struct file_lock *fl)
+static struct file_lease *file_lease(struct file_lock_core *flc)
+{
+	return container_of(flc, struct file_lease, fl_core);
+}
+
+static bool lease_breaking(struct file_lease *fl)
 {
 	return fl->fl_core.fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
 }
 
-static int target_leasetype(struct file_lock *fl)
+static int target_leasetype(struct file_lease *fl)
 {
 	if (fl->fl_core.fl_flags & FL_UNLOCK_PENDING)
 		return F_UNLCK;
@@ -189,6 +194,7 @@ static DEFINE_SPINLOCK(blocked_lock_lock);
 
 static struct kmem_cache *flctx_cache __ro_after_init;
 static struct kmem_cache *filelock_cache __ro_after_init;
+static struct kmem_cache *filelease_cache __ro_after_init;
 
 static struct file_lock_context *
 locks_get_lock_context(struct inode *inode, int type)
@@ -298,6 +304,18 @@ struct file_lock *locks_alloc_lock(void)
 }
 EXPORT_SYMBOL_GPL(locks_alloc_lock);
 
+/* Allocate an empty lock structure. */
+struct file_lease *locks_alloc_lease(void)
+{
+	struct file_lease *fl = kmem_cache_zalloc(filelease_cache, GFP_KERNEL);
+
+	if (fl)
+		locks_init_lock_heads(&fl->fl_core);
+
+	return fl;
+}
+EXPORT_SYMBOL_GPL(locks_alloc_lease);
+
 void locks_release_private(struct file_lock *fl)
 {
 	struct file_lock_core *flc = &fl->fl_core;
@@ -359,15 +377,25 @@ void locks_free_lock(struct file_lock *fl)
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
-		fl = list_first_entry(dispose, struct file_lock, fl_core.fl_list);
-		list_del_init(&fl->fl_core.fl_list);
-		locks_free_lock(fl);
+		flc = list_first_entry(dispose, struct file_lock_core, fl_list);
+		list_del_init(&flc->fl_list);
+		if (IS_LEASE(flc))
+			locks_free_lease(file_lease(flc));
+		else
+			locks_free_lock(file_lock(flc));
 	}
 }
 
@@ -378,6 +406,13 @@ void locks_init_lock(struct file_lock *fl)
 }
 EXPORT_SYMBOL(locks_init_lock);
 
+void locks_init_lease(struct file_lease *fl)
+{
+	memset(fl, 0, sizeof(*fl));
+	locks_init_lock_heads(&fl->fl_core);
+}
+EXPORT_SYMBOL(locks_init_lease);
+
 /*
  * Initialize a new lock from an existing file_lock structure.
  */
@@ -541,14 +576,14 @@ static int flock_to_posix_lock(struct file *filp, struct file_lock *fl,
 
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
 	struct file *filp = fl->fl_core.fl_file;
 	struct fasync_struct *fa = *priv;
@@ -564,7 +599,7 @@ lease_setup(struct file_lock *fl, void **priv)
 	__f_setown(filp, task_pid(current), PIDTYPE_TGID, 0);
 }
 
-static const struct lock_manager_operations lease_manager_ops = {
+static const struct lease_manager_operations lease_manager_ops = {
 	.lm_break = lease_break_callback,
 	.lm_change = lease_modify,
 	.lm_setup = lease_setup,
@@ -573,7 +608,7 @@ static const struct lock_manager_operations lease_manager_ops = {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, int type, struct file_lock *fl)
+static int lease_init(struct file *filp, int type, struct file_lease *fl)
 {
 	if (assign_type(&fl->fl_core, type) != 0)
 		return -EINVAL;
@@ -583,17 +618,14 @@ static int lease_init(struct file *filp, int type, struct file_lock *fl)
 
 	fl->fl_core.fl_file = filp;
 	fl->fl_core.fl_flags = FL_LEASE;
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
@@ -601,7 +633,7 @@ static struct file_lock *lease_alloc(struct file *filp, int type)
 
 	error = lease_init(filp, type, fl);
 	if (error) {
-		locks_free_lock(fl);
+		locks_free_lease(fl);
 		return ERR_PTR(error);
 	}
 	return fl;
@@ -1418,7 +1450,7 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 	return error;
 }
 
-static void lease_clear_pending(struct file_lock *fl, int arg)
+static void lease_clear_pending(struct file_lease *fl, int arg)
 {
 	switch (arg) {
 	case F_UNLCK:
@@ -1430,7 +1462,7 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 }
 
 /* We already had a lease on this file; just change its type */
-int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
+int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
 {
 	int error = assign_type(&fl->fl_core, arg);
 
@@ -1465,7 +1497,7 @@ static bool past_time(unsigned long then)
 static void time_out_leases(struct inode *inode, struct list_head *dispose)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
-	struct file_lock *fl, *tmp;
+	struct file_lease *fl, *tmp;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
@@ -1481,8 +1513,8 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 static bool leases_conflict(struct file_lock_core *lc, struct file_lock_core *bc)
 {
 	bool rc;
-	struct file_lock *lease = file_lock(lc);
-	struct file_lock *breaker = file_lock(bc);
+	struct file_lease *lease = file_lease(lc);
+	struct file_lease *breaker = file_lease(bc);
 
 	if (lease->fl_lmops->lm_breaker_owns_lease
 			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
@@ -1503,7 +1535,7 @@ static bool leases_conflict(struct file_lock_core *lc, struct file_lock_core *bc
 }
 
 static bool
-any_leases_conflict(struct inode *inode, struct file_lock *breaker)
+any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
 	struct file_lock_core *flc;
@@ -1534,7 +1566,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 {
 	int error = 0;
 	struct file_lock_context *ctx;
-	struct file_lock *new_fl, *fl, *tmp;
+	struct file_lease *new_fl, *fl, *tmp;
 	unsigned long break_time;
 	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
@@ -1594,7 +1626,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	}
 
 restart:
-	fl = list_first_entry(&ctx->flc_lease, struct file_lock, fl_core.fl_list);
+	fl = list_first_entry(&ctx->flc_lease, struct file_lease, fl_core.fl_list);
 	break_time = fl->fl_break_time;
 	if (break_time != 0)
 		break_time -= jiffies;
@@ -1613,7 +1645,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	trace_break_lease_unblock(inode, new_fl);
-	locks_delete_block(new_fl);
+	__locks_delete_block(&new_fl->fl_core);
 	if (error >= 0) {
 		/*
 		 * Wait for the next conflicting lease that has not been
@@ -1630,7 +1662,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	percpu_up_read(&file_rwsem);
 	locks_dispose_list(&dispose);
 free_lock:
-	locks_free_lock(new_fl);
+	locks_free_lease(new_fl);
 	return error;
 }
 EXPORT_SYMBOL(__break_lease);
@@ -1648,13 +1680,13 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 {
 	bool has_lease = false;
 	struct file_lock_context *ctx;
-	struct file_lock *fl;
+	struct file_lease *fl;
 
 	ctx = locks_inode_context(inode);
 	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
 		spin_lock(&ctx->flc_lock);
 		fl = list_first_entry_or_null(&ctx->flc_lease,
-					      struct file_lock, fl_core.fl_list);
+					      struct file_lease, fl_core.fl_list);
 		if (fl && (fl->fl_core.fl_type == F_WRLCK))
 			has_lease = true;
 		spin_unlock(&ctx->flc_lock);
@@ -1690,7 +1722,7 @@ EXPORT_SYMBOL(lease_get_mtime);
  */
 int fcntl_getlease(struct file *filp)
 {
-	struct file_lock *fl;
+	struct file_lease *fl;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	int type = F_UNLCK;
@@ -1762,9 +1794,9 @@ check_conflicting_open(struct file *filp, const int arg, int flags)
 }
 
 static int
-generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **priv)
+generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **priv)
 {
-	struct file_lock *fl, *my_fl = NULL, *lease;
+	struct file_lease *fl, *my_fl = NULL, *lease;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	bool is_deleg = (*flp)->fl_core.fl_flags & FL_DELEG;
@@ -1873,7 +1905,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 static int generic_delete_lease(struct file *filp, void *owner)
 {
 	int error = -EAGAIN;
-	struct file_lock *fl, *victim = NULL;
+	struct file_lease *fl, *victim = NULL;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	LIST_HEAD(dispose);
@@ -1913,7 +1945,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
  *	The (input) flp->fl_lmops->lm_break function is required
  *	by break_lease().
  */
-int generic_setlease(struct file *filp, int arg, struct file_lock **flp,
+int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
 	struct inode *inode = file_inode(filp);
@@ -1960,7 +1992,7 @@ lease_notifier_chain_init(void)
 }
 
 static inline void
-setlease_notifier(int arg, struct file_lock *lease)
+setlease_notifier(int arg, struct file_lease *lease)
 {
 	if (arg != F_UNLCK)
 		srcu_notifier_call_chain(&lease_notifier_chain, arg, lease);
@@ -1996,7 +2028,7 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
  * may be NULL if the lm_setup operation doesn't require it.
  */
 int
-vfs_setlease(struct file *filp, int arg, struct file_lock **lease, void **priv)
+vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 {
 	if (lease)
 		setlease_notifier(arg, *lease);
@@ -2009,7 +2041,7 @@ EXPORT_SYMBOL_GPL(vfs_setlease);
 
 static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
 {
-	struct file_lock *fl;
+	struct file_lease *fl;
 	struct fasync_struct *new;
 	int error;
 
@@ -2019,14 +2051,14 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
 
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
@@ -2646,7 +2678,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 static void
 locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 {
-	struct file_lock *fl, *tmp;
+	struct file_lease *fl, *tmp;
 	LIST_HEAD(dispose);
 
 	if (list_empty(&ctx->flc_lease))
@@ -2744,7 +2776,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
-	int type;
+	int type = fl->fl_core.fl_type;
 
 	fl_pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2761,6 +2793,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (repeat)
 		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
 
+
 	if (IS_POSIX(&fl->fl_core)) {
 		if (fl->fl_core.fl_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
@@ -2774,21 +2807,25 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else if (IS_FLOCK(&fl->fl_core)) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
 	} else if (IS_LEASE(&fl->fl_core)) {
-		if (fl->fl_core.fl_flags & FL_DELEG)
+		struct file_lease *lease = file_lease(&fl->fl_core);
+
+		type = target_leasetype(lease);
+
+		if (lease->fl_core.fl_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
 			seq_puts(f, "LEASE  ");
 
-		if (lease_breaking(fl))
+		if (lease_breaking(lease))
 			seq_puts(f, "BREAKING  ");
-		else if (fl->fl_core.fl_file)
+		else if (lease->fl_core.fl_file)
 			seq_puts(f, "ACTIVE    ");
 		else
 			seq_puts(f, "BREAKER   ");
 	} else {
 		seq_puts(f, "UNKNOWN UNKNOWN  ");
 	}
-	type = IS_LEASE(&fl->fl_core) ? target_leasetype(fl) : fl->fl_core.fl_type;
+
 
 	seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
 			     (type == F_RDLCK) ? "READ" : "UNLCK");
@@ -2964,6 +3001,9 @@ static int __init filelock_init(void)
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
index a5596007b4d9..e2ef04e88603 100644
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
index 4bef3349bd90..7726aca7ad52 100644
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
 	fl->fl_core.fl_flags = FL_LAYOUT;
 	fl->fl_core.fl_type = F_RDLCK;
-	fl->fl_end = OFFSET_MAX;
 	fl->fl_core.fl_owner = ls;
 	fl->fl_core.fl_pid = current->tgid;
 	fl->fl_core.fl_file = ls->ls_file->nf_file;
@@ -203,7 +202,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 	status = vfs_setlease(fl->fl_core.fl_file, fl->fl_core.fl_type, &fl,
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
index cf5d0b3a553f..8b394f8a14c5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4922,7 +4922,7 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 
 /* Called from break_lease() with flc_lock held. */
 static bool
-nfsd_break_deleg_cb(struct file_lock *fl)
+nfsd_break_deleg_cb(struct file_lease *fl)
 {
 	struct nfs4_delegation *dp = (struct nfs4_delegation *) fl->fl_core.fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
@@ -4960,7 +4960,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
  *   %true: Lease conflict was resolved
  *   %false: Lease conflict was not resolved.
  */
-static bool nfsd_breaker_owns_lease(struct file_lock *fl)
+static bool nfsd_breaker_owns_lease(struct file_lease *fl)
 {
 	struct nfs4_delegation *dl = fl->fl_core.fl_owner;
 	struct svc_rqst *rqst;
@@ -4977,7 +4977,7 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 }
 
 static int
-nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
+nfsd_change_deleg_cb(struct file_lease *onlist, int arg,
 		     struct list_head *dispose)
 {
 	struct nfs4_delegation *dp = (struct nfs4_delegation *) onlist->fl_core.fl_owner;
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
 	fl->fl_core.fl_flags = FL_DELEG;
 	fl->fl_core.fl_type = flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK;
-	fl->fl_end = OFFSET_MAX;
 	fl->fl_core.fl_owner = (fl_owner_t)dp;
 	fl->fl_core.fl_pid = current->tgid;
 	fl->fl_core.fl_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
@@ -5463,7 +5462,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf = NULL;
-	struct file_lock *fl;
+	struct file_lease *fl;
 	u32 dl_type;
 
 	/*
@@ -5536,7 +5535,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_core.fl_type,
 			      &fl, NULL);
 	if (fl)
-		locks_free_lock(fl);
+		locks_free_lease(fl);
 	if (status)
 		goto out_clnt_odstate;
 
@@ -8449,7 +8448,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 {
 	__be32 status;
 	struct file_lock_context *ctx;
-	struct file_lock *fl;
+	struct file_lease *fl;
 	struct nfs4_delegation *dp;
 
 	ctx = locks_inode_context(inode);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 99b0ade833aa..d053c15d06b3 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1084,7 +1084,7 @@ static loff_t cifs_llseek(struct file *file, loff_t offset, int whence)
 }
 
 static int
-cifs_setlease(struct file *file, int arg, struct file_lock **lease, void **priv)
+cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv)
 {
 	/*
 	 * Note that this is called by vfs setlease with i_lock held to
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 9cf1ee3efeda..fcb3f7e86270 100644
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
+	struct file_lock_core fl_core;
+	struct fasync_struct *	fl_fasync; /* for lease break notifications */
+	/* for lease breaks: */
+	unsigned long fl_break_time;
+	unsigned long fl_downgrade_time;
+	const struct lease_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
+} __randomize_layout;
+
 struct file_lock_context {
 	spinlock_t		flc_lock;
 	struct list_head	flc_flock;
@@ -156,7 +164,7 @@ int fcntl_getlease(struct file *filp);
 void locks_free_lock_context(struct inode *inode);
 void locks_free_lock(struct file_lock *fl);
 void locks_init_lock(struct file_lock *);
-struct file_lock * locks_alloc_lock(void);
+struct file_lock *locks_alloc_lock(void);
 void locks_copy_lock(struct file_lock *, struct file_lock *);
 void locks_copy_conflock(struct file_lock *, struct file_lock *);
 void locks_remove_posix(struct file *, fl_owner_t);
@@ -170,11 +178,15 @@ int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_l
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
@@ -238,6 +250,11 @@ static inline void locks_init_lock(struct file_lock *fl)
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
@@ -312,18 +329,18 @@ static inline void lease_get_mtime(struct inode *inode,
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
index e6ba0cc6f2ee..07b73e5c8f55 100644
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
index 49263b69215e..344753e43aa4 100644
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
 		__field(struct file_lock_core *, fl_blocker)
@@ -153,23 +153,23 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl_break_time, __entry->fl_downgrade_time)
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


