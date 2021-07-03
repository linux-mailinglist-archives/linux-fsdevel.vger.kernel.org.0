Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3921D3BA73A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 06:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGCEhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 00:37:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26360 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhGCEhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 00:37:04 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1634WneG032265;
        Sat, 3 Jul 2021 04:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=pS0iXB2AfZFfxmJ72Phh9a9hcfNELweNb55uxdDJwnI=;
 b=mvGOceTdxbi/61rYsRCf21ZYYkwtvujltsnMtBhSQ25UIfFrpofn/FGJUu8pNy+a+Nx6
 gF/E7uYQ1+1kcpNVMnemjBl8HClIf+fx6xQxvyCGzAYqTXUjj7fIZY5ECIs/aEVNUEeO
 So90lW67DuBOnALqMs3cSImz+TTyW95t/MwSH83mVQkwA6gi2Ol/KyhX4P+lUvy9A2e5
 SE17y4KLEoh2CQTxrKyTlwTQShzItVaQctnF+aR5lO7dotDVlN9E1kFLqK12RzKQnX5N
 4DQU1ibCxRwEw3+o6OaHQtiWdIHKDScPVi39769LfJxIVFuyDbAmebQSdrnOnZGTWhml 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jfsc815k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 04:34:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1634UGUA150300;
        Sat, 3 Jul 2021 04:34:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39jf7k3v0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 04:34:28 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1634YQ5l156774;
        Sat, 3 Jul 2021 04:34:28 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 39jf7k3uyg-3;
        Sat, 03 Jul 2021 04:34:28 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Sat,  3 Jul 2021 00:34:20 -0400
Message-Id: <20210703043420.84549-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20210703043420.84549-1-dai.ngo@oracle.com>
References: <20210703043420.84549-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QX4_r8k4P_ApaWkt6cNKKMVuhDfeTz5F
X-Proofpoint-ORIG-GUID: QX4_r8k4P_ApaWkt6cNKKMVuhDfeTz5F
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently an NFSv4 client must maintain its lease by using the at least
one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
a singleton SEQUENCE (4.1) at least once during each lease period. If the
client fails to renew the lease, for any reason, the Linux server expunges
the state tokens immediately upon detection of the "failure to renew the
lease" condition and begins returning NFS4ERR_EXPIRED if the client should
reconnect and attempt to use the (now) expired state.

The default lease period for the Linux server is 90 seconds.  The typical
client cuts that in half and will issue a lease renewing operation every
45 seconds. The 90 second lease period is very short considering the
potential for moderately long term network partitions.  A network partition
refers to any loss of network connectivity between the NFS client and the
NFS server, regardless of its root cause.  This includes NIC failures, NIC
driver bugs, network misconfigurations & administrative errors, routers &
switches crashing and/or having software updates applied, even down to
cables being physically pulled.  In most cases, these network failures are
transient, although the duration is unknown.

A server which does not immediately expunge the state on lease expiration
is known as a Courteous Server.  A Courteous Server continues to recognize
previously generated state tokens as valid until conflict arises between
the expired state and the requests from another client, or the server
reboots.

The initial implementation of the Courteous Server will do the following:

. when the laundromat thread detects an expired client and if that client
still has established states on the Linux server and there is no waiters
for the client's locks then mark the client as a COURTESY_CLIENT and skip
destroying the client and all its states, otherwise destroy the client as
usual.

. detects conflict of OPEN request with a COURTESY_CLIENT, destroys the
expired client and all its states, skips the delegation recall then allows
the conflicting request to succeed.

. detects conflict of LOCK/LOCKT request with a COURTESY_CLIENT, destroys
the expired client and all its states then allows the conflicting request
to succeed.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c        | 172 +++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/state.h            |   3 +
 include/linux/sunrpc/svc.h |   1 +
 3 files changed, 170 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b517a8794400..ea137e91999f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -124,6 +124,11 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
+static struct workqueue_struct *laundry_wq;
+static void laundromat_main(struct work_struct *);
+
+static int courtesy_client_expiry = (24 * 60 * 60);	/* in secs */
+
 static bool is_session_dead(struct nfsd4_session *ses)
 {
 	return ses->se_flags & NFS4_SESSION_DEAD;
@@ -171,6 +176,7 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
+	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
 }
 
 static void put_client_renew_locked(struct nfs4_client *clp)
