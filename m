Return-Path: <linux-fsdevel+bounces-6449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D51A817E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426921C22BCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA13847E;
	Tue, 19 Dec 2023 00:08:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D453C00;
	Tue, 19 Dec 2023 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d3165ac96bso1176054b3a.0;
        Mon, 18 Dec 2023 16:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944536; x=1703549336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnnL4cR8C+xSU9+oFBLo82Df+WoReU4StMHCaYfa7vk=;
        b=jEyloCAVtqd3d/CNMsWkdy6y81qLKhf8MEAvZ7AuPnqqXVH8ZpXuITMhqHuLFnV1mJ
         Eg1tQrwywXaG3xXKSdggzXUC5cM7jrrI1ia8pu8ktQXnuPloC+e5A093SHQrBRonjpBj
         mp9yED087E2SyE71tB7HzaaB3FSLvwG1OP1zzZ2s5PQjqgRIk/zH65wEPVWeArPTsJRJ
         s+VSmgqOwGUSAhi/B/y7HxzU/Yle71C8sEKjZ9MhTxVnYZ7FPVoNDpMQqkCPdgBJvhsH
         ktn8J9clkZDKQZHasoThXSLAKm/U+YzoEN193ljvQwvfynKqujL1sKQts1M3kQYSbQLN
         AW6A==
X-Gm-Message-State: AOJu0Ywfh9k6qAL3gjXlrJKVnhWhcFp9Fj9PFlKtAorbVqn+Nw8yy9zm
	vHRG7RCE1nhto18Edi812TY=
X-Google-Smtp-Source: AGHT+IF6KVOdWl5ZbLB8OJ+Wj1oxW/DoNRKzunvv+TGDT7/BvOaQ850XVRsk3XIk9eOvqVA1mlRNbQ==
X-Received: by 2002:a05:6a20:2595:b0:190:d1d2:56fd with SMTP id k21-20020a056a20259500b00190d1d256fdmr7837248pzd.39.1702944536294;
        Mon, 18 Dec 2023 16:08:56 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:55 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v8 12/19] scsi: scsi_debug: Reduce code duplication
Date: Mon, 18 Dec 2023 16:07:45 -0800
Message-ID: <20231219000815.2739120-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
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
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 67922e2c4c19..5cf337ba9c19 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1909,7 +1909,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		u32 len;
 		char lu_id_str[6];
 		int host_no = devip->sdbg_host->shost->host_no;
-		
+
+		arr[1] = cmd[2];
 		port_group_id = (((host_no + 1) & 0x7f) << 8) +
 		    (devip->channel & 0x7f);
 		if (sdebug_vpd_use_hostno == 0)
@@ -1920,7 +1921,6 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				 (devip->target * 1000) - 3;
 		len = scnprintf(lu_id_str, 6, "%d", lu_id_num);
 		if (0 == cmd[2]) { /* supported vital product data pages */
-			arr[1] = cmd[2];	/*sanity */
 			n = 4;
 			arr[n++] = 0x0;   /* this page */
 			arr[n++] = 0x80;  /* unit serial number */
@@ -1941,23 +1941,18 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
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
@@ -1967,30 +1962,23 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
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

