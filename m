Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB839737D86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjFUIik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjFUIie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:38:34 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35B01987
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 01:38:31 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621083830euoutp01ca7fb32929a659a61cbca89136261bd1~qn8xsrZWW0952109521euoutp01d
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 08:38:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621083830euoutp01ca7fb32929a659a61cbca89136261bd1~qn8xsrZWW0952109521euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687336710;
        bh=w3WwCWATNZEjaxwXuvbzceRiaECoMo+kjp6czj94BZw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=remuJAmv++xqADP0gSs92HnGKNaq2Ho0RzPzXAS95cXG0eJ+EuGJMr82vRUFpGnqH
         PlvAA6Ic4ui13UwsZLbo91cHjWy2OqIF438t8BDSv3y7C0d+2JQfpMIxRXr1wjyDwP
         uQPkjq2R/KCz2OQ+s3bAH8ML05vGiljTTO6QIiOE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621083830eucas1p1bd1ed8b55bf02cbf0607171ae098f2fa~qn8xbeCsy1887218872eucas1p1g;
        Wed, 21 Jun 2023 08:38:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A3.2A.42423.607B2946; Wed, 21
        Jun 2023 09:38:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb~qn8xMmChV2120721207eucas1p1m;
        Wed, 21 Jun 2023 08:38:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621083830eusmtrp2960ddc217a12ea8b2ff7b9919f63eca4~qn8xL3wm80284602846eusmtrp2J;
        Wed, 21 Jun 2023 08:38:30 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-9d-6492b706ee14
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.8B.14344.607B2946; Wed, 21
        Jun 2023 09:38:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621083829eusmtip28a5341bf537b3783377d1c6eea202609~qn8w_T4Qh2282222822eusmtip2R;
        Wed, 21 Jun 2023 08:38:29 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 09:38:29 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <hare@suse.de>, <willy@infradead.org>, <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 4/4] nvme: enable logical block size > PAGE_SIZE
Date:   Wed, 21 Jun 2023 10:38:23 +0200
Message-ID: <20230621083823.1724337-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621083823.1724337-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+845Ox4Xs9MS9mppMbphpRldVpZkRc0/yqjoBpVLT2rO5c60
        m1QbLtPRZayFpnZTqmVXNzNXGjqaZq0IK1lXSp2aGJGKKYPM+SX43/M+z+/le174GFKcLwhm
        UlQZHK9SKKW0kKqsH3w9j35kSpzfbQ6SVdR/RbLqEhMhu3XbSciaXacJWXVNIyV7+7iYlrmN
        HiTzDhTTKxn5ixKQ2yxhcmtZHi1/8kFLy20vs+S91tCN9E7h8kROmXKQ4yOi44XJFUVGMr2V
        PvzGfh5pUa3AgPwZYBdC0zszMiAhI2YtCBpcDgEe+hBcemoaocRsL4IP1yaMbnh1nwgM3URw
        Xa+j8DAMdZQU0nioQDBg6x9OGIZmw0CX5+fbDmRXgq28eOQJkq1GUKvrIXzMJDYaSk+qfZJi
        Z8Bzw0EfLmKjoE17289nAzsVSr+Bz/Znl0P5rTqEkYnQeLGN8mlyGMl+WERiDVDX2UnizlLQ
        2lwU1segJrvWz9cA2CEGLrZYEA7WQLfT/V9Pgq6GCj+sp8CQ/QqBdRZ43F4SL+sRnLPfp3G5
        KDjrUmImBspaSwlsB4D750TcJwBMlfkktkWQmyM2oumFYy4oHHNB4ZgLriKyDEm4TE1aEqeJ
        VHGHwjWKNE2mKik84UCaFQ3/nZd/G3qq0KWu3+EORDDIgYAhpYGiEKspUSxKVBw5yvEH9vCZ
        Sk7jQJMZSioRzVnRmCBmkxQZXCrHpXP8aEow/sFaImC1IV0QYB93oiqoa+YbCVmf9KV6tm4r
        H7cxI2Utvep4G9u4JtAc8Wy//wI+uNmC5j7fG6duN+xoam/SR6xLjll2o2vQveuMgiTMBa1X
        UoWfOzzOuGmXC2KWnGqOf9tbKc+RqPni2thxe8m6vJBZm96rp6+udC09eifDQim363aba7wN
        g9kKZv/TvnPGbdYpWm+RwZggXuXpuPfjo8bZF05SZVsXL/gx0JJ1eXxHbOaF/Mj1d29+4SS0
        4FporgfNpHt3Feicr0JKuv/0u6u2ZD+77nhAqQa29aSis9b4fG+ON8hOR8Hmmtx9RePLA/vF
        xIbvv/Qt+tewSHlGOSSlNMmKyDCS1yj+AfYMxC2qAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7ps2yelGMy+zGKx5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jC2zJzAXPGaruLBzMmMD4wHWLkZODgkBE4nfjbeZuhi5OIQEljJK3N/wigUiISOx
        8ctVqCJhiT/Xutggij4ySmza1ccM4WxhlFi06QljFyMHB5uAlkRjJztIg4iAg8TmjXNYQWqY
        BfYwShxo/MQEUiMsYCexuLUQxGQRUJU40VUGUs4rYC3xpGE1O0hYQkBeYvEDCZAwp4CNxMaV
        BxlBbCGgkvbjU9khygUlTs58AnYmM1B589bZzBC2hMTBFy+YIU5WkmjYfAbqlVqJzlen2SYw
        isxC0j4LSfssJO0LGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbltmM/t+xgXPnqo94h
        RiYOxkOMEhzMSiK8spsmpQjxpiRWVqUW5ccXleakFh9iNAX6ciKzlGhyPjAx5JXEG5oZmBqa
        mFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MOlv2Vyv2GHbs3Zt/RulTu7lz2xL
        rURk7194rm1+/GyJbdPvPw6s7zbk3pnbvOzl3vuqKUWzL/ZGquc83z9BiaEkTfEt3+uUosjJ
        Z4OuV89aueSeRWLqqYly6fqfTs1hZw742h9V5mHE88LZR0kvurKW/UBT3irGt/M/FoSfmc0+
        xeLsjMlzJYU1rO02/50/x5wrfq/QrsgzTjnfCu+0+Wp//FISdHnJzOd6339vtDt1Il9LdPXm
        rH0Ly5K7lt4Wnel9ou2kkKjZZHelOeaOFh4yT159vJXAtvVuktf6H1cvCETKn737MyFDgNnj
        bGGcfSE/+7o5WX+2s87aI5gpedq/Yb37vh9zGV+un7nsnagSS3FGoqEWc1FxIgC+fEt3VAMA
        AA==
X-CMS-MailID: 20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb
X-Msg-Generator: CA
X-RootMTR: 20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083830eucas1p1c7e6ea9e23949a9688aac6f9f3ea25fb@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't set the capacity to zero for when logical block size > PAGE_SIZE
as the block device with iomap aops support allocating block cache with
a minimum folio order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98bfb3d9c22a..36cf610f938c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1886,7 +1886,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * The block layer can't support LBA sizes larger than the page size
 	 * yet, so catch this early and don't allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if ((ns->lba_shift > PAGE_SHIFT) && IS_ENABLED(CONFIG_BUFFER_HEAD)) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
-- 
2.39.2

