Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA6252D27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgHZL6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 07:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgHZL6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:58:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE3C061574;
        Wed, 26 Aug 2020 04:58:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q1so764971pjd.1;
        Wed, 26 Aug 2020 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKUsSNHPD10epGKanq0lKFpn+rXbIBIuwXm/qXBGIj0=;
        b=EOuU6ToKMSAx7xeacj4km9h3pmmlxYSdt4PtIbGsaCxTwohnZZR9kTXGGdT4WJwfO7
         fIY2bTTt7z/etwByKXe1GlF963kgNn9R1AR290LZB+qUOt6a2jYrXMmEFLvcKAfvRczi
         2sdqYmKLsUJx5sSXBDLRZEb6cZObN/1s4HDlg3OYZSDQkTFpASSLCWyrLWWiV0rXwp7X
         Kpi4P8VtOQ3D7iQKFIibzyD8f7EFBJrHP/l4miOnrUHIVYbWlsInlY/2Tkmd0AfRkaba
         CH0NvEX5/IoTCZWxFZk92y/MjIKS439XNclNuCaI6ARWaX+GJ16eVGq0bUjy2vwiFbM1
         oDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKUsSNHPD10epGKanq0lKFpn+rXbIBIuwXm/qXBGIj0=;
        b=kxrKS+bI1PsRtHSeUklA+AiHDAAc2CmXY+td875i5nS+fLvQP+2I58oIoEThGFa5Gz
         dUVaXy5p1xFb02y6fK2lNQiJPiETO1reZwrpSlpkhNyhAYF2HGSqSEUtuBhVYwZSBaDp
         qkRQmbXYTaTPrLxtEVfh/RflfvxiY1a7USNkPXP3+BZBCYXtcElIu/DW36p+QTwD4jH7
         5P0CCe+58R4GU4QlRIkhh5QAWAT5c+4cpL75hZa/uAqGAvE/hf1FdvTbgbPwsnq2lTar
         S6XFAUg0KspOGW2RTep/19crfgt9yVtSnRKfIyOB2nm+/9uKHZM/sMwqUu6euFZRoGIa
         z9cw==
X-Gm-Message-State: AOAM533CcatPXPTaRb0G3BYiYJ80ZXEQwFF9E3M8FdqgzFM1cr9Cy7cP
        +M8jEHJTAS2SnhRYvZMXU8o=
X-Google-Smtp-Source: ABdhPJzSd7e0yvfCA9FBrguWq8Tqv5JdR5VaCv8sOX614lA0Jnks51/iurNYxAfsFPu9T0O8PcnAgw==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr12040146plr.194.1598443085619;
        Wed, 26 Aug 2020 04:58:05 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id v1sm1957904pjh.16.2020.08.26.04.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:58:05 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] exfat: add NameLength check when extracting name
Date:   Wed, 26 Aug 2020 20:57:38 +0900
Message-Id: <20200826115742.21207-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826115742.21207-1-kohada.t2@gmail.com>
References: <20200826115742.21207-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current implementation doesn't care NameLength when extracting
the name from Name dir-entries, so the name may be incorrect.
(Without null-termination, Insufficient Name dir-entry, etc)
Add a NameLength check when extracting the name from Name dir-entries
to extract correct name.
And, change to get the information of file/stream-ext dir-entries
via the member variable of exfat_entry_set_cache.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Add error check when extracting name
 - Change error from EIO to EINVAL when the name length is invalid
 - Correct the spelling in commit messages
Changes in v3:
 - Nothing
Changes in v4:
 - Into patch series '[PATCH v4] exfat: integrates dir-entry getting and validation'

 fs/exfat/dir.c | 87 +++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index bb3c20bac422..99d9e6d119d6 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -28,16 +28,15 @@ static int exfat_extract_uni_name(struct exfat_dentry *ep,
 
 }
 
