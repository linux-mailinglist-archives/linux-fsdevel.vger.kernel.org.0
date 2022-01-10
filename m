Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E97489F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 19:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbiAJSkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 13:40:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49184 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238734AbiAJSkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:40:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AHfj0I021897;
        Mon, 10 Jan 2022 18:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=XuMi8XupsjnJRvxdpfBplP2l5oDohx4u2Ub1t5IoEu4=;
 b=evRSTtQSIt0rZiUi2wPsZ1xD4L5z5V1QzGLEpRvoteyWF0AlVIiybDc0CH1B3lJJ6RzM
 ET+PpCUE/ofaWqESQEI8bFOoHrUqo/wPdiTkb9AzvbsqUHbzNlK37I5Ol1LcdWeqLUBh
 /+8r/fmhhn8DAJiB+xNKJy1lN5eE9fJS3Q2oVFwLG48jJadENBBufNuoSQ8dMA16nxfa
 QOJ9cT3T4pMpcIf3/XxXVYJMMlXXjFlZYNahJ6zzus9XHJnRZlfy8WUdcbsy88QRAJgZ
 P+WSAxSQAOyIajJifuMrc3IARwywO949Wnnh/pHFoCg+Ek4ucivhyS1fpTTRwhfH19Km 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx15e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 18:40:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AIePUr063693;
        Mon, 10 Jan 2022 18:40:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3df0ncxje4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 18:40:39 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20AIebx3064436;
        Mon, 10 Jan 2022 18:40:39 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3df0ncxjcd-3;
        Mon, 10 Jan 2022 18:40:39 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk, linux-nfs@vger.kernel,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v9 2/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Mon, 10 Jan 2022 10:40:29 -0800
Message-Id: <1641840029-20972-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641840029-20972-1-git-send-email-dai.ngo@oracle.com>
References: <1641840029-20972-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: B-hDplvtuRovHWKkOn9ebNnWYn8RseLy
X-Proofpoint-ORIG-GUID: B-hDplvtuRovHWKkOn9ebNnWYn8RseLy
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
 fs/nfsd/nfs4state.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/state.h     |   8 ++
 2 files changed, 323 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3f4027a5de88..e7fa4da44835 100644
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
@@ -155,8 +160,10 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 	return nfs_ok;
 }
 
-/* must be called under the client_lock */
+/* must be called under the client_lock
 static inline void
+*/
+void
 renew_client_locked(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
@@ -172,7 +179,9 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
+	clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
 }
+EXPORT_SYMBOL_GPL(renew_client_locked);
 
 static void put_client_renew_locked(struct nfs4_client *clp)
 {
@@ -1912,10 +1921,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 {
 	struct nfsd4_session *session;
 	__be32 status = nfserr_badsession;
+	struct nfs4_client *clp;
 
 	session = __find_in_sessionid_hashtbl(sessionid, net);
 	if (!session)
 		goto out;
+	clp = session->se_client;
+	if (clp) {
+		spin_lock(&clp->cl_cs_lock);
+		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags)) {
+			spin_unlock(&clp->cl_cs_lock);
+			session = NULL;
+			goto out;
+		}
+		clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
+		spin_unlock(&clp->cl_cs_lock);
+	}
 	status = nfsd4_get_session_locked(session);
 	if (status)
 		session = NULL;
@@ -1992,6 +2013,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
 	spin_lock_init(&clp->cl_lock);
+	spin_lock_init(&clp->cl_cs_lock);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
 err_no_hashtbl:
@@ -2389,6 +2411,10 @@ static int client_info_show(struct seq_file *m, void *v)
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
@@ -2809,8 +2835,17 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
 			node = node->rb_left;
 		else if (cmp < 0)
 			node = node->rb_right;
-		else
-			return clp;
+		else {
+			spin_lock(&clp->cl_cs_lock);
+			if (!test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
+					&clp->cl_flags)) {
+				clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
+				spin_unlock(&clp->cl_cs_lock);
+				return clp;
+			}
+			spin_unlock(&clp->cl_cs_lock);
+			return NULL;
+		}
 	}
 	return NULL;
 }
