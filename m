Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3B24950F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHSGgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 02:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHSGgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:36:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC5C061389;
        Tue, 18 Aug 2020 23:36:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o5so10921698pgb.2;
        Tue, 18 Aug 2020 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PDmC07eBBWKYfMjPDStl0jGbtXe62YQEZp90mKCh68=;
        b=pHVHmTJe5o4bEWfZIKhi6U1HMwO0jCK21YHd9ghgkMKEbzAHT22BDNk7M83cvtJiAj
         tyKGxj41uObo1xtgrStAhnX1GBZuLaXcry4P3JCXRxdDs/Lk3An0HlJ5OMQgTJKIz5hP
         0JcLXrIhym789Yr6d1esFF7KySyFFG1parxyZtoRs0lWU2NzEQuvJRfKXvRXrH0pzVMP
         APUSWGBy7lLrs24WBwKXQbfPIn+UjdgGojSKWwmjkZjAPtcy/eTZRmsEfsUI6STI1CsL
         9L/gTzQ6KdHkEoqCZwbd2o74SWl1ZglrY9wyrSjKRTZx/kwGymjkn9vaH2HRCqN3VWU/
         nf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9PDmC07eBBWKYfMjPDStl0jGbtXe62YQEZp90mKCh68=;
        b=txwuhDer7RjeoeNiJvBrFGRqwwOKeel6rbBFCP/J1Nzgwdx7oMIti9siIoQITIQZem
         b9IE8FlGl9QbAoyuFY9LfUENfoIPfOjNDP1l7pNxV2X6FZQYTM7r0fnGqnB9OFhMJYLn
         WQ0qg9SBtZCFkyt78qCWynRXYH+/xvhTHwpaEwBBUHu2uCjE6Dccx+rYJFLW2o5IkEGO
         rX1g72AWmp0FEokDQLVLFg1H3C53aVKxgkW4g9sH7aqymotTBCFZrmB345i3wPHIRN5W
         lTqq4YmyMbQD29FlvlPX1e05hHgByA8lXwJOzfry0+YizPSqldh5tGJacTkfL4/uhIBB
         sd3g==
X-Gm-Message-State: AOAM5300MGgPSa95SqtJZEBezK0nmugi9KmbOBv3OwF9JC4NYi7NTF+z
        5YJYDpgdV/6zKvdNeOzAckg=
X-Google-Smtp-Source: ABdhPJzlXED23hKUk2u+0eI64mr7G3pGFLxvX2Ec34MzFf/nysC8SEYuZexvkR435RlupXTKFMG2Og==
X-Received: by 2002:a63:451:: with SMTP id 78mr15340090pge.183.1597818980251;
        Tue, 18 Aug 2020 23:36:20 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id x11sm11182970pgl.65.2020.08.18.23.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 23:36:19 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] exfat: add NameLength check when extracting name
Date:   Wed, 19 Aug 2020 15:36:13 +0900
Message-Id: <20200819063614.19485-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current implementation doesn't care NameLength when extracting
the name from Name dir-entries, so the name may be incorrect.
(Without null-termination, Insufficient Name dir-entries, etc)
Add a NameLength check when extracting the name from Name dir-entries
to extract correct name.
And, change to get the information of file/stream-ext dir-entries
via the member variable in exfat_entry_set_cache.

** This patch depends on:
  '[PATCH v3] exfat: integrates dir-entry getting and validation'.

Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Add error check when extracting name
 - Change error from EIO to EINVAL when the name length is invalid
 - Correct the spelling in commit messages

 fs/exfat/dir.c | 87 +++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 91cdbede0fd1..08ebfcdd66a0 100644
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
+		return -EINVAL;
 
 	/*
 	 * First entry  : file entry
@@ -45,24 +44,26 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
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

