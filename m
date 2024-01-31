Return-Path: <linux-fsdevel+bounces-9746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D9844C03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0153D295B78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEF5D739;
	Wed, 31 Jan 2024 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkDZvqSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9A5677B;
	Wed, 31 Jan 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742200; cv=none; b=UCrARcBwUzJotppUrmpcc4FhJH6hNcu9xg36j3LkoDRxTm+otsUJ/Df2Ep9WsDDX8L5wtkbNy/nZQAnDSW9ZuUC+B6xH/dIUq5MpJBjNl8+elnmrpolHkmHEjVv1oYXyfFBkF5ZxPRQksl662ORqDJe5Uu9UkiqYyJQqIb5jvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742200; c=relaxed/simple;
	bh=5swEox7V4hK8YGA2X7E7k10sEDLgEh0qA057+uwiAbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TO5Pvv83UCCVR+x76noNiGQWPK/2kE+NByp5Ea8BMLK/QwLyY31uv6qXKeTqV19x30BvoioSsqKUS3FC4D43wm1jYEtOF6cACvhoBHx8z9C4RdudZWlBbo3+Ea+SeD6sLKxmSG1QbrZ/zJdm0QJ2lkL24gqCbi3/d0qpCVu3i/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkDZvqSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D33C433B2;
	Wed, 31 Jan 2024 23:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742199;
	bh=5swEox7V4hK8YGA2X7E7k10sEDLgEh0qA057+uwiAbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tkDZvqSHCUpfwZClKkxlyG6uTkY15Ou0cqbbpV7PlnGagszHGxcMa1jnZkXR98oU3
	 qIb9Idx3nVnPug8413GPmfHCo/H/7Q92ZoXrr1iP+78l8dC1FYzATD8AMAXXenNL80
	 4552kNJRSCnWCEz/aFwCbjchbX6hcm4QljunWVjLO2GMwcZcqoaneHBqsBApnk44Ks
	 ULhp3+G6wNKDcoq1fIQZTWpFG4BnyYcAYl9wdfatGBg1FHMiFGq3SHhdCxSqw3maRm
	 WlCnxcsiqCqTARY3dlwF3ez00KHz59q1OM+CZ12ywYQAXxxWqwy7PhHyaKdR8NhWRe
	 zhxkrJIugubBA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:57 -0500
Subject: [PATCH v3 16/47] filelock: drop the IS_* macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-16-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5swEox7V4hK8YGA2X7E7k10sEDLgEh0qA057+uwiAbI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFw1gNZXaBpHdfIiv1gOKh+XtMS35AGJtNDY
 f87s9/sgGCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 FaCTEADWGpwDJy9k978zXhQu7rq2iKRa7A+5cqrfAodW8VK1sF01UKKoyv8z4/vrF3jei4ernAI
 6s7OCbt7o0zEbpJfP0A8EK4gLNnHhA0U/MonNdZoOe05S2JpCf7Igako+cx0Ije8/iJc9ZxGU/2
 ND6365olXE5xeTzezicUTLepgNWL1KJPpJ4B2DrzD3c0yhF6o96ttkix5fak7jOpyVT85h9l3ph
 idPJDRigG8UMdJ9dEewZuT1o13FqtYX7fyOqPpvgcKf/sgid6Qf3SQ597xTyw9RaBxIHCH5R451
 Z8GVBR1T+ZyyeTvbl2alGLQpYI2UNmhTSflE8OjU6OkfkYgyjRHMVQ+KogeptjCoJw4HUyCBW9L
 zi2XCAg1y94Aj3cyqVHrHQyH4gi4QD1wcpHUzPvU4k7z5W4WHHXZzGBjM2pTUJsBd6nISAl9EA8
 hEip8991FDmgY2xomZItbya283R5gbVonbeLBKyZxN/sWaufQeVprpb3v4Ubsw0al7IQJeb/BcK
 q9gcEMiaVxJbNqBPXDChfBn2p18av2NA02Vn03YITVoWHAV9nCJ7vwkzwFTZzk/vvSUrN+c/Nqu
 GkgCUaVBT1FIR8AO0OYJyL4Q7miSgfddhcLWndjkuG2XCdt56y+LUKSWCAYR3fAZFKs4RRejNkf
 F2mrJg3I4Q0mLXg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These don't add a lot of value over just open-coding the flag check.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 149070fd3b66..d685c3fdbea5 100644
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


