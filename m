Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A9F5ACC56
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiIEHWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiIEHVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:21:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128743E6C;
        Mon,  5 Sep 2022 00:17:53 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28579MxE014670;
        Mon, 5 Sep 2022 07:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=ex4xX9XfdG8q4J9ida3IVOdGi65E2yi+3EIwfXfaLLQ=;
 b=ZpxOic5MohHcJw+QqjfqbXLSpKNRVtCtQo3n3t3TW4T2ybUy7MoSqKzVV8KfPhljf/uC
 8B7kHGw8ACWthkSIV2VCN2jL3bH/F7jxHtKqa/dczTiLl1NsS0udQqPRB4Xe3+g574do
 TPx4U+h00jStDZqJsPJAFFFJ/kvt//p/Fb8JshJR+0rbRxbocvh1NAMiC1Z164HDhMnz
 ooa2SjbuxyHB19W+ZwX6pijlxA9s5E3Raib2MauFd16HbPMlntQI73pUYsAwR8wa1cc+
 rsGkdNclMxWBT5R+O7X0JnRZoasUrZ9Q4TGCvfYrdNelIcY3/wxXEpL4ZIcjFiBpzwF1 6g== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbypmkd14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 07:17:51 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2857Hl83020975;
        Mon, 5 Sep 2022 07:17:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3jc00ndyt3-1;
        Mon, 05 Sep 2022 07:17:47 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2857HlZx020966;
        Mon, 5 Sep 2022 07:17:47 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 2857HkfW020964;
        Mon, 05 Sep 2022 07:17:47 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 519DD2102E38; Mon,  5 Sep 2022 15:17:45 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, quic_maow@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: fix the deadlock in race of reclaim path with kswapd
Date:   Mon,  5 Sep 2022 15:17:44 +0800
Message-Id: <20220905071744.8350-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7ur43WgbJS1G_aJxSf8daCtddNbyNJvi
X-Proofpoint-GUID: 7ur43WgbJS1G_aJxSf8daCtddNbyNJvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=644
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050035
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Task A wait for writeback, while writeback Task B send request to fuse.
Task C is expected to serve this request, here it is in direct reclaim
path cause deadlock when system is in low memory.

without __GFP_FS in Task_C break throttle_direct_reclaim with an
HZ timeout.

kswpad (Task_A):                    writeback(Task_B):
    __switch_to+0x14c			schedule+0x70
    __schedule+0xb5c			__fuse_request_send+0x154
    schedule+0x70			fuse_simple_request+0x184
    bit_wait+0x18			fuse_flush_times+0x114
    __wait_on_bit+0x74			fuse_write_inode+0x60
    inode_wait_for_writeback+0xa4	__writeback_single_inode+0x3d8
    evict+0xa8				writeback_sb_inodes+0x4c0
    iput+0x248				__writeback_inodes_wb+0xb0
    dentry_unlink_inode+0xdc		wb_writeback+0x270
    __dentry_kill[jt]+0x110		wb_workfn+0x37c
    shrink_dentry_list+0x17c		process_one_work+0x284
    prune_dcache_sb+0x5c
    super_cache_scan+0x11c
    do_shrink_slab+0x248
    shrink_slab+0x260
    shrink_node+0x678
    kswapd+0x8ec
    kthread+0x140
    ret_from_fork+0x10

Task_C:
    __switch_to+0x14c
    __schedule+0xb5c
    schedule+0x70
    throttle_direct_reclaim
    try_to_free_pages
    __perform_reclaim
    __alloc_pages_direct_reclaim
    __alloc_pages_slowpath
    __alloc_pages_nodemask
    alloc_pages
    fuse_copy_fill+0x168
    fuse_dev_do_read+0x37c
    fuse_dev_splice_read+0x94

Suggested-by: Wang Mao <quic_maow@quicinc.com>
Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51897427a534..0df7234840c3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -713,7 +713,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
-			page = alloc_page(GFP_HIGHUSER);
+			page = alloc_page(GFP_HIGHUSER & ~__GFP_FS);
 			if (!page)
 				return -ENOMEM;
 
-- 
2.17.1

