Return-Path: <linux-fsdevel+bounces-9750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B32844C55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB26B22151
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A113B787;
	Wed, 31 Jan 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw+CONjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE113A258;
	Wed, 31 Jan 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742216; cv=none; b=Q8J5Ppw9eZ9/zIJqER5VLWzsBsfVWCsj9xLV8F/x0nHE2atRsOdZfbPQgOHknElFzIC0INUIEYeNPawat04w+sLOgjqLx5nGRowP7aHazDMSGbyCIEiSFMCz/wT9GaflWvZuiyQ6xDORUpFOdyzFJPCribBV2zmARhBnQU2jdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742216; c=relaxed/simple;
	bh=Qv8I4OPOQFKNMU0YbGeVUmPm+8mCKSnxsP8/NBFTVaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChyOpZAewTMop5CU2cwFLGu/EJ5vzkiGSvEiJvHrxOw0nq2+PoLjCsN/r4ZHK3SUlq4dKcj+9MjT483IoQRzlWNjvFA1TJGolmmFs0Hbdgc3hba5whUY35BfiyXWqglXOwNOgxvfpOIVhPGoAoE5VTpGuThZe5iPYS8AlKury+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw+CONjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CA9C433C7;
	Wed, 31 Jan 2024 23:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742215;
	bh=Qv8I4OPOQFKNMU0YbGeVUmPm+8mCKSnxsP8/NBFTVaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Iw+CONjOOceGUzpk4GlJ8u7rTQddWR/k2+1U3g+5juIpk2W9ExXLCgTEVEfv6Kp7V
	 4zO1SbFzOgFWa41nxLOg7X+BPeKP4iu94MS+XQfqUY0uh/w9+JpU/P8mYBLn+BRLrQ
	 okb/HO3F8YNBxS66SvQ3UGzbX1IkEgf1GnucwU8ggx00Wwu5t1T//cL80INmmZl+bk
	 PibGtBA+CbHjfOXA0bebAYKCpLPy3OZ/yzVXEILoPrEifs95pioBl9FOPjsgn7g8w5
	 N746m9LQlPD/Nbv/zKfvjZyOIpkmWcOn3Jb4wngz1U/PWTtRGTiRb8+T7wG0zi5XNK
	 AiqJFWzIexuXg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:01 -0500
Subject: [PATCH v3 20/47] filelock: make posix_same_owner take
 file_lock_core pointers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-20-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2863; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Qv8I4OPOQFKNMU0YbGeVUmPm+8mCKSnxsP8/NBFTVaw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFwIAIZzH6gn1mLBrHMjdFNmI6uHABwgegNG
 TDAgU+ZWnKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcAAKCRAADmhBGVaC
 FRimEAC1tK4TT1crYkK2Tv6KsHknwHQk2Uf6BlvlbxpQn86QwhgP1+TEtY7ga6DQemHNUgq1exV
 pqC2lqqrLeSykb9JMRYWblebsmBGjm9cuAhbKss9Jb6+WNujt6ty6d0c74ys0VbX/j/F5qYVJYc
 v81YQJUmRRE9Ghwa/zjdM8XQrvO+1+HNxR17hE8rh+bpti5bzaKelAR+v5WKXusncE1TJZ3L2b1
 +xgMklP1KUhK/iQ+K1YOEDZ16hdqyk4zzDEuuZcDAgRQ9Qz7JnFbwLA0TbHjhePwbC8kj6WQzjb
 AOK7ztCi/QXcHroOrcO0ucXQ25b7jDl7NlyDC6V/ZJkaoxpsNL8+HZ/hJruKULvDfgOU195t1Jo
 3zGnHNHxgNfyWqTOPPj8xJelKt1mrmkbH67z3I+WGnZ1F1E39PrbDfiUM50NkPCw3teEGsFCKeo
 ZxgUJ/LevLO8sVnASkR2Nne1ZtEJtd8T3G3G46CENp7yRwmae4NTnnKqAk34XHrvjg/54gMss3H
 5i+Cwt83ZjDJEU8pM6THUwESBszWPOK75qQWxYadugEomS7a/cI5ScubHzyJihaz2HKp9sM//Gr
 OGyZZeJDj5mxSt19X/DGhgjY9AU264IykhxhpadMbRZj67N5Jgjquxd0ZOyqTRXxoj/4WNTjD1n
 zfBCsyncG071TzA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Change posix_same_owner to take struct file_lock_core pointers, and
convert the callers to pass those in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 5d25a3f53c9d..9ff331b55b7a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -590,9 +590,9 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
 /*
  * Check whether two locks have the same owner.
  */
-static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
+static int posix_same_owner(struct file_lock_core *fl1, struct file_lock_core *fl2)
 {
-	return fl1->c.flc_owner == fl2->c.flc_owner;
+	return fl1->flc_owner == fl2->flc_owner;
 }
 
 /* Must be called with the flc_lock held! */
@@ -857,7 +857,7 @@ static bool posix_locks_conflict(struct file_lock *caller_fl,
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
-	if (posix_same_owner(caller_fl, sys_fl))
+	if (posix_same_owner(&caller_fl->c, &sys_fl->c))
 		return false;
 
 	/* Check whether they overlap */
@@ -875,7 +875,7 @@ static bool posix_test_locks_conflict(struct file_lock *caller_fl,
 {
 	/* F_UNLCK checks any locks on the same fd. */
 	if (lock_is_unlock(caller_fl)) {
-		if (!posix_same_owner(caller_fl, sys_fl))
+		if (!posix_same_owner(&caller_fl->c, &sys_fl->c))
 			return false;
 		return locks_overlap(caller_fl, sys_fl);
 	}
@@ -978,7 +978,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 	struct file_lock *fl;
 
 	hash_for_each_possible(blocked_hash, fl, c.flc_link, posix_owner_key(block_fl)) {
-		if (posix_same_owner(fl, block_fl)) {
+		if (posix_same_owner(&fl->c, &block_fl->c)) {
 			while (fl->c.flc_blocker)
 				fl = fl->c.flc_blocker;
 			return fl;
@@ -1005,7 +1005,7 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
 		if (i++ > MAX_DEADLK_ITERATIONS)
 			return 0;
-		if (posix_same_owner(caller_fl, block_fl))
+		if (posix_same_owner(&caller_fl->c, &block_fl->c))
 			return 1;
 	}
 	return 0;
@@ -1178,13 +1178,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	/* Find the first old lock with the same owner as the new lock */
 	list_for_each_entry(fl, &ctx->flc_posix, c.flc_list) {
-		if (posix_same_owner(request, fl))
+		if (posix_same_owner(&request->c, &fl->c))
 			break;
 	}
 
 	/* Process locks with this owner. */
 	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, c.flc_list) {
-		if (!posix_same_owner(request, fl))
+		if (!posix_same_owner(&request->c, &fl->c))
 			break;
 
 		/* Detect adjacent or overlapping regions (if same lock type) */

-- 
2.43.0


