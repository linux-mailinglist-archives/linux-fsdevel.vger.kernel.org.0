Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9347D4CE1A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiCEAiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiCEAiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E241990;
        Fri,  4 Mar 2022 16:37:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224KFxd3009042;
        Sat, 5 Mar 2022 00:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=EH1P5KqmZNy/b8Q5rSQhj/sfecFbc94SIsDmOdiOADk=;
 b=Ej2Wu/N0wDrOZnaRofH0HddUAbbG7rZXsPYGy8oTI3w8wwvE9uVkdRkMJ8Fe0glERMk7
 OSB/nTEVL4OOdGBqGTIvGMtDgRBLVrD+RGruFoKeSezyVTRzKO9Hudhpd/OcaHhzw92Y
 Ja9fgnfNbjXdVC712d4Gz67BUBaXZmNIRHQWsWVKq76u2mQvhhfETnxYtiexqk/3llYn
 DGaZFHvjoSFcOCBvQoyoamLGWzZsNfz/jQZv+jO+/iFwsICT0OHb8wA5ENRNCQKtfFAm
 GIYmW8fgxPM3zPL9pjL0GGDPXzGDkozWLIjG7YDA3EiBeCNlKB4gO+LT5DYNz9LjrHqe jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hv32wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250Pw45146626;
        Sat, 5 Mar 2022 00:37:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaP161402;
        Sat, 5 Mar 2022 00:37:23 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-7;
        Sat, 05 Mar 2022 00:37:23 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 06/11] NFSD: Update find_clp_in_name_tree() to handle courtesy clients
Date:   Fri,  4 Mar 2022 16:37:08 -0800
Message-Id: <1646440633-3542-7-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: AIXrUTd1hSe4UEpk2lItbgNagrR0FBDi
X-Proofpoint-ORIG-GUID: AIXrUTd1hSe4UEpk2lItbgNagrR0FBDi
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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
 fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b16f689f34c3..f42d72a8f5ca 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1929,6 +1929,34 @@ __find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net)
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
+	clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+	/* need to sync with thread resolving lock/deleg conflict */
+	spin_lock(&clp->cl_cs_lock);
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
@@ -2834,8 +2862,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
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
@@ -2914,8 +2945,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
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
@@ -4032,12 +4070,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -4068,7 +4113,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

