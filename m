Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7682F7A7712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjITJUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjITI7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:59:24 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97ACF1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:49 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230920085847epoutp02e1d4ab10183fe5ba013d2a83692ff17d~Gj7d2soTi2757227572epoutp02f
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230920085847epoutp02e1d4ab10183fe5ba013d2a83692ff17d~Gj7d2soTi2757227572epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200327;
        bh=ddG+iMTBPykY7aem2/d5RFRU6pD1r9HGia7WdJCIOGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDz+UnGQ423tla/xax0Am7BkiBctpNH0PSSEIrrsqww+E9/PFRuFi4ucoK8X0Itr+
         aQfB6ZkCwrcROpU4xr9V5jq1TmIPUv/C375JUC9DFR/iKdVFtwqKx7E9KshHRiC4t9
         KcmQeS+1Hjn5GvnXIPd6DGcARzM4NDYuoqtfacB0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230920085847epcas5p2cc008ef9a9ded85cafc0c033339026f3~Gj7dRA2k72273522735epcas5p2I;
        Wed, 20 Sep 2023 08:58:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RrCBF49fpz4x9Pw; Wed, 20 Sep
        2023 08:58:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.FA.09638.544BA056; Wed, 20 Sep 2023 17:58:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230920081607epcas5p3def8c43668f1bfb5555b65b93f2f7b6f~GjWNZ-Lby2994129941epcas5p3u;
        Wed, 20 Sep 2023 08:16:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230920081607epsmtrp1edd5801b2581d477d5ff46bdb38677ce~GjWNY3xBc2250122501epsmtrp1K;
        Wed, 20 Sep 2023 08:16:07 +0000 (GMT)
X-AuditID: b6c32a4a-6d5ff700000025a6-bc-650ab4458474
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.7C.08649.74AAA056; Wed, 20 Sep 2023 17:16:07 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081604epsmtip16700d2985fe3f82725b430bdd8785f24~GjWKQRg_B3072130721epsmtip1b;
        Wed, 20 Sep 2023 08:16:04 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 11/12] null: Enable trace capability for null block
