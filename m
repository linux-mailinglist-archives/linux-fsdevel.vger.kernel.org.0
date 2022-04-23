Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA42F50CD00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiDWSrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiDWSrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:47:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F461A1766;
        Sat, 23 Apr 2022 11:44:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23NH4T59017776;
        Sat, 23 Apr 2022 18:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=8BgXC2AYci+jFP+j1heOfC/h+ASWPUJ5vkN3Z5re8Lc=;
 b=r9crMx+sy035AG4V26Elh5jjMHbBI5+bF7j2hYw2WLhS14EAJZHFIpBYYEqqte8Aal7b
 QLKUyqe6H2c/vx/+5sEvcTopCuqLfWBZYeLwG5OajF3GMfkst2AjCjxdtfyCvZgwiJqp
 hiFpnDhL2fLc/PH2DIobogmPMfVYljEjwaPZ+X1kBvCtZcYMrWRTbhLbaL/h4SETJNe0
 bAiOGjt7k1Ezm9x3eqzYcyNvt6rI8yjtUAXYNTZI4RssYVBFTwj9eyjheY2xETRwNgcz
 LQbldYSCOldet2472yXo6xdZaN1QcXPEpGzBkLGPfzu/mXYWExEui3yIC4DFme/DMRNS Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4gn0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23NIb0uZ010514;
        Sat, 23 Apr 2022 18:44:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14shc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23NIgigm016659;
        Sat, 23 Apr 2022 18:44:18 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14sh1-2;
        Sat, 23 Apr 2022 18:44:18 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v21 1/7] NFSD: add courteous server support for thread with only delegation
Date:   Sat, 23 Apr 2022 11:44:09 -0700
Message-Id: <1650739455-26096-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: GTQnhvUBlfVTvhPGTE090FPKjU1h1iLr
X-Proofpoint-GUID: GTQnhvUBlfVTvhPGTE090FPKjU1h1iLr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch provides courteous server support for delegation only.
Only expired client with delegation but no conflict and no open
or lock state is allowed to be in COURTESY state.

Delegation conflict with COURTESY client is resolved by setting it
to EXPIRABLE, queue work for the laundromat and return delay to
caller. Conflict is resolved when the laudromat runs and expires
the EXIRABLE client while the NFS client retries the OPEN request.
Local thread request that gets conflict is doing the retry in
__break_lease.

Client in COURTESY state is allowed to reconnect and continues to
have access to its state while client in EXPIRABLE state is not.
To prevent 2 clients with the same name are on the conf_name_tree,
nfsd4_setclientid is modified to expire confirmed client in EXPIRABLE
state.

The spinlock cl_cs_lock is used to handle race conditions between
conflict resolver, nfsd_break_deleg_cb, and the COURTESY client
doing reconnect.

find_in_sessionid_hashtbl, find_confirmed_client_by_name and
find_confirmed_client are modified to activate COURTESY client by
setting it to ACTIVE state and skip client in EXPIRABLE state.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfsd.h      |   1 +
 fs/nfsd/state.h     |  63 +++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 234e852fcdfa..fea5e24e7d94 100644
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
@@ -690,6 +692,14 @@ static unsigned int file_hashval(struct svc_fh *fh)
 
 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
 
