Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960164DB14B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiCPNYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiCPNYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:24:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836CA188;
        Wed, 16 Mar 2022 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647436987; x=1678972987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kCqIT6QE4X6rjqZGfyRVMUMbl6cnDFW78z03eIIrjMY=;
  b=nE1f0ZxYzkW4mhBTvgSz+l/quHxF2TrrSxIehT6vT9tjZBzL+uCSsUDw
   Ayxh81Jn5YdTZmN78gyI6HEw1yDv2WBlK2kmDquN+QZfoU1oZLFyNLRSK
   1Nfy69yUsEQXzlYER65E1aKXKiRZIzV7ZM3GAzApQexUMpFY+7aUjd+vu
   SrnuNOlOfqtLKBKUMPmUU5cxuO8Wn8jf4LFYIq21JMzvl6YL32RKHnE3f
   ZGLTaIb7+lGegglZ3YxMI4EVRWgrI0XsTRlC6utbEfxPCdnxPIVQ2zUe7
   WCUufyZ1XU46VsniVMgznXYeSUEx+tcI2nrBwE3UkmdgPO5728XlqZLqJ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="299654875"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 21:23:07 +0800
IronPort-SDR: KZaIeq9tbwICFt4rR1PhVvJ0cgLtAVWn1gthIG8yDHMw1j/Z/Svoti2BS7pdcttAZ2yAswgemm
 NhhDuSxQIjl6h9VwwfYw46BExCn7+U67CUTkLYJEIx5vylhZ8tBHatkAVAJ8dzNX0NHpd4SSoJ
 K9PabBnj+/xE+HjZzt5VV7VnQBB24SVItS3FwP4hOiwtAP0sMNBYB5y0CiJW3PRHlgDF7FqQuu
 +JwLKIkXIVgh0VR+Mim7wwTpDIrWQfNfhia31PAqUv2zBocW+y8jAOiNKc9Bd7WqvITs1wWERV
 yUzcgL+DFiy5g/FLexwuh3cp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:54:13 -0700
IronPort-SDR: h6pANHya6cNJa88DC1iwMORVk1t0Z8B8LtArPceHg4/YDHusZQRsHTopJVcfBLjNEgAKBLC9s7
 vRFfQrslHKWv+DjIGaZO3sXCp154mYZstC46dBPLKmwOd9EzELnJrcoq1sG1rQpX2guq/0Dm/m
 ikfGZYO9mbEwHqD2ikSoBaKXda/+9FDhBIi1fdv0xA6Saw6zFOPaqFHoMGDt5DgZ2ctQ9Ccwf0
 fubirgoV1fjxA5ei3Kudto/Gu//YByWevcAtSjtj5hDXW6Qrc0b8IeGqOE7eEPb306I8i8899s
 grk=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 06:23:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/4] btrfs: mark resumed async balance as writing
Date:   Wed, 16 Mar 2022 22:22:37 +0900
Message-Id: <bd1ecbdfca4a2873d3825afba00d462a84f7264f.1647436353.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647436353.git.naohiro.aota@wdc.com>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
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

When btrfs balance is interrupted with umount, the background balance
resumes on the next mount. There is a potential deadlock with FS freezing
here like as described in commit 26559780b953 ("btrfs: zoned: mark
relocation as writing").

Mark the process as sb_writing. To preserve the order of sb_start_write()
(or mnt_want_write_file()) and btrfs_exclop_start(), call sb_start_write()
at btrfs_resume_balance_async() before taking fs_info->super_lock.

Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3fd17e87815a..3471698fd831 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4430,10 +4430,12 @@ static int balance_kthread(void *data)
 	struct btrfs_fs_info *fs_info = data;
 	int ret = 0;
 
+	sb_start_write(fs_info->sb);
 	mutex_lock(&fs_info->balance_mutex);
 	if (fs_info->balance_ctl)
 		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
 	mutex_unlock(&fs_info->balance_mutex);
+	sb_end_write(fs_info->sb);
 
 	return ret;
 }
-- 
2.35.1

