Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0164C657F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfGKNjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 09:39:48 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:43473 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfGKNjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:39:47 -0400
Received: by mail-io1-f47.google.com with SMTP id k20so12540933ios.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2019 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OMzOtcTDaPuutCWarO8/hubDu6gmJZ+DgezGavT2Dc8=;
        b=HbnTNvTwyjv1eO38XrDQkkiz1r9CiU+XRHdvwiMIj5h/28zc7QZiu18009Z6r3hbfR
         aV9zORoeUaB7ON9O5YV+O/mczDD/AutN1Sd6xbexhOtkg6QulcQJs/w2pPqUWTeOua2K
         DeyX95zVQ1un9efmd14Gsyr0o+UJc/z3M0Hxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OMzOtcTDaPuutCWarO8/hubDu6gmJZ+DgezGavT2Dc8=;
        b=qtsi9Txz+Rvr7Lgv8ixsnpTxM4p5QZXU1bB/2o9iBIDyVB+rrClcsxIeyF2ta7ufed
         nx+7rBupihj+36f6IOxwgIjcG+rhttmtEkD+zO2ugKaQZuN5M3XSATxb6afK/r7Tm4rJ
         Hp/08+vByIuyVhnNvasWck8CwkSeQuGRoJMKwAyPgLutSysDHTW8NiqWwAdfi04u5Qg3
         ulXLkEaQQyKYQ1iDJEaqOElvpdjAjNa3HEEBITF2TLmCPI1wURsAnljF397hAGzeS4+V
         2nR9GCgU3Iq/fqKF4SQGrgRONZFL76A+BA1d58UZvg291MSqZcbWlGL9k/DTtBSB9eqC
         YRzw==
X-Gm-Message-State: APjAAAUGwnjmOQR3FXDBOcauA1hpoA7WukzWrZ8xM7VXo8NiRK6UwXED
        pXTRhlgxZmLBGm0nkHawgo1VOA==
X-Google-Smtp-Source: APXvYqxmmOhhot0GSRBAbp875mT9MpKSjBOUXjMz3wkXmp1edLFpPOcavYzu2doQE/5DrG1poTDOcw==
X-Received: by 2002:a05:6602:2289:: with SMTP id d9mr4455389iod.47.1562852386757;
        Thu, 11 Jul 2019 06:39:46 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id u4sm6035902iol.59.2019.07.11.06.39.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 06:39:46 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH v2 1/2] udf: refactor VRS descriptor identification
Date:   Thu, 11 Jul 2019 08:38:51 -0500
Message-Id: <20190711133852.16887-1-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extract code that parses a Volume Recognition Sequence descriptor
(component), in preparation for calling it twice against different
locations in a block.

Change from v1:
Fix regression in debug logging of "open disc" condition

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

--- a/fs/udf/super.c	2019-07-10 18:57:41.192852154 -0500
+++ b/fs/udf/super.c	2019-07-10 20:47:50.438352500 -0500
@@ -685,16 +685,62 @@ out_unlock:
 	return error;
 }
 
