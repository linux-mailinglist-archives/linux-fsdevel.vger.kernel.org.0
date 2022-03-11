Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771204D5C79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbiCKHju (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347163AbiCKHjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:39:45 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437E14F9C8;
        Thu, 10 Mar 2022 23:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984321; x=1678520321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pQ/vgMzfkUEI4czLqMfrA8jdkm3Ndae0jcZtDlW3SfE=;
  b=grvk6LY719VLvKULHRFBnjTZkXLLKgutpliq5ue9oTBJK4SPQqw79Xsr
   9DCCVYFOn4I2vVfnK1TUdWMHfZThD+E/lFKjhaBX5nwHdfKyDmjqSXU+O
   N3OT7UPm2zGBmEP7VutCnFKSGSU6eK8x/lKh71Mn4RF5P+4DcIBqz1lgb
   vGS/aPMcs6tdih0o1hmD9pG3qgGVxk7DhbDbx695RM/yziaMzddZVc3C8
   xuRVQuMPbI47ygQae8ElOzOQ6V/HdSGkgBptqQGo3yQXNoXq8OoXPWKq3
   SCJ4slCF5MdbE051kA9lgcxY2ogznYm7lGfk411nHGQUxZlOZ2FNGLJNe
   g==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="199899088"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:38:41 +0800
IronPort-SDR: es39VIfq94u1NqQPl+Gk8ilaoaOH3LcLbH9SuEgXhOpjZ8se+b8REEjtzuopkoOYTyQzNLQc2U
 4e3cpFHrwzQjk7LajqQSibNYN/ZMvf68PoJT668BU1NaXFXODFjD3F2uWoD3Z/GrMNsf4SPfVR
 Hvq4Ho+ASi++wefTwyKR0uravAqbaqHlCRGCsRgd7+t8UHS+QwJmc+M8izIHur+wFsMNr8FXyy
 OxObmdp0jabls0W8y5XNNOgATHZMXAuyheh3xdgfWYCxKHjDlOZzDDwYLl0tr+PP6frxFbF5f9
 PwQeUkl6XjkupM5DatzNKQ9y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:10:55 -0800
IronPort-SDR: sXPNJCABsu0Ckwxwjr9cqUUWp6OZOszVo3mlhAY134jJUgK6fGm0Z0KHP1irz2LK+s1quFQhyJ
 Pd/7jlz0l3Luaq/1bh+GKy9YrRgeiPJZchiwY0g/b6mF43vLGP5K+ZpfHkvVfrH8X27jIJG4X/
 16YYhvlDYM+Cn8tGkhPzj+BhGW7jEPUUGWM/1LtKx5QzlEnTT8qeJTp3E/FesM3bkZmDjMOg5Z
 f4/uNPQkpkw1YZKO5x8Y+GXYWs56uMrkdufynucz2yRD1Wx10yNpGlHiJRKJr5UqsU9neZBCq/
 FvU=
WDCIronportException: Internal
Received: from dyv5jr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.231])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Mar 2022 23:38:42 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] btrfs: mark device addition as sb_writing
Date:   Fri, 11 Mar 2022 16:38:03 +0900
Message-Id: <09e63a62afe0c03bac24cfbfe37316f97e13e113.1646983176.git.naohiro.aota@wdc.com>
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

btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
file-system internal writing. That writing can cause a deadlock with
FS freezing like as described in like as described in commit
26559780b953 ("btrfs: zoned: mark relocation as writing").

Mark the device addition as sb_writing. This is also consistent with
the removing device ioctl counterpart.

Fixes: 5accdf82ba25 ("fs: Improve filesystem freezing handling")
Cc: stable@vger.kernel.org
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 238cee5b5254..ffa30fd3eed2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3484,6 +3484,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 		return -EINVAL;
 	}
 
+	sb_start_write(fs_info->sb);
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
 		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
 			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
@@ -3516,6 +3517,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
 	else
 		btrfs_exclop_finish(fs_info);
+	sb_end_write(fs_info->sb);
 	return ret;
 }
 
-- 
2.35.1

