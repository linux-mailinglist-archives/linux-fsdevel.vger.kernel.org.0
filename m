Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69F5166C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353467AbiEARlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 May 2022 13:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351040AbiEARlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 May 2022 13:41:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6930212748;
        Sun,  1 May 2022 10:38:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24196muR024988;
        Sun, 1 May 2022 17:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=KFA+orjsH92adk655Dito9nkXFAP5FkdrwNjUdDZk24=;
 b=t4FTNLlnHw0k3U/lVnUH7XpW4UVKxPmf8pbiPq3DWkH26dvQDYVg4eQ5OgOCTWuSjPeo
 WMZr7l3wdwonB75cL9HyUJiENyPfGQkdDdsHMZ3QJbIK/8aT+gfFgN543yKgKNd4dlIa
 rn933Pm3ilvm4+8J7zRMuQT2/XNa+3wGNTJYnypP21+uwwpZ3iWdu/YczKiI6l7yiki+
 twCTdu0RDG1hjXfJ7p0jL1KnHE/XVrMb+jwI4Z/56MIpeX2Emc+y1++/esZbDzPDcNVi
 IYLFFN7Lk3VnRsKAg9Z+cUHfLm0+IWsgpgYjrpTBQn9V0pvV+Nm+yr/ot1xkrjW/gaW5 Kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw29vha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 241HZNuT033501;
        Sun, 1 May 2022 17:38:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 241HauVb034841;
        Sun, 1 May 2022 17:38:20 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w5x-2;
        Sun, 01 May 2022 17:38:20 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v24 1/7] NFSD: add courteous server support for thread with only delegation
Date:   Sun,  1 May 2022 10:38:10 -0700
Message-Id: <1651426696-15509-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: y_syDCwuZ6xdAufngybecRiaWYxc2hRd
X-Proofpoint-ORIG-GUID: y_syDCwuZ6xdAufngybecRiaWYxc2hRd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch provides courteous server support for delegation only.
Only expired client with delegation but no conflict and no open
or lock state is allowed to be in COURTESY state.

Delegation conflict with COURTESY/EXPIRABLE client is resolved by
setting it to EXPIRABLE, queue work for the laundromat and return
delay to the caller. Conflict is resolved when the laudromat runs
and expires the EXIRABLE client while the NFS client retries the
OPEN request. Local thread request that gets conflict is doing the
retry in _break_lease.

Client in COURTESY or EXPIRABLE state is allowed to reconnect and
continues to have access to its state. Access to the nfs4_client by
the reconnecting thread and the laundromat is serialized via the
client_lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 83 +++++++++++++++++++++++++++++++++++++++++++----------
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/state.h     | 31 ++++++++++++++++++++
 3 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 234e852fcdfa..917eaab45999 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
+static struct workqueue_struct *laundry_wq;
+
 static bool is_session_dead(struct nfsd4_session *ses)
 {
 	return ses->se_flags & NFS4_SESSION_DEAD;
@@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 	if (is_client_expired(clp))
 		return nfserr_expired;
 	atomic_inc(&clp->cl_rpc_users);
+	clp->cl_state = NFSD4_ACTIVE;
 	return nfs_ok;
 }
 
@@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
+	clp->cl_state = NFSD4_ACTIVE;
 }
 
 static void put_client_renew_locked(struct nfs4_client *clp)
@@ -1090,6 +1094,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	get_clnt_odstate(odstate);
 	dp->dl_type = NFS4_OPEN_DELEGATE_READ;
 	dp->dl_retries = 1;
+	dp->dl_recalled = false;
 	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
 		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
 	get_nfs4_file(fp);
@@ -2004,6 +2009,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	idr_init(&clp->cl_stateids);
 	atomic_set(&clp->cl_rpc_users, 0);
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
+	clp->cl_state = NFSD4_ACTIVE;
+	atomic_set(&clp->cl_delegs_in_recall, 0);
 	INIT_LIST_HEAD(&clp->cl_idhash);
 	INIT_LIST_HEAD(&clp->cl_openowners);
 	INIT_LIST_HEAD(&clp->cl_delegations);
@@ -4694,9 +4701,18 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	bool ret = false;
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn;
 
 	trace_nfsd_cb_recall(&dp->dl_stid);
 
