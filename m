Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B25D28070D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbgJASjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:54 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733114AbgJASjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577549; x=1633113549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SoPash0411BS/9S75lSWLF1bHnsRbsdKp/SZjqYeY6U=;
  b=c4QvaUsU+9/FinE3zFDKoZ8kQD5fFnkUZLZAD79BHDiozsWMinx/y4VJ
   4SEjbi6aDAALzNLcxvL2ZtQtqhaIk3+OEJybOvu6Eo2AYFPoYpGA4R5aU
   gmH4gkS2fJCKf7b1A9Kum/eKi8YIzofWe1FzkyFU0svREGj5Pmoo4Oz3O
   hQm6BJtWwmKJJxpW166CytkW29767dLD238W+oP4zBnv6M9aBzFcI6UYy
   fv+3hLZdfnhxbW8M3fvS8wwGu/2JGzARei6eRCxlrgpfKLmAZV6ZN4IeD
   NJR/8x0NGi8ybkgjeApUCWoZEBOepiQ+ASbk6pyJbGAYs16uwPWaHFBBL
   A==;
IronPort-SDR: rQA+1/6Tz7J81Nx0wA2RgDSkSMwgBC506ZgTxDqIrcg5XA9sFZRJa+qsQvl3qDDnThZ7oyu368
 8q32CNuKIeA8WvvCXE+cJ5wq9B+dm4dMTD3b9Yfxrpxkd3YcP88Cqn2tgnwY1YYUFlfGTpBRG7
 +tvPt6PMREVXJC0Yumgb2dWMCDFtLbszTw79EWBwAYed3uNbq/aByie8nZsF2eZynxqEWRQ/XL
 gv+Rt9ePB6yfgPfaSDrWrE1X6TWaPWmqGcdncbIYwbm/S2FGX+JxJSJs9RPB9B8Z9No/Wh+Hlb
 LWw=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036858"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:50 +0800
IronPort-SDR: BdXoxdq2g+hEWA6BCe31O4Hy+wlT0FdORPqSnGpsu45xtx8rBKT8QEwXee8tIiIvQhC6YXlkdg
 3yBZW/yCiTng==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:46 -0700
IronPort-SDR: wzs2VezWDo6hfkixw3vKpBVpSmh4GOBvwXgUzuw1GSSIyDLDFui4ZhF/Obya6ZPJtyOcbTkto8
 J0YgJxj1p/dw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 41/41] btrfs: enable to mount ZONED incompat flag
Date:   Fri,  2 Oct 2020 03:36:48 +0900
Message-Id: <95a1e2f5ca2cc551b946b91b13804ec1bd093675.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 81e2f5b78917..f5b78ae3baff 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -302,7 +302,8 @@ struct btrfs_super_block {
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