-static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
-		struct exfat_chain *p_dir, int entry, unsigned short *uniname)
+static int exfat_get_uniname_from_name_entries(struct exfat_entry_set_cache *es,
+		struct exfat_uni_name *uniname)
 {
-	int i;
-	struct exfat_entry_set_cache *es;
+	int n, l, i;
 	struct exfat_dentry *ep;
 
-	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
-	if (!es)
-		return;
+	uniname->name_len = ES_STREAM(es).name_len;
+	if (uniname->name_len == 0)
+		return -EINVAL;
 
 	/*
 	 * First entry  : file entry
@@ -45,24 +44,26 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 	 * Third entry  : first file-name entry
 	 * So, the index of first file-name dentry should start from 2.
 	 */
-
-	i = ES_INDEX_NAME;
-	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
-		exfat_extract_uni_name(ep, uniname);
-		uniname += EXFAT_FILE_NAME_LEN;
+	for (l = 0, n = ES_INDEX_NAME; l < uniname->name_len; n++) {
+		ep = exfat_get_validated_dentry(es, n, TYPE_NAME);
+		if (!ep)
+			return -EIO;
+		for (i = 0; l < uniname->name_len && i < EXFAT_FILE_NAME_LEN; i++, l++)
+			uniname->name[l] = le16_to_cpu(ep->dentry.name.unicode_0_14[i]);
 	}
-
-	exfat_free_dentry_set(es, false);
+	uniname->name[l] = 0;
+	return 0;
 }
 
 /* read a directory entry from the opened directory */
 static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 {
-	int i, dentries_per_clu, dentries_per_clu_bits = 0;
+	int i, dentries_per_clu, dentries_per_clu_bits = 0, err;
 	unsigned int type, clu_offset;
 	sector_t sector;
 	struct exfat_chain dir, clu;
 	struct exfat_uni_name uni_name;
+	struct exfat_entry_set_cache *es;
 	struct exfat_dentry *ep;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -114,47 +115,45 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 				return -EIO;
 
 			type = exfat_get_entry_type(ep);
-			if (type == TYPE_UNUSED) {
-				brelse(bh);
+			brelse(bh);
+
+			if (type == TYPE_UNUSED)
 				break;
-			}
 
-			if (type != TYPE_FILE && type != TYPE_DIR) {
-				brelse(bh);
+			if (type != TYPE_FILE && type != TYPE_DIR)
 				continue;
-			}
 
-			dir_entry->attr = le16_to_cpu(ep->dentry.file.attr);
+			es = exfat_get_dentry_set(sb, &dir, dentry, ES_ALL_ENTRIES);
+			if (!es)
+				return -EIO;
+
+			dir_entry->attr = le16_to_cpu(ES_FILE(es).attr);
 			exfat_get_entry_time(sbi, &dir_entry->crtime,
-					ep->dentry.file.create_tz,
-					ep->dentry.file.create_time,
-					ep->dentry.file.create_date,
-					ep->dentry.file.create_time_cs);
+					ES_FILE(es).create_tz,
+					ES_FILE(es).create_time,
+					ES_FILE(es).create_date,
+					ES_FILE(es).create_time_cs);
 			exfat_get_entry_time(sbi, &dir_entry->mtime,
-					ep->dentry.file.modify_tz,
-					ep->dentry.file.modify_time,
-					ep->dentry.file.modify_date,
-					ep->dentry.file.modify_time_cs);
+					ES_FILE(es).modify_tz,
+					ES_FILE(es).modify_time,
+					ES_FILE(es).modify_date,
+					ES_FILE(es).modify_time_cs);
 			exfat_get_entry_time(sbi, &dir_entry->atime,
-					ep->dentry.file.access_tz,
-					ep->dentry.file.access_time,
-					ep->dentry.file.access_date,
+					ES_FILE(es).access_tz,
+					ES_FILE(es).access_time,
+					ES_FILE(es).access_date,
 					0);
 
-			*uni_name.name = 0x0;
-			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
-				uni_name.name);
+			dir_entry->size = le64_to_cpu(ES_STREAM(es).valid_size);
+
+			err = exfat_get_uniname_from_name_entries(es, &uni_name);
+			exfat_free_dentry_set(es, false);
+			if (err)
+				return err;
+
 			exfat_utf16_to_nls(sb, &uni_name,
 				dir_entry->namebuf.lfn,
 				dir_entry->namebuf.lfnbuf_len);
-			brelse(bh);
-
-			ep = exfat_get_dentry(sb, &clu, i + 1, &bh, NULL);
-			if (!ep)
-				return -EIO;
-			dir_entry->size =
-				le64_to_cpu(ep->dentry.stream.valid_size);
-			brelse(bh);
 
 			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
 			ei->hint_bmap.clu = clu.dir;
-- 
2.25.1

