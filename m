Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB126E21C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 13:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDNLIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjDNLIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:08:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D810CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 04:08:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230414110827euoutp0176f7a6cdc45270f78f14d542108da79c~VyIR2SI6k1324913249euoutp013
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230414110827euoutp0176f7a6cdc45270f78f14d542108da79c~VyIR2SI6k1324913249euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681470507;
        bh=bj8baqlJ3xbqI4cUC/UA6zmhZCxhKwgx39HkAQuD4fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJISNXnTsYVWM4Je5xvVmkSAvxU8nLYiklXi+ekE7Us/8AYm36M37epx6EY7vOwDb
         6RFXFTusHUK997hKX9krM8ZSxmrB4OxqZmY3wf7jKkbMqeC1s9HXo2MpSoFLG9grsp
         qwq5sYtg1MxosYYUzrI0L0S3SZ0c0OpdJjs7RvE4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230414110826eucas1p2ce40f92dab528798642e4e76e1afb140~VyIQ_A9TV3129031290eucas1p26;
        Fri, 14 Apr 2023 11:08:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9B.25.09966.A2439346; Fri, 14
        Apr 2023 12:08:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230414110825eucas1p2faad8162ee3aac7ed17f735dcbfc2334~VyIQtuKk_0295002950eucas1p2C;
        Fri, 14 Apr 2023 11:08:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230414110825eusmtrp205bbbc45cef585744a33e1411797f63e~VyIQtHsbg0970009700eusmtrp2R;
        Fri, 14 Apr 2023 11:08:25 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-e5-6439342af1b7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3D.39.34412.92439346; Fri, 14
        Apr 2023 12:08:25 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230414110825eusmtip2dfbef8e4c6f27559c80bf91e2d130d7b~VyIQhBV2z1802118021eusmtip2c;
        Fri, 14 Apr 2023 11:08:25 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     brauner@kernel.org, willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com, hare@suse.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 1/4] fs/buffer: add set_bh_folio helper
