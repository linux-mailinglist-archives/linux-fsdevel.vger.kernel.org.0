Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC784E6D48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 05:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358229AbiCYEgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358209AbiCYEgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:36:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED19C6810;
        Thu, 24 Mar 2022 21:35:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P0HSD9010788;
        Fri, 25 Mar 2022 04:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=GCCYTjtEURvqHpfBP1bRepULzX12vgrHNRQxR5jmc0E=;
 b=j6lMngfDTgZLe8vWDFqgSy8sMOXs7yxIZDCCzlAW9/kAa4mIYbY+ikXtKNk1wufHiPcs
 9Cjl4IPdSEQbFWM0Wq10n7PscU5pJvoVwFtrKCad/IMfEVGCkZd/JlZupH260i7UhXei
 wkbRMajgK6FIPpyxuQOLURziGrdQssQygC0dpqsvaAobURb3KvQOTztJbh6s/HLo4s8W
 Aahy6E7DHXxdyrJBJCmAU/5WNWITZmFs4Yyudh3gKdPXXG17kYzyM7/toDBqB08z86RR
 ZNXXxgSHbnGNHjOTxegLR197YU5dLiLGBanX41sPsdGpw229SIvoZtiz9T9uJHF6Cjrm nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6sse8d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:34:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22P4WEhY020841;
        Fri, 25 Mar 2022 04:34:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:34:57 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22P4YsCY040479;
        Fri, 25 Mar 2022 04:34:57 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bmt-4;
        Fri, 25 Mar 2022 04:34:57 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v18 03/11] NFSD: Add lm_lock_expired call out
Date:   Thu, 24 Mar 2022 21:34:43 -0700
Message-Id: <1648182891-32599-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: h8bESJtcQVqLX_UMHGCLMxEW4ntXWKNb
X-Proofpoint-GUID: h8bESJtcQVqLX_UMHGCLMxEW4ntXWKNb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
If lock request has conflict with courtesy client then expire the
courtesy client and return no conflict to caller.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++++
 fs/nfsd/state.h     | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a65d59510681..80772662236b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6578,10 +6578,32 @@ nfsd4_lm_notify(struct file_lock *fl)
 	}
 }
 
+/**
+ * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
+ *
+ * @fl: pointer to file_lock with a potential conflict
+ * Return values:
+ *   %false: real conflict, lock conflict can not be resolved.
+ *   %true: no conflict, lock conflict was resolved.
+ *
+ * Note that this function is called while the flc_lock is held.
+ */
+static bool
+nfsd4_lm_lock_expired(struct file_lock *fl)
+{
+	struct nfs4_lockowner *lo;
+
+	if (!fl)
+		return false;
+	lo = (struct nfs4_lockowner *)fl->fl_owner;
+	return nfsd4_expire_courtesy_clnt(lo->lo_owner.so_client);
+}
+
 static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
 	.lm_get_owner = nfsd4_lm_get_owner,
 	.lm_put_owner = nfsd4_lm_put_owner,
+	.lm_lock_expired = nfsd4_lm_lock_expired,
 };
 
 static inline void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 40e390abc842..d156ae3ab46c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -735,4 +735,18 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+static inline bool
+nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
+{
+	bool rc = false;
+
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY)
+		clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
+		rc = true;
+	spin_unlock(&clp->cl_cs_lock);
+	return rc;
+}
+
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

