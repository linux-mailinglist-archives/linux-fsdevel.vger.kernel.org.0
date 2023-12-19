Return-Path: <linux-fsdevel+bounces-6452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAC6817E96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47691C22FF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F3EBA25;
	Tue, 19 Dec 2023 00:09:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BFF62B;
	Tue, 19 Dec 2023 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd8e2988ddso1038249a12.3;
        Mon, 18 Dec 2023 16:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944540; x=1703549340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axWCMvTp0bALUCa2nEe+Ebru41CBfQSiQtkM+jVQ7iM=;
        b=HcsncsfmQUME/UAaSJeWx488j7AGBRcUWS7GqmNq9KtdTbG9pXcTWgEfQYXk5N09dQ
         4aPc3OOZi4hvetYRKeP4GAPAyIWquPRzc8R6e5DH01oB2dReqoftcX62P/x9oa4YlyyW
         IExbnY3tX8EHSK9cVxBHyl+Ta6vfUe9YPkwkMCjw4yajOCeWpVv5XagcFAmJFxOfzy3W
         ptJydA6JkEX1b8kqV572VzDE6fiaqfJTjtVHmsr6/2eGCDcych2qBrdn0sFztV6UFGtW
         ZToOoZ446+YwbPsU/IO2JA0LJfbG8atQoQskfSc6fGyYVG+JC65uTlYkJVHNxxuZE6+o
         G6fA==
X-Gm-Message-State: AOJu0YyHIqgbYw+eE8Z1Z++/oRBsRQDPViKzM4ep3HlvzoEb6s2eINdU
	Sbhm3LEXPTJ57Pi/+WuP/Dg=
X-Google-Smtp-Source: AGHT+IHwQPwtNkLFd3UvHd0vOVzwJ/fDNyMMhQe5IvLEUzqt9RLXWaOOlZBaUCTr4BM9DljyUn6/FQ==
X-Received: by 2002:a05:6a20:734f:b0:18b:5a8a:4333 with SMTP id v15-20020a056a20734f00b0018b5a8a4333mr7502801pzc.19.1702944540425;
        Mon, 18 Dec 2023 16:09:00 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:09:00 -0800 (PST)
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
Subject: [PATCH v8 15/19] scsi: scsi_debug: Rework subpage code error handling
Date: Mon, 18 Dec 2023 16:07:48 -0800
Message-ID: <20231219000815.2739120-16-bvanassche@acm.org>
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

Move the subpage code checks into the switch statement to make it easier
to add support for new page code / subpage code combinations.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 70 ++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index b646c5320c63..cadd130d6b53 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2709,22 +2709,22 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2733,6 +2733,8 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0x8:	/* Caching page, direct access */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		if (is_disk || is_zbc) {
 			len = resp_caching_pg(ap, pcontrol, target);
 			offset += len;
@@ -2741,14 +2743,14 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2760,35 +2762,31 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2802,6 +2800,10 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 bad_pcode:
 	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
 	return check_condition_result;
+
+bad_subpcode:
+	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
+	return check_condition_result;
 }
 
 #define SDEBUG_MAX_MSELECT_SZ 512

