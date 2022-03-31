Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7522D4EDE31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiCaQEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiCaQEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93E160FDC;
        Thu, 31 Mar 2022 09:02:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEa0mY032355;
        Thu, 31 Mar 2022 16:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=9zXBUnXiKF+VqRq8fk8LNIdhG+VXmNB6K4p7mldr7g4=;
 b=osklpOFmFDx4ENKoouXSGGjNzPuUE6kAWOv5ocL+4OJ/eDZnG6Br4En6VLM+IImUb86m
 D69NvJ/AzqTfY1wGTXVwkne1JliT+LFFopJ8O4wayU035ge6LyoKbp7HSM299Rn87N/m
 +cbDryRvr3Jn/6zZtIHGXRNN+pDHNEJhaUFa/iVUSO9U/UftepEL8UREc6E9FJrZa7uQ
 s4d8iDZJwe8QmENSduVYvXmXFrVCWmk+qfvTQTIoloEPjyGXZVegQZ6JjJGQSpDjlYOw
 s86nKVqKC/7DDEI6YQyX0SIgRTuzqYBC9Kp1OVLWz0g66/uQPDeGdsOqLazAvspXMHcL Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctw1hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFvMUO029503;
        Thu, 31 Mar 2022 16:02:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VG10K1003132;
        Thu, 31 Mar 2022 16:02:14 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxf8-4;
        Thu, 31 Mar 2022 16:02:14 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v19 03/11] NFSD: Add lm_lock_expired call out
Date:   Thu, 31 Mar 2022 09:02:01 -0700
Message-Id: <1648742529-28551-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: k7LuAHNTYCnffyHBtthRE1JDCAufzS-r
X-Proofpoint-GUID: k7LuAHNTYCnffyHBtthRE1JDCAufzS-r
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
index 7f78da5d1408..8b81493ee48a 100644
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

