Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2A5113DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 10:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiD0I4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiD0I4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:56:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA51AE035;
        Wed, 27 Apr 2022 01:53:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6q8J9003700;
        Wed, 27 Apr 2022 08:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=LGSPXBDQBrKoSqeb2iwjeiVXyaRaUFmj08i8ApiawaA=;
 b=gwLtn9mp5Lrlyn1hYr1555Q4Tbgdv+w7mUEPHg2kr0HWjC/7qlEXG5W5NorydupchmVt
 rISMqn5S5grLYvXA9ltrJ6OxHn6pJw/mkj/3Pbjjy4nxhVK3Z3M47aMbVkmWCUN6j4BV
 ZL2OM9w79ZKFlFRYYU0GePBfsDare/J3ohl7zq4jUvD8iO8KbWDbCGHTu/UhNDNqHV2T
 PiP+ySYUDay1oHB9em936SuO2y7ybojddaRGTlMGPtH+t2B2MP7f47z4F/Seg/heD2Gm
 M8lvU2MCNJI8O3y6ZBYn8QMir6hU56zXPHRranM1lLnuKPhNQ5yFo/N3q3z6rcqqGZUp Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4r3yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 08:53:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23R8kYIn001337;
        Wed, 27 Apr 2022 08:53:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ykfxpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 08:53:01 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23R8ligw005778;
        Wed, 27 Apr 2022 08:53:01 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ykfxme-4;
        Wed, 27 Apr 2022 08:53:01 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v22 3/7] NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
Date:   Wed, 27 Apr 2022 01:52:49 -0700
Message-Id: <1651049573-29552-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: UnwFl37ZCnbTTOtK38ko_laIMJ5whWeP
X-Proofpoint-GUID: UnwFl37ZCnbTTOtK38ko_laIMJ5whWeP
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
 fs/nfsd/nfs4state.c | 28 ++++++++++++++++------------
 fs/nfsd/nfsctl.c    |  5 +++++
 fs/nfsd/nfsd.h      |  4 ++++
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1454cadcd595..55ecf5da25fe 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -127,6 +127,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
 static struct workqueue_struct *laundry_wq;
 
+int nfsd4_create_laundry_wq(void)
+{
+	int rc = 0;
+
+	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
+	if (laundry_wq == NULL)
+		rc = -ENOMEM;
+	return rc;
+}
+
+void nfsd4_destroy_laundry_wq(void)
+{
+	destroy_workqueue(laundry_wq);
+}
+
 static bool is_session_dead(struct nfsd4_session *ses)
 {
 	return ses->se_flags & NFS4_SESSION_DEAD;
@@ -7758,22 +7773,12 @@ nfs4_state_start(void)
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
@@ -7810,7 +7815,6 @@ nfs4_state_shutdown_net(struct net *net)
 void
 nfs4_state_shutdown(void)
 {
-	destroy_workqueue(laundry_wq);
 	nfsd4_destroy_callback_queue();
 }
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 16920e4512bd..2bdd5678deee 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1476,6 +1476,7 @@ static __net_init int nfsd_init_net(struct net *net)
 	if (retval)
 		goto out_drc_error;
 	nn->nfsd4_lease = 90;	/* default lease time */
+	nn->nfsd4_lease = 30;	/* DEBUG */
 	nn->nfsd4_grace = 90;
 	nn->somebody_reclaimed = false;
 	nn->track_reclaim_completes = false;
@@ -1544,6 +1545,9 @@ static int __init init_nfsd(void)
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_all;
+	retval = nfsd4_create_laundry_wq();
+	if (retval)
+		goto out_free_all;
 	return 0;
 out_free_all:
 	unregister_pernet_subsys(&nfsd_net_ops);
@@ -1566,6 +1570,7 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 23996c6ca75e..624a6c7da522 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -162,6 +162,8 @@ void nfs4_state_shutdown_net(struct net *net);
 int nfs4_reset_recoverydir(char *recdir);
 char * nfs4_recoverydir(void);
 bool nfsd4_spo_must_allow(struct svc_rqst *rqstp);
+int nfsd4_create_laundry_wq(void);
+void nfsd4_destroy_laundry_wq(void);
 #else
 static inline int nfsd4_init_slabs(void) { return 0; }
 static inline void nfsd4_free_slabs(void) { }
@@ -175,6 +177,8 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 {
 	return false;
 }
+static inline int nfsd4_create_laundry_wq(void) { return 0 };
+static inline void nfsd4_destroy_laundry_wq(void) {};
 #endif
 
 /*
-- 
2.9.5

