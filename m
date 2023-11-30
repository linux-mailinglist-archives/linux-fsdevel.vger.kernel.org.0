Return-Path: <linux-fsdevel+bounces-4307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359397FE70D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48052821B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B00134B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C62595;
	Wed, 29 Nov 2023 17:33:49 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2859c011cb0so500623a91.1;
        Wed, 29 Nov 2023 17:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308028; x=1701912828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RASKjKm4nLxb/R40dTTJuuHVAsjKJQJdoYQIctJ4Wj4=;
        b=oayq+asoylAjeX3c5F9nW9t1pvhG+WejX8cyDAXjzSi5uDBdT9qC2zBn8alaEcUEl+
         z0PzHOmSlbihEm8Iv/EJS9GHR6/2G0k2vCBB3wPuN27hQ/wMvl5n1Kph2DxWw8MjlxgT
         zRaH3A46sx+DJQUi/SDStfPMd9rCMHJayy1VeQgo8VF533SmDPk4F4xKbOPeefHElMAr
         F6ZH0l90kmk+vUWiO45baTpPaKxNH+mL332iaPlgGTuNIRs/dXBHaCLu9sXqOVA5hZSO
         2oqWYUz1FSxMNE0f7GFjlVVjR0R1KCed0tmVGdYTI3r3Qbw8h0Hlo5rvDtGBfJBSOhtp
         YjOg==
X-Gm-Message-State: AOJu0YwWBJ9YmLda7lyGbzWL3S5dMt6ft66LjiiUJzLqZNRYqpkZZ1fI
	Yt1+OBKcZTxFdAfWqhZfwOk=
X-Google-Smtp-Source: AGHT+IFV53GmxLlglVBYipVMkQZDesvI4yBeBlOte1fzdPaxS6MjVeo8sQ1sQD7JoIOPwfh11GfPDg==
X-Received: by 2002:a17:90a:356:b0:285:83c8:b19d with SMTP id 22-20020a17090a035600b0028583c8b19dmr22546459pjf.16.1701308028395;
        Wed, 29 Nov 2023 17:33:48 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:47 -0800 (PST)
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
Subject: [PATCH v5 13/17] scsi_debug: Rework page code error handling
Date: Wed, 29 Nov 2023 17:33:18 -0800
Message-ID: <20231130013322.175290-14-bvanassche@acm.org>
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

Instead of tracking whether or not the page code is valid in a boolean
variable, jump to error handling code if an unsupported page code is
encountered.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b9a39829a012..a2d25177f0f3 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2631,7 +2631,7 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 	unsigned char *ap;
 	unsigned char arr[SDEBUG_MAX_MSENSE_SZ];
 	unsigned char *cmd = scp->cmnd;
-	bool dbd, llbaa, msense_6, is_disk, is_zbc, bad_pcode;
+	bool dbd, llbaa, msense_6, is_disk, is_zbc;
 
 	dbd = !!(cmd[1] & 0x8);		/* disable block descriptors */
 	pcontrol = (cmd[2] & 0xc0) >> 6;
@@ -2695,7 +2695,6 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
 		return check_condition_result;
 	}
-	bad_pcode = false;
 
 	switch (pcode) {
 	case 0x1:	/* Read-Write error recovery page, direct access */
@@ -2710,15 +2709,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		if (is_disk) {
 			len = resp_format_pg(ap, pcontrol, target);
 			offset += len;
-		} else
-			bad_pcode = true;
+		} else {
+			goto bad_pcode;
+		}
 		break;
 	case 0x8:	/* Caching page, direct access */
 		if (is_disk || is_zbc) {
 			len = resp_caching_pg(ap, pcontrol, target);
 			offset += len;
-		} else
-			bad_pcode = true;
+		} else {
+			goto bad_pcode;
+		}
 		break;
 	case 0xa:	/* Control Mode page, all devices */
 		len = resp_ctrl_m_pg(ap, pcontrol, target);
@@ -2771,18 +2772,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	default:
-		bad_pcode = true;
-		break;
-	}
-	if (bad_pcode) {
-		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
-		return check_condition_result;
+		goto bad_pcode;
 	}
 	if (msense_6)
 		arr[0] = offset - 1;
 	else
 		put_unaligned_be16((offset - 2), arr + 0);
 	return fill_from_dev_buffer(scp, arr, min_t(u32, alloc_len, offset));
+
+bad_pcode:
+	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
+	return check_condition_result;
 }
 
 #define SDEBUG_MAX_MSELECT_SZ 512

