Return-Path: <linux-fsdevel+bounces-9760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B8844C4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF92B1F22B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A160F14532F;
	Wed, 31 Jan 2024 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of+aN9Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521A145320;
	Wed, 31 Jan 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742256; cv=none; b=NZb7YxXzTDOcZBHNZl/j5LfkqBx3PCL1qKsrYp2aiAw4CCGbBFfKJCUiAX+ua/D1zYss8necgtiM+vJku8dGvf7Eh728brAcKEg6aB7dNi5PBmSBF4imTZtqLBWuo3nMWS1Ru/njM9fMQR2neoH4xxShtuIf5nqqmlg1/WRDzjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742256; c=relaxed/simple;
	bh=pXZ4V1pbOgczFwwAtEF+oajUDhW4eIw9Ye+Sx1hORgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1jQTHlNQ3sDcscGT+3+z2y5e9BdJsycdrilpWYj7FlYvr284aDuh/WSWKyKW6hVZtiNlQNM6WdMo2ThGiL4N/Ogvlym6zF7ne7UwYM2Jo6zoNKIHU/pHVLQj3lrv3u9ANRYWGlcequa0VNHRYgb/IM2iP7URSizz5azpRRoZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of+aN9Fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E75C433F1;
	Wed, 31 Jan 2024 23:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742255;
	bh=pXZ4V1pbOgczFwwAtEF+oajUDhW4eIw9Ye+Sx1hORgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=of+aN9Fo7MsgaT2JE9Fkn94Km+Tsd+i0Bohle9euwxnzZr/6f6Qc3cpVeRsKX2m+V
	 6EmO+axk0uVWnPnDheiv0pFw1k+SK81ng9rCu36uku2viemTrZA54vme1ak3J1erRr
	 E+ZCIDNTgJMvO4Gvk2jEdGYr+hgbZWGOOc/ePQ4VP9DaY+ec9xVvh0smQqK7QEXUiC
	 ULLlSW5NcjRO+Jq3INZWB2HUVi4tG/opA62rjlB4YO2jSOxkb+Z0odqTxucdzvPt4W
	 4QlhTx9irucd/dfstbbSN+C6EGp+opECgsM7Xphht871DNLC5rfrSzrnEsDB0hBrmy
	 Lnqq8mUPcejXQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:11 -0500
Subject: [PATCH v3 30/47] filelock: convert locks_wake_up_blocks to take a
 file_lock_core pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-30-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pXZ4V1pbOgczFwwAtEF+oajUDhW4eIw9Ye+Sx1hORgg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFy5SUWitkQ9qblwQyS1dppZibGWT5J31Nuo
 qbgZbE9hQCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcgAKCRAADmhBGVaC
 Fe6DD/9Vxyy8wNJrdh+IwW2cV8gOOQwzjr6maWWLKA5blIAsumiuFvzZLXJSihcFCoJ1LiVonWe
 BvbUow4volc/ThTa1TlBL9dPUaaJT56oXwQ4RbUi4CW/WBCiSjaJZY+0jxA0EmdBL+DH5nS3xCy
 smGim2TkDqn2lO6ili9fuPYX6TbWf9iyCV3PcqVXiFrfvNF8sO3hkx1By95bhoI/XnOHz8jbLkf
 jSv59ZiWVV12RCiinXsOmQMDgNSJeC3CEEJaKSHD5JILs7ROCotd+ZOiy9gp9aLYwKRMqLbNd0z
 2ztqnOFhbNRRBipjWIPX2cwtO4t9rt1hM3W54YDMpZg4vvyEHhoVdIZYpTYEggCBi/Oi91OEwQD
 rFq7S/944SGLJKpNP2x3RZui3a9/3JTY9eqd6rk15C+2xCtpMKoMVhWxXgTdVESsbl3KC9Q7T8z
 lDUBs+zzu4MEgQqR809U+AKjy5IxD8cqz7QJjmSJu7BsdI+bgeakBS7AA73uwA2pcigvAXoMcQO
 prpaXqnnQYJ381/f+pR1nGea8MdyL0jJNItn3ZU7a55afBopYmX8A1Rt5aBVHepoxmbvAb7JupR
 rWxZ37syiAhZDHJzOY/ZHfyAJbkAzrdK+Yq0x9ididtcb6n8b03q9ThKYfa6EJ8IsTS1jXRXi8j
 gtt3GrDS5wJzcIg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have locks_wake_up_blocks take a file_lock_core pointer, and fix up the
callers to pass one in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6892511ed89b..9f3670ba0880 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -806,7 +806,7 @@ static void locks_insert_block(struct file_lock_core *blocker,
  *
  * Must be called with the inode->flc_lock held!
  */
-static void locks_wake_up_blocks(struct file_lock *blocker)
+static void locks_wake_up_blocks(struct file_lock_core *blocker)
 {
 	/*
 	 * Avoid taking global lock if list is empty. This is safe since new
@@ -815,11 +815,11 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 	 * fl_blocked_requests list does not require the flc_lock, so we must
 	 * recheck list_empty() after acquiring the blocked_lock_lock.
 	 */
-	if (list_empty(&blocker->c.flc_blocked_requests))
+	if (list_empty(&blocker->flc_blocked_requests))
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	__locks_wake_up_blocks(&blocker->c);
+	__locks_wake_up_blocks(blocker);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -835,7 +835,7 @@ locks_unlink_lock_ctx(struct file_lock *fl)
 {
 	locks_delete_global_locks(&fl->c);
 	list_del_init(&fl->c.flc_list);
-	locks_wake_up_blocks(fl);
+	locks_wake_up_blocks(&fl->c);
 }
 
 static void
@@ -1328,11 +1328,11 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			locks_insert_lock_ctx(left, &fl->c.flc_list);
 		}
 		right->fl_start = request->fl_end + 1;
-		locks_wake_up_blocks(right);
+		locks_wake_up_blocks(&right->c);
 	}
 	if (left) {
 		left->fl_end = request->fl_start - 1;
-		locks_wake_up_blocks(left);
+		locks_wake_up_blocks(&left->c);
 	}
  out:
 	spin_unlock(&ctx->flc_lock);
@@ -1414,7 +1414,7 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 	if (error)
 		return error;
 	lease_clear_pending(fl, arg);
-	locks_wake_up_blocks(fl);
+	locks_wake_up_blocks(&fl->c);
 	if (arg == F_UNLCK) {
 		struct file *filp = fl->c.flc_file;
 

-- 
2.43.0


