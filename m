Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC66B512C59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 09:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbiD1HK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbiD1HKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:10:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCD599687;
        Thu, 28 Apr 2022 00:06:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S5tHJY032179;
        Thu, 28 Apr 2022 07:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=CSeEoz9+qZj8yVJ+6r2eMH4p5mlw9+CMfO57qMfxgtk=;
 b=anGhXlGkIvIDhyBjTr+TZiCW9bxZuq6mbmhGnK9VHF4mScZSRD3MMyBisNbVfaa9CnUm
 wJ1JiL/FEHvgc3D0L+nNduZqxZDglfyMJAnjWEVrep/fITgg2obV8v8nRiyZKMeu8i4m
 dXxSYcs8SuwFGXGWiQNKiBDwoiFwujvBFKlIa/hnY9Bv5Ql9Q/kqTpCyesfT9NuuEfBS
 TXZSpitwV3epPd3FD4jL3QtjGEKvx1cKwfFRpeZxULArkcPEh28Uk0vuT5b1szuJozkm
 5hd3JgEwommrlN0Ox4kf2yT4XovoOerHQFr7YnVCRtT7bJ3CfN2LruEt3l9yeWt9nRB6 dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb102ngf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S70COu019517;
        Thu, 28 Apr 2022 07:06:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23S76cAc007862;
        Thu, 28 Apr 2022 07:06:39 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634qj-2;
        Thu, 28 Apr 2022 07:06:39 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v23 1/7] NFSD: add courteous server support for thread with only delegation
Date:   Thu, 28 Apr 2022 00:06:29 -0700
Message-Id: <1651129595-6904-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: z4qTx-du29zkIlvC__8_hlC-FzMFjR2H
X-Proofpoint-GUID: z4qTx-du29zkIlvC__8_hlC-FzMFjR2H
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
 fs/nfsd/nfs4state.c | 79 ++++++++++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/state.h     | 29 ++++++++++++++++++++
 3 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 234e852fcdfa..b84ba19c856b 100644
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
@@ -2004,6 +2008,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	idr_init(&clp->cl_stateids);
 	atomic_set(&clp->cl_rpc_users, 0);
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
+	clp->cl_state = NFSD4_ACTIVE;
 	INIT_LIST_HEAD(&clp->cl_idhash);
 	INIT_LIST_HEAD(&clp->cl_openowners);
 	INIT_LIST_HEAD(&clp->cl_delegations);
@@ -4694,9 +4699,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	bool ret = false;
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
+	struct nfs4_client *clp = dp->dl_stid.sc_client;
+	struct nfsd_net *nn;
 
 	trace_nfsd_cb_recall(&dp->dl_stid);
 
+	if (try_to_expire_client(clp)) {
+		nn = net_generic(clp->net, nfsd_net_id);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+
 	/*
 	 * We don't want the locks code to timeout the lease for us;
 	 * we'll remove it ourself if a delegation isn't returned
@@ -5605,6 +5617,58 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
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
+
+	INIT_LIST_HEAD(reaplist);
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (clp->cl_state == NFSD4_EXPIRABLE)
+			goto exp_client;
+		if (!state_expired(lt, clp->cl_time))
+			break;
+		clp->cl_state = NFSD4_COURTESY;
+		if (!client_has_state_tmp(clp) ||
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
@@ -5627,7 +5691,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 		goto out;
 	}
 	nfsd4_end_grace(nn);
-	INIT_LIST_HEAD(&reaplist);
 
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
@@ -5637,17 +5700,7 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -5657,6 +5710,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
+		try_to_expire_client(dp->dl_stid.sc_client);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
 		WARN_ON(!unhash_delegation_locked(dp));
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
index 95457cfd37fc..bd15f2863823 100644
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
@@ -385,6 +407,8 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	unsigned int		cl_state;
 };
 
 /* struct nfs4_client_reset
@@ -702,4 +726,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
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

