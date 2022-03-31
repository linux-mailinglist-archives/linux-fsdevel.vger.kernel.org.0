Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36344EDE25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiCaQEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCaQEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5A460D9E;
        Thu, 31 Mar 2022 09:02:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEd26L032372;
        Thu, 31 Mar 2022 16:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=uuafM9uKPPhrEZgjvuWP/kYH/+TuCz82+Xngl6pc6zk=;
 b=duQuUy7h3ynj/Bs+M/c03pYZx8d5OeieRg3t5bkR2QJyokJ8ACOUtNv2Jqj4F8kI7pws
 DGJV2ZbfB1KpL+6MlSeCcwsQ44E56jboxynOeOcDYd8k2Y31BBw5aAy1FulEWk6fqmWV
 IstiDte2d4njf27FC9yKXBHK9cRbhIJIismnvzsqTzZ6A1KVTZ44LLvKLuBDrszGslkT
 B36DVg4D1XcvTtQ9Pbx9Q+psWwhO4PcSS5pfBxz9J+JdC6sT4txh8iNweEpTks/LOkdT
 M/G+EQxvxEP7i/qVX+2tyS9XVT9kmM3aURAwJsJZ6FaiQ48xemB2MeFRih+Qsv1es2Sx jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctw1j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFvMQM029490;
        Thu, 31 Mar 2022 16:02:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VG10KB003132;
        Thu, 31 Mar 2022 16:02:18 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxf8-9;
        Thu, 31 Mar 2022 16:02:18 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v19 08/11] NFSD: Update find_client_in_id_table() to handle courtesy client
Date:   Thu, 31 Mar 2022 09:02:06 -0700
Message-Id: <1648742529-28551-9-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: 1nPbUXS9EgJ5cmwXnA6tggi-ATX_JHjX
X-Proofpoint-GUID: 1nPbUXS9EgJ5cmwXnA6tggi-ATX_JHjX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update find_client_in_id_table to:
 . skip client with CLIENT_EXPIRED; discarded courtesy client
 . if courtesy client was found then set CLIENT_RECONNECTED
   state so caller can take appropriate action.

Update find_confirmed_client to discard courtesy client.
Update lookup_clientid to call find_client_in_id_table directly.
Update set_client to create client record for courtesy client.
Update find_cpntf_state to discard courtesy client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a3004654d096..b33ad5bce721 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2968,6 +2968,8 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 		if (same_clid(&clp->cl_clientid, clid)) {
 			if ((bool)clp->cl_minorversion != sessions)
 				return NULL;
+			if (nfsd4_courtesy_clnt_expired(clp))
+				continue;
 			renew_client_locked(clp);
 			return clp;
 		}
@@ -2979,9 +2981,15 @@ static struct nfs4_client *
 find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
 {
 	struct list_head *tbl = nn->conf_id_hashtbl;
+	struct nfs4_client *clp;
 
 	lockdep_assert_held(&nn->client_lock);
-	return find_client_in_id_table(tbl, clid, sessions);
+	clp = find_client_in_id_table(tbl, clid, sessions);
+	if (clp && clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		nfsd4_discard_courtesy_clnt(clp);
+		clp = NULL;
+	}
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4888,9 +4896,10 @@ static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
 						struct nfsd_net *nn)
 {
 	struct nfs4_client *found;
+	struct list_head *tbl = nn->conf_id_hashtbl;
 
 	spin_lock(&nn->client_lock);
-	found = find_confirmed_client(clid, sessions, nn);
+	found = find_client_in_id_table(tbl, clid, sessions);
 	if (found)
 		atomic_inc(&found->cl_rpc_users);
 	spin_unlock(&nn->client_lock);
@@ -4915,6 +4924,7 @@ static __be32 set_client(clientid_t *clid,
 	cstate->clp = lookup_clientid(clid, false, nn);
 	if (!cstate->clp)
 		return nfserr_expired;
+	nfsd4_reactivate_courtesy_client(cstate->clp, nfs_ok);
 	return nfs_ok;
 }
 
@@ -6151,6 +6161,13 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 	found = lookup_clientid(&cps->cp_p_clid, true, nn);
 	if (!found)
 		goto out;
+	if (found->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		nfsd4_discard_courtesy_clnt(found);
+		if (atomic_dec_and_lock(&found->cl_rpc_users,
+				&nn->client_lock))
+			spin_unlock(&nn->client_lock);
+		goto out;
+	}
 
 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
-- 
2.9.5

