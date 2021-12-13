Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD794732D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 18:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbhLMRYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 12:24:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235142AbhLMRYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:24:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDG0ecd018140;
        Mon, 13 Dec 2021 17:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=M/SeMWwXNc8JU3DbQzQ5ix4sle0OP1xAfZX/IfpXLmo=;
 b=Rjb5jEBjotNzZdHfAXGGN/Pe9V2rMYbpN8bq5V6lhvHrCzqbR+1LR8H6jVi2gzXmkYQC
 N+0inmFsqgzBjVWA2QdszvcqbymEVKNGkCHVdn31xS0GieeRVVzWBsEDDbKMAgFWJ1PR
 Vpz9vKNQC0nFQOVyXu3hmTY/Du9ErVEoOmKx0LFzzbGyYN1KeF624aDyu6AcKeTx3B1I
 bmJKmeTardGpFdXpWANcxTgn/iUg+FImh03+KmiHM/rqLX8XcVwPVNRnJxId8//Flyqd
 rRpxXGprkvVvPDmE1x9PN9b7upMef4JYyO9/tTQRgUx0jkJjtI5VdOIBeH/7P5ZGkvIf CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrs8ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 17:24:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDHF16Y130173;
        Mon, 13 Dec 2021 17:24:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3cvnendvum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 17:24:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BDHOQ0R168505;
        Mon, 13 Dec 2021 17:24:28 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 3cvnendvt7-3;
        Mon, 13 Dec 2021 17:24:28 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 2/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Mon, 13 Dec 2021 12:24:23 -0500
Message-Id: <20211213172423.49021-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20211213172423.49021-1-dai.ngo@oracle.com>
References: <20211213172423.49021-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1SWbda-_Z_g9LTVD-Tbctj5SnFK63a5a
X-Proofpoint-GUID: 1SWbda-_Z_g9LTVD-Tbctj5SnFK63a5a
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

. detects conflict of OPEN request with COURTESY_CLIENT, destroys the
expired client and all its states, skips the delegation recall then allows
the conflicting request to succeed.

. detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
requests with COURTESY_CLIENT, destroys the expired client and all its
states then allows the conflicting request to succeed.

. detects conflict of LOCK/LOCKT, NLM LOCK and TEST, and local locks
requests with COURTESY_CLIENT, destroys the expired client and all its
states then allows the conflicting request to succeed.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 274 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h     |   3 +
 2 files changed, 274 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3f4027a5de88..b1ff8d22534c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -125,6 +125,11 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
+static struct workqueue_struct *laundry_wq;
+static void laundromat_main(struct work_struct *);
+
+static const int courtesy_client_expiry = (24 * 60 * 60);	/* in secs */
+
 static bool is_session_dead(struct nfsd4_session *ses)
 {
 	return ses->se_flags & NFS4_SESSION_DEAD;
@@ -172,6 +177,7 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
+	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
 }
 
 static void put_client_renew_locked(struct nfs4_client *clp)
@@ -2389,6 +2395,10 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_puts(m, "status: confirmed\n");
 	else
 		seq_puts(m, "status: unconfirmed\n");
+	seq_printf(m, "courtesy client: %s\n",
+		test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ? "yes" : "no");
+	seq_printf(m, "seconds from last renew: %lld\n",
+		ktime_get_boottime_seconds() - clp->cl_time);
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
@@ -4662,6 +4672,33 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 	nfsd4_run_cb(&dp->dl_recall);
 }
 
+/*
+ * This function is called when a file is opened and there is a
+ * delegation conflict with another client. If the other client
+ * is a courtesy client then kick start the laundromat to destroy
+ * it.
+ */
+static bool
+nfsd_check_courtesy_client(struct nfs4_delegation *dp)
+{
+	struct svc_rqst *rqst;
+	struct nfs4_client *clp = dp->dl_recall.cb_clp;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+
+	if (!i_am_nfsd())
+		goto out;
+	rqst = kthread_data(current);
+	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
+		return false;
+out:
+	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
+		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+		return true;
+	}
+	return false;
+}
+
 /* Called from break_lease() with i_lock held. */
 static bool
 nfsd_break_deleg_cb(struct file_lock *fl)
