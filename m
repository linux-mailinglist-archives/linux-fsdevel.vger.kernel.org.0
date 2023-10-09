Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2E7BD77C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjJIJqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345608AbjJIJqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:46:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7548F;
        Mon,  9 Oct 2023 02:46:42 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3997oubK021800;
        Mon, 9 Oct 2023 02:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=gbKq1gtSDc+O2vuPRtkIcpNC6/iJ+SOTe8Xsyqj7Jms=; b=
        ljCMD14xhKF/hicNBrq1JAJ9hrqpWq/3njuUvQCEc+uG9Mn7AZh8gcsE6d8ehU8Q
        UrOQpUvrHPZoJCsaY9LiDBF2xdRBbVe7Gojix8KoLue3YlDYKbxb4fpIMagdP75I
        1xAQ89mVDsTRHu5pz4I8L8hFX40SnS7fI++cvwFDVN7U1L7WeTPE9sDyeAWQP/x1
        c2DEYNQ+GgPIJn4QOTe7A2Z9VYQEEXnqqTNe9RDPCh6Jwp36QHnnz+/nyHNSnJfK
        8WFk8/GTkgyC6rDGNBfkk6EBt7LgcqRjU/9Qf9JS2o4Tfq2NWVFS3udteo6zAoui
        5Nlf0cNhI4i2fiEBHv0zhA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tk2m0he20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Oct 2023 02:46:02 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 02:46:01 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 02:45:58 -0700
From:   Lizhi Xu <lizhi.xu@windriver.com>
To:     <syzbot+23bc20037854bb335d59@syzkaller.appspotmail.com>
CC:     <axboe@kernel.dk>, <brauner@kernel.org>,
        <dave.kleikamp@oracle.com>, <hare@suse.de>, <hch@lst.de>,
        <jack@suse.cz>, <jfs-discussion@lists.sourceforge.net>,
        <johannes.thumshirn@wdc.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shaggy@kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] jfs: fix log->bdev_handle null ptr deref in lbmStartIO
Date:   Mon, 9 Oct 2023 17:45:57 +0800
Message-ID: <20231009094557.1398920-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000005239cf060727d3f6@google.com>
References: <0000000000005239cf060727d3f6@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tFDM0zeFcUxp2M-7km3gquoA9XDeWls_
X-Proofpoint-ORIG-GUID: tFDM0zeFcUxp2M-7km3gquoA9XDeWls_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_08,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 bulkscore=0 mlxlogscore=716 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310090080
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When sbi->flag is JFS_NOINTEGRITY in lmLogOpen(), log->bdev_handle can't
be inited, so it value will be NULL.
Therefore, add the "log ->no_integrity=1" judgment in lbmStartIO() to avoid such
problems.

Reported-and-tested-by: syzbot+23bc20037854bb335d59@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/jfs/jfs_logmgr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index c911d838b8ec..c41a76164f84 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2110,10 +2110,14 @@ static void lbmStartIO(struct lbuf * bp)
 {
 	struct bio *bio;
 	struct jfs_log *log = bp->l_log;
+	struct block_device *bdev = NULL;
 
 	jfs_info("lbmStartIO");
 
-	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_WRITE | REQ_SYNC,
+	if (!log->no_integrity) 
+		bdev = log->bdev_handle->bdev;	
+
+	bio = bio_alloc(bdev, 1, REQ_OP_WRITE | REQ_SYNC,
 			GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
 	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
-- 
2.25.1

