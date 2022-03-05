Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDED4CE19B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiCEAiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiCEAiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE941990;
        Fri,  4 Mar 2022 16:37:26 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224K7ROR012006;
        Sat, 5 Mar 2022 00:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=sZv4LYibBFzq0kYLdFmObVhZgZO2pceasMSCWTjkyjw=;
 b=bApf098vnamBla0628WKtM+GTVClhHz+/yluS8tkvxN3YP29EjcBOHUIf/j+P5cFrP8p
 EA3jbUJYZeHhlzXOGHegz+6u/xCBgLjty5aAAFSP2MRYKT1sSzk57OkQTuPdNmYuDDDg
 6onIG7MGrjXxB9rXA7kPFcIJoUGVqj85vDs7U26n+VjjkA2qB4KFUk+PXBHmU1QZm1ut
 UiugqUAd+JkrYQPqGRadN/pIhA9JA74jOFQwB8AAjONmG4NMfiRQkEE4SFzYBqlwM7NX
 neBK5jkk0wKaae+4rAP1kp3oXfSulpVd7u11LDAqFEZb7TJ0f4aNUX8V4L+5yjz+BTAR Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvk5eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250Pwx9146603;
        Sat, 5 Mar 2022 00:37:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:22 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaL161402;
        Sat, 5 Mar 2022 00:37:22 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-5;
        Sat, 05 Mar 2022 00:37:22 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 04/11] NFSD: Update nfsd_breaker_owns_lease() to handle courtesy clients
Date:   Fri,  4 Mar 2022 16:37:06 -0800
Message-Id: <1646440633-3542-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: rHjRI8r8b0gDwL8-ryjgxRT92GLB5dQK
X-Proofpoint-GUID: rHjRI8r8b0gDwL8-ryjgxRT92GLB5dQK
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update nfsd_breaker_owns_lease() to handle delegation conflict
with courtesy clients. If conflict was caused courtesy client
then discard the courtesy client by setting CLIENT_EXPIRED and
return conflict resolved. Client with CLIENT_EXPIRED is expired
by the laundromat.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 583ac807e98d..40a357fd1a14 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4727,6 +4727,24 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	clp = dl->dl_stid.sc_client;
+	/*
+	 * need to sync with courtesy client trying to reconnect using
+	 * the cl_cs_lock, nn->client_lock can not be used since this
+	 * function is called with the fl_lck held.
+	 */
+	spin_lock(&clp->cl_cs_lock);
+	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+
 	if (!i_am_nfsd())
 		return false;
 	rqst = kthread_data(current);
-- 
2.9.5

