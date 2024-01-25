Return-Path: <linux-fsdevel+bounces-8897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FA83BFC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBBA1C21DB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7969E63127;
	Thu, 25 Jan 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkFCWPDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF8175BC;
	Thu, 25 Jan 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179491; cv=none; b=k7Gri8APIDFH4W7Qrw/H7ESVENXVRdmpMMFjDwhXOUtaaH9PUtlPeWe91SdvOIz2W9KlG3Tw0is03gpkPElpnqG/oreWVRldGFtOpIPv4lizbocbEykPnH4NSfY3spKsad7xKHKz52HWzAHSf+gXJ98pkIpgYWWvkBWKUsM1F+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179491; c=relaxed/simple;
	bh=BE6D7fVdZjq/WVYIXNVhQrYy7EzO38NGIYIfMpI0THc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VC7fw/4/y9znSbu/HMA7Zsw5o3uRvleSD4uxmUeMCCsRaTXIgAevCFH7aH2+MDdaZrKBB+ht/qd63LWGd3KU0hO5Jteb+QmzZfixNxZm393W6LHDvCpRdu/kBYRceSzu09UQxYmpajJC0lIqUioggsqULiiIV0m3wRmpWg6rLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkFCWPDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB54C43330;
	Thu, 25 Jan 2024 10:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179490;
	bh=BE6D7fVdZjq/WVYIXNVhQrYy7EzO38NGIYIfMpI0THc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IkFCWPDawygwa7FN8A+X2hEJMiv2FuqP8qMkbc+BPuUyRJ7w/2uN/d6+bNht1mapa
	 uNtUNwb9n3nt30r7kmPu4C+/F9PJ5JWV/qNjjhvqxyENdazdxdrKdq/3SHgbMpk3eV
	 amgUlZ+N08TQsk8DwZBARr2Srt0oBLKBevcTylXD7GXxVMyn9tTtlGSSDCgwsSmbtE
	 +Y6O0FXBs8Q56wUA3atVIIk65ZPmTdxI3jO+ekQkXAbI9J0ZaffjN48OozAWTWKVxc
	 eN/SRSotvev2f4KZAFKyKmStig9hZ1kVWuRHTBrA6kPh8JrxpiWLlEW0gO3Yzu0YAh
	 3n0Iqe7SvIszw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:06 -0500
Subject: [PATCH v2 25/41] filelock: convert locks_wake_up_blocks to take a
 file_lock_core pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-25-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BE6D7fVdZjq/WVYIXNVhQrYy7EzO38NGIYIfMpI0THc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs96R45LralQk0vXAi/sncoWqvG8sGckQ+V5
 SbBb+K41ASJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PQAKCRAADmhBGVaC
 Fa06D/9xYM5ismcjCqj3pKFHU4iTx84d+XrQGP7iJaqdOWlkIvD+TqphzZa1RdctYx5uyTLt8DJ
 DuiV/RyOtHeOM9IsytyzaPzesXLNmQawkhg3IRHDZKxK3yr16h3dlSqfah/KK3IFI57d9a4aaaN
 bkXo9lRkcfp8ErDM7pf3jS45Vhu01wdNq2aiVtBNyRVKzrHaLsDA+TqnZdJLaylbeNarNBbULhM
 vIzu09a530rKfC6Uw1AittxzUj8QDv5v9FfVKgz1BJqb/Z51q+qiy0nRjhK38tGUYg5WaMuk+3R
 HdoeG2YvTFlBhkpk8DUQ0iSp+Euod5IiFFSPAcRXngS6yrDavM+gXiFFHZKrqOm2Pb8Ev0Fq9pj
 0XHccxlAdR3e8S6tAgKdeWzY+GidOm8QeyUbSlfoU1Mo7I3khez2ZSzhna8vFbP/5ifB5TxASZ4
 dwfr1Y+C9IbojRXKJQQyzCq6QLpDJgeC6OfdNQ5/dDu5Qe8jEAH0v3STKOsrqLpX/pyET9wIJqV
 z4kapupGuI1p/poMjRG/2lGqqvMF2J8wpYiufzSZtphkDcv8uUjsyh4ge2hvuNscGPkFo+2MSNg
 U2IGE4K31T5ddrY8FZlYwYkep/QBVEJZ9EI+94s25QoLUAol3o6jkDwB7GgmkfN9kzlEryX5I/a
 ovW/Xy6H1Q2DhhA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have locks_wake_up_blocks take a file_lock_core pointer, and fix up the
callers to pass one in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6182f5c5e7b4..03985cfb7eff 100644
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
-	if (list_empty(&blocker->fl_core.flc_blocked_requests))
+	if (list_empty(&blocker->flc_blocked_requests))
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	__locks_wake_up_blocks(&blocker->fl_core);
+	__locks_wake_up_blocks(blocker);
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -835,7 +835,7 @@ locks_unlink_lock_ctx(struct file_lock *fl)
 {
 	locks_delete_global_locks(&fl->fl_core);
 	list_del_init(&fl->fl_core.flc_list);
-	locks_wake_up_blocks(fl);
+	locks_wake_up_blocks(&fl->fl_core);
 }
 
 static void
@@ -1328,11 +1328,11 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			locks_insert_lock_ctx(left, &fl->fl_core.flc_list);
 		}
 		right->fl_start = request->fl_end + 1;
-		locks_wake_up_blocks(right);
+		locks_wake_up_blocks(&right->fl_core);
 	}
 	if (left) {
 		left->fl_end = request->fl_start - 1;
-		locks_wake_up_blocks(left);
+		locks_wake_up_blocks(&left->fl_core);
 	}
  out:
 	spin_unlock(&ctx->flc_lock);
@@ -1414,7 +1414,7 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 	if (error)
 		return error;
 	lease_clear_pending(fl, arg);
-	locks_wake_up_blocks(fl);
+	locks_wake_up_blocks(&fl->fl_core);
 	if (arg == F_UNLCK) {
 		struct file *filp = fl->fl_core.flc_file;
 

-- 
2.43.0


