Return-Path: <linux-fsdevel+bounces-9754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D61844C2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9691C20D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E968113E22E;
	Wed, 31 Jan 2024 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM/ekbRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3402D13E211;
	Wed, 31 Jan 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742232; cv=none; b=M/2b6qFJRe1tTKvYUH72v5iHBtej4OU0ncV+wQkbVu3kijO0McGDWKjDOQJE1ZuJKUpW9gZb4XGOaGjKkmuEPeU2iOVjbuX6+QGC2lGTwW5WjzFpDDsTdVF+Pyw51goRL2gZq+/j/Ns6Pe87f0R3DyaMN2MinYNrY9QrOylXQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742232; c=relaxed/simple;
	bh=+fh0Pyz60IyaAdOx+0EoERtKYPFhqrIpllRCidYLo4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6imatu71v+il6C8JJZeDQPgw6kwcAh3rThZcKpgANo71IybuCi9IbvD9/qTSDfb8pZe8/4+kRB9XlMDDL70nStboNO/1TiaIpyzJgKOJTNCkJ/w28c5Zu1SwIkUDRLNTc+z84C1V9C36u6Q64LitJ1AK01vEpVRccSASZX42ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM/ekbRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED23DC43390;
	Wed, 31 Jan 2024 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742231;
	bh=+fh0Pyz60IyaAdOx+0EoERtKYPFhqrIpllRCidYLo4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bM/ekbRViAsY+5DUTUT/5NUOUze2DbyGhWio8gErtKqeAff1puRV3oVoFidhFxcrC
	 74+Y/EbuBOUKRsoOP6iH6jpYg4ZkxJd5FgCYz5i1YfheC8gB6jotkv28djCoZ5CHCl
	 0tIDSchku+P+ziP0FisUyux1IOGT+3oXNBf1b3YXYu6D6HiEmZbD7V4GJMjHBt4oTn
	 kttrW4HaMwmDKHFes5s4df23+V/rh0S4SJ5NsllOLU60xiFTtQeipmlGfqJrlyVRxB
	 vGWMHcS1ODdJ54p6UcLKQHM6XQSDn8hjyN8Yzr97Ij6tDJQFpQpTbgHroWJq7SRDeZ
	 1wYiPZ0v8v1Uw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:05 -0500
Subject: [PATCH v3 24/47] filelock: make __locks_delete_block and
 __locks_wake_up_blocks take file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-24-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4001; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+fh0Pyz60IyaAdOx+0EoERtKYPFhqrIpllRCidYLo4Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFxs5terizvq50AGfajQ5gB4SSv/QE7zun6s
 7LfTA+Vb+yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 FTzmD/9jWU1AHowJsmJW2yQFaIH0ea4koaFqzMTBSqcK+HWHLMXGEkBSwD7pZaPUvN5mzp1/E8W
 1b0C34g48/w3VQ2AnR65/mmhehnLZdjb19USwIEcyHVt+fvGuT/K8af5sMCd16GKP35di1euDE5
 Knu35ZM8cbwywmNp7HZapaH89KYCHVZcFx3G++GoKh2KBauAXv8B9ha1zb3hB0RMFj3MDikNVV0
 u0b6xmUGUVDZeHDV90U7MAe/nFj0cst36l+1Ea1s30Wpcr1K42eL6MqZ70HRWE93WXH5NTqG6nT
 h44ogNN9gqZUPZq/vO/RVPcVJd6ofWcKMLJLizOr+Uhbf1lEbKaXlORiNebQDXWr84ViPdFlDtE
 sDOlX1kP6HbWA2wa7Lv/w+6dAk8rou/cD7/SOr2g+Uu/3ftDPMNYoUYTWxO1AiRMkGMXGA408pw
 0xlpWo+JikKkcktjPyZdjg04MVlPjGl2SjL+PfeGuPAXmDGl+u4jo52iBSQW79g3Gnaf4ovsF0d
 p4B2Dm0f+sKXtcR4ZUNZpigsOxk4G6s3nLfyA2lTZ2QB+jaMEH+2lWPL2A09jY1Z7j76sGIlRAK
 OGXZdEt7Q0xgUFTGdAOc2iyFZq2i5qGKHJiAoLARcU0E6eoE/LDAgR5ZFLTv/mHmm+6bKZkHh4i
 lKZhCpia9wEtUPQ==
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
index ef67a5a7bae8..1e8b943bd7f9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -69,6 +69,11 @@
 
 #include <linux/uaccess.h>
 