+static inline void
+run_laundromat(struct nfsd_net *nn, bool wait)
+{
+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	if (wait)
+		flush_workqueue(laundry_wq);
+}
+
 static void
 __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 {
@@ -1939,6 +1949,11 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 	session = __find_in_sessionid_hashtbl(sessionid, net);
 	if (!session)
 		goto out;
+	if (!try_to_activate_client(session->se_client)) {
+		/* client is EXPIRABLE */
+		session = NULL;
+		goto out;
+	}
 	status = nfsd4_get_session_locked(session);
 	if (status)
 		session = NULL;
@@ -2004,6 +2019,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	idr_init(&clp->cl_stateids);
 	atomic_set(&clp->cl_rpc_users, 0);
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
+	clp->cl_state = NFSD4_ACTIVE;
 	INIT_LIST_HEAD(&clp->cl_idhash);
 	INIT_LIST_HEAD(&clp->cl_openowners);
 	INIT_LIST_HEAD(&clp->cl_delegations);
@@ -2015,6 +2031,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
 	spin_lock_init(&clp->cl_lock);
+	spin_lock_init(&clp->cl_cs_lock);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
 err_no_hashtbl:
@@ -2890,9 +2907,13 @@ static struct nfs4_client *
 find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
 {
 	struct list_head *tbl = nn->conf_id_hashtbl;
+	struct nfs4_client *clp;
 
 	lockdep_assert_held(&nn->client_lock);
-	return find_client_in_id_table(tbl, clid, sessions);
+	clp = find_client_in_id_table(tbl, clid, sessions);
+	if (clp && !try_to_activate_client(clp))
+		clp = NULL;
+	return clp;
 }
 
 static struct nfs4_client *
@@ -2912,8 +2933,13 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
 static struct nfs4_client *
 find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
 {
+	struct nfs4_client *clp;
+
 	lockdep_assert_held(&nn->client_lock);
-	return find_clp_in_name_tree(name, &nn->conf_name_tree);
+	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
+	if (clp && !try_to_activate_client(clp))
+		clp = NULL;
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4030,12 +4056,25 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client	*unconf = NULL;
 	__be32 			status;
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfs4_client *expired = NULL;
 
 	new = create_client(clname, rqstp, &clverifier);
 	if (new == NULL)
 		return nfserr_jukebox;
 	spin_lock(&nn->client_lock);
-	conf = find_confirmed_client_by_name(&clname, nn);
+	conf = find_clp_in_name_tree(&clname, &nn->conf_name_tree);
+	if (conf) {
+		if (!try_to_activate_client(conf)) {
+			/*
+			 * remove EXPIRABLE client from conf_name_tree so
+			 * when the new client is confirmed there won't be
+			 * 2 clients with the same name on the conf_name_tree.
+			 */
+			if (!mark_client_expired_locked(conf))
+				expired = conf;
+			conf = NULL;
+		}
+	}
 	if (conf && client_has_state(conf)) {
 		status = nfserr_clid_inuse;
 		if (clp_used_exchangeid(conf))
@@ -4073,6 +4112,8 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		trace_nfsd_clid_expire_unconf(&unconf->cl_clientid);
 		expire_client(unconf);
 	}
+	if (expired)
+		expire_client(expired);
 	return status;
 }
 
@@ -4694,9 +4735,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	bool ret = false;
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn;
 
 	trace_nfsd_cb_recall(&dp->dl_stid);
 
+	if (try_to_expire_client(clp)) {
+		nn = net_generic(clp->net, nfsd_net_id);
+		run_laundromat(nn, false);
+	}
+
 	/*
 	 * We don't want the locks code to timeout the lease for us;
 	 * we'll remove it ourself if a delegation isn't returned
@@ -5605,6 +5653,64 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+/*
+ * place holder for now, no check for lock blockers yet
+ */
+static bool
+nfs4_anylock_blockers(struct nfs4_client *clp)
+{
+	/*
+	 * don't want to check for delegation conflict here since
+	 * we need the state_lock for it. The laundromat willexpire
+	 * COURTESY later when checking for delegation recall timeout.
+	 */
+	return false;
+}
+
+static bool client_has_state_tmp(struct nfs4_client *clp)
+{
+	if (!list_empty(&clp->cl_delegations) &&
+			!client_has_openowners(clp) &&
+			list_empty(&clp->async_copies))
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
+	bool cour;
+
+	INIT_LIST_HEAD(reaplist);
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (clp->cl_state == NFSD4_EXPIRABLE)
+			goto exp_client;
+		if (!state_expired(lt, clp->cl_time))
+			break;
+		if (!client_has_state_tmp(clp))
+			goto exp_client;
+		cour = (clp->cl_state == NFSD4_COURTESY);
+		if (cour && ktime_get_boottime_seconds() >=
+				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
+			goto exp_client;
+		if (nfs4_anylock_blockers(clp)) {
+exp_client:
+			if (mark_client_expired_locked(clp))
+				continue;
+			list_add(&clp->cl_lru, reaplist);
+			continue;
+		}
+		if (!cour)
+			cmpxchg(&clp->cl_state, NFSD4_ACTIVE, NFSD4_COURTESY);
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5627,7 +5733,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 		goto out;
 	}
 	nfsd4_end_grace(nn);
-	INIT_LIST_HEAD(&reaplist);
 
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
@@ -5637,17 +5742,7 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -5657,6 +5752,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
+
+		clp = dp->dl_stid.sc_client;
+		try_to_expire_client(dp->dl_stid.sc_client);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
 		WARN_ON(!unhash_delegation_locked(dp));
@@ -5722,7 +5820,6 @@ nfs4_laundromat(struct nfsd_net *nn)
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
index 95457cfd37fc..b7d243073c58 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -283,6 +283,28 @@ struct nfsd4_sessionid {
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
@@ -385,6 +407,9 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	spinlock_t		cl_cs_lock;
+	unsigned int		cl_state;
 };
 
 /* struct nfs4_client_reset
@@ -702,4 +727,42 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+static inline bool try_to_expire_client(struct nfs4_client *clp)
+{
+	bool ret;
+
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_state == NFSD4_EXPIRABLE) {
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	ret = NFSD4_COURTESY ==
+		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
+	spin_unlock(&clp->cl_cs_lock);
+	return ret;
+}
+
+static inline bool try_to_activate_client(struct nfs4_client *clp)
+{
+	bool ret;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+
+	/* sync with laundromat */
+	lockdep_assert_held(&nn->client_lock);
+
+	/* sync with try_to_expire_client */
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_state == NFSD4_ACTIVE) {
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	if (clp->cl_state == NFSD4_EXPIRABLE) {
+		spin_unlock(&clp->cl_cs_lock);
+		return false;
+	}
+	ret = NFSD4_COURTESY ==
+		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_ACTIVE);
+	spin_unlock(&clp->cl_cs_lock);
+	return ret;
+}
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