@@ -2371,6 +2377,10 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_puts(m, "status: confirmed\n");
 	else
 		seq_puts(m, "status: unconfirmed\n");
+	seq_printf(m, "courtesy client: %s\n",
+		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
+	seq_printf(m, "last renew: %lld secs\n",
+		ktime_get_boottime_seconds() - clp->cl_time);
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
@@ -3538,7 +3548,7 @@ static struct nfsd4_conn *__nfsd4_find_conn(struct svc_xprt *xpt, struct nfsd4_s
 }
 
 static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
-				struct nfsd4_session *session, u32 req)
+		struct nfsd4_session *session, u32 req, struct nfsd4_conn **conn)
 {
 	struct nfs4_client *clp = session->se_client;
 	struct svc_xprt *xpt = rqst->rq_xprt;
@@ -3561,6 +3571,8 @@ static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
 	else
 		status = nfserr_inval;
 	spin_unlock(&clp->cl_lock);
+	if (status == nfs_ok && conn)
+		*conn = c;
 	return status;
 }
 
@@ -3585,8 +3597,16 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(session->se_client, rqstp))
 		goto out;
-	status = nfsd4_match_existing_connection(rqstp, session, bcts->dir);
-	if (status == nfs_ok || status == nfserr_inval)
+	status = nfsd4_match_existing_connection(rqstp, session,
+			bcts->dir, &conn);
+	if (status == nfs_ok) {
+		if (bcts->dir == NFS4_CDFC4_FORE_OR_BOTH ||
+				bcts->dir == NFS4_CDFC4_BACK)
+			conn->cn_flags |= NFS4_CDFC4_BACK;
+		nfsd4_probe_callback(session->se_client);
+		goto out;
+	}
+	if (status == nfserr_inval)
 		goto out;
 	status = nfsd4_map_bcts_dir(&bcts->dir);
 	if (status)
@@ -4610,6 +4630,42 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	nfsd4_run_cb(&dp->dl_recall);
 }
 
+/*
+ * If the conflict happens due to a NFSv4 request then check for
+ * courtesy client and set rq_conflict_client so that upper layer
+ * can destroy the conflict client and retry the call.
+ */
+static bool
+nfsd_check_courtesy_client(struct nfs4_delegation *dp)
+{
+	struct svc_rqst *rqst;
+	struct nfs4_client *clp = dp->dl_recall.cb_clp;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	bool ret = false;
+
+	if (!i_am_nfsd()) {
+		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
+			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
+			mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+			return true;
+		}
+		return false;
+	}
+	rqst = kthread_data(current);
+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
+		return false;
+	rqst->rq_conflict_client = NULL;
+
+	spin_lock(&nn->client_lock);
+	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) &&
+				!mark_client_expired_locked(clp)) {
+		rqst->rq_conflict_client = clp;
+		ret = true;
+	}
+	spin_unlock(&nn->client_lock);
+	return ret;
+}
+
 /* Called from break_lease() with i_lock held. */
 static bool
 nfsd_break_deleg_cb(struct file_lock *fl)
@@ -4618,6 +4674,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
+	if (nfsd_check_courtesy_client(dp))
+		return false;
 	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
 
 	/*
@@ -5237,6 +5295,22 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 	 */
 }
 
