Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D614DB14E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347832AbiCPNYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiCPNYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:24:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86A64FF;
        Wed, 16 Mar 2022 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647436987; x=1678972987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lhi2nnAaW5WDGC50h+Y+39ChFJieqInTYmGd5Oew2ys=;
  b=PhebxgaYhEYCZOPxbYO8r8qS6xIIHlr9w4Ot/cBygITV1A7KH1lrevbw
   CtkDz+2mH8ex7VIZs0zAvIyK7Y6Y0U8WDO+xvevAEZbgVDj7/I61sTGsK
   KkQwkxzr0qYqz5Q6YS4LMd6vyjruDxq1LzOECO0WcALsd7dckS2+eLnqq
   ZS9OvYpNFrfq0WN5nBGsqAO5wgv0DtBRW0tvZe5vXEy4a3nLP1j54m262
   FXbkOCr37uN2QS4SsJK2QWOna1zOPRCRAAZZkQQCWiNAVGc7T3FGhMvFF
   svfdFizN/yKu1KnjHTi4GL2UmABUmK5V9BS5yg68T5J6ogDJO+uA3HgHz
   g==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="299654873"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 21:23:05 +0800
IronPort-SDR: RyI/pAngn2No5hbBIBYmNZ5fP7piGxzXagkuhzafh3RTliEtxYNe6qCG3WrDHJ73k2WuEisQK/
 /sCuw5mrMp9xP9HyIcO2cYQDzFuwHYH89SKs5q4y8pYSjxs+xkX40sEu2U4IJDiGkq58YyFlMk
 A23IUg3cEBFGitbbDc/VEZwMqCzdm3Vkr/Zq2La9jNUfF338dMsG1nER7netvyJH1YIWEjQTgK
 DaqTWm0SxwBV7sAOvsgWg91vNWfST7y9u6+0JoYjlbABMh+rJOLbIhcH35CWY7fiKeviR4944y
 0Aeug/yLZLm9M6DPVsTN1rc1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:54:12 -0700
IronPort-SDR: oWVh2WPrHCoYwaggq2JfUbfQgR62FTJNIxC0mRjxlu8/OqyW6GMAWv1JnvESn+mdJh3LNxwoZd
 HK4UClDFndUCfG1ajewZVM+lZTpRgnOGnHh9/Zxf2/g3RzI7gf9OeWkIoB3mPDYZ0eWAtXPla4
 uTxKkOZtLkeQRMalNPnZxtvfZF+htn4/SgvljoKoLZLNMA8J+cqF+d7VUu0MnXhbbucMKttaDF
 VYTWTIb9wGv5Xr8UkMD14c473GoPEuoJ6sZOQ0CAalZtDJDgOFesYWzGvOlXRAKYavRTsQtrEC
 BF8=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 06:23:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/4] protect relocation with sb_start_write
Date:   Wed, 16 Mar 2022 22:22:36 +0900
Message-Id: <cover.1647436353.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series is a follow-up to the series below. The old series added
an assertion to btrfs_relocate_chunk() to check if it is protected
with sb_start_write(). However, it revealed another location we need
to add sb_start_write() [1].

https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/

[1] https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/#e06eecc07ce1cd1e45bfd30a374bd2d15b4fd76d8

Patches 1 and 2 add (indirectly) sb_{start,end}_write() to the resumed
async balancing and device addition.

Patches 3 and 4 add an ASSERT to catch a future error.

--
v2:
  - Use mnt_want_write_file() instead of sb_start_write() for
    btrfs_ioctl_add_dev()
  - Drop bogus fixes tag
  - Change the stable target to meaningful 4.9+

Naohiro Aota (4):
  btrfs: mark resumed async balance as writing
  btrfs: mark device addition as mnt_want_write_file
  fs: add check functions for sb_start_{write,pagefault,intwrite}
  btrfs: assert that relocation is protected with sb_start_write()

 fs/btrfs/ioctl.c   | 11 +++++++++--
 fs/btrfs/volumes.c |  5 +++++
 include/linux/fs.h | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.35.1

