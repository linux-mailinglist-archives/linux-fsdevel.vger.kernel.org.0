Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58E266765
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIKRmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38451 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgIKMhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827843; x=1631363843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u23e3WllPu/3rko2m2r9M+D8jYbtSHTDuV00w5bX5wk=;
  b=jWe9Oe1txJdlZy/b3Bt7FNH9EGDAdsDjuBJfDnKWEcENOyYi302fs0Nw
   cia8D24guDjUKNNJ/hojVmCWkC+ze5rITpwCJr7As9fBMihbk64m/B61e
   zEcHSm/sUYOSzP8IYpACO+MYC56SbC0ZR0gurHQQ/QPxKRPW8BooX1pbP
   uKNkFVs3CwWEkz0tCYx1rBvDvsodt8EDp4dpaL4jzBTYH4ObB0GlUm6eR
   tf2bNJeZEttL3uYRbicmF9f4+GA/JVq1kK4lvdpTLZFfirYZWsfsDzBK5
   bFE7Z3EQtG45JyAt+N/qTEq7nOzuET4cJ7aNgwO2uYRB6dTnMQmyOLC9x
   Q==;
IronPort-SDR: 72/KwMJJ7LSTfAqqTKrgc78IqpogTHS2W6Rdc7uGXn6fgqCw5QNOncm8+4fgaK0kBn6wHRsX3q
 ymIs03Ku28kQbJ9wfja5Xov4CCURHW/fGha70gsJxZ5xAT3Av2ttzFanpG+T7TFOb1v89iz7rW
 16/bSbV7fbNPEF/61RLiFpAgjyGBLi/4uJ1/sJLMQfPFBkTJkxVicDMDkaD5P7ttWJqPiQn/iU
 6jpfY4GPfkZbk6zofqzOl/gr/CCrpWLqYkcM1O7Ontp47SzqQxoyR3lOJcERHxFB9MsNkGxroN
 3js=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126007"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:41 +0800
IronPort-SDR: ycqnwhT8DIgQKX66ZYoS1CgVk59uDXbWqFPCd5DyOKqsMMhHR2v//sGjBtuLSFvg8CnmTlTIg7
 6Y4bPAa3kf8w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:02 -0700
IronPort-SDR: /EYgh2W1wBcOStpcNDs7LwzTWUD3E2SdpVRIUj5X0OLvx7uBLr57A2DT3lJGFQZ/klhF6wcqk3
 qnc660/riHRg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 23/39] btrfs: handle REQ_OP_ZONE_APPEND as writing
Date:   Fri, 11 Sep 2020 21:32:43 +0900
Message-Id: <20200911123259.3782926-24-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZONED btrfs uses REQ_OP_ZONE_APPEND for a bio going to actual devices. Let
btrfs_end_bio() and btrfs_op, who faces the bios, aware of it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 3 ++-
 fs/btrfs/volumes.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6337ce95a088..ca139c63f63c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6453,7 +6453,8 @@ static void btrfs_end_bio(struct bio *bio)
 			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
 
 			ASSERT(dev->bdev);
-			if (bio_op(bio) == REQ_OP_WRITE)
+			if (bio_op(bio) == REQ_OP_WRITE ||
+			    bio_op(bio) == REQ_OP_ZONE_APPEND)
 				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 88b1d59fbc12..fc03b386bb8c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -410,6 +410,7 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 	case REQ_OP_DISCARD:
 		return BTRFS_MAP_DISCARD;
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		return BTRFS_MAP_WRITE;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.27.0

