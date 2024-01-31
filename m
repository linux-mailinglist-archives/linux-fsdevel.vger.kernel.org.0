Return-Path: <linux-fsdevel+bounces-9738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFA3844BDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D34A1C231B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4146450;
	Wed, 31 Jan 2024 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6TSDctV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC045C07;
	Wed, 31 Jan 2024 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742168; cv=none; b=c7ABhYwidiRMvCbJPVcYwESIfgKa5pWd0aLxpttdiHZ6qG+p0mskIeTHcZXBqBAq4nQyz0K4UMB/CBp/YPAFDS5tM+08AYnYayxatCwqjdEbsTpBt3LPreJmYF6o22HG3Z64wgGs9EQRHakSBlf6qIxFJHH9BPbooZGWnzCKWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742168; c=relaxed/simple;
	bh=nxRAveAqE7WF9Z4q90ZvBndTgcucgYKZ5gjGnB+BWHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsRqiKAhJUECPqV3T0GUgnt0P9ZmvzRaU0CgT3RL0EFEGhMCMGYsGfn3wXWvoJvEFcdi+RAt0/nCfZh16YmTaUnT8nQEjqJ2ZQeTKC/wAkOIbbo5lcpB+oCwNr7Ln5FYm+AgBz6ThS0Barm63uWVsJ+gS9F+RsC5OuOVUVs/l2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6TSDctV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A94C43142;
	Wed, 31 Jan 2024 23:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742168;
	bh=nxRAveAqE7WF9Z4q90ZvBndTgcucgYKZ5gjGnB+BWHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G6TSDctVx0EAoLL7MKJOe7dg6dAQ69yCO5HOY68otxwXguUX1qVr8+FCO6c1AuVL2
	 YmVsaz2EysbtySwd0vVbMAZfL1TaimjEO+x+lYGkf9FW3awXE6Np0AqIeDtDBMTnwH
	 28OwF4AAjGKTUen6L7BBl2nGT490B8FsVC4uPSXHGwwkkRnYMkQ7wv3lIZ6sqkdLW5
	 BQJzUJn+avSuNkZvjPWoMDTDdDwrHl0DlkIZWoU9xVpoTmoxReSb2D6b5SAtPIltdx
	 /7GeZsExlO3Hh5biggJnt8dk7ZE4OJmttPsBB1PCbWmbq+1aLcKrXthPi2xvyUarL6
	 w2myiSNvtMEAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:49 -0500
Subject: [PATCH v3 08/47] dlm: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-8-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nxRAveAqE7WF9Z4q90ZvBndTgcucgYKZ5gjGnB+BWHA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFvbOKPbcg5w9YPlh79kzOLxpbHp7c7796Aw
 c+EXzMZANyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FSdnD/0YO3VvUkyTdJLamrF+VheQvuF2wqr3jNFP/fHAw88i6wMR20Q0W+/dSGKZdx3wZzjbaRK
 r1YnHtyc3ppCVPGqsU1Q+Sd2KH/6VQqfowXAY2jo7svL25xFhAxKQxStToPjow4skvr8GYOQw+3
 QWilBdJr49gEAEeri2QaP6LNeB/CWAiugP8ypphJ10S1JXUXwhwVxJ4w2kctiQQDReU9DXySbOQ
 ljX3WCNIxoe6YH3kmFbMMIc/8IDUOVx/UhVnWQxFz1mTpk8uYj9OQp4rjZXrLC2U5AwUiY1WhzO
 8yJ1NU8PEobtjVAGn4z8Qe2C54YM1UgTvwwGWABmjMnymHdoFvFj2c0yCIK8FVLsHu0VT9uj/+7
 guHuAcJ6uuVa3dy4rv1ly8L+BaBSdzlPLjzbZXVnmNPP0fHR5DBA9Zh7NRDWNluSXo6IegFDFat
 rINPZng0LZHi7Da6fAV94Es/hDLo4SJ26hR0c6CWoJyhS3fCTmQ2EMsMCta88baiDfS3fdKlXoE
 jHvmLC8WJEy1LNcq/8O3FMUWO6vyhjWg7vRV5ovc+OFljB3ACFkXbKtioiVk6gspAA6TNa2rXOt
 coLckJ+ikvz1mc9ZnjkAvcIratWdBcP+gWRicgWQGMB/bksk5ZUnU74ll1F5lo/ZHAF89L8UcPG
 2uY5MVD2xpeeVeQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions. Also, in later
patches we're going to introduce some temporary macros with names that
clash with the variable name in dlm_posix_unlock. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/dlm/plock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index d814c5121367..42c596b900d4 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -139,7 +139,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
 	op->info.pid		= fl->fl_pid;
-	op->info.ex		= (fl->fl_type == F_WRLCK);
+	op->info.ex		= (lock_is_write(fl));
 	op->info.wait		= !!(fl->fl_flags & FL_SLEEP);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
@@ -291,7 +291,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct dlm_ls *ls;
 	struct plock_op *op;
 	int rv;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char saved_flags = fl->fl_flags;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
@@ -345,7 +345,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = saved_flags;
 	return rv;
 }
 EXPORT_SYMBOL_GPL(dlm_posix_unlock);
@@ -376,7 +376,7 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	memset(&info, 0, sizeof(info));
 	info.pid = fl->fl_pid;
-	info.ex = (fl->fl_type == F_WRLCK);
+	info.ex = (lock_is_write(fl));
 	info.fsid = ls->ls_global_id;
 	dlm_put_lockspace(ls);
 	info.number = number;
@@ -438,7 +438,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	op->info.optype		= DLM_PLOCK_OP_GET;
 	op->info.pid		= fl->fl_pid;
-	op->info.ex		= (fl->fl_type == F_WRLCK);
+	op->info.ex		= (lock_is_write(fl));
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;

-- 
2.43.0


