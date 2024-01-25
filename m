Return-Path: <linux-fsdevel+bounces-8900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7983C05B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CA1B2D1F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B364CC5;
	Thu, 25 Jan 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdu3TUw6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014864AB0;
	Thu, 25 Jan 2024 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179503; cv=none; b=ViFYDDeQhHdQsDSr0ceSVD+tmPQZsoKv5ZrgzOl7sXGuz2ZBIS6npc+RkT7+LbMZMlOoPKqxntdyXqTm8SL4kkLY86rlSQwETaUV8KP34VPbMPqYjVAZlBQ5pfbdE5RlEfyH6YtqM0T8h2gDYlCvZOFODO3VtF6U0XTQt10Y7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179503; c=relaxed/simple;
	bh=v8PSdf1izCEgBD5ZJh8KPcAAwqgcrnxIZtLrcC5ncwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfacRuA8Dpm7tPY7YApMGBkXOSKZ9B4OYWolwHeQJoVpGUURv8LbF+3ME0XstVnL4hewbW+ApogVaIEy7Ko+k5cmr6HMncxrsxfLjS6SlWy56JrSCl4FsAGRLk89HfIgxioMRiZE7snvSFe7Lb6FHJPQ9ZtjcFn3n6u8LzYhQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdu3TUw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CDFC43394;
	Thu, 25 Jan 2024 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179502;
	bh=v8PSdf1izCEgBD5ZJh8KPcAAwqgcrnxIZtLrcC5ncwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rdu3TUw6huG9di9piQog0QmobrboYo6xDOn2KRn3C6nR/xFZxeUHtO1T+XYIrU+s/
	 jXzhdP4H04RpL5RCjvL7xJMrsbxv7ew/ek30gPpbbjV9Nb4v+xpjjombnUT8oIOIq8
	 iObTfIsPWK99AbLf040uZPjMAol3IKca7CVCVTqab0q0PiF7pakuQn88M6w7PM0Gom
	 NSxZrrBEtvg/ZFgg3v8mTtwelEAPMZ64krlvJxo64+mMb6pD2IyOt5moOawb7NL01P
	 hVpQZY6wW737ZweygcTTbIhbJc4bHLN9qLK/8YJtFnEO8az1Ns6jvfuxp9Xfv7ZyMW
	 bX9106dl4uHCw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:09 -0500
Subject: [PATCH v2 28/41] filelock: convert seqfile handling to use
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-28-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6528; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=v8PSdf1izCEgBD5ZJh8KPcAAwqgcrnxIZtLrcC5ncwo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs9NABERfDWZKLfE5/QgXU8whcVzuCVD38fQ
 1aXWqVkdWmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PQAKCRAADmhBGVaC
 FU5xD/0f8xTr4iVqZCdVGNFmdPV6lhNTcg6FDiP68QA32M0HwcHjAiHNmpdivK2XZYgHjsn5m8w
 c4WokQJNcExcscyZZuPOoHpeNeXqTDMK8mVLuhZmXhZiL5/nZXUmjmw+5SX2TzzsqrXpI8xgzab
 p/C+nw1QQMkP2Xe5bYiq7j0DH3uGXOls5yZ/HowDFNP8AsSXljo//8W6b+2pJz483M2jYwpq9gr
 qr483PD2jx5PxtV44snb5iI3Gxhymee/WLrx71wMTdYfGLxoHZRAXYMMi2Vw2NuY2njBRHqogD4
 INTxWFatqw3cwb7HTVARSQ6cDTUS2pTLQx3oSsvahy7RlvDDgc9Ti8PKN3470U0S27KJ33SKWUC
 Qvph3RroeKmTcnSSfv4HRsVPsmVeLMwKwKgXE+jX+a7VJV3WxR+IHwxFYxOUwue2HmcvGK6mBcN
 xKobLIE0WF2ckTkqAQfZG8ZfA39bv0kpdSe5DChODmUS3kofbRn0eF36ovhS+GikEeaAoVb3nz0
 J2EdKP2z91Q0wCkRctQTpWQEbL9xrKrYCp7a1vmXPJFlFmHomlf9ZhwXlZR+V0JZ3vdytXWV5F3
 Hl1ZiuW9ZeuTYH4IIEd6IocRVc2DDtoIUFrXuGlT6R8gZrxVEYQ3f6YASlu+UOQD0M4vKhVan4Z
 ewSirartqcatUZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Reduce some pointer manipulation by just using file_lock_core where we
can and only translate to a file_lock when needed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 71 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index e8afdd084245..de93d38da2f9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2718,52 +2718,54 @@ struct locks_iterator {
 	loff_t	li_pos;
 };
 
