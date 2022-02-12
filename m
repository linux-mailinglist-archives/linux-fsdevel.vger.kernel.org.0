Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB97A4B3701
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiBLSNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Feb 2022 13:13:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiBLSNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:13:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6F50B2F;
        Sat, 12 Feb 2022 10:13:03 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21C9Qgl3028571;
        Sat, 12 Feb 2022 18:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=qfHQKjLZV9DuyfqCU1qxWBTMlnIE/gpSZTs6cu52b+o=;
 b=Ueq9Z33Bcfblb2peZiSZ2H/KBoAMrB0KPOAVH/ACTEVotqhzqd13PCQFKFHptKbpzQrh
 FCZlJtsuy/TOD7r69ZT5zyd+hEUaUcuM8bLYvE1UlCx4O+D16f1+h93pipoFIrZrAmiS
 kXmngGYA6M1+kBRopN/5cCFziHqeSNibp6PvLvrZwSCEXUOS9uADpj44oqVNQ17voEYG
 AlfIXHUFkiM2Hut+J63O3cUy+th9jVJd/mmwAAkSE+1j7AUtA5UqByZsDuTGaFsibFEI
 e5DZrqvR/5axfOKYHDaEqRgrXKW4ji4YveMj5lLEL+YgIcahvctMzRDZSP9M5GQ4TNlU 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g110xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Feb 2022 18:13:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21CIBqAb120414;
        Sat, 12 Feb 2022 18:12:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e66bj2f5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Feb 2022 18:12:59 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21CICvs3121470;
        Sat, 12 Feb 2022 18:12:59 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by userp3020.oracle.com with ESMTP id 3e66bj2f4u-5;
        Sat, 12 Feb 2022 18:12:58 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Sat, 12 Feb 2022 10:12:55 -0800
Message-Id: <1644689575-1235-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: N-AaPc3yNFS2obHLBUiu27_TSIr39A1u
X-Proofpoint-ORIG-GUID: N-AaPc3yNFS2obHLBUiu27_TSIr39A1u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Problems such as hardware failures or administrative errors may cause
network partitions longer than the NFSv4 lease period. Our server currently
removes all client state as soon as a client fails to renew.

A server which does not immediately expunge the state on lease expiration
is known as a Courteous Server.  A Courteous Server continues to recognize
previously generated state tokens as valid until conflict arises between
the expired state and the requests from another client, or the server
reboots.

The initial implementation of the Courteous Server will do the following:

. When the laundromat thread detects an expired client and if that client
still has established state on the Linux server and there is no waiters
for the client's locks then deletes the client persistent record and marks
the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
all of its state, otherwise destroys the client as usual.

. Client persistent record is added to the client database when the
courtesy client reconnects and transits to normal client.

. Lock/delegation/share reversation conflict with courtesy client is
resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY,
effectively disable it, then allow the current request to proceed
immediately.

. Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed to
reconnect to reuse itsstate. It is expired by the laundromat asynchronously
in the background.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 440 +++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfsd.h      |   1 +
 fs/nfsd/state.h     |   6 +
 3 files changed, 424 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 32063733443d..b837ff97e097 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1935,10 +1935,33 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 {
 	struct nfsd4_session *session;
 	__be32 status = nfserr_badsession;
+	struct nfs4_client *clp;
 
 	session = __find_in_sessionid_hashtbl(sessionid, net);
 	if (!session)
 		goto out;
+	clp = session->se_client;
+	if (clp) {
+		clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
+		/* need to sync with thread resolving lock/deleg conflict */
+		spin_lock(&clp->cl_cs_lock);
+		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
+			spin_unlock(&clp->cl_cs_lock);
+			session = NULL;
+			goto out;
+		}
+		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+			/*
+			 * clear CLIENT_COURTESY flag to prevent it from being
+			 * destroyed by thread trying to resolve conflicts.
+			 */
+			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+
+			/* let caller knows it's courtesy client */
+			set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
+		}
+		spin_unlock(&clp->cl_cs_lock);
+	}
 	status = nfsd4_get_session_locked(session);
 	if (status)
 		session = NULL;
