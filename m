Return-Path: <linux-fsdevel+bounces-9767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81624844C71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C9128D28F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221FE148FFF;
	Wed, 31 Jan 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc8E7uPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9521487F8;
	Wed, 31 Jan 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742283; cv=none; b=scykox56b3WhydckRsECb34jGvKDAbKONTfdBe14XFeX6ojji9tC/Yin3Dh52nu2EXuKPflE0hQMb1utXauw+EtwVKSd+bAwX3P24V5ovJg9BNnvUr5dUrlmo8g7jsEGJu7JaPnyIb3mOs5QIXWIGKvwdL70jDO/5Kit36/7ruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742283; c=relaxed/simple;
	bh=P2mftGY8+3jqRTT4GbeHxI5uwsZT5isNJfmn++ZI1Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/nGPE5m8ra5/64tOlZ+zzFFzheX6M1b8YEpTQQputj1LNzrT7mXBk/1VZiO9L+AaveXUhQz6mHEQ7OJ0LIHWV+x/+QGrkiyj1BM4tMLR1iYKuNn3KS7ccqBJ7bIYOlCK5i4Kb9lcxWeoVxgX7Vqmgge7m3ND8iNy6jlLlRX9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc8E7uPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805DFC433B2;
	Wed, 31 Jan 2024 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742283;
	bh=P2mftGY8+3jqRTT4GbeHxI5uwsZT5isNJfmn++ZI1Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bc8E7uPZzEjIqMcmVpMTC2B0blbxKheGwD1g/0gaWMLjljSPqD5kslOS7LlaVmDVi
	 trkAlBztwvp+27E6+qTTj15LlWGwS0fK8LJ7zVLtc5hkTj273sdZ1iCq5mTuKSq4Im
	 xH6yvPZ1CqeQpfaxZvkW9fV5l/dzy17034f5OkrbvLc97MYzuBzmrxaZRmveqys/1m
	 hh8T+VIKGZkTYkczPuJ93lmeY1lm2JZDS+wZA02eVOviro3olJ8XEEWHjGPSOOmcwo
	 sfd33z/gA8yv8J/IAn6H7Lm3LTid8RmWAMovr+8ZnOz+LkayPAf+tdwAYgvmU8QnAE
	 jJP+pLtGW+R8w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:18 -0500
Subject: [PATCH v3 37/47] dlm: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-37-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5038; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=P2mftGY8+3jqRTT4GbeHxI5uwsZT5isNJfmn++ZI1Bk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFzb1zHWnDUvdn7dUCqkyMWmb0Imqnfb554q
 Ee53RbtrMuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcwAKCRAADmhBGVaC
 FSHID/4tsdwz2xYdPgYBK79/g0K0lrGcQCKjypuyTtD5w+IGCgOP08M3e4uBlRz/trqt7XLu12+
 pPnwjVurb7JDU/HZZbLIiHYcxlZLUmPXr5QEEX+0Xs9aGqwpagTLCBIFIm1Vly5qrfyFuzfXUZ8
 MhV1n9+CnAl9kS02N7S2QumuCmfYQ2XZ2oR8H/RIw3PFa5uLphyrfoOOPJ7TKl1u9JAxQwyyq0z
 V+Iq19y/azY+DrWrOVqDZ/IJvdrOqs+3wzZkOfndW+MD3Z+PQpsiFGfqCvuZSGh+/nlnltY1PIc
 12EF6bPV2Qf6Db4sCLzsVYPzJ/UHlPWAVJhhJTcfc7P8H2FJsKqEL5iESCdAnmThLcP/mCX5Y66
 vV0tbZ50rbHb51Tln1s1HMPximLcivGRFupLMQCiAXkGWXT0IRsaMke8fLviSC+MrYDm3z9+z/L
 CtxmIS5u5WuS9pYz54Ury8bsZSOP3QBoN8tNbFIAPDOA14Tt15ijmj2R8QE3gazUvH4/ZwIWgK8
 mNuCb7JQ9VjqpvBfffh6aYLEiEW3pZ0K+OyOIJsLC/EIm65s3N+LU52j/Gvqe1mba2Px55xSZGw
 qGilOoQ2C5oB+HNc2QhvNSvdlPvxt8E6/fNxVa/jO/Yd6QS4Vsv2Rba2FxVxXHRWDA8+lEHCTSl
 78Y4uaEWldNrAEA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/dlm/plock.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index fdcddbb96d40..9ca83ef70ed1 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
