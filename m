Return-Path: <linux-fsdevel+bounces-8891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B083BFA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C441C22F2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F72060891;
	Thu, 25 Jan 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTFJtdJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6906087B;
	Thu, 25 Jan 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179468; cv=none; b=dSMLdGXrP1J98S9FafUNk5uvc89KiLBp6pYxkj9GbtFDMN+I0wWDGasWQd5e3YmtpG3JbvAG4C1mgHMcMdNBTn77rYQttYkWXlVB5BqKRzf3jS0H2C+JyxtSr3cVcFs9EjetCHdHs5YHT9iiQoncNa5zGWgB62rgo9Ro5Lk+mFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179468; c=relaxed/simple;
	bh=xEH7T9zAfy3Zq5qW5HBkaCebYL132D5N/i5X+abBr/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEyX17c7efdugZDT+OhNEzNw5tvtxU1xqSMfzbKGzz/m792a7/tVZtz1/xSJ2ermHJZKMJHK5JFTzUq+AC38G/1tb1cQWvH8mOSz3QF9f3R0OkHPfWyaJHWl6EF/VYYFEkJpcckhalg/uC51yQEpgUlYyrXIreZBlDiOPvttV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTFJtdJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470EFC433B2;
	Thu, 25 Jan 2024 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179467;
	bh=xEH7T9zAfy3Zq5qW5HBkaCebYL132D5N/i5X+abBr/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eTFJtdJwPA9h/0aH8gznSxkIOCiS6LsmYImMTn4YRHQfc0t/SFGIXoxLO6bKzcORs
	 6u0Zwfx+JvmmI8IMmVRVX8gZp5xrcIPK8NGFFBWsL7LZTkNkGPy9FqC+ukG4zOjTef
	 PXphh5Qd72sYCjpg9LNDybYoUoIIaKjT+Abrj0R2FSgl+hAp9iPyHk6X3qRmxkep9f
	 gYtIB1+MjET3246GM1Uy7MsgpBmuImJnhHrBifQ4ChZB1L8+/IFhTOxg6VXVhwVWqX
	 B3awEMmU0HxcUTSO9JepifANCgNKW1Y8GMLzhAEJgtO04H3Al1IwrVWqaJpRWMZlA7
	 ngw2xOxjzimxA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:00 -0500
Subject: [PATCH v2 19/41] filelock: make __locks_delete_block and
 __locks_wake_up_blocks take file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-19-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xEH7T9zAfy3Zq5qW5HBkaCebYL132D5N/i5X+abBr/A=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8Sefnc019u18YQH+g88ChpnPWXVEzAJQm/
 YAZffDHvoiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FWZtD/47lA1y7kyUu+yJ0GoyXZ36UN7MGGsKRq8uf+ar92a2JuwUjmfVlUQN4u/fTthvH0GaQsD
 oPSJVG7Fy9Rdj4QfjluBLwur5tF+ExXrnjP9im9oD/4q+2peLKLZppOd2FQHdbN/CtHfeFWfsir
 rdz40NkhjkelfRyFRfv3scrkYwpe/axW4nW6ikyEBHZpj3TpLA0uIfdA0yHxr7RZlWAvqFnyE0M
 gQ/connbf103sy/+Jq9oyJCJqmEPI3fh8vSLMhsB1iKD5CUWXQSQlq0kPDd+l6NWTANxCCtshFe
 +mOcu9YLvjd6IjdeP7WXc4ZgkHVTtfWFFIVAZZjlnxk6m8fKAET0MEPj59KdXZcVIOWcxk/i+wt
 6zgf4nMPrDgo2SIPrqeHAIJlAgbxgweknEm0RCnmFrcQJ1Y7zoDCh6+YRp/F9kKuKFTLV8n4G5g
 Y5IXmJmeLFtgfGY+aFNoEOTuIo5yNEsZaxhNaNPJjJagNbrUtSC3Q6ShW1TLVIC1Nj9anto8hXU
 0Hd6Ji0XxoJCzzCCemwH3iqQxpJI0MyVVeoQ7S0AdW+PuzMhOKJPTgrV3TRa8UdX0Bsx/KcpviV
 IGTn3bUckr7E2vZh6cY2nnpZv4H5OvC+c9vfKNvrO4i6dXgBt2yR/crobgewwr06MneRWvTBilM
 pWVkMX/PD16hW2A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert __locks_delete_block and __locks_wake_up_blocks to take a struct
