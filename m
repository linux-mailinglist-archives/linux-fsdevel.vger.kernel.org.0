Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDC770AB19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 23:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjETVhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjETVg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 17:36:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3934EA;
        Sat, 20 May 2023 14:36:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34KKnhGx009887;
        Sat, 20 May 2023 21:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=0/Jnenzmn8aVSUuTnz6Fptl+6U11GhzKCLrxvjWJiJs=;
 b=rtV9BZxGmGBw53tG1q7KTFc7sBO+WJlHf182cRNbFi8z1DBv8YO5nXR8LM7kfFX9Mmmx
 Vk6poWk1cfZY96gvhh5vLmo9j+6BdbOkf+JeP90gfn/2iYbUBDk8EGCJgSevd9xgckAE
 fYFtnBqwTU0WE4PLksA1+I1iMQpRCF8FNRmmWjbm+gaHInzeM1qpfcjJ7bC3adQJyb88
 eS8dleN80YZg0WCTYsoeRZQpvYXE5GI7MsfWy/OaBOZ9lhV/eozxgq7DqydqEzC3w6ef
 OU8FCKGrTJx/NI2Z3bc2qyZ58qjBz2MB8SDL+4VlHHhUkqorkfKjWw8dS2UutL74nxPL Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtgmwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 May 2023 21:36:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34KG50BA011202;
        Sat, 20 May 2023 21:36:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qpmn82h4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 May 2023 21:36:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34KLajTr030297;
        Sat, 20 May 2023 21:36:48 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qpmn82h46-4;
        Sat, 20 May 2023 21:36:48 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write delegation
Date:   Sat, 20 May 2023 14:36:34 -0700
Message-Id: <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-GUID: 0gUcjjLkro3NSjIPEM6XLcqj4CGH6W24
X-Proofpoint-ORIG-GUID: 0gUcjjLkro3NSjIPEM6XLcqj4CGH6W24
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the GETATTR request on a file that has write delegation in effect
and the request attributes include the change info and size attribute
then the write delegation is recalled and NFS4ERR_DELAY is returned
for the GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 76db2fe29624..e069b970f136 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 	return nfserr_resource;
 }
 
+static struct file_lock *
+nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
+{
+	struct file_lock_context *ctx;
+	struct file_lock *fl;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return NULL;
+	spin_lock(&ctx->flc_lock);
+	if (!list_empty(&ctx->flc_lease)) {
+		fl = list_first_entry(&ctx->flc_lease,
+					struct file_lock, fl_list);
+		if (fl->fl_type == F_WRLCK) {
+			spin_unlock(&ctx->flc_lock);
+			return fl;
+		}
+	}
+	spin_unlock(&ctx->flc_lock);
+	return NULL;
+}
+
+static __be32
+nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)
+{
+	__be32 status;
+	struct file_lock *fl;
+	struct nfs4_delegation *dp;
+
+	fl = nfs4_wrdeleg_filelock(rqstp, inode);
+	if (!fl)
+		return 0;
+	dp = fl->fl_owner;
+	if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
+		return 0;
+	refcount_inc(&dp->dl_stid.sc_count);
+	status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+	return status;
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (status)
 			goto out;
 	}
+	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
+		if (status)
+			goto out;
+	}
 
 	err = vfs_getattr(&path, &stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
-- 
2.9.5

