Return-Path: <linux-fsdevel+bounces-4306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB67FE70C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8146B1F20CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6E134C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0310D1;
	Wed, 29 Nov 2023 17:33:47 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5b9a456798eso371123a12.3;
        Wed, 29 Nov 2023 17:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308027; x=1701912827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUbgB9ONZ2+H10NqZegXF7okKt0TpfEQcrO7VYgHrxM=;
        b=djBlfY/JtKFilmlMNv2cYEaKaoqbvFgi3UtU/ngmiDwoCfL2lbad86+uRBkwLNWlwX
         2FiH4RLlI1riFgpW8ywzaO3zqfTJfoj5CFiRD9ZQhP6pc4Zm64x6OswsdOnlCv2nVpAv
         vXzmwMjvvPZ7JIdBQA7PPSf/WGeNfatVhGZmmUAb2xnuLX38rFCy7Z5KiVrfui+bLRzt
         jtBxHiSUyHuq0vQ8xLyKdwDE79Z/4OYpON7XPNgS035i+YoF92lZ7muTzYdVD2Gz4LR7
         ePCmOsRdj7nfNW8BR7CmH5TlfNB2LgrJYFO3gZYjlydZ0PH3e23dWQXs6Z2ZqSKVSkcp
         JM8g==
X-Gm-Message-State: AOJu0YyBBhnNI9/4hFegyjhVto+A2ZCXZguemJJ+N+FmeFCXHwKgFG4y
	qdCcTWHqjCoiMo1vw+0IqB8=
X-Google-Smtp-Source: AGHT+IHaUeHfQDZsMdd46aW8K2o1OXXaLAc/sUL4vwbfkClb7N7rsH0093gIL31+b0eGD1r3c5Z83Q==
X-Received: by 2002:a17:90b:3009:b0:27f:fcdb:89c1 with SMTP id hg9-20020a17090b300900b0027ffcdb89c1mr18170917pjb.41.1701308027107;
        Wed, 29 Nov 2023 17:33:47 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:46 -0800 (PST)
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
Subject: [PATCH v5 12/17] scsi_debug: Support the block limits extension VPD page
Date: Wed, 29 Nov 2023 17:33:17 -0800
Message-ID: <20231130013322.175290-13-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index f6261ad76c09..b9a39829a012 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1931,6 +1931,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 					arr[n++] = 0xb2;  /* LB Provisioning */
 				if (is_zbc)
 					arr[n++] = 0xb6;  /* ZB dev. char. */
+				arr[n++] = 0xb7;  /* Block limits extension */
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
@@ -1973,6 +1974,9 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
+		} else if (cmd[2] == 0xb7) { /* block limits extension page */
+			arr[3] = 2; /* page length */
+			arr[5] = 1; /* Reduced stream control support (RSCS) */
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);
 			kfree(arr);