@@ -2008,6 +2031,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	INIT_LIST_HEAD(&clp->cl_openowners);
 	INIT_LIST_HEAD(&clp->cl_delegations);
 	INIT_LIST_HEAD(&clp->cl_lru);
+	INIT_LIST_HEAD(&clp->cl_cs_list);
 	INIT_LIST_HEAD(&clp->cl_revoked);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
@@ -2015,6 +2039,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
 	spin_lock_init(&clp->cl_lock);
+	spin_lock_init(&clp->cl_cs_lock);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
 err_no_hashtbl:
@@ -2412,6 +2437,10 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_puts(m, "status: confirmed\n");
 	else
 		seq_puts(m, "status: unconfirmed\n");
+	seq_printf(m, "courtesy client: %s\n",
+		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
+	seq_printf(m, "seconds from last renew: %lld\n",
+		ktime_get_boottime_seconds() - clp->cl_time);
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
@@ -2832,8 +2861,22 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
 			node = node->rb_left;
 		else if (cmp < 0)
 			node = node->rb_right;
-		else
+		else {
+			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
+			/* sync with thread resolving lock/deleg conflict */
+			spin_lock(&clp->cl_cs_lock);
+			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
+					&clp->cl_flags)) {
+				spin_unlock(&clp->cl_cs_lock);
+				return NULL;
+			}
+			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
+			}
+			spin_unlock(&clp->cl_cs_lock);
 			return clp;
+		}
 	}
 	return NULL;
 }
@@ -2879,6 +2922,20 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 		if (same_clid(&clp->cl_clientid, clid)) {
 			if ((bool)clp->cl_minorversion != sessions)
 				return NULL;
+
+			/* need to sync with thread resolving lock/deleg conflict */
+			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
+			spin_lock(&clp->cl_cs_lock);
+			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
+					&clp->cl_flags)) {
+				spin_unlock(&clp->cl_cs_lock);
+				continue;
+			}
+			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
+			}
+			spin_unlock(&clp->cl_cs_lock);
 			renew_client_locked(clp);
 			return clp;
 		}
@@ -3118,6 +3175,14 @@ static __be32 copy_impl_id(struct nfs4_client *clp,
 	return 0;
 }
 
+static void
+nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
+{
+	spin_lock(&clp->cl_cs_lock);
+	set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
+	spin_unlock(&clp->cl_cs_lock);
+}
+
 __be32
 nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -3195,6 +3260,10 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	/* Cases below refer to rfc 5661 section 18.35.4: */
 	spin_lock(&nn->client_lock);
 	conf = find_confirmed_client_by_name(&exid->clname, nn);
