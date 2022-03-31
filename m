Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93E4EDE26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbiCaQEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiCaQEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097DF17154E;
        Thu, 31 Mar 2022 09:02:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VFUhpK029851;
        Thu, 31 Mar 2022 16:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=sMuWa3tktc018ISun+eN9uSgXne5vBC2P8jsDM3coKQ=;
 b=Aa1Y6wzj6Q9fQ13QIllJyJ77Ji/pWM97Y1Iyewp9GRH+6aQbvgVrdyfb5EHz3NylhZSV
 00K+HlbiS4YeQw9KnDawENGiRNuWwfl4fvOBXcvIj+1bJDMr92mwlpLBEhBXreo/HvQj
 GYu9t3xd2l68PjuC/dt/w2cIJ08tweyEvFBZbUfnXwAk72KT/GvCrG2Iti/7LIgCHRdX
 vsD6pWdMla66V4OFtAgtntrMnd7SmnUGthhwKRIsCbhbX++bDZalv6JoPFRQkik/Q1aU
 5FaiUlejxvMOUEjCLohq2hDnDWi3beJeAKo62LDneK24dm10yfay5xOdGbPDqhb4EQgB zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbck2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFvMQK029490;
        Thu, 31 Mar 2022 16:02:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VG10K7003132;
        Thu, 31 Mar 2022 16:02:16 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxf8-7;
        Thu, 31 Mar 2022 16:02:16 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to handle courtesy client
Date:   Thu, 31 Mar 2022 09:02:04 -0700
Message-Id: <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: ypn0u2Vi8ae1EfuQm-C57kCCjBeK1yDH
X-Proofpoint-ORIG-GUID: ypn0u2Vi8ae1EfuQm-C57kCCjBeK1yDH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update find_clp_in_name_tree to check and expire courtesy client.

Update find_confirmed_client_by_name to discard the courtesy
client by setting CLIENT_EXPIRED.

Update nfsd4_setclientid to expire client with CLIENT_EXPIRED
state to prevent multiple confirmed clients with the same name
on the conf_name_tree.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
 fs/nfsd/state.h     | 22 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fe8969ba94b3..eadce5d19473 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2893,8 +2893,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
 			node = node->rb_left;
 		else if (cmp < 0)
 			node = node->rb_right;
-		else
+		else {
+			if (nfsd4_courtesy_clnt_expired(clp))
+				return NULL;
 			return clp;
+		}
 	}
 	return NULL;
 }
@@ -2973,8 +2976,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
 static struct nfs4_client *
 find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
 {
+	struct nfs4_client *clp;
+
 	lockdep_assert_held(&nn->client_lock);
-	return find_clp_in_name_tree(name, &nn->conf_name_tree);
+	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
+	if (clp && clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		nfsd4_discard_courtesy_clnt(clp);
+		clp = NULL;
+	}
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4091,12 +4101,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
+	if (conf && conf->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		cclient = conf;
+		conf = NULL;
+	}
+
 	if (conf && client_has_state(conf)) {
 		status = nfserr_clid_inuse;
 		if (clp_used_exchangeid(conf))
@@ -4127,7 +4144,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 8b81493ee48a..a2e2ac1a945a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -735,6 +735,7 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+/* courteous server */
 static inline bool
 nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
 {
@@ -749,4 +750,25 @@ nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
 	return rc;
 }
 
+static inline void
+nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
+{
+	spin_lock(&clp->cl_cs_lock);
+	clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
+	spin_unlock(&clp->cl_cs_lock);
+}
+
+static inline bool
+nfsd4_courtesy_clnt_expired(struct nfs4_client *clp)
+{
+	bool rc = false;
+
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
+		rc = true;
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY)
+		clp->cl_cs_client_state = NFSD4_CLIENT_RECONNECTED;
+	spin_unlock(&clp->cl_cs_lock);
+	return rc;
+}
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

