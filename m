Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B48A4DB153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356210AbiCPNY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348686AbiCPNYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:24:25 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044E140FE;
        Wed, 16 Mar 2022 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647436991; x=1678972991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjZyVW2Vmz9PfM7KmmbwgSWBd6UhTpv2ye+92Bbx6tI=;
  b=Xziow4cuik54hi8blkhJ1tB5szf7Et8jbdb46UUoKiQuNlRSU5mUzn5Y
   aZSiZzr+SLMLWfS1dAB7LHT7Z2SegCr8ZgqJ2l4cOEN4lA11POD9xjnQ7
   ir2W7+TCck3XQ/gxG9dB0mcYISUK3KCm2pK+n68do/ZNURZqhwEWNhBMX
   soLEOAC7Cf9KybIGJWvO//HqFaSESCP+nSnKLJLSm2OnLk6ZVUEvrqhGX
   kSxEyKIWs4+AGeLuNEfU6FSBMXJiXQlO6gTR/GEaSSzvsZjqKEq2Xj9Qm
   HrwwwbSOV0oel/tM38enbqCIRWePw6rKGmp/IqO4UQfzPbuUwMXq+Fc6A
   A==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="299654891"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 21:23:10 +0800
IronPort-SDR: VIZpG+hzxKsXV83zWAoKKWRCw4fZnpCRZEunrq7EKTImnL0y0UvQdKYvVqpiQ/sYe416G2Vcyf
 x8mfdF4CAv/P6EcLS9mt4DvDPx5lHEqyT5cVpSlL9Jz3ZSFO2x/JCV9SrLnvOEsbsKMHBOsD+e
 W4nPl9jTNkLxtnApS/GR+ol/as83lpNHTqnlXoJLu6b2sRzy/IQGK42GLloAl6guT1CCvbO942
 E1LR+5/RJhcpVlEftfry6lBT4kM/fj/n1df3YsljyFIUONK3L2z2AG5ptZkMWT5SqqZKKljDFh
 aI5swdztAc00DDv6eaJu8Lu7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:54:17 -0700
IronPort-SDR: GMps7eOP8mqHYSEz31iuKTv3l681MnxrtnrOd/maTu+qcgCfi6QvSUyfr9JNPUbkdqLAwGAEFr
 YhBkU1hLv26k3a/+EXb5ydpWtQGw/dSyd9dSyCjsCbZmTIndlAPz1GayCPVeAtW0M8GJkMaRPT
 NxI8EuN2V4EsOt0Sl8iFI2mb/mPOecDo0ji+6waGOvGaVmzO42yNaCCJiBVPuCo/ZpnpvAMkdX
 2hpQyyPsgMVMymyloZTmQFavxZ2boBQkW1fuaidco+sWVMJcg14Go1D8qhN8XsV0umIzL1UOzR
 scs=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 06:23:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 4/4] btrfs: assert that relocation is protected with sb_start_write()
Date:   Wed, 16 Mar 2022 22:22:40 +0900
Message-Id: <3f88d51b35da92bf2391febd7186973cc9539e95.1647436353.git.naohiro.aota@wdc.com>
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

btrfs_relocate_chunk() initiates new ordered extents. They can cause a
hang when a process is trying to thaw the filesystem.

We should have called sb_start_write(), so the filesystem is not being
frozen. Add an ASSERT to check it is protected.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3471698fd831..393fc7db99d3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3230,6 +3230,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
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

