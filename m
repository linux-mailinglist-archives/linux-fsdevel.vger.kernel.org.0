Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE963737DB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjFUIiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 04:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjFUIih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:38:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21511992
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 01:38:32 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621083829euoutp02325356fd8167dec1da65e553e046c9bd~qn8worH4-0616906169euoutp02F
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 08:38:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621083829euoutp02325356fd8167dec1da65e553e046c9bd~qn8worH4-0616906169euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687336709;
        bh=rvlCjmlSj0ZGDPQ/cfO6o7K+JkKYO3ZTGRL/HoVyZkI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=f2JlsmvJy5R+KQPw6npTXW8J/LIQM+eqasPWHqsIdpw4VsYHEJpK2LFXezG0dSkjT
         q8vsQSXLnfIryKjUcE6SgPFYh+Zvb92L5FG3y/AIec5k7o1ixkQXeiPJGnEjbO3I9D
         MEzSOpdlpSZKORrgYnMbYyTdLqw/22c3TN92wZIY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621083829eucas1p11b550c4838bc9fe93c75dfe0fa9c602a~qn8wTQQ8a2120721207eucas1p1i;
        Wed, 21 Jun 2023 08:38:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.2A.42423.507B2946; Wed, 21
        Jun 2023 09:38:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621083828eucas1p23222cae535297f9536f12dddd485f97b~qn8v_yb723008730087eucas1p2o;
        Wed, 21 Jun 2023 08:38:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621083828eusmtrp23eb1aa29cb9f11352d3e19ee81f3649c~qn8v_Luwr0288202882eusmtrp2p;
        Wed, 21 Jun 2023 08:38:28 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-98-6492b705af31
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.8B.14344.407B2946; Wed, 21
        Jun 2023 09:38:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621083828eusmtip268aebe9ddef3dfc67b9f54483d98e7da~qn8v0A8p-2785727857eusmtip29;
        Wed, 21 Jun 2023 08:38:28 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 09:38:28 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <hare@suse.de>, <willy@infradead.org>, <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 3/4] block: set mapping order for the block cache in
 set_init_blocksize
