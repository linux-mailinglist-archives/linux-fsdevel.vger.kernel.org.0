Return-Path: <linux-fsdevel+bounces-9763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397C844C5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E401F29B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBAB14691B;
	Wed, 31 Jan 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXjwt2MW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA7146909;
	Wed, 31 Jan 2024 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742267; cv=none; b=uxm6C2sW9YK2QAFXpG8QD7VnD6GxVNeRH5Ex2zMf2TUwcEzGDLMxVxIflkHCtY3SrfvOuq05LPePV1mtyf30vGNvrigNXzdNgceF7SPf3kUoLgqePlQu2q+k6R0fBUnyn8X8TrCjshpR4KEltGMHCFkbItzc7Zkb+vAGQJ3K4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742267; c=relaxed/simple;
	bh=nv8eptBPFBD1zSehgok4Q6KkOnT9m4GjZYDWX89CcGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCPCF7j4s1rIOt8YJmZYXrHunleKho+VKFWNxXWdRb3pmNTOjUSDB6eArL0l9h/L7Bg6phPwWnqR4j47ga/IOHMO1yFCa4EIBdUl34ptxsHk6Jqvtb2pLaxobN69BNveaIuxdZ9U7m+0FaYjxMo6E885+MqBQqVMQjYeBoqgNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXjwt2MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A332CC43390;
	Wed, 31 Jan 2024 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742267;
	bh=nv8eptBPFBD1zSehgok4Q6KkOnT9m4GjZYDWX89CcGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EXjwt2MW9GCsL2BcTs78Katqm1uyNoTrFaHmbfCrr+Q53EZeAnKXhY919+WZr147B
	 yJlSNd5Wk89B8F+FESZE+d5RkLwopV/oCqyCCdejaTjDZqfOQNcpvSapaiDN/sXmjh
	 2nfLujw/457ohNsJ+tWr/916rGu9xk61b42Y4tpm9kf+gyJzR3Bu6ZX3trRWsFj1HB
	 9s9xbOzR3PA5Ry+3RK9JVgyRRoMK5vGFfnCeGKu8tGvLsnbiEe1D7XW0Ja1fadeUrv
	 j71y4gMRltxgUDDf2wW3TWy8Uyu2JnoS37XB2/gfAoThnATcf1FP9dYyb3m2dd1hJl
	 qpid7Nkt1mGsA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:14 -0500
Subject: [PATCH v3 33/47] filelock: convert seqfile handling to use
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-33-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6366; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nv8eptBPFBD1zSehgok4Q6KkOnT9m4GjZYDWX89CcGw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFyfLhhLIWchVjpzK8MH79H68ZFxzyYPdkWy
 QQncxKMD1GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcgAKCRAADmhBGVaC
 FSVlEADVr6Q8kq+/ObinNGeVbvxJHlRJ+rlVe5XcIvyd5ZQWGw3ngLwDwBSL3hiqURCGyMCrWJ7
 1xujBdYU6PG82u5vfkOXOiEld5nlQHOY28qF7lnJZATXCeyZpVFhEjLstvjr52HM3+eO8QXpH0Y
 BwLa0FgqQbO10FsVYB9HtzjzLUzAlM+3MObYJ/+coJGB2OZ57OxND6ao2Dykp+KF5shHp9NfSYS
 lMnoPw8HmiCKowqshbykaEGTPQNA6KMFiBYruFFIPsOXYihMGbZpjDbKMUvRWl94RfXolcVu4sA
 L1MQW+8F876IkBFTZjpbPmADAZctkQK08Dn2H+fT2hxP1FDIiXjHrQdUBTnL3NfE9PuT0oPFJ0H
 9ckL8T/SMbxqy2HnmZ/UsHN5YM1FFaYGTBPX7i4XHfTTuSRdnztjmjQhjBQFFEZ8Y6gA0oUQkMX
 pPfrSxFSAm9Vja/dXcpkw2Vk0El7yjN/+tCcxgKrXS/pEdNNrbvhobjAhWBf+Q6vjHYc/daEH8j
 57JcbwIe6mRP+Lj6FXa6IrZRxehG7lW7k880Q9nPV5ttqmrPdkps9b6L98/JO/1jjtex+tpZetH
 Wnvvf69Glfv6/0XRP8fH83xG4s3kS6y8VmmtAChqiZYyAokBWBUaPoU87X06J9JSRDKjpeEs3Pu
 QFQvm77U5iPUjHw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Reduce some pointer manipulation by just using file_lock_core where we
can and only translate to a file_lock when needed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 72 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 97f6e9163130..1a4b01203d3d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2718,52 +2718,53 @@ struct locks_iterator {
 	loff_t	li_pos;
 };
 