-static void lock_get_status(struct seq_file *f, struct file_lock *fl,
+static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
 			    loff_t id, char *pfx, int repeat)
 {
 	struct inode *inode = NULL;
 	unsigned int pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
-	int type = fl->fl_core.flc_type;
+	int type = flc->flc_type;
+	struct file_lock *fl = file_lock(flc);
+
+	pid = locks_translate_pid(flc, proc_pidns);
 
-	pid = locks_translate_pid(&fl->fl_core, proc_pidns);
 	/*
 	 * If lock owner is dead (and pid is freed) or not visible in current
 	 * pidns, zero is shown as a pid value. Check lock info from
 	 * init_pid_ns to get saved lock pid value.
 	 */
 
-	if (fl->fl_core.flc_file != NULL)
-		inode = file_inode(fl->fl_core.flc_file);
+	if (flc->flc_file != NULL)
+		inode = file_inode(flc->flc_file);
 
 	seq_printf(f, "%lld: ", id);
 
 	if (repeat)
 		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
 
-	if (fl->fl_core.flc_flags & FL_POSIX) {
-		if (fl->fl_core.flc_flags & FL_ACCESS)
+	if (flc->flc_flags & FL_POSIX) {
+		if (flc->flc_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
-		else if (fl->fl_core.flc_flags & FL_OFDLCK)
+		else if (flc->flc_flags & FL_OFDLCK)
 			seq_puts(f, "OFDLCK");
 		else
 			seq_puts(f, "POSIX ");
 
 		seq_printf(f, " %s ",
 			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");
-	} else if (fl->fl_core.flc_flags & FL_FLOCK) {
+	} else if (flc->flc_flags & FL_FLOCK) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
-	} else if (fl->fl_core.flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
+	} else if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
 		type = target_leasetype(fl);
 
-		if (fl->fl_core.flc_flags & FL_DELEG)
+		if (flc->flc_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
 			seq_puts(f, "LEASE  ");
 
 		if (lease_breaking(fl))
 			seq_puts(f, "BREAKING  ");
-		else if (fl->fl_core.flc_file)
+		else if (flc->flc_file)
 			seq_puts(f, "ACTIVE    ");
 		else
 			seq_puts(f, "BREAKER   ");
@@ -2781,7 +2783,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else {
 		seq_printf(f, "%d <none>:0 ", pid);
 	}
-	if (fl->fl_core.flc_flags & FL_POSIX) {
+	if (flc->flc_flags & FL_POSIX) {
 		if (fl->fl_end == OFFSET_MAX)
 			seq_printf(f, "%Ld EOF\n", fl->fl_start);
 		else
@@ -2791,18 +2793,18 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	}
 }
 
-static struct file_lock *get_next_blocked_member(struct file_lock *node)
+static struct file_lock_core *get_next_blocked_member(struct file_lock_core *node)
 {
-	struct file_lock *tmp;
+	struct file_lock_core *tmp;
 
 	/* NULL node or root node */
-	if (node == NULL || node->fl_core.flc_blocker == NULL)
+	if (node == NULL || node->flc_blocker == NULL)
 		return NULL;
 
 	/* Next member in the linked list could be itself */
-	tmp = list_next_entry(node, fl_core.flc_blocked_member);
-	if (list_entry_is_head(tmp, &node->fl_core.flc_blocker->flc_blocked_requests,
-			       fl_core.flc_blocked_member)
+	tmp = list_next_entry(node, flc_blocked_member);
+	if (list_entry_is_head(tmp, &node->flc_blocker->flc_blocked_requests,
+			       flc_blocked_member)
 		|| tmp == node) {
 		return NULL;
 	}
@@ -2813,18 +2815,18 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
-	struct file_lock *cur, *tmp;
+	struct file_lock_core *cur, *tmp;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int level = 0;
 
-	cur = hlist_entry(v, struct file_lock, fl_core.flc_link);
+	cur = hlist_entry(v, struct file_lock_core, flc_link);
 
-	if (locks_translate_pid(&cur->fl_core, proc_pidns) == 0)
+	if (locks_translate_pid(cur, proc_pidns) == 0)
 		return 0;
 
-	/* View this crossed linked list as a binary tree, the first member of fl_blocked_requests
+	/* View this crossed linked list as a binary tree, the first member of flc_blocked_requests
 	 * is the left child of current node, the next silibing in flc_blocked_member is the
-	 * right child, we can alse get the parent of current node from fl_blocker, so this
+	 * right child, we can alse get the parent of current node from flc_blocker, so this
 	 * question becomes traversal of a binary tree
 	 */
 	while (cur != NULL) {
@@ -2833,18 +2835,18 @@ static int locks_show(struct seq_file *f, void *v)
 		else
 			lock_get_status(f, cur, iter->li_pos, "", level);
 
-		if (!list_empty(&cur->fl_core.flc_blocked_requests)) {
+		if (!list_empty(&cur->flc_blocked_requests)) {
 			/* Turn left */
-			cur = list_first_entry_or_null(&cur->fl_core.flc_blocked_requests,
-						       struct file_lock,
-						       fl_core.flc_blocked_member);
+			cur = list_first_entry_or_null(&cur->flc_blocked_requests,
+						       struct file_lock_core,
+						       flc_blocked_member);
 			level++;
 		} else {
 			/* Turn right */
 			tmp = get_next_blocked_member(cur);
 			/* Fall back to parent node */
-			while (tmp == NULL && cur->fl_core.flc_blocker != NULL) {
-				cur = file_lock(cur->fl_core.flc_blocker);
+			while (tmp == NULL && cur->flc_blocker != NULL) {
+				cur = cur->flc_blocker;
 				level--;
 				tmp = get_next_blocked_member(cur);
 			}
@@ -2859,14 +2861,13 @@ static void __show_fd_locks(struct seq_file *f,
 			struct list_head *head, int *id,
 			struct file *filp, struct files_struct *files)
 {
-	struct file_lock *fl;
+	struct file_lock_core *fl;
 
-	list_for_each_entry(fl, head, fl_core.flc_list) {
+	list_for_each_entry(fl, head, flc_list) {
 
-		if (filp != fl->fl_core.flc_file)
+		if (filp != fl->flc_file)
 			continue;
-		if (fl->fl_core.flc_owner != files &&
-		    fl->fl_core.flc_owner != filp)
+		if (fl->flc_owner != files && fl->flc_owner != filp)
 			continue;
 
 		(*id)++;

-- 
2.43.0


