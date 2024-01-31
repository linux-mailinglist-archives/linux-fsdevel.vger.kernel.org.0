Return-Path: <linux-fsdevel+bounces-9742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F4844BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A93EB2F02D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DD482E5;
	Wed, 31 Jan 2024 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omrorkuN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D23B793;
	Wed, 31 Jan 2024 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742184; cv=none; b=TynPFAyDqmS/2/SHc6jFsKf4dRHYf6PZ2NCYQ0JFDxtoTNpFU+dUiMnL3Vy/qQAmV65k5BIE6sNEpJzvfVP9usGk8ZXuUExsCo6XYvTtle/g42VYoYSDLmAWEghavpdC8wlYMUE7J5I7kuec86V+LD3gkyMQ5gTcqm/5xcClRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742184; c=relaxed/simple;
	bh=V/Cml+ndEU7iQrcDHnjT9HOwBZUwf1ET15f3AAfB7zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuvXwufYFyrrCJktlOkHsSklkvCV2z/XKcYJOVTdwPSl+3sTR4PbOGyVUQkwXxAO6AarNQ+pzscX1KYHF+X0N9zbt3n1R9Pnov14NjrNJLAUun51mt/THIgNIWH7BhriYUI/45B1Hof5yMsyG28S/Bggg/qgCaZoXERprOyzBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omrorkuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45726C43394;
	Wed, 31 Jan 2024 23:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742184;
	bh=V/Cml+ndEU7iQrcDHnjT9HOwBZUwf1ET15f3AAfB7zM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=omrorkuNj3diaNJvYiK9P5+yx8p60ff8FukG+v2+B7wTGbS+e8zUhtTdCf1MQZFY7
	 uIKg/y1b5LpNxfuOuU8KNS9shaWxuIBBe+E+OmEQdgfbLFrDMNDdgJhRiSgq02szf3
	 QFdOkSxUpkThzjYhrcqyY6FWBqGsoODi4kh+YZjecu37Ivn4CEPfqAi50VRibJuT5Z
	 VmzQQXu6IK6lGoj+h5US3L/67zesRUV3XGFBb7TEVwlsHD23aTJGvaZkUyOUs5kfa3
	 tnap+AncKNLD8P/Gjf1RjVIqKCUg6VsYygeac4MfnZ6hN1dx0VzD+dDovyQkG4MuEz
	 Hpy7xDXkAP8Qw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:53 -0500
Subject: [PATCH v3 12/47] nfsd: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-12-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4942; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=V/Cml+ndEU7iQrcDHnjT9HOwBZUwf1ET15f3AAfB7zM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFveQ3kAMFR+bNak+EV0mzECrq5iciXdyE9m
 QnN6JXrqtCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FXtUEACeQ33gx59LXWKBtRatMw8bD3yv2bYtjghaJJvF5XfMUmiX14V065boE5cV3gXMnZGrspQ
 tqo4DJIEaQ4lFXTIARdtx64HQCI9lMABI4gZAP2XzrYGm9LHCCPyuny9jIC6cBytL2tckxf4O8j
 glgdiO10rXdFZdGVpSBFE/6Vrf91Fjmk21eifR2nLK0MF7MRTX/+otIhthokSqkYD+bNbe+Bx2Z
 +JH3O1lkf6bRoWgKw2L24nOT5seYXPsvL0KXAeabZP74WNeOPO30W7PwmxmINQhxCBJzPBsWjWg
 9dJR52MP/a6Um6S9LELMGq0TAScE7fxYm5j5uJRnk7NXT7Z7OC/r9NRdXv8EudCYt8r4n/sNp7m
 QcbwifvyLq0WZIwaDZ+rWmxGaNSk8tRgBSdO0rD1vOYHZc5itN63NLMbKjnhSGtQWHAiS7c0bRc
 1+wRNBZdfWD9VMf1YnYijA0xkJ2bJtVRLUtOX3FbmFvrKqidD9qg/UL+uq6LIKtZU6WssLAJZbS
 QKurKERrbp7mxYpVTObWJYAZnFmfeiOIsgYze7WiPuuGX/Bvr/iN8qT8WBcL14ckMvPBSSftF1V
 giRoBcq/9JOMgiZjTkDr60d2K8crFpvOXfKgh+3bxIyrbYuwc0QHzcJMp5TJVZ0TJWigsB6/zhO
 hP0MjuSrsZ+3msg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions. Also, in later
