Return-Path: <linux-fsdevel+bounces-9736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9F844BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE20B2D865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE2405F8;
	Wed, 31 Jan 2024 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6y3TvL7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BC405D8;
	Wed, 31 Jan 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742160; cv=none; b=t6bBnAymU8JBlNMYGwzHlHZtD7Iby3rWgJirmTEBEXv50lyzDNoI+nVGYg1lMnqnuSS8vqu2PGFOKrn+pTaWBk6/vsmxpIoom6IqIO1YvoUeIR6AX8Shn6g3V5tmPhuWcIjOJ8MZvCyC96wQYGL/JYGVD8rj0aq6ioCMvmqXp4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742160; c=relaxed/simple;
	bh=euQqh/A/+3u/1dNNztrBljXWB1tU1Qxda+6XvMysb2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tM44cTe6Y1vgh7CjhAIVXBDGhKc0VX0N/5buRzdeKgt1AOgt3UF7giIchVdXMX+ru/mvLtiEkRqTnupqjrdfyJ1VvnglC9j5O5rHf7MxzF53QjtxCvagQjGD4is9Rk9dhOPHKVk/rciH+JQV5hg45zkyUvBOYyymUovoRQ+iyGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6y3TvL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715EDC43330;
	Wed, 31 Jan 2024 23:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742160;
	bh=euQqh/A/+3u/1dNNztrBljXWB1tU1Qxda+6XvMysb2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K6y3TvL7j0rQElOl8HMEpLwbfrfxXuMKxVdoFQ3vgJ3ncwuuu/kBtLNyze9uTYgLs
	 Mtlxb4165EITslBjPrQMVOf0HhqhJ5Sgb8om56edXFSr4W8+9lPr3oLG8hRZyQacDm
	 /A7YiqoDAVF4wKGXipQa2IFjzr7xuRNnYRTtWD24A3OnCWSydmKS8QZuj5QTDJtqGI
	 hfY3wHpUjDqryoK2iEQCmDfTzVDkWh0YiMc4A0Bn0GA3nypjgHP7XuXassRrzPYfsy
	 tTESwFBLmDYV0KC18FtIkGnlvf7CB/tZJ5PsSJPhxllRR+LlpAnNVZqa5dq6Y/BlJA
	 6SMqYNSXYty2w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:47 -0500
Subject: [PATCH v3 06/47] afs: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-6-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4039; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=euQqh/A/+3u/1dNNztrBljXWB1tU1Qxda+6XvMysb2g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFv8yrZZCeCMjQ60t++Gsw+NdizIjXTDmNg4
 KOb65q4wzOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FZ4QD/9Vi6c4kB8+RSFR5LlyQN3yX1tMkrbOdr9+a+r9Xyjc4SMI1Byv14fPo4Zo/pVtd0wgJ64
 DqLL+0QXI+LAul0z1i/FEqi4nZFzePe7gwvo0B2rEJNlybGkWogHndodfkHg/h+k3MFtSVIRJHS
 yrAPe1xgxYZKCysYMrwPz0lT7+8sBpCYawrQ3XXFB7MOI9Vu9V7T5zxsp9JlmlMm0gyl7Pa1sRA
 kss+/mFdpBSrOiTsc9Q6R2AqCgTh8Dlb215EMZNKdIRznapilE5aXyUDz721aL9kUUro9aYpMf7
 DMR5k1OFfCN65imlnt0XWAiHpte7Sy/wsXCgda+TYqh6LQB9qqvfJAke22Yz2yTs9jbZHIfv/J9
 Q8WXmhhWFJK0G9od4Bppa+qpW0bmdqrorEHJcUVRnw46OgVACua/gCsO88Hu6OTf66mo8U48lrA
 6KFTGCyA88BHNr/65GpaQgC76t5EK4aqeHtnxPOKjlITvUbp6F5Si3upRwZyxLkhTKKVjj/pDlj
 GqbmFsMDqEDwsOHtj/Exq5+WcmPELcMCA4bIalDR9zLJsn9JQ3U7jGqBvcZ+qV5KEne7NwudjrD
 /eOiw4QyENYJ6C8NmZkah7xN0Zi8Tq3qY55ibo7IEFtbafCO59jFROGFEcwXtM9YGuhuVswEuT1
 edoNh7AArUatVLQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions. Also, in later
