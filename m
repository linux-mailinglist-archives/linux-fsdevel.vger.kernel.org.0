Return-Path: <linux-fsdevel+bounces-8107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42BE82F767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A22C2878B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8D2230D;
	Tue, 16 Jan 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEhrTykK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F597CF16;
	Tue, 16 Jan 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434454; cv=none; b=JJQzhtZMS04IkrGJFFzFPp7YWBhWiDl94AiEajsdZzwV3Nzfpnh3uQ2z9gQOi7XG/j8/ZKNTE6UdQHssjTtF9/Mo0xPPCR4Sw/IpmBMP7bLgcu5H6l3l5q7KfNbEQ7moWaH7a0l2NGrkxO1/2/xnuMueD55f35FebCXYgshxKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434454; c=relaxed/simple;
	bh=AkiTCb6wI/I7afKxVR9W5K0pvQ6+tRl16zAHjb4fgIA=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=hG+Xxl/3rNFVnEqnNWX/Yoom4AAlsreif+FAVQhGu0km1mppxd5MRbA23nepLPwfJwo81zocCZawyw/dZGQc6z1K3OycmSxiZsJozjCzX6IdqecID+s0lk3npTFxBcxCK1J+qIrEpVZdow2IJtPNtZ1OIBJRT1+YSQyVT+PewPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEhrTykK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D62C433F1;
	Tue, 16 Jan 2024 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434454;
	bh=AkiTCb6wI/I7afKxVR9W5K0pvQ6+tRl16zAHjb4fgIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QEhrTykKlwOGz5IuTVNR5SOUJoPTi1MlovOZyLg/e5ggi+VPJokYrXvWLP0FM0CmF
	 UciNRXb8LAHsbDcH7RnDxPNl456DEp5vNTqNKqS3Zll1Bm/UKxtmm0C6WW5hZKpIxt
	 quhzwRalKlVZNzA+Y83mkDs74ua4fL/hk5TRUc+QIlB+DzneVrkaBYzn3rR9mdBrR1
	 gXy4IF/J+EaHEkLb0tJ/Fgrx9suZljHU9xEdLnl9umNAXRMIjVNqmVxLTVpTsox4EL
	 5YD/uGpJhclwCMziD6w93ypv+5XjDqsVUPSwKUacl+oHEX5LAI7YjFHM0Fam/2eh33
	 ltxJXjI9mbukA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:08 -0500
Subject: [PATCH 12/20] filelock: make __locks_delete_block and
 __locks_wake_up_blocks take file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-12-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4069; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AkiTCb6wI/I7afKxVR9W5K0pvQ6+tRl16zAHjb4fgIA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0h5QYo2Mzczjq3QvKNi1KSMPpywliqQ0U92
 SG1Z2SOvF2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIQAKCRAADmhBGVaC
 FaY2D/4rwgL7811zt1zhBumpeY4uAeYPfPfqjMV7b5bI8BhMtPvnC7XrU4EUKDt+cJYJbGa6TJI
 gc4apK+Bt2ih3DLCgFlWrcK5iM8fIcbgwMK8r01AZK0jzHVF+1b0CS2Nu/LhrRqM4XIWnztPXt1
 7tipdDp4tBL6O+Fhv9GaHJZBGBVS52ThJmjemF1a+LZRw5qqOipyu1R5evakULxCX6PhsllNMTT
 XrB5H3McvLNHE2mYC7Fon0ilA96p2kKzW8jLe+KR8mp5MDBx7G+ttZ1gPb8FMT7kIcNeCrvE9S5
 m7CeaQ+o4zmtpXvtsWdLPUS7nQIul9Rcwtdgr7BvI0aIMnQ1Szmp8sicKVblSxBSVOqx7hmizRs
 mnbQ1sgavpwWDJ1I9hofCOd7EYPNm1aFE7mngQX45DCOd9A3Opkw2oI3a8autiEd17ofuzb4pTB
 kOO/7K3/Dugnq5UW589/4O2WbawsSkzXUdVe+XSrJHJ/Uq05RrjaxLYElWRSFb/Fj/8YDxntP1V
 wJcZnSdtK1XZjTKlY0Z9bRJhxjs1UoAm7427TQug4LUjGx1fOajuOLQoHQzGNqFlEhCN3CGLlmo
 56gyESKLCL619gAE80X899aNbVw5SrNibMs3zCs+MhAlnR2H+ul6CizW0dRDnKE/MWgNEaDoGcE
 1fTJDFYiDK6yu9g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert __locks_delete_block and __locks_wake_up_blocks to take a struct