+static struct file_lock *file_lock(struct file_lock_core *flc)
+{
+	return container_of(flc, struct file_lock, c);
+}
+
 static bool lease_breaking(struct file_lock *fl)
 {
 	return fl->c.flc_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
@@ -654,31 +659,35 @@ static void locks_delete_global_blocked(struct file_lock_core *waiter)
  *
  * Must be called with blocked_lock_lock held.
  */
-static void __locks_delete_block(struct file_lock *waiter)
+static void __locks_delete_block(struct file_lock_core *waiter)
 {
-	locks_delete_global_blocked(&waiter->c);
-	list_del_init(&waiter->c.flc_blocked_member);
+	locks_delete_global_blocked(waiter);
+	list_del_init(&waiter->flc_blocked_member);
 }
 
-static void __locks_wake_up_blocks(struct file_lock *blocker)
+static void __locks_wake_up_blocks(struct file_lock_core *blocker)
 {
-	while (!list_empty(&blocker->c.flc_blocked_requests)) {
-		struct file_lock *waiter;
+	while (!list_empty(&blocker->flc_blocked_requests)) {
+		struct file_lock_core *waiter;
+		struct file_lock *fl;
+
+		waiter = list_first_entry(&blocker->flc_blocked_requests,
+					  struct file_lock_core, flc_blocked_member);
 
-		waiter = list_first_entry(&blocker->c.flc_blocked_requests,
-					  struct file_lock, c.flc_blocked_member);
+		fl = file_lock(waiter);
 		__locks_delete_block(waiter);
-		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
-			waiter->fl_lmops->lm_notify(waiter);
+		if ((waiter->flc_flags & (FL_POSIX | FL_FLOCK)) &&
+		    fl->fl_lmops && fl->fl_lmops->lm_notify)
+			fl->fl_lmops->lm_notify(fl);
 		else
-			locks_wake_up(waiter);
+			locks_wake_up(fl);
 
 		/*
-		 * The setting of fl_blocker to NULL marks the "done"
+		 * The setting of flc_blocker to NULL marks the "done"
 		 * point in deleting a block. Paired with acquire at the top
 		 * of locks_delete_block().
 		 */
-		smp_store_release(&waiter->c.flc_blocker, NULL);
+		smp_store_release(&waiter->flc_blocker, NULL);
 	}
 }
 
@@ -720,8 +729,8 @@ int locks_delete_block(struct file_lock *waiter)
 	spin_lock(&blocked_lock_lock);
 	if (waiter->c.flc_blocker)
 		status = 0;
-	__locks_wake_up_blocks(waiter);
-	__locks_delete_block(waiter);
+	__locks_wake_up_blocks(&waiter->c);
+	__locks_delete_block(&waiter->c);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
@@ -773,7 +782,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 	 * waiter, but might not conflict with blocker, or the requests
 	 * and lock which block it.  So they all need to be woken.
 	 */
-	__locks_wake_up_blocks(waiter);
+	__locks_wake_up_blocks(&waiter->c);
 }
 
 /* Must be called with flc_lock held. */
@@ -805,7 +814,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	__locks_wake_up_blocks(blocker);
+	__locks_wake_up_blocks(&blocker->c);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -1159,7 +1168,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			 * Ensure that we don't find any locks blocked on this
 			 * request during deadlock detection.
 			 */
-			__locks_wake_up_blocks(request);
+			__locks_wake_up_blocks(&request->c);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
 				__locks_insert_block(fl, request,

-- 
2.43.0


