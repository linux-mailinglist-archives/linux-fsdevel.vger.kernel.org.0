Return-Path: <linux-fsdevel+bounces-8909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606E83C007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B11C2085D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE067E73;
	Thu, 25 Jan 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="genccXEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37007679E3;
	Thu, 25 Jan 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179537; cv=none; b=pHcyjTJGttc5Wq+9OhG+goyW3wewC/KiHEUlCr793j6Mgb4A9yGvx0iGdsEPHvdbEVJM0LCdZxiqmaAaxhg9iIsGa3qp7IMh0PDPUS2LYJ93LmD2RulZUNZGtTsk95zgUBQZPnj50cJ6u8ElVokWyd7+1IZBQZGUmsUucaxe0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179537; c=relaxed/simple;
	bh=5PoLST2zhBI/R2hv821tOsWlAsgfBTelNfMTVnihNDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEEncDpb9sGFLmOZX74SKFSHR/+KWcTv71F5bS5Hmh9mvUIakBMCX1nGEzx1RZQOIFjj6vwxF5CpeD2IDYYHk3cPRhdfdn/laDyepaooKY8wYxvqNJdS+pe7cV6soneAdlpR2wmaRQyV0jGhmNHevnggH0OTPmd7bA3bZA5xoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=genccXEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C095C433F1;
	Thu, 25 Jan 2024 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179537;
	bh=5PoLST2zhBI/R2hv821tOsWlAsgfBTelNfMTVnihNDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=genccXEuScIA1iHXfQ45jPkJ1+8Gk5yVcHD+PneDArmXuS3+TL+w1ySWIY9pT4yhK
	 nRgmW/JsSPKxrzAdFJEkv6MgT6bNAQtg2r3ZsFBf09/hR/0UZyANzcqZGcgphUfeSX
	 mpv/BguU1kf1mSqAWTHEf7t11rr0OCJUNh2zJFEuBCr4XO1fWO79mSlB7Vqb2OiyD6
	 PhHoZxzipM7uJzswrhK04qtBYSWXKPDcsOkEb6iAjJ5XPJsaHCAqmoGZInHby5cdHh
	 V6jbuvv6eR0Uxzg0ZWVRPgU+OPIrX9LM+3xjtyqTzHCaqbH7p+pgfqN1X6Ep+NfF/O
	 BzgGyd+Q8X4qg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:18 -0500
Subject: [PATCH v2 37/41] ocfs2: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-37-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3086; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5PoLST2zhBI/R2hv821tOsWlAsgfBTelNfMTVnihNDs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+cYYPuaTS142Pzq5o0u79qjV9PREOI8bdv
 9wk/89Hr42JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 Fc7pEACt6yf1pSeRKhHC5jklKwZrsjWmKF/7k6kOz4a4s1C4NLlKt7j4lcg4yTS91bL2y8LGZjH
 MUj3VyZOh6v7U4CYmyeV8iS94NVYEdz/vDDkFs+nJTMxpx1j3P1G9fHmSDcdhxw8nAE9yzEKHCY
 Lx6ei2jMcPcakXbu/B8ECO/DQH9/gR4lK7l84HCvcFyocWTrgbtavX5gnFaHnJA8paHJqfy0LNT
 oCb4M+DpFtcegwAQCHXlTL9BdnkIh1LpJS/GcacoNG92pSUd7YDdyt6bhv30C7m8zgMzRuNxpUg
 h/GazImYZ/3CvpwbGmDqHdvvBQXesLmytfDhKm2SXyD3mzE9Zm0jqn8jYNk7U+MD7bjhHBiocOc
 FWCfuoOj9Q4SSVMuGjcKbX1x4kSoJgBu3gC00bQjF0zMyeME+nBN94gg9430eDM3+avqrgeHcO4
 tX3dEiUO3qRFYCTRX4koHDKm9TWsTwtTOhpV7iDDEZoe+Hq7F2jGOj9OPPhqD4Q6PFShbu6XwBF
 TntQBiMJkWY39mAZACq+q5qOtemFLHnMREGgduiED1v/+VOHykYnVtv9qJlA9Zei0dFsmTKoeAe
 bTjApIfwkgwj3imcxArcYXhH0WLfXJuTeiucDoC+hNCQgUr3ofDN3zYYEjug3IbmQjezAdZCr2a
 JUl7YTPZePJXGrg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ocfs2/locks.c      | 13 ++++++-------
 fs/ocfs2/stack_user.c |  3 +--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index 8a9970dc852e..b86df9b59719 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/fcntl.h>
 
@@ -28,7 +27,7 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 	struct ocfs2_file_private *fp = file->private_data;
 	struct ocfs2_lock_res *lockres = &fp->fp_flock;
 
-	if (fl->fl_type == F_WRLCK)
+	if (fl->fl_core.flc_type == F_WRLCK)
 		level = 1;
 	if (!IS_SETLKW(cmd))
 		trylock = 1;
@@ -54,8 +53,8 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 		 */
 
 		locks_init_lock(&request);
-		request.fl_type = F_UNLCK;
-		request.fl_flags = FL_FLOCK;
+		request.fl_core.flc_type = F_UNLCK;
+		request.fl_core.flc_flags = FL_FLOCK;
 		locks_lock_file_wait(file, &request);
 
 		ocfs2_file_unlock(file);
@@ -101,14 +100,14 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 	struct inode *inode = file->f_mapping->host;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if ((osb->s_mount_opt & OCFS2_MOUNT_LOCALFLOCKS) ||
 	    ocfs2_mount_local(osb))
 		return locks_lock_file_wait(file, fl);
 
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.flc_type == F_UNLCK)
 		return ocfs2_do_funlock(file, cmd, fl);
 	else
 		return ocfs2_do_flock(file, inode, cmd, fl);
@@ -119,7 +118,7 @@ int ocfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	struct inode *inode = file->f_mapping->host;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->fl_core.flc_flags & FL_POSIX))
 		return -ENOLCK;
 
 	return ocfs2_plock(osb->cconn, OCFS2_I(inode)->ip_blkno, file, cmd, fl);
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 460c882c5384..70fa466746d3 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -9,7 +9,6 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
@@ -745,7 +744,7 @@ static int user_plock(struct ocfs2_cluster_connection *conn,
 		return dlm_posix_cancel(conn->cc_lockspace, ino, file, fl);
 	else if (IS_GETLK(cmd))
 		return dlm_posix_get(conn->cc_lockspace, ino, file, fl);
-	else if (fl->fl_type == F_UNLCK)
+	else if (fl->fl_core.flc_type == F_UNLCK)
 		return dlm_posix_unlock(conn->cc_lockspace, ino, file, fl);
 	else
 		return dlm_posix_lock(conn->cc_lockspace, ino, file, cmd, fl);

-- 
2.43.0