patches we're going to introduce macros that conflict with the variable
name in afs_next_locker. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/flock.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 9c6dea3139f5..4eee3d1ca5ad 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -93,13 +93,13 @@ static void afs_grant_locks(struct afs_vnode *vnode)
 	bool exclusive = (vnode->lock_type == AFS_LOCK_WRITE);
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
-		if (!exclusive && p->fl_type == F_WRLCK)
+		if (!exclusive && lock_is_write(p))
 			continue;
 
 		list_move_tail(&p->fl_u.afs.link, &vnode->granted_locks);
 		p->fl_u.afs.state = AFS_LOCK_GRANTED;
 		trace_afs_flock_op(vnode, p, afs_flock_op_grant);
-		wake_up(&p->fl_wait);
+		locks_wake_up(p);
 	}
 }
 
@@ -112,25 +112,25 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 {
 	struct file_lock *p, *_p, *next = NULL;
 	struct key *key = vnode->lock_key;
-	unsigned int fl_type = F_RDLCK;
+	unsigned int type = F_RDLCK;
 
 	_enter("");
 
 	if (vnode->lock_type == AFS_LOCK_WRITE)
-		fl_type = F_WRLCK;
+		type = F_WRLCK;
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
 		if (error &&
-		    p->fl_type == fl_type &&
+		    p->fl_type == type &&
 		    afs_file_key(p->fl_file) == key) {
 			list_del_init(&p->fl_u.afs.link);
 			p->fl_u.afs.state = error;
-			wake_up(&p->fl_wait);
+			locks_wake_up(p);
 		}
 
 		/* Select the next locker to hand off to. */
 		if (next &&
-		    (next->fl_type == F_WRLCK || p->fl_type == F_RDLCK))
+		    (lock_is_write(next) || lock_is_read(p)))
 			continue;
 		next = p;
 	}
@@ -142,7 +142,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_SETTING);
 		next->fl_u.afs.state = AFS_LOCK_YOUR_TRY;
 		trace_afs_flock_op(vnode, next, afs_flock_op_wake);
-		wake_up(&next->fl_wait);
+		locks_wake_up(next);
 	} else {
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_NONE);
 		trace_afs_flock_ev(vnode, NULL, afs_flock_no_lockers, 0);
@@ -166,7 +166,7 @@ static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
 			       struct file_lock, fl_u.afs.link);
 		list_del_init(&p->fl_u.afs.link);
 		p->fl_u.afs.state = -ENOENT;
-		wake_up(&p->fl_wait);
+		locks_wake_up(p);
 	}
 
 	key_put(vnode->lock_key);
@@ -471,7 +471,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	fl->fl_u.afs.state = AFS_LOCK_PENDING;
 
 	partial = (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX);
-	type = (fl->fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
+	type = lock_is_read(fl) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
 	if (mode == afs_flock_mode_write && partial)
 		type = AFS_LOCK_WRITE;
 
@@ -734,7 +734,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 
 	/* check local lock records first */
 	posix_test_lock(file, fl);
-	if (fl->fl_type == F_UNLCK) {
+	if (lock_is_unlock(fl)) {
 		/* no local locks; consult the server */
 		ret = afs_fetch_status(vnode, key, false, NULL);
 		if (ret < 0)
@@ -778,7 +778,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
 	trace_afs_flock_op(vnode, fl, afs_flock_op_lock);
 
-	if (fl->fl_type == F_UNLCK)
+	if (lock_is_unlock(fl))
 		ret = afs_do_unlk(file, fl);
 	else
 		ret = afs_do_setlk(file, fl);
@@ -820,7 +820,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 	trace_afs_flock_op(vnode, fl, afs_flock_op_flock);
 
 	/* we're simulating flock() locks using posix locks on the server */
-	if (fl->fl_type == F_UNLCK)
+	if (lock_is_unlock(fl))
 		ret = afs_do_unlk(file, fl);
 	else
 		ret = afs_do_setlk(file, fl);

-- 
2.43.0


