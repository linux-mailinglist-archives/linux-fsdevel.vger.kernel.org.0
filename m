Return-Path: <linux-fsdevel+bounces-9744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B25844C97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC23B2EED3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6D4B5D7;
	Wed, 31 Jan 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPaJihUo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE84A9BF;
	Wed, 31 Jan 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742192; cv=none; b=rGfLpMD+Zb+fBNSTyAac6TbxT1aXJhdf/f+3OfcUvA8b3DwHdRquC4mhtcb862YTThPvapwLYsp1icOVq06OkDsjgo8apRkz4O4ArSZqOdk9gF2WcAoGAjo545y+oWG/oNBPw9KICqn+8LemiiZ6MXJ552klh2GsiKtIrlQpTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742192; c=relaxed/simple;
	bh=sNOrCkTcYd2ehInJVAjwI61o+eqh8+BcNWvctRiFYlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvWh88l8qbwm5bqAvWMxZx9xMfSLNa3cF4iIfSmN9Qmd1Fzy6T+Uy8wxEn37rBtI+hGxwOLk9EnUHN66FN3cWlr5p2ZZFSuzpBF1MpgP9KLQnI1Ns7zrbYez6eL/D+pwcDQls7vrL9vVU5RnDQaRPxzXEUMnUMEg7x9dQc/efSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPaJihUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3656AC43330;
	Wed, 31 Jan 2024 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742191;
	bh=sNOrCkTcYd2ehInJVAjwI61o+eqh8+BcNWvctRiFYlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jPaJihUo28zQ6jJnl98vBQtGyyjGMtzVW5ofnzGXXU+QTRvh15v2RBIzVXnE2JFaO
	 W1Cu7k+uH0yEh+e6pr4EIx+3m7Cmuu0iBVZvMwfVERr61y3TDefQNLlrBM2eqKa4FL
	 kscevZqv+9C8H0SmoYtuM6o3cW5YxYYLT17q7Iah5phaEuTsvnRBb9bchyuRHcZB5N
	 5qxt/iEjtAf/z6JUO6qoQDD7icldKN+rA7J2YL/LOI0H1y8CiIqIXoR7t+EWxh1sAk
	 aEOt5gPSJ3qqU/PmADYuY6BSwnL3Mej0uia1UEvudny2EEo7O+ehgLssIhfvbJASww
	 QkNFb26yMDazw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:55 -0500
Subject: [PATCH v3 14/47] smb/client: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-14-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sNOrCkTcYd2ehInJVAjwI61o+eqh8+BcNWvctRiFYlw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFwEGvApQjLFywG5KR4PXw94xatGEobs6Txc
 96xMWLF+iuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 FW/HD/9t/9RYMz4y8XwdaPmCmqiSG5Md5Xd11I35AaoOBOBMXwUeC3cIoizT7vcQHgG8OQQebCw
 NQOY+wmXxcYtqyJcbt9RiqqFybbWAQt4crYf6Bg5nKBHwm32QIdP6JJLMrFmAtbpp6hb2xWzHuz
 5SvKSCIFWRslcz1JTSTnWgNed6rUapybXAi4K/adDvQTXEZuqB4vWFPXYkAR+sJ/2snfOgau0hR
 sMxvrdi/COJ7AepichAP3JvXKGu/elAe7g6lJ0MgLssb3b2olbt/Jl3XXdm4T4Q8+Odb/pJyP6M
 R2VBE9T3c8w/pVTEun2UStpcm1DH6U/tYHwaHK/Zq5zLT/d6NOIaftuaFxBMLqXVgVGggAc/5PM
 imB/qngELyOKiVRbx/KfMFtj6FOesJ3S7jZWWSu1uBwOlzvR5vS9btnKObUYgWfGgTOb7WW6lPp
 z+QjxOu+Byg8QBU4dhuT8w37Aulj/OeJ5p0xEsAebccb9B1JRie5m3LL2RkjVT6L2aihHdJL5sC
 GiHAJT7z+Qz0g8YhAk/jU9AlalNqbzGdxcIX7vh/6KsoNvwsjV/8MVwGSvfX8OYVBnYcQkexQbN
 h0VvHH7dz198ioRYLgTk60as7ToLb/qVHNxt+o5sTF/pQL6Iu6S2QAKlGgtres1FM9mSz9/wE8g
 pi2mqeC1DCCjf1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b75282c204da..27f9ef4e69a8 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1409,7 +1409,7 @@ cifs_posix_lock_test(struct file *file, struct file_lock *flock)
 	down_read(&cinode->lock_sem);
 	posix_test_lock(file, flock);
 
-	if (flock->fl_type == F_UNLCK && !cinode->can_cache_brlcks) {
+	if (lock_is_unlock(flock) && !cinode->can_cache_brlcks) {
 		flock->fl_type = saved_type;
 		rc = 1;
 	}
@@ -1581,7 +1581,7 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 
 	el = locks_to_send.next;
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(flock, &flctx->flc_posix, fl_list) {
+	for_each_file_lock(flock, &flctx->flc_posix) {
 		if (el == &locks_to_send) {
 			/*
 			 * The list ended. We don't have enough allocated
@@ -1591,7 +1591,7 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 			break;
 		}
 		length = cifs_flock_len(flock);
-		if (flock->fl_type == F_RDLCK || flock->fl_type == F_SHLCK)
+		if (lock_is_read(flock) || flock->fl_type == F_SHLCK)
 			type = CIFS_RDLCK;
 		else
 			type = CIFS_WRLCK;
@@ -1681,16 +1681,16 @@ cifs_read_flock(struct file_lock *flock, __u32 *type, int *lock, int *unlock,
 		cifs_dbg(FYI, "Unknown lock flags 0x%x\n", flock->fl_flags);
 
 	*type = server->vals->large_lock_type;
-	if (flock->fl_type == F_WRLCK) {
+	if (lock_is_write(flock)) {
 		cifs_dbg(FYI, "F_WRLCK\n");
 		*type |= server->vals->exclusive_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_UNLCK) {
+	} else if (lock_is_unlock(flock)) {
 		cifs_dbg(FYI, "F_UNLCK\n");
 		*type |= server->vals->unlock_lock_type;
 		*unlock = 1;
 		/* Check if unlock includes more than one lock range */
-	} else if (flock->fl_type == F_RDLCK) {
+	} else if (lock_is_read(flock)) {
 		cifs_dbg(FYI, "F_RDLCK\n");
 		*type |= server->vals->shared_lock_type;
 		*lock = 1;

-- 
2.43.0


