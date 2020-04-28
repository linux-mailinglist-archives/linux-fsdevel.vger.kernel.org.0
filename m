Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4251BBB88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 12:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgD1Kqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 06:46:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15241 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgD1Kq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588070794; x=1619606794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4KoylvGM35+I3CCYZ1pHkVXsr4zw0ijqlA8dkmPggnI=;
  b=gxy+r4dTxEk39/O4fsyV9Ok9cH28PnfljGN8hgYZ06hc1TwHV5WBQa+o
   PRatk7PoJfu/E3RVb3gPlec8iSrbz4LnawfUHhZx3SDmxjuGv/022SF4+
   Tbz3XOhcZwtPzyQ5Lr7YrSkyaFDZZNZa+3EoVDjX0W33VRwtxPI/S9enI
   TZ0R85lD91w7DRaj4OR5IavfydXMGTPuxkMvDDTaMCq3T12msrcwP7mWg
   1UVDUHFK3HRnJjxHFWtgb6MWQUppRRB8WKVhoXUMOq6Dx2F7ViVNic8fU
   N1VeKM4QNnwYau7ViyV/k9XABs5tOafZqaolIX9lP+K2w3KfRJP4TTvcL
   A==;
IronPort-SDR: roo61yFnv+LB9BPdFU++4Mt01VwO6H41+qMX4JW54FYh602T8jCjsThtdzLzUTME+qCqS9MbqD
 hfIKIOylvGsGioT+nqqsh5ZmkM1LOE+Md3iNHS2aO7TQz76eeaRbVsfBL0dVVyYQ/Oyf1Q7f2Y
 JdY/vyDUAjqKEwrSZ6NuNumCnZe6xHLBj6/C0zMCcmQbN21ttB+a8MoeRwMHY1qgG8094AFZtU
 Ex4aJ00byKSg4ztMgKO5ih2S47ckuSqd/RchpKb+y/rWUZm5eCjm6t01Zuxl0OJbCEVcOOK95y
 C2o=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="238886599"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 18:46:34 +0800
IronPort-SDR: Q3HyToBMIVK0zm7aQ6phTqE7wVUU4zeLeCur7+QQ7gXOy+15wmrHhpFPLcR3qdmhVj/SyDS10q
 eLZMNrhApTreJLI4gxvSC+pjRhm8+fXEA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 03:36:36 -0700
IronPort-SDR: eX95PBgu56KGpCTyZGIYyTgm5R4WsTJQx0uf+5AG5/8dp1pcUBL98jqHcJzEv5og8nOyq0r9Pe
 Nhysof7Dc9Iw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 03:46:26 -0700
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
Subject: [PATCH v9 10/11] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Tue, 28 Apr 2020 19:46:04 +0900
Message-Id: <20200428104605.8143-11-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
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

