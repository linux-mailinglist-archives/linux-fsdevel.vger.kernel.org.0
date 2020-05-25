Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F891E0DC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbgEYLvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbgEYLvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 07:51:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5ADC061A0E;
        Mon, 25 May 2020 04:51:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so8456920pjm.2;
        Mon, 25 May 2020 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4UVF2F7RQFgZF9TvMBhu/gG/JvDOxuQGLaONHXyR5s=;
        b=tgC9fhJtqnhdwTHKE6zOKF0U3gP7PBy70DhmT8kRMIlvF+Xg3W/wc2KxDbNWLRrJ/v
         RTmIO7qWIn2sTg34xArVkzR9GA79AnyyH9bQdByOo5a77CMmLjY/lwr6UorAaVQUHk97
         rmcVe6DFFoJUvQ3hCOovyvd5u9jmxmBajOZi4ZqfM8ZcmUA0r93EsWWgwbxtsuFf3Xxb
         tqxeb2Q4GP++kDSUkVA0gSLkCWB+FyEbJEfCGHhEkX8ejuvapUzwXRvMoGqtrR8SW9d/
         iSBarC6HWV/CoUg0GD9meRsmO/EKHKlENZ7Uc3wx8y9AwW2TOZu/HRBMXxECnkK3lJVk
         ZvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4UVF2F7RQFgZF9TvMBhu/gG/JvDOxuQGLaONHXyR5s=;
        b=noY9VvC8ikeMN6/qC5NxmZ1+TwF5eaP80oCvx4nbD6yvLZF2wGofplhfva5dX9784a
         xRFN431HrLmmjtPsVlKEBJGqhYDF9AFDDP1tcl4rpM/YkNAQar4iAsQN6vQwKiOePaAx
         2cXWHuWOyW6V1KP3xivSfuhcHNgiENS7mxh5RXkVisjo7sOH1n0vwHqGY38yi70tLU2T
         GOhhmWTceP4hOl2Egn8U/XSFpM6GsLe83D2GCtjWprhx7JxHdW+VwnIiasJzc+wBD9ds
         GZshv076PAXiwm/xlV+vk74G9d9W9UYkcvUnJPSRcIYTxfVQSlD86K8SJe4BQIOJGVbf
         AR/g==
X-Gm-Message-State: AOAM5300KqOWJ72p8amThpzxAGrTuygI3+x80r3fdGc7CGnw9/B6k+zw
        mikZDGuFEjL/CUkJsILr7Qo=
X-Google-Smtp-Source: ABdhPJxUjCKnyQ3ystg+Gcy4GfknLLcd4dAeId7XCUDIAtoKC4i8Bn2i0Y/wfwHm3a+6kjmKJhh44w==
X-Received: by 2002:a17:90a:f004:: with SMTP id bt4mr10146770pjb.128.1590407475821;
        Mon, 25 May 2020 04:51:15 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:b9cb:9f91:3c10:565c])
        by smtp.gmail.com with ESMTPSA id h16sm13017537pfq.56.2020.05.25.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:51:15 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] exfat: add boot region verification
Date:   Mon, 25 May 2020 20:50:50 +0900
Message-Id: <20200525115052.19243-3-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200525115052.19243-1-kohada.t2@gmail.com>
References: <20200525115052.19243-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add Boot-Regions verification specified in exFAT specification.
Note that the checksum type is strongly related to the raw structure,
so the'u32 'type is used to clarify the number of bits.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 14 +++++++++++++
 fs/exfat/super.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index b0e5b9afc56c..15817281b3c8 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -517,6 +517,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 unsigned short exfat_calc_chksum_2byte(void *data, int len,
 		unsigned short chksum, int type);
+u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index ab7f88b1f6d3..b82d2dd5bd7c 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -151,6 +151,20 @@ unsigned short exfat_calc_chksum_2byte(void *data, int len,
 	return chksum;
 }
 
+u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type)
+{
+	int i;
+	u8 *c = (u8 *)data;
+
+	for (i = 0; i < len; i++, c++) {
+		if (unlikely(type == CS_BOOT_SECTOR &&
+			     (i == 106 || i == 107 || i == 112)))
+			continue;
+		chksum = ((chksum << 31) | (chksum >> 1)) + *c;
+	}
+	return chksum;
+}
+
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync)
 {
 	set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(sb)->s_state);
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 95909b4d5e75..42b3bd3df020 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -486,6 +486,50 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_verify_boot_region(struct super_block *sb)
+{
+	struct buffer_head *bh = NULL;
+	u32 chksum = 0, *p_sig, *p_chksum;
+	int sn, i;
+
+	/* read boot sector sub-regions */
+	for (sn = 0; sn < 11; sn++) {
+		bh = sb_bread(sb, sn);
+		if (!bh)
+			return -EIO;
+
+		if (sn != 0 && sn <= 8) {
+			/* extended boot sector sub-regions */
+			p_sig = (u32 *)&bh->b_data[sb->s_blocksize - 4];
+			if (le32_to_cpu(*p_sig) != EXBOOT_SIGNATURE) {
+				exfat_err(sb, "no exboot-signature");
+				brelse(bh);
+				return -EINVAL;
+			}
+		}
+
+		chksum = exfat_calc_chksum32(bh->b_data, sb->s_blocksize,
+			chksum, sn ? CS_DEFAULT : CS_BOOT_SECTOR);
+		brelse(bh);
+	}
+
+	/* boot checksum sub-regions */
+	bh = sb_bread(sb, sn);
+	if (!bh)
+		return -EIO;
+
+	for (i = 0; i < sb->s_blocksize; i += sizeof(u32)) {
+		p_chksum = (u32 *)&bh->b_data[i];
+		if (le32_to_cpu(*p_chksum) != chksum) {
+			exfat_err(sb, "mismatch checksum");
+			brelse(bh);
+			return -EINVAL;
+		}
+	}
+	brelse(bh);
+	return 0;
+}
+
 /* mount the file system volume */
 static int __exfat_fill_super(struct super_block *sb)
 {
@@ -498,6 +542,12 @@ static int __exfat_fill_super(struct super_block *sb)
 		goto free_bh;
 	}
 
+	ret = exfat_verify_boot_region(sb);
+	if (ret) {
+		exfat_err(sb, "invalid boot region");
+		goto free_bh;
+	}
+
 	ret = exfat_create_upcase_table(sb);
 	if (ret) {
 		exfat_err(sb, "failed to load upcase table");
-- 
2.25.1