@@ -4670,6 +4707,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
+	if (nfsd_check_courtesy_client(dp))
+		return false;
 	trace_nfsd_cb_recall(&dp->dl_stid);
 
 	/*
@@ -4912,6 +4951,118 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
 }
 
+static bool
+__nfs4_check_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
+			bool share_access)
+{
+	if (share_access) {
+		if (!stp->st_deny_bmap)
+			return false;
+
+		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
+			(access & NFS4_SHARE_ACCESS_READ &&
+				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
+			(access & NFS4_SHARE_ACCESS_WRITE &&
+				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
+			return true;
+		}
+		return false;
+	}
+	if ((access & NFS4_SHARE_DENY_BOTH) ||
+		(access & NFS4_SHARE_DENY_READ &&
+			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
+		(access & NFS4_SHARE_DENY_WRITE &&
+			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
+		return true;
+	}
+	return false;
+}
+
+/*
+ * access: if share_access is true then check access mode else check deny mode
+ */
+static bool
+nfs4_check_deny_bmap(struct nfs4_client *clp, struct nfs4_file *fp,
+		struct nfs4_ol_stateid *st, u32 access, bool share_access)
+{
+	int i;
+	struct nfs4_openowner *oo;
+	struct nfs4_stateowner *so, *tmp;
+	struct nfs4_ol_stateid *stp, *stmp;
+
+	spin_lock(&clp->cl_lock);
+	for (i = 0; i < OWNER_HASH_SIZE; i++) {
+		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
+					so_strhash) {
+			if (!so->so_is_open_owner)
+				continue;
+			oo = openowner(so);
+			list_for_each_entry_safe(stp, stmp,
+				&oo->oo_owner.so_stateids, st_perstateowner) {
+				if (stp == st || stp->st_stid.sc_file != fp)
+					continue;
+				if (__nfs4_check_deny_bmap(stp, access,
+							share_access)) {
+					spin_unlock(&clp->cl_lock);
+					return true;
+				}
+			}
+		}
+	}
+	spin_unlock(&clp->cl_lock);
+	return false;
+}
+
+/*
+ * Function to check if the nfserr_share_denied error for 'fp' resulted
+ * from conflict with courtesy clients then release their state to resolve
+ * the conflict.
+ *
+ * Function returns:
+ *	 0 -  no conflict with courtesy clients
+ *	>0 -  conflict with courtesy clients being resolved in background
+ *            return nfserr_jukebox to NFS client
+ */
+static int
+nfs4_destroy_clnts_with_sresv_conflict(struct svc_rqst *rqstp,
+			struct nfs4_file *fp, struct nfs4_ol_stateid *stp,
+			u32 access, bool share_access)
+{
+	int cnt = 0;
+	int async_cnt = 0;
+	bool no_retry = false;
+	struct nfs4_client *cl;
+	struct list_head *pos, *next;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		cl = list_entry(pos, struct nfs4_client, cl_lru);
+		/*
+		 * check all nfs4_ol_stateid of this client
+		 * for conflicts with 'access'mode.
+		 */
+		if (nfs4_check_deny_bmap(cl, fp, stp, access, share_access)) {
+			if (!test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
+				/* conflict with non-courtesy client */
+				no_retry = true;
+				cnt = 0;
+				goto out;
+			}
+			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
+			async_cnt++;
+		}
+	}
+out:
+	spin_unlock(&nn->client_lock);
+	if (async_cnt) {
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+		if (!no_retry)
+			cnt = async_cnt;
+	}
+	return cnt;
+}
+
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
 		struct nfsd4_open *open)
@@ -4921,6 +5072,7 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	int oflag = nfs4_access_to_omode(open->op_share_access);
 	int access = nfs4_access_to_access(open->op_share_access);
 	unsigned char old_access_bmap, old_deny_bmap;
