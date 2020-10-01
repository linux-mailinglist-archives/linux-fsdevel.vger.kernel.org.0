Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FAC2806C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgJASiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732894AbgJASiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577493; x=1633113493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgEBWgJSMacwtA3SUdTXH5qAHlX9ODJTm0ZOwmpKHYs=;
  b=gMOl0crI3YZ6k+Q/Mq/L77AkPjATfsh6BsGK9Ln1i9NnrjBbfZ/JMC1W
   dcQKbx2X0KM/TqCMldGNry81COnNCdHEDw+dzAWlDMwc7zSm9duuO990g
   7Hanmx+fXJ7rJyWLrTRxqOkdTykW9oPw7GneMwBDJIE6iqYMSJoma5PtI
   YP8L85Jf7O3e4Rjf6SAzm1ZPt/B2an9/lij05S0TgP9mT7T6aRWUlb7Wp
   jJDrdeGsRR4UbY7295um1jzFflLobVSlHzd3/L1VTNrgNT3O5Pe600ryT
   qUYNLydnPFOBUSY44ouQIx/zhIc0xBt1PACUNW7YPW00Wd6AzwOuEmK4D
   Q==;
IronPort-SDR: JjPwzCMLaqOw5+PL3ciYoXa9fYZ+TB4H3hgv75QaO64UtD4L4DIUw/5IRkmMHj8IIj6QJDeqq8
 dzv5Ct1nQ4IY4naww7pYHWajhbCT+EI7bsRRbfUO003oWmoM9Nis55iI4hmnclu51WAFE4Y3rJ
 gw0p5etog2QXDhzYJR9t0DjQmGPAbJlgGJoAK3agCd06ni0KClFUh0Mg8Gxscd49VhxCLIhNxj
 GKb48U1wsoYGRHyoxAQZ4R+yz9iTc4S4Ri2L7EX6bfNeAlXaMEfXs/8CxXLJbwrq2yJWdXeMDl
 sp0=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036790"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:13 +0800
IronPort-SDR: xAqLW8qa52557hw5RspC239GR6UspCPKK0jCRN+2VE3ltwhrt1o92O9tWgyHR2D16ef8D0K//s
 5vPi98cpVWbg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:10 -0700
IronPort-SDR: xc4RgaAzRd6qlo6VsUYb0UGcTD/0npLCT+R6bBXNqkLyve2DOU++SD37nvkF/ylxoJfArG03EV
 oztc75rvhsiA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 10/41] btrfs: disallow inode_cache in ZONED mode
Date:   Fri,  2 Oct 2020 03:36:17 +0900
Message-Id: <4aad45e8c087490facbd24fc037b6ab374295cbe.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_cache use pre-allocation to write its cache data. However,
pre-allocation is completely disabled in ZONED mode.

We can technically enable inode_cache in the same way as relocation.
However, inode_cache is rarely used and the man page discourage using it.
So, let's just disable it for now.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8cd43d2d5611..e47698d313a5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -297,5 +297,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_test_pending(info, SET_INODE_MAP_CACHE)) {
+		btrfs_err(info,
+		  "cannot enable inode map caching with ZONED mode");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
-- 
2.27.0

