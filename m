Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D167173D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 04:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjEaCfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 22:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjEaCfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 22:35:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C58121;
        Tue, 30 May 2023 19:35:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UNOILU018182;
        Wed, 31 May 2023 02:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=iK2oKZjx+o3544QS3nk8uOV21ANLfxk4JBE7RO45JfI=;
 b=3I8IJpuFgskzZjpvK4OAW0bNV7wsU6pDo901DPj6hiReDwnL5L5FTCUNplKmn2F+Sid3
 kunRBiTi8iqaMRM4qz43NA5bHYoIMbroWfKQqecXu6WuwkqMFEsqkkxJQtePW/EdP4KA
 3Oz52T/ghlYsqC1NboB5orjbu5xKDSrLBJJGsHxjUhw6v6qwDznl+4DtxL7pPJWU5XMM
 QphxaKnUjPSGt3ADxS5ucf1v+Ee2BkG9fj95OcT5w7KG2E0h+NKgX1Eq+5UrfZUXbMJS
 m8FKm0IDru3yL3VwkYDTG7DOrPANsXgaS+xd9rnywhbhSq35pX6ssxIdFbLT3M/rN/L9 /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwce2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 02:35:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UNTthI000321;
        Wed, 31 May 2023 02:35:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8q99hts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 02:35:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34V2TtqX012906;
        Wed, 31 May 2023 02:35:20 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qu8q99hsx-2;
        Wed, 31 May 2023 02:35:20 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/2] NFSD: handle GETATTR conflict with write delegation
Date:   Tue, 30 May 2023 19:35:06 -0700
Message-Id: <1685500507-23598-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
References: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310019
X-Proofpoint-ORIG-GUID: wf0siu5_Pvtv11t8qJeG4yGS-qd6V0ii
X-Proofpoint-GUID: wf0siu5_Pvtv11t8qJeG4yGS-qd6V0ii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the GETATTR request on a file that has write delegation in effect
and the request attributes include the change info and size attribute
then the write delegation is recalled. If the delegation is returned
within 30ms then the GETATTR is serviced as normal otherwise the
NFS4ERR_DELAY error is returned for the GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   |  5 +++++
 fs/nfsd/state.h     |  3 +++
 3 files changed, 68 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b90b74a5e66e..fea78d90ecf7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8353,3 +8353,63 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 {
 	get_stateid(cstate, &u->write.wr_stateid);
 }
+
+/**
+ * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
+ * @rqstp: RPC transaction context
+ * @inode: file to be checked for a conflict
+ *
+ * This function is called when there is a conflict between a write
+ * delegation and a change/size GETATR from another client. The server
+ * must either use the CB_GETATTR to get the current values of the
+ * attributes from the client that hold the delegation or recall the
+ * delegation before replying to the GETATTR. See RFC 8881 section
+ * 18.7.4.
+ *
+ * Returns 0 if there is no conflict; otherwise an nfs_stat
+ * code is returned.
+ */
+__be32
+nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
+{
+	__be32 status;
+	struct file_lock_context *ctx;
+	struct file_lock *fl;
+	struct nfs4_delegation *dp;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return 0;
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+		if (fl->fl_flags == FL_LAYOUT)
+			continue;
+		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
+			/*
+			 * non-nfs lease, if it's a lease with F_RDLCK then
+			 * we are done; there isn't any write delegation
+			 * on this inode
+			 */
+			if (fl->fl_type == F_RDLCK)
+				break;
+			goto break_lease;
+		}
+		if (fl->fl_type == F_WRLCK) {
+			dp = fl->fl_owner;
+			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
+				spin_unlock(&ctx->flc_lock);
+				return 0;
+			}
+break_lease:
+			spin_unlock(&ctx->flc_lock);
+			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+			if (status != nfserr_jukebox ||
+					!nfsd_wait_for_delegreturn(rqstp, inode))
+				return status;
+			return 0;
+		}
+		break;
+	}
+	spin_unlock(&ctx->flc_lock);
+	return 0;
+}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b83954fc57e3..4590b893dbc8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (status)
 			goto out;
 	}
+	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
+		if (status)
+			goto out;
+	}
 
 	err = vfs_getattr(&path, &stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d49d3060ed4f..cbddcf484dba 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
 	return clp->cl_state == NFSD4_EXPIRABLE;
 }
+
+extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
+				struct inode *inode);
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

