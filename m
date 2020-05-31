Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785151E9692
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgEaJa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 May 2020 05:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgEaJa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 May 2020 05:30:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10583C061A0E;
        Sun, 31 May 2020 02:30:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so2128545pgm.0;
        Sun, 31 May 2020 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAG8TaT+2P5xmIws2CpHpkpVUo5ktRCdXi0mFy5w2p0=;
        b=I/amNDxUiEx15hrLjE/jkQEp4cTYoUQcRshnczYAQ3YcbTg1qVSvSWpczx5zDGXWN0
         IMfLe8KDoKvT4diDZ7TWFJ5czYX2Z6SctkNDgydq58GLXEv8skcJHUVkcbApMEdvtdhR
         nF92za3zy5AKTzKq+7Kaj1o2LIzcd/aSRw53y6BbqK83S46/OWYPlgHD3PwvTtH1dqmT
         FVq7za7ZlauCspMkYulhc5AadzBX6+LLNGRMdlxxFRINwiepodfsViAKAr4ZgKWkQ/el
         n8WyyFgEcViOqWF5CsziMB05jZ+8S1Th8vKGYTC77SiXSnOHHLWkLV2fEfGiXk18ZPsv
         RyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAG8TaT+2P5xmIws2CpHpkpVUo5ktRCdXi0mFy5w2p0=;
        b=Vui5hkxxtDZrlO3HcDIg1pAAGy6wyQQCB4ZOW96Yh020wJBa69oio8yWOf+Kwk3Ppp
         GQ5aAJHnGAw1+BZ7q4mVNxhZYB63Z5nB/HufDYnsbS1Bk1eeno6S5l/2Px3egOJpUTpR
         p2IooBXL4eiabpyfso4l0R68YIO9Ym5g51NiRmAhkeROiGIxJ84afIBwr+Afa7calexo
         2YO2lwsoiCsWkXnZELvWmsTFPbv1DASFVwoEna3zqXxXnoZwZ7WvvSMXBoHbIVU+mpjS
         GAGCiBe7N0fhRdKzGicnYiE8Lstigi/Q+xR5lFVdPDgb8M3N64jGPfSSqKwMJerscp8i
         Z64Q==
X-Gm-Message-State: AOAM532F44weKWburVTVujVtRKhXJudr2RjyHFzdpDsae3IzTdjamNcf
        SUT6cSyFFQUZpAMupyYge8wU/zH4otw=
X-Google-Smtp-Source: ABdhPJztSP45xopxdIcL3PtHIXXcghobYIDNgGtCH7eaeVXXAyE5/jvuyUHxW5iiIIoRn6pkAOeITg==
X-Received: by 2002:a62:1c93:: with SMTP id c141mr16209862pfc.289.1590917424454;
        Sun, 31 May 2020 02:30:24 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:181d:bb76:cc02:958c])
        by smtp.gmail.com with ESMTPSA id q44sm4538436pja.29.2020.05.31.02.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 02:30:23 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4 v4] exfat: add boot region verification
Date:   Sun, 31 May 2020 18:30:17 +0900
Message-Id: <20200531093017.12318-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Changes in v2:
 - rebase with patch 'optimize dir-cache' applied
 - just print a warning when invalid exboot-signature detected
 - print additional information when invalid boot-checksum detected
Changes in v3:
 - based on '[PATCH 2/4 v3] exfat: separate the boot sector analysis'
Changes in v4:
 - fix type of p_sig/p_chksum to __le32

 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 14 +++++++++++++
 fs/exfat/super.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 9673e2d31045..eebbe5a84b2b 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -514,6 +514,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
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
index 6a1330be5a9a..405717e4e3ea 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -491,6 +491,50 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	return 0;
 }
 
+static int exfat_verify_boot_region(struct super_block *sb)
+{
+	struct buffer_head *bh = NULL;
+	u32 chksum = 0;
+	__le32 *p_sig, *p_chksum;
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
+			p_sig = (__le32 *)&bh->b_data[sb->s_blocksize - 4];
+			if (le32_to_cpu(*p_sig) != EXBOOT_SIGNATURE)
+				exfat_warn(sb, "Invalid exboot-signature(sector = %d): 0x%08x",
+					   sn, le32_to_cpu(*p_sig));
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
+		p_chksum = (__le32 *)&bh->b_data[i];
+		if (le32_to_cpu(*p_chksum) != chksum) {
+			exfat_err(sb, "Invalid boot checksum (boot checksum : 0x%08x, checksum : 0x%08x)",
+				  le32_to_cpu(*p_chksum), chksum);
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
@@ -503,6 +547,12 @@ static int __exfat_fill_super(struct super_block *sb)
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

