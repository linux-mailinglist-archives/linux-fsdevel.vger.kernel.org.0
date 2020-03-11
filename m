Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB43181640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgCKKxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 06:53:03 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:50714 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgCKKwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:52:51 -0400
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id E500C3A4455;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 48cphK5xc8zRk8c;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr05.melco.co.jp (Postfix) with ESMTP id 48cphK5dNxzRk81;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48cphK5ZmMzRjFt;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48cphK57jfzRjFp;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 02BAqnRu028969;
        Wed, 11 Mar 2020 19:52:49 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 76B6517E075;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tux100.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 6027117E073;
        Wed, 11 Mar 2020 19:52:49 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 02BAqm0w017644;
        Wed, 11 Mar 2020 19:52:49 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: exfat: add boot region verification
Date:   Wed, 11 Mar 2020 19:52:44 +0900
Message-Id: <20200311105245.125564-4-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200311105245.125564-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add Boot-Regions verification specified in exFAT specification.

Reviewed-by: Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat_core.c | 69 ++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 3faa7f35c77c..07c876bb1759 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2017,7 +2017,20 @@ u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type)
 			chksum = (((chksum & 1) << 15) |
 				  ((chksum & 0xFFFE) >> 1)) + (u16)*c;
 	}
+	return chksum;
+}
 
+u32 calc_checksum32(void *data, int len, u32 chksum, int type)
+{
+	int i;
+	u8 *c = (u8 *)data;
+
+	for (i = 0; i < len; i++, c++) {
+		if (unlikely(type == CS_BOOT_SECTOR &&
+			     (i == 106 || i == 107 || i == 112)))
+			continue;
+		chksum = ((chksum & 1) << 31 | chksum >> 1) + (u32)*c;
+	}
 	return chksum;
 }
 
@@ -2053,6 +2066,58 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	return 0;
 }
 
+static int verify_boot_region(struct super_block *sb)
+{
+	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
+	struct buffer_head *tmp_bh = NULL;
+	u32 chksum = 0, *p_signatue, *p_chksum;
+	int sn = 0, i, ret;
+
+	/* read boot sector sub-regions */
+	ret = sector_read(sb, sn++, &tmp_bh, 1);
+	if (ret)
+		goto out;
+
+	chksum = calc_checksum32(tmp_bh->b_data, p_bd->sector_size,
+				 chksum, CS_BOOT_SECTOR);
+
+	while (sn < 11) {
+		ret = sector_read(sb, sn++, &tmp_bh, 1);
+		if (ret)
+			goto out;
+
+		chksum = calc_checksum32(tmp_bh->b_data, p_bd->sector_size,
+					 chksum, CS_DEFAULT);
+
+		/* skip OEM Parameters & Reserved sub-regions */
+		if (sn >= 9)
+			continue;
+
+		/* extended boot sector sub-regions */
+		p_signatue = (u32 *)(tmp_bh->b_data + p_bd->sector_size - 4);
+		if (le32_to_cpu(*p_signatue) != EXBOOT_SIGNATURE) {
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+	}
+
+	/* boot checksum sub-regions */
+	ret = sector_read(sb, sn++, &tmp_bh, 1);
+	if (ret)
+		goto out;
+
+	p_chksum = (u32 *)tmp_bh->b_data;
+	for (i = 0; i < p_bd->sector_size / 4; i++) {
+		if (le32_to_cpu(*p_chksum) != chksum) {
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+	}
+out:
+	brelse(tmp_bh);
+	return ret;
+}
+
 static int read_boot_sector(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -2129,6 +2194,10 @@ s32 exfat_mount(struct super_block *sb)
 	if (ret)
 		goto err_out;
 
+	ret = verify_boot_region(sb);
+	if (ret)
+		goto err_out;
+
 	ret = load_alloc_bitmap(sb);
 	if (ret)
 		goto err_out;
-- 
2.25.1

