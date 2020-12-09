Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C313D2D4140
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgLILip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 06:38:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41844 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgLILip (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607513924; x=1639049924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z8t6fXgsdr985qUyqYggTJ5LOO1pxCv3UiIIe+ZJVAo=;
  b=eBWY+8+PPznX0k62tlT5IIAkEtkB/wY2o+qU52nwkEVu3kiUTTUquX9K
   NNODi9VZBg/8l18RE+7PyJIcBQDJ5nmrobr0Mt7fNdzsRJNXmLWli9ekp
   9WVpd9RhSpFknfZbl0b5XVLAG2I2VsluwrrbdLP5FIo990SO2FHqOpb/e
   /3L4xS5b2dtscvJeVs9m/wPSWMy5UrvRqmBTbiNtXmR7Uk+q4EvTLRubK
   ysKFjPi2JBQDdXX61jHRClDCQlwAl7p9eMLPrtplqsvocQH4WsLvK2MAU
   vle5GWyfiq94s1ynY5spU99iOctj/UAxa3WhzquHyc5PvNsCV8e9mc12f
   w==;
IronPort-SDR: pjOzd7kdFqOMhHpEl3OgG4ayjCUwl77Sf/Cj0HGrWfVmhaM36eMr1kVHShCKtyWQ9BvAadi5RF
 ysbAbVXJF4cQfmJl+krH+h1zBSFkbaMmnGFz5gV6EJV2VouDnzGBt/+mi/rhsb9SY/ey6Gk4CQ
 TZjvbrKDCQPKimBCpdZfb6owTG2kf9Vlo2ThzomfbnfDhsVCQyekhEUPAn5CpBO0YhWH0/5974
 iSE9qs6LFmem3PUF7sDs++rZANSiZfyZwC9dGJUmdrMYPHpAsBd8H0M8GAp4Tk9wUMjRES2XtG
 znU=
X-IronPort-AV: E=Sophos;i="5.78,405,1599494400"; 
   d="scan'208";a="159226578"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2020 19:37:39 +0800
IronPort-SDR: Iqj4ykmNIOsCMsQnv7a7nzw0AIoIbwBBCUxLMiJUry02XXdvO447HqWT3XywgTFv5HEeJgyWXx
 ITXTaRRWloYFwYsNcQ3eAY/IsDSesY96U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 03:21:36 -0800
IronPort-SDR: 9HtDum8MMs2W/NvzwIzRH0sjAZRCiaBaBKjoZsLIynC6hNGixpEz3wFuEb5JxqySbVZFYCEwF9
 pumIVg4i7cNg==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2020 03:37:39 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] zonefs: fix page reference and BIO leak
Date:   Wed,  9 Dec 2020 20:37:38 +0900
Message-Id: <20201209113738.300930-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In zonefs_file_dio_append(), the pages obtained using
bio_iov_iter_get_pages() are not released on completion of the
REQ_OP_APPEND BIO and when bio_iov_iter_get_pages() fails. Fix this by
adding the missing calls to bio_release_pages() before returning.
Furthermore, a call to bio_put() is missing when
bio_iov_iter_get_pages() fails. Add it to avoid leaking the BIO
allocated. The call to bio_io_error() is removed from this error path
as the error code is returned directly to the caller.

Reported-by: Christoph Hellwig <hch@lst.de>
Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/zonefs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ff5930be096c..eb5d1db018e1 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -692,7 +692,8 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = bio_iov_iter_get_pages(bio, from);
 	if (unlikely(ret)) {
-		bio_io_error(bio);
+		bio_release_pages(bio, false);
+		bio_put(bio);
 		return ret;
 	}
 	size = bio->bi_iter.bi_size;
@@ -703,6 +704,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = submit_bio_wait(bio);
 
+	bio_release_pages(bio, false);
 	bio_put(bio);
 
 	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
-- 
2.28.0

