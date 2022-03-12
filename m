Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307524D6BEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 03:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiCLCPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 21:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiCLCPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:15:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E61B84CA;
        Fri, 11 Mar 2022 18:13:57 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BNEUlt011899;
        Sat, 12 Mar 2022 02:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=NAFoVzd9smCnK1gQpyKocadq16OaaIMgxxFBKYnc8yY=;
 b=LPLoMl3JVZucKS0JWMLqq6ulrOBjbahzi3G3I4m9qZetj2sNqNkGGTb0KVkw7V2ycqti
 mact6imcHork68U+P2NIOGG4xx93jU2Ue/YTi8rpOUv3ZupqNPKLNsIOXqUvZlAgQTlP
 DXEUBB+HR4wi4w2fccI6/063B2dVJFQUo93E+/4hf3J6ynGyvRzZt5xQ7iO1FbMPu0wy
 LuWYMpAjpetyhYtpvLen1KlCDAMxNTdWERSH0GdN8FZrxfmmGRNvslejCf/w1Wk0tmlk
 r7oQKi3+yfq6eJy4Myf2BRuq879QXYfCdn4hcczlLNJrJWvtInsc64oRqYTZ0UCDhkPG Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfstka7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C2BkWp084209;
        Sat, 12 Mar 2022 02:13:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3erhj88qgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:48 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22C2DgMh086332;
        Sat, 12 Mar 2022 02:13:48 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfe-10;
        Sat, 12 Mar 2022 02:13:48 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v16 09/11] NFSD: Refactor nfsd4_laundromat()
Date:   Fri, 11 Mar 2022 18:13:33 -0800
Message-Id: <1647051215-2873-10-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: xvxLrbWR0gbhAngnaSuKG7541AV4CPHe
X-Proofpoint-ORIG-GUID: xvxLrbWR0gbhAngnaSuKG7541AV4CPHe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extract a bit of logic that is about to be expanded to handle
courtesy clients.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2ff80999b243..034161a28bd1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5805,6 +5805,26 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
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
+		if (!state_expired(lt, clp->cl_time))
+			break;
+		if (mark_client_expired_locked(clp))
+			continue;
+		list_add(&clp->cl_lru, reaplist);
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5827,7 +5847,6 @@ nfs4_laundromat(struct nfsd_net *nn)
 		goto out;
 	}
 	nfsd4_end_grace(nn);
-	INIT_LIST_HEAD(&reaplist);
 
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
@@ -5837,17 +5856,7 @@ nfs4_laundromat(struct nfsd_net *nn)
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
-- 
2.9.5

