Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0BC280709
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbgJASjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbgJASjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577541; x=1633113541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/dS61ZHd3vP9uYD0p4gcGPRjl47fX+Beo6W1L/zt6wM=;
  b=G1+7h1U5paAqYDSHBUI1n+Yp/klAStViBttOZMo83RwIhW/jYWcp1uxR
   yq96L/aa8sebwWEim5nNgIi20tDr6glAMtB4wIDesJYkn6TpaRD058OGj
   VBscy8+fQpaEzUZAZwUbeGHhgD0aSPG8z11XQOj2Nxh4F9/IsKDI39iC5
   q1cT8WSKsOlgWuNf69dCB5ThXOlSLTqOexukQZnZQ0kqPsSrsA5ocRQMl
   rSDRBzN2KPJwmo+L0849gWtsvPvmrRi6F96/+8IdNgv1Qyak5KQ0C6yC5
   +D/K5FBosJboLaVI0SDbCfyWP7j7udUE5loNcIKfKrJSxz7bxuSRYhKgr
   Q==;
IronPort-SDR: LEcm32Px8HFUI1Jxjig/RkQ3fSqH4BGOAaTrifwlFtjfVokskAuMs4yUBn84IGJKQWquyP3NmU
 FSnY1ZSGflA0tkQR+J//CONVcNhUayotesL+Ug4IOrJJ22BWsFTvVpeimMLB9+TJuTuJR+aU8c
 uFO7UJZmFhXmfaRdmWRyAP3ESCN5vdAyrlwE8XpWHu8scd6o79QpztiVVQg/X1D00ftyZkZh8V
 /s3MywjIAqY4mFXxbLmC/gFEhvUpKcO9GtSihR7kxe52DX58eyOClrfdm9XEBhWVsElLONtdb2
 rYM=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036813"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:27 +0800
IronPort-SDR: xiS/rxJy5sWThY7wMU8PCTvX+rdM4V0S7UJOCyx8T7eKI/P8HsBkHEnZaidY/xI+3t6KcuOVSz
 8DJ/IY0By/tA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:24 -0700
IronPort-SDR: iFL/yOvYoy7BUSIjoVqLHnOVori+z8LF7b87sA8ugcHfpHOtDIHgchWRbiArK+QO/leCz9BJJ8
 LfaWkLSBUrxw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:27 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 22/41] btrfs: handle REQ_OP_ZONE_APPEND as writing
Date:   Fri,  2 Oct 2020 03:36:29 +0900
Message-Id: <27a2688a096eda2be0fa491a3cd15837912f4dd1.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZONED btrfs uses REQ_OP_ZONE_APPEND for a bio going to actual devices. Let
btrfs_end_bio() and btrfs_op, who faces the bios, aware of it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 3 ++-
 fs/btrfs/volumes.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c22ea7f0551f..44ef7b2fb46c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6447,7 +6447,8 @@ static void btrfs_end_bio(struct bio *bio)
 			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
 
 			ASSERT(dev->bdev);
-			if (bio_op(bio) == REQ_OP_WRITE)
+			if (bio_op(bio) == REQ_OP_WRITE ||
+			    bio_op(bio) == REQ_OP_ZONE_APPEND)
 				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c01dd5e40ec8..f8fc3debd5e0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -410,6 +410,7 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 	case REQ_OP_DISCARD:
 		return BTRFS_MAP_DISCARD;
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		return BTRFS_MAP_WRITE;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.27.0

