Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3FEF9BBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKLVN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:58 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37650 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727516AbfKLVNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:50 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDnpw029731
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:49 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDibI023949
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:49 -0500
Received: by mail-qk1-f198.google.com with SMTP id s144so24320qke.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nBMeWmqtacDeZwaLfnQQdHa+4rImWGWUbj1hgwCuPP8=;
        b=nJ2kEfiJmcChNr0WrtgX8F8c4dzQOG+xt5F0pNf4izCZk1G0Y7/079qCLPpUJiI3Nv
         VcUat0vIImGSN4dbgoOcFrFtA6CYjiATem+F3Iixxxm/819KHjbJMj3nEYI2x9K7XfCa
         GBq1VgmXqyZ1DX733L5qP/G2CBb98J0XW4ZfdBn3uyfT4H1R/HQ3MnENsnqy2iLqC6so
         s3rzwG2zt9rAFpVrWelAE570oZ5g5++tkvIAjZG0huL+aonZRtIVC+2EjUm0IoSjcNK+
         GDmdWQzCF941itSCcAYqAVnGQksXg9WJ7e/WdUTKF+6mFa6izj+/LCXN8j0lEMX7smCc
         fVkg==
X-Gm-Message-State: APjAAAUJq/XX/bBTCW6YhkkPMzDDfJt55IvUMHlyPRdsVqZMl9F1q2Ph
        9GY/mQ4cMeNsN9do8UGQjf9ZMinrpwe7etdRaBdE9aEnkXS9aBmFhJpMlKK/ezBm1o32nnY3dP1
        w0HrHxCi8RX76jdWPvenOFUpDFkVBRpn+Qxe7
X-Received: by 2002:a0c:e9c4:: with SMTP id q4mr31520020qvo.61.1573593224230;
        Tue, 12 Nov 2019 13:13:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzsHoM6Thzt3ejRwUJZu/EOWTzFZnTDcsUK7gX5UJ5IG1AxuhHiUG63JG6ykXzeHz/LqwQ+jg==
X-Received: by 2002:a0c:e9c4:: with SMTP id q4mr31519995qvo.61.1573593223916;
        Tue, 12 Nov 2019 13:13:43 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:42 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] staging: exfat: Clean up the namespace pollution part 4
Date:   Tue, 12 Nov 2019 16:12:34 -0500
Message-Id: <20191112211238.156490-9-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Relocating these functions to before first use lets us make them static

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      |  4 --
 drivers/staging/exfat/exfat_core.c | 78 +++++++++++++++---------------
 2 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 407dbb017c5f..48267dd11e9d 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -775,10 +775,6 @@ void free_upcase_table(struct super_block *sb);
 
 /* dir entry management functions */
 struct timestamp_t *tm_current(struct timestamp_t *tm);
-void init_file_entry(struct file_dentry_t *ep, u32 type);
-void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
-		     u64 size);
-void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
 
 struct dentry_t *get_entry_in_dir(struct super_block *sb, struct chain_t *p_dir,
 				  s32 entry, sector_t *sector);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 3ea51d12c38d..24700b251acb 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -971,6 +971,45 @@ static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *t
 	}
 }
 
+static void init_file_entry(struct file_dentry_t *ep, u32 type)
+{
+	struct timestamp_t tm, *tp;
+
+	exfat_set_entry_type((struct dentry_t *)ep, type);
+
+	tp = tm_current(&tm);
+	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_CREATE);
+	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_MODIFY);
+	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_ACCESS);
+	ep->create_time_ms = 0;
+	ep->modify_time_ms = 0;
+	ep->access_time_ms = 0;
+}
+
+static void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
+{
+	exfat_set_entry_type((struct dentry_t *)ep, TYPE_STREAM);
+	ep->flags = flags;
+	SET32_A(ep->start_clu, start_clu);
+	SET64_A(ep->valid_size, size);
+	SET64_A(ep->size, size);
+}
+
+static void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
+{
+	int i;
+
+	exfat_set_entry_type((struct dentry_t *)ep, TYPE_EXTEND);
+	ep->flags = 0x0;
+
+	for (i = 0; i < 30; i++, i++) {
+		SET16_A(ep->unicode_0_14 + i, *uniname);
+		if (*uniname == 0x0)
+			break;
+		uniname++;
+	}
+}
+
 static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size)
 {
@@ -1047,45 +1086,6 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	return 0;
 }
 
-void init_file_entry(struct file_dentry_t *ep, u32 type)
-{
-	struct timestamp_t tm, *tp;
-
-	exfat_set_entry_type((struct dentry_t *)ep, type);
-
-	tp = tm_current(&tm);
-	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_CREATE);
-	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_MODIFY);
-	exfat_set_entry_time((struct dentry_t *)ep, tp, TM_ACCESS);
-	ep->create_time_ms = 0;
-	ep->modify_time_ms = 0;
-	ep->access_time_ms = 0;
-}
-
-void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu, u64 size)
-{
-	exfat_set_entry_type((struct dentry_t *)ep, TYPE_STREAM);
-	ep->flags = flags;
-	SET32_A(ep->start_clu, start_clu);
-	SET64_A(ep->valid_size, size);
-	SET64_A(ep->size, size);
-}
-
-void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
-{
-	int i;
-
-	exfat_set_entry_type((struct dentry_t *)ep, TYPE_EXTEND);
-	ep->flags = 0x0;
-
-	for (i = 0; i < 30; i++, i++) {
-		SET16_A(ep->unicode_0_14 + i, *uniname);
-		if (*uniname == 0x0)
-			break;
-		uniname++;
-	}
-}
-
 static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, s32 order, s32 num_entries)
 {
-- 
2.24.0