@@ -139,14 +138,14 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
-	op->info.pid		= fl->fl_pid;
-	op->info.ex		= (lock_is_write(fl));
-	op->info.wait		= !!(fl->fl_flags & FL_SLEEP);
+	op->info.pid		= fl->c.flc_pid;
+	op->info.ex		= lock_is_write(fl);
+	op->info.wait		= !!(fl->c.flc_flags & FL_SLEEP);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->c.flc_owner;
 	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
 		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
@@ -259,7 +258,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	}
 
 	/* got fs lock; bookkeep locally as well: */
-	flc->fl_flags &= ~FL_SLEEP;
+	flc->c.flc_flags &= ~FL_SLEEP;
 	if (posix_lock_file(file, flc, NULL)) {
 		/*
 		 * This can only happen in the case of kmalloc() failure.
@@ -292,7 +291,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct dlm_ls *ls;
 	struct plock_op *op;
 	int rv;
-	unsigned char saved_flags = fl->fl_flags;
+	unsigned char saved_flags = fl->c.flc_flags;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
@@ -305,7 +304,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	/* cause the vfs unlock to return ENOENT if lock is not found */
-	fl->fl_flags |= FL_EXISTS;
+	fl->c.flc_flags |= FL_EXISTS;
 
 	rv = locks_lock_file_wait(file, fl);
 	if (rv == -ENOENT) {
@@ -318,14 +317,14 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_UNLOCK;
-	op->info.pid		= fl->fl_pid;
+	op->info.pid		= fl->c.flc_pid;
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->c.flc_owner;
 
-	if (fl->fl_flags & FL_CLOSE) {
+	if (fl->c.flc_flags & FL_CLOSE) {
 		op->info.flags |= DLM_PLOCK_FL_CLOSE;
 		send_op(op);
 		rv = 0;
@@ -346,7 +345,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
-	fl->fl_flags = saved_flags;
+	fl->c.flc_flags = saved_flags;
 	return rv;
 }
 EXPORT_SYMBOL_GPL(dlm_posix_unlock);
@@ -376,14 +375,14 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		return -EINVAL;
 
 	memset(&info, 0, sizeof(info));
-	info.pid = fl->fl_pid;
-	info.ex = (lock_is_write(fl));
+	info.pid = fl->c.flc_pid;
+	info.ex = lock_is_write(fl);
 	info.fsid = ls->ls_global_id;
 	dlm_put_lockspace(ls);
 	info.number = number;
 	info.start = fl->fl_start;
 	info.end = fl->fl_end;
-	info.owner = (__u64)(long)fl->fl_owner;
+	info.owner = (__u64)(long) fl->c.flc_owner;
 
 	rv = do_lock_cancel(&info);
 	switch (rv) {
@@ -438,13 +437,13 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_GET;
-	op->info.pid		= fl->fl_pid;
-	op->info.ex		= (lock_is_write(fl));
+	op->info.pid		= fl->c.flc_pid;
+	op->info.ex		= lock_is_write(fl);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->c.flc_owner;
 
 	send_op(op);
 	wait_event(recv_wq, (op->done != 0));
@@ -456,16 +455,16 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	rv = op->info.rv;
 
-	fl->fl_type = F_UNLCK;
+	fl->c.flc_type = F_UNLCK;
 	if (rv == -ENOENT)
 		rv = 0;
 	else if (rv > 0) {
 		locks_init_lock(fl);
-		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
-		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = op->info.pid;
+		fl->c.flc_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
+		fl->c.flc_flags = FL_POSIX;
+		fl->c.flc_pid = op->info.pid;
 		if (op->info.nodeid != dlm_our_nodeid())
-			fl->fl_pid = -fl->fl_pid;
+			fl->c.flc_pid = -fl->c.flc_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;

-- 
2.43.0


