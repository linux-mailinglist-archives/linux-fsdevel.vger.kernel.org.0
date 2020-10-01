Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE492806E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbgJASjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgJASjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577542; x=1633113542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lF+1gtKcY/8Ddsnnjdki26oFBUL/Pm8XsVg1+Bp/B6Y=;
  b=F6xAoSK0iyvfHssbUUZ8ipBO3KOBW+zrZhLRLhyzzfusThC4AymRhgwH
   I6xBfcvp4+Q1weF0gdolTs5g9Y54Hzi/dR0kS5bq3NV72KMq30EUCf+BB
   TSnQh8b4phGEMX87SWOpelFd4Hxicx1Cc6diiqcnJZ6AXzvxsLkwScn84
   nfw+GBaPy5yNKaXX291T0Lcykd/flhuHON92pyTGz3nDuRZDF5YAguY5+
   g4wb2rqKoeGTQe/QfrDsPNUR740XghsA8xu/VIJ0CSIfPBal2YW0k1tKK
   I8qh69TWjmLCb2OTKeOyLdN4sHq/duS68MW3LfDf0w/MYTGPdhykBNxm1
   Q==;
IronPort-SDR: EOuIBfA0BYAlrNvQljdPI4hZ241vzjcN/wo9bYWIFRwDisrQJbwK6ss0NduttR7QLdT/D5vYNC
 wUUOZCx4q9ZCIZMdWhxhEh8jLP7ZUJK35djgRt5tx38hR/JM4ANhg8Uetlmi+1uEGgqShPyeg2
 gXo4tb+trhKOo+xoVl7rO34+9kCEc928VeK3j7UfMEwIKj954K5SRuSV2JT3laYG/j/F0CFBcA
 asmcF0cWqhJzBfPlRRfshv/zb/uVqBqFh+eTXDwEPh2silsskqjY4YSzn5PJeg4y3Jj6gik2Y8
 iFQ=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036823"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:35 +0800
IronPort-SDR: E6drWRHrV1IYdeo02n66apWQInNXe25pED2ktIT8/MOn8LSF4UgJDFuzWGtqtdzGTFVZmH9N32
 xy4dGbCQiu5g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:32 -0700
IronPort-SDR: K9tu9LXXogV7XQSVEG43BQKOPg49OjpZLovX8ruEDFYHwyVvJkSA983NtJFrP5bPMxMXbUbdOd
 0TxQ19t3X0aA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 29/41] btrfs: wait existing extents before truncating
Date:   Fri,  2 Oct 2020 03:36:36 +0900
Message-Id: <e371de561d618dc1c9f326bd55c289ad8e607123.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 46eba6c7792b..40704b61f582 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4953,6 +4953,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_fs_incompat(fs_info, ZONED)) {
+			ret = btrfs_wait_ordered_range(
+				inode,
+				ALIGN(newsize, fs_info->sectorsize),
+				(u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.27.0

