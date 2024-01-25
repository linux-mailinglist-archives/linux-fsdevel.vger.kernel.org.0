Return-Path: <linux-fsdevel+bounces-8881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B77283BF68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7539293E9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3156765;
	Thu, 25 Jan 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+bHBjlN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230E55C3A;
	Thu, 25 Jan 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179429; cv=none; b=ofFA9CPuiP2yeCUmCJ0jJM3+9hhFR31zA9wLmn9TmEjE5SVIquuWG5Hg3gLSHYKzdgsSB8GXliFOBVW1chBIuMO6Rwtba7MFzdQSynO2qyX3v14NLHJibGUuw3/XMfqPfx6salQxblw0qEjFz99C8aAkU1pWXgVM0zkF5SD+3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179429; c=relaxed/simple;
	bh=Ie5p6oqmpFNZUgXEHLRq4W1RdiFIAqz5JNsDHAErZ1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ga1vBd4puHzSQxrY2Dbq/RvHeBYR2zXwzNDjSMyeOroZtg0hQjuQSToW4kQ+ZYBy/LQqRzgsj4mnUV8sGxTcWQPSvoOHmb8ouzdgE5QIAFddTeBeK7YnQz3ECK0zL8PACGFWIivCGIcEE5+HsR7F7NTNKT9GYjUR9HU6trTxreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+bHBjlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC091C43609;
	Thu, 25 Jan 2024 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179429;
	bh=Ie5p6oqmpFNZUgXEHLRq4W1RdiFIAqz5JNsDHAErZ1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+bHBjlNlfdirhOZjDJ7TyKBL24R/sb+xPVkIlvknO5FCv6+2ywDiZPjndCU2rXxE
	 ra+DRB/VjHyWgJNwVsMzMS2mWmczJiVuLN9RTvqtBtXACM3usg4oYpMn0xcTL526fX
	 CrDaGT+dG8GoSQUTmZ+y7j/ZU7bUcLTXCMDwthaXK//+kSH1mmTKk7an856p3CwYGt
	 zTebnliilHGxiM6dWWKDpy0DMkHuqLKbiTBuFvfM884Eyox1OicJ2x0Z6JaOIxV01U
	 f2BqwRF0DgmztCZ+1irPNcHaGa1QNC8oi1iN+0SRIGlG+SwsmcHaBEaMA0NKTVaJAz
	 6AcccnLv5JyOQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:50 -0500
Subject: [PATCH v2 09/41] filelock: drop the IS_* macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-9-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
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
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ie5p6oqmpFNZUgXEHLRq4W1RdiFIAqz5JNsDHAErZ1M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs7Y1gVzezg9FUKDvD/HvS9VuYz3hiMoSnaH
 dR/9lKIk3WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OwAKCRAADmhBGVaC
 FdwSEACc87JFuNmCK+jCub4XqNO93qhEtp9+fbbmrtMA1m5mbpH7I4XRLaLv/HGnbycVzTDZtUq
 L/ICfyXuuAewtz0Yz+sFBHLvwwstnBha2u8aMN1P8PuI4YV352iOtrJAtMT2ZWocKZ6kg0F/5t1
 UUD6WvDWVQ7Fn2fCHuowQOA9GufJMsK1IKuzy2wJl4SNV04yZ5Ja+8queToadwoEiV/CCCNo0AM
 vcA+fcvnrFcmu0V4VkMZsVOiBUulEGpVAeOwaUSXtrz1qL6MfHf1BUUvyqZzeYLOHuRGy/JKJL5
 f5Y/gJ7DqESSxNbJSO4BaFYWnLX90E0W7Mq0DPEzAkCc1Zl7L6HLwxitEXVsHNxcWeRjoR4nKSX
 tpXq6iwqBCdCcASVZCyZL+4bhhXCwRQ5DyVHtyUAN27gBWt/p//hW3TPymvnz9k8u/6lnbmTmFm
 r7h06Op4cDcDiwqqGlg9wEQYAnk10grHBlt7RTH/4vofeVLRjT6Ft8jS+FEiuibotGJPCvDCXdu
 fN6x1V4EHKK98xh0rTIdqZbpwHr78WKHSti1GFS/3g6s187txgSWX389tuets1UyJt37nJTT4lU
 Uu7T1zM6yKsvPhrNYr6Z5qqzPEi1sG+GzEBSfuSV+x298GQ0JI/cIIOTQc4ea4Jo3LWvHiifjsJ
 P7dl9XwNhMcWVEw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These don't add a lot of value over just open-coding the flag check.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1eceaa56e47f..87212f86eca9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -70,12 +70,6 @@
 
 #include <linux/uaccess.h>
 
