Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42170AB1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjETVhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETVg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 17:36:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01EE9;
        Sat, 20 May 2023 14:36:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34KKdAFZ011730;
        Sat, 20 May 2023 21:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=EWy6VJgb5xir2ErseDocHeoaNrVmvy3UgcI/JF4Nfyk=;
 b=FmncQSXkhKKTaM/6EOp6JBwZPGEvNvhQquy94Pjh0cGwV7F41Ne3QU+KB97Xd8mNTlcY
 fiNG7JBsgSDFI1aGTssBn9HE75pThHg1pOdVuJTzFmulJ86F38FqRl0BtdUaMTftrId4
 +LRJMHRDQY5oEMiExb7c1wPy4pzJ2DfOqSsr4qoKZ0WvIv+HH/Wba+kJq+u8xTmK9R0u
 fdOM9mBrsvkpm4t1spiotReT1wn/ZLRui/ZKvJCEwnrTicBHqJLt7bw1Fshsu5GIA0nK
 JEodnyXYdf9oj8E0QrGvSMmlnhsIYJPpZCz8fhsMeAJcy0LPq1XKJ9GmuD+cUg+Aj/TQ TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mgnkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 May 2023 21:36:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34KGsZSq011287;
        Sat, 20 May 2023 21:36:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qpmn82h4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 May 2023 21:36:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34KLajTt030297;
        Sat, 20 May 2023 21:36:49 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qpmn82h46-5;
        Sat, 20 May 2023 21:36:49 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 4/4] NFSD: add trace point to track when write delegation is granted
Date:   Sat, 20 May 2023 14:36:35 -0700
Message-Id: <1684618595-4178-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-20_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305200192
X-Proofpoint-ORIG-GUID: GNyCzlPfkmGviDwsoMnrRaYQVUUiVGKI
X-Proofpoint-GUID: GNyCzlPfkmGviDwsoMnrRaYQVUUiVGKI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add trace point to track whether read or write delegation is granted.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 8 +++++---
 fs/nfsd/trace.h     | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3f98b7485c72..b90b74a5e66e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5621,11 +5621,13 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
-	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
-	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE)
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
-	else
+		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
+	} else {
 		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
+		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
+	}
 	nfs4_put_stid(&dp->dl_stid);
 	return;
 out_no_deleg:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4183819ea082..a14cf8684255 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -607,6 +607,7 @@ DEFINE_STATEID_EVENT(layout_recall_release);
 
 DEFINE_STATEID_EVENT(open);
 DEFINE_STATEID_EVENT(deleg_read);
+DEFINE_STATEID_EVENT(deleg_write);
 DEFINE_STATEID_EVENT(deleg_return);
 DEFINE_STATEID_EVENT(deleg_recall);
 
-- 
2.9.5

