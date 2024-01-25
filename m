Return-Path: <linux-fsdevel+bounces-8904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE49C83BFED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35511C20B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A1664BD;
	Thu, 25 Jan 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBVOlKdK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8065BAD;
	Thu, 25 Jan 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179518; cv=none; b=fZ5QAzNy7d4v5QgIRLeovvTm5jUptrcXzG6QQqMnhmD0OoJxXFaQj/WYe0gyBllwy0Q/stQSK87ExPdgfC91R8axIlswKe13KKUxlF8n/uJXyN9CtRC86ToWvaQazTIHYYItCOcRtl8XXtZU/pveKMYopqeuo9pmg7UVJMgRTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179518; c=relaxed/simple;
	bh=8OEJAMKjJtMP3gQQ/4s+/aqMUuEPd9kVijNe+p2LZWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FN0GDxnRZ3ZZdCgmyXd/Cd0tXiTiutgi1J7fLpylrsMQz3qqUwtF63+qh1082vDJvKKSBN9ZEfYItOAk7BqnwMZLq62oqaBdI9wZkr4lWfqOZGWcvw22L7+Crw6YotywTZgAewGrT1ylXoRPNBYk4rzraDmvo2dsh/qZDqZZmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBVOlKdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DBCC43390;
	Thu, 25 Jan 2024 10:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179517;
	bh=8OEJAMKjJtMP3gQQ/4s+/aqMUuEPd9kVijNe+p2LZWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GBVOlKdK2Syi7Bxz4hmjBDvSGJ4R4YiE9W4FGG3rurhjO51Mo2dVWXg42eFyzVUdK
	 F8vwl3otN4QCX4Xpi0cewqUM4xauPpFf949InH1CgBTwYKyt+A825H7QcDvuz/QlK2
	 U4P1j5L3NzffUkECBS0M/2l86ZWgyaCaBqLVR1WohCWebPNaUh295ABOoFX0u6Gxd7
	 OCn3Qd10Kfio9Ws84o+7sAgQqzFGZ1EX20G2/EUmXqVT+GdDvqER5apxZ7ga8oz7Lf
	 PFQJRXZcB0YYZ1OEw43AU2uZNa3yRxrMOeFozhS5YXwxoM9pKYhdxNyi9zxUaV0Uh2
	 LLLqs8UaJpIdQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:13 -0500
Subject: [PATCH v2 32/41] dlm: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-32-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5221; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8OEJAMKjJtMP3gQQ/4s+/aqMUuEPd9kVijNe+p2LZWI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+J3EWJEmklSu0dTF/7aEoCXaYmUzqlZk0z
 BMnwHDjdLGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 FX9EEACvpf3Am1XlKZ8gE7vV9mjusPzF/XPNZlQDvb21/K76jSlbWCBi8y3UTwWclbv3brNxdKL
 5q3XA5C4p4WCEkRvbc6PhCzLRjZ6P8Vsd004IQ64qOLB1PRnYhhzedPXf+OMqVe57UBFVo5Kl7l
 UzcEt8SFfgDG9qQpqJpPVNApCFn0g6qawWhPC/i34YDI/GBQejzkzffXUGHvIpj44rdRVnaJRYu
 42qX0FGmFMekBN1b/CUSfjtN/LVnO3RVfBweR1kqaCb9/udYP7G9sQnVSKRlZvT4/HabNysI29G
 mlxqWyX1zSXKclgXuLe6KzxflxuaYROQiXrCBRdxN4O7TxiD4BBnBr6c3L5er6L2sPv7supN3s8
 CUelIf56e5kKPQkKxmnYYMdoDpmsa6om5vsWxp68c2Ih/Fs0bY59lf/R6A+lqIa8Rt4S4Ln12Qj
 OVhTjOIq1jXubmB+CNER5zNN61fV52qtGboQqlfcvDuHd33WX1Nw/4XDRNrkbzMHYwi4W/bZPbZ
 htmcRiVRopVw0lJkVugQGD+UN3oYJ48PQD2AJL77WyUs3sLjr54/7iOHee18G2XN9z2Pnon11pZ
 PDY5pWHAMG7qxum9N5OoWBvAEC5XODSzbVNWY4FwlJ/MgTRcUj65qxC7G4WhyUue7uP9g1GuR7U
 2hMBAj0M63TUzLg==
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
index b89dca1d51b0..b3e9fb9df808 100644
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
-	op->info.ex		= (fl->fl_type == F_WRLCK);
-	op->info.wait		= !!(fl->fl_flags & FL_SLEEP);
+	op->info.pid		= fl->fl_core.flc_pid;
+	op->info.ex		= (fl->fl_core.flc_type == F_WRLCK);
+	op->info.wait		= !!(fl->fl_core.flc_flags & FL_SLEEP);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->fl_core.flc_owner;
 	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
 		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