-#define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
-#define IS_FLOCK(fl)	(fl->fl_flags & FL_FLOCK)
-#define IS_LEASE(fl)	(fl->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
-#define IS_OFDLCK(fl)	(fl->fl_flags & FL_OFDLCK)
-#define IS_REMOTELCK(fl)	(fl->fl_pid <= 0)
-
 static bool lease_breaking(struct file_lock *fl)
 {
 	return fl->fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
@@ -767,7 +761,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 		}
 	waiter->fl_blocker = blocker;
 	list_add_tail(&waiter->fl_blocked_member, &blocker->fl_blocked_requests);
-	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
+	if ((blocker->fl_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
 		locks_insert_global_blocked(waiter);
 
 	/* The requests in waiter->fl_blocked are known to conflict with
@@ -999,7 +993,7 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	 * This deadlock detector can't reasonably detect deadlocks with
 	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
 	 */
-	if (IS_OFDLCK(caller_fl))
+	if (caller_fl->fl_flags & FL_OFDLCK)
 		return 0;
 
 	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
@@ -2150,10 +2144,13 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	pid_t vnr;
 	struct pid *pid;
 
-	if (IS_OFDLCK(fl))
+	if (fl->fl_flags & FL_OFDLCK)
 		return -1;
-	if (IS_REMOTELCK(fl))
+
+	/* Remote locks report a negative pid value */
+	if (fl->fl_pid <= 0)
 		return fl->fl_pid;
+
 	/*
 	 * If the flock owner process is dead and its pid has been already
 	 * freed, the translation below won't work, but we still want to show
@@ -2697,7 +2694,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	struct inode *inode = NULL;
 	unsigned int pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
-	int type;
+	int type = fl->fl_type;
 
 	pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2714,19 +2711,21 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (repeat)
 		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
 
-	if (IS_POSIX(fl)) {
+	if (fl->fl_flags & FL_POSIX) {
 		if (fl->fl_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
-		else if (IS_OFDLCK(fl))
+		else if (fl->fl_flags & FL_OFDLCK)
 			seq_puts(f, "OFDLCK");
 		else
 			seq_puts(f, "POSIX ");
 
 		seq_printf(f, " %s ",
 			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");
-	} else if (IS_FLOCK(fl)) {
+	} else if (fl->fl_flags & FL_FLOCK) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
-	} else if (IS_LEASE(fl)) {
+	} else if (fl->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
+		type = target_leasetype(fl);
+
 		if (fl->fl_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
@@ -2741,7 +2740,6 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else {
 		seq_puts(f, "UNKNOWN UNKNOWN  ");
 	}
-	type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_type;
 
 	seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
 			     (type == F_RDLCK) ? "READ" : "UNLCK");
@@ -2753,7 +2751,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else {
 		seq_printf(f, "%d <none>:0 ", pid);
 	}
-	if (IS_POSIX(fl)) {
+	if (fl->fl_flags & FL_POSIX) {
 		if (fl->fl_end == OFFSET_MAX)
 			seq_printf(f, "%Ld EOF\n", fl->fl_start);
 		else

-- 
2.43.0


