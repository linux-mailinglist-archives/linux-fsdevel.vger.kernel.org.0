Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AFA1E7A46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgE2KQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:16:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EC1C03E969;
        Fri, 29 May 2020 03:16:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nu7so1081421pjb.0;
        Fri, 29 May 2020 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBMgJ9whjsvq/AWaW81SmPo/4l5VsvrgMHjQvZN2SiE=;
        b=gSrd+zIuFe3Zndsz/xz1u14zvx993mRW/5KgtXDCF7BDFykI6FadlabHSKWQlwZRjW
         WX3AVv0joMyUOb5jgEq9T/aOYmOA4KiWm40P01o3BZLReki/+CzQEYBWJpwnchnqZWt3
         WecsUASyoQtqIE7nkv+CT2sFws65dTvefloR0Yz0WzrXiuix17yjnGIJr/+encbC8HUR
         TpDIgnkfPsWRmKIWToDiYqdTUiYPQVR9Ld6uZ9yMRnDBKBhllgnGcFj0eUcBiNz7A0LI
         o6tj1AwQTD4R31sUDC0FpPhfIY7U6Jl0OuD+X4DAc1sD0UDTeflbFfXgQgb/seGcfFLt
         2M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBMgJ9whjsvq/AWaW81SmPo/4l5VsvrgMHjQvZN2SiE=;
        b=CgiKNLcyhZ0n9hfc2KyEdLxs8lKzjaUYPx8tg9U6na2LTeDyxRL8O/Jw/FiW0sloWL
         qy11hDb8R7eQX4H1QFnQXjx4TitkuMh5W8D2lF9mt/Vjd3PM3kN/VvBav0JYIx53zdtH
         jKlT2EIVBz1vdJw1UTANyWHsgOdxkWPyNgnq6ePHZUZERgmym7RnKN9oj11LrG0WXAvQ
         XpQEs4BqFE8ioZUfm0DtaANDhg8B7ufB+XBxAqm61rRWFL4l27mURIR6RpLxjgBC1HG3
         H13frCFmdAVgyrUe5WGPkho/kAGXMgb9t610pqTNNTSVBYLW4tqsywJUS/rUujT2IaaO
         IeyA==
X-Gm-Message-State: AOAM532YAnhb84x7HC34JYV0e+XmiohLusdJ7J72zcx12cFAH6uIuc3h
        6GvvFuZ29Qca1Mf6k/aYAqw=
X-Google-Smtp-Source: ABdhPJxppVjEnC3Or9K2nOKXqourY5wZbz12b0XSVIUORqZOnILhz0vDCOyUt6NlD6Tz+KRpRKuuzg==
X-Received: by 2002:a17:90a:1ad0:: with SMTP id p74mr471846pjp.117.1590747359812;
        Fri, 29 May 2020 03:15:59 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:3c0d:7bea:2bcd:e53b])
        by smtp.gmail.com with ESMTPSA id u4sm10839260pjf.3.2020.05.29.03.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 03:15:59 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4 v3] exfat: add boot region verification
Date:   Fri, 29 May 2020 19:14:58 +0900
Message-Id: <20200529101459.8546-3-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529101459.8546-1-kohada.t2@gmail.com>
References: <20200529101459.8546-1-kohada.t2@gmail.com>
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
index 6a1330be5a9a..c9bc6ad0aade 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -491,6 +491,49 @@ static int exfat_read_boot_sector(struct super_block *sb)
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
@@ -503,6 +546,12 @@ static int __exfat_fill_super(struct super_block *sb)
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