file_lock_core pointer. Note that to accomodate this, we need to add a
new file_lock() wrapper to go from file_lock_core to file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index eddf4d767d5d..6b8e8820dec9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -92,6 +92,11 @@ static inline bool IS_LEASE(struct file_lock_core *flc)
 
 #define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <= 0)
 
+struct file_lock *file_lock(struct file_lock_core *flc)
+{
+	return container_of(flc, struct file_lock, fl_core);
+}
+
 static bool lease_breaking(struct file_lock *fl)
 {
 	return fl->fl_core.fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
@@ -677,31 +682,35 @@ static void locks_delete_global_blocked(struct file_lock_core *waiter)
  *
  * Must be called with blocked_lock_lock held.
  */
-static void __locks_delete_block(struct file_lock *waiter)
+static void __locks_delete_block(struct file_lock_core *waiter)
 {
-	locks_delete_global_blocked(&waiter->fl_core);
-	list_del_init(&waiter->fl_core.fl_blocked_member);
+	locks_delete_global_blocked(waiter);
+	list_del_init(&waiter->fl_blocked_member);
 }
 
-static void __locks_wake_up_blocks(struct file_lock *blocker)
+static void __locks_wake_up_blocks(struct file_lock_core *blocker)
 {
-	while (!list_empty(&blocker->fl_core.fl_blocked_requests)) {
-		struct file_lock *waiter;
+	while (!list_empty(&blocker->fl_blocked_requests)) {
+		struct file_lock_core *waiter;
+		struct file_lock *fl;
+
+		waiter = list_first_entry(&blocker->fl_blocked_requests,
+					  struct file_lock_core, fl_blocked_member);
 
-		waiter = list_first_entry(&blocker->fl_core.fl_blocked_requests,
-					  struct file_lock, fl_core.fl_blocked_member);
+		fl = file_lock(waiter);
 		__locks_delete_block(waiter);
-		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
-			waiter->fl_lmops->lm_notify(waiter);
+		if ((IS_POSIX(waiter) || IS_FLOCK(waiter)) &&
+		    fl->fl_lmops && fl->fl_lmops->lm_notify)
+			fl->fl_lmops->lm_notify(fl);
 		else
-			wake_up(&waiter->fl_core.fl_wait);
+			wake_up(&waiter->fl_wait);
 
 		/*
 		 * The setting of fl_blocker to NULL marks the "done"
 		 * point in deleting a block. Paired with acquire at the top
 		 * of locks_delete_block().
 		 */
-		smp_store_release(&waiter->fl_core.fl_blocker, NULL);
+		smp_store_release(&waiter->fl_blocker, NULL);
 	}
 }
 
@@ -743,8 +752,8 @@ int locks_delete_block(struct file_lock *waiter)
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_core.fl_blocker)
 		status = 0;
-	__locks_wake_up_blocks(waiter);
-	__locks_delete_block(waiter);
+	__locks_wake_up_blocks(&waiter->fl_core);
+	__locks_delete_block(&waiter->fl_core);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
@@ -799,7 +808,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 	 * waiter, but might not conflict with blocker, or the requests
 	 * and lock which block it.  So they all need to be woken.
 	 */
-	__locks_wake_up_blocks(waiter);
+	__locks_wake_up_blocks(&waiter->fl_core);
 }
 
 /* Must be called with flc_lock held. */
@@ -831,7 +840,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	__locks_wake_up_blocks(blocker);
+	__locks_wake_up_blocks(&blocker->fl_core);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -1186,7 +1195,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			 * Ensure that we don't find any locks blocked on this
 			 * request during deadlock detection.
 			 */
-			__locks_wake_up_blocks(request);
+			__locks_wake_up_blocks(&request->fl_core);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
 				__locks_insert_block(fl, request,

-- 
2.43.0


