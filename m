Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F6070CF14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjEWAYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjEVX4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 19:56:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E821E2127;
        Mon, 22 May 2023 16:52:58 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOJIX021162;
        Mon, 22 May 2023 23:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=NUHXx4ezbWH8V+5Y+D7uOx7uQf5Aay0LA6R3wk1M550=;
 b=VoZ3v+lW3wi1BNmK1pzlrCkMV778LyB99mkovKsvIfoImpyJblbYgWajiWsh6lcBayWQ
 +5HUGlSgao9oprV4wxigSLi7jfC/hMpFA+dFIkZnz1WKy/KxW+QWfGrneKJZtcl+LnbE
 Q/oJzwh0CYlBGAalUGDtArG9Z6ONScpNgIeVd3GT0OotSGIjrk4KP63agX6GP7I+tOM9
 P5jQTAouiOeK9spqYQRwmmLtNH0TdJgpCKxOYXUfqczgoY6gNPNsBW0BnosqYDGYkj8O
 3NiRNQ+ePfHYEjbVhZ5gZErmucY1booty+J58Q1TmvRK/nWHsDGaoHZ1HLJocerZ8tb4 Mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bkw1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLpt9a012958;
        Mon, 22 May 2023 23:52:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7e43w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 23:52:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MNqqh1018982;
        Mon, 22 May 2023 23:52:53 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qqk7e43vc-3;
        Mon, 22 May 2023 23:52:53 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write delegation
Date:   Mon, 22 May 2023 16:52:39 -0700
Message-Id: <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-GUID: NXnbb_Hmsvaai1XqNx7OWM6pNm6COqOg
X-Proofpoint-ORIG-GUID: NXnbb_Hmsvaai1XqNx7OWM6pNm6COqOg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   |  5 +++++
 fs/nfsd/state.h     |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b90b74a5e66e..ea9cd781db5f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8353,3 +8353,40 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 {
 	get_stateid(cstate, &u->write.wr_stateid);
 }
+
+__be32
+nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)
+{
+	struct file_lock_context *ctx;
+	struct file_lock *fl;
+	struct nfs4_delegation *dp;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return 0;
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+		if (fl->fl_flags == FL_LAYOUT ||
+				fl->fl_lmops != &nfsd_lease_mng_ops)
+			continue;
+		if (fl->fl_type == F_WRLCK) {
+			dp = fl->fl_owner;
+			/*
+			 * increment the sc_count to prevent the delegation to
+			 * be freed while sending the CB_RECALL. The refcount is
+			 * decremented by nfs4_put_stid in nfsd4_cb_recall_release
+			 * after the request was sent.
+			 */
+			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker) ||
+					!refcount_inc_not_zero(&dp->dl_stid.sc_count)) {
+				spin_unlock(&ctx->flc_lock);
+				return 0;
+			}
+			spin_unlock(&ctx->flc_lock);
+			return nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+		}
+		break;
+	}
+	spin_unlock(&ctx->flc_lock);
+	return 0;
+}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 76db2fe29624..ed09b575afac 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d49d3060ed4f..64727a39f0db 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
 	return clp->cl_state == NFSD4_EXPIRABLE;
 }
+
+extern __be32 nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp,
+				struct inode *inode);
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

