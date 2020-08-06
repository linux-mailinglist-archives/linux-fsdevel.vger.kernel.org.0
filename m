Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF5523D6A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 07:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHFF5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 01:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHFF5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:57:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C9C061574;
        Wed,  5 Aug 2020 22:57:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z20so6198828plo.6;
        Wed, 05 Aug 2020 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=twWGVICE4fgRJfM7XBVpLSd7zGjr5JvWyKChRjzzsCo=;
        b=NnYfbUByFzKu5u3q9YQYaf6OqcD9lIri3Gw3cntv64OfVYsC//qIze4mZgkWvwqpS2
         EzSvgXvjHmf4WXSDEfl4eiJ7n0F50/V8fIClJkiEP+Ttyy4g31Qcmi/20KbbUiMmI5f9
         NgaTtd33O5d7F7fVoP1iozzUC/+JZkhh2CtzGQBRvxXTS9SlBz321QeaC8+TkE8K94h2
         MHf0bEmGmxba8hTNtevsUzAPdTo0MfjmhWRqE7cKjPlnicntT1wA13+gIQU9PbEldtet
         T37Ns5PC+8rBq1kf27uEkX8BZP/cAtwLiikF0koce5e+GqkXocLGBEKWrufEVR2ay0aD
         wcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=twWGVICE4fgRJfM7XBVpLSd7zGjr5JvWyKChRjzzsCo=;
        b=ZBzc5JlxPHF5iuMnu1qZgdabwjdHZq1G8UC+gn1L0ZTQRVpwM/Kcy6MxIJE85VxMpJ
         p2hodZWzIuQhA/abt1bBOsLwEKbFFZE76jYsrOQGI0Ifg0TfrtSjpaNDKkNbUXljlCYY
         1z3BCaJ+I/fMRjWpoLJH6f0SCEk/yoEZGHz1fHPjqX3LqYb9Kz0t8wWABaxLJpUmIODI
         KKshlbqY/ksS8KzlGtOnvMgBvNEQ1OqMWSdKLKmmVmqNr3Ihr+bdosKU91f/Z7dyrObN
         l9UhXEqAgo8JKgmeo157tLTp7+TeAWNIq1EjcXYBF009YCsJNubuK3nRfIwyfcX+34rw
         l0ow==
X-Gm-Message-State: AOAM530sD/LTnSQD1AmohvMmTDoU3xq/UFKzEr+3GsWMhRiSYnRknuXA
        Kea13Ykah2fZS3uiqDm6uVY=
X-Google-Smtp-Source: ABdhPJxAizwORww/0+3z367sBw1ZRXh061mCfXAo55dCKmhqcIGp7mi16y1zdoVp2y3LxPkO6KB8ZA==
X-Received: by 2002:a17:90a:7f02:: with SMTP id k2mr6773450pjl.196.1596693435614;
        Wed, 05 Aug 2020 22:57:15 -0700 (PDT)
Received: from dc803.localdomain (FL1-218-42-16-224.hyg.mesh.ad.jp. [218.42.16.224])
        by smtp.gmail.com with ESMTPSA id g129sm6056784pfb.33.2020.08.05.22.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 22:57:15 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exfat: add NameLength check when extracting name
Date:   Thu,  6 Aug 2020 14:56:52 +0900
Message-Id: <20200806055653.9329-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

** This patch depends on:
  '[PATCH v3] exfat: integrates dir-entry getting and validation'.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c | 81 ++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 91cdbede0fd1..545bb73b95e9 100644
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
+	uniname->name_len = es->de_stream->name_len;
+	if (uniname->name_len == 0)
+		return -EIO;
 
 	/*
 	 * First entry  : file entry
@@ -45,14 +44,15 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 	 * Third entry  : first file-name entry
 	 * So, the index of first file-name dentry should start from 2.
 	 */
-
-	i = 2;
-	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
-		exfat_extract_uni_name(ep, uniname);
-		uniname += EXFAT_FILE_NAME_LEN;
+	for (l = 0, n = 2; l < uniname->name_len; n++) {
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
@@ -63,6 +63,7 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
 	sector_t sector;
 	struct exfat_chain dir, clu;
 	struct exfat_uni_name uni_name;
+	struct exfat_entry_set_cache *es;
 	struct exfat_dentry *ep;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -114,47 +115,43 @@ static int exfat_readdir(struct inode *inode, struct exfat_dir_entry *dir_entry)
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
+			dir_entry->attr = le16_to_cpu(es->de_file->attr);
 			exfat_get_entry_time(sbi, &dir_entry->crtime,
-					ep->dentry.file.create_tz,
-					ep->dentry.file.create_time,
-					ep->dentry.file.create_date,
-					ep->dentry.file.create_time_cs);
+					es->de_file->create_tz,
+					es->de_file->create_time,
+					es->de_file->create_date,
+					es->de_file->create_time_cs);
 			exfat_get_entry_time(sbi, &dir_entry->mtime,
-					ep->dentry.file.modify_tz,
-					ep->dentry.file.modify_time,
-					ep->dentry.file.modify_date,
-					ep->dentry.file.modify_time_cs);
+					es->de_file->modify_tz,
+					es->de_file->modify_time,
+					es->de_file->modify_date,
+					es->de_file->modify_time_cs);
 			exfat_get_entry_time(sbi, &dir_entry->atime,
-					ep->dentry.file.access_tz,
-					ep->dentry.file.access_time,
-					ep->dentry.file.access_date,
+					es->de_file->access_tz,
+					es->de_file->access_time,
+					es->de_file->access_date,
 					0);
 
-			*uni_name.name = 0x0;
-			exfat_get_uniname_from_ext_entry(sb, &dir, dentry,
-				uni_name.name);
+			dir_entry->size = le64_to_cpu(es->de_stream->valid_size);
+
+			exfat_get_uniname_from_name_entries(es, &uni_name);
 			exfat_utf16_to_nls(sb, &uni_name,
 				dir_entry->namebuf.lfn,
 				dir_entry->namebuf.lfnbuf_len);
-			brelse(bh);
 
-			ep = exfat_get_dentry(sb, &clu, i + 1, &bh, NULL);
-			if (!ep)
-				return -EIO;
-			dir_entry->size =
-				le64_to_cpu(ep->dentry.stream.valid_size);
-			brelse(bh);
+			exfat_free_dentry_set(es, false);
 
 			ei->hint_bmap.off = dentry >> dentries_per_clu_bits;
 			ei->hint_bmap.clu = clu.dir;
-- 
2.25.1