-/* Check Volume Structure Descriptors (ECMA 167 2/9.1) */
-/* We also check any "CD-ROM Volume Descriptor Set" (ECMA 167 2/8.3.1) */
-static loff_t udf_check_vsd(struct super_block *sb)
+static int identify_vsd(const struct volStructDesc *vsd)
+{
+	int vsd_id = 0;
+
+	if (!strncmp(vsd->stdIdent, VSD_STD_ID_CD001, VSD_STD_ID_LEN)) {
+		switch (vsd->structType) {
+		case 0:
+			udf_debug("ISO9660 Boot Record found\n");
+			break;
+		case 1:
+			udf_debug("ISO9660 Primary Volume Descriptor found\n");
+			break;
+		case 2:
+			udf_debug("ISO9660 Supplementary Volume Descriptor found\n");
+			break;
+		case 3:
+			udf_debug("ISO9660 Volume Partition Descriptor found\n");
+			break;
+		case 255:
+			udf_debug("ISO9660 Volume Descriptor Set Terminator found\n");
+			break;
+		default:
+			udf_debug("ISO9660 VRS (%u) found\n", vsd->structType);
+			break;
+		}
+	} else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BEA01, VSD_STD_ID_LEN))
+		vsd_id = 1;
+	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR02, VSD_STD_ID_LEN))
+		vsd_id = 2;
+	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR03, VSD_STD_ID_LEN))
+		vsd_id = 3;
+	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BOOT2, VSD_STD_ID_LEN))
+		; /* vsd_id = 0 */
+	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_CDW02, VSD_STD_ID_LEN))
+		; /* vsd_id = 0 */
+	else {
+		/* TEA01 or invalid id : end of volume recognition area */
+		vsd_id = 255;
+	}
+
+	return vsd_id;
+}
+
+/*
+ * Check Volume Structure Descriptors (ECMA 167 2/9.1)
+ * We also check any "CD-ROM Volume Descriptor Set" (ECMA 167 2/8.3.1)
+ * @return   2 if NSR02 found, 3 if NSR03 found,
+ *	    -1 if first sector read error, 0 otherwise
+ */
+static int udf_check_vsd(struct super_block *sb)
 {
 	struct volStructDesc *vsd = NULL;
 	loff_t sector = VSD_FIRST_SECTOR_OFFSET;
 	int sectorsize;
 	struct buffer_head *bh = NULL;
-	int nsr02 = 0;
-	int nsr03 = 0;
+	int nsr = 0;
 	struct udf_sb_info *sbi;
 
 	sbi = UDF_SB(sb);
@@ -718,71 +764,27 @@ static loff_t udf_check_vsd(struct super
 	 * activity. This actually happened with uninitialised SSD partitions
 	 * (all 0xFF) before the check for the limit and all valid IDs were
 	 * added */
-	for (; !nsr02 && !nsr03 && sector < VSD_MAX_SECTOR_OFFSET;
+	for (; (nsr < 2) && sector < VSD_MAX_SECTOR_OFFSET;
 	     sector += sectorsize) {
+		int vsd_id;
+
 		/* Read a block */
 		bh = udf_tread(sb, sector >> sb->s_blocksize_bits);
 		if (!bh)
 			break;
 
-		/* Look for ISO  descriptors */
 		vsd = (struct volStructDesc *)(bh->b_data +
 					      (sector & (sb->s_blocksize - 1)));
 
-		if (!strncmp(vsd->stdIdent, VSD_STD_ID_CD001,
-				    VSD_STD_ID_LEN)) {
-			switch (vsd->structType) {
-			case 0:
-				udf_debug("ISO9660 Boot Record found\n");
-				break;
-			case 1:
-				udf_debug("ISO9660 Primary Volume Descriptor found\n");
-				break;
-			case 2:
-				udf_debug("ISO9660 Supplementary Volume Descriptor found\n");
-				break;
-			case 3:
-				udf_debug("ISO9660 Volume Partition Descriptor found\n");
-				break;
-			case 255:
-				udf_debug("ISO9660 Volume Descriptor Set Terminator found\n");
-				break;
-			default:
-				udf_debug("ISO9660 VRS (%u) found\n",
-					  vsd->structType);
-				break;
-			}
-		} else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BEA01,
-				    VSD_STD_ID_LEN))
-			; /* nothing */
-		else if (!strncmp(vsd->stdIdent, VSD_STD_ID_TEA01,
-				    VSD_STD_ID_LEN)) {
-			brelse(bh);
-			break;
-		} else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR02,
-				    VSD_STD_ID_LEN))
-			nsr02 = sector;
-		else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR03,
-				    VSD_STD_ID_LEN))
-			nsr03 = sector;
-		else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BOOT2,
-				    VSD_STD_ID_LEN))
-			; /* nothing */
-		else if (!strncmp(vsd->stdIdent, VSD_STD_ID_CDW02,
-				    VSD_STD_ID_LEN))
-			; /* nothing */
-		else {
-			/* invalid id : end of volume recognition area */
-			brelse(bh);
-			break;
-		}
+		vsd_id = identify_vsd(vsd);
+		if (vsd_id > nsr)
+			nsr = vsd_id;
+
 		brelse(bh);
 	}
 
-	if (nsr03)
-		return nsr03;
-	else if (nsr02)
-		return nsr02;
+	if ((nsr >= 2) && (nsr <= 3))
+		return nsr;
 	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
 			VSD_FIRST_SECTOR_OFFSET)
 		return -1;
@@ -1936,7 +1938,7 @@ static int udf_load_vrs(struct super_blo
 			int silent, struct kernel_lb_addr *fileset)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-	loff_t nsr_off;
+	int nsr = 0;
 	int ret;
 
 	if (!sb_set_blocksize(sb, uopt->blocksize)) {
@@ -1947,13 +1949,13 @@ static int udf_load_vrs(struct super_blo
 	sbi->s_last_block = uopt->lastblock;
 	if (!uopt->novrs) {
 		/* Check that it is NSR02 compliant */
-		nsr_off = udf_check_vsd(sb);
-		if (!nsr_off) {
+		nsr = udf_check_vsd(sb);
+		if (!nsr) {
 			if (!silent)
 				udf_warn(sb, "No VRS found\n");
 			return -EINVAL;
 		}
-		if (nsr_off == -1)
+		if (nsr == -1)
 			udf_debug("Failed to read sector at offset %d. "
 				  "Assuming open disc. Skipping validity "
 				  "check\n", VSD_FIRST_SECTOR_OFFSET);
