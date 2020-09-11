Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A87265F9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgIKMhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:37:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgIKMfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827725; x=1631363725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i44UAAWCU3pEu/WrC87PmjeM9oN6Y5QwdfGRxQZHtDI=;
  b=ByAxPnPecbmuR6jSqXUFzvE8w/GTYZ2R895RNE4plBQatjGGcZQgXuCF
   sGHcU1qdh7Co4l7s7AiEALbwvch47izazicHjlI3ylTA9+ipy6ZrRMfCR
   d0WK0H30BSmpMlAtmoDgOr/cO2cMb8lpOOMj9ztn2/HHjByhwpTZu+jIP
   j7VzVkZuyaBOXPirpm24MHswcf/TQUCBeJhYu7fEC69OUz/QOqpGj2COP
   JRZyRQfCNTppNKhUkISuhwjTePLtqwUJFZl/yaJZpUAjo/13iCiWkqOMc
   evOWcgl4jirx/TcXlsiMpESXpOo+ybgRJerSnJ0rLEIks9zIAlUlPcQYp
   Q==;
IronPort-SDR: dScrbB4mMpkhdLpCQ/OUgoaNixF140VYd7NMdrNsB8zacP8IBVgRrF+cZagJ33jmfsxFjlkqy7
 3qib0fETEGIp7sExwpeIwB96Bui8iAaTzd/zR+dBqpqJGh1Chuhavc5guySo4QXYpNuZjwKVKs
 NkBGI++tCe3AX6Pn8FsThvh7zI3y4kIFVZ7L64y0ww9qyCfhgGykxF4hNKUR516ltrkTCrYugm
 jkFnZcRDyIgBwlg4m/ZfZRxkajR8k7MCq5Ry/kO63VGpXuEEyv1MqmPL/UfvPnqTUTOa3aQQoQ
 CX4=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125968"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:20 +0800
IronPort-SDR: PKWaGU3+easiWOuLFF7PWjyEWTPsi/K7U3rZAverMgl20istRpkLoC05MsE+xkXYrSdxpENI3U
 aYN4bBg0yfqQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:40 -0700
IronPort-SDR: 8IvoI5d2CsSf1iTG+gGPSTPaR7hlMYGNCssn/rMhavF+c5VELpq1CPus6AQLG2bm5f99dxMqLX
 aBXiQLalsJsQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 08/39] btrfs: disallow mixed-bg in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:28 +0900
Message-Id: <20200911123259.3782926-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Placing both data and metadata in a block group is impossible in ZONED
mode. For data, we can allocate a space for it and write it immediately
after the allocation. For metadata, however, we cannot do so, because the
logical addresses are recorded in other metadata buffers to build up the
trees. As a result, a data buffer can be placed after a metadata buffer,
which is not written yet. Writing out the data buffer will break the
sequential write rule.

This commit check and disallow MIXED_BG with ZONED mode.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6bce654bb0e8..8cd43d2d5611 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -260,6 +260,13 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info,
+			  "ZONED mode is not allowed for mixed block groups");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
 
-- 
2.27.0

