Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2E266789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgIKRo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:44:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38370 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgIKMeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827657; x=1631363657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+eY6whLDHc/YKQ9K4YyAddscKcqtBOgwR1sNKYkpH8=;
  b=rZk2TWiEQqXKf5I1ZsxF+vbYznrCUCdVGPEAZLpxYIwtoburmOF8/mZA
   mjd81ngIiW/u999tNd/NtCPiVtJ2QtieqIeBpRL0HMNICUl1maSxyQmAf
   HeYMmrK5tjgbwpyO3szTvh8LJtGabmVafUlYxgpP4qUzQlNUboeNIXxph
   EXJsnyOMGgFGgMRUmrERVR6q02aF1eb4nQwhFWrdJpZqF5DJJwii53sIA
   c98bYHbJq4ru2b3yW8q1uG613OHpJlDIhLIVe159rNrnjE8y9PyUs0jLx
   nDyo3tP+1kevfS8VGD3276qN4suBr22ZGEuco4VgGS6iHxNQNQ7v3hUfM
   w==;
IronPort-SDR: 12DQnn1IniLuHCQ9vhhw1w1WmW83JzGVxhlQrccTp7ezm9WhdxHfkPBaex7VKy/QJxIi8aBP/K
 V6gNOM5X8UPxgjVtqbB3cAvlloDaUkGeemohsnyLMXxGqRqOaBfkyEXMb/jBJbCEbauIaTu7fZ
 UT9X2qeONlXIV24YXmlP/HgSMPFTlIBC6NIGd+I0TVcIANM/XMYvs3NvGRJtz8vVuHmcbIZSZf
 cIs5J6ZvbMdMTM7s5SS3GeSPzWaNTCK4PmNL17RcMIFM/VoeNeKKvXtET4nLk5L8gaH2wdpKtf
 33g=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125964"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:18 +0800
IronPort-SDR: 6sOxySGaDcvVsMTIBADmFyi/SFfrTFRLArHoO+cgMQLWSg/zmac60F/yHTS7IfLPWJUo+X2n4D
 2mLo/0nQgTfQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:39 -0700
IronPort-SDR: ofowNukk5ASuU0CR5DAMDfiPbO78TOUgbW618Ec9+WiXi+RyeS5pgYeMm8MBlVvDm7AKw4fDvj
 G2cKSDFS/Uzg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v7 07/39] btrfs: disable fallocate in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:27 +0900
Message-Id: <20200911123259.3782926-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in ZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in ZONED
mode by utilizing space_info->bytes_may_use or so.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1395e537ad32..8843696c7f74 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3309,6 +3309,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in ZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), ZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.27.0

