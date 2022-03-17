Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77DB4DC059
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 08:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiCQHp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 03:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCQHpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:45:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE2C12E7;
        Thu, 17 Mar 2022 00:44:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3THLX001986;
        Thu, 17 Mar 2022 07:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=//dc5mO3m2lCgIQUlFf4OQ7mC2eW2A7e1z/rZkBbXCM=;
 b=ms9r/OhIR6ZKh02KUF4I8TMXapjLjKGK4KooiH6anskR1q2Mxvbw/Lr0EZJo6wNLe4E4
 pBHk4a7GJKRAOPzGBy7zhajzf9JYhWxHMYfnD8+WE/tTtQR2LZ8TdPbIaHpKwMNFObE8
 j9LiaNQLnLeQvQ8G/O6EBfYUZSrPWnKO+xijI6eO7qKSgCBklb/JQt2CXPgPFsz2FQFb
 iD8B05dB9DB8nf7MoxeP2Snu57EWdMQg9YVHR6t/+Cxo5Wp1XdE8o1lLK4MWm19y/PHy
 bATpqvOTs1UA7ja3fEgym1dtn+UhdxQdrZPgHkfVFams1++vkAESBwzFcoHPxBT/NyL5 YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwr5e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:44:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22H7fnWA034958;
        Thu, 17 Mar 2022 07:43:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3erhy2wr02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:43:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22H7hoGr038783;
        Thu, 17 Mar 2022 07:43:59 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3erhy2wqv5-9;
        Thu, 17 Mar 2022 07:43:58 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v17 08/11] NFSD: Update find_client_in_id_table() to handle courtesy client
Date:   Thu, 17 Mar 2022 00:43:45 -0700
Message-Id: <1647503028-11966-9-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: lUP3A7qeVmCQOgBVicXcgFxFrnZlLsuC
X-Proofpoint-ORIG-GUID: lUP3A7qeVmCQOgBVicXcgFxFrnZlLsuC
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
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3b1e857eabee..102b4aae286d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2893,6 +2893,8 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 		if (same_clid(&clp->cl_clientid, clid)) {
 			if ((bool)clp->cl_minorversion != sessions)
 				return NULL;
+			if (nfsd4_courtesy_clnt_expired(clp))
+				continue;
 			renew_client_locked(clp);
 			return clp;
 		}
@@ -2904,9 +2906,15 @@ static struct nfs4_client *
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
@@ -4822,9 +4830,10 @@ static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
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
@@ -4849,6 +4858,8 @@ static __be32 set_client(clientid_t *clid,
 	cstate->clp = lookup_clientid(clid, false, nn);
 	if (!cstate->clp)
 		return nfserr_expired;
+	if (cstate->clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED)
+		nfsd4_client_record_create(cstate->clp);
 	return nfs_ok;
 }
 
@@ -6168,6 +6179,13 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
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

