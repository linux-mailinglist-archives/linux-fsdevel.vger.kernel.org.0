Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0ED13879C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbgALR7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 12:59:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39083 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbgALR7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:59:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so6379353wrt.6;
        Sun, 12 Jan 2020 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I7p3MTVh7YW9DcnuTnIP7pDzwPRCSGKLfSdL+8Sg37M=;
        b=APD6gBkArkoCRa5hy0KIkpF9vcj82jkyOWBkslfE0wW7/PzK87pTLmwiYM6a7yM90a
         8wzH0lzDh+vYapb5+OotTkwql512VUuDVJou0acaXY5hobfJz0MQWpbcOijOs/0YM/ue
         Ws/Z/zQeQ7TNy7btBJ52k0A1rn1SrOCjf8CqWO/MXGQdoDIknS4nbhPcmMQjJ7XAD52H
         Oybo1fnhoeu3Pc1ZPp6g2OdgUvE33DxP7/3sfxgGl3woY76uwmumXd1A9TXmSvu2gyXw
         6LN/jIh2fL+SS4B4tmjFQDiJEAg9vyJH9ETqz9hBOr7LgibghfiTuNeqgUR83jfZdipv
         I9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7p3MTVh7YW9DcnuTnIP7pDzwPRCSGKLfSdL+8Sg37M=;
        b=KwfQCTtlpq6+y1R8OiO0UNGnBKvWG0Z12w4/kM90AhQ+Yz7ydzuJMC3mAA2NOiJjGy
         6Y6RkW9R/XMiLcxGM39vuLzOTS4uzLxZIdhQV45JDlnZ8c2y0FG9lrw9GeMLSneKJbeG
         l0i+k9RGSUlnm4uAiF00rguu9rV7SOjmlyivK0xStYeDU6Di3AcHeic4+HTEyXadBjt8
         M5h1+Ft8dL9iP2TqwQLagZmDDaW3Hak6AHaEDYOfND5iZ5V2Yvl6zOCXrddZu8r7q3s9
         5FsRk8NrtyVPg7Sdiq7J+PzMs6okaA6FNaVxU0+MoqrevoO/37T1/WeZibQ1fkF+fUqr
         5gdw==
X-Gm-Message-State: APjAAAUpmBkn4GJW4LbcXHwBi/IW/8zEdeft/8x4SesGBfshHk3fbtyj
        iF7dt1puNBBa6AHeq2b3A+RQPM33
X-Google-Smtp-Source: APXvYqx8jVVXP2mT9xjVxDqVe2Ls7boR3vrxUDKVudBmPvhg1niv2uT8b9SxZjnAcIt0ulVVbx7gVg==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr15105861wrt.100.1578851989330;
        Sun, 12 Jan 2020 09:59:49 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id t25sm11076522wmj.19.2020.01.12.09.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:59:48 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [WIP PATCH 2/4] udf: Fix reading numFiles and numDirs from UDF 2.00+ VAT discs
Date:   Sun, 12 Jan 2020 18:59:31 +0100
Message-Id: <20200112175933.5259-3-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200112175933.5259-1-pali.rohar@gmail.com>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These two fields are stored in VAT and override previous values stored in
LVIDIU.

This change contains only implementation for UDF 2.00+. For UDF 1.50 there
is an optional structure "Logical Volume Extended Information" which is not
implemented in this change yet.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/super.c  | 25 ++++++++++++++++++++++---
 fs/udf/udf_sb.h |  3 +++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 8df6e9962..e8661bf01 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1202,6 +1202,8 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 		map->s_type_specific.s_virtual.s_start_offset = 0;
 		map->s_type_specific.s_virtual.s_num_entries =
 			(sbi->s_vat_inode->i_size - 36) >> 2;
+		/* TODO: Add support for reading Logical Volume Extended Information (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
+		map->s_type_specific.s_virtual.s_has_additional_data = false;
 	} else if (map->s_partition_type == UDF_VIRTUAL_MAP20) {
 		vati = UDF_I(sbi->s_vat_inode);
 		if (vati->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
@@ -1215,6 +1217,12 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 							vati->i_ext.i_data;
 		}
 
+		map->s_type_specific.s_virtual.s_has_additional_data =
+			true;
+		map->s_type_specific.s_virtual.s_num_files =
+			le32_to_cpu(vat20->numFiles);
+		map->s_type_specific.s_virtual.s_num_dirs =
+			le32_to_cpu(vat20->numDirs);
 		map->s_type_specific.s_virtual.s_start_offset =
 			le16_to_cpu(vat20->lengthHeader);
 		map->s_type_specific.s_virtual.s_num_entries =
@@ -2417,9 +2425,20 @@ static int udf_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
 	buf->f_bfree = udf_count_free(sb);
 	buf->f_bavail = buf->f_bfree;
-	buf->f_files = (lvidiu != NULL ? (le32_to_cpu(lvidiu->numFiles) +
-					  le32_to_cpu(lvidiu->numDirs)) : 0)
-			+ buf->f_bfree;
+
+	if ((sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP15 ||
+	     sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP20) &&
+	     sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_has_additional_data)
+		buf->f_files = sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_num_files +
+			       sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_num_dirs +
+			       buf->f_bfree;
+	else if (lvidiu != NULL)
+		buf->f_files = le32_to_cpu(lvidiu->numFiles) +
+			       le32_to_cpu(lvidiu->numDirs) +
+			       buf->f_bfree;
+	else
+		buf->f_files = buf->f_bfree;
+
 	buf->f_ffree = buf->f_bfree;
 	buf->f_namelen = UDF_NAME_LEN;
 	buf->f_fsid.val[0] = (u32)id;
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 6bd0d4430..c74abbc84 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -78,6 +78,9 @@ struct udf_sparing_data {
 struct udf_virtual_data {
 	__u32	s_num_entries;
 	__u16	s_start_offset;
+	bool	s_has_additional_data;
+	__u32	s_num_files;
+	__u32	s_num_dirs;
 };
 
 struct udf_bitmap {
-- 
2.20.1

