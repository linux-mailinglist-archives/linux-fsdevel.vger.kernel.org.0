Return-Path: <linux-fsdevel+bounces-8101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E482F748
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DEF1C24961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900380048;
	Tue, 16 Jan 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvh7q0/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5680024;
	Tue, 16 Jan 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434430; cv=none; b=ifEKMbJ71U5n1VTVNVvH+Ivy/DHA7DovLTSwF9PBLkEzAV29j14C3EVU6vsSre7hcUoOdodrNLq/dNdFNCj9w8wOw0ZCiQMicA8VG+AWq4gHfm3fsceDH4XatdjYbl3yDkRO3IqACFCHtXkBahcbyRjAKFjyrd9nKSWRpUz7448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434430; c=relaxed/simple;
	bh=6eZQeCkW4iFcfnmfrvJdpykOJoNW9gO68mk12ueOnn4=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=JLzLxKdTNcmRrkEYPOWYksq1yoLi3SjHfdr0U4nbWfneQ2hJmentjDmIlAOhO6+XpQyLRb04uGWPnaYfb1nJbMoq9jXK2SBbL2FRpfrnAjES4VYB1LpXTEs/vwmK/DMyfhdv27sCv3Z8gxvFYc+eKXyiJDxVSx6LMMPseTTG0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvh7q0/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F4C433A6;
	Tue, 16 Jan 2024 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434430;
	bh=6eZQeCkW4iFcfnmfrvJdpykOJoNW9gO68mk12ueOnn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nvh7q0/E/N1JdPaGP+XEcUQn5mCYgXxCoGrhjxk6Kb0D9r/51nGWx6/aDB9wBIYHu
	 s9qa29A/KTsKjOhA6OKdYhlj2AJa9nMDFjXQmyXI3HbbnY5jgloUDPYqhgx48rj/qc
	 TlNZo+LkVLzS0KgoQzolooH03sN55F71hdUqX8KGZLuAyrQ/x92D/2KVRqT1Yh+rj4
	 fCMWdxQxkazjEn7IGYo8E1G7vrTtoAqno28mcV2jUUlCY2+81wM4eHJRM9GZXY4oIQ
	 5pJEFzbOr0Z8RJApCVNEDBEX2liSWEYiUsjnox29KTkhcAJtgGqcUHpqyYOpz86f88
	 O4neXmD/Hw97A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:02 -0500
Subject: [PATCH 06/20] filelock: convert more internal functions to use
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-6-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3974; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6eZQeCkW4iFcfnmfrvJdpykOJoNW9gO68mk12ueOnn4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0gkbCGP0TGVDiqaY92qso6UdDDYYNPcitPS
 wLpQSH+Mq6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIAAKCRAADmhBGVaC
 FQmtD/43Ok262HrU0nw5Im/yax8UeF7kPSqEzTjHJ4xF2CIjFS64ejnI5j3Q3SWvO0dPXdMZGHo
 q63T2n6CXQNzXurtakLNezxz86Grqj0SloTEaNrFKAYLynEUriP9le4R6f7sOfWVEx8fQtKIcII
 CBiL3qfFJaP5er8DXgeNe4xNQX38KfNMNIZzuDvZVfaV/2MMM/mOk7MUVD8esu0vYvtu+65MwK3
 BHU+g6KilT4YmpUY8eSvYIzTDqyhUxyDjB8EYn5MV+ynur5nGC0vLgV40QFBRPHTG9kUrFn0IXy
 fnWwrhOub7sY39kI/5abRiSTTGM9WqLrt7lTUDTxsdkg/Zf1j6WqNrvNbWcUh/0Gq5F7Ogp9rlu
 ywIOk+docNI0n17CnXEv1/5c8FktZORSOXzHWD7DtF8Lj2CW5TS3HYb7Fa9eusG7+Uj/BMOhO6G
 UXZT07l+7ub1+MJdKBeuOkxZ6sX2+6aRyuqlJ2fkIxGDVw23TiY8Tbp6icWrdb6hEJWRc2Ksjrl
 FiOfJWhJTCStUs6lg6EpaqzMBRiZ3WGt8mfnmLdsSvxqTmNmr/mJYB0J3Qf+8oPbFrlq7zDhW2n
 TFkMkykikEug4Rk1etGrNoD9ROFn8olB8bDuPiSInOtyF0yYLMzNDegwWkWtbRzDntELWxdWKeg
 RbC7jCLbvfsyRVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert more internal fs/locks.c functions to take and deal with struct
