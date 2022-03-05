Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F94CE199
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiCEAiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiCEAiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032E18E;
        Fri,  4 Mar 2022 16:37:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224Jx5mt020770;
        Sat, 5 Mar 2022 00:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=zr2GuroqkQCEJUAkHaSF7PaiddkbHo5TKIjBVWhg/24=;
 b=1BNy8mD2v6qfqJHqB2a4xSgOSAW8Z2h3X06VtMIYLZglSyMJlxtjPsPK8WG6+yJxqt3d
 THuk2DUOILfkWtHcgAMA8g6vpNTzGiiNyaE9KcLT5oFTiRCw4z6g09RSwNN0J8vVz/Nd
 2H1AjvbqvcMevDPRxPx2eITOXu/aphl5sOgka7PEtceG4arr+JhPx7Wi+qR9DrzkpJFa
 3mE9rI8CQg6NLw8uXzaDgACKjM+W3fB/r4hurHzMcQbMAN4xg2B33uBR7KCAH9k7rsRx
 DKw+8JaA9hk+lMWA9SXl1lGILEQgFvhDrHzU5y1nm+6zKjBTaujYRUpvn8vKMV3lHIHT Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hw36jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250Pw44146626;
        Sat, 5 Mar 2022 00:37:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:22 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaJ161402;
        Sat, 5 Mar 2022 00:37:21 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-4;
        Sat, 05 Mar 2022 00:37:21 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 03/11] NFSD: Add lm_lock_expired call out
Date:   Fri,  4 Mar 2022 16:37:05 -0800
Message-Id: <1646440633-3542-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: e6tUynlzt7vDISv-Vw4pUGLfcTTUabzE
X-Proofpoint-GUID: e6tUynlzt7vDISv-Vw4pUGLfcTTUabzE
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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
 fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a65d59510681..583ac807e98d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
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
+	struct nfs4_client *clp;
+	bool rc = false;
+
+	if (!fl)
+		return false;
+	lo = (struct nfs4_lockowner *)fl->fl_owner;
+	clp = lo->lo_owner.so_client;
+
+	/* need to sync with courtesy client trying to reconnect */
+	spin_lock(&clp->cl_cs_lock);
+	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
+		rc = true;
+	else {
+		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
+			rc =  true;
+		}
+	}
+	spin_unlock(&clp->cl_cs_lock);
+	return rc;
+}
+
 static const struct lock_manager_operations nfsd_posix_mng_ops  = {
 	.lm_notify = nfsd4_lm_notify,
 	.lm_get_owner = nfsd4_lm_get_owner,
 	.lm_put_owner = nfsd4_lm_put_owner,
+	.lm_lock_expired = nfsd4_lm_lock_expired,
 };
 
 static inline void
-- 
2.9.5

