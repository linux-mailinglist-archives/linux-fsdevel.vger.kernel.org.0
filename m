Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109BF717BD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 11:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjEaJ0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEaJ0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 05:26:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49D97;
        Wed, 31 May 2023 02:26:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V94Yqt017855;
        Wed, 31 May 2023 09:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=BXj7Kiy3r/4ROGAvCQJiJz+56vxscyzDPBqDmm7TooE=;
 b=X1ehLk9Tvs/YkD/fJiNaSG71g4bl9Nfj7EVMasphcUwD/9IKj/UciBabDhOJZt5QH3PI
 UBlqjYbFcjzjCEVFmixMQ40K2JcTIV/KdtjFp6CWVhnvvyy5mhWPksCB+On2u0puzkwj
 MrM7bld3kAMqCO+aYD3JvHOZdLWBAV76NWvSInukfdotFOdZyv7RgoYNJmKaMPyNj0ww
 MTw1Qm2SaLjvYmHXiVX3xjHzyftvHxOKJWONysiKUEjfVZ0vXieUDccDzOeLnGChHqOO
 amE4zun1w/a/jzsquBo5sZVizumOdpq9kCn6Z1m/zLqY0sD6E0TE2Guqd7c2KKmFG470 7A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx39d01hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 09:26:49 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34V9Qjx5030339;
        Wed, 31 May 2023 09:26:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3quaxkdeh9-1;
        Wed, 31 May 2023 09:26:45 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34V9QjOw030334;
        Wed, 31 May 2023 09:26:45 GMT
Received: from hyd-e160-a01-1-05.qualcomm.com (hyd-e160-a01-1-05.qualcomm.com [10.147.154.233])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34V9Qj3x030333;
        Wed, 31 May 2023 09:26:45 +0000
Received: by hyd-e160-a01-1-05.qualcomm.com (Postfix, from userid 2304101)
        id 781858CE2; Wed, 31 May 2023 14:56:44 +0530 (IST)
From:   Pradeep P V K <quic_pragalla@quicinc.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pradeep P V K <quic_pragalla@quicinc.com>
Subject: [PATCH V1] fuse: Abort the requests under processing queue with a spin_lock
Date:   Wed, 31 May 2023 14:56:43 +0530
Message-Id: <20230531092643.45607-1-quic_pragalla@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3yDbiAOHTv5FO89O1iB6xkSAKTPvg33D
X-Proofpoint-ORIG-GUID: 3yDbiAOHTv5FO89O1iB6xkSAKTPvg33D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_05,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxlogscore=534 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310081
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a potential race/timing issue while aborting the
requests on processing list between fuse_dev_release() and
fuse_abort_conn(). This is resulting into below warnings
and can even result into UAF issues.

[22809.190255][T31644] refcount_t: underflow; use-after-free.
[22809.190266][T31644] WARNING: CPU: 2 PID: 31644 at lib/refcount.c:28
refcount_warn_saturate+0x110/0x158
...
[22809.190567][T31644] Call trace:
[22809.190567][T31644]  refcount_warn_saturate+0x110/0x158
[22809.190569][T31644]  fuse_file_put+0xfc/0x104
[22809.190575][T31644]  fuse_readpages_end+0x210/0x29c
[22809.190579][T31644]  fuse_request_end+0x17c/0x200
[22809.190580][T31644]  fuse_dev_release+0xe0/0x1e4
[22809.190582][T31644]  __fput+0xfc/0x294
[22809.190588][T31644]  ____fput+0x18/0x2c
[22809.190590][T31644]  task_work_run+0xd8/0x104
[22809.190599][T31644]  do_exit+0x2a8/0xa5c
[22809.190605][T31644]  do_group_exit+0x78/0xa4
[22809.190608][T31644]  get_signal+0x778/0x8a8
[22809.190614][T31644]  do_notify_resume+0x134/0x340
[22809.190617][T31644]  el0_svc+0x68/0xc4
[22809.190623][T31644]  el0t_64_sync_handler+0x8c/0xfc
[22809.190626][T31644]  el0t_64_sync+0x1a0/0x1a4

Fix this by aborting the requests in fuse_dev_release()
under fpq spin lock.

Signed-off-by: Pradeep P V K <quic_pragalla@quicinc.com>
---
 fs/fuse/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..bbc33a97ab7c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2208,9 +2208,8 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		WARN_ON(!list_empty(&fpq->io));
 		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
 			list_splice_init(&fpq->processing[i], &to_end);
-		spin_unlock(&fpq->lock);
-
 		end_requests(&to_end);
+		spin_unlock(&fpq->lock);
 
 		/* Are we the last open device? */
 		if (atomic_dec_and_test(&fc->dev_count)) {
-- 
2.17.1

