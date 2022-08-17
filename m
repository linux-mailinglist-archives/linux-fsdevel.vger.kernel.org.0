Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C363F597038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbiHQNwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiHQNwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:52:09 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F095E74
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 06:52:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VMVoL-M_1660744318;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VMVoL-M_1660744318)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 21:52:03 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH] mm/filemap.c: fix the timing of asignment of prev_pos
Date:   Wed, 17 Aug 2022 21:51:57 +0800
Message-Id: <1660744317-8183-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The prev_pos should be assigned before the iocb->ki_pos is incremented,
so that the prev_pos is the exact location of the last visit.

Fixes: 06c0444290cec ("mm/filemap.c: generic_file_buffered_read() now
uses find_get_pages_contig")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

---
Hi guys,
    When I`m running repetitive 4k read io which has same offset,
I find that access to folio_mark_accessed is inevitable in the
read process, the reason is that the prev_pos is assigned after the
iocb->ki_pos is incremented, so that the prev_pos is always not equal
to the position currently visited.
    Is this a bug that needs fixing?

 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 660490c..68fd987 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2703,8 +2703,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			copied = copy_folio_to_iter(folio, offset, bytes, iter);
 
 			already_read += copied;
-			iocb->ki_pos += copied;
 			ra->prev_pos = iocb->ki_pos;
+			iocb->ki_pos += copied;
 
 			if (copied < bytes) {
 				error = -EFAULT;
-- 
1.8.3.1

