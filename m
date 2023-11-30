Return-Path: <linux-fsdevel+bounces-4309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFC7FE70F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB46C1C2089C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AE134A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB5F198;
	Wed, 29 Nov 2023 17:33:50 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c239897895so400550a12.2;
        Wed, 29 Nov 2023 17:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308030; x=1701912830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+xqXglR3+BSOL4njxSi9nvnVhvoALDgqBUC0+oGvwk=;
        b=bMa2B7OdZzv/xmGzdlqudPujXt6sukGrRFD+8DooGh9Qu76e1VVCO3yk+T1HmMIZde
         s81wMJ1Sz9nTfPd7txqhwn8ZoUSa3F9erODHGrLbBbxRIX55qNDKzkB9TZTRvh0CjMq7
         i2IAZhDc3DRitsfeCNkCxDl0+LXcNSBJc4QxIyWIpkgdt6Kr4I6Biy94Gw9WACD3u1Rz
         2Ma6T0DlO45y4TWyNIdQrlpATo30g0607T9d/U/lNxiv/rJC7UiAOZCuBDQbsjlt5we5
         0xCu1IkBpZhVjVlw2bq6RV7rYYzj3W5jZqUgLWVZQ805irrFwmWAoxz7XJbtoFG+tTW+
         0rHg==
X-Gm-Message-State: AOJu0YzzE/YHqzaawZWuZsNhK4JKxAlN/odbH+z4IqPHS9Un1qNg05/I
	DamuZ5UqHoAYX0W4W7Z71/Q=
X-Google-Smtp-Source: AGHT+IEA975ENyWNyAPH5uwLXF5LTRVB3oPbSWrNQosvAvZzA2S6plFh0/eNEjlknaeVptWvCjqYcA==
X-Received: by 2002:a17:90b:1e02:b0:285:ade1:10cb with SMTP id pg2-20020a17090b1e0200b00285ade110cbmr15008752pjb.10.1701308029764;
        Wed, 29 Nov 2023 17:33:49 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:49 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Douglas Gilbert <dgilbert@interlog.com>
Subject: [PATCH v5 14/17] scsi_debug: Rework subpage code error handling
Date: Wed, 29 Nov 2023 17:33:19 -0800
Message-ID: <20231130013322.175290-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130013322.175290-1-bvanassche@acm.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the subpage code checks into the switch statement to make it easier
to add support for new page code / subpage code combinations.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 70 ++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a2d25177f0f3..7674bb87b198 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2690,22 +2690,22 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2714,6 +2714,8 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0x8:	/* Caching page, direct access */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		if (is_disk || is_zbc) {
 			len = resp_caching_pg(ap, pcontrol, target);
 			offset += len;
@@ -2722,14 +2724,14 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2741,35 +2743,31 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2783,6 +2781,10 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 bad_pcode:
 	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
 	return check_condition_result;
+
+bad_subpcode:
+	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
+	return check_condition_result;
 }
 
 #define SDEBUG_MAX_MSELECT_SZ 512