+	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(conf);
+		conf = NULL;
+	}
 	if (conf) {
 		bool creds_match = same_creds(&conf->cl_cred, &rqstp->rq_cred);
 		bool verfs_match = same_verf(&verf, &conf->cl_verifier);
@@ -3462,6 +3531,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 	spin_lock(&nn->client_lock);
 	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
 	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
+	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(conf);
+		conf = NULL;
+	}
 	WARN_ON_ONCE(conf && unconf);
 
 	if (conf) {
@@ -3493,6 +3566,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 			goto out_free_conn;
 		}
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
+		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &old->cl_flags)) {
+			nfsd4_discard_courtesy_clnt(old);
+			old = NULL;
+		}
 		if (old) {
 			status = mark_client_expired_locked(old);
 			if (status) {
@@ -3631,6 +3708,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	struct nfsd4_session *session;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	if (!nfsd4_last_compound_op(rqstp))
 		return nfserr_not_only_op;
@@ -3663,6 +3741,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	nfsd4_init_conn(rqstp, conn, session);
 	status = nfs_ok;
 out:
+	clp = session->se_client;
+	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
+		if (status == nfs_ok)
+			nfsd4_client_record_create(clp);
+		else
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 	nfsd4_put_session(session);
 out_no_session:
 	return status;
@@ -3685,6 +3770,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	int ref_held_by_me = 0;
 	struct net *net = SVC_NET(r);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	status = nfserr_not_only_op;
 	if (nfsd4_compound_in_session(cstate, sessionid)) {
@@ -3697,6 +3783,13 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
 	if (!ses)
 		goto out_client_lock;
+	clp = ses->se_client;
+	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
+		status = nfserr_badsession;
+		nfsd4_discard_courtesy_clnt(clp);
+		goto out_put_session;
+	}
+
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(ses->se_client, r))
 		goto out_put_session;
@@ -3801,7 +3894,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
-	struct nfs4_client *clp;
+	struct nfs4_client *clp = NULL;
 	struct nfsd4_slot *slot;
 	struct nfsd4_conn *conn;
 	__be32 status;
@@ -3911,6 +4004,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (conn)
 		free_conn(conn);
 	spin_unlock(&nn->client_lock);
+	if (clp && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
+		if (status == nfs_ok)
+			nfsd4_client_record_create(clp);
+		else
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 	return status;
 out_put_session:
 	nfsd4_put_session_locked(session);
@@ -3947,6 +4046,10 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
 	spin_lock(&nn->client_lock);
 	unconf = find_unconfirmed_client(&dc->clientid, true, nn);
 	conf = find_confirmed_client(&dc->clientid, true, nn);
+	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(conf);
+		conf = NULL;
+	}
 	WARN_ON_ONCE(conf && unconf);
 
 	if (conf) {
@@ -4030,12 +4133,17 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client	*unconf = NULL;
 	__be32 			status;
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfs4_client *cclient = NULL;
 
 	new = create_client(clname, rqstp, &clverifier);
 	if (new == NULL)
 		return nfserr_jukebox;
 	spin_lock(&nn->client_lock);
 	conf = find_confirmed_client_by_name(&clname, nn);
+	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
+		cclient = conf;
+		conf = NULL;
+	}
 	if (conf && client_has_state(conf)) {
 		status = nfserr_clid_inuse;
 		if (clp_used_exchangeid(conf))
@@ -4066,7 +4174,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = NULL;
 	status = nfs_ok;
 out:
+	if (cclient)
+		unhash_client_locked(cclient);
 	spin_unlock(&nn->client_lock);
+	if (cclient)
+		expire_client(cclient);
 	if (new)
 		free_client(new);
 	if (unconf) {
@@ -4096,6 +4208,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	spin_lock(&nn->client_lock);
 	conf = find_confirmed_client(clid, false, nn);
 	unconf = find_unconfirmed_client(clid, false, nn);
+	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(conf);
+		conf = NULL;
+	}
 	/*
 	 * We try hard to give out unique clientid's, so if we get an
 	 * attempt to confirm the same clientid with a different cred,
@@ -4126,6 +4242,11 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
 	} else {
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
+		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT,
+						&old->cl_flags)) {
+			nfsd4_discard_courtesy_clnt(old);
+			old = NULL;
+		}
 		if (old) {
 			status = nfserr_clid_inuse;
 			if (client_has_state(old)
@@ -4711,18 +4832,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	return ret;
 }
 
+/*
+ * Function returns true if lease conflict was resolved
+ * else returns false.
+ */
 static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 {
 	struct nfs4_delegation *dl = fl->fl_owner;
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	clp = dl->dl_stid.sc_client;
+
+	/*
+	 * need to sync with courtesy client trying to reconnect using
+	 * the cl_cs_lock, nn->client_lock can not be used since this
+	 * function is called with the fl_lck held.
+	 */
+	spin_lock(&clp->cl_cs_lock);
+	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+
 	if (!i_am_nfsd())
-		return NULL;
+		return false;
 	rqst = kthread_data(current);
 	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
 	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
-		return NULL;
+		return false;
 	clp = *(rqst->rq_lease_breaker);
 	return dl->dl_stid.sc_client == clp;
 }
@@ -4755,7 +4899,7 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
 }
 
 static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
-						struct nfsd_net *nn)
+			struct nfsd_net *nn)
 {
 	struct nfs4_client *found;
 
@@ -4785,6 +4929,9 @@ static __be32 set_client(clientid_t *clid,
 	cstate->clp = lookup_clientid(clid, false, nn);
 	if (!cstate->clp)
 		return nfserr_expired;
+
+	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &cstate->clp->cl_flags))
+		nfsd4_client_record_create(cstate->clp);
 	return nfs_ok;
 }
 
