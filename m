Return-Path: <linux-fsdevel+bounces-8899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3583BFF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDC6B2D5EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FB0634F9;
	Thu, 25 Jan 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zny8bRHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F2634ED;
	Thu, 25 Jan 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179498; cv=none; b=foX/2lVtkQQ5G92ywDC21uMo3GCmZdUdM3nTmk1HzuUpi62cd1Jv8XMGfRLXbYFnDeMXF8emnyQ3uRsLAx3zXMR6wdwwLmuXPUp9i3KPmdpjaHBuEsPaBG95j6k7VByGWEfOsP+ojw6+rymjmO4HS3iFNI7kCKbNFjfMwa1jGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179498; c=relaxed/simple;
	bh=nD9BEv1CjR2OEjVeGMUNguKQLxTTM6NPvUbffSU/wSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/tXyXrQCajMs1HnsOmnOxrM0vLh5GwjOG7uIep0NCkJXv/EPG7Vo08ewGcShy53QCrWYDGn8rBr0JZgBY7eCfdrVH5Y9LVCdm4//pNTJLIt12cQPV6DJxiIfyCK81vZ8LFLykJilT0okhAZeF5MzWpQ1El7+mhmemHq90SMIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zny8bRHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B9C43390;
	Thu, 25 Jan 2024 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179498;
	bh=nD9BEv1CjR2OEjVeGMUNguKQLxTTM6NPvUbffSU/wSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zny8bRHQmNv4M03mIxXaXtc0dCpUSLo1Se3qED43JoJs2I8LBsReArD6qamVjqiH+
	 hR7ap85HlxCSXtnGVBsGHxxETKBi6thUDStd9Z2TAO+t3K/RRk2EZgXI7ANY3mNYyL
	 rGxPXFCO9lwl2FgaFDo7FwvojU96rn5chhT1Y4Iy8CzSchD3qmgeGyaGYQEIa1t/Az
	 fkYMxVvd0otc3kmiEVUqGRtF7/rdVySNFmGmAT2IChRc35/2SsLKDTga9Ifl4Ipx/W
	 C82VcLFX0r4I5kjMVzAxwW5M161EtBjeQE0bT6xHwq/xhdcVvWijNXC/gMAzID17XL
	 VK/mcwYHCZpCw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:08 -0500
Subject: [PATCH v2 27/41] filelock: convert locks_translate_pid to take
 file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-27-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3137; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nD9BEv1CjR2OEjVeGMUNguKQLxTTM6NPvUbffSU/wSk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs9y/o7I1K7nhN5OVz7m4BnLP++BiaKwndRm
 iQSPatwv8iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PQAKCRAADmhBGVaC
 Fa+EEAChdI4fiS8GaZOJEUHs4gt7453mUL0TceiKxymqOqdC1MkeSsPi7KSeMaCfKGZDe5XUYxX
 jIS7vgHQmQoeEvJIuke5wfJU26K1YlXcSomHhUpAI+KUIel1EkV7Bwhr1DSYinF9aRA0XWaTLGl
 X2gcDZIdPeiA1yM3MXSOCDCpxjS7PW2fktGxR48kNDnq0Q8cRuVWeB3u/rUkC4o/vEHmTmyX+ho
 j4i9MEslLYEAuQ1eXGwf1903oRh9831rIUszxkXpYt05TPDnVU3emG/kbX7FoxeQr1i0XI99r8o
 ByPaFwjUv/MfpWtr+LnjSIRXWO7QokFkHQcRUrvdDPX1j8flHM/QuJ4I5LZQQVGXZE1IhEfiBzH
 Lq0I0sJissOACy7C+s6EIyGClcQy1U5+1zCPsSVYGpxUDASptnnsZgKRyhov4Xn+IGtKCle6/RB
 dcXAvQo68oCLUKw/KJpuVMo20Nj47knGoejWzc6OTJLsXojAQWn4DmsojyadRcG59mjt3UbdOfq
 n7mmjncdQnOdsobfNHXZaJCiMArPKIKQssxI95UnucqvAcHEalb5jNmN+iV1G02Fg6LHtrMl/ON
 /172GK5Eqas4o0+B9qTS8GBc0XvlXNj5tgHQadDAU/wfnECvA/gLEyQGmpheWvu//Vgnv/xi4An
 3RK1bGttIkX+hag==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 0491d621417d..e8afdd084245 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2169,17 +2169,17 @@ EXPORT_SYMBOL_GPL(vfs_test_lock);
  *
  * Used to translate a fl_pid into a namespace virtual pid number
  */
-static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
+static pid_t locks_translate_pid(struct file_lock_core *fl, struct pid_namespace *ns)
 {
 	pid_t vnr;
 	struct pid *pid;
 
-	if (fl->fl_core.flc_flags & FL_OFDLCK)
+	if (fl->flc_flags & FL_OFDLCK)
 		return -1;
 
 	/* Remote locks report a negative pid value */
-	if (fl->fl_core.flc_pid <= 0)
-		return fl->fl_core.flc_pid;
+	if (fl->flc_pid <= 0)
+		return fl->flc_pid;
 
 	/*
 	 * If the flock owner process is dead and its pid has been already
@@ -2187,10 +2187,10 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	 * flock owner pid number in init pidns.
 	 */
 	if (ns == &init_pid_ns)
-		return (pid_t) fl->fl_core.flc_pid;
+		return (pid_t) fl->flc_pid;
 
 	rcu_read_lock();
-	pid = find_pid_ns(fl->fl_core.flc_pid, &init_pid_ns);
+	pid = find_pid_ns(fl->flc_pid, &init_pid_ns);
 	vnr = pid_nr_ns(pid, ns);
 	rcu_read_unlock();
 	return vnr;
@@ -2198,7 +2198,7 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 
 static int posix_lock_to_flock(struct flock *flock, struct file_lock *fl)
 {
-	flock->l_pid = locks_translate_pid(fl, task_active_pid_ns(current));
+	flock->l_pid = locks_translate_pid(&fl->fl_core, task_active_pid_ns(current));
 #if BITS_PER_LONG == 32
 	/*
 	 * Make sure we can represent the posix lock via
@@ -2220,7 +2220,7 @@ static int posix_lock_to_flock(struct flock *flock, struct file_lock *fl)
 #if BITS_PER_LONG == 32
 static void posix_lock_to_flock64(struct flock64 *flock, struct file_lock *fl)
 {
-	flock->l_pid = locks_translate_pid(fl, task_active_pid_ns(current));
+	flock->l_pid = locks_translate_pid(&fl->fl_core, task_active_pid_ns(current));
 	flock->l_start = fl->fl_start;
 	flock->l_len = fl->fl_end == OFFSET_MAX ? 0 :
 		fl->fl_end - fl->fl_start + 1;
@@ -2726,7 +2726,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
 	int type = fl->fl_core.flc_type;
 
-	pid = locks_translate_pid(fl, proc_pidns);
+	pid = locks_translate_pid(&fl->fl_core, proc_pidns);
 	/*
 	 * If lock owner is dead (and pid is freed) or not visible in current
 	 * pidns, zero is shown as a pid value. Check lock info from
@@ -2819,7 +2819,7 @@ static int locks_show(struct seq_file *f, void *v)
 
 	cur = hlist_entry(v, struct file_lock, fl_core.flc_link);
 
-	if (locks_translate_pid(cur, proc_pidns) == 0)
+	if (locks_translate_pid(&cur->fl_core, proc_pidns) == 0)
 		return 0;
 
 	/* View this crossed linked list as a binary tree, the first member of fl_blocked_requests

-- 
2.43.0


