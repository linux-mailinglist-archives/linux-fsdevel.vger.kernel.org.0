Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598334CE1A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiCEAiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiCEAiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F7A14CDBE;
        Fri,  4 Mar 2022 16:37:28 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224Jx5mu020770;
        Sat, 5 Mar 2022 00:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=olLzHwNmxZBZy72/SZ6XOB6q2e+528u7ZebVNL6Jhdc=;
 b=KG69aUJ5FfNSwmgV7L/s57AEUB/E66dvZZ1vw3U6Ksb1pC8fIunxB1PB2uir6g53mVcj
 i9JPMlpzgVualNOoBgGvQWtNTE8Ch8MyWn8UgL9vm3GXWy0+H3vNOKVDj0XdcYgfUFKI
 tH6MNhz4TPd1gmfVAVjIarfrqSbSiagFkJZmQappEI5dyCyLfojBML9ggT7zbIImkPhr
 dyFAx0c+kdjXPaPfoE//krLP19VtgpZDHztS0nIiQVUhwDSFUMEKB/Lh386yVRSo5LrX
 d3zD59X22CD2OLNA0r3W7FiUmcaJEtGo0kNjDpOFxRU7Gxl+thVnFL3xuq2CijdfE3VY LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hw36jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250Ptck146527;
        Sat, 5 Mar 2022 00:37:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaR161402;
        Sat, 5 Mar 2022 00:37:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-8;
        Sat, 05 Mar 2022 00:37:24 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 07/11] NFSD: Update find_in_sessionid_hashtbl() to handle courtesy clients
Date:   Fri,  4 Mar 2022 16:37:09 -0800
Message-Id: <1646440633-3542-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: EMzK13TYS1rIHu4e_kBLiOOHKfeAF-oT
X-Proofpoint-GUID: EMzK13TYS1rIHu4e_kBLiOOHKfeAF-oT
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update find_in_sessionid_hashtbl to:
 . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
 . if courtesy client was found then clear CLIENT_COURTESY and
   set CLIENT_RECONNECTED so callers can take appropriate action.

Update nfsd4_sequence and nfsd4_bind_conn_to_session to create client
record for client with CLIENT_RECONNECTED set.

Update nfsd4_destroy_session to discard client with CLIENT_RECONNECTED
set.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f42d72a8f5ca..34a59c6f446c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1963,13 +1963,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 {
 	struct nfsd4_session *session;
 	__be32 status = nfserr_badsession;
+	struct nfs4_client *clp;
 
 	session = __find_in_sessionid_hashtbl(sessionid, net);
 	if (!session)
 		goto out;
+	clp = session->se_client;
+	if (clp && nfs4_is_courtesy_client_expired(clp)) {
+		session = NULL;
+		goto out;
+	}
 	status = nfsd4_get_session_locked(session);
-	if (status)
+	if (status) {
 		session = NULL;
+		if (clp && test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 out:
 	*ret = status;
 	return session;
@@ -3671,6 +3680,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	struct nfsd4_session *session;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	if (!nfsd4_last_compound_op(rqstp))
 		return nfserr_not_only_op;
@@ -3703,6 +3713,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	nfsd4_init_conn(rqstp, conn, session);
 	status = nfs_ok;
 out:
+	clp = session->se_client;
+	if (test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		if (status == nfs_ok)
+			nfsd4_client_record_create(clp);
+		else
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 	nfsd4_put_session(session);
 out_no_session:
 	return status;
@@ -3725,6 +3742,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	int ref_held_by_me = 0;
 	struct net *net = SVC_NET(r);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	status = nfserr_not_only_op;
 	if (nfsd4_compound_in_session(cstate, sessionid)) {
@@ -3737,6 +3755,12 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
 	if (!ses)
 		goto out_client_lock;
+	clp = ses->se_client;
+	if (test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		status = nfserr_badsession;
+		nfsd4_discard_courtesy_clnt(clp);
+		goto out_put_session;
+	}
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(ses->se_client, r))
 		goto out_put_session;
@@ -3841,7 +3865,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
-	struct nfs4_client *clp;
+	struct nfs4_client *clp = NULL;
 	struct nfsd4_slot *slot;
 	struct nfsd4_conn *conn;
 	__be32 status;
@@ -3951,6 +3975,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (conn)
 		free_conn(conn);
 	spin_unlock(&nn->client_lock);
+	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		if (status == nfs_ok)
+			nfsd4_client_record_create(clp);
+		else
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 	return status;
 out_put_session:
 	nfsd4_put_session_locked(session);
-- 
2.9.5

