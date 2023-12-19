Return-Path: <linux-fsdevel+bounces-6454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE2817E9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96501F23C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CCAC158;
	Tue, 19 Dec 2023 00:09:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2B62B;
	Tue, 19 Dec 2023 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c68da9d639so1657323a12.3;
        Mon, 18 Dec 2023 16:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944543; x=1703549343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF3r6kBvweQQzNsLxPq1BZprgUkPpuRDDhas88uNzHQ=;
        b=LZg+GfAFCtTFX4bjXZcXcy7C9aK/sY26Bd+mnK4Pf65han4AHNLGA2I/TK/ycSJDtt
         lH+l6fZjbQZ8M84LhPsFkV48pccfyCo/tSQ69vBikWm1yuWXx4VGPr5f3ZlMwJwMCSeR
         1qb1Rju0lEZ4aRhX9nK25HlPxBR5wA9tFf21dtJ3FF8FbAgn+vsBBi+BdUgRMEl4CmcY
         AM4tL91u7lGXLKfD6EsC50cw2MYYfHvH/5JM0w61brUhMU8NdMF7bh9USs1ReraDzmW3
         HNAew4I0uiGAMYzHbdYBLez93s6rTf5fO/KjIEbaJqxdFoQOtYhGzPPTaLxmBkvJS1L5
         HSjw==
X-Gm-Message-State: AOJu0YzRF2LKSoQ3mG4mwdIStDBK9REJ9xv70FE5RkxU4XqPunq6tzqY
	XybtEniADpvtI1y65XsDhVw=
X-Google-Smtp-Source: AGHT+IGH0V3Yl9l63FQQFHeataCuwoHdWkCR04ezcDlwRamxVtPE1GhKc1xhdmchMnhGU1Osogco1Q==
X-Received: by 2002:a05:6a20:914b:b0:190:228e:4c11 with SMTP id x11-20020a056a20914b00b00190228e4c11mr9350439pzc.90.1702944543261;
        Mon, 18 Dec 2023 16:09:03 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:09:02 -0800 (PST)
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
	Douglas Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v8 17/19] scsi: scsi_debug: Implement the IO Advice Hints Grouping mode page
Date: Mon, 18 Dec 2023 16:07:50 -0800
Message-ID: <20231219000815.2739120-18-bvanassche@acm.org>
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

Implement an IO Advice Hints Grouping mode page with three permanent
streams. A permanent stream is a stream for which the device server does
not allow closing or otherwise modifying the configuration of that
stream. The stream identifier enable (ST_ENBLE) bit specifies whether
the stream identifier may be used in the GROUP NUMBER field of SCSI
WRITE commands.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 61 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 4181d0d81224..4e18265a05da 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1975,7 +1975,11 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				arr[4] = 0x5;   /* SPT: GRD_CHK:1, REF_CHK:1 */
 			else
 				arr[4] = 0x0;   /* no protection stuff */
-			arr[5] = 0x7;   /* head of q, ordered + simple q's */
+			/*
+			 * GROUP_SUP=1; HEADSUP=1 (HEAD OF QUEUE); ORDSUP=1
+			 * (ORDERED queuing); SIMPSUP=1 (SIMPLE queuing).
+			 */
+			arr[5] = 0x17;
 		} else if (0x87 == cmd[2]) { /* mode page policy */
 			arr[3] = 0x8;	/* number of following entries */
 			arr[4] = 0x2;	/* disconnect-reconnect mp */
@@ -2565,6 +2569,40 @@ static int resp_ctrl_m_pg(unsigned char *p, int pcontrol, int target)
 	return sizeof(ctrl_m_pg);
 }
 
+/* IO Advice Hints Grouping mode page */
+static int resp_grouping_m_pg(unsigned char *p, int pcontrol, int target)
+{
+	/* IO Advice Hints Grouping mode page */
+	struct grouping_m_pg {
+		u8 page_code;	/* OR 0x40 when subpage_code > 0 */
+		u8 subpage_code;
+		__be16 page_length;
+		u8 reserved[12];
+		struct scsi_io_group_descriptor descr[MAXIMUM_NUMBER_OF_STREAMS];
+	};
+	static const struct grouping_m_pg gr_m_pg = {
+		.page_code = 0xa | 0x40,
+		.subpage_code = 5,
+		.page_length = cpu_to_be16(sizeof(gr_m_pg) - 4),
+		.descr = {
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 1 },
+			{ .st_enble = 0 },
+		}
+	};
+
+	BUILD_BUG_ON(sizeof(struct grouping_m_pg) !=
+		     16 + MAXIMUM_NUMBER_OF_STREAMS * 16);
+	memcpy(p, &gr_m_pg, sizeof(gr_m_pg));
+	if (1 == pcontrol) {
+		/* There are no changeable values so clear from byte 4 on. */
+		memset(p + 4, 0, sizeof(gr_m_pg) - 4);
+	}
+	return sizeof(gr_m_pg);
+}
 
 static int resp_iec_m_pg(unsigned char *p, int pcontrol, int target)
 {	/* Informational Exceptions control mode page for mode_sense */
@@ -2714,6 +2752,10 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		ap = arr + offset;
 	}
 
+	/*
+	 * N.B. If len>0 before resp_*_pg() call, then form of that call should be:
+	 *        len += resp_*_pg(ap + len, pcontrol, target);
+	 */
 	switch (pcode) {
 	case 0x1:	/* Read-Write error recovery page, direct access */
 		if (subpcode > 0x0 && subpcode < 0xff)
@@ -2748,9 +2790,20 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0xa:	/* Control Mode page, all devices */
-		if (subpcode > 0x0 && subpcode < 0xff)
+		switch (subpcode) {
+		case 0:
+			len = resp_ctrl_m_pg(ap, pcontrol, target);
+			break;
+		case 0x05:
+			len = resp_grouping_m_pg(ap, pcontrol, target);
+			break;
+		case 0xff:
+			len = resp_ctrl_m_pg(ap, pcontrol, target);
+			len += resp_grouping_m_pg(ap + len, pcontrol, target);
+			break;
+		default:
 			goto bad_subpcode;
-		len = resp_ctrl_m_pg(ap, pcontrol, target);
+		}
 		offset += len;
 		break;
 	case 0x19:	/* if spc==1 then sas phy, control+discover */
@@ -2784,6 +2837,8 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 			len += resp_caching_pg(ap + len, pcontrol, target);
 		}
 		len += resp_ctrl_m_pg(ap + len, pcontrol, target);
+		if (0xff == subpcode)
+			len += resp_grouping_m_pg(ap + len, pcontrol, target);
 		len += resp_sas_sf_m_pg(ap + len, pcontrol, target);
 		if (0xff == subpcode) {
 			len += resp_sas_pcd_m_spg(ap + len, pcontrol, target,

