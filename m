Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707394EA831
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiC2G56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 02:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiC2G5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:57:54 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A22E9ED;
        Mon, 28 Mar 2022 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648536972; x=1680072972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cd0iTHAu9pZ35QJoZ2R6TCWqhJhsHQts6FYW7B5x2Uc=;
  b=frascRHxpNlZCTWZCotXN13MzLcs02LrD5FRFI3Ge9C5qeCTOaqK9ssi
   awRvo7YDd1aUOQyXWhutEmdfr2QhOOL2oS+kPI710q4STRdU9yh0rVAqh
   J93TNaVIWdyBYSGNIu9c7dXLKAVtetYF2UAMbQQGoxoriBM6Wm1LL1KYw
   y3LyE9S1XVRTjGzD2f24HmdpHT5RHfK27IlKn3cJ0EscadnfVBqMoiALQ
   zSOP8aYVEyq20t8QSLbMXx/oUo1IvcT0XkufQ+q6Jk5Gs5ffvyIpXb4DI
   H2jE4p9uREZwuVX97AX7usV7rkBmOIJmPnB0g9RTPwsItT6Y3CaKd35H2
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="197429226"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 14:56:09 +0800
IronPort-SDR: 59XS4lQMkN1w+H3gl56zHsMtYRBmOTDLTLnBhb0ENWShY700GKAAzldF8nRl2fWGhbILVqWqfs
 Kbhr/nxH/9mfQVsNQK1KC9eh1FNPo60SJyLg6WvL7jgKHCeLeBjEdEWiP85vDD1UgTQLzR7H6i
 iTPqNYUGypB/BGLO5679necolB016xuQLnmfw3T51BQV4I4VIpFNhIHn0rCICRgdBk+yCAf1wK
 675dytWlL3+weoPFD90PNW/18ogOlbU+2+8SXCPnnMT0mW3Zus7XoVau7KiWoyZdFfmPyNwmP6
 m6L/gw3R4PvEwQXNjH5LS9VK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 23:27:54 -0700
IronPort-SDR: kPAly7Qjv1lcmHzcVdNb5DbcEDrP+XFEGSu4UNV7LgsA7G4z4PZ4NSGJWZhf1T/FsyzkTjVLvK
 +2m6W9+FBQVQH8BSiOFaDpwozis8AN/gDewLTQcVv4ezft2ZxXA0c/ebKMh9lWujMlUHDmHvW5
 4lKOECik6okuHE2b6+FhTM6W69nPgX89hhG4YaRIYkb6FOrlJN6z3w6hCz3Mqj+/civwb4QUV5
 4VQrG6a0UruMVkRAmK/ixRV5CARBKsWd98j0QgiY/P8iZccExAG9eOJAnvV9dS4ctMmMVJHpnO
 ScY=
WDCIronportException: Internal
Received: from 2zx6353.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.64])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Mar 2022 23:56:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 3/3] btrfs: assert that relocation is protected with sb_start_write()
Date:   Tue, 29 Mar 2022 15:56:00 +0900
Message-Id: <28e3e02ed14fe7c0859707e1a10a447fe4338c16.1648535838.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648535838.git.naohiro.aota@wdc.com>
References: <cover.1648535838.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Relocation of a data block group creates ordered extents. They can cause a
hang when a process is trying to thaw the filesystem.

We should have called sb_start_write(), so the filesystem is not being
frozen. Add an ASSERT to check it is protected.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fdc2c4b411f0..5e52cd8d5f23 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3977,6 +3977,16 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	if (!bg)
 		return -ENOENT;
 
+	/*
+	 * Relocation of a data block group creates ordered extents.
+	 * Without sb_start_write(), we can freeze the FS while unfinished
+	 * ordered extents are left. Such ordered extents can cause a
+	 * deadlock e.g, when syncfs() is trying to finish them because
+	 * they never finish as the FS is already frozen.
+	 */
+	if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
+		ASSERT(sb_write_started(fs_info->sb));
+
 	if (btrfs_pinned_by_swapfile(fs_info, bg)) {
 		btrfs_put_block_group(bg);
 		return -ETXTBSY;
-- 
2.35.1

