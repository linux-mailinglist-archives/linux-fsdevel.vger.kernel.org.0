Return-Path: <linux-fsdevel+bounces-9748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB2844C19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0F6B26250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E312FF73;
	Wed, 31 Jan 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8YhFEGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1B3BB46;
	Wed, 31 Jan 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742208; cv=none; b=O3Qr2GRNlXVJB/2cwBvdxn18ejTCC7beNabJCDRg7s5eFVrNA5yZ/AVeLXC1tAchIL3BPAsQ1790LuZzyl0mjhQ6W5b6VvWjIRVOA9olZWHNo+pQG2daJxlCMCgACxK0R6ObkBjGH0qQonS20VB6o7gv+mTSCCmpZ+RTEdMb9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742208; c=relaxed/simple;
	bh=0lhMVSXXMONSuk1xhogptefh4pl+qGIVtZIWq2RWjiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KG4070Am9rVLenb13kxUSwDm/n7LFgo+BgoaC5LSNeire/dDszxcj/3/12pe9FKkkXvmdEX210yh3PoEukHOUzPzdxo0Edg7Ag70wIMa8IUYv4J/8BQ4gCzGWV6ttc3oofqpwAuVlXbYjs9jWGeEeNsd9YwiZM/N/fwBlS6WXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8YhFEGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155C0C43394;
	Wed, 31 Jan 2024 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742207;
	bh=0lhMVSXXMONSuk1xhogptefh4pl+qGIVtZIWq2RWjiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t8YhFEGzJv/H7PXeq9reTe5j2K1skK8w3n8s3NUbIk9r90GbZ9ukyKkpzKYYeIu5m
	 umUY2lU3DZt8poZHJaGBQ2hIb5QskekpotYjKNCgK1Q8Tyow+BGmpOXeoX6H97CpCH
	 5HToSdLnBz4nZSBO5M7dM1q45sSYltSUP18nW+iNPy0FSeTCYlxWxuedCk3ggZ1O/g
	 HmT3Xpg1d0eBqJdA148vuJKudiVmSvYTG1r9jSPCnsVUpPhij9wr5sSpDEeAm9v0Fy
	 xjB49sPdkrv6ZMlG5E6xfcdL8DJ5Tw8JUt2KnuNmKmZXOLx5XUyYZDSy7cx+wXboae
	 I/GbrKkSv+TmA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:59 -0500
Subject: [PATCH v3 18/47] filelock: have fs/locks.c deal with
 file_lock_core directly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-18-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=49673; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0lhMVSXXMONSuk1xhogptefh4pl+qGIVtZIWq2RWjiQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFwtfOzGYwCaRgz6O/DyaKWUjvWVthZjzcz1
 jYBl14uexuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 FW8eD/0XdLPz8aqu5KUAsQJmpawLdcDp+iJ5cMScKagTpkdkZ3R4eQ08ey79G/o4IUdCRJiKB1q
 +2V9ITmyjnfxj2Qhy80Tlod+gBCvghGfLg4n6qn2ayxNCVP/ScSQLIJBAc/qKB/vqLqwlqWLTI2
 7ksrfhPduJs17vz16HOk2F1Sf0Qwp3xcMxw+Lr0qIla1iCUJhLNJU1SEH2q9V1gvzBph24WZvns
 /f0Ih7VX+2rok0pDn2lGucXTO9WqQwM4y2Nt3ay6pOWsSk+2bVtvEq2Hqcyx7aWArgR/BauDQPA
 XXV6OLUxsP+lbZYicJpmZBkMUizBduyCcdC2b7aSiYdEupdkZ0lMvSObnsywECCKQwJto+vfsID
 d7EOXB/QFjbWJY+2bwJF2kEVWiL5lBUeh+E4jVW0xHaY23j4GwI7K/Tc2GIwjFG+fFgSSiqauje
 e0MpKd+A5qpQmI8NYq01f6V4hF0680mevvJ9pmHzDKel5WXQOxiBuu3DaDayDV7k9HV4Wvy0b4r
 Oi+6nLhW+FiuXDuKgCVEANhi6VbMPufvhfGPIGlRSPGfZzMTdYz/NqpdntGzuZmfFJ4pqOHq4D2
 9eYdNwC3cdCZTwDjXUlXIFi+YrCkAG7CBg7kWKUJax8iCmA4Lfa05IJ1xBK3dZ0ExDYZUhVj1zi
 /g3RDC+WKv7s4lw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert fs/locks.c to access fl_core fields direcly rather than using
the backward-compatibility macros. Most of this was done with
coccinelle, with a few by-hand fixups.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      | 467 ++++++++++++++++++++--------------------
 include/trace/events/filelock.h |  32 +--
 2 files changed, 254 insertions(+), 245 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 097254ab35d3..f418c6e31219 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -48,8 +48,6 @@
  * children.
  *
  */
-#define _NEED_FILE_LOCK_FIELD_MACROS
-
 #include <linux/capability.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
@@ -73,16 +71,16 @@
 
 static bool lease_breaking(struct file_lock *fl)
 {
-	return fl->fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
+	return fl->c.flc_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
 }
 
 static int target_leasetype(struct file_lock *fl)
 {
-	if (fl->fl_flags & FL_UNLOCK_PENDING)
+	if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 		return F_UNLCK;
-	if (fl->fl_flags & FL_DOWNGRADE_PENDING)
+	if (fl->c.flc_flags & FL_DOWNGRADE_PENDING)
 		return F_RDLCK;
-	return fl->fl_type;
+	return fl->c.flc_type;
 }
 
 static int leases_enable = 1;
@@ -201,8 +199,10 @@ locks_dump_ctx_list(struct list_head *list, char *list_type)
 {
 	struct file_lock *fl;
 
-	list_for_each_entry(fl, list, fl_list) {
-		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
+	list_for_each_entry(fl, list, c.flc_list) {
+		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type,
+			fl->c.flc_owner, fl->c.flc_flags,
+			fl->c.flc_type, fl->c.flc_pid);
 	}
 }
 
@@ -230,13 +230,14 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
 	struct file_lock *fl;
 	struct inode *inode = file_inode(filp);
 
-	list_for_each_entry(fl, list, fl_list)
-		if (fl->fl_file == filp)
+	list_for_each_entry(fl, list, c.flc_list)
+		if (fl->c.flc_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
 				list_type, MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino,
-				fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
+				fl->c.flc_owner, fl->c.flc_flags,
+				fl->c.flc_type, fl->c.flc_pid);
 }
 
 void
@@ -250,13 +251,13 @@ locks_free_lock_context(struct inode *inode)
 	}
 }
 
