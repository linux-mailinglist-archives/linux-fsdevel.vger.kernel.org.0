Return-Path: <linux-fsdevel+bounces-6450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4A817E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD531C209B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2818838;
	Tue, 19 Dec 2023 00:09:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698088475;
	Tue, 19 Dec 2023 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d532e4f6d6so1018385b3a.2;
        Mon, 18 Dec 2023 16:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944538; x=1703549338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXdPrhmXkodv3U1sgUWXZcsbwZmhqv5TuxWwL9ersgU=;
        b=QtBY/UsHspCTclfMm1qfwt3Rp1J6zmyloK/JTaqw6f0bua1YdND9yPLsgjule9E8rD
         fEXiOTJ1y98m8iAdzfziPrZGUMMQL49qBokBKUIPIxVMQBETXjlef+YwURJYNZXyR7fS
         HfIolFmJa0hi3NlKSfQncdlHeLSCN0AO5rJzJzFjv3YQKM+IpXX5pBKYsin6T7cpQhD1
         exceRoK6KWJBFHc9CQXb7nkOw+rPvHRgxjIPqYj334TJKoayLvuDv64OM1S3evJRKXwk
         cNs47BMQSNei/x92TIiKmL2mPKMgIiVGUTt22kd0HmNsQDw1jvw69lWWcNY5exE1FaD1
         95Jw==
X-Gm-Message-State: AOJu0YxjULEH8LXUG/Mc01DOpjKiY9lOr957G1V+ET2CrqI9Qfw1Jezd
	MeKXviWfCeEpioSUdMQiKtI=
X-Google-Smtp-Source: AGHT+IGxP+1mRu0Tp1bTkYGgUIqQk6whrUIGxZwfiiH5SkJ9HyaajyY5N38Rxg+qXCryba5E/UUF+g==
X-Received: by 2002:a05:6a20:429f:b0:18f:97c:4f4c with SMTP id o31-20020a056a20429f00b0018f097c4f4cmr9743661pzj.88.1702944537691;
        Mon, 18 Dec 2023 16:08:57 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:57 -0800 (PST)
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
Subject: [PATCH v8 13/19] scsi: scsi_debug: Support the block limits extension VPD page
Date: Mon, 18 Dec 2023 16:07:46 -0800
Message-ID: <20231219000815.2739120-14-bvanassche@acm.org>
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