patches we're going to introduce some macros with names that clash with
the variable names in nfsd4_lock. Rename them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6dc6340e2852..83d605ecdcdc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7493,8 +7493,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	int lkflg;
 	int err;
 	bool new = false;
-	unsigned char fl_type;
-	unsigned int fl_flags = FL_POSIX;
+	unsigned char type;
+	unsigned int flags = FL_POSIX;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
@@ -7557,14 +7557,14 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 
 	if (lock->lk_reclaim)
-		fl_flags |= FL_RECLAIM;
+		flags |= FL_RECLAIM;
 
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
 			if (nfsd4_has_session(cstate) ||
 			    exportfs_lock_op_is_async(sb->s_export_op))
-				fl_flags |= FL_SLEEP;
+				flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
 			spin_lock(&fp->fi_lock);
@@ -7572,12 +7572,12 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_READ);
 			spin_unlock(&fp->fi_lock);
-			fl_type = F_RDLCK;
+			type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
 			if (nfsd4_has_session(cstate) ||
 			    exportfs_lock_op_is_async(sb->s_export_op))
-				fl_flags |= FL_SLEEP;
+				flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
 			spin_lock(&fp->fi_lock);
@@ -7585,7 +7585,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			if (nf)
 				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_WRITE);
 			spin_unlock(&fp->fi_lock);
-			fl_type = F_WRLCK;
+			type = F_WRLCK;
 			break;
 		default:
 			status = nfserr_inval;
@@ -7605,7 +7605,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * on those filesystems:
 	 */
 	if (!exportfs_lock_op_is_async(sb->s_export_op))
-		fl_flags &= ~FL_SLEEP;
+		flags &= ~FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
 	if (!nbl) {
@@ -7615,11 +7615,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	file_lock = &nbl->nbl_lock;
-	file_lock->fl_type = fl_type;
+	file_lock->fl_type = type;
 	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
 	file_lock->fl_pid = current->tgid;
 	file_lock->fl_file = nf->nf_file;
-	file_lock->fl_flags = fl_flags;
+	file_lock->fl_flags = flags;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = lock->lk_offset;
 	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
@@ -7632,7 +7632,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	if (fl_flags & FL_SLEEP) {
+	if (flags & FL_SLEEP) {
 		nbl->nbl_time = ktime_get_boottime_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
@@ -7669,7 +7669,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	if (nbl) {
 		/* dequeue it if we queued it before */
-		if (fl_flags & FL_SLEEP) {
+		if (flags & FL_SLEEP) {
 			spin_lock(&nn->blocked_locks_lock);
 			if (!list_empty(&nbl->nbl_list) &&
 			    !list_empty(&nbl->nbl_lru)) {
@@ -7928,7 +7928,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
-		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
+		for_each_file_lock(fl, &flctx->flc_posix) {
 			if (fl->fl_owner == (fl_owner_t)lowner) {
 				status = true;
 				break;
@@ -8459,7 +8459,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 	if (!ctx)
 		return 0;
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+	for_each_file_lock(fl, &ctx->flc_lease) {
 		if (fl->fl_flags == FL_LAYOUT)
 			continue;
 		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
@@ -8468,11 +8468,11 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 			 * we are done; there isn't any write delegation
 			 * on this inode
 			 */
-			if (fl->fl_type == F_RDLCK)
+			if (lock_is_read(fl))
 				break;
 			goto break_lease;
 		}
-		if (fl->fl_type == F_WRLCK) {
+		if (lock_is_write(fl)) {
 			dp = fl->fl_owner;
 			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
 				spin_unlock(&ctx->flc_lock);

-- 
2.43.0