-static void locks_init_lock_heads(struct file_lock *fl)
+static void locks_init_lock_heads(struct file_lock_core *flc)
 {
-	INIT_HLIST_NODE(&fl->fl_link);
-	INIT_LIST_HEAD(&fl->fl_list);
-	INIT_LIST_HEAD(&fl->fl_blocked_requests);
-	INIT_LIST_HEAD(&fl->fl_blocked_member);
-	init_waitqueue_head(&fl->fl_wait);
+	INIT_HLIST_NODE(&flc->flc_link);
+	INIT_LIST_HEAD(&flc->flc_list);
+	INIT_LIST_HEAD(&flc->flc_blocked_requests);
+	INIT_LIST_HEAD(&flc->flc_blocked_member);
+	init_waitqueue_head(&flc->flc_wait);
 }
 
 /* Allocate an empty lock structure. */
@@ -265,7 +266,7 @@ struct file_lock *locks_alloc_lock(void)
 	struct file_lock *fl = kmem_cache_zalloc(filelock_cache, GFP_KERNEL);
 
 	if (fl)
-		locks_init_lock_heads(fl);
+		locks_init_lock_heads(&fl->c);
 
 	return fl;
 }
@@ -273,11 +274,11 @@ EXPORT_SYMBOL_GPL(locks_alloc_lock);
 
 void locks_release_private(struct file_lock *fl)
 {
-	BUG_ON(waitqueue_active(&fl->fl_wait));
-	BUG_ON(!list_empty(&fl->fl_list));
-	BUG_ON(!list_empty(&fl->fl_blocked_requests));
-	BUG_ON(!list_empty(&fl->fl_blocked_member));
-	BUG_ON(!hlist_unhashed(&fl->fl_link));
+	BUG_ON(waitqueue_active(&fl->c.flc_wait));
+	BUG_ON(!list_empty(&fl->c.flc_list));
+	BUG_ON(!list_empty(&fl->c.flc_blocked_requests));
+	BUG_ON(!list_empty(&fl->c.flc_blocked_member));
+	BUG_ON(!hlist_unhashed(&fl->c.flc_link));
 
 	if (fl->fl_ops) {
 		if (fl->fl_ops->fl_release_private)
@@ -287,8 +288,8 @@ void locks_release_private(struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_put_owner) {
-			fl->fl_lmops->lm_put_owner(fl->fl_owner);
-			fl->fl_owner = NULL;
+			fl->fl_lmops->lm_put_owner(fl->c.flc_owner);
+			fl->c.flc_owner = NULL;
 		}
 		fl->fl_lmops = NULL;
 	}
@@ -310,10 +311,10 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 	struct file_lock *fl;
 
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
-		if (fl->fl_owner != owner)
+	list_for_each_entry(fl, &flctx->flc_posix, c.flc_list) {
+		if (fl->c.flc_owner != owner)
 			continue;
-		if (!list_empty(&fl->fl_blocked_requests)) {
+		if (!list_empty(&fl->c.flc_blocked_requests)) {
 			spin_unlock(&flctx->flc_lock);
 			return true;
 		}
@@ -337,8 +338,8 @@ locks_dispose_list(struct list_head *dispose)
 	struct file_lock *fl;
 
 	while (!list_empty(dispose)) {
-		fl = list_first_entry(dispose, struct file_lock, fl_list);
-		list_del_init(&fl->fl_list);
+		fl = list_first_entry(dispose, struct file_lock, c.flc_list);
+		list_del_init(&fl->c.flc_list);
 		locks_free_lock(fl);
 	}
 }
@@ -346,7 +347,7 @@ locks_dispose_list(struct list_head *dispose)
 void locks_init_lock(struct file_lock *fl)
 {
 	memset(fl, 0, sizeof(struct file_lock));
-	locks_init_lock_heads(fl);
+	locks_init_lock_heads(&fl->c);
 }
 EXPORT_SYMBOL(locks_init_lock);
 
@@ -355,11 +356,11 @@ EXPORT_SYMBOL(locks_init_lock);
  */
 void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
 {
-	new->fl_owner = fl->fl_owner;
-	new->fl_pid = fl->fl_pid;
-	new->fl_file = NULL;
-	new->fl_flags = fl->fl_flags;
-	new->fl_type = fl->fl_type;
+	new->c.flc_owner = fl->c.flc_owner;
+	new->c.flc_pid = fl->c.flc_pid;
+	new->c.flc_file = NULL;
+	new->c.flc_flags = fl->c.flc_flags;
+	new->c.flc_type = fl->c.flc_type;
 	new->fl_start = fl->fl_start;
 	new->fl_end = fl->fl_end;
 	new->fl_lmops = fl->fl_lmops;
@@ -367,7 +368,7 @@ void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_get_owner)
-			fl->fl_lmops->lm_get_owner(fl->fl_owner);
+			fl->fl_lmops->lm_get_owner(fl->c.flc_owner);
 	}
 }
 EXPORT_SYMBOL(locks_copy_conflock);
@@ -379,7 +380,7 @@ void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 
 	locks_copy_conflock(new, fl);
 
-	new->fl_file = fl->fl_file;
+	new->c.flc_file = fl->c.flc_file;
 	new->fl_ops = fl->fl_ops;
 
 	if (fl->fl_ops) {
@@ -398,12 +399,14 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 	 * ->fl_blocked_requests, so we don't need a lock to check if it
 	 * is empty.
 	 */
-	if (list_empty(&fl->fl_blocked_requests))
+	if (list_empty(&fl->c.flc_blocked_requests))
 		return;
 	spin_lock(&blocked_lock_lock);
-	list_splice_init(&fl->fl_blocked_requests, &new->fl_blocked_requests);
-	list_for_each_entry(f, &new->fl_blocked_requests, fl_blocked_member)
-		f->fl_blocker = new;
+	list_splice_init(&fl->c.flc_blocked_requests,
+			 &new->c.flc_blocked_requests);
+	list_for_each_entry(f, &new->c.flc_blocked_requests,
+			    c.flc_blocked_member)
+		f->c.flc_blocker = new;
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -424,11 +427,11 @@ static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
 {
 	locks_init_lock(fl);
 
-	fl->fl_file = filp;
-	fl->fl_owner = filp;
-	fl->fl_pid = current->tgid;
-	fl->fl_flags = FL_FLOCK;
-	fl->fl_type = type;
+	fl->c.flc_file = filp;
+	fl->c.flc_owner = filp;
+	fl->c.flc_pid = current->tgid;
+	fl->c.flc_flags = FL_FLOCK;
+	fl->c.flc_type = type;
 	fl->fl_end = OFFSET_MAX;
 }
 
@@ -438,7 +441,7 @@ static int assign_type(struct file_lock *fl, int type)
 	case F_RDLCK:
 	case F_WRLCK:
 	case F_UNLCK:
-		fl->fl_type = type;
+		fl->c.flc_type = type;
 		break;
 	default:
 		return -EINVAL;
@@ -483,10 +486,10 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
 	} else
 		fl->fl_end = OFFSET_MAX;
 
