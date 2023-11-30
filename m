Return-Path: <linux-fsdevel+bounces-4305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0077FE70B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4473B20F32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA90134BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E0A10C3;
	Wed, 29 Nov 2023 17:33:46 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1cfb4d28c43so4504315ad.1;
        Wed, 29 Nov 2023 17:33:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308026; x=1701912826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkSfUcpnh8PvnHDsfNZNkdUSjQw/qQT17pFxq0lAy8s=;
        b=VHDBGKLRMaE4JwcOahMN3NLc9k27TTDGv45XwP5tqTWQGGkYjeIH8MTtbAGHRF8U4Z
         jgj6tRGqpg/m410x2SsA6Oh9nKMHdyGoSRtMLlAxEWJDaDG9m1Rx4O5lPBzIMpNXlDEU
         coBNW6tA8qdTaw0pgrrReBb+ZRLw5juf5TcjLeDAA1NHrjmxxon2JQb12/0s2xFWImKq
         QWOAzCt8oDng08hHw9VN6ltxJTKMdbJ89BUdU048hesJuTHplKQr7peP/lf4y77hu2JJ
         yWEubuZXTsiVUaEqS5a/zkPdSZzVM2nH/0WRlnsySOr/eRGnIB/E5QV8bx06wEZX8/ij
         xAiw==
X-Gm-Message-State: AOJu0Yw9lzCmhELsCdMt+aPMnALpDyStUhWUAA7KbBYjM9W6+99SuUdy
	S7MxhllqlWjjMX1PiB+xtuo=
X-Google-Smtp-Source: AGHT+IH0eJWutgnl5hcSr4uJjTgEtVZ1VWHTo0dVtYBH9KTCcEJ79QbZLReo2NxsZM4xuK9byKO6nw==
X-Received: by 2002:a17:90a:1947:b0:281:5860:12f3 with SMTP id 7-20020a17090a194700b00281586012f3mr17384164pjh.3.1701308025837;
        Wed, 29 Nov 2023 17:33:45 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:45 -0800 (PST)
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
	Avri Altman <avri.altman@wdc.com>,
	Douglas Gilbert <dgilbert@interlog.com>
Subject: [PATCH v5 11/17] scsi_debug: Reduce code duplication
Date: Wed, 29 Nov 2023 17:33:16 -0800
Message-ID: <20231130013322.175290-12-bvanassche@acm.org>
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

All VPD pages have the page code in byte one. Reduce code duplication by
storing the VPD page code once.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6d8218a44122..f6261ad76c09 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1902,7 +1902,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		u32 len;
 		char lu_id_str[6];
 		int host_no = devip->sdbg_host->shost->host_no;
-		
+
+		arr[1] = cmd[2];
 		port_group_id = (((host_no + 1) & 0x7f) << 8) +
 		    (devip->channel & 0x7f);
 		if (sdebug_vpd_use_hostno == 0)
@@ -1913,7 +1914,6 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				 (devip->target * 1000) - 3;
 		len = scnprintf(lu_id_str, 6, "%d", lu_id_num);
 		if (0 == cmd[2]) { /* supported vital product data pages */
-			arr[1] = cmd[2];	/*sanity */
 			n = 4;
 			arr[n++] = 0x0;   /* this page */
 			arr[n++] = 0x80;  /* unit serial number */
@@ -1934,23 +1934,18 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = len;
 			memcpy(&arr[4], lu_id_str, len);
 		} else if (0x83 == cmd[2]) { /* device identification */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_83(&arr[4], port_group_id,
 						target_dev_id, lu_id_num,
 						lu_id_str, len,
 						&devip->lu_name);
 		} else if (0x84 == cmd[2]) { /* Software interface ident. */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_84(&arr[4]);
 		} else if (0x85 == cmd[2]) { /* Management network addresses */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_85(&arr[4]);
 		} else if (0x86 == cmd[2]) { /* extended inquiry */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = 0x3c;	/* number of following entries */
 			if (sdebug_dif == T10_PI_TYPE3_PROTECTION)
 				arr[4] = 0x4;	/* SPT: GRD_CHK:1 */
@@ -1960,30 +1955,23 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				arr[4] = 0x0;   /* no protection stuff */
 			arr[5] = 0x7;   /* head of q, ordered + simple q's */
 		} else if (0x87 == cmd[2]) { /* mode page policy */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = 0x8;	/* number of following entries */
 			arr[4] = 0x2;	/* disconnect-reconnect mp */
 			arr[6] = 0x80;	/* mlus, shared */
 			arr[8] = 0x18;	 /* protocol specific lu */
 			arr[10] = 0x82;	 /* mlus, per initiator port */
 		} else if (0x88 == cmd[2]) { /* SCSI Ports */
-			arr[1] = cmd[2];	/*sanity */
 			arr[3] = inquiry_vpd_88(&arr[4], target_dev_id);
 		} else if (is_disk_zbc && 0x89 == cmd[2]) { /* ATA info */
-			arr[1] = cmd[2];        /*sanity */
 			n = inquiry_vpd_89(&arr[4]);
 			put_unaligned_be16(n, arr + 2);
 		} else if (is_disk_zbc && 0xb0 == cmd[2]) { /* Block limits */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b0(&arr[4]);
 		} else if (is_disk_zbc && 0xb1 == cmd[2]) { /* Block char. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b1(devip, &arr[4]);
 		} else if (is_disk && 0xb2 == cmd[2]) { /* LB Prov. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
-			arr[1] = cmd[2];        /*sanity */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);

