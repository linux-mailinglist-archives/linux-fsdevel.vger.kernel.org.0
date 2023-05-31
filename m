Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BFC7173D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 04:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjEaCfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 22:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjEaCf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 22:35:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A80123;
        Tue, 30 May 2023 19:35:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UNOgXq015320;
        Wed, 31 May 2023 02:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=J/dLiyzOlqOVO3IWRV52xWq8Kl3J1LMJAHb4zxE2SxI=;
 b=b/udPmEb8Mr4B1l3J5Ar4A01XFauaIdAmBvsnqz5oarMcPuw2nIe6bAuGzZzpOstsZJ/
 98LVX2bEak0hRh75i1YgCVFf9302dkQht6vdIJK5sb6zV6HOLEmXa8FjdOp8cs6qt+Gr
 E25U1awf0ffGH8mOJCd+ur+9beL9KkEEbmpKRcCmCU3nWOF8FGNa7ZLF3zj+y7rRZMEk
 gZGQcmBJl5W58Sr0kriTXqcSPPqHOvTK1eMDiBp3eG7qSB9X/JthS6d+uUNjdgmYeaJp
 VSclxYOZIE45pbOh8oBQe/3s4rgPvIvVq6KGvLQmod3GUXviUWpy/hGm36cqa2wJSUss OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4vfr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 02:35:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34V07Cc8000380;
        Wed, 31 May 2023 02:35:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8q99hu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 02:35:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34V2TtqZ012906;
        Wed, 31 May 2023 02:35:21 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qu8q99hsx-3;
        Wed, 31 May 2023 02:35:21 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/2] NFSD: add counter for write delegation recall due to conflict with GETATTR
Date:   Tue, 30 May 2023 19:35:07 -0700
Message-Id: <1685500507-23598-3-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-GUID: xMXQOQwd2makauZuOtD8QRpHd-A_1eBz
X-Proofpoint-ORIG-GUID: xMXQOQwd2makauZuOtD8QRpHd-A_1eBz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add counter to keep track of how many times write delegations are
recalled due to conflict with GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/stats.c     | 2 ++
 fs/nfsd/stats.h     | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 29ed2e72b665..cba27dfa39e8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8402,6 +8402,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 			}
 break_lease:
 			spin_unlock(&ctx->flc_lock);
+			nfsd_stats_wdeleg_getattr_inc();
 			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 			if (status != nfserr_jukebox ||
 					!nfsd_wait_for_delegreturn(rqstp, inode))
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 777e24e5da33..63797635e1c3 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -65,6 +65,8 @@ static int nfsd_show(struct seq_file *seq, void *v)
 		seq_printf(seq, " %lld",
 			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
 	}
+	seq_printf(seq, "\nwdeleg_getattr %lld",
+		percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]));
 
 	seq_putc(seq, '\n');
 #endif
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b43dc3d9991..cf5524e7ca06 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -22,6 +22,7 @@ enum {
 	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
 	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
 #define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
+	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
 #endif
 	NFSD_STATS_COUNTERS_NUM
 };
@@ -93,4 +94,10 @@ static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
 }
 
+#ifdef CONFIG_NFSD_V4
+static inline void nfsd_stats_wdeleg_getattr_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
+}
+#endif
 #endif /* _NFSD_STATS_H */
-- 
2.9.5

