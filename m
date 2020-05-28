Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7141E5BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgE1JRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 05:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgE1JRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 05:17:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B330C05BD1E;
        Thu, 28 May 2020 02:17:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y11so3045184plt.12;
        Thu, 28 May 2020 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8hs8Gy4+vcTx/6wICvu/N/ImG6vk07R81c1rqTOhmo=;
        b=l0N71qao1hvbacif3rtUkOSbER25ThW144oVegNpIDXEuGNq2EaylwS+QnYpRKGNPi
         cutYH25IZCsN7OnStEqnfjRcGgUh0YLyvny4JfmWV9OYgeDyuh6709H0axsi46bL8o6I
         TJ9IT9hl/LYVVInLZcajUVSNSWj4eMYXP5355oFzUz1Myy36jU+vfDzWQ3u5cD9TVqrn
         YfBfjqvUVr9GMFSdPpXv8jOeTspLuh+EKITpkoXORG8ZSoyQT7vMgp3TypS0/otClvxD
         W5OHzfA339GFDwbMRCC+4uxGACXSrZeH59qpVmYM1BfMSDBGMhQyUn/b+KLoH5kZ7nn8
         NFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8hs8Gy4+vcTx/6wICvu/N/ImG6vk07R81c1rqTOhmo=;
        b=IzR2Ljyi3zJLmdk/lqxDbU2ehoknzXyVQbJPfAKeOFeuZkwPZBM17sIW9iKPIhRJHf
         pEkMw0s1AgaoILXCij1uB9GpzqGf+zsyyvagr7OPJq4nMpthF4bKqFd8W0evH/H4j3Hz
         +liERFBMJmH51aZHzN/8edJ4hTFhDhwnBrinnWElXcxieLPyWXJe413uY8HHgszqqSNK
         D1BA8CyIpRlHYQq8RuyScg0zj8J5iFBRf9j8DM7uqfKS98WI2JENkWAn2eYnvb7XhLdS
         BRX2U9r6axSC1hwt9JA3CxWr4v71O4x7a/NdQ3WNKDRNaOziwVCjXCUJjoo7Nk8j9gCa
         JCGA==
X-Gm-Message-State: AOAM532FTTB/6SuFF9EHut74sVzSzxh9ilB6SgAQmGVcr3bZoDvkp8I/
        zxcZ23Qmi9ujNspfhXlci9U=
X-Google-Smtp-Source: ABdhPJwahJ1NP+QNBEmCkE229tlWtT5nT1KzHV6I4UKclk7tpdk6Qk9pj80SLaFPOkSGw+tQe0Ek6w==
X-Received: by 2002:a17:90a:4495:: with SMTP id t21mr2797725pjg.185.1590657426953;
        Thu, 28 May 2020 02:17:06 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:295a:ef64:e071:39ab])
        by smtp.gmail.com with ESMTPSA id d15sm5856185pjc.0.2020.05.28.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 02:17:06 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4 v2] exfat: add boot region verification
Date:   Thu, 28 May 2020 18:16:03 +0900
Message-Id: <20200528091605.13016-3-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528091605.13016-1-kohada.t2@gmail.com>
References: <20200528091605.13016-1-kohada.t2@gmail.com>
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

 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 14 +++++++++++++
 fs/exfat/super.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

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
index 95909b4d5e75..381f4394f976 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -486,6 +486,49 @@ static int exfat_read_boot_sector(struct super_block *sb)
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
+		p_chksum = (u32 *)&bh->b_data[i];
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
@@ -498,6 +541,12 @@ static int __exfat_fill_super(struct super_block *sb)
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

