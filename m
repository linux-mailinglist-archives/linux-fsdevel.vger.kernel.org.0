Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482AB1ADD2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgDQMQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 08:16:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgDQMQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587125766; x=1618661766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wu0Wqu+uMy68Ptkn8zi6Jwl5CpiQBAeDUJahmaTNaQQ=;
  b=D3VezgGN0I2BroMEOG8FJZSmi0f/8wQaTPZXGl2V6zOxiZ+dGLjRoVy6
   ahmTC6zcLnfI7O1+H8OlhiZDwsmBc/D71lYH4X5AwuLyOG+zOptv9zaBE
   yiLl2TRnoM9JJaWNerDherkvirjzV9W131DJ5+Ybl79ZEdnWzV133MiwS
   0tPx2Oz+0OvvlmYVWGeH6VwuFAO4CB0WREtRxGrG2YgvakO7YY2OitAo8
   9AZBZPVvfTD1JsM5i6VS61ZZLggDuV9zRnUXXr2nflK/S5c0c2LODYaP8
   md1082xMJf+zqbrf46XJb/PbajgKFHn6ymT5Gl3tt9nsLNZBG20x+vdls
   A==;
IronPort-SDR: 5BH0guw+k6zsRlaHYa306+C6M/f8TdGyvcvwQfP0kAeBYqUtnyXbmcvFfrO6MRfd0jZyc+0gxD
 xh7LTJCrnQ9LJlfPj92/T4mvu+nkSLm8HLt4Np+De8cvV1TNtSfaPxWgSeOzaWINwEi2YjAOMh
 pcYImtEKLiXCKhEZE84W+flN33YFQByTjZvr1cyL3x84u70g69SaoAcD9iBxfdDZu08cFCyfUO
 fzqyxHbp/gqzSeA7GDqWJozZJIfJgeQ3mAFav1EL84VszeV3wSuBRI4XOUeuTypHA+t1lV9lMz
 SxA=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="237989230"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 20:16:06 +0800
IronPort-SDR: vu+A0NBNbckmURYsv86L1YvQ9FNYQkUV/2hScAgYeWSEE6VE2MZUzD18DnEIxD4MwHqL30Zb+x
 6FUiwA2PqJ5RE12sgHpPJf4kystidZAiY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 05:07:03 -0700
IronPort-SDR: mDs4uGOoMXkJQVh/tpaLkYkTxzbG6jdIAJMpKKxIoZcS71rHDAg34MmcG7sTdZZhhnT3EDiU5W
 uCyKuejXQ0pA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2020 05:16:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 10/11] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Fri, 17 Apr 2020 21:15:35 +0900
Message-Id: <20200417121536.5393-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export bio_release_pages and bio_iov_iter_get_pages, so they can be used
from modular code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 97baadc6d964..baa37d936d67 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -942,6 +942,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		put_page(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_release_pages);
 
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1105,6 +1106,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 	return bio->bi_vcnt ? 0 : ret;
 }
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
-- 
2.24.1

