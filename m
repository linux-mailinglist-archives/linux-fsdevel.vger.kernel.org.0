Return-Path: <linux-fsdevel+bounces-8901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17BC83BFD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6226C1F23DA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAA6518A;
	Thu, 25 Jan 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ4hsEQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF564CE9;
	Thu, 25 Jan 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179506; cv=none; b=XuXq4lUtjAeqx2t3sCWqz2UVwoIidIC/E5OY57XHKzvqQy9pXkrwHhpB33lFVF+/xrGR+EbQAd9DjkUprP2ZGJBJkZ4HmvdK2VhtkgKWdNY9MIRZzndS0iWUauRlD6lE22A3yQ2afsjEaArKV6Azrhzb9vE428nSaLRqEuqPhLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179506; c=relaxed/simple;
	bh=+UTv8zesFpelxZCkQPSVZ+9Jl6IVT/Y9SMwqWMmXfSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+HTlXvdynxeGUjlZeD7k3euhbOjFUkVB5W+eRKBQT+83GBl2dRc33QWtqpEUZusIHnwaCTJFrPOVoqGBiWQQD6MinUqd39hPHtKY2H/YR8vMcWWlEILhWjNfXpLY+lDM4y78oBHSr+lBayBwZ5WWtLmHWVqttqhLfonko/tvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ4hsEQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ADBC43390;
	Thu, 25 Jan 2024 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179506;
	bh=+UTv8zesFpelxZCkQPSVZ+9Jl6IVT/Y9SMwqWMmXfSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QZ4hsEQ9VmQZMj/+XhcHBtwKUVpIti3rkiAvqHQpS7kNAeqVKHVdnahsnvjA9PUGm
	 8fINHUH8nJJ7ZhOH+XDsmBj3WIczYKjShKtSG4BTcHBdFJAE2GnPC54hUacYwNLnDe
	 bZbr/AWQlxrVOhaAkVplsoBs32Gc/JtrmVNxEVHxCHVdglK2xfEWPEipfPV58rJLAZ
	 RsuNNYYlgUnYeI8vVyTpSTiXsgIELTnLkc+3Qf3N6l1Y/nIXHYl6+y0Fb7oXqG1XAQ
	 c7CnAgDwRlUEI4ygboTcYyH22u6xe96zgSK5LHiOJJzZIglS/hN1jBP7psoNA7lNtI
	 e+3wD/EQcinCw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:10 -0500
Subject: [PATCH v2 29/41] 9p: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-29-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5504; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+UTv8zesFpelxZCkQPSVZ+9Jl6IVT/Y9SMwqWMmXfSk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs9bTGkcmFH/56/z8DtKj3S69wbu4y/yv65u
 doBs2O8aKGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PQAKCRAADmhBGVaC
 FSL6D/9DFRH8l50P3oe3jIKdcFQQWKVTJRofS0b0WvT0V9I7BTn8d9DTgWD+UfQTymPZgHLNSCT
 fbWiqgN4Imn8tQYuVhw//6fbw44RfiblJIsxA8qBlnvU0RL6F4nP0Us/IEeiNyqEnjE8JKxrQTc
 TcFucsVNcYEVC3MZN19mC11X4nE9vXntQulqYXJctw1EcgMeNfk2lx278D+p5c45EqiDR6aPwBS
 qkmzU3CrJ1+tZacD3e5ztuY/bv5x1hc6WHjJT1Pi4gtZbyH5YBNT4wmFnAY/bl3Lzz9hmvSLii/
 FoS1s/7lkdqzfuiVt92me9A+DGRJFTYx40+mhao1wDiBsBI0hxAeJYC2dEzdU14GQFG78vd1OIx
 k5rOtVJ+MCpM2tJ7moPp3fhF6OUxomtAwl3qSGlflOWnbTs5TWhxAvT0oB+UYgull00JQbYe/MA
 MB98S8Hv10khBmh2bFgoFCFmkaZG9ZO5MGdHSIO8kczDhcViPETPTN8vXcuvXrFxd/agx0lLFFi
 lKjafjZMCBUE98+ANNor6V7qqFgsaHrQkpnl0zXFqdnwA8TATt9O229KEuEQBjvVY9+MraQdTHg
 iiOhGtYBxQyTBq/kVhVrVk0ybedeO6LUhiu9gBIaWSHrL7buN5sNh0QLNsJiIMHQQYlbKru/KoS
 ksP0kaaGsF/Ffig==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_file.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index a1dabcf73380..4e4f555e0c8b 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/sched.h>
 #include <linux/file.h>
