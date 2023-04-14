Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48616E21C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 13:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDNLIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDNLId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:08:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48376199
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 04:08:32 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230414110828euoutp01b80a6f1c999863b761e11d2132973803~VyITFP6hH1543415434euoutp01B
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230414110828euoutp01b80a6f1c999863b761e11d2132973803~VyITFP6hH1543415434euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681470508;
        bh=RSOGq3FrSoWTKQkTpr/5r4j+YAAPIjwLJMcrhoIlH+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAd/6DAlYvu1XMnSEnNRo3E1VZqJdS/vehvklGbj1gkudXKyHHQgllpmPwUYlwy9f
         8QKY2GBaMdc3Bp4CijVny51VDtGZD8eMm0jFmIDiWSQoZJkPd3HuckBU868rTPnw/n
         y85BWFmn1YmUBdo8/3VDatm6ptTtHaC4n6WXRO2E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230414110827eucas1p207835504e487b376ebad539ba5144250~VyISKgiwV0186801868eucas1p2t;
        Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 32.9A.09503.B2439346; Fri, 14
        Apr 2023 12:08:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230414110827eucas1p1b872c350b7e81f01e65ba0985082ba20~VyIR1VkI60084500845eucas1p1O;
        Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230414110827eusmtrp21c4f119e4cab5295de4520b22e69c302~VyIR0o5fz0913109131eusmtrp2W;
        Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-9c-6439342b055f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.39.34412.A2439346; Fri, 14
        Apr 2023 12:08:26 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230414110826eusmtip1e7db1c25fda031f3dd0ba138dcb74441~VyIRme_cz1969519695eusmtip1h;
        Fri, 14 Apr 2023 11:08:26 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     brauner@kernel.org, willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com, hare@suse.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 3/4] fs/buffer: add folio_create_empty_buffers helper
Date:   Fri, 14 Apr 2023 13:08:20 +0200
Message-Id: <20230414110821.21548-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414110821.21548-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7raJpYpBt+/iFrMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/isklJzcksSy3St0vgypj7XqFgu3DFhg9/mRoY
        pwp0MXJwSAiYSFzZUdfFyMUhJLCCUeLu3P9MEM4XRom1O1sZIZzPjBKH7nxj7WLkBOuYs+cC
        K0RiOaPEpR8vmEASQgIvGSWW3uQDGcsmoCXR2MkOYooIJErcfK8AUs4ssIBR4tbt9+wg5cIC
        zhKT9jeD2SwCqhJ7t+8Hs3kFLCW6z09jh9glL7H/4FlmEJtTwErizbILbBA1ghInZz5hAbGZ
        gWqat85mBlkgIXCDQ+JRwxlmiGYXiVdvXkPZwhKvjm+BGioj8X/nfCYIu1ri6Y3fUM0tjBL9
        O9ezQcLFWqLvTA6IySygKbF+lz5EuaPEytsLmCAq+CRuvBWEOIFPYtK26cwQYV6JjjYhiGol
        iZ0/n0AtlZC43DSHBcL2kLjW2so0gVFxFpJnZiF5ZhbC3gWMzKsYxVNLi3PTU4sN81LL9YoT
        c4tL89L1kvNzNzECE9Lpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrw/XExThHhTEiurUovy44tK
        c1KLDzFKc7AoifNq255MFhJITyxJzU5NLUgtgskycXBKNTDJhu5pznnao+2xz75dVrQiY9Ph
        uvKj6178jNq84qeBu9VUAZ2Ne/qkrLNFVew4N8T5bxGQSj1wPyq07LTtxy2fGXI+x4Z/tkur
        S58t5SnzImRHkquBodINyUbTKqv42PdrJlyqPxsopKG0Mc3vfO2KD8VmDzn3bX9f7zZLuWXB
        ttaZPD8Fk9jO5G+cpZSR1dx7xtZEuF9y9oIdvhna/5d8MFm0LtHB+uXxiRPPLLzMksE1XSSd
        f9J57WWp6+3ntqSuUpSqEdM/wnlz9jW1IvnHahkdqzI9WNZ1n/RpY555p2ez7ZMT14/1Lvnz
        Jnyam2nvE3HxhYw/FuY9iA1QlerRnafVc5HjqmSBb0+rlBJLcUaioRZzUXEiALKT/Eq3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7raJpYpBkd0LeasX8Nm8frwJ0aL
        mwd2MlnsWTQJSOw9yWJxedccNosbE54yWnxe2sJucf7vcVaL3z/msDlweWxeoeWxaVUnm8eJ
        Gb9ZPPq2rGL02Hy62uPzJjmPTU/eMgWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlzH2vULBduGLDh79MDYxTBboYOTkkBEwk5uy5wNrFyMUh
        JLCUUeLtydMsEAkJidsLmxghbGGJP9e62CCKnjNKHLg0GaiDg4NNQEuisZMdpEZEIFXi9ImP
        YDXMAssYJdbMfcEGkhAWcJaYtL8ZrIhFQFVi7/b9YDavgKVE9/lp7BAL5CX2HzzLDGJzClhJ
        vFl2AaxXCKimfcsSFoh6QYmTM5+A2cxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYiO9
        4sTc4tK8dL3k/NxNjMD42Xbs55YdjCtffdQ7xMjEwXiIUYKDWUmE94eLaYoQb0piZVVqUX58
        UWlOavEhRlOguycyS4km5wMjOK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUI
        po+Jg1OqgaljJst23cpHUYuNHir4nD4dOJvx7fn1H64smVIRbCGhLfr+6poNNT7f5KeGv+wP
        q+r6JLFkkVdFtfa9qU8f2C+W8g3dtC6eYf/cFjP5P5Mv/DOeYBMn1bv/0RfJe38VZp9lXM7w
        je/Zn2IJ9nMWNd5Of6VsTrw8NyUhQ4Or2JORo/RLT8CSld1Hn3+9uORs1k6/zy+Co45u8qy4
        tLDK8L6UHO//1Bn93035n65iuns68m96x9PMWQr7Yt4KMj7IurZC/bPbxzM7RI8uUarc8mGp
        bnPb4YzSkKKGBy8UFgn0OgpuFjryYHrbhR9dSZlNk3Py771bseXjpYPi5eXJ7x7djU47Fs92
        0KYnR+f7HWZ7JZbijERDLeai4kQAfZNdcigDAAA=
