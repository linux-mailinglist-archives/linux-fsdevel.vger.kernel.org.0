Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027207020C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 02:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbjEOAVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjEOAVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 20:21:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47010FB;
        Sun, 14 May 2023 17:21:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34EMwVhg032372;
        Mon, 15 May 2023 00:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=13yFsu/hc2QefBrXwXw9AQoe32PXPPNvjMgyb8bREfE=;
 b=SJnrpZLYTG0Xtg+guMC4qD/S1/TNvjB67209xDZ/mQq1x0Wn2JqxYSyqwrFc+w2d3Qel
 IKTnWKAsQtrNYLhpjyZh1zl/Wf72aoDjyiNszcupC/q+h4Xa92CcCn5tKzNIUJ735kge
 JdKBgRHNXV69iuIiObx6vVHAL3jVt0lTX7lWM7vKiz797f+9uzHag1bTB2z3LBT7NUth
 uF51mwFZwIFm93wFk1zVpuGpLIh/52VkgRiST5PeDksoXdcEqiGG3HS6FQD169WaqG8h
 VPl5W4YDgUNbkIZNz5gzoCsvb4sui7ptZIp6uCVSz1agi5fGOqsVPrYqotx3Pb9jow1p EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25tx0wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 00:20:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ENh2ec033181;
        Mon, 15 May 2023 00:20:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107ymt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 00:20:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34F0KoeO004448;
        Mon, 15 May 2023 00:20:52 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj107yms7-3;
        Mon, 15 May 2023 00:20:52 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] NFSD: enable support for write delegation
Date:   Sun, 14 May 2023 17:20:36 -0700
Message-Id: <1684110038-11266-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150000
X-Proofpoint-ORIG-GUID: yI9ot7vQadrILzCZ3piZqzsmiGdHK_1o
X-Proofpoint-GUID: yI9ot7vQadrILzCZ3piZqzsmiGdHK_1o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6e61fa3acaf1..09a9e16407f9 100644
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
+	u32 deleg;
 
 	/*
 	 * The fi_had_conflict and nfs_get_existing_delegation checks
@@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (fp->fi_had_conflict)
 		return ERR_PTR(-EAGAIN);
 
-	nf = find_readable_file(fp);
+	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		nf = find_writeable_file(fp);
+		deleg = NFS4_OPEN_DELEGATE_WRITE;
+	} else {
+		nf = find_readable_file(fp);
+		deleg = NFS4_OPEN_DELEGATE_READ;
+	}
 	if (!nf) {
 		/*
 		 * We probably could attempt another open and get a read
@@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		return ERR_PTR(status);
 
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, odstate);
+	dp = alloc_init_deleg(clp, fp, odstate, deleg);
 	if (!dp)
 		goto out_delegees;
 
-	fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
+	fl = nfs4_alloc_init_lease(dp, deleg);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -5583,6 +5590,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	struct svc_fh *parent = NULL;
 	int cb_up;
 	int status = 0;
+	u32 wdeleg = false;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = 0;
@@ -5590,8 +5598,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		case NFS4_OPEN_CLAIM_PREVIOUS:
 			if (!cb_up)
 				open->op_recall = 1;
-			if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
-				goto out_no_deleg;
 			break;
 		case NFS4_OPEN_CLAIM_NULL:
 			parent = currentfh;
@@ -5617,7 +5623,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
-	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
+	wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
+	open->op_delegate_type = wdeleg ?
+			NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
 	nfs4_put_stid(&dp->dl_stid);
 	return;
 out_no_deleg:
-- 
2.9.5

