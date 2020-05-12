Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A227F1CEFBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 10:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgELI4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 04:56:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16035 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgELI4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 04:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589273781; x=1620809781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OxG58gmQxO/wsNKD46rcb3CCQQtQoICGm9rQW0sMuDY=;
  b=O3G8cn82pL52oYH6XS89JRNDArgz1jrp+oGrGc+icESMttRyxwAWQsf+
   MLc8KQ/3QpH4tG45LuymEbTzn8c4HTHoWOOqdpNANt26uHPIUUwcgrX6c
   EgCITunfA9gXmbGUpp0Rnv5swt2CX4kxLDcwyv6oZvhIe1zdNSHhKnB7R
   /ktnoUaNo0OjcHJ2jjDvSn+ZMqehOBBmqYOeZAbQ0d8j6/KnWlFzvy6ca
   OFUHH6LsD9pyYLJ2N0hMvUdhP9hrhEYxx+CXHoqW3yFIGjmpLBpPQL56a
   7IRtscD8uj3kXkCcugKvDiDBixQ1OIpwJXIpCRnbwtBeda88txzyUvmBA
   Q==;
IronPort-SDR: p3i8mkwVJnYAP2euyf4jc3zLAd+5ogAsxdH6TJrE7aCsCN0ROLKRzkBrddIJVsVlTQJbEKZHrz
 Sl3jG3JQx8nr/CEcLE6isRc/+ln0GvxI9PmBGVIaO+x/Rabc/ki0xeR40rtrFJZXXVddZkjj0a
 fFfr/Irm23pDdHKIFV/bpsdAKVkefp66EqXkf9NXIDce2LPhbgxCjc0HFy6AYLxCdEjQTa7CUJ
 DPchm0vZkLLUelSWtHCfjpz9j3uI5DI0V5vIsps22z6vY/ZvOWfht5P3tjls6iICiFeCebbrmX
 zkU=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="141823571"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:56:21 +0800
IronPort-SDR: ScoxW/IOyA2Ag5sV+y7yfSF7wkD0nUabxiW17Cl3KeeLArSjimZhd/EzXDeYLcZAIgsShWqzMO
 TER2hG+qq40fugxuFFGIEP+6zL+b6r+yY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:46:03 -0700
IronPort-SDR: iAAE5ms6Ynm5Lj5CMF2vunRHavFvSZF0pMySOoHCANAt+Cxomo4cCNENFCwGqVk/KYP2n8HSPY
 rpmxSf0X4n5g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 May 2020 01:56:18 -0700
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
Subject: [PATCH v11 09/10] block: export bio_release_pages and bio_iov_iter_get_pages
Date:   Tue, 12 May 2020 17:55:53 +0900
Message-Id: <20200512085554.26366-10-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
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

