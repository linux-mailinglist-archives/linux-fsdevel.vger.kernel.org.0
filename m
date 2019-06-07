Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A705638B31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfFGNLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfFGNLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913090; x=1591449090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKuA4EwOvjFtZaiDno+tWhs28ewLsbZ4n58bYeMECQo=;
  b=YMO8WDxFNolUvfQJ6XuU0X7sea41p4spoEP7L2yPcim6XDLD4iMZ3IOx
   5tHIup95RQcVjqSxzf6gDHctIW6jz3e1chNEw1qiBm/B9uR5z0FjsnCjK
   Jv9bZDt1pREw1PAXRBz4IZ+ISR2fii43cJjnIlfkJZy5Tio6cd4Bqc+rm
   JybUjBG452fxoQ7mZQz0Uq+ak4TDobRoel+cq3mCzpkgsxgU+F43V4QCo
   ZX59EH1MIiB3X8zmxNI4Zj9TR0kWuWlcHovQzYy9u7DdIaDH7Ge3vtppq
   5fEt03no47J1HgHv5PRWvwkllBw+mk0ffEQN/OE6HNko6xr6Jz1xppC4O
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027805"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:30 +0800
IronPort-SDR: 1OIfbapfZ8VtWUpKgs/7OA+qj6hUL6crUF1Szh9nCzI9txnhUlz5SDaPQHzJuxbaDj6gqeghRe
 cdtZZn9If49W1u9xT5hspYjnV2Q10p/U+rd5wjh428i88ET0+POnUEgmlK6Co2i6VWMiQ5vYj9
 y8GcFhmPXl/ZeiuUuTdumaoqvpAYwGwxDJXmSSEWmpudw5dxiDWpO95uIYHUe6ouC5+0Kpimg2
 FXc/tR3h4sxDPKBa9WONVkq8f4ACHDEKdHH2asZwUmCUdZV0aOsNpQ+aj6PN4Chchr/4+eJN+k
 qGxEhW0qIDTmu5WgB74zPzJK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:47 -0700
IronPort-SDR: pNdd9U/Q1+9d52KqBqHR5WKrQzu3sqL7DQ+1pWcp32GJBIpD+8D/yKbuS3sqOHQzsWAs8IjNjC
 v8mnxl/NhUtia31KMMF1zMaI5/6cy4WXzThfkYF5pg2DjBpBR7R5BAARVye/eiO9v2hHHcEevp
 cJYMvzeCbPlEtXr5fRIaNYF5vJWUosWF7oIAMrOzWi+7TIi9K0msaECOHvn2/DmlriPLE5chSA
 tNfw13VbK2wttI3hOh4cqc7mwXXouLxurDB9IMdw6L1apSdMx+FX753sD/+CNVN7Z9PSzpHEs0
 41c=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:28 -0700
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
Subject: [PATCH 08/19] btrfs: make unmirroed BGs readonly only if we have at least one writable BG
Date:   Fri,  7 Jun 2019 22:10:14 +0900
Message-Id: <20190607131025.31996-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the btrfs volume has mirrored block groups, it unconditionally makes
un-mirrored block groups read only. When we have mirrored block groups, but
don't have writable block groups, this will drop all writable block groups.
So, check if we have at least one writable mirrored block group before
setting un-mirrored block groups read only.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ebd0d6eae038..3d41d840fe5c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10791,6 +10791,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	}
 
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
+		bool has_rw = false;
+		int i;
+
 		if (!(get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
 		       BTRFS_BLOCK_GROUP_RAID1 |
@@ -10798,6 +10801,25 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		       BTRFS_BLOCK_GROUP_RAID6 |
 		       BTRFS_BLOCK_GROUP_DUP)))
 			continue;
+
+		/* check if we have at least one writable mirroed block group */
+		for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+			if (i == BTRFS_RAID_RAID0 || i == BTRFS_RAID_SINGLE)
+				continue;
+			list_for_each_entry(cache, &space_info->block_groups[i],
+					    list) {
+				if (!cache->ro) {
+					has_rw = true;
+					break;
+				}
+			}
+			if (has_rw)
+				break;
+		}
+
+		if (!has_rw)
+			continue;
+
 		/*
 		 * avoid allocating from un-mirrored block group if there are
 		 * mirrored block groups.
-- 
2.21.0