-	fl->fl_owner = current->files;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = filp;
-	fl->fl_flags = FL_POSIX;
+	fl->c.flc_owner = current->files;
+	fl->c.flc_pid = current->tgid;
+	fl->c.flc_file = filp;
+	fl->c.flc_flags = FL_POSIX;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -520,7 +523,7 @@ lease_break_callback(struct file_lock *fl)
 static void
 lease_setup(struct file_lock *fl, void **priv)
 {
-	struct file *filp = fl->fl_file;
+	struct file *filp = fl->c.flc_file;
 	struct fasync_struct *fa = *priv;
 
 	/*
@@ -548,11 +551,11 @@ static int lease_init(struct file *filp, int type, struct file_lock *fl)
 	if (assign_type(fl, type) != 0)
 		return -EINVAL;
 
-	fl->fl_owner = filp;
-	fl->fl_pid = current->tgid;
+	fl->c.flc_owner = filp;
+	fl->c.flc_pid = current->tgid;
 
-	fl->fl_file = filp;
-	fl->fl_flags = FL_LEASE;
+	fl->c.flc_file = filp;
+	fl->c.flc_flags = FL_LEASE;
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
@@ -590,7 +593,7 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
  */
 static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
-	return fl1->fl_owner == fl2->fl_owner;
+	return fl1->c.flc_owner == fl2->c.flc_owner;
 }
 
 /* Must be called with the flc_lock held! */
@@ -601,8 +604,8 @@ static void locks_insert_global_locks(struct file_lock *fl)
 	percpu_rwsem_assert_held(&file_rwsem);
 
 	spin_lock(&fll->lock);
-	fl->fl_link_cpu = smp_processor_id();
-	hlist_add_head(&fl->fl_link, &fll->hlist);
+	fl->c.flc_link_cpu = smp_processor_id();
+	hlist_add_head(&fl->c.flc_link, &fll->hlist);
 	spin_unlock(&fll->lock);
 }
 
@@ -618,33 +621,34 @@ static void locks_delete_global_locks(struct file_lock *fl)
 	 * is done while holding the flc_lock, and new insertions into the list
 	 * also require that it be held.
 	 */
-	if (hlist_unhashed(&fl->fl_link))
+	if (hlist_unhashed(&fl->c.flc_link))
 		return;
 
-	fll = per_cpu_ptr(&file_lock_list, fl->fl_link_cpu);
+	fll = per_cpu_ptr(&file_lock_list, fl->c.flc_link_cpu);
 	spin_lock(&fll->lock);
-	hlist_del_init(&fl->fl_link);
+	hlist_del_init(&fl->c.flc_link);
 	spin_unlock(&fll->lock);
 }
 
 static unsigned long
 posix_owner_key(struct file_lock *fl)
 {
-	return (unsigned long)fl->fl_owner;
+	return (unsigned long) fl->c.flc_owner;
 }
 
 static void locks_insert_global_blocked(struct file_lock *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_add(blocked_hash, &waiter->fl_link, posix_owner_key(waiter));
+	hash_add(blocked_hash, &waiter->c.flc_link,
+		 posix_owner_key(waiter));
 }
 
 static void locks_delete_global_blocked(struct file_lock *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_del(&waiter->fl_link);
+	hash_del(&waiter->c.flc_link);
 }
 
 /* Remove waiter from blocker's block list.
@@ -655,16 +659,16 @@ static void locks_delete_global_blocked(struct file_lock *waiter)
 static void __locks_delete_block(struct file_lock *waiter)
 {
 	locks_delete_global_blocked(waiter);
-	list_del_init(&waiter->fl_blocked_member);
+	list_del_init(&waiter->c.flc_blocked_member);
 }
 
 static void __locks_wake_up_blocks(struct file_lock *blocker)
 {
-	while (!list_empty(&blocker->fl_blocked_requests)) {
+	while (!list_empty(&blocker->c.flc_blocked_requests)) {
 		struct file_lock *waiter;
 
-		waiter = list_first_entry(&blocker->fl_blocked_requests,
-					  struct file_lock, fl_blocked_member);
+		waiter = list_first_entry(&blocker->c.flc_blocked_requests,
+					  struct file_lock, c.flc_blocked_member);
 		__locks_delete_block(waiter);
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
 			waiter->fl_lmops->lm_notify(waiter);
@@ -676,7 +680,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 		 * point in deleting a block. Paired with acquire at the top
 		 * of locks_delete_block().
 		 */
-		smp_store_release(&waiter->fl_blocker, NULL);
+		smp_store_release(&waiter->c.flc_blocker, NULL);
 	}
 }
 
@@ -711,12 +715,12 @@ int locks_delete_block(struct file_lock *waiter)
 	 * no new locks can be inserted into its fl_blocked_requests list, and
 	 * can avoid doing anything further if the list is empty.
 	 */
-	if (!smp_load_acquire(&waiter->fl_blocker) &&
-	    list_empty(&waiter->fl_blocked_requests))
+	if (!smp_load_acquire(&waiter->c.flc_blocker) &&
+	    list_empty(&waiter->c.flc_blocked_requests))
 		return status;
 
 	spin_lock(&blocked_lock_lock);
-	if (waiter->fl_blocker)
+	if (waiter->c.flc_blocker)
 		status = 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
@@ -725,7 +729,7 @@ int locks_delete_block(struct file_lock *waiter)
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
 	 * a block. Paired with acquire at the top of this function.
 	 */
