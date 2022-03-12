Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD14D6BDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 03:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiCLCOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 21:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiCLCOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:14:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB01A2708;
        Fri, 11 Mar 2022 18:13:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22C1Vdws023826;
        Sat, 12 Mar 2022 02:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=zr2GuroqkQCEJUAkHaSF7PaiddkbHo5TKIjBVWhg/24=;
 b=hlaDWH7y5bnAB6PPjxcAIc032U8tWoHGP+66NO15ZoU8+Mvzj1gTOkT1IjSqj62ossv/
 /8YvQCSYyH7W0c17C9hO89MPJtZ6oM6E4/HhdWAYaHBrDZ0axYqjhaUM1kKMOIkbbYY4
 YRl0GUDSNOJjn1ZngR7MKcIWa0wvh+goGqLjVhQNk+Ipx/JVZyFq0Na6WjL+DihfQaNW
 16FBeaGZXmG69ftjrcQEAwsRJvkisq3cnFRSKi8w/UXLwtLxJeF5kZqJL8fFoNmUfwO5
 KobzxJxePIf4n6aKGQ7aV9Ng/LoAKeqldSFp3ROj1jjPjlc3py3QcTs7c0xiEf5XCsOC +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erhxcg0v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22C2CA0U084327;
        Sat, 12 Mar 2022 02:13:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Mar 2022 02:13:44 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22C2DgMV086332;
        Sat, 12 Mar 2022 02:13:44 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3erhj88qfe-4;
        Sat, 12 Mar 2022 02:13:44 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v16 03/11] NFSD: Add lm_lock_expired call out
Date:   Fri, 11 Mar 2022 18:13:27 -0800
Message-Id: <1647051215-2873-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
References: <1647051215-2873-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: da4MgeTcuShorU52jRrTTB57iloxtXGL
X-Proofpoint-ORIG-GUID: da4MgeTcuShorU52jRrTTB57iloxtXGL
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