@@ -4937,9 +5084,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
 }
 
-static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
+static bool
+nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
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
+ * This function is called to check whether nfserr_share_denied should
+ * be returning to client.
+ *
+ * access:  is op_share_access if share_access is true.
+ *	    Check if access mode, op_share_access, would conflict with
+ *	    the current deny mode of the file 'fp'.
+ * access:  is op_share_deny if share_access is false.
+ *	    Check if the deny mode, op_share_deny, would conflict with
+ *	    current access of the file 'fp'.
+ * stp:     skip checking this entry.
+ * new_stp: normal open, not open upgrade.
+ *
+ * Function returns:
+ *	true   - access/deny mode conflict with normal client.
+ *	false  - no conflict or conflict with courtesy client(s) is resolved.
+ */
+static bool
+nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
+		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
+{
+	struct nfs4_ol_stateid *st;
+	struct nfs4_client *cl;
+	bool conflict = false;
+
+	lockdep_assert_held(&fp->fi_lock);
+	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
+		if (st->st_openstp || (st == stp && new_stp) ||
+			(!nfs4_check_access_deny_bmap(st,
+					access, share_access)))
+			continue;
+
+		/* need to sync with courtesy client trying to reconnect */
+		cl = st->st_stid.sc_client;
+		spin_lock(&cl->cl_cs_lock);
+		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
+			spin_unlock(&cl->cl_cs_lock);
+			continue;
+		}
+		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
+			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
+			spin_unlock(&cl->cl_cs_lock);
+			continue;
+		}
+		/* conflict not caused by courtesy client */
+		spin_unlock(&cl->cl_cs_lock);
+		conflict = true;
+		break;
+	}
+	return conflict;
+}
+
+static __be32
+nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
-		struct nfsd4_open *open)
+		struct nfsd4_open *open, bool new_stp)
 {
 	struct nfsd_file *nf = NULL;
 	__be32 status;
@@ -4955,15 +5182,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	 */
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status != nfs_ok) {
-		spin_unlock(&fp->fi_lock);
-		goto out;
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_conflict_clients(fp, new_stp, stp,
+				open->op_share_deny, false)) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
 	}
 
 	/* set access to the file */
 	status = nfs4_file_get_access(fp, open->op_share_access);
 	if (status != nfs_ok) {
-		spin_unlock(&fp->fi_lock);
-		goto out;
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_conflict_clients(fp, new_stp, stp,
+				open->op_share_access, true)) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
 	}
 
 	/* Set access bits in stateid */
@@ -5014,7 +5255,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
 	unsigned char old_deny_bmap = stp->st_deny_bmap;
 
 	if (!test_access(open->op_share_access, stp))
