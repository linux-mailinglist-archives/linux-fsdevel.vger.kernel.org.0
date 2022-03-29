Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0571F4EA82C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiC2G5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiC2G5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:57:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF422E093;
        Mon, 28 Mar 2022 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648536969; x=1680072969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zGt4/7Bi6rVIM3CDrEKyuP24GWSiTE6w3IEXHN5j18=;
  b=Ho8efVm7o2X7ReeaeoBhBd6scPwTOkR95QgVGJPv3JHI7ez+FS86ej6p
   Sp64FGap9C/n8+lUJn4bNu//ZPf9NeXV5FjzA24L3QcI8+3fvyhL0bZFI
   1smdJPotv5Ps9pdQ1vZodc4D2xyT98bs7VebvaeaCjU4A256iLk3cP/lt
   64ku4OSA6JyPNkItHRD7f7R2xZ6o0IG+mFLZk5XbCVGmv6lcJ6xtk7F+R
   Fn5ri3mrk61THyrta6zNmOs7S/E7iBUOokOpjUsksmgIgaydlOaJshvD9
   nWkg6tzwsfqlTAsDbe3oRBDiMVbPkvif8z/Xlc/0jKkvN8iNB57Y8cHtV
   g==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="197429220"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 14:56:08 +0800
IronPort-SDR: 2I/470t9N5Z7unptV6eP6d0zsYG5+qDmhh50Cqap8wEH+/U2rSPNsaT+5mEHnvx8w535wzpaIC
 iRMID2Sy3gGPer/3Ivj5r4P0Utoy1DLkINnBVEidd1NlwVJTzUpgpRHGnD1rcEQI+HbtH9vodo
 GcTIp5yMvHPxMxmbdngYXFYYM5/bR9ATcCG2oW30tZUAHsuSyL2l7jLKaBnJ+xsHwwhy9U00CA
 OefGkgok3ZHubacS0sh553HSH0ImsCKyU65nbw+pZmXUjNgosN30/19Tn7VY9y1ggzJ8h8E6h8
 YL3ptQrvcr37rTOiDaHjTszC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 23:27:52 -0700
IronPort-SDR: 4hN00kNPKO2fkHyAezDcWBXq/WqkODj+0wNeRhhZrrd19y8IQGa9vc/xuelUMdhUlRvQCtYVV1
 VBVTpi0OBn9W6o+CTGjinxj5zSQj0anWodWPy4s3KTWYOQZXqkIveIfQri8XLYeZF0934EIYCf
 uL3Km/3/KTcf5ItFyTK40dC7jpNHjrrte4IfRPWpTO4lRPXDQPTr1oum0nK/yM9x8nMg3DMO3L
 vakfxsU4xIH3fMxddr3LMmR4rmItiY0oixliGCRFRPUaPtQ6k+lei5TQNAOJ1L/Ny3F0gzTRLk
 kog=
WDCIronportException: Internal
Received: from 2zx6353.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.64])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Mar 2022 23:56:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 2/3] fs: add a check function for sb_start_write()
Date:   Tue, 29 Mar 2022 15:55:59 +0900
Message-Id: <ccccf0efac8d017dd4edbe34259296b83f6371dd.1648535838.git.naohiro.aota@wdc.com>
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

Add a function sb_write_started() to return if sb_start_write() is
properly called. It is used in the next commit.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 27746a3da8fd..1f3df6e8a74d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1732,6 +1732,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
 #define __sb_writers_release(sb, lev)	\
 	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
 
+static inline bool sb_write_started(const struct super_block *sb)
+{
+	return lockdep_is_held_type(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1, 1);
+}
+
 /**
  * sb_end_write - drop write access to a superblock
  * @sb: the super we wrote to
-- 
2.35.1

