Return-Path: <linux-fsdevel+bounces-9582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C0842F13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B82B1C20D11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DC7C573;
	Tue, 30 Jan 2024 21:50:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7D14AAA;
	Tue, 30 Jan 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651401; cv=none; b=gadObSyUDr+GVLz++ZrnCUXIGxg8KxwgSghC1yYKu5bEOFlnBE3ZAwBp1Qkq+UqFGJ3BwF/mHOwlI1o4kbLzD2Fsd3JuYVEPrbcIPWnU3x0OUthEpqENLaHPbTsAS53FxL4bsttMgFwFScpkOeb/zCNon+X1zZH5FPjkWMreXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651401; c=relaxed/simple;
	bh=mW+VEHSEMe5NTiO4ammMUexCtbQO4umn8rI2uNjOxkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjvwdSwCxbhh9T3i0T4fIjszxyf+7NZeDWU1osgdZ4jg8r35cSD/tm8DM/xMZItIG5eoDguM/L+DOZWJ+6b7eH8eSaHlNXQs0Qz38JjW2Z1e7MPHIq+hUzl2/zN0fBpWAUouMTrU9vqLJZzIbCKqhEd6Ps7fOFhkP+4n7FvHp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8dc0172d7so15496155ad.1;
        Tue, 30 Jan 2024 13:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651400; x=1707256200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbVZNnyK3WhWIR+xZPdP47ThSfpJCvGfnUGz/BJTKu4=;
        b=XlVtQBts38KBN4aSigy7Knhk/7dLaPTlYJN08zjD3QJ74R5T03Q9qB/Ls/idA7LsCE
         GrzdRhz0LqxwOVkUX3Fe4jNdAd5td0XsmHZ20rogFEz1UXQflKwWeT6usS0rxyZgJkzf
         WCJfTAUQpZx0AgmGXlsfyl7Sqj61QqGUUMikQiaV6LfLuiz60JQG51POdnPsvE8xPLED
         DVaGhqe/yrddXCUnSU8C8SafBmF8xRVVR/5d9D+k8Mrjxjv1tk9b21DbUHyFCn//9S0I
         bcF7FOby4SJOaIU2wJKcMAPGbB/EJthjFsiMZTIua++TIfeQ4WX0jEhq7OwLfGURc8rT
         DJqg==
X-Gm-Message-State: AOJu0YxZeZBzz1rbk5O5DXyuEhvW3V5fKljHcbFPuti6RlV7Q5tR7K1T
	Y1vnxJOcMUyWZBMcnOthuRS/amGUd0IW1o7zmnatvF5RroEQCixk
X-Google-Smtp-Source: AGHT+IHubE1/OVe/pLhXpRSZRv/6OrGodScS2z6BPKDtpV1eczZhuwHlIkzTezizEzYtXRFljsAgmw==
X-Received: by 2002:a17:902:6506:b0:1d8:ce7d:623b with SMTP id b6-20020a170902650600b001d8ce7d623bmr5472066plk.23.1706651399682;
        Tue, 30 Jan 2024 13:49:59 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:59 -0800 (PST)
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
Subject: [PATCH v9 15/19] scsi: scsi_debug: Rework subpage code error handling
Date: Tue, 30 Jan 2024 13:48:41 -0800
Message-ID: <20240130214911.1863909-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
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
index ba0a29e6a86d..67a8e6243e5e 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2703,22 +2703,22 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2727,6 +2727,8 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		}
 		break;
 	case 0x8:	/* Caching page, direct access */
+		if (subpcode > 0x0 && subpcode < 0xff)
+			goto bad_subpcode;
 		if (is_disk || is_zbc) {
 			len = resp_caching_pg(ap, pcontrol, target);
 			offset += len;
@@ -2735,14 +2737,14 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2754,35 +2756,31 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
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
@@ -2796,6 +2794,10 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 bad_pcode:
 	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 5);
 	return check_condition_result;
+
+bad_subpcode:
+	mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
+	return check_condition_result;
 }
 
 #define SDEBUG_MAX_MSELECT_SZ 512