+static bool
+nfs4_destroy_courtesy_client(struct nfs4_client *clp)
+{
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+
+	spin_lock(&nn->client_lock);
+	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ||
+			mark_client_expired_locked(clp)) {
+		spin_unlock(&nn->client_lock);
+		return false;
+	}
+	spin_unlock(&nn->client_lock);
+	expire_client(clp);
+	return true;
+}
+
 __be32
 nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open)
 {
@@ -5286,7 +5360,13 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 	} else {
+		rqstp->rq_conflict_client = NULL;
 		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		if (status == nfserr_jukebox && rqstp->rq_conflict_client) {
+			if (nfs4_destroy_courtesy_client(rqstp->rq_conflict_client))
+				status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		}
+
 		if (status) {
 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
@@ -5457,6 +5537,47 @@ static bool state_expired(struct laundry_time *lt, time64_t last_refresh)
 	return false;
 }
 
+static
+bool nfs4_anylock_conflict(struct nfs4_client *clp)
+{
+	int i;
+	struct nfs4_stateowner *so, *tmp;
+	struct nfs4_lockowner *lo;
+	struct nfs4_ol_stateid *stp;
+	struct nfs4_file *nf;
+	struct inode *ino;
+	struct file_lock_context *ctx;
+	struct file_lock *fl;
+
+	for (i = 0; i < OWNER_HASH_SIZE; i++) {
+		/* scan each lock owner */
+		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
+				so_strhash) {
+			if (so->so_is_open_owner)
+				continue;
+
+			/* scan lock states of this lock owner */
+			lo = lockowner(so);
+			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
+					st_perstateowner) {
+				nf = stp->st_stid.sc_file;
+				ino = nf->fi_inode;
+				ctx = ino->i_flctx;
+				if (!ctx)
+					continue;
+				/* check each lock belongs to this lock state */
+				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+					if (fl->fl_owner != lo)
+						continue;
+					if (!list_empty(&fl->fl_blocked_requests))
+						return true;
+				}
+			}
+		}
+	}
+	return false;
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5472,7 +5593,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 	};
 	struct nfs4_cpntf_state *cps;
 	copy_stateid_t *cps_t;
+	struct nfs4_stid *stid;
 	int i;
+	int id = 0;
 
 	if (clients_still_reclaiming(nn)) {
 		lt.new_timeo = 0;
@@ -5493,8 +5616,34 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
+			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
+			goto exp_client;
+		}
+		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
+			if (ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
+				goto exp_client;
+			/*
+			 * after umount, v4.0 client is still
+			 * around waiting to be expired
+			 */
+			if (clp->cl_minorversion)
+				continue;
+		}
 		if (!state_expired(&lt, clp->cl_time))
 			break;
+
+		spin_lock(&clp->cl_lock);
+		stid = idr_get_next(&clp->cl_stateids, &id);
+		spin_unlock(&clp->cl_lock);
+		if (stid && !nfs4_anylock_conflict(clp)) {
+			/* client still has states */
+			clp->courtesy_client_expiry =
+				ktime_get_boottime_seconds() + courtesy_client_expiry;
+			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
+			continue;
+		}
+exp_client:
 		if (mark_client_expired_locked(clp)) {
 			trace_nfsd_clid_expired(&clp->cl_clientid);
 			continue;
@@ -5572,9 +5721,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
 
-static struct workqueue_struct *laundry_wq;
-static void laundromat_main(struct work_struct *);
-
 static void
 laundromat_main(struct work_struct *laundry)
 {
@@ -6393,6 +6539,19 @@ nfs4_transform_lock_offset(struct file_lock *lock)
 		lock->fl_end = OFFSET_MAX;
 }
 
+/* return true if lock was expired else return false */
+static bool
+nfsd4_fl_expire_lock(struct file_lock *fl, bool testonly)
+{
+	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)fl->fl_owner;
+	struct nfs4_client *clp = lo->lo_owner.so_client;
+
+	if (testonly)
+		return test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ?
+			true : false;
+	return nfs4_destroy_courtesy_client(clp);
+}
+
 static fl_owner_t
 nfsd4_fl_get_owner(fl_owner_t owner)
 {
@@ -6438,6 +6597,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
 	.lm_get_owner = nfsd4_fl_get_owner,
 	.lm_put_owner = nfsd4_fl_put_owner,
+	.lm_expire_lock = nfsd4_fl_expire_lock,
 };
 
 static inline void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e73bdbb1634a..93e30b101578 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -345,6 +345,8 @@ struct nfs4_client {
 #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
 #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
 					 1 << NFSD4_CLIENT_CB_KILL)
+#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
+#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
 	unsigned long		cl_flags;
 	const struct cred	*cl_cb_cred;
 	struct rpc_clnt		*cl_cb_client;
@@ -385,6 +387,7 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+	int			courtesy_client_expiry;
 };
 
 /* struct nfs4_client_reset
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e91d51ea028b..2f0382f9d0ff 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -304,6 +304,7 @@ struct svc_rqst {
 						 * net namespace
 						 */
 	void **			rq_lease_breaker; /* The v4 client breaking a lease */
+	void			*rq_conflict_client;
 };
 
 #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
-- 
2.9.5

