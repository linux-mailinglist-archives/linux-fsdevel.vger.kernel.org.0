Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5596E21C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 13:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjDNLIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDNLIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:08:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBE2683
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 04:08:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230414110829euoutp02af8c0c92427fff057ed68d6ca9b76c6a~VyITtjsUI0816708167euoutp02Q
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:08:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230414110829euoutp02af8c0c92427fff057ed68d6ca9b76c6a~VyITtjsUI0816708167euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681470509;
        bh=mYP1zNZlkNSFYYEZy1X4gVz5Ukcj0nQ95dBohrnlJJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fbx4sqB55TW2FIa6EbR+LpMXJuU6PZqdqlPW/7FVdgNspqOTNdJZizrnu3VNCjKVj
         MDk67wo/G75wy+a3bsVu0xUQ5UBYyzQbr4ayulLqmdMgKGD4REB/O6NVtKTZw5tJch
         GpZavB1tnFRYrQEdoVsy0S4bYjXMx2/UdbJ2HMHE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230414110828eucas1p27a02cf6a0489c892cebb71a142cd12d6~VyIS6P83_0295002950eucas1p2D;
        Fri, 14 Apr 2023 11:08:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 73.9A.09503.C2439346; Fri, 14
        Apr 2023 12:08:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230414110827eucas1p20e5f6bc74025acfb62b13465f267fa84~VyISX3-6I0896208962eucas1p2W;
        Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230414110827eusmtrp23a6f6eb3620adf6cec0cd8f777b64956~VyISXJW7G0913109131eusmtrp2X;
        Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-9f-6439342c4e39
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.39.34412.B2439346; Fri, 14
        Apr 2023 12:08:27 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230414110827eusmtip23f72b25a7070947a365203c3b088f67a~VyISIV5tx2822728227eusmtip2L;
        Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     brauner@kernel.org, willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com, hare@suse.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 4/4] fs/buffer: convert create_page_buffers to
 create_folio_buffers
Date:   Fri, 14 Apr 2023 13:08:21 +0200
Message-Id: <20230414110821.21548-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414110821.21548-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87o6JpYpBk/XcVjMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/isklJzcksSy3St0vgytjbuJCxoF244tduqQbG
        y/xdjJwcEgImEtOOXGTpYuTiEBJYwSjRsuAmE4TzhVFi9c6b7BDOZ0aJxdP+M8O0XN92gBEi
        sRwo0TwFynnJKLFxfS9bFyMHB5uAlkRjJzuIKSKQKHHzvQJICbPAAkaJW7ffs4MMEhYIlpi3
        ZS0TiM0ioCpx6/hONhCbV8BS4vDazewQy+Ql9h88C7aYU8BK4s2yC1A1ghInZz5hAbGZgWqa
        t85mBlkgIXCFQ+LciYNQl7pIPL7eDmULS7w6vgVqqIzE/53zmSDsaomnN35DNbcwSvTvXA/2
        gISAtUTfmRwQk1lAU2L9Ln2IckeJf5f+s0BU8EnceCsIcQKfxKRt05khwrwSHW1CENVKEjt/
        PoFaKiFxuWkOC4TtIbHgwTzGCYyKs5A8MwvJM7MQ9i5gZF7FKJ5aWpybnlpsmJdarlecmFtc
        mpeul5yfu4kRmJRO/zv+aQfj3Fcf9Q4xMnEwHmKU4GBWEuH94WKaIsSbklhZlVqUH19UmpNa
        fIhRmoNFSZxX2/ZkspBAemJJanZqakFqEUyWiYNTqoEpfqVWstrffW9YZ7zkV8wu+ZJ28hcj
        Z8GJ4mQp/5r+3pfum5b2eZ4yUNwot+TcgeItUbVbHJw810jaX+fV/PU1qCzo7cTQ+K5LQrsm
        6Zzu1ji9hX2KToxo9Zaa1j3JbysaLLpsHBZEZ304yCNgZMNzZMGMqK0pPMmHVJacSZh4LM72
        lG/mtoBQNuar79qNNEq+pTDtnzQz+k3ZGsE65z/3N21f8uacffBswS0NsTfFDyQddr5XZZbw
        7sUTr/x9P/Oke0pOiFs9O3Gzp8DQfHO65I+GV+vv3SrdEK2t5Vmt2JexY0Yut72KPWvnSluW
        A1EWtd3sTTO2f2Tx871XInPXZ+tpPbfw5FybP9dc3yixFGckGmoxFxUnAgAU/upCuQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7raJpYpBn+nKVvMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy9jbuJCxoF244tduqQbGy/xdjJwcEgImEte3HWDsYuTi
        EBJYyihx7vEadoiEhMTthU2MELawxJ9rXWwQRc8ZJW6fX8jcxcjBwSagJdHYCVYvIpAqcfrE
        R7AaZoFljBJr5r5gA0kICwRKrJ9+GMxmEVCVuHV8J5jNK2ApcXjtZqhl8hL7D55lBrE5Bawk
        3iy7AFYjBFTTvmUJC0S9oMTJmU/AbGag+uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFe
        cWJucWleul5yfu4mRmAEbTv2c8sOxpWvPuodYmTiYDzEKMHBrCTC+8PFNEWINyWxsiq1KD++
        qDQntfgQoynQ3ROZpUST84ExnFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE
        08fEwSnVwMT7/2TDms6105SNpu9nZNOK+uijlX7i3v5gRmdzb0nvkGjdBRtuZbIKcJvt6pOc
        t1htV7GXiL9+gHr1PC6rurkX7z0+73D2dZ92euW+s8es/5zV9Lt83VvnvNbW6sCXsyfs/Dc/
        fK1qZE0c56Svhu7KNvPZ9V6onSsXV8pc9FPX+rLVw8vXdVOTzX97vGXPkC5SUWc7GxCy1k3n
        zCm5cLXVHu/Ko5bEHPKpCZRLYlL52a63Yv0LpxNBalN3TWUr3nxs63qvBfcnTfFJ97fyuHF0
        9pxVd2w2l7/e8CJ/y8t0tdql1Y4+taxL/PKF3YsF9DhsLm/w+N24MPzfzay5Z1/8kk59XM95
        dNucwoqrm5VYijMSDbWYi4oTAdGKN2opAwAA
