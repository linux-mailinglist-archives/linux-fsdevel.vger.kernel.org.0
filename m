Return-Path: <linux-fsdevel+bounces-6157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66130813BE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA01F225F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51E6FCF2;
	Thu, 14 Dec 2023 20:42:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FB2112;
	Thu, 14 Dec 2023 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b0a265f92so938306a91.3;
        Thu, 14 Dec 2023 12:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586561; x=1703191361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NF3r6kBvweQQzNsLxPq1BZprgUkPpuRDDhas88uNzHQ=;
        b=h1AeVzMLOXEDooJK7ibIIvIMC1e2BrQVzny0EjkCY7DrwWXmlFlMetBVM0YHaDDex4
         GgBvYZypPwV/hQBPJWTa5hvyK5vyDFPtxbgHbHVEaGQHmNBBy8oLB/JEQr7oKk1OQg8A
         oN03kQOIM3iRNQJ1Fp46ZG6pzcKdosFZtVc7dSC+XAM6z3++V3U4cqRkdPvjUy9TFcqG
         HFQSkc1a9134RkvupILdna+WDHa7r7loFf02GOYcwbMAuBLNLbs0H1y1CGp6tkkdw8P9
         WpCgDiKax0nIo+M8rIfPRTAoNW3tXgI64vSqySV51070m5WyDi2b2effkj3CZQZZMXbc
         OItQ==
X-Gm-Message-State: AOJu0YxsTqM8EezRLO6b8Ca2BPOrnJzE1KPTo9UH6JwPhZ8br7yemX/v
	C11UCXNOBau5/Pn6wbKLj9DVWgVSW7M=
X-Google-Smtp-Source: AGHT+IFNrFWf+sKjYAspwT5ZfD32mRxSbYT81QnnyIqCzhDyxzhMuIfhaz3QivPgQrm8EEr0UqUfpw==
X-Received: by 2002:a17:90b:f10:b0:28a:c5e5:98da with SMTP id br16-20020a17090b0f1000b0028ac5e598damr4212210pjb.54.1702586561164;
        Thu, 14 Dec 2023 12:42:41 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:40 -0800 (PST)
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
Subject: [PATCH v6 18/20] scsi: scsi_debug: Implement the IO Advice Hints Grouping mode page
Date: Thu, 14 Dec 2023 12:40:51 -0800
Message-ID: <20231214204119.3670625-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214204119.3670625-1-bvanassche@acm.org>
References: <20231214204119.3670625-1-bvanassche@acm.org>
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

