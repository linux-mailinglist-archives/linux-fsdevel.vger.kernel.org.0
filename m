Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108EC4D6BE3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 03:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiCLCPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 21:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiCLCOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:14:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F451AA048;
        Fri, 11 Mar 2022 18:13:50 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C1hxI0013559;
        Sat, 12 Mar 2022 02:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=XHhtyopXZzpFEOphEdO15NR9aYcZXYqcEdZ8ZRWkJMc=;
 b=d3OpftaPLYdDsg1HJFxCZVU5oV7KcsAzoVxR9tsS2AWrSgtXOKURPNm8l13nbdremvSq
 nWcehMgjU6lw0fg8vb3KwUr9DaEDZJmGjElSPsuaIPuVQ064Phd8B3ddrR5jRouo+YQS
 ETEswsm5D5Z03fP4gnIzzfECa84JMdE2L/Dl0df1XpezBS7qW9UfLhUZ8RVPnoTYp4+m
 g4jyk2Vh6URlqkEsgk9Zps2WTV54aVnn5a62wq0r8y16S0uEgCStrJaph2P6b4nGSgzc
 Oi8EPEohlhPdEmISnA0VOULqbiZEHStLTAP6f4CFGHHgSQJ49OG4aLmFr7k3sg8yy8/s DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erj4200j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C2BvaA084272;
        Sat, 12 Mar 2022 02:13:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3erhj88qg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:46 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22C2DgMb086332;
        Sat, 12 Mar 2022 02:13:46 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfe-7;
        Sat, 12 Mar 2022 02:13:46 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v16 06/11] NFSD: Update find_clp_in_name_tree() to handle courtesy clients
Date:   Fri, 11 Mar 2022 18:13:30 -0800
Message-Id: <1647051215-2873-7-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: d7uYHyo1LHvv08sOuGPKCAt2rUCFTEWT
X-Proofpoint-ORIG-GUID: d7uYHyo1LHvv08sOuGPKCAt2rUCFTEWT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update find_clp_in_name_tree:
 . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
 . if courtesy client was found then clear CLIENT_COURTESY and
   set CLIENT_RECONNECTED so callers can take appropriate action.

Update find_confirmed_client_by_name to discard the courtesy
client; set CLIENT_EXPIRED.

Update nfsd4_setclientid to expire the confirmed courtesy client
to prevent multiple confirmed clients with the same name on the
the conf_id_hashtbl list.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b16f689f34c3..2f19aaaf6a66 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1929,6 +1929,33 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net)
 	return NULL;
 }
 
+static void
+nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
+{
+	spin_lock(&clp->cl_cs_lock);
+	set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
+	spin_unlock(&clp->cl_cs_lock);
+}
+
+static bool
+nfs4_is_courtesy_client_expired(struct nfs4_client *clp)
+{
+	spin_lock(&clp->cl_cs_lock);
+	clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	/*
+	 * clear CLIENT_COURTESY flag to prevent it from being
+	 * destroyed by thread trying to resolve conflicts.
+	 */
+	if (test_and_clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
+		set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+	spin_unlock(&clp->cl_cs_lock);
+	return false;
+}
+
 static struct nfsd4_session *
 find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 		__be32 *ret)
@@ -2834,8 +2861,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
 			node = node->rb_left;
 		else if (cmp < 0)
 			node = node->rb_right;
-		else
+		else {
+			if (nfs4_is_courtesy_client_expired(clp))
+				return NULL;
 			return clp;
+		}
 	}
 	return NULL;
 }
@@ -2914,8 +2944,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
 static struct nfs4_client *
 find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
 {
+	struct nfs4_client *clp;
+
 	lockdep_assert_held(&nn->client_lock);
-	return find_clp_in_name_tree(name, &nn->conf_name_tree);
+	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
+	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(clp);
+		clp = NULL;
+	}
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4032,12 +4069,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client	*unconf = NULL;
 	__be32 			status;
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfs4_client	*cclient = NULL;
 
 	new = create_client(clname, rqstp, &clverifier);
 	if (new == NULL)
 		return nfserr_jukebox;
 	spin_lock(&nn->client_lock);
-	conf = find_confirmed_client_by_name(&clname, nn);
+	/* find confirmed client by name */
+	conf = find_clp_in_name_tree(&clname, &nn->conf_name_tree);
+	if (conf && test_bit(NFSD4_CLIENT_RECONNECTED, &conf->cl_flags)) {
+		cclient = conf;
+		conf = NULL;
+	}
+
 	if (conf && client_has_state(conf)) {
 		status = nfserr_clid_inuse;
 		if (clp_used_exchangeid(conf))
@@ -4068,7 +4112,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
-- 
2.9.5

