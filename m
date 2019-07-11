Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7786A657F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 15:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfGKNjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 09:39:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34961 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbfGKNjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:39:49 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so12630633ioo.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2019 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=J6xUpl3LGrcfXZq9XYXjgjQhRvk3EDm/aUvIPtVRdsn6YwB6MeoOX1bVjlXjCz7GyE
         mhN/3QX3ZTDmfEXUyCsrpXqJ3Y9OCtW321tJHFk+zDlCzYd7UO0cQrTZADPvDL0x7au8
         5bqEPMKZS6j4jyKs2f5KGpgI2P4Z2U2RLtUhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shtQwTN82SLzlsJ+3Dw6r1akGAa25vF9P/FWU52bI/A=;
        b=Gy/AT5Qo6aiR1iGK9YjRuFwcfbYJN7sWluxQCmSOXYZ9xnYYfaOGzcKAubCBLSLaql
         w7ArTNIfdvmPTn2EAEYiA2Jhb1LNyrm4Kc8FFRm4I1qsTa9gTHCrlED6oDg1NN2j/Znf
         r1cZJLp7zpk06ABTfXUnWtcHES0qqAtDOC8hpjWgg52zQbYFTxllZDXXQZoT64HXww0K
         QTeHaK+dY4rDUGDVc0IwsMiAgiQODHOdINvRxAb3PQuw8+82fKmHyJDsoJ57os/ebO6F
         HfFpI0vaevN7//ZzdTrkkDK0+m/H7vUVBpOdTHjSvuFi4eQvu3OblNnZ7BQOLdHb+pax
         S76Q==
X-Gm-Message-State: APjAAAVzKPq1d558yObwzpgbHba/BxJc7w5eBbCSNJJJ7ifFUp8K9RI0
        lj3RnrRNu5mts8c9ta3XsrXflg==
X-Google-Smtp-Source: APXvYqwqul/LDm81/jCmBsHIlGWxPfbJ84LDnGDdpTrjfTFg+kRxMtPm19SEDIvbJTj8KkcITbgJrQ==
X-Received: by 2002:a6b:5115:: with SMTP id f21mr4493812iob.173.1562852388663;
        Thu, 11 Jul 2019 06:39:48 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id u4sm6035902iol.59.2019.07.11.06.39.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 06:39:48 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH v2 2/2] udf: support 2048-byte spacing of VRS descriptors on 4K media
Date:   Thu, 11 Jul 2019 08:38:52 -0500
Message-Id: <20190711133852.16887-2-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711133852.16887-1-steve@digidescorp.com>
References: <20190711133852.16887-1-steve@digidescorp.com>
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
