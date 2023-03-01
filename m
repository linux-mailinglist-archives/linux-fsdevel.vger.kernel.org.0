Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B26A67EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 08:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCAHFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 02:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAHFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:05:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D436336FEC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 23:04:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso8303212pjb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 23:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677654285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/7MP/ejAI3sruq8iFOBWkRKcy/cVwRiQeeMY1HpYcV4=;
        b=SJQ1r2P/WYtOeX7MwiIFp3r8lUoIY4iCZ4Kh8f/qVe3/AEb21nYPjUH4Hv18AlxL6o
         nVT66J/R/ENNcfrWJal9Qz4w0cc+bslDOrJZdbPYNnVSnTgdbZTaJK9WHrZXQyp5esb5
         5Yb5IfeL8mYmG7NirZaZnEAGLW3cOpU3SzqTbD2G1D2wcGOpHrMOGHukLzBrvcI2LfOK
         nyyyekRH4Vmof5eh3kwHztUg2NXk0tPlvHTc6LvetxHCdrpMGRsbCZszSca+yJa/vlTH
         m7gCcVmwIKNfkmga+j1x3I3yZL0OhUfNzvPCHP2joI67VeydZ+7WbSMdGDVFWXF8aWyA
         5x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677654285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7MP/ejAI3sruq8iFOBWkRKcy/cVwRiQeeMY1HpYcV4=;
        b=YotFz+zEQZUOqGyNOgYKqJu77MQ0DpsCPjcFuoYW3mjg6I2AEbxqEyw0UWbyzTtTcb
         CnJCOlg1hQa1pVsmnSEYlVwO1Ei9UZSfBtUSqDEOJnwRG6KKHeqsrGof8Ii7542CahyW
         qwarA5rNgOmCLcEsqYg0JvuLyCWnct3WFjPtOlq8wq4Tmeb2rVzyf9W6FFq2NYZkrMET
         CPkQIZWOSVnKR660XInQB/KUepVSfrVfEB6+OcgCOokxGX1ca/i/mTnTMoyzaDTbUThe
         GuIoVaazRoqj1lqDAEWv1eMEBclJvFpSryKW/aMW5T17IXmUfLdm9rj0svPqQJrcVuHA
         z4AA==
X-Gm-Message-State: AO0yUKVfNAq11oP0EXj1T9Ws0lhRtghJ1yRl94Qt7rxtIxm/6uaeNZCb
        4tkQlaslAGDXp/1xFyBE2cws6Q==
X-Google-Smtp-Source: AK7set+/jkVD/fqVCwDuBJSSHDh/BeXN+rwU+fD/gd7C3RkBNLPU9avj1wOQlqSbEwdnsqX5Ao/0Tg==
X-Received: by 2002:a05:6a20:4320:b0:cc:c557:9ce with SMTP id h32-20020a056a20432000b000ccc55709cemr7634102pzk.61.1677654285266;
        Tue, 28 Feb 2023 23:04:45 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 4-20020a630104000000b004f27761a9e7sm6701485pgb.12.2023.02.28.23.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 23:04:44 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     xiang@kernel.org, chao@kernel.org, gerry@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        Jia Zhu <zhujia.zj@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH] erofs: support for mounting a single block device with multiple devices
Date:   Wed,  1 Mar 2023 15:04:17 +0800
Message-Id: <20230301070417.13084-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to support mounting multi-layer container image as a block
device, add single block device with multiple devices feature for EROFS.

In this mode, all meta/data contents will be mapped into one block address.
User could directly mount the block device by EROFS.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/erofs/data.c  | 8 ++++++--
 fs/erofs/super.c | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..870b1f7fe1d4 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -195,9 +195,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 {
 	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
 	struct erofs_device_info *dif;
+	bool flatdev = !!sb->s_bdev;
 	int id;
 
-	/* primary device by default */
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
@@ -210,12 +210,16 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return -ENODEV;
 		}
+		if (flatdev) {
+			map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
+			map->m_deviceid = 0;
+		}
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
 		up_read(&devs->rwsem);
-	} else if (devs->extra_devices) {
+	} else if (devs->extra_devices && !flatdev) {
 		down_read(&devs->rwsem);
 		idr_for_each_entry(&devs->tree, dif, id) {
 			erofs_off_t startoff, length;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..4f9725b0950c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -226,6 +226,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct block_device *bdev;
+	bool flatdev = !!sb->s_bdev;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
@@ -248,6 +249,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (IS_ERR(fscache))
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
+	} else if (flatdev) {
+		dif->bdev = sb->s_bdev;
+		dif->dax_dev = EROFS_SB(sb)->dax_dev;
+		dif->dax_part_off = sbi->dax_part_off;
 	} else {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
-- 
2.20.1

