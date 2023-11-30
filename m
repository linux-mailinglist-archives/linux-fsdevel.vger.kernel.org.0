Return-Path: <linux-fsdevel+bounces-4310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B67FE710
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469FCB20F51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C8A134B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E410CE;
	Wed, 29 Nov 2023 17:33:51 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so428488a91.3;
        Wed, 29 Nov 2023 17:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308031; x=1701912831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPUr7AN5wjXpBKb3YYxtHgtGvE4TLpsCPP6Q+ma8VNA=;
        b=lYufhd8rRcSHN0AZrYoHNDVSyh2Aa+FX8k9NjjRrkIJ94cQzJksV2fnGia4LlaPC52
         CE1cEuVr4hh6gnsogdyrG0tkYn0AIYx63HK+lYtJz6HR6jfne138Uc5Fr26SMvB8CmuO
         EKavMsXN5dAtuZvWfJo4K3jpxWkv8+wuomoXSSQUeixWiDt+LIuNSGoD7jhqCrhXgY+I
         XgELOIRDEsMLwWANMkJeZo8o3B2ovYuxCNbhFsBzAr+2jWd9wJQhiv8zp6n3dV1nsKPE
         7RQKuoZn1+v3y3De8XJSIhnO25LSTbdaxQmSKzLccvM2WV2IHE3zvjpa07YoSBi7mLPU
         V7Cg==
X-Gm-Message-State: AOJu0Ywjsq8guhF4cDH/4kOaG9G3DLm+ZaoQa4b9ioeWq3vCG6WrgPFV
	4dyHi676Gsz7ffi3uhlvyzA=
X-Google-Smtp-Source: AGHT+IF1zqN3w2RA3xQHqAi1gk3aegBF3YwJYAUy1z4cWsmRnV1Cb2Ulj3K6+LONJtOC6XkCUmQ3Aw==
X-Received: by 2002:a17:90a:1cf:b0:285:9b85:45ee with SMTP id 15-20020a17090a01cf00b002859b8545eemr15219491pjd.3.1701308031053;
        Wed, 29 Nov 2023 17:33:51 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:50 -0800 (PST)
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
Subject: [PATCH v5 15/17] scsi_debug: Implement the IO Advice Hints Grouping mode page
Date: Wed, 29 Nov 2023 17:33:20 -0800
Message-ID: <20231130013322.175290-16-bvanassche@acm.org>
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

Implement an IO Advice Hints Grouping mode page with three permanent
streams. A permanent stream is a stream for which the device server does
not allow closing or otherwise modifying the configuration of that
stream. The stream identifier enable (ST_ENBLE) bit specifies whether
the stream identifier may be used in the GROUP NUMBER field of SCSI
WRITE commands.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 42 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 7674bb87b198..a1f4a499b82c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2545,6 +2545,36 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(ctrl_m_pg);
 }
 
+enum { MAXIMUM_NUMBER_OF_STREAMS = 4 };
+
+/* IO Advice Hints Grouping mode page */
+static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
+{
+	/* IO Advice Hints Grouping mode page */
+	struct grouping_m_pg {
+		u8 page_code;
+		u8 subpage_code;
+		__be16 page_length;
+		u8 reserved[12];
+		struct scsi_io_group_descriptor
+			descr[MAXIMUM_NUMBER_OF_STREAMS];
+	};
+	static const struct grouping_m_pg gr_m_pg = {
+		.page_code = 0xa,
+		.subpage_code = 5,
+		.page_length = cpu_to_be16(sizeof(gr_m_pg) - 4),
+		.descr = {
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 0 },
+		}
+	};
+
+	BUILD_BUG_ON(sizeof(struct grouping_m_pg) != 16 + 4 * 16);
+	memcpy(p, &gr_m_pg, sizeof(gr_m_pg));
+	return sizeof(gr_m_pg);
+}
 
 static int resp_iec_m_pg(unsigned char *p, int pcontrol, int target)
 {	/* Informational Exceptions control mode page for mode_sense */
@@ -2724,9 +2754,17 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0xa:	/* Control Mode page, all devices */
-		if (subpcode > 0x0 && subpcode < 0xff)
+		switch (subpcode) {
+		case 0:
+		case 0xff:
+			len = resp_ctrl_m_pg(ap, pcontrol, target);
+			break;
+		case 0x05:
+			len = resp_grouping_m_pg(ap, pcontrol, target);
+			break;
+		default:
 			goto bad_subpcode;
-		len = resp_ctrl_m_pg(ap, pcontrol, target);
+		}
 		offset += len;
 		break;
 	case 0x19:	/* if spc==1 then sas phy, control+discover */

