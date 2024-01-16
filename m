Return-Path: <linux-fsdevel+bounces-8113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C082F789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A771F25A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDFB224C3;
	Tue, 16 Jan 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRFGk3F8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E54823C7;
	Tue, 16 Jan 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434477; cv=none; b=SYAfvFWViDwxVLJdlzyC0xtbPol55UaGB/iC3R73l1tXEp5zSS7zyJ/WYL6LxwUB/yx8Qktugnl4CETKe7R+kJCWKyVziHNtep6pNhsJIeu2LonCRyNtrLbkENCVhYaHoCVzEBC1iguAibFoAkpodVVcV17THjqJeQKczY0MU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434477; c=relaxed/simple;
	bh=cAmIIbMPxRZTJqkY9XtG7e1FF5ZQvaw1I6KUw0Tops8=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=hnMdH1XOIwMlc9PXz+L5gIst2eUUgkrDk3jqpLkjcWYiGflnPujVe2lucHF+Jk8iNd59oaIqh0vq5L6XjIj9JcliUna5GdMtBKf6+qe8hYbKTlgCav2PvS95GO4/H8gZyX6wQEsBGWsuNQZOPbuWlj60CdlovlH/7VZbmzz4RtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRFGk3F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F3EC433B2;
	Tue, 16 Jan 2024 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434477;
	bh=cAmIIbMPxRZTJqkY9XtG7e1FF5ZQvaw1I6KUw0Tops8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CRFGk3F8SExbxOElcBSBKajj6soClSjjeedXHJ8MjMqo98s9dqZpn6TU+QEbb4IwP
	 mQ2m3I8sbdnIKIJf081yXe2px46aPyWSxFzPXshqq71eJBNaIbWOyklczaVKNn2pX3
	 wehtXnMqsN8nxRvBZIbPKeAWgALOgX4CyfW6AZjcOSyu2A20+6ulb5SQfwQhHvOZ6m
	 PwkyZQYR2+XpgnKbVLgLtqIBJFqsfelrd4Ohtezw5xFnXMhSSOehqZbwIa6BwNiSL+
	 38qfSwkA+4kChPa+TrLwg561uqfaCVEGK0ub46qfNS3Q7xajSUh3zIjAf++Ef1GYv1
	 dx3PZZm8uM4Xw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:14 -0500
Subject: [PATCH 18/20] filelock: convert locks_wake_up_blocks to take a
 file_lock_core pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-18-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cAmIIbMPxRZTJqkY9XtG7e1FF5ZQvaw1I6KUw0Tops8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0iQy2Q/95WI9t43Bv7XN421VQLJ+2klLwZK
 nR6pvJi1PWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIgAKCRAADmhBGVaC
 FVRcD/4yTAkRFFLlCV//Lye7K/pHQlvdc0FyTNkTZ4pThskhFPpBbutOCB+hVuzj1WKVGWd4gVr
 58c7ALPSStiS0wBkN5bpu0z6mYymzdmP34GNrebPcxb6GUm1dp0i3YieUr7dpp4wR91F+YgEOnz
 JIM+Vdz5sx6hP2yQcxd88ttqJXuRXIn2kkFVUu8pFbE9vKl9kt8fAhrwHzGFykv42RjA8T+j382
 Yy9VfBYN7d442yEBepNbMHJR74Cjqay27P4wagefbfbnFSC/2m2CM/+YaNRADrn2x8JsXTRonUF
 ny61DccrUhajMycRsq+1xlB98zlW0aC50beGixktdDzbqU4jRJTUq46JHcjUM9FVMdUhgye5BOa
 /POc/VDgXJHe67TtZjhnPy3MdKrDDO34FkHDHbuIPyGQvgZwAn/NL9WzHUTRyzuj1vwsPfSAwx4
 JOgD5fLKd2Lw/7FKOPcH/a4cE+UK0xkozI8+zSO9KQpbSS/apOuCJbcU5/DJvelU8Aj2gHBw1Ll
 NlY/iSj8XDRUo+Qq6YNBNOTaJWkHs5gqWob/kiGQN0UNSdbnwCsGXDvrTOmj9hlQchN7GY91uAg
 ZEJftHwe2r54pBoYAyTw7qqhHeFYz1q4IJTBL2lFxD/khLmOva63vfBGnYeOz8IuF4Q7tcOncY5
 H9f83H00tXTG+sA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have locks_wake_up_blocks take a file_lock_core pointer, and fix up the
callers to pass one in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 4a1e9457c430..88c72eb4672e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -829,7 +829,7 @@ static void locks_insert_block(struct file_lock_core *blocker,
  *
  * Must be called with the inode->flc_lock held!
  */
-static void locks_wake_up_blocks(struct file_lock *blocker)
+static void locks_wake_up_blocks(struct file_lock_core *blocker)
 {
 	/*
 	 * Avoid taking global lock if list is empty. This is safe since new
@@ -838,11 +838,11 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 	 * fl_blocked_requests list does not require the flc_lock, so we must
 	 * recheck list_empty() after acquiring the blocked_lock_lock.
 	 */
-	if (list_empty(&blocker->fl_core.fl_blocked_requests))
+	if (list_empty(&blocker->fl_blocked_requests))
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	__locks_wake_up_blocks(&blocker->fl_core);
+	__locks_wake_up_blocks(blocker);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -858,7 +858,7 @@ locks_unlink_lock_ctx(struct file_lock *fl)
 {
 	locks_delete_global_locks(&fl->fl_core);
 	list_del_init(&fl->fl_core.fl_list);
-	locks_wake_up_blocks(fl);
+	locks_wake_up_blocks(&fl->fl_core);
 }
 
 static void
@@ -1351,11 +1351,11 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			locks_insert_lock_ctx(left, &fl->fl_core.fl_list);
 		}
 		right->fl_start = request->fl_end + 1;
-		locks_wake_up_blocks(right);
+		locks_wake_up_blocks(&right->fl_core);
 	}
 	if (left) {
 		left->fl_end = request->fl_start - 1;
-		locks_wake_up_blocks(left);
+		locks_wake_up_blocks(&left->fl_core);
 	}
  out:
 	spin_unlock(&ctx->flc_lock);
@@ -1437,7 +1437,7 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 	if (error)
 		return error;
 	lease_clear_pending(fl, arg);
-	locks_wake_up_blocks(fl);
+	locks_wake_up_blocks(&fl->fl_core);
 	if (arg == F_UNLCK) {
 		struct file *filp = fl->fl_core.fl_file;
 

-- 
2.43.0


