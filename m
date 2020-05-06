Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793061C75FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgEFQMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 12:12:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61321 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgEFQMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 12:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588781527; x=1620317527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OxG58gmQxO/wsNKD46rcb3CCQQtQoICGm9rQW0sMuDY=;
  b=atS0PxDi+irOZ5xYt/ONT9oP9Pf5VC9q90Np5E1kbAvZUWliTFwU5azr
   8puMVJ2RDOZZIxeNXj0NkiEySXQizth1ezVFraJnyLR99ZkvFTMyDYwiQ
   6wD2pxrx8L1k/4+VXlIK4tjgngPLdUJoBFm1uH+rnShhgNeqdDh+/eI5Y
   EI02l6M3IygcQoCtzPAcEewZ8T9Un9c0kbxsIlXfC8rSbC+zQZK7Iw/UP
   P9GT0ITObmjP1giTPyD+RZMQln1muOG6hJf6p+RJgc6ZtBZWHbYlIUYwn
   xQTmmR2fesuQrALgBjOgrFjr9pHTJPK69+Dz+EOJVwCe2lzAKrWJcxhO1
   g==;
IronPort-SDR: 6eGzfzj72/9oyhcaYWNIwAlr0y7dKdhnY5Tdy/FgNaQBRf/fUwBACYjm7/jL11sh76IAwgMjPU
 t2bwy/a3F96YRh0Fma1GCIX7vMlrlbF8l10TI/gRrEx0GqBOFls3UoPsx3k8MiZcFomz4kpvzC
 rI18mHeqrhpu0uBTIBN1by0ti1zhpFjFfl7jHK0rCkzqxqg95zqRm4jRdqUXRasKX7KgSykmUq
 9MbURp459XlCZ0V6pnjy9tSaRMMAyStrhArThYIsBf4thgfjq2Cziqnc/ac7t9fiPT6EnpeAKg
 /sc=
X-IronPort-AV: E=Sophos;i="5.73,359,1583164800"; 
   d="scan'208";a="245917915"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 00:12:06 +0800
IronPort-SDR: SJVeI9xC3ItEiJuLwry9cJNQAL3YXLyJtbWaD1oPWEv8RYAz7+QtfOUUbKV7QhDZEBwwXPEMzf
 COdzUtWFG2azlVtVlzlxcHL30vieDk5Yo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 09:02:32 -0700
IronPort-SDR: qdy9dU46JX6laW4ErvdwNTFcIvgszCHwZBcJaiO4xx8gFPqshwKfOqN7Vs9LFRKmjUAZHzYcyP
 ON7YFZNqa26g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2020 09:12:05 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v10 8/9] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Thu,  7 May 2020 01:11:44 +0900
Message-Id: <20200506161145.9841-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
References: <20200506161145.9841-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export bio_release_pages and bio_iov_iter_get_pages, so they can be used
from modular code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 3aa3c4ce2e5e..e4c46e2bd5ba 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -951,6 +951,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		put_page(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_release_pages);
 
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1114,6 +1115,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		bio_set_flag(bio, BIO_NO_PAGE_REF);
 	return bio->bi_vcnt ? 0 : ret;
 }
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
-- 
2.24.1

