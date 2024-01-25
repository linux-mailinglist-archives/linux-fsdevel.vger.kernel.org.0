Return-Path: <linux-fsdevel+bounces-8905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4583BFEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C0029760C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B224501E;
	Thu, 25 Jan 2024 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMG1+CCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5865BD6;
	Thu, 25 Jan 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179524; cv=none; b=CDtWFXV3mH8ZKMA+Udm2C33iMACBOr/YPMA6dGGgsngLVAtZu+fqZoZf3oOZSD7Z/kUYR9WSoL/jnrimIk17TYOArDstcV8sPTCPhZFLtE5Y8q6RSMxFX54ZcERkFrGHBbu4XVQlgWuKubMh8OD//AOJVhpZT/V3vab2AGbcyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179524; c=relaxed/simple;
	bh=May8tXK/aU9P09eCGMe0XoJv+iSqKO1K5ZKsSFCQogk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4DCm7rMflp7K9zZcQ9kkGRMCntl2pzntF//aubc5Dsa/gTsp/0mAvnyy8fCF5CP1Bb4pKhbhgK3j0XcpPOm6sU2RNslS5hTJB04NZIgSafS6BOGvBzTO85i/K+hD+ZEurlWx9LQ4dQmGl2RXfcc9+uyG/M1zZ/rsBPLsjev/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMG1+CCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD52C43399;
	Thu, 25 Jan 2024 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179521;
	bh=May8tXK/aU9P09eCGMe0XoJv+iSqKO1K5ZKsSFCQogk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMG1+CCtlySiyvB+Qu5e+QSRgO2YlQnNL8nh97HGU2zVZRA1ZYk+NTHR17fnjilI+
	 XpDdy69YwLaWbmQ9N/d7qtdZCvmbdEG2SqO+hTS4wLNC9o6NC+iKL6n3hs1XnaXvZU
	 6kRFJUMFlQG8uzbDboyh/3DaEacUZlQMcp7N4gIcXM/G9/iCZ3FAkKfq+oziCUp233
	 KJlstnIzOq1nx5vAknGxgyVMEDX7s0AJez77L4+cPH4I/Ix1wgk6auWuXjDdIa6Cit
	 C+ia+qhUAU3mNd9nob/B7vzawuVNsyMvuOkqVckszSSdCgDZgXMkTodaUTtFnHBCro
	 HbTtqq/yO2/lw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:14 -0500
Subject: [PATCH v2 33/41] gfs2: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-33-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=May8tXK/aU9P09eCGMe0XoJv+iSqKO1K5ZKsSFCQogk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+crUFt4hWuqAUhKVtDFUTGdJiHAxl8qo6z
 jTpTEqOhGSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 FSXFEAC2Ij6vquQrJJuMnnGDLS15DLOkNyj/OzO/ognOixJocSiMEvgsjf7b9t6/sxFknKzi6N4
 kfUk2pzXp3FJ/3QTr+urjiw7MdpwP/KVmIeC/Inn9mttlPquZOqPPKmjGHK+g8PK0X4i7XVExTD
 clqeJmFWI5tC7ZipLCyJKxVOGhbrO/H7n6mbfk6chsYWbS2lHX6nOOTiowJB2ekjUmQKW3PzcRm
 lZGFCxs8eq5Y6c5q8Dam3XwfJdIPDclh1ZkThWjkL2JkEah5IAdZiqJD2F3rrbbauMaRvUDkt29
 5DTebMEEQxLoOv1+FmFOR1vv1lFPRm/IArkz0zDnY4OkPqEI4Y5dFtjlO7mVC87quTeJdtR6D+p
 zbypfBkT5LaP1CFVr5rGcsXv62yFuprKPKvILIT5a8/I4nY/B6qbOsVzHuMuw04/bOn6RcxjyGy
 QDs0HU/2zwDdEfBjONMBqycoWEkYzqGc8lskjs3lp0NdIeFU5vfbABqI1QWTzTZoSFSxn5WkYwW
 8HROwXlT5mMJVeUndmumdfY4D+Zt/JhoBvLXbF3Ej04SJD1jgBuWm76X0tB1T2MpAtnz0we+ziQ
 iKB/s5ugzfWnEY+QWBQI7QD8GFMxcXAaOXQIF8chaf0RhJ4SFdsze6q6KlBp/acpPzZpT0J4T6T
 rO87ah3Dt3EaXMw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/file.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 9e7cd054e924..dc0c4f7d7cc7 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -15,7 +15,6 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/gfs2_ondisk.h>
 #include <linux/falloc.h>
@@ -1441,10 +1440,10 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	struct gfs2_sbd *sdp = GFS2_SB(file->f_mapping->host);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->fl_core.flc_flags & FL_POSIX))
 		return -ENOLCK;
 	if (gfs2_withdrawing_or_withdrawn(sdp)) {
-		if (fl->fl_type == F_UNLCK)
+		if (fl->fl_core.flc_type == F_UNLCK)
 			locks_lock_file_wait(file, fl);
 		return -EIO;
 	}
@@ -1452,7 +1451,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 		return dlm_posix_cancel(ls->ls_dlm, ip->i_no_addr, file, fl);
 	else if (IS_GETLK(cmd))
 		return dlm_posix_get(ls->ls_dlm, ip->i_no_addr, file, fl);
-	else if (fl->fl_type == F_UNLCK)
+	else if (fl->fl_core.flc_type == F_UNLCK)
 		return dlm_posix_unlock(ls->ls_dlm, ip->i_no_addr, file, fl);
 	else
 		return dlm_posix_lock(ls->ls_dlm, ip->i_no_addr, file, cmd, fl);
@@ -1484,7 +1483,7 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 	int error = 0;
 	int sleeptime;
 
-	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
+	state = (fl->fl_core.flc_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
 	flags = GL_EXACT | GL_NOPID;
 	if (!IS_SETLKW(cmd))
 		flags |= LM_FLAG_TRY_1CB;
@@ -1496,8 +1495,8 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 		if (fl_gh->gh_state == state)
 			goto out;
 		locks_init_lock(&request);
-		request.fl_type = F_UNLCK;
-		request.fl_flags = FL_FLOCK;
+		request.fl_core.flc_type = F_UNLCK;
+		request.fl_core.flc_flags = FL_FLOCK;
 		locks_lock_file_wait(file, &request);
 		gfs2_glock_dq(fl_gh);
 		gfs2_holder_reinit(state, flags, fl_gh);
@@ -1558,10 +1557,10 @@ static void do_unflock(struct file *file, struct file_lock *fl)
 
 static int gfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 {
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
-	if (fl->fl_type == F_UNLCK) {
+	if (fl->fl_core.flc_type == F_UNLCK) {
 		do_unflock(file, fl);
 		return 0;
 	} else {

-- 
2.43.0