X-CMS-MailID: 20230414110827eucas1p20e5f6bc74025acfb62b13465f267fa84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414110827eucas1p20e5f6bc74025acfb62b13465f267fa84
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414110827eucas1p20e5f6bc74025acfb62b13465f267fa84
References: <20230414110821.21548-1-p.raghav@samsung.com>
        <CGME20230414110827eucas1p20e5f6bc74025acfb62b13465f267fa84@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/buffer do not support large folios as there are many assumptions on
the folio size to be the host page size. This conversion is one step
towards removing that assumption. Also this conversion will reduce calls
to compound_head() if create_folio_buffers() calls
folio_create_empty_buffers().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e6a1a738fb5..a83d9bf78ca5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1802,14 +1802,17 @@ static inline int block_size_bits(unsigned int blocksize)
 	return ilog2(blocksize);
 }
 
-static struct buffer_head *create_page_buffers(struct page *page, struct inode *inode, unsigned int b_state)
+static struct buffer_head *create_folio_buffers(struct folio *folio,
+						struct inode *inode,
+						unsigned int b_state)
 {
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << READ_ONCE(inode->i_blkbits),
-				     b_state);
-	return page_buffers(page);
+	if (!folio_buffers(folio))
+		folio_create_empty_buffers(folio,
+					   1 << READ_ONCE(inode->i_blkbits),
+					   b_state);
+	return folio_buffers(folio);
 }
 
 /*
@@ -1853,8 +1856,8 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 	int nr_underway = 0;
 	blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
-	head = create_page_buffers(page, inode,
-					(1 << BH_Dirty)|(1 << BH_Uptodate));
+	head = create_folio_buffers(page_folio(page), inode,
+				    (1 << BH_Dirty) | (1 << BH_Uptodate));
 
 	/*
 	 * Be very careful.  We have no exclusion from block_dirty_folio
@@ -2117,7 +2120,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 	BUG_ON(to > PAGE_SIZE);
 	BUG_ON(from > to);
 
-	head = create_page_buffers(&folio->page, inode, 0);
+	head = create_folio_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
@@ -2403,7 +2406,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 
 	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
-	head = create_page_buffers(&folio->page, inode, 0);
+	head = create_folio_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 	bbits = block_size_bits(blocksize);
 
-- 
2.34.1

