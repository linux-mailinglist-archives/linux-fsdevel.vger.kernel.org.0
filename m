Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24373138798
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 19:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgALR7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 12:59:52 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:51302 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733191AbgALR7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:59:52 -0500
Received: by mail-wm1-f52.google.com with SMTP id d73so7216562wmd.1;
        Sun, 12 Jan 2020 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UI0olG8Ukex2VWgAiT/l06nIRGJslLR40+ZHv7ZVUKc=;
        b=u4VYHSVtc62kKwCw8LfnRdHaQz785lmJ/mFM6OwbwFG5eM/ox/lljIrE490W5Ivl1E
         TvVGQ031Wu269rPLrJPT61hw4wFDbd0xQCLGONvT5PjYTWlcqw4QShlWzkiLJbcP4LwE
         D6MWSImvjwW4uiJMmKNF53GD2dPjUUlr2IioWYh5HS/wTnORZellfnu04Kk2zewQvGuk
         Kpra+pFY6+0LbSt5aIzuTrBKAD1weJI0gpgLdelEgDO/LeUeoUkI+kwV827xCOnoo3n5
         m4c8iICpKkPWsMqwIOpYu/btWo08a4CN6V31UoN7g1JQrSJFtNp5SYd74G4ECIc94uyd
         r+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UI0olG8Ukex2VWgAiT/l06nIRGJslLR40+ZHv7ZVUKc=;
        b=K8cyzcYICi0OOSeh6OeMpz0pbHh2kbE3csN7yHbs0hWM/x7VF8lx4rXZwedu7iyt4h
         xbzuTmEvSMRQ5hRDZcUpRLmmkwr4KBjcs46w9EBjc9Z4phkGOhOikVStmc+ENwSyJh2n
         tdFVOSP+CqJ7Nix3CyGFuUEdGpBLZl8spZkxbUst22hfClGfLTtF6FYCJOfB0ic8u5vC
         wwvszQzKODwIXPiQvEVLEOVqACrwfvyy8pFQ0PVD/hq1XEokQYZe0ZvYcnJv4cRXNLYP
         GVlXkXE1cpi1dTZeESKs+QDBI7hWPDMnnWwBLt4qSmg4Q4EnxH1ud7MttkHhDWHzZ/bN
         CEbg==
X-Gm-Message-State: APjAAAUe+zPWUiZXaeBuEGmvy8VYd/nInxGosEjh6NRxSPl3fNFCYHBK
        yrAGx4AuCqKjm0m4mD0lYYVstTbQ
X-Google-Smtp-Source: APXvYqwIILguQViiff3Pti4Cez1bl6U3fwyMu1qvpJl99JqO/PKZcXKhB0sk5rqPaBqdjWso1LIdyA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr14913994wmi.166.1578851990392;
        Sun, 12 Jan 2020 09:59:50 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id t25sm11076522wmj.19.2020.01.12.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:59:49 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [WIP PATCH 3/4] udf: Fix reading minUDFReadRev and minUDFWriteRev from UDF 2.00+ VAT discs
Date:   Sun, 12 Jan 2020 18:59:32 +0100
Message-Id: <20200112175933.5259-4-pali.rohar@gmail.com>
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
 fs/udf/super.c  | 11 ++++++++++-
 fs/udf/udf_sb.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index e8661bf01..0dad63f88 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1223,6 +1223,10 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 			le32_to_cpu(vat20->numFiles);
 		map->s_type_specific.s_virtual.s_num_dirs =
 			le32_to_cpu(vat20->numDirs);
+		map->s_type_specific.s_virtual.s_min_udf_read_rev =
+			le16_to_cpu(vat20->minUDFReadRev);
+		map->s_type_specific.s_virtual.s_min_udf_write_rev =
+			le16_to_cpu(vat20->minUDFWriteRev);
 		map->s_type_specific.s_virtual.s_start_offset =
 			le16_to_cpu(vat20->lengthHeader);
 		map->s_type_specific.s_virtual.s_num_entries =
@@ -2238,7 +2242,12 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
 			goto error_out;
 		}
 
-		if (sbi->s_lvd_udfrev >= 0x0102) { /* minUDFReadRev and minUDFWriteRev were introduced in UDF 1.02 */
+		if ((sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP15 ||
+		     sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP20) &&
+		     sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_has_additional_data) {
+			minUDFReadRev = sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_min_udf_read_rev;
+			minUDFWriteRev = sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_min_udf_write_rev;
+		} else if (sbi->s_lvd_udfrev >= 0x0102) { /* minUDFReadRev and minUDFWriteRev were introduced in UDF 1.02 */
 			minUDFReadRev = le16_to_cpu(lvidiu->minUDFReadRev);
 			minUDFWriteRev = le16_to_cpu(lvidiu->minUDFWriteRev);
 		} else {
diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index c74abbc84..baac0357b 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -81,6 +81,8 @@ struct udf_virtual_data {
 	bool	s_has_additional_data;
 	__u32	s_num_files;
 	__u32	s_num_dirs;
+	__u16	s_min_udf_read_rev;
+	__u16	s_min_udf_write_rev;
 };
 
 struct udf_bitmap {
-- 
2.20.1

