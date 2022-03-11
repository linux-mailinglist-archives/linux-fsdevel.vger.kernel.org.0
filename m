Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE74D5C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbiCKHjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347173AbiCKHjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:39:47 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B1755208;
        Thu, 10 Mar 2022 23:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984323; x=1678520323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4D1r2l1x0Nc7hKdRdIldPQPtNyBpfjRydgDwmsMl+Oo=;
  b=csDjoVJqa/JimWxiiEwkrqWwvdnu5nH2ge6J6g3VMQpRDz7ES8aEmlPa
   d4g6UgyI6D2YdlcjNTgJvC3ttimIy2akonwbuC1dcIWq1MoomqQ8FLcV/
   NTqxRItaijMiuIMJcyNfFhFsmWz5KClDr/bYO+iYuSGpYKY+SZCMBvrLt
   cPKrwyuTVOlWkRxpwwuUQfqbvUmkIJQJXaPGjcMbhC6vv4SiQJ1C2yIjp
   ZZiyyQf9XrzGUlrlpALSEfHFVSELG2aqm0PkH0zoO5hBlTSdUYxNA4Smk
   PCzEAPIQU4n8wOVYumdquy+/rWTLHQlZSEZ0DbD/U0czMCz1PZaJVgK9l
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="199899098"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:38:43 +0800
IronPort-SDR: TI/HTqmY2p2s10YMwb4hEZVlgAf3adTMxFVIrXfOUweJSZi629qrKvJeQ4uKXvj/lqtL86LcHf
 QnO0bQ/8bHiyRTDLZjzNoBg8SuVplELJa6nHhXQ3Rfa92QRX8+ePCmdWsE6NKMAhf8vK5qg1Ez
 /DyjSj3Qzeb8B8b/y9mlkUxd9ccCkt66nsZg5NOn2VFDRI8u57MgdNSNmaKhe2DQv2FfeVRxsi
 Ze1f2+M3z4cBF6qs8BxqlcU0beBsxfqFAssh8k3+8/qT0G/dhzKeEfN7jEDSkXdXPv7Q4DJbBo
 3NcMi195jlC/PA6OBwJZt/JF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:10:58 -0800
IronPort-SDR: owNkfMOyxfjpTbPEnJp3MM/hvdGVjwzxTzvTBOF2bzvLuvOS3RiI5a3l6OBcFv2Y/Npen90Neo
 /NlMOf2Ph+fBq5qcwo7qfV0HOcqatke+O6H2Q39mD8G2TnoJ7lcsedLvO9bf2Xb8tNuuvpi5oG
 JUNzpRP2eUsoz3L/LAAN3a+TJ9wgJAuYO2Co9KUuarjowFj1etqvyEftUd2DQk3BB2cBriBB+X
 CiS+NTLYNxPY131QBTeQ2LvY3fvhoURXDNOhl3CTHIxKx4RLBvVorpS3iafMlxq6KEgUbqy1Pj
 bC0=
WDCIronportException: Internal
Received: from dyv5jr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.231])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Mar 2022 23:38:45 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/4] btrfs: assert that relocation is protected with sb_start_write()
Date:   Fri, 11 Mar 2022 16:38:05 +0900
Message-Id: <697674ea626a3d04218b02dbb12e07bdd851d3f0.1646983176.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646983176.git.naohiro.aota@wdc.com>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
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

btrfs_relocate_chunk() initiates new ordered extents. They can cause a
hang when a process is trying to thaw the filesystem.

We should have called sb_start_write(), so the filesystem is not being
frozen. Add an ASSERT to check it is protected.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0d27d8d35c7a..b558fd293ffa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3239,6 +3239,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	u64 length;
 	int ret;
 
+	/* Assert we called sb_start_write(), not to race with FS freezing */
+	ASSERT(sb_write_started(fs_info->sb));
+
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
 		btrfs_err(fs_info,
 			  "relocate: not supported on extent tree v2 yet");
-- 
2.35.1