file_lock_core instead of struct file_lock:

- locks_dump_ctx_list
- locks_check_ctx_file_list
- locks_release_private
- locks_owner_has_blockers

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 42221cecd331..e09920cc9da2 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -204,13 +204,12 @@ locks_get_lock_context(struct inode *inode, int type)
 static void
 locks_dump_ctx_list(struct list_head *list, char *list_type)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
-	list_for_each_entry(fl, list, fl_core.fl_list) {
-		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type,
-			fl->fl_core.fl_owner, fl->fl_core.fl_flags,
-			fl->fl_core.fl_type, fl->fl_core.fl_pid);
-	}
+	list_for_each_entry(flc, list, fl_list)
+		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
+			list_type, flc->fl_owner, flc->fl_flags,
+			flc->fl_type, flc->fl_pid);
 }
 
 static void
@@ -231,20 +230,19 @@ locks_check_ctx_lists(struct inode *inode)
 }
 
 static void
-locks_check_ctx_file_list(struct file *filp, struct list_head *list,
-				char *list_type)
+locks_check_ctx_file_list(struct file *filp, struct list_head *list, char *list_type)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 	struct inode *inode = file_inode(filp);
 
-	list_for_each_entry(fl, list, fl_core.fl_list)
-		if (fl->fl_core.fl_file == filp)
+	list_for_each_entry(flc, list, fl_list)
+		if (flc->fl_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
 				list_type, MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino,
-				fl->fl_core.fl_owner, fl->fl_core.fl_flags,
-				fl->fl_core.fl_type, fl->fl_core.fl_pid);
+				flc->fl_owner, flc->fl_flags,
+				flc->fl_type, flc->fl_pid);
 }
 
 void
@@ -281,11 +279,13 @@ EXPORT_SYMBOL_GPL(locks_alloc_lock);
 
 void locks_release_private(struct file_lock *fl)
 {
-	BUG_ON(waitqueue_active(&fl->fl_core.fl_wait));
-	BUG_ON(!list_empty(&fl->fl_core.fl_list));
-	BUG_ON(!list_empty(&fl->fl_core.fl_blocked_requests));
-	BUG_ON(!list_empty(&fl->fl_core.fl_blocked_member));
-	BUG_ON(!hlist_unhashed(&fl->fl_core.fl_link));
+	struct file_lock_core *flc = &fl->fl_core;
+
+	BUG_ON(waitqueue_active(&flc->fl_wait));
+	BUG_ON(!list_empty(&flc->fl_list));
+	BUG_ON(!list_empty(&flc->fl_blocked_requests));
+	BUG_ON(!list_empty(&flc->fl_blocked_member));
+	BUG_ON(!hlist_unhashed(&flc->fl_link));
 
 	if (fl->fl_ops) {
 		if (fl->fl_ops->fl_release_private)
@@ -295,8 +295,8 @@ void locks_release_private(struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_put_owner) {
-			fl->fl_lmops->lm_put_owner(fl->fl_core.fl_owner);
-			fl->fl_core.fl_owner = NULL;
+			fl->fl_lmops->lm_put_owner(flc->fl_owner);
+			flc->fl_owner = NULL;
 		}
 		fl->fl_lmops = NULL;
 	}
@@ -312,16 +312,15 @@ EXPORT_SYMBOL_GPL(locks_release_private);
  *   %true: @owner has at least one blocker
  *   %false: @owner has no blockers
  */
-bool locks_owner_has_blockers(struct file_lock_context *flctx,
-		fl_owner_t owner)
+bool locks_owner_has_blockers(struct file_lock_context *flctx, fl_owner_t owner)
 {
-	struct file_lock *fl;
+	struct file_lock_core *flc;
 
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
-		if (fl->fl_core.fl_owner != owner)
+	list_for_each_entry(flc, &flctx->flc_posix, fl_list) {
+		if (flc->fl_owner != owner)
 			continue;
-		if (!list_empty(&fl->fl_core.fl_blocked_requests)) {
+		if (!list_empty(&flc->fl_blocked_requests)) {
 			spin_unlock(&flctx->flc_lock);
 			return true;
 		}

-- 
2.43.0


