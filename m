Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF979428F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbjIFR5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243598AbjIFR5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:57:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24251BF4
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:56:17 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230906175454epoutp03abe5360738f37925f491ca9d09f1cba5~CYNj6dXuc1173811738epoutp03q
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230906175454epoutp03abe5360738f37925f491ca9d09f1cba5~CYNj6dXuc1173811738epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022894;
        bh=8oFkb7PK7GQ2zPH27PAgufSfon22139Cy8Y1FXrmwY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCozcn5jDsgPFEg2a9ZxlSftR67Xf+7pSdOTDMcd54kKW23cp7jdF1yobKFgl5N5Q
         ipK9o5dFmzEvu9OkmFySrSlmhag6FNrysbzBQp2lapIjp49t9pT+dY54B3DceBkfrr
         RvPdBGNXiz3+CeNtbA65dfd4Vn9J98NX7mrn9pIg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230906175454epcas5p483de28cee6d9f82f3587eefdad7fd868~CYNjW53Q01892318923epcas5p4b;
        Wed,  6 Sep 2023 17:54:54 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RgqlJ40Wxz4x9Pq; Wed,  6 Sep
        2023 17:54:52 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.04.19094.CECB8F46; Thu,  7 Sep 2023 02:54:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230906164425epcas5p4275f672db2cfe129f666d8c929cbd095~CXQBASmK33062630626epcas5p42;
        Wed,  6 Sep 2023 16:44:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230906164425epsmtrp1b8691dfa3eb0aeb501c8a7fe38dc1785~CXQA-ThoJ0455204552epsmtrp1J;
        Wed,  6 Sep 2023 16:44:25 +0000 (GMT)
X-AuditID: b6c32a50-64fff70000004a96-e3-64f8bcec4df9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.86.08649.96CA8F46; Thu,  7 Sep 2023 01:44:25 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164422epsmtip2fddc6ff2b840387871c20033ad2c4f9f~CXP_RKkz_0127201272epsmtip2i;
        Wed,  6 Sep 2023 16:44:22 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 11/12] null: Enable trace capability for null block
Date:   Wed,  6 Sep 2023 22:08:36 +0530
Message-Id: <20230906163844.18754-12-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRTOe+/t5RYpXgrE1y58WGaydQNaLfWisM2B8yqLkkz8sZhBQ29a
        QmmbfgxBg90QGEwoMAlSQNiodcCAURkiXyKjwDATdRnrqlBNIGaAfIzJFgdoS0H373mec857
        znPeHALlruM8IkOlZ7QqqZKP+2Ld1/cLIhf7H8mEpmke1TExilJnyzdRqnXahFML1+8Danao
        CFADS7Us6u7QNwjV3GpHqMrhKUDN3TYj1IDzAHWx0IJR/QM3MOpWbx1ONVjnfKgvx7YQylE+
        B6juxw0o1b6wjFHjzj3U5OYY60gwPTnTidG3bhpoW0sxTn9l+Yjuu2vE6aayCyy6NH8Jp1fn
        nBi9PHgbp8u6WgC9ZgulbbN/Isl+JzPjFIxUxmjDGVW6Wpahksfzk06kJqTGSISiSFEs9RI/
        XCXNYuL5iceTI49lKN1e+eGnpUqDW0qW6nT86ENxWrVBz4Qr1Dp9PJ/RyJQasSZKJ83SGVTy
        KBWjf1kkFL4Q405My1R8sfgZS+Pkvl9hLGIZweLTJYBNQFIMXWVLaAnwJbhkP4Abha075D6A
        NV3zmJesA9jlqEB2S36v62F5AwMAmhqKfbykAIHWpTZQAggCJw/A7/8hPHoQaUTh1b4m4CEo
        2Y7AGsvPqOepQPJ1+Effio8HY+TzsNv29bbOIV+Bxl+tLM9DkIyGJleAR2a75bNnfgLelAB4
        o2YW82CUDIP512q354ZkERu2ls1j3lETof3Buo8XB8L5sa4dzIP3TIU7OBs2f3oZ9xZ/DKD5
        jhl4A4dhwYQJ9QyBkvthR2+0Vw6BVRPtiLexPyx9PLuzFg7s+XwXR8ArHY24Fz8Lpx6ewb1e
        aLh1M9Mjc8kyAEfuvVMOws1P2DE/Ycf8f+NGgLYAHqPRZcmZ9BiNKFLFZP/3zenqLBvYPgBB
        cg9ovboZNQwQAgwDSKD8IM5S2LqMy5FJc3IZrTpVa1AyumEQ4953BcoLTle7L0ilTxWJY4Vi
        iUQijn1RIuI/w1koqJdxSblUz2QyjIbR7tYhBJtnRKrjI9d/TNELq2I2bEnLzfb8vVJ7lJ+C
        0/ndcKM/4bKItUHxXb+4zj/Ffnc+ezVpazW4In2tOoTfXde8Epcmn6/FTjinqlWXXddyHDnO
        T07dyX07opk4HJdXa7UNTYcMimNBzkbBoCCw31dpTQlcSagx+B0/qP9LvncGX7Gkncsd9xld
        O6nZmImtV85V5BXYJZUTFogcu/Tt5MUPQ2yCt3RNB2eSRRFhH+yzTjykekec9SVvvBpQXM3T
        LuddOT+SkrDYtifRwVYYUkLaUg4lVT0oLQ8YzdA898j/yNRvb0rPtbN+6AwVhrou/U2EOiqP
        vncqyTF+2i5gjgZ39yP7XuNjOoVUJEC1Oum/DsYkgIkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvG7mmh8pBtdaRSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrR4cqCd0WLvu9msFjcP7GSyWLn6KJPFpEPXGC2eXp3FZLH3lrbFwrYlLBZ7
        9p5ksbi8aw6bxfxlT9ktlh//x2RxY8JTRottv+czW6x7/Z7F4sQtaYvzf4+zOoh6nL+3kcXj
        8tlSj02rOtk8Ni+p99h9s4HNY3HfZFaP3uZ3bB4fn95i8Xi/7yqbR9+WVYwenzfJeWx68pYp
        gCeKyyYlNSezLLVI3y6BK2PpmxmsBbeEKiY2tLM2ML7h72Lk5JAQMJF4OGcHaxcjF4eQwG5G
        iev3e9ggEpISy/4eYYawhSVW/nvODlHUzCTR/m0uSxcjBwebgLbE6f8cIHERgS5mic6d71hA
        HGaBHUwSz/+3sYN0Cwu4Szzf/QHMZhFQldi2aTvYVF4Ba4mGO8tYQQZJCOhL9N8XBAlzAoWb
        Gi8ygthCAlYSd1a9ZoQoF5Q4OfMJC4jNLCAv0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc9N
        NiwwzEst1ytOzC0uzUvXS87P3cQIjlAtjR2M9+b/0zvEyMTBeIhRgoNZSYT3nfy3FCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqYaifvcDzvHtVy92nz
        st3WW8K/FsnIZpv5MV1dOTdcbpU8S9Jzb7WoDUZ/NCaITHPUmdh7/l6cbcGazTEJdq9Dz4Y5
        7a43uD9D6PzB5yrhE9ZqM6po8748dO96oen5mTsMGThiqyep7ZzIeP+ceZn9nAMqDge97Hec
        jOe7kBAWxFklVXXeeDPDlK6we0Eq5l6J/e/+nQisei8u13Ij+/Xho77Ly5bU2i66d/Dem/Vz
        2TzWiGusjm9TbpfJNdu1+pTHFt/YPdJTpi9z8lte9lllptDLxYlMvKUmsW3//ldHm08RvRjC
        p2/ya7PhBvYGqTPp6ksfdWpMmi3mll+ldSph+meOF+HN8gatXs1O2ReVWIozEg21mIuKEwHl
        CyCePwMAAA==
