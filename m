Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D426675B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIKRmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgIKMkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828017; x=1631364017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OJptT2hjT7Q8ki1tbMIvOuOMASPmIsPauAsPnYMRO5c=;
  b=Tqck23hpUqs2B47qiDj869ESOYkcogc42tzIphQzLcH1xqbvnyFXuKhO
   FfORXdtRVsOIIDyMAmyytCe0jLXtybWjiEHFsShHHlIS3Ayko6L3P1HBD
   LDZyTH7YJjDCGDU2/0sznfmoiNpuIrSbuISU9vkHHoBMWufOu8PKe1klR
   hh3be8rVT/6NMFZ9kRBR4vzzCz7sCzoifyVi62SzLTRx34rBDDMHVoaTN
   x0UVC9i44sdFLhZlP3qZ7mCYraN8LRd41rVeGm2Sxm0QbK8P8mTkSUO4j
   sPE7IbZU81P/1FLSWJuz+q2Chwg5MNjuEerT2HmY8amLqQlaqo2nEFQkV
   w==;
IronPort-SDR: T2wtIZzmjT/rbbaG73/Iy3MbDPHANJb72cuWjoZ75BPw5vDO0S1Goh8uqyX+sRxAz+oPVIJuLE
 Rup5LKENhHRm8y6zEME+5FBopJbOr3YhyD1QBsT2nVFSTkv9AVWZGKLotv8K/WAkK4rAwTyoBw
 g2H2SO7qrj0lMrCvnrqZLSa64Uw9ricJqAVV2TYxv3dOd+YEFV8/DiejtvEXKbqWbyYd9HrroE
 CWBl2I/I5MsIkX6Nm4oLNlixOV1YU499aFYEJuTELXUsP6RMYzV9SdTkuyLzS7zg5KQyZ8GkNP
 5mQ=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126018"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:47 +0800
IronPort-SDR: trG2Do2LjEyopDfyiHs3mt1JCu3CDBZtmT80CjtSreOMsQh/0cr6IBVvQwj1V1N4Zdu4qdxTCB
 d4DI/ziJxZ+g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:07 -0700
IronPort-SDR: OKMcWla4O61fSOwlSfE0Qwp/cL+VTBir6NyU5QZEt+yo9Qx3tz7snqSjmNGawnoYdOU4/2/rYA
 3hciq9gR1xGw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:44 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 27/39] btrfs: wait existing extents before truncating
Date:   Fri, 11 Sep 2020 21:32:47 +0900
Message-Id: <20200911123259.3782926-28-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 2bd001df4a75..7e1a0a5a6e55 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4883,6 +4883,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
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

