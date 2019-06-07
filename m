Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1838B33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfFGNLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfFGNLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913094; x=1591449094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p8z3jb430Qgqzm++OBw+hFbvq/mvjn8Ir5DK424mBcI=;
  b=XTmOTyuacwVz6PZE8MaxhvlF8/0GtheDkb0wCKs1LVlkjIAQSNVS8/5q
   8GqveWxvWm1XqIfar+o0dxcJsLP//xNdj86GQw3hRRL49rGJDLc9L/2T2
   FqXLX0Le5C/yPGSx0iPff9I6K5fwd5a5Sm2ejGeaq2ulGoo6EF67CnOhu
   qvHbcCZBmEy7Ib2vXVuyEGcmOoLe6JjlIx8oCggc1SnM6utsb/rI2aQ/A
   jMII433QNUkgU+yCTlsw2Z6uYbgEMFs2t9GaZxyIlREMlCRB2pPp0agZM
   9MDbhdtxb/bo0V1VxuXw4BFfFphs08kW7hf/Z0F5HZ13a2piMB4v1VnB0
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027811"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:34 +0800
IronPort-SDR: ripgf24P5iEILz4XuvxMxYsrvrXtIEZLdESfBqI4FyzF+JDUpPr3k307JQ/i/szMqdOXVLK87D
 8db/snQbGRk2H0Re4mAycMKkgTYES5SjLpA0/7ebtg3nStkoUsKFVmID1AAeN47dg9ZsSEGVmU
 x9toFEd0Ed6hhTsTc7ntKepfD5pwGikGvW+SqFivwtz3YgOjPGaOHrS0SdEuhzXtf4v2xx5/YN
 Mcx8VClMhNnkUd2jQuPX0Nlfrz+9RkbPyWNs/hB1alPqmox7JYN2ZS/hrf6LgWWrYwaBpffELF
 8/zcCYdaKtGhpTbaYwg2UCz+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:51 -0700
IronPort-SDR: 8ZW0jd7H9HZ7r/JhlmGNBuVBz7JFaYUZwT7cYlV5evYbYvsNzZfklaNova3j6NeVtPN0gHBds6
 8Xdx0LbkmzMwqBElW1LE4bbcu/EM4OWVivVDAiIKQ6jkrnEFAU7aYcc5DJ9jkSx3WgPNgPXIMQ
 LlKipULqUQzyOSY/SFRoipc+7JUvUx5AuWIakyz2gjaOweehVUo01Iv3geCJYmxrfuyWbN4c4d
 IMhaRqfZsstKH4f0pjwxgY5W0XTVjv4lrW50zyQXCK2zeCDztcmLLiIhzVmS0H0nhDcjs6W9kc
 q6M=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:32 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/19] btrfs: rename btrfs_map_bio()
Date:   Fri,  7 Jun 2019 22:10:16 +0900
Message-Id: <20190607131025.31996-11-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch renames btrfs_map_bio() to __btrfs_map_bio() to prepare using
__btrfs_map_bio() as a helper function.

NOTE: may be squash with next patch?

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c1ed3b6e3cfd..52d0d458c0fd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6808,8 +6808,9 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 	}
 }
 
-blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			   int mirror_num, int async_submit)
+static blk_status_t __btrfs_map_bio(struct btrfs_fs_info *fs_info,
+				    struct bio *bio, int mirror_num,
+				    int async_submit)
 {
 	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
@@ -6884,6 +6885,12 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	return BLK_STS_OK;
 }
 
+blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+			   int mirror_num, int async_submit)
+{
+	return __btrfs_map_bio(fs_info, bio, mirror_num, async_submit);
+}
+
 /*
  * Find a device specified by @devid or @uuid in the list of @fs_devices, or
  * return NULL.
-- 
2.21.0

