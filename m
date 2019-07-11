Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC765793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 15:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfGKNEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 09:04:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36987 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfGKNEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:04:34 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so12339422iog.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2019 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=bYHNLj2555c6nQAGFXIgsx02XGYUdwS5556hzj7AhU7eSNV5HudXIMxO9o/Tg+vHvR
         J/JU8/EISnQ35BHU84MseRjDJTTCks5voIBeOq6zBVfTXscVdANrtBX/Ly5lUjLkkPYz
         qLX9cR8Tku9cfQgOFkbDXFy20RvQEPcn7JRMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=nHZ670uRJeD+NiFH4wKtODAVsBvBxqd7bIDVm0c+b4ZPo6B8/wOeFA9gi2irasRCiy
         ajJRdZ2GB1QM6UAV4+8jncF2hehSIeeXP7pXm8rk1LPVlkqDO2KoFYnY0v/zJB62OO2g
         UUy9XQBJdt7BBO4Fy//Q01KF6FDEO8klLSGy984DSqBXL/mOWpFV8aswsfoHQKUY+nXz
         VXu3F6xxu9qoLZyYbEuximdpq8UvrGsXDxlIFHlp8QvOom2gh2mSF1JabNw3POimsjwQ
         lb/IZfUhQeKFQTHBURxI4FfmL6erWfePe9hvRGF+riCl8iTwMsBGlfKusmsnOT4V1hkh
         1F5A==
X-Gm-Message-State: APjAAAVagZLkN6tgIzpBcSl6dPm0XDWhBJTmdGBBfZZ/kVSO4qNp9gW3
        1W9nqtiJ4ubz9DPT4HEDud/6pg==
X-Google-Smtp-Source: APXvYqzKJRu7RRE0OzusmNdv5ntOQE2Vuy0JDu0xeE9VyYwevfdkM4d9gSmDfN4PNtDu81ZjH3M9/w==
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr4220181ior.163.1562850273790;
        Thu, 11 Jul 2019 06:04:33 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id l11sm4051951ioj.32.2019.07.11.06.04.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 06:04:33 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH 2/2] udf: support 2048-byte spacing of VRS descriptors on 4K media
Date:   Thu, 11 Jul 2019 08:04:10 -0500
Message-Id: <20190711130410.13047-2-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711130410.13047-1-steve@digidescorp.com>
References: <20190711130410.13047-1-steve@digidescorp.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some UDF creators (specifically Microsoft, but perhaps others) mishandle
the ECMA-167 corner case that requires descriptors within a Volume
Recognition Sequence to be placed at 4096-byte intervals on media where
the block size is 4K. Instead, the descriptors are placed at the 2048-
byte interval mandated for media with smaller blocks. This nonconformity
currently prevents Linux from recognizing the filesystem as UDF.

Modify the driver to tolerate a misformatted VRS on 4K media.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

--- a/fs/udf/super.c	2019-07-10 20:55:33.334359446 -0500
+++ b/fs/udf/super.c	2019-07-10 21:20:58.138382326 -0500
@@ -741,6 +741,7 @@ static int udf_check_vsd(struct super_bl
 	int sectorsize;
 	struct buffer_head *bh = NULL;
 	int nsr = 0;
+	int quirk_nsr = 0;
 	struct udf_sb_info *sbi;
 
 	sbi = UDF_SB(sb);
@@ -780,11 +781,27 @@ static int udf_check_vsd(struct super_bl
 		if (vsd_id > nsr)
 			nsr = vsd_id;
 
+		/* Special handling for improperly formatted VRS (e.g., Win10)
+		 * where components are separated by 2048 bytes
+		 * even though sectors are 4K
+		 */
+		if ((sb->s_blocksize == 4096) && (quirk_nsr < 2)) {
+			vsd_id = identify_vsd(vsd + 1);
+			if ((nsr == 1) || (quirk_nsr == 1)) {
+				/* BEA01 has been seen, allow quirk NSR */
+				if (vsd_id > quirk_nsr)
+					quirk_nsr = vsd_id;
+			} else if (vsd_id > 3)
+				quirk_nsr = vsd_id;  /* 0 -> 255 */
+		}
+
 		brelse(bh);
 	}
 
 	if ((nsr >= 2) && (nsr <= 3))
 		return nsr;
+	else if ((quirk_nsr >= 2) && (quirk_nsr <= 3))
+		return quirk_nsr;
 	else if (!bh && sector - (sbi->s_session << sb->s_blocksize_bits) ==
 			VSD_FIRST_SECTOR_OFFSET)
 		return -1;
