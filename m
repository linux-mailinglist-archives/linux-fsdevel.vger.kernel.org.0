Return-Path: <linux-fsdevel+bounces-9740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CCB844BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B1280AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BE47F52;
	Wed, 31 Jan 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpcuOybx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91647F4A;
	Wed, 31 Jan 2024 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742176; cv=none; b=KdAiwRzZ9BL1xJrzn2EB3SbZNrycY6GfSabjhiJFlqJb5qsAMc0H6gyZ+7/0o9xwKvcpkh4C+g1ZO48+Gn49ZZp9NaWlgtH24LY1Bl+1QAJuUSh7ns1m1032hc8dEj1WNITgcqn+CsR8W9w8VDgZfGhfVpo5NS1nlU5zEy9UO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742176; c=relaxed/simple;
	bh=cTEhrRQK/pPZfG5SgdIjCBsK5/c2WpJ2+Rpoetr4t34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9XUSN6rWHHZLnZ9XSF7EMUOwp+9VjnG+9YFGx6nzoypWwfo2rWDPh4VFzD1yiO5miqTMEnFPcDc8J1Hj/q4stHhY6b0huvX6gCC52AcbZhM8IziValNv6OqWEh7Dv338621a7jYrJ9xoPanlrksFG8XotOFdG7kk5CxntCr8xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpcuOybx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5565FC43394;
	Wed, 31 Jan 2024 23:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742176;
	bh=cTEhrRQK/pPZfG5SgdIjCBsK5/c2WpJ2+Rpoetr4t34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KpcuOybxKp8kzBVNZRVOSd2hyOzxsHN+Q2JM6pKcBsoHVZ1+BfvD/BiP7Az7Gfa9S
	 5TXnSKiTv5Q8KiTx+5BpFcbCmK69WsXV4n/HCIqcXxFoPy0s9w46d9jLoRDCF8VnXf
	 HpcjsoqGoWukHOXZfgxclIckk4lZ0snpUG8n9LQZJeVqox3e8rHfQnPFeLDbNNwDs1
	 /R2VvYHq7iiY63PpGTrouf1vJgaaODF87cuSfXq6MFAaQL8L9CBS/vF6/M6BtfQvpw
	 L+2QCjpnp/Ml3XWRRKm45FKmXLUU2R7Bg23sNS2CKpm4HqtoJzxZdoqTzIXyop7dhc
	 J/ZGjSeR76tkQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:51 -0500
Subject: [PATCH v3 10/47] lockd: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-10-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4108; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cTEhrRQK/pPZfG5SgdIjCBsK5/c2WpJ2+Rpoetr4t34=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFvmegJWC8ptz/XfE+aVF7dcJVYgi199W+Hi
 DkuSh5cSr+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FZFlEACnCNo6HdQ4edZhTv7QqDxGRqev0LLEA1C3jqcbs/zdAYJRSOAC4knLZhmDH+JHVobGUXx
 YTKdHYWYrNXQ5Dp9iiUNE3Nt4B4Ehs6Qxuh1OJbcGCWblzwatHd8WFY8ieMwptnmXc/M38IX3pD
 oJ/NgJGLTJ6ayZ1JMeMty3HNYupR0jruiR5/mKf94yhEpiRGYAslpKTa9c4MFZGo9/dknneUJ+1
 N7aspE+RpBP1lbcpTeUwe3bg7aA0NldHnlWgW6Q+ubwkaYGDWg7LPrDkDhZRuBBkvhU2lmsmsjq
 VOOItL0ig0x26tUGr6TH3BHwOQwiMUq1XoxB+msHl44X0pQEMtRH7hitp/CTWg6VMaJ/8/YSsDV
 9GBPeeK0C0KSLjFtzixZBqjTCAA5OtG2zotaePy5S83kSz320SOGTBLPYpwolg8gUnQJbHT977c
 qWnD0Kfkz/YRDloQylVI5N9qIub9QdL7qg4OD+o080JEy6G04fafb5kqvf/qCd9CvWH69Am/7Xq
 otfnfBHfRsnQKLR6RHT5qUwNfvl3C6nsmxudTAH21D8ufbJJ3NI+L/N81rHgJrzppiS9vDLDKmm
 tEKoRE1QqOIoUIEfCS5ZBdLkPjJv1I3Rvq4kiSezxsCBw/Kn3Y0sundyUGo20rRZh3ooQdyp+vR
 MAoSoPdhda8CErg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions. Also in later