Date:   Wed, 20 Sep 2023 13:37:48 +0530
Message-Id: <20230920080756.11919-12-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1BUVRTH5763vF2IxQdY3d0CaTF1ZVh+uNClJEtR36A4KE32w4IdeMMS
        y+7O/lDIZoCItTB+CCi0oKCgwFKA/HAWcBkDFBYzGo3fktosjYVCSEKyrcby1vK/z/nec+73
        nnPncHCPIjafkyTX0Cq5RCYgXFgXeoQb/Le3utCBFeXeqHHgCo7mHlpZ6PMCG47qJ/MJNN3z
        ACDLpSMAmWbKnNDYpXYMXTxTiKG6+ssYKuweBmhqSI8h07gfOq2rZqGLJjML3egoJ1DFuSk2
        OjpiJFBN32MMjRZMAWS0ZAJ0wVqBo4bpWRbqH38JDdr6nN7iUe36STY1+Mt5FnXjmpZqNnxF
        UC3V6VTnWAZBVeUVOVG5WTMENTc1zqJmu4YIKq/VAKiWq4ep+WZvqtlyH4t2+yB5s5SWJNAq
        H1oer0hIkieGC3bFxG6LDQkNDPIPCkOvCXzkkhQ6XBCxO9p/R5JseRACn4MSmXZZipao1YKA
        NzerFFoN7SNVqDXhAlqZIFOKlSK1JEWtlSeK5LTm9aDAwOCQ5cS4ZOlw6RG28ohn6s9N17EM
        UEzmAGcOJMVwpv28Uw5w4XiQnQDaquYIJngAYOn0GYwJFgDs/f4YyAGclZKOyo8Y3QTgQk+V
        Iykbg4MWi5M9iSD94NUnHLu+mszAYVNnFbAHOHkKhy2/9mF2c09yJzQ0mVeYRb4K5yf0hJ25
        5Btw8K88nHELgPm33O2y87I8Xz3CZlLcofkbC8vOOLkGZrWV4fb7IVnjDO+UXMeY5iJg/+ka
        B3vCP/pa2Qzz4e/5OgcfgnXFtQRT/AWA+hE9YA62wOyB/JVH4KQQNnYEMLIXPD7QgDHGbjDX
        anHcz4XGU0/ZF37bWEkwzIPDi5kOpuDdo5OOYecBmDFmYBcAH/0zDemfaUj/v3UlwA2ARyvV
        KYm0OkQZLKcP/ffN8YqUZrCyHRsjjeDO7T9F3QDjgG4AObhgNTdlnQvtwU2QpH1KqxSxKq2M
        VneDkOWBH8P5z8crltdLrokNEocFikNDQ8Vhm0KDBC9yp7NPJniQiRINnUzTSlr1tA7jOPMz
        sB3vjZ6tSreqbm55/LXIVFPaO9q/P+pAu3IiymwW0HVrz5VLS16Im9kZF/kOfa2wnrfftfa3
        smzuD97aYK15grfnk1znJwNeUbGKmwUvn1W4RSyBpeLm+8/ZiMsdqdIK8cO4koXZNi/d1hYZ
        VxdxbyjY2JFW+K6pR1hctHYiZdG2TmTb2rX+yqP4NN9b7vfW+1pjXqk9nL478sSHyul9bNft
        OfzOz/5RC122lW64u5dz0Dsq5m9hw8eGPfwF4/Evy3OTa1ofiXr7I/cdyAqrO/m262KTtZc4
        keq5Spcq/Knlx6E1cZpcD/S+bqors5zjx/uuscFv0yC1qmc6/nZj29LeXQtQwFJLJUEbcZVa
        8i9kO7jypgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzHfZ/n6bnnzq49rsa3Us1trKFyYvsOYbP0mF/VmM0Yp56l6a5z
        1wllIsRJEpkudqXLj4vk+nV3leVCVzeLJP3wK92PrSgUlRSd2Pz32uv9/nz22T4ULmggvKk4
        aSIrl4rjhSSPqKwX+gWG63jsosudvuhe0xMcffk2RqDjWeM4Kn5znkR99V8BstWlA1Tbn+eG
        OuqMGKq5no2h28WPMZRtbgPI/lKNodrOBajglJZANbWNBHphukoizQ07B519ZSDRzYYJDLVn
        2QEy2I4BVDmmwVFJ3wCBLJ0+qHm8wW21F2NUv+EwzW/vE8yLp0pGrztDMmXao0x1RyrJFGZe
        dGPOpfWTzBd7J8EMPHhJMpnlOsCUWZOZQb0fo7d9wiLct/NWxLDxcQdYefDK3by9bVfSObJ0
        j4OtpS1YKrhEqwBFQXoJNOXvVAEeJaCrAbQ9zCRUgDvpveCN8Uf4FHvA2xNOzlQpDYMWSytw
        DZP0Amj9Rbm8J63C4Rlj/59hnL6Dw/JrfBd70OFQV9qIuZig58LBLjXpYj69HDYPZeJTRwTD
        8+9muDR3Ug9qX3FcLKCXQeszDWeqPgM25tr+rveHaRV5eBag1f9F6v+ifIDpgBcrU0hiJdEi
        mUjKJgUpxBKFUhobFJ0g0YM/v54fYABvNRNBZoBRwAwghQs9+ZJ5PFbAjxEfOszKE3bJlfGs
        wgx8KEI4iy+6khcjoGPFiew+lpWx8n8pRnG9UzHj0qUdo17WVZXPHXPXBieUbMbyF7Ze7uo6
        5fQeOpb7I3mkx+HvKFS8i4rkbJasKyf3bDLx2aEBx4Dzalz5oh291YU5Ye3mlkCQJA3Uy4ps
        rz/73Yo02bldVdy7vh9NllshEUPDPRGziwr7mvI2Coqiuk+023OaYhMIy+jiTRPQMuwTX6dy
        qC+Eumt1ffePmPcj/63bltQc9TOUKNcgG9Pzff/xXE0vZdxiELa4V3sWp21QwEMeOkPvwowP
        njdTYlQZVs7M070pBd1VI9N2VSTqwoadIl9qN54xWvqz4c77NbXLp6do80OjUo+0paucJwt8
        1jMgJ6BHOWcLHSISEoq9YtF8XK4Q/wadwq4jWgMAAA==
X-CMS-MailID: 20230920081607epcas5p3def8c43668f1bfb5555b65b93f2f7b6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081607epcas5p3def8c43668f1bfb5555b65b93f2f7b6f
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081607epcas5p3def8c43668f1bfb5555b65b93f2f7b6f@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a prep patch to enable copy trace capability.
At present only zoned null_block is using trace, so we decoupled trace
and zoned dependency to make it usable in null_blk driver also.

Reviewed-by: Hannes Reinecke <hare@suse.de>
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
index 968090935eb2..c56bef0edc5e 100644
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