+	int cnt = 0;
 
 	spin_lock(&fp->fi_lock);
 
@@ -4931,6 +5083,12 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status != nfs_ok) {
 		spin_unlock(&fp->fi_lock);
+		if (status != nfserr_share_denied)
+			goto out;
+		cnt = nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
+				stp, open->op_share_deny, false);
+		if (cnt > 0)
+			status = nfserr_jukebox;
 		goto out;
 	}
 
@@ -4938,6 +5096,12 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	status = nfs4_file_get_access(fp, open->op_share_access);
 	if (status != nfs_ok) {
 		spin_unlock(&fp->fi_lock);
+		if (status != nfserr_share_denied)
+			goto out;
+		cnt = nfs4_destroy_clnts_with_sresv_conflict(rqstp, fp,
+				stp, open->op_share_access, true);
+		if (cnt > 0)
+			status = nfserr_jukebox;
 		goto out;
 	}
 
@@ -5572,6 +5736,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
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
@@ -5587,7 +5792,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 	};
 	struct nfs4_cpntf_state *cps;
 	copy_stateid_t *cps_t;
+	struct nfs4_stid *stid;
 	int i;
+	int id;
 
 	if (clients_still_reclaiming(nn)) {
 		lt.new_timeo = 0;
@@ -5608,8 +5815,36 @@ nfs4_laundromat(struct nfsd_net *nn)
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
+			 * after umount, v4.0 client is still around
+			 * waiting to be expired. Check again and if
+			 * it has no state then expire it.
+			 */
+			if (clp->cl_minorversion)
+				continue;
+		}
 		if (!state_expired(&lt, clp->cl_time))
 			break;
+		id = 0;
+		spin_lock(&clp->cl_lock);
+		stid = idr_get_next(&clp->cl_stateids, &id);
+		if (stid && !nfs4_anylock_conflict(clp)) {
+			/* client still has states */
+			spin_unlock(&clp->cl_lock);
+			clp->courtesy_client_expiry =
+				ktime_get_boottime_seconds() + courtesy_client_expiry;
+			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
+			continue;
+		}
+		spin_unlock(&clp->cl_lock);
+exp_client:
 		if (mark_client_expired_locked(clp))
 			continue;
 		list_add(&clp->cl_lru, &reaplist);
@@ -5689,9 +5924,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
 
-static struct workqueue_struct *laundry_wq;
-static void laundromat_main(struct work_struct *);
-
 static void
 laundromat_main(struct work_struct *laundry)
 {
@@ -6496,6 +6728,41 @@ nfs4_transform_lock_offset(struct file_lock *lock)
 		lock->fl_end = OFFSET_MAX;
 }
 
+/*
+ * If testonly is true then check if the client owns the lock is a
+ * courtesy client. If it is then return that client else return NULL.
+ * If testonly is false then destroy the specified courtesy client.
+ */
+static void *
+nfsd4_fl_expire_lock(void *cfl, bool testonly)
+{
+	struct file_lock *fl;
+	struct nfs4_lockowner *lo;
+	struct nfs4_client *clp;
+	struct nfsd_net *nn;
+
+	if (testonly) {
+		fl = (struct file_lock *)cfl;
+		lo = (struct nfs4_lockowner *)fl->fl_owner;
+		clp = lo->lo_owner.so_client;
+		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags))
+			return clp;
+		return NULL;
+	}
+	clp = (struct nfs4_client *)cfl;
+
+	nn = net_generic(clp->net, nfsd_net_id);
+	spin_lock(&nn->client_lock);
+	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags) ||
+			mark_client_expired_locked(clp)) {
+		spin_unlock(&nn->client_lock);
+		return NULL;
+	}
+	spin_unlock(&nn->client_lock);
+	expire_client(clp);
+	return clp;
+}
+
 static fl_owner_t
 nfsd4_fl_get_owner(fl_owner_t owner)
 {
@@ -6543,6 +6810,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
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
-- 
2.9.5