@@ -108,7 +107,7 @@ static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	p9_debug(P9_DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_core.flc_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
@@ -127,7 +126,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	fid = filp->private_data;
 	BUG_ON(fid == NULL);
 
-	BUG_ON((fl->fl_flags & FL_POSIX) != FL_POSIX);
+	BUG_ON((fl->fl_core.flc_flags & FL_POSIX) != FL_POSIX);
 
 	res = locks_lock_file_wait(filp, fl);
 	if (res < 0)
@@ -136,7 +135,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	/* convert posix lock to p9 tlock args */
 	memset(&flock, 0, sizeof(flock));
 	/* map the lock type */
-	switch (fl->fl_type) {
+	switch (fl->fl_core.flc_type) {
 	case F_RDLCK:
 		flock.type = P9_LOCK_TYPE_RDLCK;
 		break;
@@ -152,7 +151,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 		flock.length = 0;
 	else
 		flock.length = fl->fl_end - fl->fl_start + 1;
-	flock.proc_id = fl->fl_pid;
+	flock.proc_id = fl->fl_core.flc_pid;
 	flock.client_id = fid->clnt->name;
 	if (IS_SETLKW(cmd))
 		flock.flags = P9_LOCK_FLAGS_BLOCK;
@@ -207,13 +206,13 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	 * incase server returned error for lock request, revert
 	 * it locally
 	 */
-	if (res < 0 && fl->fl_type != F_UNLCK) {
-		unsigned char type = fl->fl_type;
+	if (res < 0 && fl->fl_core.flc_type != F_UNLCK) {
+		unsigned char type = fl->fl_core.flc_type;
 
-		fl->fl_type = F_UNLCK;
+		fl->fl_core.flc_type = F_UNLCK;
 		/* Even if this fails we want to return the remote error */
 		locks_lock_file_wait(filp, fl);
-		fl->fl_type = type;
+		fl->fl_core.flc_type = type;
 	}
 	if (flock.client_id != fid->clnt->name)
 		kfree(flock.client_id);
@@ -235,7 +234,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 	 * if we have a conflicting lock locally, no need to validate
 	 * with server
 	 */
-	if (fl->fl_type != F_UNLCK)
+	if (fl->fl_core.flc_type != F_UNLCK)
 		return res;
 
 	/* convert posix lock to p9 tgetlock args */
@@ -246,7 +245,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 		glock.length = 0;
 	else
 		glock.length = fl->fl_end - fl->fl_start + 1;
-	glock.proc_id = fl->fl_pid;
+	glock.proc_id = fl->fl_core.flc_pid;
 	glock.client_id = fid->clnt->name;
 
 	res = p9_client_getlock_dotl(fid, &glock);
@@ -255,13 +254,13 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 	/* map 9p lock type to os lock type */
 	switch (glock.type) {
 	case P9_LOCK_TYPE_RDLCK:
-		fl->fl_type = F_RDLCK;
+		fl->fl_core.flc_type = F_RDLCK;
 		break;
 	case P9_LOCK_TYPE_WRLCK:
-		fl->fl_type = F_WRLCK;
+		fl->fl_core.flc_type = F_WRLCK;
 		break;
 	case P9_LOCK_TYPE_UNLCK:
-		fl->fl_type = F_UNLCK;
+		fl->fl_core.flc_type = F_UNLCK;
 		break;
 	}
 	if (glock.type != P9_LOCK_TYPE_UNLCK) {
@@ -270,7 +269,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 			fl->fl_end = OFFSET_MAX;
 		else
 			fl->fl_end = glock.start + glock.length - 1;
-		fl->fl_pid = -glock.proc_id;
+		fl->fl_core.flc_pid = -glock.proc_id;
 	}
 out:
 	if (glock.client_id != fid->clnt->name)
@@ -294,7 +293,7 @@ static int v9fs_file_lock_dotl(struct file *filp, int cmd, struct file_lock *fl)
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_core.flc_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
@@ -325,16 +324,16 @@ static int v9fs_file_flock_dotl(struct file *filp, int cmd,
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.flc_flags & FL_FLOCK))
 		goto out_err;
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_core.flc_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
 	/* Convert flock to posix lock */
-	fl->fl_flags |= FL_POSIX;
-	fl->fl_flags ^= FL_FLOCK;
+	fl->fl_core.flc_flags |= FL_POSIX;
+	fl->fl_core.flc_flags ^= FL_FLOCK;
 
 	if (IS_SETLK(cmd) | IS_SETLKW(cmd))
 		ret = v9fs_file_do_lock(filp, cmd, fl);

-- 
2.43.0


