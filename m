Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5B2D506A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 02:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgLJBjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 20:39:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26035 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgLJBjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 20:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607564379; x=1639100379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AFI6it6kJQ2psUYuzLxZl39WwEf1xh8hmEOpoaEid8k=;
  b=lhlU+Y6DoABH+evwUjOIPSrIBwCTrAbUS54CVEA4BKGkTrGNxeWfQF0a
   doPpufGEyG/h7PDB961KIuastbZo6TxorH40LQJNqHZl17aadGH0E1s9S
   6HNcb2KsjIY9jvTbc+lEqgcOdRa7CaAZEYYa1/2VHBK5xWZ625DLQ1qq7
   rgoTTObkivMcyr8Q2GqCYFlm6iuIbWMECf6C1e13Z/7pku3Ut3tMPNHHf
   /306sPHC2Bj0RKYAYKAylGxcv583wml+tBTKuGBhaLS/citlWB2HcSz1N
   egyemxVD3by8ARycoPvWtlNABOWWeO1IOxpCVcGwnrhENltDji8uXALwF
   w==;
IronPort-SDR: hS5ZHT20MPiNYaPkN9ogEzgo7LyHSMFTCviJYewCLpQ+Rjf6E79gVePDqTHmlFULp4fuuahEyg
 9bzrGDpYgjh6F7M/VIMuzWcdvxhhxQqKrZCVftUTFICAn/taYDd2sA+ggqrRg8MzwYrkcJqRFk
 +K8T358Nx5V6+85qQ7btMJKg+EWFcLqc+4H4vvkk/d6+Sch3drbSPAF9mGb2IQYN+8Y6tDV3qs
 rlWvI5KT+u3rWQRnIZKySJ9mRTru2N+KuNil5GlUWmHjLHwIPxBrRpE2rZe/ct+sm6wGqe8bu1
 qkM=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="154863920"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 09:38:29 +0800
IronPort-SDR: QHZ92ELiSb4BzQl4eb0hW6t+mIm8+TCYex+buyezSoP0IbryO51KIg8NZuVs1hkxbFQuWwRzyp
 6rNQX6gurmr8WP4jsyPcUUXcRIxnijWcg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 17:22:25 -0800
IronPort-SDR: RK2neKfWyNFmkNvYQ7bP7pi/mPzXjWH6F5y9TFO8nAqZz8OyBp7Kw7iUyWUJojIADESDW2AbCl
 qNybDX0fCh2A==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 17:38:30 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] zonefs: fix page reference and BIO leak
Date:   Thu, 10 Dec 2020 10:38:28 +0900
Message-Id: <20201210013828.417576-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In zonefs_file_dio_append(), the pages obtained using
bio_iov_iter_get_pages() are not released on completion of the
REQ_OP_APPEND BIO, nor when bio_iov_iter_get_pages() fails.
Furthermore, a call to bio_put() is missing when
bio_iov_iter_get_pages() fails.

Fix these resource leaks by adding BIO resource release code (bio_put()i
and bio_release_pages()) at the end of the function after the BIO
execution and add a jump to this resource cleanup code in case of
bio_iov_iter_get_pages() failure.

While at it, also fix the call to task_io_account_write() to be passed
the correct BIO size instead of bio_iov_iter_get_pages() return value.

Reported-by: Christoph Hellwig <hch@lst.de>
Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/zonefs/super.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ff5930be096c..bec47f2d074b 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -691,21 +691,23 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 		bio->bi_opf |= REQ_FUA;
 
 	ret = bio_iov_iter_get_pages(bio, from);
-	if (unlikely(ret)) {
-		bio_io_error(bio);
-		return ret;
-	}
+	if (unlikely(ret))
+		goto out_release;
+
 	size = bio->bi_iter.bi_size;
-	task_io_account_write(ret);
+	task_io_account_write(size);
 
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(bio, iocb);
 
 	ret = submit_bio_wait(bio);
 
+	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
+
+out_release:
+	bio_release_pages(bio, false);
 	bio_put(bio);
 
-	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
 	if (ret >= 0) {
 		iocb->ki_pos += size;
 		return size;
-- 
2.28.0