@@ -2856,6 +2891,14 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 		if (same_clid(&clp->cl_clientid, clid)) {
 			if ((bool)clp->cl_minorversion != sessions)
 				return NULL;
+			spin_lock(&clp->cl_cs_lock);
+			if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT,
+					&clp->cl_flags)) {
+				spin_unlock(&clp->cl_cs_lock);
+				continue;
+			}
+			clear_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
+			spin_unlock(&clp->cl_cs_lock);
 			renew_client_locked(clp);
 			return clp;
 		}
@@ -4662,6 +4705,36 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
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
+	spin_lock(&clp->cl_cs_lock);
+	if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
+		set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
+		spin_unlock(&clp->cl_cs_lock);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+		return true;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+	return false;
+}
+
 /* Called from break_lease() with i_lock held. */
 static bool
 nfsd_break_deleg_cb(struct file_lock *fl)
@@ -4670,6 +4743,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
+	if (nfsd_check_courtesy_client(dp))
+		return false;
 	trace_nfsd_cb_recall(&dp->dl_stid);
 
 	/*
@@ -4912,7 +4987,128 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
 }
 
-static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
+static bool
+__nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
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
+ * Check all files belong to the specified client to determine if there is
+ * any conflict with the specified access_mode/deny_mode of the file 'fp.
+ *
+ * If share_access is true then 'access' is the access mode. Check if
+ * this access mode conflicts with current deny mode of the file.
+ *
+ * If share_access is false then 'access' the deny mode. Check if
+ * this deny mode conflicts with current access mode of the file.
+ */
+static bool
+nfs4_check_access_deny_bmap(struct nfs4_client *clp, struct nfs4_file *fp,
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
+				if (__nfs4_check_access_deny_bmap(stp, access,
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
+ * This function is called to check whether nfserr_share_denied should
+ * be returning to client.
+ *
+ * access: is op_share_access if share_access is true.
+ *	   Check if access mode, op_share_access, would conflict with
+ *	   the current deny mode of the file 'fp'.
+ * access: is op_share_deny if share_access is true.
+ *	   Check if the deny mode, op_share_deny, would conflict with
+ *	   current access of the file 'fp'.
+ * stp:    skip checking this entry.
+ *
+ * Function returns:
+ *	true  - access/deny mode conflict with courtesy client(s).
+ *		Caller to return nfserr_jukebox while client(s) being expired.
+ *	false - access/deny mode conflict with non-courtesy client.
+ *		Caller to return nfserr_share_denied to client.
+ */
+static bool
+nfs4_conflict_courtesy_clients(struct svc_rqst *rqstp, struct nfs4_file *fp,
+		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
+{
+	struct nfs4_client *cl;
+	bool conflict = false;
+	int async_cnt = 0;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+
+	spin_lock(&nn->client_lock);
+	list_for_each_entry(cl, &nn->client_lru, cl_lru) {
+		if (!nfs4_check_access_deny_bmap(cl, fp, stp, access, share_access))
+			continue;
+		spin_lock(&cl->cl_cs_lock);
+		if (test_bit(NFSD4_COURTESY_CLIENT, &cl->cl_flags)) {
+			set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &cl->cl_flags);
+			async_cnt++;
+			spin_unlock(&cl->cl_cs_lock);
+			continue;
+		}
+		/* conflict with non-courtesy client */
+		spin_unlock(&cl->cl_cs_lock);
+		conflict = false;
+		break;
+	}
+	spin_unlock(&nn->client_lock);
+	if (async_cnt) {
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+		conflict = true;
+	}
+	return conflict;
+}
+
+static __be32
+nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
 		struct nfsd4_open *open)
 {
@@ -4931,6 +5127,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status != nfs_ok) {
 		spin_unlock(&fp->fi_lock);
+		if (status != nfserr_share_denied)
+			goto out;
+		if (nfs4_conflict_courtesy_clients(rqstp, fp,
+				stp, open->op_share_deny, false))
+			status = nfserr_jukebox;
 		goto out;
 	}
 
@@ -4938,6 +5139,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	status = nfs4_file_get_access(fp, open->op_share_access);
 	if (status != nfs_ok) {
 		spin_unlock(&fp->fi_lock);
+		if (status != nfserr_share_denied)
+			goto out;
+		if (nfs4_conflict_courtesy_clients(rqstp, fp,
+				stp, open->op_share_access, true))
+			status = nfserr_jukebox;
 		goto out;
 	}
 
@@ -5572,6 +5778,47 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
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
@@ -5587,7 +5834,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 	};
 	struct nfs4_cpntf_state *cps;
 	copy_stateid_t *cps_t;
+	struct nfs4_stid *stid;
 	int i;
+	int id;
 
 	if (clients_still_reclaiming(nn)) {
 		lt.new_timeo = 0;
@@ -5608,8 +5857,41 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (!state_expired(&lt, clp->cl_time))
+		spin_lock(&clp->cl_cs_lock);
+		if (test_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags))
+			goto exp_client;
+		if (test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
+			if (ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
+				goto exp_client;
+			/*
+			 * after umount, v4.0 client is still around
+			 * waiting to be expired. Check again and if
+			 * it has no state then expire it.
+			 */
+			if (clp->cl_minorversion) {
+				spin_unlock(&clp->cl_cs_lock);
+				continue;
+			}
+		}
+		if (!state_expired(&lt, clp->cl_time)) {
+			spin_unlock(&clp->cl_cs_lock);
 			break;
+		}
+		id = 0;
+		spin_lock(&clp->cl_lock);
+		stid = idr_get_next(&clp->cl_stateids, &id);
+		if (stid && !nfs4_anylock_conflict(clp)) {
+			/* client still has states */
+			spin_unlock(&clp->cl_lock);
+			clp->courtesy_client_expiry =
+				ktime_get_boottime_seconds() + courtesy_client_expiry;
+			set_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags);
+			spin_unlock(&clp->cl_cs_lock);
+			continue;
+		}
+		spin_unlock(&clp->cl_lock);
+exp_client:
+		spin_unlock(&clp->cl_cs_lock);
 		if (mark_client_expired_locked(clp))
 			continue;
 		list_add(&clp->cl_lru, &reaplist);
@@ -5689,9 +5971,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
 
-static struct workqueue_struct *laundry_wq;
-static void laundromat_main(struct work_struct *);
-
 static void
 laundromat_main(struct work_struct *laundry)
 {
@@ -6496,6 +6775,33 @@ nfs4_transform_lock_offset(struct file_lock *lock)
 		lock->fl_end = OFFSET_MAX;
 }
 
+/*
+ * Return true if lock can be resolved by expiring
+ * courtesy client else return false.
+ */
+static bool
+nfsd4_fl_expire_lock(struct file_lock *fl)
+{
+	struct nfs4_lockowner *lo;
+	struct nfs4_client *clp;
+	struct nfsd_net *nn;
+
+	if (!fl)
+		return false;
+	lo = (struct nfs4_lockowner *)fl->fl_owner;
+	clp = lo->lo_owner.so_client;
+	spin_lock(&clp->cl_cs_lock);
+	if (!test_bit(NFSD4_COURTESY_CLIENT, &clp->cl_flags)) {
+		spin_unlock(&clp->cl_cs_lock);
+		return false;
+	}
+	nn = net_generic(clp->net, nfsd_net_id);
+	set_bit(NFSD4_DESTROY_COURTESY_CLIENT, &clp->cl_flags);
+	spin_unlock(&clp->cl_cs_lock);
+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	return true;
+}
+
 static fl_owner_t
 nfsd4_fl_get_owner(fl_owner_t owner)
 {
@@ -6543,6 +6849,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
 	.lm_get_owner = nfsd4_fl_get_owner,
 	.lm_put_owner = nfsd4_fl_put_owner,
+	.lm_expire_lock = nfsd4_fl_expire_lock,
 };
 
 static inline void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e73bdbb1634a..7f52a79e0743 100644
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
@@ -385,6 +387,12 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+	int			courtesy_client_expiry;
+	/*
+	 * used to synchronize access to NFSD4_COURTESY_CLIENT
+	 * and NFSD4_DESTROY_COURTESY_CLIENT for race conditions.
+	 */
+	spinlock_t		cl_cs_lock;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

