Return-Path: <linux-fsdevel+bounces-8908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B383C0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9104CB2EBD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C98679F2;
	Thu, 25 Jan 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk0lBzeg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDA67756;
	Thu, 25 Jan 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179533; cv=none; b=jqMrVxomvpFZPlpN3yD3dr6VzBW0kK2iWJrAcQYUHRRgFnGhyel0j+D7V/WRcL9NZZ9Y1HZ/pB+NPqv6Hg97N1zXCddley1GY3R43EvY2+n6Gti882gD4kV9ThC4rrEYf0sEMBpTE3TtTivFVMKg5y+TdOj9JBt5Zeoqhloc1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179533; c=relaxed/simple;
	bh=KEGIhG1M9cVNuxbLTEMHAkQB/+mlSZpkhInSOcaicFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9woY5t4WYy6xaX8Pj0ICG2mcss09w+zgYynSgetuPpe4Ga6mX9lG3sz9g4ThT98vyKQSi8rgPKlEnuZ8t49sTN7Yy+uFdsPAE2lXbrHB6H8qShwwJ7iSYllkNXQRTYyzWIapnMglOE/B0b5nib9K/cftxPsgADA+m2l3k7Av5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk0lBzeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959C3C43142;
	Thu, 25 Jan 2024 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179533;
	bh=KEGIhG1M9cVNuxbLTEMHAkQB/+mlSZpkhInSOcaicFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bk0lBzeg2OP7ynFxKyDDSfnNppzMbVPTmpIChVI8GFGAjchcQ89GxyzImjj8w2T5r
	 7JXvIIAt3+3RCYlVOzK26ExNKyjOtbUBbt43I8cEyY3rQvp4mMwSxGru9sRb9ErjEx
	 Bhtt6EsiuKBX0ey0qlKqUrmgKdYVOhrOvg806PweNnvLbBlHAWiq9mVTjpxYc8StO1
	 TEiMMpdDpoRJRXesXcQMtcB3TPU2t/0YPQPavIHKNbcrXhUmKsPzx3GpxwGooL8QBL
	 5FjxnfEoPUl+WpRzQlMogtWQh5HQZI8/ZeuY1YGJ51EGzx8fbrBm7jy12Vrj7iPwIK
	 Gl4BCxHzgr5bA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:43:17 -0500
Subject: [PATCH v2 36/41] nfsd: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-36-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11733; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KEGIhG1M9cVNuxbLTEMHAkQB/+mlSZpkhInSOcaicFg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs+wNVTxC3ISSGsT3NEhTs2nH5RzWe4hl7yu
 Szn8iuPy7uJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PgAKCRAADmhBGVaC
 FUm2EACXCXZ22xHzrZYtUU1tpf3IKgt5T6xB5FtLJ7r28Q352NFn9cpeGv7r2jXD3/22pXKbpoH
 rNLGd1GQLEFTmt81qCEswsogz3xDhEXQZ3Gq8nt4533/OCIB4AGUhx09AX+h3o1Jnen72aUFrK8
 qAJSoXJVUmg9msNBTTVPwc6hp+J3bFWvwCuOAr1+yfO6mm+/v25GHmbsyMLFv2JdGRJil3txLdu
 hmhooueWVaDX8dlefzwosHVhOZ9tBvyvW6J2kyOFGpJZIRVHWs+tIlm5e90SGUCK1oqohrLLTl9
 GU8byV/hpGn15Ed1ilPtWkYglAebG4xH6lsUB/fNDpCQliMJSrYrratKt3AJnkPynMvSLQaA0Wa
 yW1J0Nd2smjq2t1YQaLka0dExupOlnKjDOn7I/3ecWb4PgQ8UW/kpBITfcuKNArsF8p4mABL6u/
 rkF50v1OpErveFxSVSpGmKuzTn/swvTKCKG5ZqXkSxt3add6u4FgG1mJVrGqN2rnfT0fK+Gtsxv
 y9MWlsKICLPxMJGZ7aMMeLdiEvKqQF1kac36SjV0stb3FoWCAQuCutDJJH4n3nZJKgBY57fDSzb
 YILM1A9sXnHtlt3ffIVOvedxR/U3cdE2nJ6/QGfCyX+MDgj8dUAkCtpjg0sECFk4SjjKDstYUYn
 Ddnl2mxLdhKuqMQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c    |  4 +--
 fs/nfsd/netns.h        |  1 -
 fs/nfsd/nfs4callback.c |  2 +-
 fs/nfsd/nfs4layouts.c  | 15 +++++-----
 fs/nfsd/nfs4state.c    | 77 +++++++++++++++++++++++++-------------------------
 5 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9cb7f0c33df5..cdd36758c692 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -662,8 +662,8 @@ nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 	struct file_lock *fl = data;
 
 	/* Only close files for F_SETLEASE leases */
