Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149870CF07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjEWAYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjEVX4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 19:56:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7650C2126;
        Mon, 22 May 2023 16:52:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOFns005241;
        Mon, 22 May 2023 23:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=Pk8rzW+XOVceUfl6DCh1Zu8VDbfNL5h8e1WbOlF9v2w=;
 b=q/PIlv7DnTKkXIl98ynzG57KKc9SdmLIcXeWPsY4hSxRET5vljoX0oCq+nrx+vItHXag
 CNgOZb0WW0C7zt5cfq2vLDakI+HeSJ64uIilcaG+VRSmYzA62ZzIgE5ZaEuYB5ItYZxi
 sWHyTjglcjKOe0WTUeEu1yx+A2tmoZaAax4sq0GmN8+P+9+LuTnvQA4BKgglCSMVUZsA
 w9QPng9LJiKojLA1XimKfHM5nm2Kj2mFGb8Z++ymiGuzWtNjJmjYgRWPj7bLAx0Buu+H
 Z5fRvOj2wB/kzZ4EaMnFV6fak1iykbi/F0/wkVMePXZm/3EDXMn/hwyOZK/KFs9FnGst ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtkvhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLdVZ7013286;
        Mon, 22 May 2023 23:52:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7e43vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MNqqgx018982;
        Mon, 22 May 2023 23:52:53 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qqk7e43vc-2;
        Mon, 22 May 2023 23:52:53 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 1/3] NFSD: enable support for write delegation
Date:   Mon, 22 May 2023 16:52:38 -0700
Message-Id: <1684799560-31663-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220201
X-Proofpoint-GUID: -qSzO1clrFQ8hajhc3LjBunfTlhIb3ex
X-Proofpoint-ORIG-GUID: -qSzO1clrFQ8hajhc3LjBunfTlhIb3ex
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
if there is no conflict with other OPENs.

Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
are handled the same as read delegation using notify_change,
try_break_deleg.

Add trace point to track whether read or write delegation is granted.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 28 +++++++++++++++++++---------
 fs/nfsd/trace.h     |  1 +
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6e61fa3acaf1..b90b74a5e66e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
 
 static struct nfs4_delegation *
 alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
-		 struct nfs4_clnt_odstate *odstate)
+		struct nfs4_clnt_odstate *odstate, u32 dl_type)
 {
 	struct nfs4_delegation *dp;
 	long n;
@@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	INIT_LIST_HEAD(&dp->dl_recall_lru);
 	dp->dl_clnt_odstate = odstate;
 	get_clnt_odstate(odstate);
-	dp->dl_type = NFS4_OPEN_DELEGATE_READ;
+	dp->dl_type = dl_type;
 	dp->dl_retries = 1;
 	dp->dl_recalled = false;
 	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
@@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct nfs4_delegation *dp;
 	struct nfsd_file *nf;
 	struct file_lock *fl;
+	u32 dl_type;
 
 	/*
 	 * The fi_had_conflict and nfs_get_existing_delegation checks
@@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		return ERR_PTR(-EAGAIN);
 
-	nf = find_readable_file(fp);
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		nf = find_writeable_file(fp);
+		dl_type = NFS4_OPEN_DELEGATE_WRITE;
+	} else {
+		nf = find_readable_file(fp);
+		dl_type = NFS4_OPEN_DELEGATE_READ;
+	}
 	if (!nf) {
 		/*
 		 * We probably could attempt another open and get a read
@@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		return ERR_PTR(status);
 
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, odstate);
+	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
+	fl = nfs4_alloc_init_lease(dp, dl_type);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -5590,8 +5597,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		case NFS4_OPEN_CLAIM_PREVIOUS:
 			if (!cb_up)
 				open->op_recall = 1;
-			if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
-				goto out_no_deleg;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
 			parent = currentfh;
@@ -5616,8 +5621,13 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
-	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
-	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
+		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
+	} else {
+		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
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

