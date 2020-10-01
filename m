Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD98B2806C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgJASiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732864AbgJASiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577492; x=1633113492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i44UAAWCU3pEu/WrC87PmjeM9oN6Y5QwdfGRxQZHtDI=;
  b=A4iJhkmZJrmAGBoTTCtmnMhLqHrUDbEe8nWdM2trmM3TyRD7wSk28i7Y
   oxV9C63oobPFkBQ81VaGa90CMVR1G94e3Ov1l4r4WkMYSAx9dghO0rI9e
   3qhMjkO97kKlLDaS4nydWFZ7PfdlZp2cyL6P/xAB8TPmrjKjAXVIdzaTN
   SiSUPbMaMlvIdbFhisfcR19Woq6VGiYe1OmL6Z+N7XXcGN6R3B0U8oeHF
   FiaZ7VdUbVeb8iB4PE5LG3BTVj9imXQ/BABhippmRfVbEECWpLnoRTAv9
   ajZ6Yvry3I7ZHrjcdX9tVYuhwmY/NFwRTuBImA+qyj00d2K+Ul/WNdPf6
   w==;
IronPort-SDR: R5ezBBCJTpMiY+W3UmR0l3zJojhnid3KphjZYyBYhFwm1nymBrIlkAQWr8exBywYYv1mtQaGFx
 U8zf2Cbmwl61NkbKPC4frz1ZyPVBXaYNDzesWTWTSbzMIjZhU5A5evfueqv64mwGAKLl0MJKqR
 BXTaZvRuLSgoOWpF2WBgKOinCmyCGu7lpFc6ubU85gApJzW3qMH9v18Mjrqiz7MB1dCM7PzFLh
 SdsrloINZwhWL69EsIJ2b7UuHmIYjbe3TWbtXhbSF8BcazPMGv12fWkZyhx3O+ICG1Xul7yt3Y
 OL0=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036786"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:12 +0800
IronPort-SDR: +h/EfI0uvCrsyGw4eprtZJcuL9j1mcnskAc0jFeQilccTF4t1L29AZpDhaUxzFvzUYRbAd/Lnj
 JBre4SbtEJCw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:08 -0700
IronPort-SDR: dUBoZnvKoO8335zDgTLNwXuS7I3LlmzwT+zPRA3oQ0Nv5jZ2wsg99UTkmb2eZz/Zo6gQtwCHwT
 +qRPuZNZ5zwA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 09/41] btrfs: disallow mixed-bg in ZONED mode
Date:   Fri,  2 Oct 2020 03:36:16 +0900
Message-Id: <4e567db24f9a949e104687a0c467c488409ba14e.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

