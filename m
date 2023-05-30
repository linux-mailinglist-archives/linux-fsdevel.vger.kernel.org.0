Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D417155B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjE3Gwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 02:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjE3Gwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 02:52:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A395F4;
        Mon, 29 May 2023 23:52:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U5l5bq009109;
        Tue, 30 May 2023 06:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=OzC3wCMvVdENDIFYqf52Xb5UHjMx8xErnDKv8mVKbJU=;
 b=NeW9lEA4+g3d9rfjnCBq/xRo2hJszkClwCm55q1HFj1wKH4lq0L07PWwPbJXwFAK/ggb
 0jXUqj90ao0e73d9YYQ12X4agVlXnyHASzYTOUGoP0hyITsuvVxMJpidLhEfl7qQqblv
 U60iUN40qQor92udAQuVGB+nQBrDQK+cXYotF70EIBDgMQxv1PvlEu28TZBCxy8Vf7sZ
 mgVzXDE3Ukm9utyuGthGkxvVfE4Zgff4CPvNYWTEtQM15S9H0aYxnBle5pMdAZesiEir
 YwfwYM/u8DUyUb4S/31nVPU6AkXVB7h7MEEdOrLwfosugsLAkeDasYdsSYVmFF6P2KmG QA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb920rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 06:52:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34U6lgrR000353;
        Tue, 30 May 2023 06:52:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8q7ueam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 06:52:34 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34U6qWos004059;
        Tue, 30 May 2023 06:52:34 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qu8q7ue9a-3;
        Tue, 30 May 2023 06:52:34 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: add counter for write delegation recall due to conflict with GETATTR
Date:   Mon, 29 May 2023 23:52:17 -0700
Message-Id: <1685429537-11855-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1685429537-11855-1-git-send-email-dai.ngo@oracle.com>
References: <1685429537-11855-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_04,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300056
X-Proofpoint-GUID: 747oH_Zhmt_-7GfLJNfv7DD7ZcpJK0HK
X-Proofpoint-ORIG-GUID: 747oH_Zhmt_-7GfLJNfv7DD7ZcpJK0HK
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
index 7826483e8421..829c68841d7d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8392,6 +8392,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 				return 0;
 			}
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