X-CMS-MailID: 20230414110827eucas1p1b872c350b7e81f01e65ba0985082ba20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414110827eucas1p1b872c350b7e81f01e65ba0985082ba20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414110827eucas1p1b872c350b7e81f01e65ba0985082ba20
References: <20230414110821.21548-1-p.raghav@samsung.com>
        <CGME20230414110827eucas1p1b872c350b7e81f01e65ba0985082ba20@eucas1p1.samsung.com>
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

Folio version of create_empty_buffers(). This is required to convert
create_page_buffers() to create_folio_buffers() later in the series.

It removes several calls to compound_head() as it works directly on folio
compared to create_empty_buffers().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c                 | 34 ++++++++++++++++++++++++++++++++++
 include/linux/buffer_head.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 0f9c2127543d..9e6a1a738fb5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1645,6 +1645,40 @@ void block_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 }
 EXPORT_SYMBOL(block_invalidate_folio);
 
+/*
+ * We attach and possibly dirty the buffers atomically wrt
+ * block_dirty_folio() via private_lock.  try_to_free_buffers
+ * is already excluded via the folio lock.
+ */
+void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
+				unsigned long b_state)
+{
+	struct buffer_head *bh, *head, *tail;
+
+	head = alloc_folio_buffers(folio, blocksize, true);
+	bh = head;
+	do {
+		bh->b_state |= b_state;
+		tail = bh;
+		bh = bh->b_this_page;
+	} while (bh);
+	tail->b_this_page = head;
+
+	spin_lock(&folio->mapping->private_lock);
+	if (folio_test_uptodate(folio) || folio_test_dirty(folio)) {
+		bh = head;
+		do {
+			if (folio_test_dirty(folio))
+				set_buffer_dirty(bh);
+			if (folio_test_uptodate(folio))
+				set_buffer_uptodate(bh);
+			bh = bh->b_this_page;
+		} while (bh != head);
+	}
+	folio_attach_private(folio, head);
+	spin_unlock(&folio->mapping->private_lock);
+}
+EXPORT_SYMBOL(folio_create_empty_buffers);
 
 /*
  * We attach and possibly dirty the buffers atomically wrt
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d5a2ef9b4cdf..8afa91cbb8e2 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -203,6 +203,8 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
 			unsigned long b_state);
+void folio_create_empty_buffers(struct folio *, unsigned long,
+				unsigned long b_state);
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
 void end_buffer_async_write(struct buffer_head *bh, int uptodate);
-- 
2.34.1