-static void lock_get_status(struct seq_file *f, struct file_lock *fl,
+static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
 			    loff_t id, char *pfx, int repeat)
 {
 	struct inode *inode = NULL;
 	unsigned int pid;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
-	int type = fl->c.flc_type;
+	int type = flc->flc_type;
+	struct file_lock *fl = file_lock(flc);
+
+	pid = locks_translate_pid(flc, proc_pidns);
 
-	pid = locks_translate_pid(&fl->c, proc_pidns);
 	/*
 	 * If lock owner is dead (and pid is freed) or not visible in current
 	 * pidns, zero is shown as a pid value. Check lock info from
 	 * init_pid_ns to get saved lock pid value.
 	 */
-
-	if (fl->c.flc_file != NULL)
-		inode = file_inode(fl->c.flc_file);
+	if (flc->flc_file != NULL)
+		inode = file_inode(flc->flc_file);
 
 	seq_printf(f, "%lld: ", id);
 
 	if (repeat)
 		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
 
-	if (fl->c.flc_flags & FL_POSIX) {
-		if (fl->c.flc_flags & FL_ACCESS)
+	if (flc->flc_flags & FL_POSIX) {
+		if (flc->flc_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
-		else if (fl->c.flc_flags & FL_OFDLCK)
+		else if (flc->flc_flags & FL_OFDLCK)
 			seq_puts(f, "OFDLCK");
 		else
 			seq_puts(f, "POSIX ");
 
 		seq_printf(f, " %s ",
 			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");
-	} else if (fl->c.flc_flags & FL_FLOCK) {
+	} else if (flc->flc_flags & FL_FLOCK) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
-	} else if (fl->c.flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
+	} else if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
 		type = target_leasetype(fl);
 
-		if (fl->c.flc_flags & FL_DELEG)
+		if (flc->flc_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
 			seq_puts(f, "LEASE  ");
 
 		if (lease_breaking(fl))
 			seq_puts(f, "BREAKING  ");
-		else if (fl->c.flc_file)
+		else if (flc->flc_file)
 			seq_puts(f, "ACTIVE    ");
 		else
 			seq_puts(f, "BREAKER   ");
@@ -2781,7 +2782,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else {
 		seq_printf(f, "%d <none>:0 ", pid);
 	}
-	if (fl->c.flc_flags & FL_POSIX) {
+	if (flc->flc_flags & FL_POSIX) {
 		if (fl->fl_end == OFFSET_MAX)
 			seq_printf(f, "%Ld EOF\n", fl->fl_start);
 		else
@@ -2791,18 +2792,18 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	}
 }
 
-static struct file_lock *get_next_blocked_member(struct file_lock *node)
+static struct file_lock_core *get_next_blocked_member(struct file_lock_core *node)
 {
-	struct file_lock *tmp;
+	struct file_lock_core *tmp;
 
 	/* NULL node or root node */
-	if (node == NULL || node->c.flc_blocker == NULL)
+	if (node == NULL || node->flc_blocker == NULL)
 		return NULL;
 
 	/* Next member in the linked list could be itself */
-	tmp = list_next_entry(node, c.flc_blocked_member);
-	if (list_entry_is_head(tmp, &node->c.flc_blocker->flc_blocked_requests,
-			       c.flc_blocked_member)
+	tmp = list_next_entry(node, flc_blocked_member);
+	if (list_entry_is_head(tmp, &node->flc_blocker->flc_blocked_requests,
+			       flc_blocked_member)
 		|| tmp == node) {
 		return NULL;
 	}
@@ -2813,18 +2814,18 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
-	struct file_lock *cur, *tmp;
+	struct file_lock_core *cur, *tmp;
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int level = 0;
 
-	cur = hlist_entry(v, struct file_lock, c.flc_link);
+	cur = hlist_entry(v, struct file_lock_core, flc_link);
 
-	if (locks_translate_pid(&cur->c, proc_pidns) == 0)
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
@@ -2833,18 +2834,18 @@ static int locks_show(struct seq_file *f, void *v)
 		else
 			lock_get_status(f, cur, iter->li_pos, "", level);
 
-		if (!list_empty(&cur->c.flc_blocked_requests)) {
+		if (!list_empty(&cur->flc_blocked_requests)) {
 			/* Turn left */
-			cur = list_first_entry_or_null(&cur->c.flc_blocked_requests,
-						       struct file_lock,
-						       c.flc_blocked_member);
+			cur = list_first_entry_or_null(&cur->flc_blocked_requests,
+						       struct file_lock_core,
+						       flc_blocked_member);
 			level++;
 		} else {
 			/* Turn right */
 			tmp = get_next_blocked_member(cur);
 			/* Fall back to parent node */
-			while (tmp == NULL && cur->c.flc_blocker != NULL) {
-				cur = file_lock(cur->c.flc_blocker);
+			while (tmp == NULL && cur->flc_blocker != NULL) {
+				cur = cur->flc_blocker;
 				level--;
 				tmp = get_next_blocked_member(cur);
 			}
@@ -2859,14 +2860,13 @@ static void __show_fd_locks(struct seq_file *f,
 			struct list_head *head, int *id,
 			struct file *filp, struct files_struct *files)
 {
-	struct file_lock *fl;
+	struct file_lock_core *fl;
 
-	list_for_each_entry(fl, head, c.flc_list) {
+	list_for_each_entry(fl, head, flc_list) {
 
-		if (filp != fl->c.flc_file)
+		if (filp != fl->flc_file)
 			continue;
-		if (fl->c.flc_owner != files &&
-		    fl->c.flc_owner != filp)
+		if (fl->flc_owner != files && fl->flc_owner != filp)
 			continue;
 
 		(*id)++;

-- 
2.43.0