-	smp_store_release(&waiter->fl_blocker, NULL);
+	smp_store_release(&waiter->c.flc_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
@@ -752,17 +756,19 @@ static void __locks_insert_block(struct file_lock *blocker,
 					       struct file_lock *))
 {
 	struct file_lock *fl;
-	BUG_ON(!list_empty(&waiter->fl_blocked_member));
+	BUG_ON(!list_empty(&waiter->c.flc_blocked_member));
 
 new_blocker:
-	list_for_each_entry(fl, &blocker->fl_blocked_requests, fl_blocked_member)
+	list_for_each_entry(fl, &blocker->c.flc_blocked_requests,
+			    c.flc_blocked_member)
 		if (conflict(fl, waiter)) {
 			blocker =  fl;
 			goto new_blocker;
 		}
-	waiter->fl_blocker = blocker;
-	list_add_tail(&waiter->fl_blocked_member, &blocker->fl_blocked_requests);
-	if ((blocker->fl_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
+	waiter->c.flc_blocker = blocker;
+	list_add_tail(&waiter->c.flc_blocked_member,
+		      &blocker->c.flc_blocked_requests);
+	if ((blocker->c.flc_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
 		locks_insert_global_blocked(waiter);
 
 	/* The requests in waiter->fl_blocked are known to conflict with
@@ -797,7 +803,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 	 * fl_blocked_requests list does not require the flc_lock, so we must
 	 * recheck list_empty() after acquiring the blocked_lock_lock.
 	 */
-	if (list_empty(&blocker->fl_blocked_requests))
+	if (list_empty(&blocker->c.flc_blocked_requests))
 		return;
 
 	spin_lock(&blocked_lock_lock);
@@ -808,7 +814,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 static void
 locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
 {
-	list_add_tail(&fl->fl_list, before);
+	list_add_tail(&fl->c.flc_list, before);
 	locks_insert_global_locks(fl);
 }
 
@@ -816,7 +822,7 @@ static void
 locks_unlink_lock_ctx(struct file_lock *fl)
 {
 	locks_delete_global_locks(fl);
-	list_del_init(&fl->fl_list);
+	list_del_init(&fl->c.flc_list);
 	locks_wake_up_blocks(fl);
 }
 
@@ -825,7 +831,7 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 {
 	locks_unlink_lock_ctx(fl);
 	if (dispose)
-		list_add(&fl->fl_list, dispose);
+		list_add(&fl->c.flc_list, dispose);
 	else
 		locks_free_lock(fl);
 }
@@ -886,7 +892,7 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
 	 */
-	if (caller_fl->fl_file == sys_fl->fl_file)
+	if (caller_fl->c.flc_file == sys_fl->c.flc_file)
 		return false;
 
 	return locks_conflict(caller_fl, sys_fl);
@@ -903,13 +909,13 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 
 	ctx = locks_inode_context(inode);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
-		fl->fl_type = F_UNLCK;
+		fl->c.flc_type = F_UNLCK;
 		return;
 	}
 
 retry:
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(cfl, &ctx->flc_posix, c.flc_list) {
 		if (!posix_test_locks_conflict(fl, cfl))
 			continue;
 		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
@@ -925,7 +931,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 		locks_copy_conflock(fl, cfl);
 		goto out;
 	}
-	fl->fl_type = F_UNLCK;
+	fl->c.flc_type = F_UNLCK;
 out:
 	spin_unlock(&ctx->flc_lock);
 	return;
@@ -972,10 +978,10 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 {
 	struct file_lock *fl;
 
-	hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_key(block_fl)) {
+	hash_for_each_possible(blocked_hash, fl, c.flc_link, posix_owner_key(block_fl)) {
 		if (posix_same_owner(fl, block_fl)) {
-			while (fl->fl_blocker)
-				fl = fl->fl_blocker;
+			while (fl->c.flc_blocker)
+				fl = fl->c.flc_blocker;
 			return fl;
 		}
 	}
@@ -994,7 +1000,7 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	 * This deadlock detector can't reasonably detect deadlocks with
 	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
 	 */
-	if (caller_fl->fl_flags & FL_OFDLCK)
+	if (caller_fl->c.flc_flags & FL_OFDLCK)
 		return 0;
 
 	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
@@ -1022,14 +1028,14 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	bool found = false;
 	LIST_HEAD(dispose);
 
-	ctx = locks_get_lock_context(inode, request->fl_type);
+	ctx = locks_get_lock_context(inode, request->c.flc_type);
 	if (!ctx) {
-		if (request->fl_type != F_UNLCK)
+		if (request->c.flc_type != F_UNLCK)
 			return -ENOMEM;
-		return (request->fl_flags & FL_EXISTS) ? -ENOENT : 0;
+		return (request->c.flc_flags & FL_EXISTS) ? -ENOENT : 0;
 	}
 
-	if (!(request->fl_flags & FL_ACCESS) && (request->fl_type != F_UNLCK)) {
+	if (!(request->c.flc_flags & FL_ACCESS) && (request->c.flc_type != F_UNLCK)) {
 		new_fl = locks_alloc_lock();
 		if (!new_fl)
 			return -ENOMEM;
@@ -1037,13 +1043,13 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
-	if (request->fl_flags & FL_ACCESS)
+	if (request->c.flc_flags & FL_ACCESS)
 		goto find_conflict;
 
-	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
-		if (request->fl_file != fl->fl_file)
+	list_for_each_entry(fl, &ctx->flc_flock, c.flc_list) {
+		if (request->c.flc_file != fl->c.flc_file)
 			continue;
-		if (request->fl_type == fl->fl_type)
+		if (request->c.flc_type == fl->c.flc_type)
 			goto out;
 		found = true;
 		locks_delete_lock_ctx(fl, &dispose);
@@ -1051,23 +1057,23 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	}
 
 	if (lock_is_unlock(request)) {
-		if ((request->fl_flags & FL_EXISTS) && !found)
+		if ((request->c.flc_flags & FL_EXISTS) && !found)
 			error = -ENOENT;
 		goto out;
 	}
 
 find_conflict:
-	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_flock, c.flc_list) {
 		if (!flock_locks_conflict(request, fl))
 			continue;
 		error = -EAGAIN;
-		if (!(request->fl_flags & FL_SLEEP))
+		if (!(request->c.flc_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
 		locks_insert_block(fl, request, flock_locks_conflict);
 		goto out;
 	}
-	if (request->fl_flags & FL_ACCESS)
+	if (request->c.flc_flags & FL_ACCESS)
 		goto out;
 	locks_copy_lock(new_fl, request);
 	locks_move_blocks(new_fl, request);
@@ -1100,7 +1106,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	void *owner;
 	void (*func)(void);
 
-	ctx = locks_get_lock_context(inode, request->fl_type);
+	ctx = locks_get_lock_context(inode, request->c.flc_type);
 	if (!ctx)
 		return lock_is_unlock(request) ? 0 : -ENOMEM;
 
@@ -1110,8 +1116,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 *
 	 * In some cases we can be sure, that no new locks will be needed
 	 */
-	if (!(request->fl_flags & FL_ACCESS) &&
-	    (request->fl_type != F_UNLCK ||
+	if (!(request->c.flc_flags & FL_ACCESS) &&
+	    (request->c.flc_type != F_UNLCK ||
 	     request->fl_start != 0 || request->fl_end != OFFSET_MAX)) {
 		new_fl = locks_alloc_lock();
 		new_fl2 = locks_alloc_lock();
@@ -1125,8 +1131,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 * there are any, either return error or put the request on the
 	 * blocker's list of waiters and the global blocked_hash.
 	 */
-	if (request->fl_type != F_UNLCK) {
-		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+	if (request->c.flc_type != F_UNLCK) {
+		list_for_each_entry(fl, &ctx->flc_posix, c.flc_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
 			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
@@ -1143,7 +1149,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
-			if (!(request->fl_flags & FL_SLEEP))
+			if (!(request->c.flc_flags & FL_SLEEP))
 				goto out;
 			/*
 			 * Deadlock detection and insertion into the blocked
@@ -1168,22 +1174,22 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	/* If we're just looking for a conflict, we're done. */
 	error = 0;
-	if (request->fl_flags & FL_ACCESS)
+	if (request->c.flc_flags & FL_ACCESS)
 		goto out;
 
 	/* Find the first old lock with the same owner as the new lock */
-	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_posix, c.flc_list) {
 		if (posix_same_owner(request, fl))
 			break;
 	}
 
 	/* Process locks with this owner. */
-	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
+	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, c.flc_list) {
 		if (!posix_same_owner(request, fl))
 			break;
 
 		/* Detect adjacent or overlapping regions (if same lock type) */
-		if (request->fl_type == fl->fl_type) {
+		if (request->c.flc_type == fl->c.flc_type) {
 			/* In all comparisons of start vs end, use
 			 * "start - 1" rather than "end + 1". If end
 			 * is OFFSET_MAX, end + 1 will become negative.
@@ -1256,7 +1262,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				locks_move_blocks(new_fl, request);
 				request = new_fl;
 				new_fl = NULL;
-				locks_insert_lock_ctx(request, &fl->fl_list);
+				locks_insert_lock_ctx(request,
+						      &fl->c.flc_list);
 				locks_delete_lock_ctx(fl, &dispose);
 				added = true;
 			}
@@ -1275,7 +1282,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	error = 0;
 	if (!added) {
 		if (lock_is_unlock(request)) {
-			if (request->fl_flags & FL_EXISTS)
+			if (request->c.flc_flags & FL_EXISTS)
 				error = -ENOENT;
 			goto out;
 		}
@@ -1286,7 +1293,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		}
 		locks_copy_lock(new_fl, request);
 		locks_move_blocks(new_fl, request);
-		locks_insert_lock_ctx(new_fl, &fl->fl_list);
+		locks_insert_lock_ctx(new_fl, &fl->c.flc_list);
 		fl = new_fl;
 		new_fl = NULL;
 	}
@@ -1298,7 +1305,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			left = new_fl2;
 			new_fl2 = NULL;
 			locks_copy_lock(left, right);
-			locks_insert_lock_ctx(left, &fl->fl_list);
+			locks_insert_lock_ctx(left, &fl->c.flc_list);
 		}
 		right->fl_start = request->fl_end + 1;
 		locks_wake_up_blocks(right);
@@ -1359,8 +1366,8 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = posix_lock_inode(inode, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait,
-					list_empty(&fl->fl_blocked_member));
+		error = wait_event_interruptible(fl->c.flc_wait,
+						 list_empty(&fl->c.flc_blocked_member));
 		if (error)
 			break;
 	}
@@ -1372,10 +1379,10 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 {
 	switch (arg) {
 	case F_UNLCK:
-		fl->fl_flags &= ~FL_UNLOCK_PENDING;
+		fl->c.flc_flags &= ~FL_UNLOCK_PENDING;
 		fallthrough;
 	case F_RDLCK:
-		fl->fl_flags &= ~FL_DOWNGRADE_PENDING;
+		fl->c.flc_flags &= ~FL_DOWNGRADE_PENDING;
 	}
 }
 
@@ -1389,11 +1396,11 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 	lease_clear_pending(fl, arg);
 	locks_wake_up_blocks(fl);
 	if (arg == F_UNLCK) {
-		struct file *filp = fl->fl_file;
+		struct file *filp = fl->c.flc_file;
 
 		f_delown(filp);
 		filp->f_owner.signum = 0;
-		fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
+		fasync_helper(0, fl->c.flc_file, 0, &fl->fl_fasync);
 		if (fl->fl_fasync != NULL) {
 			printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
 			fl->fl_fasync = NULL;
@@ -1419,7 +1426,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 
 	lockdep_assert_held(&ctx->flc_lock);
 
-	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
+	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
@@ -1435,11 +1442,11 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 	if (lease->fl_lmops->lm_breaker_owns_lease
 			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
 		return false;
-	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
+	if ((breaker->c.flc_flags & FL_LAYOUT) != (lease->c.flc_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
 	}
-	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE)) {
+	if ((breaker->c.flc_flags & FL_DELEG) && (lease->c.flc_flags & FL_LEASE)) {
 		rc = false;
 		goto trace;
 	}
@@ -1458,7 +1465,7 @@ any_leases_conflict(struct inode *inode, struct file_lock *breaker)
 
 	lockdep_assert_held(&ctx->flc_lock);
 
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
 		if (leases_conflict(fl, breaker))
 			return true;
 	}
@@ -1490,7 +1497,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
-	new_fl->fl_flags = type;
+	new_fl->c.flc_flags = type;
 
 	/* typically we will check that ctx is non-NULL before calling */
 	ctx = locks_inode_context(inode);
@@ -1514,18 +1521,18 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 			break_time++;	/* so that 0 means no break time */
 	}
 
-	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
+	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
 		if (!leases_conflict(fl, new_fl))
 			continue;
 		if (want_write) {
-			if (fl->fl_flags & FL_UNLOCK_PENDING)
+			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 				continue;
-			fl->fl_flags |= FL_UNLOCK_PENDING;
+			fl->c.flc_flags |= FL_UNLOCK_PENDING;
 			fl->fl_break_time = break_time;
 		} else {
 			if (lease_breaking(fl))
 				continue;
-			fl->fl_flags |= FL_DOWNGRADE_PENDING;
+			fl->c.flc_flags |= FL_DOWNGRADE_PENDING;
 			fl->fl_downgrade_time = break_time;
 		}
 		if (fl->fl_lmops->lm_break(fl))
@@ -1542,7 +1549,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	}
 
 restart:
-	fl = list_first_entry(&ctx->flc_lease, struct file_lock, fl_list);
+	fl = list_first_entry(&ctx->flc_lease, struct file_lock, c.flc_list);
 	break_time = fl->fl_break_time;
 	if (break_time != 0)
 		break_time -= jiffies;
@@ -1554,9 +1561,9 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	percpu_up_read(&file_rwsem);
 
 	locks_dispose_list(&dispose);
-	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-					list_empty(&new_fl->fl_blocked_member),
-					break_time);
+	error = wait_event_interruptible_timeout(new_fl->c.flc_wait,
+						 list_empty(&new_fl->c.flc_blocked_member),
+						 break_time);
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -1602,7 +1609,7 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
 		spin_lock(&ctx->flc_lock);
 		fl = list_first_entry_or_null(&ctx->flc_lease,
-					      struct file_lock, fl_list);
+					      struct file_lock, c.flc_list);
 		if (fl && lock_is_write(fl))
 			has_lease = true;
 		spin_unlock(&ctx->flc_lock);
@@ -1649,8 +1656,8 @@ int fcntl_getlease(struct file *filp)
 		percpu_down_read(&file_rwsem);
 		spin_lock(&ctx->flc_lock);
 		time_out_leases(inode, &dispose);
-		list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-			if (fl->fl_file != filp)
+		list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
+			if (fl->c.flc_file != filp)
 				continue;
 			type = target_leasetype(fl);
 			break;
@@ -1715,7 +1722,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	struct file_lock *fl, *my_fl = NULL, *lease;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
-	bool is_deleg = (*flp)->fl_flags & FL_DELEG;
+	bool is_deleg = (*flp)->c.flc_flags & FL_DELEG;
 	int error;
 	LIST_HEAD(dispose);
 
@@ -1741,7 +1748,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-	error = check_conflicting_open(filp, arg, lease->fl_flags);
+	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
 	if (error)
 		goto out;
 
@@ -1754,9 +1761,9 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	 * except for this filp.
 	 */
 	error = -EAGAIN;
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-		if (fl->fl_file == filp &&
-		    fl->fl_owner == lease->fl_owner) {
+	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
+		if (fl->c.flc_file == filp &&
+		    fl->c.flc_owner == lease->c.flc_owner) {
 			my_fl = fl;
 			continue;
 		}
@@ -1771,7 +1778,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 		 * Modifying our existing lease is OK, but no getting a
 		 * new lease if someone else is opening for write:
 		 */
-		if (fl->fl_flags & FL_UNLOCK_PENDING)
+		if (fl->c.flc_flags & FL_UNLOCK_PENDING)
 			goto out;
 	}
 
@@ -1798,7 +1805,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	 * precedes these checks.
 	 */
 	smp_mb();
-	error = check_conflicting_open(filp, arg, lease->fl_flags);
+	error = check_conflicting_open(filp, arg, lease->c.flc_flags);
 	if (error) {
 		locks_unlink_lock_ctx(lease);
 		goto out;
@@ -1834,9 +1841,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-		if (fl->fl_file == filp &&
-		    fl->fl_owner == owner) {
+	list_for_each_entry(fl, &ctx->flc_lease, c.flc_list) {
+		if (fl->c.flc_file == filp &&
+		    fl->c.flc_owner == owner) {
 			victim = fl;
 			break;
 		}
@@ -2012,8 +2019,8 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = flock_lock_inode(inode, fl);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait,
-				list_empty(&fl->fl_blocked_member));
+		error = wait_event_interruptible(fl->c.flc_wait,
+						 list_empty(&fl->c.flc_blocked_member));
 		if (error)
 			break;
 	}
@@ -2031,7 +2038,7 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 {
 	int res = 0;
-	switch (fl->fl_flags & (FL_POSIX|FL_FLOCK)) {
+	switch (fl->c.flc_flags & (FL_POSIX|FL_FLOCK)) {
 		case FL_POSIX:
 			res = posix_lock_inode_wait(inode, fl);
 			break;
@@ -2093,13 +2100,13 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 
 	flock_make_lock(f.file, &fl, type);
 
-	error = security_file_lock(f.file, fl.fl_type);
+	error = security_file_lock(f.file, fl.c.flc_type);
 	if (error)
 		goto out_putf;
 
 	can_sleep = !(cmd & LOCK_NB);
 	if (can_sleep)
-		fl.fl_flags |= FL_SLEEP;
+		fl.c.flc_flags |= FL_SLEEP;
 
 	if (f.file->f_op->flock)
 		error = f.file->f_op->flock(f.file,
@@ -2125,7 +2132,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	WARN_ON_ONCE(filp != fl->c.flc_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);
 	posix_test_lock(filp, fl);
@@ -2145,12 +2152,12 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	pid_t vnr;
 	struct pid *pid;
 
-	if (fl->fl_flags & FL_OFDLCK)
+	if (fl->c.flc_flags & FL_OFDLCK)
 		return -1;
 
 	/* Remote locks report a negative pid value */
-	if (fl->fl_pid <= 0)
-		return fl->fl_pid;
+	if (fl->c.flc_pid <= 0)
+		return fl->c.flc_pid;
 
 	/*
 	 * If the flock owner process is dead and its pid has been already
@@ -2158,10 +2165,10 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	 * flock owner pid number in init pidns.
 	 */
 	if (ns == &init_pid_ns)
-		return (pid_t)fl->fl_pid;
+		return (pid_t) fl->c.flc_pid;
 
 	rcu_read_lock();
-	pid = find_pid_ns(fl->fl_pid, &init_pid_ns);
+	pid = find_pid_ns(fl->c.flc_pid, &init_pid_ns);
 	vnr = pid_nr_ns(pid, ns);
 	rcu_read_unlock();
 	return vnr;
@@ -2184,7 +2191,7 @@ static int posix_lock_to_flock(struct flock *flock, struct file_lock *fl)
 	flock->l_len = fl->fl_end == OFFSET_MAX ? 0 :
 		fl->fl_end - fl->fl_start + 1;
 	flock->l_whence = 0;
-	flock->l_type = fl->fl_type;
+	flock->l_type = fl->c.flc_type;
 	return 0;
 }
 
@@ -2196,7 +2203,7 @@ static void posix_lock_to_flock64(struct flock64 *flock, struct file_lock *fl)
 	flock->l_len = fl->fl_end == OFFSET_MAX ? 0 :
 		fl->fl_end - fl->fl_start + 1;
 	flock->l_whence = 0;
-	flock->l_type = fl->fl_type;
+	flock->l_type = fl->c.flc_type;
 }
 #endif
 
@@ -2225,16 +2232,16 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		fl->fl_flags |= FL_OFDLCK;
-		fl->fl_owner = filp;
+		fl->c.flc_flags |= FL_OFDLCK;
+		fl->c.flc_owner = filp;
 	}
 
 	error = vfs_test_lock(filp, fl);
 	if (error)
 		goto out;
 
-	flock->l_type = fl->fl_type;
-	if (fl->fl_type != F_UNLCK) {
+	flock->l_type = fl->c.flc_type;
+	if (fl->c.flc_type != F_UNLCK) {
 		error = posix_lock_to_flock(flock, fl);
 		if (error)
 			goto out;
@@ -2281,7 +2288,7 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  */
 int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	WARN_ON_ONCE(filp != fl->c.flc_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, cmd, fl);
 	else
@@ -2294,7 +2301,7 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 {
 	int error;
 
-	error = security_file_lock(filp, fl->fl_type);
+	error = security_file_lock(filp, fl->c.flc_type);
 	if (error)
 		return error;
 
@@ -2302,8 +2309,8 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		error = vfs_lock_file(filp, cmd, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait,
-					list_empty(&fl->fl_blocked_member));
+		error = wait_event_interruptible(fl->c.flc_wait,
+						 list_empty(&fl->c.flc_blocked_member));
 		if (error)
 			break;
 	}
@@ -2316,13 +2323,13 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 static int
 check_fmode_for_setlk(struct file_lock *fl)
 {
-	switch (fl->fl_type) {
+	switch (fl->c.flc_type) {
 	case F_RDLCK:
-		if (!(fl->fl_file->f_mode & FMODE_READ))
+		if (!(fl->c.flc_file->f_mode & FMODE_READ))
 			return -EBADF;
 		break;
 	case F_WRLCK:
-		if (!(fl->fl_file->f_mode & FMODE_WRITE))
+		if (!(fl->c.flc_file->f_mode & FMODE_WRITE))
 			return -EBADF;
 	}
 	return 0;
@@ -2361,8 +2368,8 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLK;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->c.flc_flags |= FL_OFDLCK;
+		file_lock->c.flc_owner = filp;
 		break;
 	case F_OFD_SETLKW:
 		error = -EINVAL;
@@ -2370,11 +2377,11 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLKW;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->c.flc_flags |= FL_OFDLCK;
+		file_lock->c.flc_owner = filp;
 		fallthrough;
 	case F_SETLKW:
-		file_lock->fl_flags |= FL_SLEEP;
+		file_lock->c.flc_flags |= FL_SLEEP;
 	}
 
 	error = do_lock_file_wait(filp, cmd, file_lock);
@@ -2384,8 +2391,8 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 	 * lock that was just acquired. There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
-	if (!error && file_lock->fl_type != F_UNLCK &&
-	    !(file_lock->fl_flags & FL_OFDLCK)) {
+	if (!error && file_lock->c.flc_type != F_UNLCK &&
+	    !(file_lock->c.flc_flags & FL_OFDLCK)) {
 		struct files_struct *files = current->files;
 		/*
 		 * We need that spin_lock here - it prevents reordering between
@@ -2396,7 +2403,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->fl_type = F_UNLCK;
+			file_lock->c.flc_type = F_UNLCK;
 			error = do_lock_file_wait(filp, cmd, file_lock);
 			WARN_ON_ONCE(error);
 			error = -EBADF;
@@ -2435,16 +2442,16 @@ int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		fl->fl_flags |= FL_OFDLCK;
-		fl->fl_owner = filp;
+		fl->c.flc_flags |= FL_OFDLCK;
+		fl->c.flc_owner = filp;
 	}
 
 	error = vfs_test_lock(filp, fl);
 	if (error)
 		goto out;
 
-	flock->l_type = fl->fl_type;
-	if (fl->fl_type != F_UNLCK)
+	flock->l_type = fl->c.flc_type;
+	if (fl->c.flc_type != F_UNLCK)
 		posix_lock_to_flock64(flock, fl);
 
 out:
@@ -2484,8 +2491,8 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLK64;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->c.flc_flags |= FL_OFDLCK;
+		file_lock->c.flc_owner = filp;
 		break;
 	case F_OFD_SETLKW:
 		error = -EINVAL;
@@ -2493,11 +2500,11 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLKW64;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->c.flc_flags |= FL_OFDLCK;
+		file_lock->c.flc_owner = filp;
 		fallthrough;
 	case F_SETLKW64:
-		file_lock->fl_flags |= FL_SLEEP;
+		file_lock->c.flc_flags |= FL_SLEEP;
 	}
 
 	error = do_lock_file_wait(filp, cmd, file_lock);
@@ -2507,8 +2514,8 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 	 * lock that was just acquired. There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
-	if (!error && file_lock->fl_type != F_UNLCK &&
-	    !(file_lock->fl_flags & FL_OFDLCK)) {
+	if (!error && file_lock->c.flc_type != F_UNLCK &&
+	    !(file_lock->c.flc_flags & FL_OFDLCK)) {
 		struct files_struct *files = current->files;
 		/*
 		 * We need that spin_lock here - it prevents reordering between
@@ -2519,7 +2526,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->fl_type = F_UNLCK;
+			file_lock->c.flc_type = F_UNLCK;
 			error = do_lock_file_wait(filp, cmd, file_lock);
 			WARN_ON_ONCE(error);
 			error = -EBADF;
@@ -2553,13 +2560,13 @@ void locks_remove_posix(struct file *filp, fl_owner_t owner)
 		return;
 
 	locks_init_lock(&lock);
-	lock.fl_type = F_UNLCK;
-	lock.fl_flags = FL_POSIX | FL_CLOSE;
+	lock.c.flc_type = F_UNLCK;
+	lock.c.flc_flags = FL_POSIX | FL_CLOSE;
 	lock.fl_start = 0;
 	lock.fl_end = OFFSET_MAX;
-	lock.fl_owner = owner;
-	lock.fl_pid = current->tgid;
-	lock.fl_file = filp;
+	lock.c.flc_owner = owner;
+	lock.c.flc_pid = current->tgid;
+	lock.c.flc_file = filp;
 	lock.fl_ops = NULL;
 	lock.fl_lmops = NULL;
 
@@ -2582,7 +2589,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 		return;
 
 	flock_make_lock(filp, &fl, F_UNLCK);
-	fl.fl_flags |= FL_CLOSE;
+	fl.c.flc_flags |= FL_CLOSE;
 
 	if (filp->f_op->flock)
 		filp->f_op->flock(filp, F_SETLKW, &fl);
@@ -2605,8 +2612,8 @@ locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list)
-		if (filp == fl->fl_file)
+	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list)
+		if (filp == fl->c.flc_file)
 			lease_modify(fl, F_UNLCK, &dispose);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
@@ -2650,7 +2657,7 @@ void locks_remove_file(struct file *filp)
  */
 int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	WARN_ON_ONCE(filp != fl->c.flc_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_CANCELLK, fl);
 	return 0;
@@ -2695,7 +2702,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	struct inode *inode = NULL;
 	unsigned int pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
-	int type = fl->fl_type;
+	int type = fl->c.flc_type;
 
 	pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2704,37 +2711,37 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	 * init_pid_ns to get saved lock pid value.
 	 */
 
-	if (fl->fl_file != NULL)
-		inode = file_inode(fl->fl_file);
+	if (fl->c.flc_file != NULL)
+		inode = file_inode(fl->c.flc_file);
 
 	seq_printf(f, "%lld: ", id);
 
 	if (repeat)
 		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
 
-	if (fl->fl_flags & FL_POSIX) {
-		if (fl->fl_flags & FL_ACCESS)
+	if (fl->c.flc_flags & FL_POSIX) {
+		if (fl->c.flc_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
-		else if (fl->fl_flags & FL_OFDLCK)
+		else if (fl->c.flc_flags & FL_OFDLCK)
 			seq_puts(f, "OFDLCK");
 		else
 			seq_puts(f, "POSIX ");
 
 		seq_printf(f, " %s ",
 			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");
-	} else if (fl->fl_flags & FL_FLOCK) {
+	} else if (fl->c.flc_flags & FL_FLOCK) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
-	} else if (fl->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
+	} else if (fl->c.flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
 		type = target_leasetype(fl);
 
-		if (fl->fl_flags & FL_DELEG)
+		if (fl->c.flc_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
 			seq_puts(f, "LEASE  ");
 
 		if (lease_breaking(fl))
 			seq_puts(f, "BREAKING  ");
-		else if (fl->fl_file)
+		else if (fl->c.flc_file)
 			seq_puts(f, "ACTIVE    ");
 		else
 			seq_puts(f, "BREAKER   ");
@@ -2752,7 +2759,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else {
 		seq_printf(f, "%d <none>:0 ", pid);
 	}
-	if (fl->fl_flags & FL_POSIX) {
+	if (fl->c.flc_flags & FL_POSIX) {
 		if (fl->fl_end == OFFSET_MAX)
 			seq_printf(f, "%Ld EOF\n", fl->fl_start);
 		else
@@ -2767,13 +2774,14 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 	struct file_lock *tmp;
 
 	/* NULL node or root node */
-	if (node == NULL || node->fl_blocker == NULL)
+	if (node == NULL || node->c.flc_blocker == NULL)
 		return NULL;
 
 	/* Next member in the linked list could be itself */
-	tmp = list_next_entry(node, fl_blocked_member);
-	if (list_entry_is_head(tmp, &node->fl_blocker->fl_blocked_requests, fl_blocked_member)
-		|| tmp == node) {
+	tmp = list_next_entry(node, c.flc_blocked_member);
+	if (list_entry_is_head(tmp, &node->c.flc_blocker->c.flc_blocked_requests,
+				c.flc_blocked_member)
+	    || tmp == node) {
 		return NULL;
 	}
 
@@ -2787,13 +2795,13 @@ static int locks_show(struct seq_file *f, void *v)
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int level = 0;
 
-	cur = hlist_entry(v, struct file_lock, fl_link);
+	cur = hlist_entry(v, struct file_lock, c.flc_link);
 
 	if (locks_translate_pid(cur, proc_pidns) == 0)
 		return 0;
 
 	/* View this crossed linked list as a binary tree, the first member of fl_blocked_requests
-	 * is the left child of current node, the next silibing in fl_blocked_member is the
+	 * is the left child of current node, the next silibing in flc_blocked_member is the
 	 * right child, we can alse get the parent of current node from fl_blocker, so this
 	 * question becomes traversal of a binary tree
 	 */
@@ -2803,17 +2811,18 @@ static int locks_show(struct seq_file *f, void *v)
 		else
 			lock_get_status(f, cur, iter->li_pos, "", level);
 
-		if (!list_empty(&cur->fl_blocked_requests)) {
+		if (!list_empty(&cur->c.flc_blocked_requests)) {
 			/* Turn left */
-			cur = list_first_entry_or_null(&cur->fl_blocked_requests,
-				struct file_lock, fl_blocked_member);
+			cur = list_first_entry_or_null(&cur->c.flc_blocked_requests,
+						       struct file_lock,
+						       c.flc_blocked_member);
 			level++;
 		} else {
 			/* Turn right */
 			tmp = get_next_blocked_member(cur);
 			/* Fall back to parent node */
-			while (tmp == NULL && cur->fl_blocker != NULL) {
-				cur = cur->fl_blocker;
+			while (tmp == NULL && cur->c.flc_blocker != NULL) {
+				cur = cur->c.flc_blocker;
 				level--;
 				tmp = get_next_blocked_member(cur);
 			}
@@ -2830,12 +2839,12 @@ static void __show_fd_locks(struct seq_file *f,
 {
 	struct file_lock *fl;
 
-	list_for_each_entry(fl, head, fl_list) {
+	list_for_each_entry(fl, head, c.flc_list) {
 
-		if (filp != fl->fl_file)
+		if (filp != fl->c.flc_file)
 			continue;
-		if (fl->fl_owner != files &&
-		    fl->fl_owner != filp)
+		if (fl->c.flc_owner != files &&
+		    fl->c.flc_owner != filp)
 			continue;
 
 		(*id)++;
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index 8fb1d41b1c67..4be341b5ead0 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -82,11 +82,11 @@ DECLARE_EVENT_CLASS(filelock_lock,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->blocker = fl ? fl->fl_blocker : NULL;
-		__entry->owner = fl ? fl->fl_owner : NULL;
-		__entry->pid = fl ? fl->fl_pid : 0;
-		__entry->flags = fl ? fl->fl_flags : 0;
-		__entry->type = fl ? fl->fl_type : 0;
+		__entry->blocker = fl ? fl->c.flc_blocker : NULL;
+		__entry->owner = fl ? fl->c.flc_owner : NULL;
+		__entry->pid = fl ? fl->c.flc_pid : 0;
+		__entry->flags = fl ? fl->c.flc_flags : 0;
+		__entry->type = fl ? fl->c.flc_type : 0;
 		__entry->fl_start = fl ? fl->fl_start : 0;
 		__entry->fl_end = fl ? fl->fl_end : 0;
 		__entry->ret = ret;
@@ -137,10 +137,10 @@ DECLARE_EVENT_CLASS(filelock_lease,
 		__entry->fl = fl ? fl : NULL;
 		__entry->s_dev = inode->i_sb->s_dev;
 		__entry->i_ino = inode->i_ino;
-		__entry->blocker = fl ? fl->fl_blocker : NULL;
-		__entry->owner = fl ? fl->fl_owner : NULL;
-		__entry->flags = fl ? fl->fl_flags : 0;
-		__entry->type = fl ? fl->fl_type : 0;
+		__entry->blocker = fl ? fl->c.flc_blocker : NULL;
+		__entry->owner = fl ? fl->c.flc_owner : NULL;
+		__entry->flags = fl ? fl->c.flc_flags : 0;
+		__entry->type = fl ? fl->c.flc_type : 0;
 		__entry->break_time = fl ? fl->fl_break_time : 0;
 		__entry->downgrade_time = fl ? fl->fl_downgrade_time : 0;
 	),
@@ -190,9 +190,9 @@ TRACE_EVENT(generic_add_lease,
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->rcount = atomic_read(&inode->i_readcount);
 		__entry->icount = atomic_read(&inode->i_count);
-		__entry->owner = fl->fl_owner;
-		__entry->flags = fl->fl_flags;
-		__entry->type = fl->fl_type;
+		__entry->owner = fl->c.flc_owner;
+		__entry->flags = fl->c.flc_flags;
+		__entry->type = fl->c.flc_type;
 	),
 
 	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
@@ -220,11 +220,11 @@ TRACE_EVENT(leases_conflict,
 
 	TP_fast_assign(
 		__entry->lease = lease;
-		__entry->l_fl_flags = lease->fl_flags;
-		__entry->l_fl_type = lease->fl_type;
+		__entry->l_fl_flags = lease->c.flc_flags;
+		__entry->l_fl_type = lease->c.flc_type;
 		__entry->breaker = breaker;
-		__entry->b_fl_flags = breaker->fl_flags;
-		__entry->b_fl_type = breaker->fl_type;
+		__entry->b_fl_flags = breaker->c.flc_flags;
+		__entry->b_fl_type = breaker->c.flc_type;
 		__entry->conflict = conflict;
 	),
 

-- 
2.43.0


