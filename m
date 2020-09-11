Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189EA266745
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIKRlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:41:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgIKMmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828124; x=1631364124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4XBBV9Fp6sjoRwi/igxARQSGbC6vCYxHPBzketHaDMg=;
  b=MadKBhmI5V7x7zSTg51w56ZD2ENHDWg7G5d/SvNU+ed/RDRKvMkJVhRd
   KHHXC+lYBfl6ypWv11RaNr3hDNaqSJQOoGO4hfMd8vGJB7A4AZcU03ZzW
   0GodF5ZMsDG5qKB40VLubC7XkGRQ6I/0c7sLP7uBDQoi0CvXobp+jZNL5
   8FaL2DjSVNBob9CebRRWBvS3edC+aC/bNEl7tn9pTPjaZN13MdWdu22y3
   gT1egDCfwnojJcqusyLcF7xZAH2VTUjXITHH0M3V9QETcvdF/toqk2Xha
   wQmrTt4qXTwJ8LS7qUWBvthkdrloqTP33HGWYKAgk56+fupRsU20t+SBq
   g==;
IronPort-SDR: 9YLGQ8SftZ3l0mSPqWZsRHT41JnGu0ER83yjDDJuTmlQ8d0aO0xWbQ8amPCT4ZuP0VRykdmFQT
 RXKI98zISp6XfNZ9gOn2LERxHT81EDG+rEPplz1bPhkUWpO32bUBBfktDs/D6GqjVZQ4opqyJe
 aEI+UOj+QpVm7pGEfJSUSNZs7T5y+oLca98MGkvd2nLjRpW8Oeo17/AWqqIIfen7DIpQb09cC6
 y/NFOcB5E4l+n0Zgnhrb/noOc4+T0KwTlcoq4kNLwq0sL31CjadSMEeX0WXf5w8asPmrIlbO61
 rAU=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126054"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:34:04 +0800
IronPort-SDR: TdKD4AgQtykkG9gvQrxgnwoHqbIkpl65PCvPHxwfdVIoT5asf1Ymeno2X40lRyB3IRfUjXYHIk
 /nZYp7Qe/plA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:24 -0700
IronPort-SDR: N0//q2KoYG7BBS+QU9ezO0q2sv2T3tkxv2q+/TzSU5jevXUpPY0eeZDRbgFz1bWUwSlUGjKD88
 0z+xrTiCLzOA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:34:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 39/39] btrfs: enable to mount ZONED incompat flag
Date:   Fri, 11 Sep 2020 21:32:59 +0900
Message-Id: <20200911123259.3782926-40-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the ZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount ZONED flagged file
system.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6e05eb180a77..e8639f6f7dec 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -303,7 +303,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.27.0

