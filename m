Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869004E6D51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 05:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358236AbiCYEgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 00:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358230AbiCYEgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:36:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A38C681C;
        Thu, 24 Mar 2022 21:35:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P0HSDA010788;
        Fri, 25 Mar 2022 04:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=GIOV6nH1eX8CQGLstcEJ4yo+7K+tEOdgbBFbT7K53dY=;
 b=Y/1Ul0FRTrRhKf3Rro193SGajZQWAHxQJbiwKNdup2ayU0qBWqMn9VFayR93c2esF/Nt
 Sx186Iyy1x7J8ylai2v1roO6FbvyZMuUtwdewsE3vy7yfEClZBVwTUNXNZJEu2EGfs/k
 zvQrWt27Znf5m1Sln3dRF8xoFsOV2YS3A/hNpCn/Sj3N6SLeLG3NOiOmbD2wa51x3qww
 kqUT80Oi9OjGgZul70BRAvVkYUd35/GrNgX6G0ZBQ+FD1G546i5b0Uc1Yj+EV4H5Vwwu
 Z/FE2BQUY0wpVLU9+BD+0PNn1rIBvmhg23mrg6+OOAO3Xie0cJnixMiDSjdhQAAZtM84 xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6sse8dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:35:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22P4WCuC020740;
        Fri, 25 Mar 2022 04:35:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:35:01 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22P4YsCg040479;
        Fri, 25 Mar 2022 04:35:01 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bmt-8;
        Fri, 25 Mar 2022 04:35:01 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v18 07/11] NFSD: Update find_in_sessionid_hashtbl() to handle courtesy client
Date:   Thu, 24 Mar 2022 21:34:47 -0700
Message-Id: <1648182891-32599-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: 6yxNvKtXGo_R7lzV_Am1QHGC-TzezmYb
X-Proofpoint-GUID: 6yxNvKtXGo_R7lzV_Am1QHGC-TzezmYb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update find_in_sessionid_hashtbl to:
 . skip client with CLIENT_EXPIRED state; discarded courtesy client.
 . if courtesy client was found then set CLIENT_RECONNECTED so caller
   can take appropriate action.

Update nfsd4_sequence and nfsd4_bind_conn_to_session to create client
record for courtesy client with CLIENT_RECONNECTED state.

Update nfsd4_destroy_session to discard courtesy client with
CLIENT_RECONNECTED state.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eadce5d19473..3e9cdc4a4a47 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1994,13 +1994,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 {
 	struct nfsd4_session *session;
 	__be32 status = nfserr_badsession;
+	struct nfs4_client *clp;
 
 	session = __find_in_sessionid_hashtbl(sessionid, net);
 	if (!session)
 		goto out;
+	clp = session->se_client;
+	if (nfsd4_courtesy_clnt_expired(clp)) {
+		session = NULL;
+		goto out;
+	}
 	status = nfsd4_get_session_locked(session);
-	if (status)
+	if (status) {
 		session = NULL;
+		if (clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED)
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 out:
 	*ret = status;
 	return session;
@@ -3702,6 +3711,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	struct nfsd4_session *session;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	if (!nfsd4_last_compound_op(rqstp))
 		return nfserr_not_only_op;
@@ -3734,6 +3744,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	nfsd4_init_conn(rqstp, conn, session);
 	status = nfs_ok;
 out:
+	clp = session->se_client;
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		if (status == nfs_ok)
+			nfsd4_client_record_create(clp);
+		else
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 	nfsd4_put_session(session);
 out_no_session:
 	return status;
@@ -3756,6 +3773,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	int ref_held_by_me = 0;
 	struct net *net = SVC_NET(r);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	status = nfserr_not_only_op;
 	if (nfsd4_compound_in_session(cstate, sessionid)) {
@@ -3768,6 +3786,12 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
 	if (!ses)
 		goto out_client_lock;
+	clp = ses->se_client;
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		status = nfserr_badsession;
+		nfsd4_discard_courtesy_clnt(clp);
+		goto out_put_session;
+	}
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(ses->se_client, r))
 		goto out_put_session;
@@ -3872,7 +3896,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
-	struct nfs4_client *clp;
+	struct nfs4_client *clp = NULL;
 	struct nfsd4_slot *slot;
 	struct nfsd4_conn *conn;
 	__be32 status;
@@ -3982,6 +4006,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (conn)
 		free_conn(conn);
 	spin_unlock(&nn->client_lock);
+	if (clp && clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
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

