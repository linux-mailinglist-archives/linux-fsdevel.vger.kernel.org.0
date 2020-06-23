Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2FE2049CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 08:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgFWGW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbgFWGW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:22:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87797C061573;
        Mon, 22 Jun 2020 23:22:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h22so1096558pjf.1;
        Mon, 22 Jun 2020 23:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqdXnjOTSYDDpPPJplHpLnDfQ3QmZFq8Qe/1BA+yRRc=;
        b=njWd611Shn9oilZBlrtfevCvAa+D5bJCriFuIYOaE2EhlPpt86TFW+K5ll3a62Ws99
         ZJmRYHBR8o9MKWlXMmPG2gJ7jgX6on7Yziu7RT8oMqJKzN/70zkbc6bgKpvIikqwtf3y
         A5Hxf1Dr8EdDpWYS+ITIuLUaGSwvA6FzmikSBQ6jQxdHk/+F7pnoAeRCQwqVIPgihjLY
         J2K9+tpBEp/LrLPCtvlLYCdqRCJTND1D2kVXknpee03ac4qsMIiCAQ1yvrdWqEIyycbb
         xNp8Nz4Ix55H02VWByVZ7dk4FEneuP3TeovyZuKHHl/vlT8ZvhcGjQWN1jKfXe1SpaIn
         8k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqdXnjOTSYDDpPPJplHpLnDfQ3QmZFq8Qe/1BA+yRRc=;
        b=t3/JZJ4oN+N98Lnp2pBAJn9dWuL8nJC/gO+Tdp9AAQEJBYzUhB4hPFH+BJ4Dm3UCll
         iM+GOvTCulHUDuXKKiaoK4Ob7phcE3WCtHjEtQx//Ud0+hUifk84FrAgf1S8p/rtYCRP
         8hIEpLwckXgoJTeYZcT/621fYLMpP4LIEybvj6wwj5XrRHWuyyAoW1iTtirnCermcFeQ
         W3H1UqMOCAxaOJjVRy3qO3pVoKt8d6l8keR20jn1DPWFweP/63TJD3n9k/8FiscL3ReJ
         DV66fZrQ4aH1DxbjQvceshuZtuNmtiIHUV2m44Whnq2rvaY4pqolFq0Y1QRmue8jIFIc
         ns5A==
X-Gm-Message-State: AOAM530qlVP5Ukx7ZSYam9oxMBneo6gpIW5ZDZFQgGERwX23JNge5LYd
        0HBUYOKpIx/NhdWrDJ6Pu2s=
X-Google-Smtp-Source: ABdhPJwlHrhVW3Iqlh67brc+IJeHLCozs/uo71Rj5VLzU1+/Ou4KwjZaevfVL7FipceVqNvC/obtcA==
X-Received: by 2002:a17:90a:20e9:: with SMTP id f96mr581806pjg.13.1592893346950;
        Mon, 22 Jun 2020 23:22:26 -0700 (PDT)
Received: from dc803.localdomain (FL1-125-199-162-203.hyg.mesh.ad.jp. [125.199.162.203])
        by smtp.gmail.com with ESMTPSA id 207sm16163690pfw.190.2020.06.22.23.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 23:22:26 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 v5] exfat: write multiple sectors at once
Date:   Tue, 23 Jun 2020 15:22:19 +0900
Message-Id: <20200623062219.7148-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Write multiple sectors at once when updating dir-entries.
Add exfat_update_bhs() for that. It wait for write completion once
instead of sector by sector.
It's only effective if sync enabled.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - Split into 'write multiple sectors at once'
   and 'add error check when updating dir-entries'
Changes in v3
 - Rebase to latest exfat-dev
Changes in v4
 - Use if/else instead of conditional operator
Changes in v5
 - Remove Reviewed-by tag

 fs/exfat/dir.c      | 15 +++++++++------
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 02acbb6ddf02..7c2e29632634 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -606,13 +606,16 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 
 void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 {
-	int i;
+	int i, err = 0;
 
-	for (i = 0; i < es->num_bh; i++) {
-		if (es->modified)
-			exfat_update_bh(es->bh[i], sync);
-		brelse(es->bh[i]);
-	}
+	if (es->modified)
+		err = exfat_update_bhs(es->bh, es->num_bh, sync);
+
+	for (i = 0; i < es->num_bh; i++)
+		if (err)
+			bforget(es->bh[i]);
+		else
+			brelse(es->bh[i]);
 	kfree(es);
 }
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 84664024e51e..cbb00ee97183 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -512,6 +512,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
 void exfat_update_bh(struct buffer_head *bh, int sync);
+int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
 void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec);
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 8a3dde59052b..564718747fb2 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -172,6 +172,25 @@ void exfat_update_bh(struct buffer_head *bh, int sync)
 		sync_dirty_buffer(bh);
 }
 
+int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
+{
+	int i, err = 0;
+
+	for (i = 0; i < nr_bhs; i++) {
+		set_buffer_uptodate(bhs[i]);
+		mark_buffer_dirty(bhs[i]);
+		if (sync)
+			write_dirty_buffer(bhs[i], 0);
+	}
+
+	for (i = 0; i < nr_bhs && sync; i++) {
+		wait_on_buffer(bhs[i]);
+		if (!buffer_uptodate(bhs[i]))
+			err = -EIO;
+	}
+	return err;
+}
+
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags)
 {
-- 
2.25.1

