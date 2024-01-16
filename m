Return-Path: <linux-fsdevel+bounces-8106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2A82F761
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4864F1F20FE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E6B7C0BB;
	Tue, 16 Jan 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzcsdZNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3F7C090;
	Tue, 16 Jan 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434450; cv=none; b=sz9dLmM+TWpNoP6Gkk3d05TSiiQ6S20DkYRqnDO9mK1QP2iMnrK1TpxovFjthvyadTA+i1IZ+rx9/PhgjZPRFM5E7oTIq8oF4LAy6INYQogf0lWKG5wpJ70i1EyjCJp/kyEVKvYkY2BOKPbJnPtNxJ9JwRD4ZCDd+Z0poOWmMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434450; c=relaxed/simple;
	bh=hDNBllLWV7rE28a4tOW8PqqKsyO/cQNheeJo5XTQ5lQ=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=f0QuNc4RgukpEp8zkrstK3AJoT9jKriX4rRrCC3ZR+bInF+ki36h7SAMkBa8lBbmZW4G/GtqUoBN/kTAA9hQFvGZk7bNOqmG2M4Logzu2Y1yQZ+LX2D3u7s9EA6V4Agon5UlvN5FIN6SNgtaxjieo+cO+1k+gjI3APLbR8OjTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzcsdZNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A334C43609;
	Tue, 16 Jan 2024 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434450;
	bh=hDNBllLWV7rE28a4tOW8PqqKsyO/cQNheeJo5XTQ5lQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kzcsdZNnwtOwDz+0ScxdCgLnAXucXNw7pUfdtWDuahWCJ7bHfkRUMtfY6tW9uFCRv
	 0Xtqh8iUkDN13I8l8shnWGlj+o+zcpmjyOpb1sgBdGn7Y3ZyL/ulTeR5AuqnDEe7j0
	 xT+TxTRPGklIuXvF/YYUpO0joYz4Dp/+pQpfOr/GK1QG/XkciN2+QNWytsueK4FCPi
	 r7iqT5aCProcxW19BTUCkdfn4U3HnjrCJvDQUnVTu7ZdHG96LkSDYX1CMcMvf2ThBE
	 MAnnPuenyKlNFCUf1jJQA0xj/bvMxMk3FETk6Fja7sdct35OA6hb+BaEvrhZPXMAX4
	 oPdHxej0qesCA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:07 -0500
Subject: [PATCH 11/20] filelock: convert the IS_* macros to take
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-11-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4374; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hDNBllLWV7rE28a4tOW8PqqKsyO/cQNheeJo5XTQ5lQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0h/L8At3nBU2VgP+pUsnh2pXoFcx9uKIWpb
 Hqa7gddCUGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIQAKCRAADmhBGVaC
 FYM9D/4/y07BKDV0bDKK4dYeYFXbGjF1XoU54+6uRIu/8Wtx0wBs9naTPAB/E6sCv7BGMv9W+x1
 b1wcPq336mQ8WcP8VafWXEQa6y9kffgjyqsFmcaSXYxPWp3ulvEUAUtni0gfT5isyVIt9oYooyA
 qYrYbKllZHg46JotkIK/E0cX2zHl2/kaWWxuufxRFPItIQ1Oet34OZKF5hkQFqlwCGcTAfZIDnz
 urWXdczSOzfxHf7XDY9H4Lv8qNROKN95Fl82IJ+31zTIoM17iI+vzxyBjKX5yCiUL6bzlgwNIBb
 fZvAYQ3mNJtJwXD+am8GOFC++hBSMEZbkOhgiUy1zBH/4F7rjkUJH5Rv8jiq+2syNyIS6ffo/8A
 9xW+8ANWLZ+ASuPDGI7psXJCwhT944/Afp1pjfUTH66dd+dvNqq95m26KxYlKLizNMYTi8L8AtW
 H5pDBZlFt30Y6jZkmwyMPfLEq6mCWCVMKBjpVYPx2AAFjDu928AMd3SECwfdF3NEEys/eX4Vo4M
 vcyItUEyGVwpXH9HOeNuyCpYMXq2sH4ZzY71JpDYuZxYbA7MncxxewQXScLup3Rv2fe5Ij9F4Mi
 ZXFaATkQE9c4mvpn8IMRbuyGsmrJPM3xSi6ZKqzTeaI4+6clsh1Jl8/OILx0h5MG8pTP8WdZwS1
 wThFLIR2rQGY4Hw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I couldn't get them to work properly as macros, so convert them
