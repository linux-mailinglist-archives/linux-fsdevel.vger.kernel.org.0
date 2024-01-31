Return-Path: <linux-fsdevel+bounces-9769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBE844C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9201F217C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769714A4CD;
	Wed, 31 Jan 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzP645gD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33863A8F2;
	Wed, 31 Jan 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742291; cv=none; b=k0u4Z+Ht0KdHIRe0EXNEzWtIvqXR4Gq4rvSI7vAObRea1W6hAkwhDvS2WBEhBzy/V4r2VK9CE7FooUMad44TkQgvpEkngwWhomgxybESW/L6bnT++VyGfxRdhTnOS8p6tgts61ggpNeaDRU0TON6x39k844CW8eza4UbPLiIlyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742291; c=relaxed/simple;
	bh=606xHOV7REs/CUmLZVKJCoqRw4w+gjwX2JuKeDHEpfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiqvtKuAWpN1UuGYPz8T42b5TXKq/QZn+MNa5mriruv/i9JaOTxX5CCN9FXnJp589hScFh+8v+cWAk3ZcpJ4HvOxgBfVbTC8JouAU8GghgGahgO4O4IogCvaRqu+xp66Fa+l6eTNNawrw27r0PzCuieuWdkopJrihX1Fd5I6Gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzP645gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738E9C43609;
	Wed, 31 Jan 2024 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742291;
	bh=606xHOV7REs/CUmLZVKJCoqRw4w+gjwX2JuKeDHEpfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EzP645gDJBv1zggBtj+hRyEisysLv0Pa+ri4P8BUe6hP92qCWl0sTTLLHfw20CG57
	 joB9diNPbQINssmHU3XR0tsjQ/dpET4zTrP2RzP961PqvokoWHNBds5SZFmMpHhwMY
	 NhSLMjov3RK7TCYJNS0RBrMyx083IYMZqC2PLY0qYDYHjVTxfBYBYZblr7QC9uf9Sy
	 EIOPZhh6k+7DIPkm3VAxDqjWkQz6JUbxaKeXRDwDP7PVjhQ2QGVtau7iUklgBW+OCm
	 mkYo5ibk2xjvWRtdFUZIZG/GFSJH+0q9KliHV4cgO3d1BnAiQNZlIcbg6CWhS5ZM47
	 xux7U4htrBF8Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:20 -0500
Subject: [PATCH v3 39/47] fuse: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-39-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=606xHOV7REs/CUmLZVKJCoqRw4w+gjwX2JuKeDHEpfs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFzhpKXOO+ReJrR0/Wtxd47aXLz+odJTpqdJ
 XgznpGWy26JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcwAKCRAADmhBGVaC
 FW4AD/0d6m0tKbhRrgZOQYosgQpUX6OwEpIrT/cxfgJJ5ETeRG3V4fuVoUY9AIL77bDZ9399X8+
 k1mriUxlAXGv1dgdx2mSLd3dSrV0pvmc7zio5NIO7fPcjmhP0NoddT36cTCYoBPtT6tPWwQGbyw
 QSnydNxkAUWqtymkYNLwgzGYTjYOuv2dX9e0IiIlaztHb2ntAePN+CPmyulR9EvN1R6uMwsIkvJ
 cdIhQefFhiDRLacB0N0TrfrF9JZt2yFtr2Ua1CTYsubzW67/qMyxsfRHiThJ+/PXqtc52Vb+TVY
 /A1l+oHmP8OUWsVEl6hfJnK4eEDD8l3RuJjAou35GeoXcqPI2+MWSAaw4NseBegDgAr/Ps4pP7t
 PmZcpXUEJDE2oXJ5iQ9Z17EKK1skeKgLelYOcHvyiNhxEEPaJngHhzHBQPoYIDoZr5u79sLJqoD
 rapDoEuNFf6Hnuu+8F7DjEguJZEAg16deRjZhO05R9s0cFW+9mNRPMs0a11aOWFMRmOC9C/34oY
 vbgLxCBVd6NSY26dl4lraeIW2gjEO8EtpPsAlEZqDVhILobITpVMW0e7OJgvWdDl+GBblKhTdv+
 jIMiMYxs6U9B0o5s7H6LrtFMpq0w6gS3edNY2FT08hkXaRij/pZb1fjZbtLa+5vTw2I/FLAO84a
 fTX5emi7Aj9eN4w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2757870ee6ac..c007b0f0c3a7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,7 +18,6 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/splice.h>
 
@@ -2510,14 +2509,14 @@ static int convert_fuse_file_lock(struct fuse_conn *fc,
 		 * translate it into the caller's pid namespace.
 		 */
 		rcu_read_lock();
-		fl->fl_pid = pid_nr_ns(find_pid_ns(ffl->pid, fc->pid_ns), &init_pid_ns);
+		fl->c.flc_pid = pid_nr_ns(find_pid_ns(ffl->pid, fc->pid_ns), &init_pid_ns);
 		rcu_read_unlock();
 		break;
 
 	default:
 		return -EIO;
 	}
-	fl->fl_type = ffl->type;
+	fl->c.flc_type = ffl->type;
 	return 0;
 }
 
@@ -2531,10 +2530,10 @@ static void fuse_lk_fill(struct fuse_args *args, struct file *file,
 
 	memset(inarg, 0, sizeof(*inarg));
 	inarg->fh = ff->fh;
-	inarg->owner = fuse_lock_owner_id(fc, fl->fl_owner);
+	inarg->owner = fuse_lock_owner_id(fc, fl->c.flc_owner);
 	inarg->lk.start = fl->fl_start;
 	inarg->lk.end = fl->fl_end;
-	inarg->lk.type = fl->fl_type;
+	inarg->lk.type = fl->c.flc_type;
 	inarg->lk.pid = pid;
 	if (flock)
 		inarg->lk_flags |= FUSE_LK_FLOCK;
@@ -2571,8 +2570,8 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
 	struct fuse_lk_in inarg;
-	int opcode = (fl->fl_flags & FL_SLEEP) ? FUSE_SETLKW : FUSE_SETLK;
-	struct pid *pid = fl->fl_type != F_UNLCK ? task_tgid(current) : NULL;
+	int opcode = (fl->c.flc_flags & FL_SLEEP) ? FUSE_SETLKW : FUSE_SETLK;
+	struct pid *pid = fl->c.flc_type != F_UNLCK ? task_tgid(current) : NULL;
 	pid_t pid_nr = pid_nr_ns(pid, fm->fc->pid_ns);
 	int err;
 
@@ -2582,7 +2581,7 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 	}
 
 	/* Unlock on close is handled by the flush method */
-	if ((fl->fl_flags & FL_CLOSE_POSIX) == FL_CLOSE_POSIX)
+	if ((fl->c.flc_flags & FL_CLOSE_POSIX) == FL_CLOSE_POSIX)
 		return 0;
 
 	fuse_lk_fill(&args, file, fl, opcode, pid_nr, flock, &inarg);

-- 
2.43.0


