Return-Path: <linux-fsdevel+bounces-8887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FC83BF92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705991C21036
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60285FB80;
	Thu, 25 Jan 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEKy+7Lq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B55EE89;
	Thu, 25 Jan 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179453; cv=none; b=K/YFX49z9snBUnqCjPFMVW/FTGRjGKB3hxKYGUOAKJd9jR9ittLazcX8cu0ffWpPK333OQusyOgksEu2Gu6/mSprf0x3UHzjichn4b05spllzY6yUgt8dn7i56Yi5LRzorsw9yZzOaTDCNGANoYgw1rarISvUYu1DND7kUAcYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179453; c=relaxed/simple;
	bh=EJNBZW+LLuEn3xUVX9XN4afgk7jPakpgPOqIPlOYvJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JuB88tP5PUZsgiaQZ7AjMydNWX4AddCGelLB3ZrBD6LTfxohIEIDc+VawLt7H7VsPwvqWOrIqdKwcZjcavJYnGYbQ6wd7hQn4y9sHa9u3SIP8fF14osRuopDZTgIbFUPirVYXzRhmfHlAvMhC5ysCW0kPt5uLQJSAqATjbFqG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEKy+7Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC006C433B2;
	Thu, 25 Jan 2024 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179452;
	bh=EJNBZW+LLuEn3xUVX9XN4afgk7jPakpgPOqIPlOYvJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PEKy+7Lq/Vj9Hge0FNhcZugnvOohrqWeEMkjfVBdUC7JABzmDY8lX8kpO8HUPfKUy
	 YIQLPdcKseQ3BLSguSE+nT6rePbiF0HY0aSsGfEtlAY78xYcp7MvpcNIn+rwzZSREi
	 BGqlmFHH8Y2IjAvKp6zr9tnJbugJoQtd/1K1AIaPgQ+huCezMqgGrSEBCPxr7CXdUX
	 VmqeZ+RvS3pRdnzjkgqbKwPhD6DJLec2wVHnOfM1X/yhl5h+cUFniHs4G2YcolLkyR
	 9VB0sDtjJW6IZsXg2mf/QhUd7wbGpp+11BidT11jJPYI6aytwSXwNmcqFLu/g7346Q
	 bkb2vVTUvHnHg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:56 -0500
Subject: [PATCH v2 15/41] filelock: make posix_same_owner take
 file_lock_core pointers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-15-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EJNBZW+LLuEn3xUVX9XN4afgk7jPakpgPOqIPlOYvJY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs7rYwvH2rD3o3kb7U1gLb9iX3/J/FNVo9D9
 r3XPVCLxqiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OwAKCRAADmhBGVaC
 FSZ/D/4jh2uL532A/N8MctS2m4IUVd0Btl1ASiXZdozpMjjq8cukVOxlZ+0FKxA0MaHzMbFwx3x
 wygRIPHTsTfO5st+u0mjrThJM59CQhoFLPtLAkfZ0zGBzcGm8E+anyb/8EorLLke8nTGH83Zjqg
 bqiT0/uBZfSmIoIFdVbOhIMr1w9heRkJf5IBfvnpAzIucH0s+oZPNm2dyE2oDZdzHNY3QAxhMBT
 YmC2VhiahlUEJkhcwfiTEORym/TxmVXiDAI1ckuicDhsIoqQzt5KzsLdJcNNgFbI7D/Q+Tei/D7
 IOa6i7HZ87Qur+9FgmijtNDhHUufLCM5/Ai0YVZepMBSGiCLFOVryFK/SYSeI/V4bgri+XAA9Ri
 /SckKUOfW4TuwfooVDG7sJoNPkUHZSrCCGMTqfXcZsdJSq2PEEixkfHde0IJfwFBBZTTmFQWy1v
 I5r1E3C5VzpdrIGAjc+Rvcuj0M3u1g+TwlQev4d0A5NWcHivSDBa3HaF+pIteDE67lTGtZuOonk
 1E2YzgHBmTF7s8fXFb4sEvYI/+JQGhmF3qsOKelmFd71YA9Xxo666TsXHhMwA2W3VfcqbPVVsQN
 9F0ovCojk1jjcqd9px4PDXX4Qr1AeLzxuBH3/GnIKNwYnb1NbM73koCXiu9YbLwyFwCebsRmAsC
 D8XB3FT6VOddPyw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Change posix_same_owner to take struct file_lock_core pointers, and
convert the callers to pass those in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index a0d6fc0e043a..bd0cfee230ae 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -590,9 +590,9 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
 /*
  * Check whether two locks have the same owner.
  */
-static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
+static int posix_same_owner(struct file_lock_core *fl1, struct file_lock_core *fl2)
 {
-	return fl1->fl_core.flc_owner == fl2->fl_core.flc_owner;
+	return fl1->flc_owner == fl2->flc_owner;
 }
 
 /* Must be called with the flc_lock held! */
@@ -857,7 +857,7 @@ static bool posix_locks_conflict(struct file_lock *caller_fl,
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
-	if (posix_same_owner(caller_fl, sys_fl))
+	if (posix_same_owner(&caller_fl->fl_core, &sys_fl->fl_core))
 		return false;
 
 	/* Check whether they overlap */
@@ -875,7 +875,7 @@ static bool posix_test_locks_conflict(struct file_lock *caller_fl,
 {
 	/* F_UNLCK checks any locks on the same fd. */
 	if (caller_fl->fl_core.flc_type == F_UNLCK) {
-		if (!posix_same_owner(caller_fl, sys_fl))
+		if (!posix_same_owner(&caller_fl->fl_core, &sys_fl->fl_core))
 			return false;
 		return locks_overlap(caller_fl, sys_fl);
 	}
@@ -978,7 +978,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 	struct file_lock *fl;
 
 	hash_for_each_possible(blocked_hash, fl, fl_core.flc_link, posix_owner_key(block_fl)) {
-		if (posix_same_owner(fl, block_fl)) {
+		if (posix_same_owner(&fl->fl_core, &block_fl->fl_core)) {
 			while (fl->fl_core.flc_blocker)
 				fl = fl->fl_core.flc_blocker;
 			return fl;
@@ -1005,7 +1005,7 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
 		if (i++ > MAX_DEADLK_ITERATIONS)
 			return 0;
-		if (posix_same_owner(caller_fl, block_fl))
+		if (posix_same_owner(&caller_fl->fl_core, &block_fl->fl_core))
 			return 1;
 	}
 	return 0;
@@ -1178,13 +1178,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	/* Find the first old lock with the same owner as the new lock */
 	list_for_each_entry(fl, &ctx->flc_posix, fl_core.flc_list) {
-		if (posix_same_owner(request, fl))
+		if (posix_same_owner(&request->fl_core, &fl->fl_core))
 			break;
 	}
 
 	/* Process locks with this owner. */
 	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_core.flc_list) {
-		if (!posix_same_owner(request, fl))
+		if (!posix_same_owner(&request->fl_core, &fl->fl_core))
 			break;
 
 		/* Detect adjacent or overlapping regions (if same lock type) */

-- 
2.43.0