+	dp->dl_recalled = true;
+	atomic_inc(&clp->cl_delegs_in_recall);
+	if (try_to_expire_client(clp)) {
+		nn = net_generic(clp->net, nfsd_net_id);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+
 	/*
 	 * We don't want the locks code to timeout the lease for us;
 	 * we'll remove it ourself if a delegation isn't returned
@@ -4739,9 +4755,15 @@ static int
 nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 		     struct list_head *dispose)
 {
-	if (arg & F_UNLCK)
+	struct nfs4_delegation *dp = (struct nfs4_delegation *)onlist->fl_owner;
+	struct nfs4_client *clp = dp->dl_stid.sc_client;
+
+	if (arg & F_UNLCK) {
+		if (dp->dl_recalled &&
+			atomic_dec_return(&clp->cl_delegs_in_recall) == 0)
+			dp->dl_recalled = false;
 		return lease_modify(onlist, arg, dispose);
-	else
+	} else
 		return -EAGAIN;
 }
 
@@ -5605,6 +5627,49 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+/*
+ * place holder for now, no check for lock blockers yet
+ */
+static bool
+nfs4_anylock_blockers(struct nfs4_client *clp)
+{
+	if (atomic_read(&clp->cl_delegs_in_recall) ||
+			client_has_openowners(clp)  ||
+			!list_empty(&clp->async_copies))
+		return true;
+	return false;
+}
+
+static void
+nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
+				struct laundry_time *lt)
+{
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+
+	INIT_LIST_HEAD(reaplist);
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (clp->cl_state == NFSD4_EXPIRABLE)
+			goto exp_client;
+		if (!state_expired(lt, clp->cl_time))
+			break;
+		if (!atomic_read(&clp->cl_rpc_users))
+			clp->cl_state = NFSD4_COURTESY;
+		if (!client_has_state(clp) ||
+				ktime_get_boottime_seconds() >=
+				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
+			goto exp_client;
+		if (nfs4_anylock_blockers(clp)) {
+exp_client:
+			if (!mark_client_expired_locked(clp))
+				list_add(&clp->cl_lru, reaplist);
+		}
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5627,7 +5692,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 		goto out;
 	}
 	nfsd4_end_grace(nn);
-	INIT_LIST_HEAD(&reaplist);
 
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
@@ -5637,17 +5701,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 			_free_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
-
-	spin_lock(&nn->client_lock);
-	list_for_each_safe(pos, next, &nn->client_lru) {
-		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (!state_expired(&lt, clp->cl_time))
-			break;
-		if (mark_client_expired_locked(clp))
-			continue;
-		list_add(&clp->cl_lru, &reaplist);
-	}
-	spin_unlock(&nn->client_lock);
+	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	list_for_each_safe(pos, next, &reaplist) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
 		trace_nfsd_clid_purged(&clp->cl_clientid);
@@ -5722,7 +5776,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
 
-static struct workqueue_struct *laundry_wq;
 static void laundromat_main(struct work_struct *);
 
 static void
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4fc1fd639527..23996c6ca75e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
 #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 95457cfd37fc..f3d6313914ed 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -149,6 +149,7 @@ struct nfs4_delegation {
 /* For recall: */
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;
+	bool			dl_recalled;
 };
 
 #define cb_to_delegation(cb) \
@@ -283,6 +284,28 @@ struct nfsd4_sessionid {
 #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
 
 /*
+ *       State                Meaning                  Where set
+ * --------------------------------------------------------------------------
+ * | NFSD4_ACTIVE      | Confirmed, active    | Default                     |
+ * |------------------- ----------------------------------------------------|
+ * | NFSD4_COURTESY    | Courtesy state.      | nfs4_get_client_reaplist    |
+ * |                   | Lease/lock/share     |                             |
+ * |                   | reservation conflict |                             |
+ * |                   | can cause Courtesy   |                             |
+ * |                   | client to be expired |                             |
+ * |------------------------------------------------------------------------|
+ * | NFSD4_EXPIRABLE   | Courtesy client to be| nfs4_laundromat             |
+ * |                   | expired by Laundromat| try_to_expire_client        |
+ * |                   | due to conflict      |                             |
+ * |------------------------------------------------------------------------|
+ */
+enum {
+	NFSD4_ACTIVE = 0,
+	NFSD4_COURTESY,
+	NFSD4_EXPIRABLE,
+};
+
+/*
  * struct nfs4_client - one per client.  Clientids live here.
  *
  * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
@@ -385,6 +408,9 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	unsigned int		cl_state;
+	atomic_t		cl_delegs_in_recall;
 };
 
 /* struct nfs4_client_reset
@@ -702,4 +728,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+static inline bool try_to_expire_client(struct nfs4_client *clp)
+{
+	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
+	return clp->cl_state == NFSD4_EXPIRABLE;
+}
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