-	if (fl->fl_flags & FL_LEASE)
-		nfsd_file_close_inode(file_inode(fl->fl_file));
+	if (fl->fl_core.flc_flags & FL_LEASE)
+		nfsd_file_close_inode(file_inode(fl->fl_core.flc_file));
 	return 0;
 }
 
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index fd91125208be..74b4360779a1 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,7 +10,6 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 926c29879c6a..3513c94481b4 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -674,7 +674,7 @@ static void nfs4_xdr_enc_cb_notify_lock(struct rpc_rqst *req,
 	const struct nfsd4_callback *cb = data;
 	const struct nfsd4_blocked_lock *nbl =
 		container_of(cb, struct nfsd4_blocked_lock, nbl_cb);
-	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)nbl->nbl_lock.fl_owner;
+	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)nbl->nbl_lock.fl_core.flc_owner;
 	struct nfs4_cb_compound_hdr hdr = {
 		.ident = 0,
 		.minorversion = cb->cb_clp->cl_minorversion,
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 5e8096bc5eaa..ddf221d31acf 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -193,14 +193,15 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 		return -ENOMEM;
 	locks_init_lock(fl);
 	fl->fl_lmops = &nfsd4_layouts_lm_ops;
-	fl->fl_flags = FL_LAYOUT;
-	fl->fl_type = F_RDLCK;
+	fl->fl_core.flc_flags = FL_LAYOUT;
+	fl->fl_core.flc_type = F_RDLCK;
 	fl->fl_end = OFFSET_MAX;
-	fl->fl_owner = ls;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = ls->ls_file->nf_file;
+	fl->fl_core.flc_owner = ls;
+	fl->fl_core.flc_pid = current->tgid;
+	fl->fl_core.flc_file = ls->ls_file->nf_file;
 
-	status = vfs_setlease(fl->fl_file, fl->fl_type, &fl, NULL);
+	status = vfs_setlease(fl->fl_core.flc_file, fl->fl_core.flc_type, &fl,
+			      NULL);
 	if (status) {
 		locks_free_lock(fl);
 		return status;
@@ -731,7 +732,7 @@ nfsd4_layout_lm_break(struct file_lock *fl)
 	 * in time:
 	 */
 	fl->fl_break_time = 0;
-	nfsd4_recall_file_layout(fl->fl_owner);
+	nfsd4_recall_file_layout(fl->fl_core.flc_owner);
 	return false;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f66e67394157..5899e5778fe7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4924,7 +4924,7 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 static bool
 nfsd_break_deleg_cb(struct file_lock *fl)
 {
-	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
+	struct nfs4_delegation *dp = (struct nfs4_delegation *) fl->fl_core.flc_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
 	struct nfsd_net *nn;
@@ -4962,7 +4962,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
  */
 static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 {
-	struct nfs4_delegation *dl = fl->fl_owner;
+	struct nfs4_delegation *dl = fl->fl_core.flc_owner;
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
@@ -4980,7 +4980,7 @@ static int
 nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 		     struct list_head *dispose)
 {
-	struct nfs4_delegation *dp = (struct nfs4_delegation *)onlist->fl_owner;
+	struct nfs4_delegation *dp = (struct nfs4_delegation *) onlist->fl_core.flc_owner;
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
 
 	if (arg & F_UNLCK) {
@@ -5340,12 +5340,12 @@ static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
-	fl->fl_flags = FL_DELEG;
-	fl->fl_type = flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK;
+	fl->fl_core.flc_flags = FL_DELEG;
+	fl->fl_core.flc_type = flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK;
 	fl->fl_end = OFFSET_MAX;
-	fl->fl_owner = (fl_owner_t)dp;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->fl_core.flc_owner = (fl_owner_t)dp;
+	fl->fl_core.flc_pid = current->tgid;
+	fl->fl_core.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
 	return fl;
 }
 
@@ -5533,7 +5533,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NULL);
+	status = vfs_setlease(fp->fi_deleg_file->nf_file,
+			      fl->fl_core.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lock(fl);
 	if (status)
@@ -7149,7 +7150,7 @@ nfsd4_lm_put_owner(fl_owner_t owner)
 static bool
 nfsd4_lm_lock_expirable(struct file_lock *cfl)
 {
-	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)cfl->fl_owner;
+	struct nfs4_lockowner *lo = (struct nfs4_lockowner *) cfl->fl_core.flc_owner;
 	struct nfs4_client *clp = lo->lo_owner.so_client;
 	struct nfsd_net *nn;
 
@@ -7171,7 +7172,7 @@ nfsd4_lm_expire_lock(void)
 static void
 nfsd4_lm_notify(struct file_lock *fl)
 {
-	struct nfs4_lockowner		*lo = (struct nfs4_lockowner *)fl->fl_owner;
+	struct nfs4_lockowner		*lo = (struct nfs4_lockowner *) fl->fl_core.flc_owner;
 	struct net			*net = lo->lo_owner.so_client->net;
 	struct nfsd_net			*nn = net_generic(net, nfsd_net_id);
 	struct nfsd4_blocked_lock	*nbl = container_of(fl,
@@ -7208,7 +7209,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
 	struct nfs4_lockowner *lo;
 
 	if (fl->fl_lmops == &nfsd_posix_mng_ops) {
-		lo = (struct nfs4_lockowner *) fl->fl_owner;
+		lo = (struct nfs4_lockowner *) fl->fl_core.flc_owner;
 		xdr_netobj_dup(&deny->ld_owner, &lo->lo_owner.so_owner,
 						GFP_KERNEL);
 		if (!deny->ld_owner.data)
@@ -7227,7 +7228,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
 	if (fl->fl_end != NFS4_MAX_UINT64)
 		deny->ld_length = fl->fl_end - fl->fl_start + 1;        
 	deny->ld_type = NFS4_READ_LT;
-	if (fl->fl_type != F_RDLCK)
+	if (fl->fl_core.flc_type != F_RDLCK)
 		deny->ld_type = NFS4_WRITE_LT;
 }
 
@@ -7615,11 +7616,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	file_lock = &nbl->nbl_lock;
-	file_lock->fl_type = type;
-	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
-	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = nf->nf_file;
-	file_lock->fl_flags = flags;
+	file_lock->fl_core.flc_type = type;
+	file_lock->fl_core.flc_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
+	file_lock->fl_core.flc_pid = current->tgid;
+	file_lock->fl_core.flc_file = nf->nf_file;
+	file_lock->fl_core.flc_flags = flags;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = lock->lk_offset;
 	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
@@ -7737,9 +7738,9 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 	err = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 	if (err)
 		goto out;
-	lock->fl_file = nf->nf_file;
+	lock->fl_core.flc_file = nf->nf_file;
 	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
-	lock->fl_file = NULL;
+	lock->fl_core.flc_file = NULL;
 out:
 	inode_unlock(inode);
 	nfsd_file_put(nf);
@@ -7784,11 +7785,11 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	switch (lockt->lt_type) {
 		case NFS4_READ_LT:
 		case NFS4_READW_LT:
-			file_lock->fl_type = F_RDLCK;
+			file_lock->fl_core.flc_type = F_RDLCK;
 			break;
 		case NFS4_WRITE_LT:
 		case NFS4_WRITEW_LT:
-			file_lock->fl_type = F_WRLCK;
+			file_lock->fl_core.flc_type = F_WRLCK;
 			break;
 		default:
 			dprintk("NFSD: nfs4_lockt: bad lock type!\n");
@@ -7798,9 +7799,9 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	lo = find_lockowner_str(cstate->clp, &lockt->lt_owner);
 	if (lo)
-		file_lock->fl_owner = (fl_owner_t)lo;
-	file_lock->fl_pid = current->tgid;
-	file_lock->fl_flags = FL_POSIX;
+		file_lock->fl_core.flc_owner = (fl_owner_t)lo;
+	file_lock->fl_core.flc_pid = current->tgid;
+	file_lock->fl_core.flc_flags = FL_POSIX;
 
 	file_lock->fl_start = lockt->lt_offset;
 	file_lock->fl_end = last_byte_offset(lockt->lt_offset, lockt->lt_length);
@@ -7811,7 +7812,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	if (file_lock->fl_type != F_UNLCK) {
+	if (file_lock->fl_core.flc_type != F_UNLCK) {
 		status = nfserr_denied;
 		nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
 	}
@@ -7867,11 +7868,11 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto put_file;
 	}
 
-	file_lock->fl_type = F_UNLCK;
-	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(stp->st_stateowner));
-	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = nf->nf_file;
-	file_lock->fl_flags = FL_POSIX;
+	file_lock->fl_core.flc_type = F_UNLCK;
+	file_lock->fl_core.flc_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(stp->st_stateowner));
+	file_lock->fl_core.flc_pid = current->tgid;
+	file_lock->fl_core.flc_file = nf->nf_file;
+	file_lock->fl_core.flc_flags = FL_POSIX;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = locku->lu_offset;
 
@@ -7926,8 +7927,8 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
-		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
-			if (fl->fl_owner == (fl_owner_t)lowner) {
+		list_for_each_entry(fl, &flctx->flc_posix, fl_core.flc_list) {
+			if (fl->fl_core.flc_owner == (fl_owner_t)lowner) {
 				status = true;
 				break;
 			}
@@ -8455,8 +8456,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 	if (!ctx)
 		return 0;
 	spin_lock(&ctx->flc_lock);
-	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-		if (fl->fl_flags == FL_LAYOUT)
+	list_for_each_entry(fl, &ctx->flc_lease, fl_core.flc_list) {
+		if (fl->fl_core.flc_flags == FL_LAYOUT)
 			continue;
 		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
 			/*
@@ -8464,12 +8465,12 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 			 * we are done; there isn't any write delegation
 			 * on this inode
 			 */
-			if (fl->fl_type == F_RDLCK)
+			if (fl->fl_core.flc_type == F_RDLCK)
 				break;
 			goto break_lease;
 		}
-		if (fl->fl_type == F_WRLCK) {
-			dp = fl->fl_owner;
+		if (fl->fl_core.flc_type == F_WRLCK) {
+			dp = fl->fl_core.flc_owner;
 			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
 				spin_unlock(&ctx->flc_lock);
 				return 0;

-- 
2.43.0