Date:   Wed, 21 Jun 2023 10:38:22 +0200
Message-ID: <20230621083823.1724337-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621083823.1724337-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7qs2yelGHSs47TYcuweo8WeRZOY
        LFauPspkce1MD5PFnr0nWSwu75rDZnFjwlNGi98/5rA5cHicWiThsXmFlsemVZ1sHrtvNrB5
        bD5d7fF5k1wAWxSXTUpqTmZZapG+XQJXxq+bd1kKHnBVLN6ymKmB8QdHFyMnh4SAiUT3rH9s
        XYxcHEICKxglVrzoYgNJCAl8YZRY/5UVIvGZUeL1+kmsMB0z75yA6ljOKPHi/jtmuKoVl/6z
        QzhbGCUafk5l6mLk4GAT0JJo7GQH6RYRcJDYvHEO2FhmgT2MEgcaPzGBJIQFwiW+7u1gBrFZ
        BFQlllxcC7aOV8Ba4vPp7WBzJATkJRY/kAAJcwrYSGxceZARokRQ4uTMJywgNjNQSfPW2cwQ
        toTEwRcvmCGuVpJo2HyGBcKulTi15RYTyA0SAj84JI6tX8wIkXCRWHbzCBOELSzx6vgWdghb
        RuL/zvlQ8WqJpzd+M0M0tzBK9O9czwZxnLVE35kciBpHickLj7FAhPkkbrwVhLiHT2LStunM
        EGFeiY42oQmMKrOQfDALyQezkHywgJF5FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmDq
        Of3v+KcdjHNffdQ7xMjEwXiIUYKDWUmEV3bTpBQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2
        J5OFBNITS1KzU1MLUotgskwcnFINTNKdO9a8j1SoUL0YWPNf327yMekJa1SmWKwXTzOS0w78
        cGD2BLt5Mut3yfw/JnIvavHMPGt5wd03Z5z/GLeXVSXrwt0LDd2mL9s0CmQfLvrutH7HyeM/
        xFRvum6oaZiUc/lJUtMxq0KlrIPK7HlRQjF867SPy+pKaiUxnvF9VKuz98ks0/jrmXm31Soy
        /t3RzT2j5Mnz/vHZ96+F3v97Hvt4ca+Z//xd0ydrlTtNSS4/Ypzh9mC+KnPcRMN179Mv1NYf
        Fc7Ssqw981r4QeflR0uEWu1WuLZ/XrX56LL0/ern/3RmzHBhsTnFETWnxkNN5MLsnc6ie0WE
        Gp8E1hqGHJ9y7UiP3sXHDzsslx8JclViKc5INNRiLipOBADsIb0YrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7os2yelGOxoM7bYcuweo8WeRZOY
        LFauPspkce1MD5PFnr0nWSwu75rDZnFjwlNGi98/5rA5cHicWiThsXmFlsemVZ1sHrtvNrB5
        bD5d7fF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexq+bd1kKHnBVLN6ymKmB8QdHFyMnh4SAicTMOyfYuhi5OIQEljJKbFh0iwkiISOx
        8ctVVghbWOLPtS6ooo+MEg0t81khnC2MEqcub2HuYuTgYBPQkmjsZAdpEBFwkNi8cQ5YDbPA
        HkaJA42fwKYKC4RKXN7wlg3EZhFQlVhycS3YBl4Ba4nPp7czgcyREJCXWPxAAiTMKWAjsXHl
        QUYQWwiopP34VHaIckGJkzOfsIDYzEDlzVtnM0PYEhIHX7xghjhaSaJh8xkWCLtW4vPfZ4wT
        GEVmIWmfhaR9FpL2BYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjc9uxn1t2MK589VHv
        ECMTB+MhRgkOZiURXtlNk1KEeFMSK6tSi/Lji0pzUosPMZoCvTmRWUo0OR+YHPJK4g3NDEwN
        TcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpg4Wvpy73+b5FlWZ/nvZVqNuNF3
        /YysmordjYd3ZejwVv+bpBju4Bjg8umTdIy+U/P7NAHt+pSSu7bessfWTlqk+cpj/d/Pp17s
        yPLM21z3bNuHiHwOnrJpRxWn9199EV/+yfXyrm5Ned3pdeyCXpPtfhjWaO2ambJtWs7KfVE6
        bEman68/YGFzTuXab9gQ7HL30+34/GWaUYKvv7Ik/9e4aHukzuSIVZ+usun7Vc7zr174H9A0
        d3PUnh+MBVKLp0u5ik54LhMzUy07z3nXkwRuk/hZp/gD2vKcnF4Wnex261xwRc5V9KTnNvbs
        07mly3cYzn2sp6i1ZemjP6p35l7Pddm+WpW/7urfIEGRJCWW4oxEQy3mouJEAKd6m0hWAwAA
X-CMS-MailID: 20230621083828eucas1p23222cae535297f9536f12dddd485f97b
X-Msg-Generator: CA
X-RootMTR: 20230621083828eucas1p23222cae535297f9536f12dddd485f97b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083828eucas1p23222cae535297f9536f12dddd485f97b
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083828eucas1p23222cae535297f9536f12dddd485f97b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Automatically set the minimum mapping order for block devices in
set_init_blocksize(). The mapping order will be set only when the block
device uses iomap based aops.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 9bb54d9d02a6..db8cede8a320 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -126,6 +126,7 @@ static void set_init_blocksize(struct block_device *bdev)
 {
 	unsigned int bsize = bdev_logical_block_size(bdev);
 	loff_t size = i_size_read(bdev->bd_inode);
+	int order, folio_order;
 
 	while (bsize < PAGE_SIZE) {
 		if (size & bsize)
@@ -133,6 +134,14 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	order = bdev->bd_inode->i_blkbits - PAGE_SHIFT;
+	folio_order = mapping_min_folio_order(bdev->bd_inode->i_mapping);
+
+	if (!IS_ENABLED(CONFIG_BUFFER_HEAD)) {
+		/* Do not allow changing the folio order after it is set */
+		WARN_ON_ONCE(folio_order && (folio_order != order));
+		mapping_set_folio_orders(bdev->bd_inode->i_mapping, order, 31);
+	}
 }
 
 int set_blocksize(struct block_device *bdev, int size)
-- 
2.39.2

