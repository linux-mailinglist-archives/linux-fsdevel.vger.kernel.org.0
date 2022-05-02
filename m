Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC6517902
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 23:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387616AbiEBVXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiEBVXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 17:23:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F2FBC83;
        Mon,  2 May 2022 14:19:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Kw9m5004338;
        Mon, 2 May 2022 21:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=5MaDpPMGq5u015BZ/xv3zV3etamFYF2SftHH6yNllhk=;
 b=MRY7+iVxbveQop3cNLASaYY5DmsYpV01zN79GRRalSMHKpKMUF9VW/ZpdNasSSv1thfF
 RhKhFrH/9BXK0sjfcbSOEAG9Md+iCJAUc0D7Zs69+xREtgw/kxc2nPr7WsVDa682cg3q
 9oXZc4miKuubDvOdIZVp6CDZfYKmB6HjAah9RrGhzOTV1JJP5lVTW6/HDzL8rCAkU8kV
 ikYbalBKmzWUV/D6kqo2AGyG2pSFv92iJu954FFqbJq8MaMnZwWj76yhd4jiUmqx2MI9
 GzjKt6LkeyGL5D7fX7e+u1pmGJcggJ9KOrRgGr8JuzkPFmTkUI8GcTpEe6e94ryuxRH8 cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0cdux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:19:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242LAjAl029073;
        Mon, 2 May 2022 21:19:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj1v8q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 21:19:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 242LJXSM003941;
        Mon, 2 May 2022 21:19:34 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj1v8ph-4;
        Mon, 02 May 2022 21:19:34 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v25 3/7] NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
Date:   Mon,  2 May 2022 14:19:23 -0700
Message-Id: <1651526367-1522-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
References: <1651526367-1522-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: nyj9DvCkbJOEd0WZ4NFclxsjkUyNmtf5
X-Proofpoint-GUID: nyj9DvCkbJOEd0WZ4NFclxsjkUyNmtf5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch moves create/destroy of laundry_wq from nfs4_state_start
and nfs4_state_shutdown_net to init_nfsd and exit_nfsd to prevent
the laundromat from being freed while a thread is processing a
conflicting lock.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 28 ++++++++++++++++------------
 fs/nfsd/nfsctl.c    |  4 ++++
 fs/nfsd/nfsd.h      |  4 ++++
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fe7949683c01..76c98ab7991b 100644
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
@@ -7747,22 +7762,12 @@ nfs4_state_start(void)
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
@@ -7799,7 +7804,6 @@ nfs4_state_shutdown_net(struct net *net)
 void
 nfs4_state_shutdown(void)
 {
-	destroy_workqueue(laundry_wq);
 	nfsd4_destroy_callback_queue();
 }
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 16920e4512bd..322a208878f2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1544,6 +1544,9 @@ static int __init init_nfsd(void)
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_all;
+	retval = nfsd4_create_laundry_wq();
+	if (retval)
+		goto out_free_all;
 	return 0;
 out_free_all:
 	unregister_pernet_subsys(&nfsd_net_ops);
@@ -1566,6 +1569,7 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
 	nfsd_drc_slab_free();
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 23996c6ca75e..847b482155ae 100644
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
+static inline int nfsd4_create_laundry_wq(void) { return 0; };
+static inline void nfsd4_destroy_laundry_wq(void) {};
 #endif
 
 /*
-- 
2.9.5

