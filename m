Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E81BA267
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD0LcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:32:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54664 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgD0LcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587987141; x=1619523141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rnxX2qGcJ5HPe7ZiFJY/S56JEW3gBwG3lQwqa1XfisQ=;
  b=Bl2M0rx67aknKODBeN0PSmzMr9KumK1CPPkNGgMYbjkILQNjtDMiGbMl
   sl1PCYtEIbIV6MKMnRNfVUk4TmcSRCicSFPTZdQ/jw3iy3im2r/sEzf4r
   Bi1svYGYBmW7iPYNPfDThEBEKbEIIGbX+7kZcX+ZbHviegv733O+MVxIN
   q5wtvU8c+/FRUGpLaf4X6SWiUM5TNv51Weu5i+gqFQWtVY7ipPEf3zEa/
   4AarXU8W5kijxvzK27eIdeF20cCSY3fOQbk8VoBxQ3MEIhgqq+H9pyfsY
   ZwwXxOlZ06VqNP5ynby68AJFkKU11V6dOD206kWgeI9/hxPDaG9NyLWH8
   Q==;
IronPort-SDR: dj6Ty46ay7MZyPncZvMxx8MdT631cTKzrDjmCxJRwR95HqDotb9UXTZjBmjz3LsleMA9Gmbqx1
 OHl9axo7W0kRs/5Uc1OlmOxbcne1ukfzfHxS3aLb/axZC93XymgP2sgFJ2jiB9jBqzrpfH6FDa
 IYPxl0/bmyXkNzaViMM+tUyjKJ9Tuloq2zYX7f9UzlPn5gMFEGHZxNybI/qP+30rHwBPDAiYpp
 9Je+xuBCvlLxF8rhM9z80zpyasypIS0SptmFE/sn+eC8P3iyPjqplARnc75L831rXuxCkvnGV2
 yLo=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="136552036"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 19:32:21 +0800
IronPort-SDR: wycErS0EU9NVjCnbNqaynKAsIuOHc8Xfbt27NEvVAMBoNxlJVXyrCoF9V7dX3ppOUE9uxSQQ/8
 SnXJumumDhj0yyUlUP4NdXAMw9fGC5H/8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 04:23:03 -0700
IronPort-SDR: bjOVeH3sTlwiih3zSwFE766SoxMhwmTwFPNqz57IzwkVhJuyGqTDuX/WCwnjbsDG35SjLh6qFo
 nRP31XC0XO5g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Apr 2020 04:32:20 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v8 10/11] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Mon, 27 Apr 2020 20:31:52 +0900
Message-Id: <20200427113153.31246-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
References: <20200427113153.31246-1-johannes.thumshirn@wdc.com>
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
index 6dffc45ba895..d3a42cb5fb92 100644
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

