Return-Path: <linux-fsdevel+bounces-6153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5D813BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69BD281DFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942F6EB6C;
	Thu, 14 Dec 2023 20:42:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7531110;
	Thu, 14 Dec 2023 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d08a924fcfso81331325ad.2;
        Thu, 14 Dec 2023 12:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586555; x=1703191355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXdPrhmXkodv3U1sgUWXZcsbwZmhqv5TuxWwL9ersgU=;
        b=IB/K7SS9SezkyCKRI5eVPxNt2MXxYmTFf8DUhXadwpwVj3mHhO93Re7Cx8tFJI628O
         FjbXLY9VX6sxRVz8Y7+ViRrZltGMpnE/vJ4zxikYfXQzVg4NwhrWpzV/bRRgRgBL9RMM
         ZZHBC8A0C9LUZ0CY4+gPo7t+w9fpq9jOkYhKEN0zYi6xW30G5IxCR4FDaJ/IgXj4Qt32
         GLoI2Lvk/Qra76eDh+vaGbVfHk7N/VIFYCngv4BkSqRPBoWJ5eDcLy375NEpipywkWih
         QdUfy2Su1KSfgDUfBXSS1hexchLQQKrahmFoS4nPLjM3CAjJBH502CIQKeR2JBMExZ6Z
         z/hw==
X-Gm-Message-State: AOJu0YyEHWLOKRiM9H+QjJDUfnhDYxBr/7WE//fBoP7WPUaijbySc5Co
	Vbi4ioVgL1kbY0Z1DgO+IJU=
X-Google-Smtp-Source: AGHT+IGEuezugSYFJnHc8NgGeLzN8VGdbChndZK3jE7tcDnjh87nFBhwOE+AvFnWO24889HRjzfu8g==
X-Received: by 2002:a17:903:187:b0:1cc:449b:689e with SMTP id z7-20020a170903018700b001cc449b689emr12960538plg.20.1702586555081;
        Thu, 14 Dec 2023 12:42:35 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:34 -0800 (PST)
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
Subject: [PATCH v6 14/20] scsi: scsi_debug: Support the block limits extension VPD page
Date: Thu, 14 Dec 2023 12:40:47 -0800
Message-ID: <20231214204119.3670625-15-bvanassche@acm.org>
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

From SBC-5 r05:

"Reduced stream control:
a) reduces the maximum number of streams that the device server supports;
   and
b) increases the number of write commands that are able to specify a stream
   to be written in any write command that contains the GROUP NUMBER field
   in its CDB.

If the RSCS bit (see 6.6.5) is set to one, then the device server shall:
a) support per group stream identifier usage as described in 4.32.2;
b) support the IO Advice Hints Grouping mode page (see 6.5.7); and
c) set the MAXIMUM NUMBER OF STREAMS field (see 6.6.5) to a value that is
   less than 64.

Device servers that set the RSCS bit to one may support other features
(e.g., permanent streams (see 4.32.4)).

4.32.4 Permanent streams

A permanent stream is a stream for which the device server does not allow
closing or otherwise modifying the configuration of that stream. The PERM
bit (see 5.9.2.3) indicates whether a stream is a permanent stream. If a
STREAM CONTROL command (see 5.32) specifies the closing of a permanent
stream, the device server terminates that command with CHECK CONDITION
status instead of closing the specified stream. A permanent stream is always
an open stream. Device severs should assign the lowest numbered stream
identifiers to permanent streams."

Report that reduced stream control is supported.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5cf337ba9c19..39f8ae4dce82 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1873,6 +1873,19 @@ static int inquiry_vpd_b6(struct sdebug_dev_info *devip, unsigned char *arr)
 	return 0x3c;
 }
 
+#define SDEBUG_BLE_LEN_AFTER_B4 28	/* thus vpage 32 bytes long */
+
+enum { MAXIMUM_NUMBER_OF_STREAMS = 6, PERMANENT_STREAM_COUNT = 5 };
+
+/* Block limits extension VPD page (SBC-4) */
+static int inquiry_vpd_b7(unsigned char *arrb4)
+{
+	memset(arrb4, 0, SDEBUG_BLE_LEN_AFTER_B4);
+	arrb4[1] = 1; /* Reduced stream control support (RSCS) */
+	put_unaligned_be16(MAXIMUM_NUMBER_OF_STREAMS, &arrb4[2]);
+	return SDEBUG_BLE_LEN_AFTER_B4;
+}
+
 #define SDEBUG_LONG_INQ_SZ 96
 #define SDEBUG_MAX_INQ_ARR_SZ 584
 
@@ -1938,6 +1951,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 					arr[n++] = 0xb2;  /* LB Provisioning */
 				if (is_zbc)
 					arr[n++] = 0xb6;  /* ZB dev. char. */
+				arr[n++] = 0xb7;  /* Block limits extension */
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
@@ -1980,6 +1994,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
+		} else if (cmd[2] == 0xb7) { /* block limits extension page */
+			arr[3] = inquiry_vpd_b7(&arr[4]);
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);
 			kfree(arr);

