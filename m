Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC94D5C83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbiCKHjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiCKHjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:39:44 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F154F9C8;
        Thu, 10 Mar 2022 23:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984321; x=1678520321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jeCPpho/pRrNLIRebS5xYxPYkhodGWGJai8/U6MxEg0=;
  b=K2J5PQMoLtr09xbq2HPiT4ErkAs9dMU6YUQx0/twaU7NLnQ1ivLp8g+h
   R7/V2IOCPr+h0DWhcJioye7l21XA4bv7x/PZiLrQ2sBQGFlGHKOWgUmY7
   26bF13hE3dK8l+kFu8Jb1FwZPS59ptWDMoUWrA4f8UnxjCb+GOsaeQbmf
   FkWBbjxfpbc8PDRueamjIg3tvi1AJYXzeTeVnLSdOQE8HEXQQFadyaC+9
   yhRmOh6cv612Wh1WUH93qw2FBEV4aSwx/XCYUDhs5zs5NRyloAdwhtowY
   9EVqVzfE0he+uB1LE7cgY/aGAMF7rJYvMXN4zEiPlCykCq9spKVj3Dq4u
   g==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="199899084"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:38:41 +0800
IronPort-SDR: sp0LjSXM2j1NgRZJga5DojHNsBS8sGX+Uip2fixd92nAnGYwBP3iZG/Sr/fLxQicCn00eHIEJf
 xEJhrXS5lhO0o8jAB72BMpW9XRLkypbvdEmC8kfGPI3ILXqdUdfKvFHKkN3dRHe4ZQ0sX7PxZK
 AMNrLu9DtfF4osrPci8briBs9vC8cr8TnF0s9au4tBsVmM/eRxahcjPB2DkTdHXRUjypplqCaM
 JRMb5uSZ+VCUIYqw3j2i+kfLXs7ocIP2ul7IgyLwTbqDsrjLXRvq9iTe0+MR9ItKTCzqOaVG/l
 L+a6xRJUJrckQChKnstAcyo+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:10:54 -0800
IronPort-SDR: i9t84WH50XF/cEm+tBgwkGRKmJboI6Ud0p/+ICQ5JpYy3XuyW8XPsAT+q6HIskkMqs9TlsYnW9
 r6NgrzRnLtSKFPXLK3PyJ+nxK4AyIHcAIK61vSAONhh7dvVatTx4ixCljHf0Rfkj8yKiCWZnHt
 YsJd6U3hC+AMWBqrhq8PPOcCgvYKKgVC/9bbBlqPAEUWA1wbQpDtT5vpS5Uld5JP/9mLQ6+bXR
 tCyxorqZRiLvhI2J2eJfDAlgEaqB9akm8VYaAbS/97UNRNz+Ev9QCvN7ErQyrkkKDP4T6s0HES
 YgQ=
WDCIronportException: Internal
Received: from dyv5jr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.231])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Mar 2022 23:38:41 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/4] btrfs: mark resumed async balance as writing
Date:   Fri, 11 Mar 2022 16:38:02 +0900
Message-Id: <65730df62341500bfcbde7d86eeaa3e9b15f1bcb.1646983176.git.naohiro.aota@wdc.com>
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

When btrfs balance is interrupted with umount, the background balance
resumes on the next mount. There is a potential deadlock with FS freezing
here like as described in commit 26559780b953 ("btrfs: zoned: mark
relocation as writing").

Mark the process as sb_writing. To preserve the order of sb_start_write()
(or mnt_want_write_file()) and btrfs_exclop_start(), call sb_start_write()
at btrfs_resume_balance_async() before taking fs_info->super_lock.

Fixes: 5accdf82ba25 ("fs: Improve filesystem freezing handling")
Cc: stable@vger.kernel.org
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1be7cb2f955f..0d27d8d35c7a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4443,6 +4443,7 @@ static int balance_kthread(void *data)
 	if (fs_info->balance_ctl)
 		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
 	mutex_unlock(&fs_info->balance_mutex);
+	sb_end_write(fs_info->sb);
 
 	return ret;
 }
@@ -4463,6 +4464,7 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
 		return 0;
 	}
 
+	sb_start_write(fs_info->sb);
 	spin_lock(&fs_info->super_lock);
 	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
 	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
-- 
2.35.1