-		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
+		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
 
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
@@ -5363,7 +5604,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 	} else {
-		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
@@ -5597,6 +5838,121 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+static bool
+nfs4_anylock_blocker(struct nfs4_client *clp)
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
+	spin_lock(&clp->cl_lock);
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
+					if (!list_empty(&fl->fl_blocked_requests)) {
+						spin_unlock(&clp->cl_lock);
+						return true;
+					}
+				}
+			}
+		}
+	}
+	spin_unlock(&clp->cl_lock);
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
+	struct list_head cslist;
+
+	INIT_LIST_HEAD(reaplist);
+	INIT_LIST_HEAD(&cslist);
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (!state_expired(lt, clp->cl_time))
+			break;
+
+		/* client expired */
+		if (!client_has_state(clp)) {
+			if (mark_client_expired_locked(clp))
+				continue;
+			list_add(&clp->cl_lru, reaplist);
+			continue;
+		}
+
+		/* expired client has state */
+		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
+			goto exp_client;
+
+		cour = test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+		if (cour &&
+			ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
+			goto exp_client;
+
+		if (nfs4_anylock_blocker(clp)) {
+			/* expired client has state and has blocker. */
+exp_client:
+			if (mark_client_expired_locked(clp))
+				continue;
+			list_add(&clp->cl_lru, reaplist);
+			continue;
+		}
+		/*
+		 * Client expired and has state and has no blockers.
+		 * If there is race condition with blockers, next time
+		 * the laundromat runs it will catch it and expires
+		 * the client.
+		 */
+		if (!cour) {
+			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+			clp->courtesy_client_expiry = ktime_get_boottime_seconds() +
+					NFSD_COURTESY_CLIENT_TIMEOUT;
+			list_add(&clp->cl_cs_list, &cslist);
+		}
+	}
+	spin_unlock(&nn->client_lock);
+
+	list_for_each_entry(clp, &cslist, cl_cs_list) {
+		spin_lock(&clp->cl_cs_lock);
+		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
+			!test_bit(NFSD4_CLIENT_COURTESY,
+					&clp->cl_flags)) {
+			spin_unlock(&clp->cl_cs_lock);
+			continue;
+		}
+		spin_unlock(&clp->cl_cs_lock);
+		nfsd4_client_record_remove(clp);
+	}
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5630,16 +5986,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	}
 	spin_unlock(&nn->s2s_cp_lock);
 
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
@@ -6021,6 +6368,15 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 	found = lookup_clientid(&cps->cp_p_clid, true, nn);
 	if (!found)
 		goto out;
+	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &found->cl_flags)) {
+		spin_lock(&found->cl_cs_lock);
+		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &found->cl_flags);
+		spin_unlock(&found->cl_cs_lock);
+		if (atomic_dec_and_lock(&found->cl_rpc_users,
+					&nn->client_lock))
+			spin_unlock(&nn->client_lock);
+		goto out;
+	}
 
 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
@@ -6525,6 +6881,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
 		lock->fl_end = OFFSET_MAX;
 }
 
+/**
+ * nfsd4_fl_lock_expired - check if lock conflict can be resolved.
+ *
+ * @fl: pointer to file_lock with a potential conflict
+ * Return values:
+ *   %false: real conflict, lock conflict can not be resolved.
+ *   %true: no conflict, lock conflict was resolved.
+ *
+ * Note that this function is called while the flc_lock is held.
+ */
+static bool
+nfsd4_fl_lock_expired(struct file_lock *fl)
+{
+	struct nfs4_lockowner *lo;
+	struct nfs4_client *clp;
+	bool rc = false;
+
+	if (!fl)
+		return false;
+	lo = (struct nfs4_lockowner *)fl->fl_owner;
+	clp = lo->lo_owner.so_client;
+
+	/* need to sync with courtesy client trying to reconnect */
+	spin_lock(&clp->cl_cs_lock);
+	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
+		rc = true;
+	else {
+		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
+			rc =  true;
+		} else
+			rc =  false;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+	return rc;
+}
+
 static fl_owner_t
 nfsd4_fl_get_owner(fl_owner_t owner)
 {
@@ -6572,6 +6965,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
 	.lm_get_owner = nfsd4_fl_get_owner,
 	.lm_put_owner = nfsd4_fl_put_owner,
+	.lm_lock_expired = nfsd4_fl_lock_expired,
 };
 
 static inline void
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 3e5008b475ff..920fad00e2e4 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
 #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 95457cfd37fc..80e565593d83 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -345,6 +345,9 @@ struct nfs4_client {
 #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
 #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
 					 1 << NFSD4_CLIENT_CB_KILL)
+#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
+#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
+#define NFSD4_CLIENT_COURTESY_CLNT	(8)	/* used for lookup clientid/name */
 	unsigned long		cl_flags;
 	const struct cred	*cl_cb_cred;
 	struct rpc_clnt		*cl_cb_client;
@@ -385,6 +388,9 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+	int			courtesy_client_expiry;
+	spinlock_t		cl_cs_lock;
+	struct list_head	cl_cs_list;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

