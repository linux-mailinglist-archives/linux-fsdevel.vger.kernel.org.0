Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A129753B4C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiFBIIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 04:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiFBIIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:08:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DDB25FE;
        Thu,  2 Jun 2022 01:08:08 -0700 (PDT)
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LDJTR4TJ2zRhYy;
        Thu,  2 Jun 2022 16:04:59 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 16:08:06 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 2 Jun
 2022 16:08:05 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <kent.overstreet@gmail.com>
CC:     <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next] mm/filemap: fix that first page is not mark accessed in filemap_read()
Date:   Thu, 2 Jun 2022 16:21:29 +0800
Message-ID: <20220602082129.2805890-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
while it should be 'iocb->ki_ops'. For consequence,
folio_mark_accessed() will not be called for 'fbatch.folios[0]' since
'iocb->ki_pos' is always equal to 'ra->prev_pos'.

Fixes: 06c0444290ce ("mm/filemap.c: generic_file_buffered_read() now uses find_get_pages_contig")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 mm/filemap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9daeaab36081..0b776e504d35 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2728,10 +2728,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 				flush_dcache_folio(folio);
 
 			copied = copy_folio_to_iter(folio, offset, bytes, iter);
-
-			already_read += copied;
-			iocb->ki_pos += copied;
-			ra->prev_pos = iocb->ki_pos;
+			if (copied) {
+				ra->prev_pos = iocb->ki_pos;
+				already_read += copied;
+				iocb->ki_pos += copied;
+			}
 
 			if (copied < bytes) {
 				error = -EFAULT;
-- 
2.31.1

