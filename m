Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BEA50CCF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiDWSrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 14:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiDWSrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:47:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914791A1DB7;
        Sat, 23 Apr 2022 11:44:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23NH4Q9r022522;
        Sat, 23 Apr 2022 18:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=XlK8hBLwCnzDtTv4RYb6Sytc3AvVKm5XY0ympoJTUoQ=;
 b=Y2Te1J+7LFhz4MU0Hqj2z0xd3B08z/14Ckjni8NhKI2NymIUCKeyv4XeIkNFmjKEM8/A
 lA99JVnAyto/T3gMlwizjDXeEVQQeYdH7Ntvr9wD0IUV151NzB13vDm1SYTbFpv4JvrJ
 FwaumNuVQf2TazYb/4K2YMw54p3j+QVYkBjq2FiGmPopzc+1FKV8E2mAStzBiSbid8fV
 v8ZNHSOMvY9oHtIJWPc2dELuwLdqOwaT1r9j/Gr4wEdt3Jl4FfCdaW5WCM0c1Bftn1Q1
 kgP0P5OPQ4BSBIc5X+udYmJCK4tW4MRoEvXA48t045OdwncJsN+WolMF43nJ7uI5rlW0 Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yrnhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23NIb1I1010527;
        Sat, 23 Apr 2022 18:44:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14shp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 18:44:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23NIgigq016659;
        Sat, 23 Apr 2022 18:44:20 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w14sh1-4;
        Sat, 23 Apr 2022 18:44:20 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v21 3/7] NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
Date:   Sat, 23 Apr 2022 11:44:11 -0700
Message-Id: <1650739455-26096-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: wGlrd9LjTa3cbWSfRlBgWSm-kQ_Tg-qj
X-Proofpoint-GUID: wGlrd9LjTa3cbWSfRlBgWSm-kQ_Tg-qj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch moves create/destroy of laundry_wq from nfs4_state_start
and nfs4_state_shutdown_net to init_nfsd and exit_nfsd to prevent
the laundromat from being freed while a thread is processing a
conflicting lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 15 ++-------------
 fs/nfsd/nfsctl.c    |  6 ++++++
 fs/nfsd/nfsd.h      |  1 +
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b08c132648b9..b70ba2eb5665 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -125,7 +125,7 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
-static struct workqueue_struct *laundry_wq;
+struct workqueue_struct *laundry_wq;
 
 static bool is_session_dead(struct nfsd4_session *ses)
 {
@@ -7798,22 +7798,12 @@ nfs4_state_start(void)
 {
 	int ret;
 
-	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
-	if (laundry_wq == NULL) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	ret = nfsd4_create_callback_queue();
 	if (ret)
-		goto out_free_laundry;
+		return ret;
 
 	set_max_delegations();
 	return 0;
-
-out_free_laundry:
-	destroy_workqueue(laundry_wq);
-out:
-	return ret;
 }
 
 void
@@ -7850,7 +7840,6 @@ nfs4_state_shutdown_net(struct net *net)
 void
 nfs4_state_shutdown(void)
 {
-	destroy_workqueue(laundry_wq);
 	nfsd4_destroy_callback_queue();
 }
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 16920e4512bd..884e873b46ad 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1544,6 +1544,11 @@ static int __init init_nfsd(void)
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_all;
+	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
+	if (laundry_wq == NULL) {
+		retval = -ENOMEM;
+		goto out_free_all;
+	}
 	return 0;
 out_free_all:
 	unregister_pernet_subsys(&nfsd_net_ops);
@@ -1566,6 +1571,7 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	destroy_workqueue(laundry_wq);
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 23996c6ca75e..d41dcf1c4312 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -72,6 +72,7 @@ extern unsigned long		nfsd_drc_max_mem;
 extern unsigned long		nfsd_drc_mem_used;
 
 extern const struct seq_operations nfs_exports_op;
+extern struct workqueue_struct *laundry_wq;
 
 /*
  * Common void argument and result helpers
-- 
2.9.5

