Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA04713879F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 19:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgALR7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 12:59:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733087AbgALR7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:59:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so6359663wre.10;
        Sun, 12 Jan 2020 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QCSAs9Ek4jI/o8Pi01W4vaQei9UYS3BZtKQ6fy1s4sQ=;
        b=i8Qzpy5L+m2PxADtTeEwKCopBe2wBnkzJPoh/H3cnWrmCBAmGwymprF6x1GxRkhiwQ
         DsyTvoeiJU4ftVqF5mwwf8i9omLSc1nYURzpErwRWstbBzVl1PdEUGLM9xIqXPm2Bsge
         i2kRpEOsS5xutx1r53+jrkQI5t7HGmzs4BsepfO0JxlsjaueZ7nzC2fTGn2irtE0rtB/
         3oofhNscihYresTKOFOJ9G5YVnbpHp/qjlWoo0MogeTZ7wqEkBrErNBN/39ol5Gti4wG
         RbN5mMxHu8HR4HDycaHkRPnlY2Nl6cM7gSTTXLXMFldS5r+wjdhx0TnMKWOuTvPZ6//1
         PExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCSAs9Ek4jI/o8Pi01W4vaQei9UYS3BZtKQ6fy1s4sQ=;
        b=G3eHhVKRVf17rtYsL0ylLrawwgMten6ZqZDBl4qNpnwKHCSctF/pWY4dYfcRG01GdN
         3FplyY76tQr25Gtb+ORqzoTfLO/KtWnh/7NyESBw3wfGS/AfgD8q4N23gz1S/KG0AxGi
         M18e9okvBFEISvHIm92AGSTXtksKv7jA09btUsaxex8oCuuIFfEsbSPbXDRKYwij6tbz
         nZVKSE/AoGRY4cuwlg9tWA+JUAJOeutQMWtAPMXqApGwSUhxM+VUoBWmAC3FSNgNmD6I
         kjVDmnnM9swtE6HPZ8on8BM8Nd6JC5myPaXsKWuI/symX2FEcY+TXDhyXpVM8LYYO4Dj
         YbqA==
X-Gm-Message-State: APjAAAUaLk/ZMlLUOY8EmnhcKeo/GKfjgoc6HvhO+k6WPSl5RNbKWYb7
        Kj9VVzycfOs2sqXn+tKnTREBj6UV
X-Google-Smtp-Source: APXvYqy4y3FhTYRAGrNKSgYn3eCjrHjmdaFH3crGP2UGVYjETXmkDw/81LjqCCdAzsz7tQfdzOMzGQ==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr14456440wrq.134.1578851988374;
        Sun, 12 Jan 2020 09:59:48 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id t25sm11076522wmj.19.2020.01.12.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:59:47 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [WIP PATCH 1/4] udf: Do not access LVIDIU revision members when they are not filled
Date:   Sun, 12 Jan 2020 18:59:30 +0100
Message-Id: <20200112175933.5259-2-pali.rohar@gmail.com>
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

minUDFReadRev, minUDFWriteRev and maxUDFWriteRev members were introduced in
UDF 1.02. Previous UDF revisions used that area for implementation specific
data. So in this case do not touch these members.

To check if LVIDIU contain revisions members, first read UDF revision from
LVD. If revision is at least 1.02 LVIDIU should contain revision members.