file_lock_core pointer.

While we could do this in another way, we're going to need to add a
file_lock() helper function later anyway, so introduce and use it now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index d6d47612527c..fb113103dc1b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -69,6 +69,11 @@
 
 #include <linux/uaccess.h>
 
+static struct file_lock *file_lock(struct file_lock_core *flc)
+{
+	return container_of(flc, struct file_lock, fl_core);
+}
+
 static bool lease_breaking(struct file_lock *fl)
 {
 	return fl->fl_core.flc_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
@@ -654,31 +659,35 @@ static void locks_delete_global_blocked(struct file_lock_core *waiter)
  *
  * Must be called with blocked_lock_lock held.
  */
-static void __locks_delete_block(struct file_lock *waiter)
+static void __locks_delete_block(struct file_lock_core *waiter)
 {
-	locks_delete_global_blocked(&waiter->fl_core);
-	list_del_init(&waiter->fl_core.flc_blocked_member);
+	locks_delete_global_blocked(waiter);
+	list_del_init(&waiter->flc_blocked_member);
 }
 
-static void __locks_wake_up_blocks(struct file_lock *blocker)
+static void __locks_wake_up_blocks(struct file_lock_core *blocker)
 {
-	while (!list_empty(&blocker->fl_core.flc_blocked_requests)) {
-		struct file_lock *waiter;
+	while (!list_empty(&blocker->flc_blocked_requests)) {
+		struct file_lock_core *waiter;
+		struct file_lock *fl;
+
+		waiter = list_first_entry(&blocker->flc_blocked_requests,
+					  struct file_lock_core, flc_blocked_member);
 
-		waiter = list_first_entry(&blocker->fl_core.flc_blocked_requests,
-					  struct file_lock, fl_core.flc_blocked_member);
+		fl = file_lock(waiter);
 		__locks_delete_block(waiter);
-		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
-			waiter->fl_lmops->lm_notify(waiter);
+		if ((waiter->flc_flags & (FL_POSIX | FL_FLOCK)) &&
+		    fl->fl_lmops && fl->fl_lmops->lm_notify)
+			fl->fl_lmops->lm_notify(fl);
 		else
-			wake_up(&waiter->fl_core.flc_wait);
+			wake_up(&waiter->flc_wait);
 
 		/*
-		 * The setting of fl_blocker to NULL marks the "done"
+		 * The setting of flc_blocker to NULL marks the "done"
 		 * point in deleting a block. Paired with acquire at the top
 		 * of locks_delete_block().
 		 */
-		smp_store_release(&waiter->fl_core.flc_blocker, NULL);
+		smp_store_release(&waiter->flc_blocker, NULL);
 	}
 }
 
@@ -720,8 +729,8 @@ int locks_delete_block(struct file_lock *waiter)
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_core.flc_blocker)
 		status = 0;
-	__locks_wake_up_blocks(waiter);
-	__locks_delete_block(waiter);
+	__locks_wake_up_blocks(&waiter->fl_core);
+	__locks_delete_block(&waiter->fl_core);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
@@ -773,7 +782,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 	 * waiter, but might not conflict with blocker, or the requests
 	 * and lock which block it.  So they all need to be woken.
 	 */
-	__locks_wake_up_blocks(waiter);
+	__locks_wake_up_blocks(&waiter->fl_core);
 }
 
 /* Must be called with flc_lock held. */
@@ -805,7 +814,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	__locks_wake_up_blocks(blocker);
+	__locks_wake_up_blocks(&blocker->fl_core);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -1159,7 +1168,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
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