@@ -259,7 +258,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	}
 
 	/* got fs lock; bookkeep locally as well: */
-	flc->fl_flags &= ~FL_SLEEP;
+	flc->fl_core.flc_flags &= ~FL_SLEEP;
 	if (posix_lock_file(file, flc, NULL)) {
 		/*
 		 * This can only happen in the case of kmalloc() failure.
@@ -292,7 +291,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct dlm_ls *ls;
 	struct plock_op *op;
 	int rv;
-	unsigned char saved_flags = fl->fl_flags;
+	unsigned char saved_flags = fl->fl_core.flc_flags;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
@@ -305,7 +304,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	/* cause the vfs unlock to return ENOENT if lock is not found */
-	fl->fl_flags |= FL_EXISTS;
+	fl->fl_core.flc_flags |= FL_EXISTS;
 
 	rv = locks_lock_file_wait(file, fl);
 	if (rv == -ENOENT) {
@@ -318,14 +317,14 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_UNLOCK;
-	op->info.pid		= fl->fl_pid;
+	op->info.pid		= fl->fl_core.flc_pid;
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->fl_core.flc_owner;
 
-	if (fl->fl_flags & FL_CLOSE) {
+	if (fl->fl_core.flc_flags & FL_CLOSE) {
 		op->info.flags |= DLM_PLOCK_FL_CLOSE;
 		send_op(op);
 		rv = 0;
@@ -346,7 +345,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
-	fl->fl_flags = saved_flags;
+	fl->fl_core.flc_flags = saved_flags;
 	return rv;
 }
 EXPORT_SYMBOL_GPL(dlm_posix_unlock);
@@ -376,14 +375,14 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		return -EINVAL;
 
 	memset(&info, 0, sizeof(info));
-	info.pid = fl->fl_pid;
-	info.ex = (fl->fl_type == F_WRLCK);
+	info.pid = fl->fl_core.flc_pid;
+	info.ex = (fl->fl_core.flc_type == F_WRLCK);
 	info.fsid = ls->ls_global_id;
 	dlm_put_lockspace(ls);
 	info.number = number;
 	info.start = fl->fl_start;
 	info.end = fl->fl_end;
-	info.owner = (__u64)(long)fl->fl_owner;
+	info.owner = (__u64)(long) fl->fl_core.flc_owner;
 
 	rv = do_lock_cancel(&info);
 	switch (rv) {
@@ -438,13 +437,13 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_GET;
-	op->info.pid		= fl->fl_pid;
-	op->info.ex		= (fl->fl_type == F_WRLCK);
+	op->info.pid		= fl->fl_core.flc_pid;
+	op->info.ex		= (fl->fl_core.flc_type == F_WRLCK);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->fl_core.flc_owner;
 
 	send_op(op);
 	wait_event(recv_wq, (op->done != 0));
@@ -456,16 +455,16 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	rv = op->info.rv;
 
-	fl->fl_type = F_UNLCK;
+	fl->fl_core.flc_type = F_UNLCK;
 	if (rv == -ENOENT)
 		rv = 0;
 	else if (rv > 0) {
 		locks_init_lock(fl);
-		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
-		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = op->info.pid;
+		fl->fl_core.flc_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
+		fl->fl_core.flc_flags = FL_POSIX;
+		fl->fl_core.flc_pid = op->info.pid;
 		if (op->info.nodeid != dlm_our_nodeid())
-			fl->fl_pid = -fl->fl_pid;
+			fl->fl_core.flc_pid = -fl->fl_core.flc_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;

-- 
2.43.0


