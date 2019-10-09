Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A72D1058
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfJINkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:40:13 -0400
Received: from mout02.posteo.de ([185.67.36.66]:54023 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbfJINkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:40:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 35EAF2400E5
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570627927; bh=pGVw1jADD7c9qH3moiLEWEhmMWcXL4w0BUxz1XKY8Iw=;
        h=From:To:Cc:Subject:Date:From;
        b=TgIQtB0alRDA3I1Uisxau1tr7mghmFwkivJhLjTu5nXxIrV3Xv1on8uwPtY2v6d23
         G4a5MDr0/DxtzwvmmSlZfJaLGdcevMDYjWxE+3pMmeby3j2iKc+4/rb2pNew8TtM0h
         ysHr+vHqdZ06uHE+bgxVUSKEk03Suup+XuR04zcTDWhqpmyRMTo1xUWQzPp7GDzwxj
         vDBqX7+e1GQHy8WKDQUsj1taksCkUPYH+G8DUfm7Z2Euupnx4u1ByXKzZ8LvInQS+X
         wzV6ziDd+JBAcWwzqfOo4kWGxBt0rszrzATFqYb/CSu6KDx8Fq0A+NKeUKOQAHEXLw
         Xz+VIZ8vMNymA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pFWB6bxLz9rxM;
        Wed,  9 Oct 2019 15:32:06 +0200 (CEST)
From:   philipp.ammann@posteo.de
To:     linux-fsdevel@vger.kernel.org
Cc:     Andreas Schneider <asn@cryptomilk.org>
Subject: [PATCH 2/6] Add missing fs_error() in sector functions
Date:   Wed,  9 Oct 2019 15:31:53 +0200
Message-Id: <20191009133157.14028-3-philipp.ammann@posteo.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009133157.14028-1-philipp.ammann@posteo.de>
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andreas Schneider <asn@cryptomilk.org>

Signed-off-by: Andreas Schneider <asn@cryptomilk.org>
---
 drivers/staging/exfat/exfat_core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index eef9e2726b6b..043091565578 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -3616,8 +3616,10 @@ int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_read(sb, sec, bh, 1, read);
-		if (ret != FFS_SUCCESS)
+		if (ret != FFS_SUCCESS) {
+			fs_error(sb);
 			p_fs->dev_ejected = 1;
+		}
 	}
 
 	return ret;
@@ -3645,8 +3647,10 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_write(sb, sec, bh, 1, sync);
-		if (ret != FFS_SUCCESS)
+		if (ret != FFS_SUCCESS) {
+			fs_error(sb);
 			p_fs->dev_ejected = 1;
+		}
 	}
 
 	return ret;
@@ -3668,8 +3672,10 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_read(sb, sec, bh, num_secs, read);
-		if (ret != FFS_SUCCESS)
+		if (ret != FFS_SUCCESS) {
+			fs_error(sb);
 			p_fs->dev_ejected = 1;
+		}
 	}
 
 	return ret;
@@ -3696,8 +3702,10 @@ int multi_sector_write(struct super_block *sb, sector_t sec,
 
 	if (!p_fs->dev_ejected) {
 		ret = bdev_write(sb, sec, bh, num_secs, sync);
-		if (ret != FFS_SUCCESS)
+		if (ret != FFS_SUCCESS) {
+			fs_error(sb);
 			p_fs->dev_ejected = 1;
+		}
 	}
 
 	return ret;
-- 
2.21.0