to static inlines instead (which is probably better for the type safety
anyway).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 770aaa5809ba..eddf4d767d5d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -70,10 +70,26 @@
 
 #include <linux/uaccess.h>
 
-#define IS_POSIX(fl)	(fl->fl_core.fl_flags & FL_POSIX)
-#define IS_FLOCK(fl)	(fl->fl_core.fl_flags & FL_FLOCK)
-#define IS_LEASE(fl)	(fl->fl_core.fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
-#define IS_OFDLCK(fl)	(fl->fl_core.fl_flags & FL_OFDLCK)
+static inline bool IS_POSIX(struct file_lock_core *flc)
+{
+	return flc->fl_flags & FL_POSIX;
+}
+
+static inline bool IS_FLOCK(struct file_lock_core *flc)
+{
+	return flc->fl_flags & FL_FLOCK;
+}
+
+static inline bool IS_OFDLCK(struct file_lock_core *flc)
+{
+	return flc->fl_flags & FL_OFDLCK;
+}
+
+static inline bool IS_LEASE(struct file_lock_core *flc)
+{
+	return flc->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT);
+}
+
 #define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <= 0)
 
 static bool lease_breaking(struct file_lock *fl)
@@ -761,6 +777,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 					       struct file_lock *))
 {
 	struct file_lock *fl;
+	struct file_lock_core *bflc;
 	BUG_ON(!list_empty(&waiter->fl_core.fl_blocked_member));
 
 new_blocker:
@@ -773,7 +790,9 @@ static void __locks_insert_block(struct file_lock *blocker,
 	waiter->fl_core.fl_blocker = blocker;
 	list_add_tail(&waiter->fl_core.fl_blocked_member,
 		      &blocker->fl_core.fl_blocked_requests);
-	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
+
+	bflc = &blocker->fl_core;
+	if (IS_POSIX(bflc) && !IS_OFDLCK(bflc))
 		locks_insert_global_blocked(&waiter->fl_core);
 
 	/* The requests in waiter->fl_blocked are known to conflict with
@@ -998,6 +1017,7 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 				struct file_lock *block_fl)
 {
 	int i = 0;
+	struct file_lock_core *flc = &caller_fl->fl_core;
 
 	lockdep_assert_held(&blocked_lock_lock);
 
@@ -1005,7 +1025,7 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	 * This deadlock detector can't reasonably detect deadlocks with
 	 * FL_OFDLCK locks, since they aren't owned by a process, per-se.
 	 */
-	if (IS_OFDLCK(caller_fl))
+	if (IS_OFDLCK(flc))
 		return 0;
 
 	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
@@ -2157,7 +2177,7 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	pid_t vnr;
 	struct pid *pid;
 
-	if (IS_OFDLCK(fl))
+	if (IS_OFDLCK(&fl->fl_core))
 		return -1;
 	if (IS_REMOTELCK(fl))
 		return fl->fl_core.fl_pid;
@@ -2721,19 +2741,19 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (repeat)
 		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
 
-	if (IS_POSIX(fl)) {
+	if (IS_POSIX(&fl->fl_core)) {
 		if (fl->fl_core.fl_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
-		else if (IS_OFDLCK(fl))
+		else if (IS_OFDLCK(&fl->fl_core))
 			seq_puts(f, "OFDLCK");
 		else
 			seq_puts(f, "POSIX ");
 
 		seq_printf(f, " %s ",
 			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");
-	} else if (IS_FLOCK(fl)) {
+	} else if (IS_FLOCK(&fl->fl_core)) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
-	} else if (IS_LEASE(fl)) {
+	} else if (IS_LEASE(&fl->fl_core)) {
 		if (fl->fl_core.fl_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
@@ -2748,7 +2768,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else {
 		seq_puts(f, "UNKNOWN UNKNOWN  ");
 	}
-	type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_core.fl_type;
+	type = IS_LEASE(&fl->fl_core) ? target_leasetype(fl) : fl->fl_core.fl_type;
 
 	seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
 			     (type == F_RDLCK) ? "READ" : "UNLCK");
@@ -2760,7 +2780,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else {
 		seq_printf(f, "%d <none>:0 ", fl_pid);
 	}
-	if (IS_POSIX(fl)) {
+	if (IS_POSIX(&fl->fl_core)) {
 		if (fl->fl_end == OFFSET_MAX)
 			seq_printf(f, "%Ld EOF\n", fl->fl_start);
 		else

-- 
2.43.0


