Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582824EDE24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiCaQE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiCaQEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDDA18546B;
        Thu, 31 Mar 2022 09:02:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VFBwau030433;
        Thu, 31 Mar 2022 16:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=4V//yiVK06nWuLFbwBJVa6D6T48O4hr3ccOwZgg5FZw=;
 b=aapnEdVPpmUw0OncgZ3Fi5qZ43JQUW8K90HO+Hund0o4Kx1ZzYPZM80uMUrOy3YSkowX
 EjGqU9VCLbzYkg9hN0cnDTWiGsSClUpFfz+MQZroeHn8wrb5VAIxFqNk8KsaO4JLWcu/
 1fQ8p7N1MWW60VejeRFRkM721pPniA8pbu44z5cik8smtJtIW5iwIVjE+pe4i+uE/nmY
 u0nU2wtU1KMY793Nxl8sWAfdJslJuTR8N8A7SNhE/uOmqsQqeK7kFisEbRj4bHdHEk8a
 fpseRlnIjrH7vhnwLBXMAS998p1Py0kUhM8ZMLK8aOsCjbXDpaeymC5XtKhIshzr8VQG aA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0mtme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFvMnG029521;
        Thu, 31 Mar 2022 16:02:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VG10K9003132;
        Thu, 31 Mar 2022 16:02:17 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxf8-8;
        Thu, 31 Mar 2022 16:02:17 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v19 07/11] NFSD: Update find_in_sessionid_hashtbl() to handle courtesy client
Date:   Thu, 31 Mar 2022 09:02:05 -0700
Message-Id: <1648742529-28551-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: iX5625Bqh0sGnQXph57zef34SjHjAELK
X-Proofpoint-GUID: iX5625Bqh0sGnQXph57zef34SjHjAELK
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
 fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eadce5d19473..a3004654d096 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -701,6 +701,22 @@ __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 		atomic_inc(&fp->fi_access[O_RDONLY]);
 }
 
+static void
+nfsd4_reactivate_courtesy_client(struct nfs4_client *clp, __be32 status)
+{
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		if (status == nfs_ok) {
+			clp->cl_cs_client_state = NFSD4_CLIENT_ACTIVE;
+			spin_unlock(&clp->cl_cs_lock);
+			nfsd4_client_record_create(clp);
+			return;
+		}
+		clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+}
+
 /*
  * Check if courtesy clients have conflicting access and resolve it if possible
  *
@@ -1994,13 +2010,22 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
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
@@ -3702,6 +3727,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	struct nfsd4_session *session;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	if (!nfsd4_last_compound_op(rqstp))
 		return nfserr_not_only_op;
@@ -3734,6 +3760,8 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	nfsd4_init_conn(rqstp, conn, session);
 	status = nfs_ok;
 out:
+	clp = session->se_client;
+	nfsd4_reactivate_courtesy_client(clp, status);
 	nfsd4_put_session(session);
 out_no_session:
 	return status;
@@ -3756,6 +3784,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	int ref_held_by_me = 0;
 	struct net *net = SVC_NET(r);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	status = nfserr_not_only_op;
 	if (nfsd4_compound_in_session(cstate, sessionid)) {
@@ -3768,6 +3797,12 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
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
@@ -3872,7 +3907,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
-	struct nfs4_client *clp;
+	struct nfs4_client *clp = NULL;
 	struct nfsd4_slot *slot;
 	struct nfsd4_conn *conn;
 	__be32 status;
@@ -3982,6 +4017,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (conn)
 		free_conn(conn);
 	spin_unlock(&nn->client_lock);
+	if (clp)
+		nfsd4_reactivate_courtesy_client(clp, status);
 	return status;
 out_put_session:
 	nfsd4_put_session_locked(session);
-- 
2.9.5

