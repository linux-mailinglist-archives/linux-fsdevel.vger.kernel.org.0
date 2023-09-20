Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE67A8CA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjITTQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjITTPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:55 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5AE9;
        Wed, 20 Sep 2023 12:15:08 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-27474c64b0bso54454a91.3;
        Wed, 20 Sep 2023 12:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237307; x=1695842107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgLtfRupmxASF+XQWKDQIVeDU0ZhEvhZXbulw0ZxJ0s=;
        b=TH6UI/TQ0MSN3QqmwkHtnPn8Q/7oEyPuDXNxxhAvsC7HP+0NqF4w8D0GLWgm2SPSir
         nycbRCselyRT+ldvjAUe54WMnlVV1DLyqiaWuQ9KVyV7TuNBFyWHB4071YvkxCkbE5/K
         F+EVfy+doWDAWm/OWMA5vIfZj0Lud7AdOWqgkeAvTmEPjnMNeTWBWbRrW9Qhskh61sTS
         Poos4kXpdiIQtTZ/utXmnQM7X0Y1W36++Cr7DLcu9nDsFCgSm3KAB8+du1vL5yqBfJ7/
         3X+/IPROM2gOdv/7DgGfxfFEglN6im6lgkmIBJYAQ5vtehB5CVZkfE3UyBRZtiVZGKXg
         IHbg==
X-Gm-Message-State: AOJu0YwMIZkizekyROYPCmjN3ghF0uk4zQv7TQJSqw+aeGcND5vGqpBA
        GmlARgyHbBKzRMxZjBg0qBQ=
X-Google-Smtp-Source: AGHT+IF0IJK84wVY/2R+FJFvO5sVqwZYvE7nPbClXd/RbQ5RLiz0wG6Zn4y57b6ADFqFSX/p2gwkuQ==
X-Received: by 2002:a17:90b:19cb:b0:274:2523:fc7f with SMTP id nm11-20020a17090b19cb00b002742523fc7fmr3425855pjb.47.1695237307155;
        Wed, 20 Sep 2023 12:15:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:15:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 11/13] scsi_debug: Rework subpage code error handling
Date:   Wed, 20 Sep 2023 12:14:36 -0700
Message-ID: <20230920191442.3701673-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920191442.3701673-1-bvanassche@acm.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the subpage code checks into the switch statement to make it easier
to add support for new page code / subpage code combinations.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 70 ++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6b87d267c9c5..a96eb0d10346 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2386,22 +2386,22 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		ap = arr + offset;
 	}
 
-	if ((subpcode > 0x0) && (subpcode < 0xff) && (0x19 != pcode)) {
-		/* TODO: Control Extension page */
-		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
-		return check_condition_result;
-	}
-
 	switch (pcode) {
 	case 0x1:	/* Read-Write error recovery page, direct access */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		len = resp_err_recov_pg(ap, pcontrol, target);
 		offset += len;
 		break;
 	case 0x2:	/* Disconnect-Reconnect page, all devices */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		len = resp_disconnect_pg(ap, pcontrol, target);
 		offset += len;
 		break;
 	case 0x3:       /* Format device page, direct access */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		if (is_disk) {
 			len = resp_format_pg(ap, pcontrol, target);
 			offset += len;
@@ -2410,6 +2410,8 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0x8:	/* Caching page, direct access */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		if (is_disk || is_zbc) {
 			len = resp_caching_pg(ap, pcontrol, target);
 			offset += len;
@@ -2418,14 +2420,14 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0xa:	/* Control Mode page, all devices */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		len = resp_ctrl_m_pg(ap, pcontrol, target);
 		offset += len;
 		break;
 	case 0x19:	/* if spc==1 then sas phy, control+discover */
-		if ((subpcode > 0x2) && (subpcode < 0xff)) {
-			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
-			return check_condition_result;
-		}
+		if (subpcode > 0x2 && subpcode < 0xff)
+			goto bad_subpcode;
 		len = 0;
 		if ((0x0 == subpcode) || (0xff == subpcode))
 			len += resp_sas_sf_m_pg(ap + len, pcontrol, target);
@@ -2437,35 +2439,31 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		offset += len;
 		break;
 	case 0x1c:	/* Informational Exceptions Mode page, all devices */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		len = resp_iec_m_pg(ap, pcontrol, target);
 		offset += len;
 		break;
 	case 0x3f:	/* Read all Mode pages */
-		if ((0 == subpcode) || (0xff == subpcode)) {
-			len = resp_err_recov_pg(ap, pcontrol, target);
-			len += resp_disconnect_pg(ap + len, pcontrol, target);
-			if (is_disk) {
-				len += resp_format_pg(ap + len, pcontrol,
-						      target);
-				len += resp_caching_pg(ap + len, pcontrol,
-						       target);
-			} else if (is_zbc) {
-				len += resp_caching_pg(ap + len, pcontrol,
-						       target);
-			}
-			len += resp_ctrl_m_pg(ap + len, pcontrol, target);
-			len += resp_sas_sf_m_pg(ap + len, pcontrol, target);
-			if (0xff == subpcode) {
-				len += resp_sas_pcd_m_spg(ap + len, pcontrol,
-						  target, target_dev_id);
-				len += resp_sas_sha_m_spg(ap + len, pcontrol);
-			}
-			len += resp_iec_m_pg(ap + len, pcontrol, target);
-			offset += len;
-		} else {
-			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
-			return check_condition_result;
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
+		len = resp_err_recov_pg(ap, pcontrol, target);
+		len += resp_disconnect_pg(ap + len, pcontrol, target);
+		if (is_disk) {
+			len += resp_format_pg(ap + len, pcontrol, target);
+			len += resp_caching_pg(ap + len, pcontrol, target);
+		} else if (is_zbc) {
+			len += resp_caching_pg(ap + len, pcontrol, target);
+		}
+		len += resp_ctrl_m_pg(ap + len, pcontrol, target);
+		len += resp_sas_sf_m_pg(ap + len, pcontrol, target);
+		if (0xff == subpcode) {
+			len += resp_sas_pcd_m_spg(ap + len, pcontrol, target,
+						  target_dev_id);
+			len += resp_sas_sha_m_spg(ap + len, pcontrol);
 		}
+		len += resp_iec_m_pg(ap + len, pcontrol, target);
+		offset += len;
 		break;
 	default:
 		goto bad_pcode;
@@ -2479,6 +2477,10 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 bad_pcode:
 	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
 	return check_condition_result;
+
+bad_subpcode:
+	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
+	return check_condition_result;
 }
 
 #define SDEBUG_MAX_MSELECT_SZ 512