Date:   Fri, 14 Apr 2023 13:08:18 +0200
Message-Id: <20230414110821.21548-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414110821.21548-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87paJpYpBg8fc1jMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/isklJzcksSy3St0vgyljx6TRLwR+eik8XHrI0
        MN7i6mLk5JAQMJF4NuUNexcjF4eQwApGidvTbzCBJIQEvjBKrLlvApH4zChxacdDZpiOI5v+
        M0EkljNKXP/RzwzR8ZJRYtoN7y5GDg42AS2Jxk52EFNEIFHi5nsFkHJmgQWMErduv2cHKRcW
        MJXYs/gLWCuLgKrEgq5GNhCbV8BSYtmNdjaIXfIS+w+eBavhFLCSeLPsAlSNoMTJmU9YQGxm
        oJrmrbOZQRZICNzhkGi7dYgVotlFYsW0qVC2sMSr41vYIWwZif875zNB2NUST2/8hmpuYZTo
        37meDeRqCQFrib4zOSAms4CmxPpd+hDljhIv+/qZICr4JG68FYQ4gU9i0rbpzBBhXomONiGI
        aiWJnT+fQC2VkLjcNIcFwvaQWDfjA9sERsVZSJ6ZheSZWQh7FzAyr2IUTy0tzk1PLTbKSy3X
        K07MLS7NS9dLzs/dxAhMSaf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8P5wMU0R4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1ILUIJsvEwSnVwCTy5lehfec1wR8vljTelPTf
        3XP+sIHSs5O5OVqlLxus3pl6tHz/uVHE8cWB8KTkDK4Fh164K7+UWP/pzoffkhMYLhozsYvJ
        mfIsX/otoMSYX1BcMZx9vr7y9VXsQRuFKv9mS2jPTJQNDZndVy318aG0sanEC4ewBYWlzIac
        V4O6tafd0HUOLWs7+nWVpIftnQNp/5fcsOSba/T77Y+sb8y3/p62X/VIdgoHG5fxleb7L8V0
        arneW3RrqjoZzLytM9mudJp/yar40kWzxScwcd29J/W5pePPiwl8vSbbgjlnCjiHnrpguuZ/
        rfHaFmWNuQW/2uW7m/fNeh66vPP+gdzNT7bxq8ds9avu1haaqMRSnJFoqMVcVJwIAOniHS64
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7qaJpYpBgf/G1vMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy1jx6TRLwR+eik8XHrI0MN7i6mLk5JAQMJE4suk/Uxcj
        F4eQwFJGibm3VrNDJCQkbi9sYoSwhSX+XOtigyh6zijxecEXoA4ODjYBLYnGTrB6EYFUidMn
        PoLVMAssY5RYM/cFG0hCWMBUYs/iL8wgNouAqsSCrkawOK+ApcSyG+1sEAvkJfYfPAtWwylg
        JfFm2QWwuBBQTfuWJSwQ9YISJ2c+AbOZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucVG
        esWJucWleel6yfm5mxiBMbTt2M8tOxhXvvqod4iRiYPxEKMEB7OSCO8PF9MUId6UxMqq1KL8
        +KLSnNTiQ4ymQHdPZJYSTc4HRnFeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFq
        EUwfEwenVANT8H7fy5KqD8W3vOvdZ6dXdVL9eGlSROP36f///Lx2c5N+7Mry+376HKETptUu
        uf7tStGbcwnX1C/3RDTPOHNSYvO+U1XHdzzhmLH61x/1istvJ2wwPZbffHi6j3NynMKNlIYg
        X/434lPuXbyo6P7+/tNr95KuK79+c/FP4N64Qts1d+YcrdWpqQoUSXpR9/um4b0fM2O2fFl9
        frc523o2F5EjDQl172t0Sm94+l9Puf/pE7NigqZlYftHXe15npvi8iz2Mcje06lYkXKQZd0J
        nRSX/ft7ryj+cZrwpOdUb6b6svSCW74n5YInHF1xutJpTdvi93qdfzYGRsosKuc7WPPRb++t
        Y3tmv+raaHJ+WpkSS3FGoqEWc1FxIgC7JStKKgMAAA==
X-CMS-MailID: 20230414110825eucas1p2faad8162ee3aac7ed17f735dcbfc2334
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414110825eucas1p2faad8162ee3aac7ed17f735dcbfc2334
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414110825eucas1p2faad8162ee3aac7ed17f735dcbfc2334
References: <20230414110821.21548-1-p.raghav@samsung.com>
        <CGME20230414110825eucas1p2faad8162ee3aac7ed17f735dcbfc2334@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The folio version of set_bh_page(). This is required to convert
create_page_buffers() to create_folio_buffers() later in the series.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c                 | 15 +++++++++++++++
 include/linux/buffer_head.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index b3eb905f87d6..44380ff3a31f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1484,6 +1484,21 @@ void set_bh_page(struct buffer_head *bh,
 }
 EXPORT_SYMBOL(set_bh_page);
 
+void set_bh_folio(struct buffer_head *bh, struct folio *folio,
+		  unsigned long offset)
+{
+	bh->b_folio = folio;
+	BUG_ON(offset >= folio_size(folio));
+	if (folio_test_highmem(folio))
+		/*
+		 * This catches illegal uses and preserves the offset:
+		 */
+		bh->b_data = (char *)(0 + offset);
+	else
+		bh->b_data = folio_address(folio) + offset;
+}
+EXPORT_SYMBOL(set_bh_folio);
+
 /*
  * Called when truncating a buffer on a page completely.
  */
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8f14dca5fed7..d5a2ef9b4cdf 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -196,6 +196,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh);
 void touch_buffer(struct buffer_head *bh);
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
+void set_bh_folio(struct buffer_head *bh, struct folio *folio,
+		  unsigned long offset);
 bool try_to_free_buffers(struct folio *);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
-- 
2.34.1