patches we're going to introduce some macros with names that clash with
the variable names in nlmclnt_lock. Rename them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/clntproc.c | 20 ++++++++++----------
 fs/lockd/svcsubs.c  |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index fba6c7fa7474..cc596748e359 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -522,8 +522,8 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	struct nlm_wait block;
-	unsigned char fl_flags = fl->fl_flags;
-	unsigned char fl_type;
+	unsigned char flags = fl->fl_flags;
+	unsigned char type;
 	__be32 b_status;
 	int status = -ENOLCK;
 
@@ -533,7 +533,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 
 	fl->fl_flags |= FL_ACCESS;
 	status = do_vfs_lock(fl);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = flags;
 	if (status < 0)
 		goto out;
 
@@ -595,7 +595,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 		if (do_vfs_lock(fl) < 0)
 			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __func__);
 		up_read(&host->h_rwsem);
-		fl->fl_flags = fl_flags;
+		fl->fl_flags = flags;
 		status = 0;
 	}
 	if (status < 0)
@@ -605,7 +605,7 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 	 * cases NLM_LCK_DENIED is returned for a permanent error.  So
 	 * turn it into an ENOLCK.
 	 */
-	if (resp->status == nlm_lck_denied && (fl_flags & FL_SLEEP))
+	if (resp->status == nlm_lck_denied && (flags & FL_SLEEP))
 		status = -ENOLCK;
 	else
 		status = nlm_stat_to_errno(resp->status);
@@ -622,13 +622,13 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			   req->a_host->h_addrlen, req->a_res.status);
 	dprintk("lockd: lock attempt ended in fatal error.\n"
 		"       Attempting to unlock.\n");
-	fl_type = fl->fl_type;
+	type = fl->fl_type;
 	fl->fl_type = F_UNLCK;
 	down_read(&host->h_rwsem);
 	do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_type = fl_type;
-	fl->fl_flags = fl_flags;
+	fl->fl_type = type;
+	fl->fl_flags = flags;
 	nlmclnt_async_call(cred, req, NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
 	return status;
 }
@@ -683,7 +683,7 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	int status;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char flags = fl->fl_flags;
 
 	/*
 	 * Note: the server is supposed to either grant us the unlock
@@ -694,7 +694,7 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	down_read(&host->h_rwsem);
 	status = do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_flags = fl_flags;
+	fl->fl_flags = flags;
 	if (status == -ENOENT) {
 		status = 0;
 		goto out;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e3b6229e7ae5..2f33c187b876 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -73,7 +73,7 @@ static inline unsigned int file_hash(struct nfs_fh *f)
 
 int lock_to_openmode(struct file_lock *lock)
 {
-	return (lock->fl_type == F_WRLCK) ? O_WRONLY : O_RDONLY;
+	return (lock_is_write(lock)) ? O_WRONLY : O_RDONLY;
 }
 
 /*
@@ -218,7 +218,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 again:
 	file->f_locks = 0;
 	spin_lock(&flctx->flc_lock);
-	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+	for_each_file_lock(fl, &flctx->flc_posix) {
 		if (fl->fl_lmops != &nlmsvc_lock_operations)
 			continue;
 
@@ -272,7 +272,7 @@ nlm_file_inuse(struct nlm_file *file)
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
-		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+		for_each_file_lock(fl, &flctx->flc_posix) {
 			if (fl->fl_lmops == &nlmsvc_lock_operations) {
 				spin_unlock(&flctx->flc_lock);
 				return 1;

-- 
2.43.0