This change should fix mounting UDF 1.01 images in R/W mode. Kernel would
not touch, read overwrite implementation specific area of LVIDIU.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/super.c  | 37 ++++++++++++++++++++++++++-----------
 fs/udf/udf_sb.h |  3 +++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2d0b90800..8df6e9962 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -765,7 +765,7 @@ static int udf_check_vsd(struct super_block *sb)
 }
 
 static int udf_verify_domain_identifier(struct super_block *sb,
-					struct regid *ident, char *dname)
+					struct regid *ident, char *dname, u16 *udf_rev)
 {
 	struct domainIdentSuffix *suffix;
 
@@ -779,6 +779,8 @@ static int udf_verify_domain_identifier(struct super_block *sb,
 		goto force_ro;
 	}
 	suffix = (struct domainIdentSuffix *)ident->identSuffix;
+	if (udf_rev)
+		*udf_rev = le16_to_cpu(suffix->UDFRevision);
 	if ((suffix->domainFlags & DOMAIN_FLAGS_HARD_WRITE_PROTECT) ||
 	    (suffix->domainFlags & DOMAIN_FLAGS_SOFT_WRITE_PROTECT)) {
 		if (!sb_rdonly(sb)) {
@@ -801,7 +803,7 @@ static int udf_load_fileset(struct super_block *sb, struct fileSetDesc *fset,
 {
 	int ret;
 
-	ret = udf_verify_domain_identifier(sb, &fset->domainIdent, "file set");
+	ret = udf_verify_domain_identifier(sb, &fset->domainIdent, "file set", NULL);
 	if (ret < 0)
 		return ret;
 
@@ -1404,7 +1406,7 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 	}
 
 	ret = udf_verify_domain_identifier(sb, &lvd->domainIdent,
-					   "logical volume");
+					   "logical volume", &sbi->s_lvd_udfrev);
 	if (ret)
 		goto out_bh;
 	ret = udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartitionMaps));
@@ -2055,12 +2057,19 @@ static void udf_close_lvid(struct super_block *sb)
 	mutex_lock(&sbi->s_alloc_mutex);
 	lvidiu->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
 	lvidiu->impIdent.identSuffix[1] = UDF_OS_ID_LINUX;
-	if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
-		lvidiu->maxUDFWriteRev = cpu_to_le16(UDF_MAX_WRITE_VERSION);
-	if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFReadRev))
-		lvidiu->minUDFReadRev = cpu_to_le16(sbi->s_udfrev);
-	if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFWriteRev))
-		lvidiu->minUDFWriteRev = cpu_to_le16(sbi->s_udfrev);
+
+	/* minUDFReadRev, minUDFWriteRev and maxUDFWriteRev members were
+	 * introduced in UDF 1.02. Previous UDF revisions used that area for
+	 * implementation specific data. So in this case do not touch it. */
+	if (sbi->s_lvd_udfrev >= 0x0102) {
+		if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
+			lvidiu->maxUDFWriteRev = cpu_to_le16(UDF_MAX_WRITE_VERSION);
+		if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFReadRev))
+			lvidiu->minUDFReadRev = cpu_to_le16(sbi->s_udfrev);
+		if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFWriteRev))
+			lvidiu->minUDFWriteRev = cpu_to_le16(sbi->s_udfrev);
+	}
+
 	if (!UDF_QUERY_FLAG(sb, UDF_FLAG_INCONSISTENT))
 		lvid->integrityType = cpu_to_le32(LVID_INTEGRITY_TYPE_CLOSE);
 
@@ -2220,8 +2229,14 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 			ret = -EINVAL;
 			goto error_out;
 		}
-		minUDFReadRev = le16_to_cpu(lvidiu->minUDFReadRev);
-		minUDFWriteRev = le16_to_cpu(lvidiu->minUDFWriteRev);
+
+		if (sbi->s_lvd_udfrev >= 0x0102) { /* minUDFReadRev and minUDFWriteRev were introduced in UDF 1.02 */
+			minUDFReadRev = le16_to_cpu(lvidiu->minUDFReadRev);
+			minUDFWriteRev = le16_to_cpu(lvidiu->minUDFWriteRev);
+		} else {
+			minUDFReadRev = minUDFWriteRev = sbi->s_lvd_udfrev;
+		}
+
 		if (minUDFReadRev > UDF_MAX_READ_VERSION) {
 			udf_err(sb, "minUDFReadRev=%x (max is %x)\n",
 				minUDFReadRev,
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 3d83be54c..6bd0d4430 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -137,6 +137,9 @@ struct udf_sb_info {
 	/* Fileset Info */
 	__u16			s_serial_number;
 
+	/* LVD UDF revision filled to media at format time */
+	__u16			s_lvd_udfrev;
+
 	/* highest UDF revision we have recorded to this media */
 	__u16			s_udfrev;
 
-- 
2.20.1

