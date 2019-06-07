Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705F038B73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfFGNSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:18:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56474 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfFGNSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913527; x=1591449527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=USN6rEALIg6DXGN8tesjcKQiWrb+oKgfNOsJQAIlJpY=;
  b=j/ia6CjyvdTRUluv0mkHo0/NcHrheAm7T55UJ2zK7eLBoQHhg2qgWPXQ
   Q9d2964eZYh07qg1zXQ7cjndHOOQDixjol4ven8lV2JsjhyAqr6LVdWQv
   vzJwQH/I4yVTd+vXvoRPZnoD2QDiGlxFDuH0mnBztwrP3PD9Q7i/lAwfu
   tBwOruI/UOkCxotifENbW3Hm5CuJfZCnf8NI1n6Id7Vlf6Vx9YAi//U95
   3+8xavkW4DllnljEg4q7zW2GBnHqt3a/pYTL2zHQLcLMXrtVR2zJdvaZ4
   LMzgZhK3oKpUYeTKc12rdD8IBnUcDDwb724D+0xsHY/Hs1H5ZwQfLgf7l
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="209675005"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:18:46 +0800
IronPort-SDR: ZFFN9wfnrckh/kPPFPSJhuRuDuH+D4SPRhQxe4ksJpeHmp8G0EF/1qjbh32KeaTBbHlGj0wlhk
 811nLrAd0swD8++b6t7Rdq91JDdJV1dx+t6Q2cHQVO8Wdu24seYJLuiJUNqCs6TQ/0+ifI+7Q4
 RVnNNkflPOYTKzHuafJzdILp1Ah2WjEgj5pB9BkixWNXattMziZTGHTGKfHaA7oSzvVoMigz+m
 korJZxdfeQhHnXiwYl0j91Ju6voUCHJ5q7mGmccJ3/I5jnNPRfAi0N+HfuOa27Qyc4FCj3ohz+
 ootl4IMpe7d7PxslvS6zxQI9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:55:31 -0700
IronPort-SDR: ilYLTBqhqUPHW7ACJRfxQ87dXLApIggwra3dceiCoshC2+EcCZNFHJRbIuZLRuHRTKVFNDqr6O
 +HtTWQEN5GRP5SKvGCOBoQBaAIXKXgFJ26vexpOzQKinWoBUSI5mRYimRGhowuQlHnYx9OEY2K
 /YD6rtJG5fy6VYhApsElYuFLB/5DGl2e6aIajyn8hLNCKvdqSOqXrxmP5KSNC9zRrePGRJjLEr
 CvieLuLgiHTSzVS6YuNK781rlQ0nt9HM0iViCi293vFQ5u1K1/Stxfrv7KQGtLwb5sHhJLQnAA
 6no=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:18:12 -0700
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
Subject: [PATCH 06/12] btrfs-progs: avoid writing super block to sequential zones
Date:   Fri,  7 Jun 2019 22:17:45 +0900
Message-Id: <20190607131751.5359-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131751.5359-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131751.5359-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is not possible to write a super block copy in sequential write required
zones as this prevents in-place updates required for super blocks.  This
patch limits super block possible locations to zones accepting random
writes. In particular, the zone containing the first block of the device or
partition being formatted must accept random writes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 disk-io.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/disk-io.c b/disk-io.c
index 151eb3b5a278..74a4346cbca7 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1609,6 +1609,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 			    struct btrfs_super_block *sb,
 			    struct btrfs_device *device)
 {
+	struct btrfs_zone_info *zinfo = &device->zinfo;
 	u64 bytenr;
 	u32 crc;
 	int i, ret;
@@ -1631,6 +1632,14 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		btrfs_csum_final(crc, &sb->csum[0]);
 
+		if (!zone_is_random_write(zinfo, fs_info->super_bytenr)) {
+			errno = -EIO;
+			error(
+		"failed to write super block for devid %llu: require random write zone: %m",
+				device->devid);
+			return -EIO;
+		}
+
 		/*
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
 		 * zero filled, we can use it directly
@@ -1659,6 +1668,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE > device->total_bytes)
 			break;
+		if (!zone_is_random_write(zinfo, bytenr))
+			continue;
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-- 
2.21.0