X-CMS-MailID: 20230906164425epcas5p4275f672db2cfe129f666d8c929cbd095
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164425epcas5p4275f672db2cfe129f666d8c929cbd095
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164425epcas5p4275f672db2cfe129f666d8c929cbd095@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a prep patch to enable copy trace capability.
At present only zoned null_block is using trace, so we decoupled trace
and zoned dependency to make it usable in null_blk driver also.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/block/null_blk/Makefile | 2 --
 drivers/block/null_blk/main.c   | 3 +++
 drivers/block/null_blk/trace.h  | 2 ++
 drivers/block/null_blk/zoned.c  | 1 -
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Makefile
index 84c36e512ab8..672adcf0ad24 100644
--- a/drivers/block/null_blk/Makefile
+++ b/drivers/block/null_blk/Makefile
@@ -5,7 +5,5 @@ ccflags-y			+= -I$(src)
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs			:= main.o
-ifeq ($(CONFIG_BLK_DEV_ZONED), y)
 null_blk-$(CONFIG_TRACING) 	+= trace.o
-endif
 null_blk-$(CONFIG_BLK_DEV_ZONED) += zoned.o
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..b48901b2b573 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -11,6 +11,9 @@
 #include <linux/init.h>
 #include "null_blk.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"null_blk: " fmt
 
diff --git a/drivers/block/null_blk/trace.h b/drivers/block/null_blk/trace.h
index 6b2b370e786f..91446c34eac2 100644
--- a/drivers/block/null_blk/trace.h
+++ b/drivers/block/null_blk/trace.h
@@ -30,6 +30,7 @@ static inline void __assign_disk_name(char *name, struct gendisk *disk)
 }
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
 TRACE_EVENT(nullb_zone_op,
 	    TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,
 		     unsigned int zone_cond),
@@ -67,6 +68,7 @@ TRACE_EVENT(nullb_report_zones,
 	    TP_printk("%s nr_zones=%u",
 		      __print_disk_name(__entry->disk), __entry->nr_zones)
 );
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 #endif /* _TRACE_NULLB_H */
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55c5b48bc276..9694461a31a4 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -3,7 +3,6 @@
 #include <linux/bitmap.h>
 #include "null_blk.h"
 
-#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 #undef pr_fmt
-- 
2.35.1.500.gb896f729e2

